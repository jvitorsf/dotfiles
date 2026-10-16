# dotfiles

Configurações pessoais de terminal, shell e editor. Os arquivos seguem o
mesmo caminho que ocupam a partir da home (`~`): `.config/herdr/config.toml`
aqui vai para `~/.config/herdr/config.toml`, e assim por diante.

Há dois conjuntos:

- **Terminal no macOS** (atual): Ghostty, Herdr, iTerm2, Starship, lazygit e
  delta, todos com o tema **Vesper**.
- **Linux** (legado): zsh com Powerlevel10k, Terminator e Vim.

## Conteúdo

| Arquivo | Destino | O que é |
|---|---|---|
| `.config/ghostty/config` | `~/.config/ghostty/config` | Ghostty: tema, fonte, transparência e modo Guake |
| `.config/ghostty/shaders/*.glsl` | `~/.config/ghostty/shaders/` | Efeito de monitor CRT (opcional) |
| `.config/herdr/config.toml` | `~/.config/herdr/config.toml` | Herdr: atalhos estilo Vim e tema |
| `Library/Application Support/iTerm2/DynamicProfiles/vesper.json` | mesmo caminho em `~` | Perfil "Guake (Vesper)" do iTerm2 |
| `Library/Application Support/lazygit/config.yml` | mesmo caminho em `~` | lazygit: cores Vesper e diff com delta |
| `.config/zsh/terminal-visual.zsh` | `~/.config/zsh/terminal-visual.zsh` | Starship, zoxide, `ls` com ícones e plugins do zsh |
| `.gitconfig.delta` | `~/.gitconfig.delta` | delta como pager do git |
| `.zshrc`, `.p10k.zsh`, `.bash_aliases` | `~/` | Shell (legado, Linux) |
| `.vimrc`, `.vimrc.local`, `.vimrc.local.bundles` | `~/` | Vim (legado) |
| `.config/terminator/config` | `~/.config/terminator/config` | Terminator (legado, Linux) |

## Terminal no macOS

### 1. Instalar

```bash
brew install --cask ghostty font-jetbrains-mono-nerd-font
brew install starship eza zoxide git-delta lazygit \
  zsh-autosuggestions zsh-syntax-highlighting
# opcionais: fastfetch btop
```

O Herdr tem instalação própria: <https://herdr.dev>.

### 2. Copiar os arquivos

Na raiz deste repo:

```bash
mkdir -p ~/.config/ghostty/shaders ~/.config/herdr ~/.config/zsh \
  ~/Library/Application\ Support/iTerm2/DynamicProfiles \
  ~/Library/Application\ Support/lazygit

cp .config/ghostty/config ~/.config/ghostty/config
cp .config/ghostty/shaders/*.glsl ~/.config/ghostty/shaders/
cp .config/herdr/config.toml ~/.config/herdr/config.toml
cp .config/zsh/terminal-visual.zsh ~/.config/zsh/terminal-visual.zsh
cp .gitconfig.delta ~/.gitconfig.delta
cp "Library/Application Support/iTerm2/DynamicProfiles/vesper.json" \
  ~/Library/Application\ Support/iTerm2/DynamicProfiles/
cp "Library/Application Support/lazygit/config.yml" \
  ~/Library/Application\ Support/lazygit/config.yml
```

Faça backup antes se já tiver algum desses arquivos. Se preferir que as
mudanças no repo valham na hora, troque `cp` por `ln -s "$PWD/<arquivo>" <destino>`.

### 3. Ligar no shell e no git

No fim do `~/.zshrc`:

```zsh
source ~/.config/zsh/terminal-visual.zsh
```

Se usar Oh My Zsh, deixe `ZSH_THEME=""` para o Starship desenhar o prompt.

No git:

```bash
git config --global include.path ~/.gitconfig.delta
```

### Ghostty

- **Tema:** `Vesper`, que já vem com o Ghostty. Outros: `ghostty +list-themes`.
- **Fonte:** JetBrains Mono Nerd Font, peso Medium, tamanho 14, com
  `font-thicken`.
