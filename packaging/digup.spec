%global upstream_version 0.7.0-beta.3

# Os binarios ja vem compilados (a partir do codigo-fonte traduzido deste fork).
# O pipeline padrao do Fedora (find-debuginfo + brp-strip) alteraria os ELFs;
# desativa-lo aqui e' seguro: nao ha nada para compilar ou corrigir neste pacote.
%global _enable_debug_packages 0
%global __spec_install_post %{nil}

# O .deb oficial era linkado contra o libcurl do Debian (no de versao
# CURL_OPENSSL_4). O build local usa o libcurl do Fedora, sem versoes de simbolo.
# O filtro abaixo cobre os dois casos: remove um eventual Requires versionado e
# deixa apenas o SONAME simples.
%global __requires_exclude ^libcurl.so.4.*CURL_OPENSSL_4.*$

Name:           dig-up
Version:        0.7.0~beta.3
Release:        1%{?dist}
Summary:        Busque os arquivos do seu computador pelo que há dentro deles

# O binario e' pre-compilado; os avisos de licencas de terceiros estao embutidos
# no pacote (veja THIRD-PARTY-NOTICES.txt no %%files).
License:        MIT AND Apache-2.0 AND BSD-3-Clause AND ISC AND MPL-2.0 AND Zlib AND Unicode-3.0 AND CC0-1.0 AND Unlicense AND 0BSD
URL:            https://digup.arahim.dev
Source0:        digup-%{upstream_version}.tar.gz

# O release oficial so' publica binarios x86_64 (amd64).
ExclusiveArch:  x86_64

# O indayador do sistema e' carregado via dlopen (nao aparece em DT_NEEDED),
# por isso nao e' detectado automaticamente pelo gerador de dependencias.
Requires:       libayatana-appindicator-gtk3
Requires:       hicolor-icon-theme
# backend ggml-vulkan; opcional, o backend CPU funciona sem ele
Recommends:     vulkan-loader

%description
O DigUp busca arquivos no seu computador pelo que há dentro deles: fotos, PDFs,
documentos, gravações, vídeos e código. Tudo acontece no próprio aparelho, com
os embeddings do EmbeddingGemma 2 do Google DeepMind.

Este RPM foi compilado a partir do código-fonte traduzido para português
brasileiro neste fork (branch rpm-packaging), e não dos binários oficiais em
inglês. A interface, os menus e a ferramenta de linha de comando estão em PT-BR.


%prep
%setup -q -n digup-%{upstream_version}

%build
# Nada a compilar: o upstream publica binarios pre-compilados (Tauri/Swift).

%install
# O launcher resolve o helper como /usr/bin/../lib/DigUp/helper, entao o
# caminho /usr/lib/DigUp (e NAO /usr/lib64/DigUp) deve ser preservado.
mkdir -p %{buildroot}
cp -a usr %{buildroot}/

%check
test -x %{buildroot}%{_bindir}/digup-shell
test -x %{buildroot}/usr/lib/DigUp/helper/digup

%post
if [ -x /usr/bin/update-desktop-database ]; then
    /usr/bin/update-desktop-database -q %{_datadir}/applications >/dev/null 2>&1 || :
fi
if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache -q -t -f %{_datadir}/icons/hicolor >/dev/null 2>&1 || :
fi

%postun
if [ "$1" -eq 0 ]; then
    if [ -x /usr/bin/update-desktop-database ]; then
        /usr/bin/update-desktop-database -q %{_datadir}/applications >/dev/null 2>&1 || :
    fi
    if [ -x /usr/bin/gtk-update-icon-cache ]; then
        /usr/bin/gtk-update-icon-cache -q -t -f %{_datadir}/icons/hicolor >/dev/null 2>&1 || :
    fi
fi

%files
%license /usr/lib/DigUp/THIRD-PARTY-NOTICES.txt
%license %{_datadir}/doc/dig-up/copyright
%{_bindir}/digup-shell
%dir /usr/lib/DigUp
%dir /usr/lib/DigUp/helper
/usr/lib/DigUp/helper/digup
/usr/lib/DigUp/helper/ffmpeg
/usr/lib/DigUp/helper/ffprobe
/usr/lib/DigUp/helper/lib*.so*
%{_datadir}/applications/DigUp.desktop
%{_datadir}/icons/hicolor/32x32/apps/digup-shell.png
%{_datadir}/icons/hicolor/128x128/apps/digup-shell.png
%{_datadir}/icons/hicolor/256x256@2/apps/digup-shell.png

%changelog
* Tue Nov 24 2026 mpjsilva <mpjsilva@users.noreply.github.com> - 0.7.0~beta.3-1
- Reempacotamento do .deb oficial do release v0.7.0-beta.3 para RPM.
- Rebuild do código-fonte traduzido: interface e descrições em PT-BR.
