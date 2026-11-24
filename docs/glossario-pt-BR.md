# Glossário PT-BR — DigUp

Termos e regras usados na tradução da interface do DigUp para português brasileiro.
Mantenha a consistência com este arquivo ao traduzir novas strings.

## Termos

| Inglês | PT-BR |
|---|---|
| DigUp, EmbeddingGemma 2, llama.cpp, Tauri, ggml, Vulkan, Metal | não traduzir |
| Describe it. Dig it up. | Descreva. Encontre. |
| search (subst.) | busca |
| search (verbo) | buscar / pesquisar |
| to search for | buscar por |
| index (subst.) | índice |
| index (verbo), indexing | indexar, indexação |
| folder | pasta |
| file | arquivo |
| screenshot | captura de tela |
| photo / picture | foto / imagem |
| recording | gravação |
| video | vídeo |
| audio | áudio |
| model | modelo |
| embedding | embedding (termo técnico) |
| results | resultados |
| preview | prévia |
| moment | momento |
| page | página |
| passage | trecho |
| word | palavra |
| exact words | palavras exatas |
| code search | busca de código |
| settings | Configurações |
| shortcut | atalho |
| tray / menu bar app | bandeja / barra de menus |
| update(s) | atualização(ões) |
| to skip (a folder/type) | ignorar (uma pasta/tipo) |
| to pause / to resume | pausar / retomar |
| to turn on / to turn off | ativar / desativar |
| launch at login | abrir ao iniciar |
| privacy | privacidade |
| spreadsheet | planilha |
| presentation | apresentação |
| speaker notes | notas do palestrante |
| storage | armazenamento |
| general | geral |
| cancel | Cancelar |
| save | Salvar |
| remove / delete | Remover / Excluir |
| add | Adicionar |
| change | Alterar |
| check now | Verificar agora |
| check for updates | Verificar atualizações |
| start indexing | Iniciar indexação |
| open | Abrir |
| quit | Sair |
| about | Sobre |
| help | Ajuda |
| done / finish | Concluir |
| next / back | Avançar / Voltar |

## Regras

1. Traduza **apenas textos visíveis ao usuário** e mensagens de estado/diálogo.
2. **Não traduza** identificadores, chaves de JSON/UserDefaults, nomes de comandos IPC,
   enum raw values, caminhos de arquivo, nomes de macros e mensagens de log de desenvolvedor.
3. Preserve variáveis e marcadores: `%@`, `%d`, `%1$@`, `\(variavel)`, `{{...}}`,
   `${...}`, `{}`, `%s`, `{}` de `String(format:)`, além de HTML e atributos `data-*`.
4. Não altere lógica, condicionais, comparações de strings nem valores persistidos.
5. Não traduza nomes de produtos, marcas ou bibliotecas.
6. Mantenha reticências (…) e pontuação consistente; use `…` (U+2026) onde o original usa `...`.
7. Em SwiftUI, mantenha `Text("...")` e os argumentos de `Button("...")` intactos quanto à sintaxe.