- **Modo Guake:** ``ctrl+` `` abre e esconde o terminal de qualquer app. Na
  primeira vez, o macOS pede permissão de Acessibilidade para o Ghostty.
  `quick-terminal-size = 100%` faz a janela ocupar a tela toda. Use isso em vez
  de tela cheia, porque a tela cheia fica com o tamanho errado ao trocar de
  monitor.
  - O modo Guake não tem abas no macOS (limitação do Ghostty). Use as abas do
    Herdr. Divisão de painéis funciona.
- **Option como Alt:** só o Option esquerdo (`macos-option-as-alt = left`), para
  os atalhos com `alt` do Herdr. O direito continua livre para caracteres
  especiais.
- **Pasta inicial:** descomente `working-directory` e ajuste o caminho.
- **Efeito CRT:** descomente `custom-shader`. `crt-soft.glsl` é a versão suave;
  `crt.glsl` é a original, forte e ilegível em monitor 1080p.
- **Recarregar a config:** `cmd+shift+,` (vírgula). `cmd+shift+=` aumenta a
  fonte; `cmd+0` volta ao tamanho original.
- **Abrir ao ligar o Mac:** Ajustes do Sistema → Geral → Itens de Início.

### Herdr

O prefixo é `ctrl+space`. Desligue antes o atalho do macOS que usa
`ctrl+space` (Ajustes → Teclado → Atalhos → Fontes de Entrada).

| Ação | Atalho |
|---|---|
| Configurações | `prefix` `,` |
| Trocar de painel | `prefix` `h/j/k/l` ou `ctrl+alt+h/j/k/l` |
| Dividir empilhado / lado a lado | `prefix` `s` (ou `-`) / `prefix` `v` |
| Redimensionar painel | `prefix` `<` `>` `+` `_` |
| Aba nova | `prefix` `c` |
| Próxima / anterior aba | `prefix` `n` / `p`, ou `ctrl+alt+]` / `ctrl+alt+[` |
| Último painel | `prefix` `;` |
| Próximo / anterior agente | `ctrl+alt+n` / `ctrl+alt+p` |
| Fechar workspace (a worktree fica no disco) | `prefix` `shift+d` |
| Fechar workspace **e apagar a worktree** | `prefix` `alt+d` |

- Recarregar a config sem derrubar nada: `herdr server reload-config`.
- O `alt+d` só funciona em workspace de worktree, pede confirmação e nunca apaga
  a branch.
- Fechar o terminal não derruba o Herdr: rode `herdr` de novo e tudo volta.

### iTerm2 (alternativa ao Ghostty)

O `vesper.json` cria o perfil dinâmico **Guake (Vesper)**, filho de um perfil
chamado **Guake**, que precisa existir (crie em Settings → Profiles). Ele traz a
paleta Vesper, a JetBrains Mono Nerd Font Medium 14, transparência com desfoque
e o atalho ``ctrl+` ``.

Para ele ser o perfil usado:

1. Settings → Profiles → **Guake (Vesper)** → Other Actions → *Set as Default*.
2. Desligue o atalho no perfil **Guake** original (Keys → Hotkey Window), para
   não existirem dois perfis com ``ctrl+` ``.

O Ghostty usa o mesmo ``ctrl+` ``. Não deixe os dois abertos ao mesmo tempo.

### Shell

- **Starship:** é um programa à parte, não é tema do Oh My Zsh. Para
  personalizar o prompt, crie `~/.config/starship.toml`.
- **zoxide:** `z <parte-do-nome>` pula para pastas já visitadas.
- **zsh-autosuggestions:** sugestão em cinza enquanto você digita; `→` aceita.
- **zsh-syntax-highlighting:** o comando fica verde quando existe e vermelho
  quando não existe.

### delta e lazygit

- **delta:** `git diff`, `git show` e `git log -p` passam a ter cores, números
  de linha e diff lado a lado. `n` / `N` pulam de arquivo. Em painel estreito,
  troque `side-by-side = true` por `false` no `~/.gitconfig.delta`.
- **lazygit:** usa as cores do Vesper e o delta para mostrar diffs (`|` alterna
  o modo de diff). A config fica em `~/Library/Application Support/lazygit/`.

## Linux (legado)

### zsh e Powerlevel10k

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
cp .zshrc .p10k.zsh .bash_aliases ~/
```

Para refazer o visual do prompt: `p10k configure`. O `.zshrc` também configura
nvm e caminhos de Android e Java; ajuste para a sua máquina.

### Terminator

```bash
mkdir -p ~/.config/terminator
cp .config/terminator/config ~/.config/terminator/config
```

Atalhos principais: `alt+h/j/k/l` troca de painel, `ctrl+k` / `ctrl+j` troca de
aba e `ctrl+esc` esconde a janela.

### Vim

```bash
cp .vimrc .vimrc.local .vimrc.local.bundles ~/
vim +PlugInstall +qall
```

Baseado no vim-bootstrap. O vim-plug é baixado sozinho na primeira abertura
(precisa de `curl`). Os plugins extras ficam em `.vimrc.local.bundles` (gruvbox,
coc.nvim, markdown-preview), e as preferências pessoais em `.vimrc.local`.
