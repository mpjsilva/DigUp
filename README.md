<p align="center"><a href="README.en.md">English</a> · <b>Português (Brasil)</b></p>

<p align="center"><img src="docs/logo.png" width="96" alt=""></p>

<h1 align="center">DigUp</h1>

<p align="center"><b>Descreva. Encontre.</b><br>
Busque os arquivos do seu computador pelo que há dentro deles, com o
<a href="https://huggingface.co/google/embeddinggemma-2">EmbeddingGemma 2</a> do Google DeepMind.</p>

<p align="center"><a href="https://github.com/ARahim3/DigUp/releases/latest"><b>Baixar para Mac</b></a> ·
<a href="https://github.com/ARahim3/DigUp/releases/tag/v0.7.0-beta.2"><b>Windows (beta)</b></a> ·
<a href="https://github.com/mpjsilva/DigUp/releases/tag/rpm-v0.7.0-beta.3"><b>Linux — RPM (neste fork)</b></a><br>
<sub>Gratuito e de código aberto. Tudo roda no seu computador.</sub></p>

<p align="center">
<a href="https://github.com/ARahim3/DigUp/stargazers"><img src="https://img.shields.io/github/stars/ARahim3/DigUp?style=flat-square" alt="Estrelas no GitHub"></a>
<a href="https://github.com/ARahim3/DigUp/releases"><img src="https://img.shields.io/github/downloads/ARahim3/DigUp/total?style=flat-square" alt="Downloads"></a>
<a href="https://github.com/ARahim3/DigUp/releases/latest"><img src="https://img.shields.io/github/v/release/ARahim3/DigUp?style=flat-square" alt="Último lançamento"></a>
<a href="LICENSE"><img src="https://img.shields.io/github/license/ARahim3/DigUp?style=flat-square" alt="Licença MIT"></a><br>
<a href="https://trendshift.io/repositories/295333?utm_source=trendshift-badge&amp;utm_medium=badge&amp;utm_campaign=badge-trendshift-295333" target="_blank" rel="noopener noreferrer"><img src="https://trendshift.io/api/badge/trendshift/repositories/295333/daily?language=Swift" alt="ARahim3/DigUp no Trendshift: repositório do dia para Swift" width="250" height="55"></a>
</p>

<p align="center"><img src="docs/demo.gif" width="800" alt="O painel de busca do DigUp no Mac, no Windows e no Linux: uma zebra em um vídeo, um minuto de podcast, uma cláusula de um contrato de aluguel, um cachorro na praia em inglês, bengali e árabe, e um código que abre no Zed."></p>

O EmbeddingGemma 2 é o modelo multimodal de embedding lançado pelo Google DeepMind em outubro de 2026. Ele coloca texto,
imagens, áudio e vídeo em um mesmo espaço compartilhado: uma foto de um cachorro na praia fica perto das palavras
"um cachorro na praia", e uma gravação de alguém falando sobre sono fica perto de "onde eles falam sobre dormir". Ele
entende mais de 100 idiomas, é aberto (Apache 2.0) e, com 740 milhões de parâmetros, é pequeno o bastante para rodar
em um notebook.

O DigUp leva isso aos arquivos do seu computador, no Mac, no Windows ou no Linux. Escolha as pastas que deseja buscar e
ele lê as imagens, PDFs, documentos, gravações e vídeos que estão nelas. Depois descreva o que procura com as suas
próprias palavras, e ele encontra o correspondente, seja qual for o tipo de arquivo.

## O que você pode encontrar

- "zebra em um vídeo" abre o clipe no momento em que a zebra aparece
- "onde eles falam sobre dormir" vai direto ao minuto do podcast
- "a cláusula sobre animais no contrato de aluguel" mostra a página do PDF
- "um cachorro na praia" encontra a foto, e "erro de pagamento recusado" a captura de tela
- uma busca em inglês pode encontrar uma nota escrita em bengali, árabe ou qualquer um dos mais de 100 idiomas do
  modelo, e o contrário também
- "code: tentar novamente uma chamada que falhou com backoff" encontra a função nos seus projetos, se você ativar a
  busca de código

Palavras exatas também contam. Números de nota fiscal, códigos de erro e nomes são comparados exatamente como foram
escritos, tanto em nomes de arquivos quanto no texto dos documentos: a busca considera tanto o significado quanto a
string exata. No Mac, isso inclui o texto dentro de capturas de tela.

