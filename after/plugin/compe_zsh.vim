if exists('g:loaded_compe') && has('nvim')
  lua require'compe'.register_source('zsh', require'compe_zsh')
endif
