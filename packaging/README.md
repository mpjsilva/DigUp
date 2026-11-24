# DigUp RPM

Este diretório contém o empacotamento RPM do [DigUp](https://github.com/ARahim3/DigUp),
mantido no fork <https://github.com/mpjsilva/DigUp>.

O release oficial `v0.7.0-beta.3` publica apenas `.deb`, AppImage e instalador
Windows. Aqui o `.deb` oficial é **reempacotado** como RPM sem alterar nenhum
binário — o SHA256 do download é verificado antes do build e os arquivos
instalados são exatamente os mesmos do upstream.

## Por que converter o .deb em vez de compilar do fonte?

O DigUp é um app Tauri + Swift com dependências vendored (llama.cpp, PDFium,
FFmpeg) e downloads com checksums fixados. Recompilar exigiria toda a toolchain
Swift/Rust e não acrescentaria nada ao resultado: converter o `.deb` garante
paridade byte a byte com o que o autor publicou.

## Como gerar o RPM

Em Fedora/RHEL/openSUSE com `rpm-build`, `dpkg` (para `dpkg-deb`), `curl` e `tar`:

```bash
git clone https://github.com/mpjsilva/DigUp.git
cd DigUp
chmod +x packaging/build.sh
./packaging/build.sh
```

O script:

1. baixa `DigUp_0.7.0-beta.3_amd64.deb` do release e valida o SHA256;
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
