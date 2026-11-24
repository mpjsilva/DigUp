# DigUp RPM

Este diretório contém o empacotamento RPM do [DigUp](https://github.com/ARahim3/DigUp),
mantido no fork <https://github.com/mpjsilva/DigUp>.

O release oficial `v0.7.0-beta.3` publica apenas `.deb`, AppImage e instalador
Windows. Este fork gera RPM de duas formas:

1. **Padrão (paridade com o upstream):** reempacota o `.deb` oficial, com SHA256
   verificado e binários idênticos aos do autor.
2. **100% PT-BR (recomendado aqui):** recompila o app a partir do código-fonte
   traduzido e converte o `.deb` resultante em RPM. É o que está publicado no
   release do fork.

## Como gerar o RPM 100% PT-BR a partir do fonte

Em Fedora, instale as ferramentas (`sudo dnf install nodejs npm patchelf ninja-build
pkgconf-pkg-config nasm meson gcc-c++ make zlib-devel gtk3-devel webkit2gtk4.1-devel
libsoup3-devel libayatana-appindicator-gtk3-devel libcurl-devel lld gstreamer1-plugins-base
gstreamer1-plugins-good`) e o Swift 6.4 via `swiftly install 6.4.3`.

> No Fedora 45 com Swift 6.4.3 do Ubuntu é preciso um workaround temporário: o
> toolchain espera JSON de `ld -version_details`. Veja o histórico do branch
> `rpm-packaging` para o wrapper usado; o build é feito com `/usr/sbin/ld`
> temporariamente substituído e restaurado ao final.

```bash
. "$HOME/.local/share/swiftly/env.sh"
scripts/fetch-vendor.sh
scripts/build-llama.sh
scripts/build-ffmpeg.sh
BUNDLES=deb scripts/package-linux.sh          # gera o .deb traduzido
DEB_FILE="$PWD/shell/src-tauri/target/release/bundle/deb/DigUp_0.7.0-beta.3_amd64.deb" \
  ./packaging/build.sh                        # converte para RPM
```

`BUNDLES=deb` evita o AppImage (o script foi ajustado para aceitar isso e para
encontrar os plugins GStreamer em `/usr/lib64`, o caminho do Fedora).

## Como gerar o RPM a partir do .deb oficial

Em Fedora/RHEL/openSUSE com `rpm-build`, `dpkg` (para `dpkg-deb`), `curl` e `tar`:

```bash
git clone https://github.com/mpjsilva/DigUp.git
cd DigUp
git checkout rpm-packaging   # o empacotamento esta' nesta branch
chmod +x packaging/build.sh
./packaging/build.sh
```

O script:

1. baixa `DigUp_0.7.0-beta.3_amd64.deb` do release e valida o SHA256 (ou usa um
   `.deb` local passo a passo em `DEB_FILE=...`, sem checagem de SHA);
2. extrai o payload com `dpkg-deb`;
3. gera um tarball de fontes autocontido (para o SRPM);
4. roda `rpmbuild -ba` com o spec em `packaging/digup.spec`;
5. deixa os artefatos em `dist/`:
   - `dig-up-0.7.0~beta.3-1.fcXX.x86_64.rpm`
   - `dig-up-0.7.0~beta.3-1.fcXX.src.rpm`

## Instalação

```bash
sudo dnf install ./dist/dig-up-0.7.0~beta.3-1.fc*.x86_64.rpm
```

O executável e o arquivo `.desktop` são instalados como `dig-up` /
`DigUp.desktop`; o comando para abrir é `digup-shell`.

## Notas técnicas

- O launcher `digup-shell` localiza o helper em `/usr/bin/../lib/DigUp/helper`,
  então o pacote instala em `/usr/lib/DigUp` (e **não** em `/usr/lib64/DigUp`).
  Isso é intencional e preserva o comportamento do `.deb`.
- `libayatana-appindicator-gtk3` é declarado explicitamente porque a biblioteca
  da bandeja é carregada via `dlopen` e, portanto, não aparece em `DT_NEEDED`.
- As demais dependências (GTK 3, WebKitGTK 4.1, libsoup 3, curl, Vulkan) são
  geradas automaticamente pelo `rpmbuild` a partir dos ELFs do pacote.
- **Atualizações:** o binário foi compilado pelo autor como `.deb` e traz o
  updater do Tauri apontando para os assets do GitHub. Em uma instalação RPM,
  prefira atualizar baixando o novo RPM deste fork; o updater embutido pode não
  conseguir aplicar um `.deb` no seu sistema.

## Licença

O código do DigUp é MIT. Os binários incluem componentes de terceiros
(Apache-2.0, BSD-3-Clause, ISC, MPL-2.0, Zlib, Unicode-3.0, CC0-1.0 e outros);
a lista completa está em `/usr/lib/DigUp/THIRD-PARTY-NOTICES.txt` dentro do
pacote.
