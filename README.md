# compe-zsh

Zsh completion for compe-zsh

## Requirements

* [Neovim](https://github.com/neovim/neovim/)
* [nvim-compe](https://github.com/hrsh7th/nvim-compe)
* zsh/zpty module

```zsh
zmodload zsh/zpty
```

## Installation

```vim
Plug 'hrsh7th/nvim-compe'
Plug 'tamago324/compe-zsh'
Plug 'nvim-lua/plenary.nvim'


lua << EOF
require'compe'.setup {
  -- ...
  source = {
    -- ...
    zsh = true,
  }
}
EOF
```

## Configuration

It saves compdump file in `$COMPE_ZSH_CACHE_DIR` or `$XDG_CACHE_HOME` or
`$HOME/.cache` directory.


NOTE: In my case, I had to add the directory of the complete function to `$FPATH` in `~/.zshenv`.

```zsh
# completions
if [ -d $HOME/.zsh/comp ]; then
    export FPATH="$HOME/.zsh/comp:$FPATH"
fi
```


## Credit

* [deoplete-zsh](https://github.com/deoplete-plugins/deoplete-zsh)
* [zsh-capture-completion](https://github.com/Valodim/zsh-capture-completion)

## License

MIT