## Privacidade

Nada do que você indexa sai do seu computador. O DigUp só acessa a internet para baixar o modelo uma vez e verificar
atualizações uma vez por dia. A verificação de atualizações não envia nada sobre seus arquivos, e você pode
desativá-la. Sem conta, sem telemetria.

## Instalação

**Mac.** Baixe o DMG em [Releases](https://github.com/ARahim3/DigUp/releases/latest) e arraste o DigUp para
Aplicativos, ou use o Homebrew: `brew install --cask arahim3/tap/digup`. Requer um Mac com Apple Silicon e macOS 14 ou
posterior.

**Windows.** Baixe `DigUp_x.y.z_x64-setup.exe` do
[lançamento beta](https://github.com/ARahim3/DigUp/releases/tag/v0.7.0-beta.2) e execute-o. A instalação é apenas para
o seu usuário, sem precisar de direitos de administrador. O Windows pode dizer que não reconhece o aplicativo, porque
o instalador ainda não é assinado: escolha Mais informações e depois Executar assim mesmo. Requer Windows 10 ou 11 de
64 bits.

**Linux (Debian, Ubuntu, Mint e similares).** Baixe o `.deb` e instale:

```sh
sudo apt install ./DigUp_x.y.z_amd64.deb
```

O pacote se chama `dig-up`, porque o Debian já tem outro pacote sem relação chamado `digup`. Em qualquer outra
distribuição, baixe o AppImage, torne-o executável e execute-o. Ambos são para processadores Intel e AMD de 64 bits e
funcionam no Ubuntu 22.04, Debian 12, Mint 21 e posteriores.

**Linux (RPM — Fedora, RHEL, openSUSE).** Este fork publica um RPM pronto:
[baixe o pacote](https://github.com/mpjsilva/DigUp/releases/tag/rpm-v0.7.0-beta.3) e instale com:

```sh
sudo dnf install ./dig-up-0.7.0.beta.3-1.fc45.x86_64.rpm
```

O RPM contém exatamente os mesmos binários do `.deb` oficial. O código do empacotamento está em
[`packaging/`](packaging/) e as instruções de build, em
[`packaging/README.md`](packaging/README.md).

### Interface em português

Neste fork, os textos da interface (Mac, Windows, Linux e ferramenta de linha de comando) foram traduzidos para o
português brasileiro. As regras terminológicas estão em [`docs/glossario-pt-BR.md`](docs/glossario-pt-BR.md).

O RPM publicado contém os binários oficiais do release, que ainda estão em inglês: a tradução passa a valer quando o
app é compilado a partir deste código-fonte. Não há compilador Swift/Node neste ambiente, então o pacote binário
continua idêntico ao `.deb` upstream.

Depois, em qualquer sistema:

1. Abra o DigUp. Enquanto o modelo é baixado (865 MB, uma única vez), escolha as pastas que deseja buscar: pastas
   inteiras ou apenas algumas subpastas. O DigUp mostra quanto tempo levará a primeira varredura em cada uma, medido no
   seu computador.
2. Pressione o atalho em qualquer aplicativo e descreva o que procura: **⇧⌘Espaço** no Mac, **Ctrl+Shift+Espaço** no
   Windows e no Linux.

O DigUp se mantém atualizado: no Mac, no instalador do Windows e no AppImage, as atualizações são aplicadas com um
clique. Com o `.deb`, o DigUp avisa quando há uma versão nova e abre a página do lançamento. Com o RPM deste fork,
baixe o novo pacote na página de lançamentos do fork.

## Como usar

| Mac | Windows e Linux | O que faz |
|---|---|---|
| ⇧⌘Espaço | Ctrl+Shift+Espaço | Abre o painel de busca de qualquer aplicativo (o atalho pode ser alterado) |
| ↓ ↑ | ↓ ↑ | Navega pelos resultados |
| ↩ | Enter | Abre o resultado: PDFs na página, gravações e vídeos no momento, código no editor, na linha |
| Espaço | Espaço | Uma prévia grande, na página ou no momento (depois de selecionar um resultado) |
| ⌘↩ | Ctrl+Enter | Mostra o arquivo no Finder, no Explorer ou no seu gerenciador de arquivos |
| ⌘C | Ctrl+C (na janela) | Copia o arquivo, para colar em qualquer lugar |
| ⌘O | Ctrl+O | A mesma busca em uma janela maior, com grade de imagens e filtros |

No Mac, o DigUp fica na barra de menus; no Windows e no Linux, na área de notificação (bandeja), onde você pode
acompanhar a indexação, pausá-la ou abrir as Configurações. Abri-lo pelo menu Iniciar ou pela lista de aplicativos
mostra a janela de busca.

Algumas coisas mudam conforme o sistema:

- No Mac, um vídeo abre no momento em que o trecho aparece no QuickTime Player (o macOS pergunta uma vez se o DigUp
  pode controlá-lo) ou no IINA, e um PDF abre no Visualizador com as suas palavras já no campo de busca. No Windows e
  no Linux, os PDFs abrem na página no seu leitor de PDF, se ele aceitar receber um número de página (Edge, Chrome,
  Firefox, Acrobat, SumatraPDF, Evince, Okular), e gravações e vídeos abrem no momento no VLC, mpv ou MPC-HC. Outros
  aplicativos abrem o arquivo do início; a prévia grande sempre reproduz a partir do momento.
- No GNOME e no KDE sob Wayland, que não deixam que os aplicativos definam seus próprios atalhos, o DigUp adiciona
  Ctrl+Shift+Espaço às configurações de teclado do ambiente durante a configuração inicial, e você altera lá. Em outros
  ambientes Wayland, as Configurações mostram o comando para criar um atalho próprio.
- No GNOME, o ícone da bandeja precisa da extensão AppIndicator, que o Ubuntu já inclui. Sem ela, o menu ⋯ da janela
  tem os mesmos itens.

## O que ele lê

Apenas as pastas que você escolher:

- imagens e capturas de tela (JPEG, PNG, HEIC, WebP e mais), pelo que mostram; no Mac, capturas de tela também pelo
  texto
- PDFs, página por página, inclusive digitalizações. Um PDF longo tem as primeiras 30 páginas indexadas de imediato e
  o restante depois que tudo o mais já estiver pronto (até 5.000 páginas por arquivo)
- documentos: txt, md, typ, rtf, docx, odt, html e, no Mac, doc; documentos longos da mesma forma. Textos formados
  basicamente por números, como uma exportação de dados, são encontrados apenas pelo texto exato
- planilhas e apresentações: xlsx, ods, pptx e odp, lidas pelo texto: nome e linhas de cada planilha, texto de cada
  slide e notas do palestrante
- áudio de qualquer duração: o modelo escuta 30 segundos por vez, então o DigUp usa janelas sobrepostas de 30 segundos
  e um resultado aponta para o momento correspondente
- vídeo de qualquer duração: um quadro a cada poucos segundos, um por plano, mais a trilha sonora da mesma forma que
  o áudio

Fora das pastas que você selecionou para a busca de código, o DigUp nunca lê código; dentro de um projeto de código
(uma pasta com `.git`, `package.json` e afins), ele lê apenas capturas de tela. Ele nunca lê chaves, certificados,
arquivos de senha, pastas ocultas como `.ssh`, aplicativos ou caches. Ignora pastas que parecem conjuntos de dados
(datasets) e nunca baixa arquivos que existem apenas na nuvem (iCloud no Mac, OneDrive no Windows). Você pode ignorar
mais pastas ou tipos de arquivo nas Configurações. O DigUp apenas lê seus arquivos: nunca os altera, move ou envia.

A primeira varredura acontece uma única vez. No Mac, leva alguns minutos para algumas centenas de arquivos e pode levar
uma hora para uma pasta Downloads grande. No Windows e no Linux, o DigUp roda o modelo na placa de vídeo quando isso é
mais rápido e no processador de outro modo; apenas no processador, uma imagem leva alguns segundos (cerca de cinco em
um Core i5 de notebook de 2017), então uma biblioteca de fotos grande pode levar horas — por isso a configuração
mostra o tempo antes de começar. Depois disso, um arquivo novo fica pesquisável alguns segundos depois de chegar.

## Código

O EmbeddingGemma 2 também lê código, então o DigUp pode buscar nos seus projetos. A busca de código vem desativada até
você ativá-la, em Configurações → Código ou durante a configuração inicial, para as pastas que escolher. Cada
repositório mostra quanto tempo leva para ser lido e quanto espaço seu índice ocupa. Depois comece uma busca com
`code:` e descreva o que o código faz, ou digite um nome que esteja nele:

- "code: tentar novamente uma chamada que falhou com backoff" encontra a função, seja qual for o nome dela
- "code: refreshAccessToken" vai até a linha que a define, não aos lugares que a chamam
- "code: plotar quantos exemplos cada classe tem" encontra a célula do notebook

Os resultados abrem no seu editor, na linha: Zed, VS Code, Cursor, Sublime Text, IDEs da JetBrains e alguns mais, Xcode
no Mac e Notepad++ no Windows (escolha um nas Configurações). O código tem um índice próprio e nunca aparece em outras
buscas. O DigUp lê arquivos-fonte, notebooks (sem as saídas) e a documentação do próprio repositório. Ele ignora o que
o git ignora, código vendorizado e gerado, arquivos de dados e qualquer coisa que pareça chave ou senha. Enquanto você
trabalha no código, o índice se atualiza um minuto depois que as coisas ficam paradas.

No Mac, ler o código de um aplicativo pequeno leva cerca de 20 segundos; todo o llama.cpp leva cerca de 20 minutos e
130 MB de índice.

## Como funciona

```
suas pastas ─► leitores que transformam arquivos em imagens, texto e som
            ─► EmbeddingGemma 2 sobre llama.cpp, em um processo auxiliar que sai quando termina
            ─► um arquivo SQLite: um vetor para cada imagem, página, trecho, quadro de vídeo e 30 s de áudio,
               mais um índice de palavras-chave (a busca de código mantém um segundo, só para código)
suas palavras ─► a parte de texto do mesmo modelo (~250 MB, apenas durante a busca) ─► vetores mais próximos + palavras exatas
```

O DigUp executa o build de 8 bits do EmbeddingGemma 2 do ggml-org por meio do
[llama.cpp](https://github.com/ggml-org/llama.cpp): na GPU do Mac com Metal, e no Windows e no Linux na GPU com Vulkan
quando uma verificação rápida na configuração inicial constata que é mais rápido que o processador e produz os mesmos
resultados. Todos os vetores vivem no mesmo espaço de 768 dimensões, e é por isso que uma única busca pode comparar um
quadro de vídeo com uma página de PDF. Uma busca transforma suas palavras em embedding em milissegundos e as compara
com tudo o que está no índice. Correspondências de palavras exatas recebem um reforço, porque nenhum embedding guarda
um número de nota fiscal exatamente como ele é.

O mecanismo de busca é o mesmo código Swift em todos os sistemas. No Mac, ele lê arquivos com os frameworks próprios
do macOS (ImageIO, PDFKit, AVFoundation e Vision para o texto em capturas de tela) e o aplicativo é feito em SwiftUI.
No Windows e no Linux, a leitura usa PDFium, ffmpeg, stb e miniz, e o aplicativo ao redor é feito com
[Tauri](https://tauri.app).

O índice guarda qual versão do modelo produziu seus vetores. Uma atualização que não altera os vetores mantém o índice,
e um teste verifica cada atualização do llama.cpp contra vetores de referência armazenados antes de lançá-la.

## Como compilar do código-fonte

No Mac, você precisa do Xcode 26, git e CMake (ou `uv`) para o llama.cpp. Se `xcode-select -p` apontar para as Command
Line Tools, mude para o Xcode primeiro (`sudo xcode-select -s /Applications/Xcode.app`): elas não trazem as macros de
SwiftUI e Swift Testing que o build precisa.

```sh
git clone https://github.com/ARahim3/DigUp && cd DigUp
scripts/build-llama.sh            # llama.cpp em uma tag fixada, com um patch de uma linha (alguns minutos)
swift build -c release && swift test
./build.sh                        # → build.noindex/DigUp.app
```

No Windows e no Linux, você precisa de Swift 6.4, Rust e Node; no Windows, também das ferramentas de compilação C++ do
Visual Studio, com os comandos executados no bash do Git for Windows. `scripts/fetch-vendor.sh` e
`scripts/build-llama.sh` obtêm as bibliotecas; `scripts/package-linux.sh` gera o `.deb` e o AppImage, e
`scripts/package-windows.sh`, o instalador.
[O workflow de pacotes](.github/workflows/packages.yml) traz todas as etapas, inclusive os pacotes de que cada sistema
precisa.

Para gerar o RPM deste fork, veja [`packaging/README.md`](packaging/README.md).

Também há uma ferramenta de linha de comando, `.build/release/digup`, que indexa, busca e roda os evals pelo terminal
(`digup --help`). `scripts/make-testbed.sh` cria uma pasta com arquivos de teste para experimentar no Mac (precisa de
ffmpeg), e `evals/` guarda as consultas usadas para medir mudanças na relevância.

## Perguntas frequentes

**Como isso difere do Spotlight ou da Busca do Windows?** Eles encontram arquivos pelo nome, texto e metadados. O DigUp
também os encontra pelo que mostram ou dizem, e leva você à página ou ao momento. Funcionam bem lado a lado.

**O que muda no Windows e no Linux?** A busca é a mesma: mesmo modelo, mesmos resultados. Duas coisas ainda faltam. O
texto dentro de capturas de tela ainda não é lido, então uma captura é encontrada pelo que mostra, e não por um código
exato digitado na busca. Além disso, arquivos doc de versões antigas do Word, fotos RAW e imagens SVG só são lidos no
Mac.

**Por que o download tem 865 MB?** É o modelo: a parte de texto (310 MB) e os codificadores de imagem e áudio (555 MB).
O aplicativo em si tem cerca de 20 MB no Mac e entre 40 e 140 MB no Windows e no Linux, conforme o pacote, já que
carrega seus próprios leitores de PDF, vídeo e imagem.

**Vai deixar meu computador lento?** Só a primeira varredura é pesada. Depois disso, ele lê apenas arquivos novos. O
modelo roda em um processo separado que sai quando termina, e a parte da busca só é carregada enquanto você pesquisa.

**Quais idiomas?** O modelo conhece mais de 100, e o DigUp busca em todos eles, inclusive entre idiomas diferentes. Os
evals cobrem apenas inglês, bengali e árabe, por serem os idiomas dos arquivos usados nos testes, e o Google observa que
o modelo não é igualmente forte em todos os idiomas. Dois limites valem para palavras exatas, não para o significado: o
texto dentro de capturas de tela só é lido no Mac, pelo reconhecimento de texto da Apple, que conhece cerca de 25
idiomas, e idiomas escritos sem espaços, como chinês, japonês e tailandês, não são separados em palavras.

**Como desinstalar?**
No Mac, feche o aplicativo e apague `DigUp.app` e `~/Library/Application Support/DigUp`, que guardam o modelo e os
índices. As configurações ficam em `~/Library/Preferences/com.abdurrahim.DigUp.plist`. Com o Homebrew,
`brew uninstall --cask --zap digup` remove tudo.
No Windows, desinstale em Configurações → Aplicativos; marque "Excluir os dados do aplicativo" para remover também o
modelo e o índice.
No Linux, `sudo apt remove dig-up` (ou apague o AppImage) e depois remova `~/.local/share/digup` (modelo e índice),
`~/.config/com.abdurrahim.DigUp`, `~/.local/share/com.abdurrahim.DigUp` e, se ele abria no login,
`~/.config/autostart/DigUp.desktop`. Para RPM, use `sudo dnf remove dig-up`. No GNOME, remova também o atalho em
Configurações → Teclado.

## Apoio

O DigUp é gratuito e de código aberto, e pretende continuar assim. Se ele ajudou você e quiser apoiar o projeto, você
pode [me comprar um café](https://arahim3.gumroad.com/l/support).

## Agradecimentos

O DigUp é construído sobre o [EmbeddingGemma 2](https://huggingface.co/google/embeddinggemma-2) do Google DeepMind
(Apache 2.0) e o [llama.cpp](https://github.com/ggml-org/llama.cpp) (MIT). O aplicativo para Mac usa o
[Sparkle](https://sparkle-project.org) (MIT) para atualizações. O aplicativo para Windows e Linux é feito com
[Tauri](https://tauri.app) (MIT ou Apache 2.0) e lê arquivos com
[PDFium](https://pdfium.googlesource.com/pdfium/) (BSD), [FFmpeg](https://ffmpeg.org) (LGPL),
[stb](https://github.com/nothings/stb) (domínio público) e [miniz](https://github.com/richgel999/miniz) (MIT). Os
avisos de licença acompanham o aplicativo.

O DigUp não é afiliado a Google, Apple ou Microsoft. Gemma é marca da Google LLC; Mac e Spotlight são marcas da Apple
Inc.; Windows é marca da Microsoft Corporation.

## Licença

MIT
