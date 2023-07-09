# About

My dotfiles managed with chezmoi. I'am using `macos`, `iterm2`, `zsh`, `tmux`, `vim`, `vscode`, `karabiner`, `xi` and etc. Keyboard is my love. I'm using keyboard in `95%` time.  I recommend this approach to everyone, because it really increases productivity many times over.

I'm used [xi](https://github.com/grigoryvp/vscode-language-xi) for my personal wiki database: notes, code snippets, api documentation and another information save and faster finds. Relly recommendation. More information in [description](https://github.com/maxdzyubak/dotfiles#xi)

I'm liked retro groove color scheme for vim [gruvbox](https://github.com/morhetz/gruvbox) and using her in `iterm2`, `zsh`, `tmux`, `vim`. In `vscode` using theme [Memory Color Theme](https://marketplace.visualstudio.com/items?itemName=grigoryvp.memory-theme) by [@grigoryvp](https://github.com/grigoryvp) . More information on my tools in the [table](https://github.com/maxdzyubak/dotfiles#table-tools).

## Docs

[chezmoi.io](https://chezmoi.io/)

### Install

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply maxdzyubak
```

or go to
[chezmoi.io/install](https://www.chezmoi.io/install/)

### Updating your dotfiles on any machine is a single command

```bash
chezmoi update
```

### Table tools

| | Name | Site | Repository | Config | Description |
| --- | --- | --- | --- | --- | ---   |
|![xi logo](assets/img/xi.svg) | Xi | [marketplace.visualstudio.com](https://marketplace.visualstudio.com/items?itemName=grigoryvp.language-xi) | [grigoryvp/vscode-language-xi](https://github.com/grigoryvp/vscode-language-xi)  | private repo | [description](https://github.com/maxdzyubak/dotfiles#xi) |
|![vim logo](assets/img/vim.svg)| Vim |[vim.org](https://www.vim.org/)| [vim/vim](https://github.com/vim/vim) | [config](https://github.com/maxdzyubak/dotfiles/tree/main/dot_vim) | |
|![brew logo](assets/img/brew.svg)| Homebrew | [brew.sh](https://brew.sh/]) | [brew](https://github.com/Homebrew/brew) | [config](https://github.com/maxdzyubak/dotfiles/blob/main/Brewfile) | |
|![oh my zsh logo](assets/img/ohmyzsh.svg)| Ohmyzsh | [ohmyz.sh](https://ohmyz.sh/) | [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh) | [config](https://github.com/maxdzyubak/dotfiles/blob/main/dot_zshrc) | |
|![vscode logo](assets/img/vscode.svg)| VSCode | [code.visualstudio.com](https://code.visualstudio.com/) | [vscode](https://github.com/Microsoft/vscode/) | [config](https://github.com/maxdzyubak/dotfiles/tree/main/private_Library/private_Application%20Support/private_Code/User) | |
|![iterm2 logo](assets/img/iterm2.svg)| iTerm2 | [iterm2.com](https://iterm2.com/) | [iTerm2](https://github.com/gnachman/iTerm2) | [config](https://github.com/maxdzyubak/dotfiles/tree/main/iterm2) | |
|![alacritty logo](assets/img/alacritty-logo.svg)| Alacritty | [alacritty.org](https://alacritty.org/) | [alacritty](https://github.com/alacritty/alacritty) | [config](https://github.com/maxdzyubak/dotfiles/blob/main/dot_config/alacritty/alacritty.yml) | |
|![karabiner logo](assets/img/karabiner.svg)| Karabiner | [karabiner-elements.pqrs.org](https://karabiner-elements.pqrs.org/) | [Karabiner-Elements](https://github.com/pqrs-org/Karabiner-Elements) | [config](https://github.com/maxdzyubak/dotfiles/blob/main/dot_config/private_karabiner/private_karabiner.json) | |
|![raycast logo](assets/img/raycast.svg)| Raycast | [raycast.com](https://www.raycast.com/) | [raycast](https://github.com/raycast) | [config](https://github.com/maxdzyubak/dotfiles/tree/main/dot_config/raycast) | |
|![homerow logo](assets/img/homerow.svg)| Homerow.app | [homerow.app](https://www.homerow.app/) | [homerow](https://github.com/dexterleng/homerow) | |
|![rectanglepro logo](assets/img/rectanglepro.svg)| Rectangleapp/pro | [rectangleapp.com/pro](https://rectangleapp.com/pro) | [RectanglePro](https://github.com/rxhanson/RectanglePro-Community) | [config](https://github.com/maxdzyubak/dotfiles/blob/main/dot_config/RectangleProConfig.json) | |
|![fig logo](assets/img/fig.svg)| Fig | [fig.io](https://fig.io/) | [fig.io](https://github.com/withfig) |  | |
|| Tmux | | [tmux](https://github.com/tmux/tmux) | [config](https://github.com/maxdzyubak/dotfiles/blob/main/dot_config/tmux/tmux.conf.local) | [description](https://github.com/maxdzyubak/dotfiles#tmux) |
|| Fd | | [sharkdp/fd](https://github.com/sharkdp/fd) | | |
|| Exa | [the.exa.website](https://the.exa.website/) | [ogham/exa](https://github.com/ogham/exa) | [config](https://github.com/maxdzyubak/dotfiles/blob/main/dot_zshrc) | |
|| Ripgrep | | [BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep) | | |
|| Zoxide | | [ajeetdsouza/zoxide](https://github.com/ajeetdsouza/zoxide) | | |
|| Entr | | [eradman/entr](https://github.com/eradman/entr) | | |
|| Git-radar | | [michaeldfallen/git-radar](https://github.com/michaeldfallen/git-radar) | [config](https://github.com/maxdzyubak/dotfiles/blob/main/dot_zshrc#L89) | |
|| Powerlevel10k |  | [powerlevel10k](https://github.com/romkatv/powerlevel10k) | [config](https://github.com/maxdzyubak/dotfiles/blob/main/dot_p10k.zsh) | |
|| The Silver Searcher | [geoff.greer.fm/ag/](https://geoff.greer.fm/ag/) | [the_silver_searcher](https://github.com/ggreer/the_silver_searcher) | | |
|| Lsd |  | [sd-rs/lsd](https://github.com/lsd-rs/lsd) | [config](https://github.com/maxdzyubak/dotfiles/blob/main/dot_zshrc) | |
|| Bat |  | [sharkdp/bat](https://github.com/sharkdp/bat) | [config](https://github.com/maxdzyubak/dotfiles/blob/main/dot_zshrc) | |
|| Diff-so-fancy |  | [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy) | | |

### Description

#### Xi

`Xi` — markup language support for syntax highlighting and link jumps
Autor [@grigoryvp](https://github.com/grigoryvp)
Documentation is [here](https://github.com/grigoryvp/vscode-language-xi)
Video guide in YouTube on Russian language is [here](https://youtu.be/q4Ftg63diDs)

#### Tmux

I'am using [oh-my-tmux](https://github.com/gpakosz/.tmux) configuration.

To do: keybindings...

### License

[MIT](https://opensource.org/license/mit/)
