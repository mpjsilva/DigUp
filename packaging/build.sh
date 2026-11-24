#!/usr/bin/env bash
# Constroi o pacote RPM do DigUp a partir de um .deb.
# Uso: ./packaging/build.sh                       (baixa o .deb oficial e valida o SHA256)
#      DEB_FILE=/caminho/para.deb ./packaging/build.sh   (usa um .deb local, ex.: build traduzido)
set -euo pipefail

UPSTREAM_VERSION="0.7.0-beta.3"
DEB_NAME="DigUp_${UPSTREAM_VERSION}_amd64.deb"
DEB_URL="https://github.com/ARahim3/DigUp/releases/download/v${UPSTREAM_VERSION}/${DEB_NAME}"
DEB_SHA256="81396e63fd92601dffe4b65c6b9a2e496bcfda2d188eb24220a2431b68e03bd8"

FORK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RPM_TOPDIR="${FORK_DIR}/rpmbuild"
WORKDIR="${FORK_DIR}/.build-work"
DIST_DIR="${FORK_DIR}/dist"

for tool in curl sha256sum dpkg-deb rpmbuild; do
    command -v "$tool" >/dev/null 2>&1 || { echo "ERRO: '$tool' nao encontrado" >&2; exit 1; }
done

echo "==> Preparando diretorios de build"
mkdir -p "${RPM_TOPDIR}"/{BUILD,BUILDROOT,RPMS,SPECS,SRPMS,SOURCES} "${DIST_DIR}" "${WORKDIR}"
rm -rf "${WORKDIR}/pkg"

if [ -n "${DEB_FILE:-}" ]; then
    # Build local (ex.: .deb recompilado com a interface traduzida).
    DEB_FILE="$(readlink -f "$DEB_FILE")"
    [ -f "$DEB_FILE" ] || { echo "ERRO: DEB_FILE nao encontrado: $DEB_FILE" >&2; exit 1; }
    echo "==> Usando .deb local: ${DEB_FILE}"
else
    echo "==> Baixando ${DEB_NAME} (se necessario)"
    DEB_FILE="${WORKDIR}/${DEB_NAME}"
    if [ ! -f "${DEB_FILE}" ]; then
        curl -fL --retry 3 -o "${DEB_FILE}" "${DEB_URL}"
    fi

    echo "==> Verificando SHA256"
    echo "${DEB_SHA256}  ${DEB_FILE}" | sha256sum --check --strict
fi

echo "==> Extraindo o .deb"
mkdir -p "${WORKDIR}/pkg/DEBIAN" "${WORKDIR}/pkg/root"
dpkg-deb -e "${DEB_FILE}" "${WORKDIR}/pkg/DEBIAN"
dpkg-deb -x "${DEB_FILE}" "${WORKDIR}/pkg/root"

echo "==> Criando o tarball de fontes"
STAGE="${WORKDIR}/stage"
rm -rf "${STAGE}"
mkdir -p "${STAGE}/digup-${UPSTREAM_VERSION}"
cp -a "${WORKDIR}/pkg/root/usr" "${STAGE}/digup-${UPSTREAM_VERSION}/"
TARBALL="${RPM_TOPDIR}/SOURCES/digup-${UPSTREAM_VERSION}.tar.gz"
tar -czf "${TARBALL}" -C "${STAGE}" "digup-${UPSTREAM_VERSION}"

echo "==> Copiando o spec"
cp -f "${FORK_DIR}/packaging/digup.spec" "${RPM_TOPDIR}/SPECS/digup.spec"

echo "==> Rodando rpmbuild"
rpmbuild -ba \
    --define "_topdir ${RPM_TOPDIR}" \
    "${RPM_TOPDIR}/SPECS/digup.spec"

echo "==> Copiando artefatos para dist/"
cp -f "${RPM_TOPDIR}"/RPMS/*/dig-up-*.rpm "${DIST_DIR}/"
cp -f "${RPM_TOPDIR}"/SRPMS/dig-up-*.rpm "${DIST_DIR}/"

echo
echo "PRONTO. Artefatos em ${DIST_DIR}:"
ls -lh "${DIST_DIR}"
