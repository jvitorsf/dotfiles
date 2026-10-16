# Visual do terminal: prompt Starship, zoxide, ls com ícones e plugins do zsh.
# Carregue no FIM do ~/.zshrc:  source ~/.config/zsh/terminal-visual.zsh
# Se usar Oh My Zsh, deixe ZSH_THEME="" para o Starship desenhar o prompt.

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
alias ls="eza --icons"
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"  # tem que ser o último
