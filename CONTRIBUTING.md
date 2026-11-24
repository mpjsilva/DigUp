<p align="center"><a href="CONTRIBUTING.en.md">English</a> · <b>Português (Brasil)</b></p>

# Como contribuir para o DigUp

Obrigado pelo interesse no DigUp. É um projeto pequeno, com uma única pessoa mantenedora e um plano definido para seu
caminho, então algumas observações no início economizam tempo de todos.

## Abra uma issue primeiro

Abra uma issue antes de escrever qualquer código, tanto para uma correção quanto para uma funcionalidade. A mesma
correção ou funcionalidade pode já estar em andamento e ainda não ter sido enviada. Uma issue lhe dá um "sim", "agora
não" ou "veja como isso se encaixa" antes de você gastar uma noite nisso. Um pull request que chegue sem issue pode ser
fechado com um link de volta para cá.

## Pull requests

Depois que a issue der o sinal verde:

- Mantenha o escopo em uma correção ou uma funcionalidade, com o motivo na descrição.
- Garanta que `swift test` passe, e `cargo test` em `shell/src-tauri` se você mudou o aplicativo para Windows e Linux.
- Se a mudança afetar o que a busca retorna, rode os evals em `evals/` antes e depois (veja "Como compilar do
  código-fonte" no README) e inclua os dois resultados.
- Para mudanças de velocidade ou memória, meça antes e depois no mesmo computador.

O DigUp mantém tudo no seu computador, então mudanças que enviam dados para fora, como telemetria ou serviços em nuvem,
não se encaixam.

## Onde está cada coisa

O mecanismo de busca em `Sources/DigUpKit` é o mesmo código Swift em todos os sistemas; o que muda por sistema fica
nas pastas `Platform/Apple` e `Platform/Portable`. O aplicativo para Mac é `Sources/DigUpApp` (SwiftUI). O aplicativo
para Windows e Linux fica em `shell/` (Tauri: Rust, com HTML e JavaScript simples para as janelas), que executa o
mecanismo como um programa auxiliar. `scripts/` compila llama.cpp, ffmpeg e os pacotes, e
`.github/workflows/packages.yml` mostra cada etapa dos builds para Windows e Linux. O título "Como compilar do
código-fonte" no README é o ponto de partida.

Para gerar o RPM deste fork, veja [`packaging/README.md`](packaging/README.md).

## Atualizando as dependências vendorizadas do mecanismo portátil

`scripts/fetch-vendor.sh` verifica os downloads de SQLite, miniz, PDFium (em cada plataforma compatível) e stb contra
os hashes SHA-256 revisados e fixados em `scripts/vendor-checksums.json` antes de extrair ou instalar. Ao mudar uma
versão, revise o lançamento upstream e atualize os hashes correspondentes no mesmo commit. Nunca obtenha o hash
esperado do mesmo download não confiável durante o build. Mudar os hashes invalida o cache de dependências
vendorizadas, inclusive os caches criados antes da verificação existir.

## O que esperar

O DigUp é mantido em paralelo com um emprego e outros projetos, e a maior parte do tempo vai para o plano do seu futuro,
então as respostas podem levar alguns dias, às vezes mais. Uma semana sem novidades significa que a pessoa está
ocupada, não que você foi ignorado, e toda issue recebe uma resposta, mesmo que seja "agora não".

Nem todo pull request será aceito, mesmo os bons. O projeto tem uma direção, e algumas mudanças não se encaixam. Outras
são reworkadas ou reescritas para se adaptarem a trabalho em andamento; quando isso acontece, você é creditado nas
notas do lançamento.

## Como relatar um bug

Um bom relato inclui seu computador (no Mac, o chip e a memória; no Windows e no Linux, o processador e a placa de
vídeo), as versões do sistema e do DigUp (no Linux, também o ambiente desktop, como GNOME ou KDE, e Wayland ou X11),
o que você fez ou buscou e o que esperava acontecer. Os logs ficam em:

- Mac: `~/Library/Application Support/DigUp/index.noindex` (`app.log` e `indexer.log`)
- Windows: `%LOCALAPPDATA%\com.abdurrahim.DigUp\logs`, e `worker.log` em `%LOCALAPPDATA%\DigUp\index`
- Linux: `~/.local/share/com.abdurrahim.DigUp/logs`, e `worker.log` em `~/.local/share/digup/index`
