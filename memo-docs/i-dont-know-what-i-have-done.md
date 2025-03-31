lua require('telescope.builtin').lsp_workspace_symbols()
lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
lua vim.lsp.buf.workspace_symbol()
lua vim.lsp.buf.workspace_symbol()
lsp_workspace_symbols

- /Users/gitp/dotfiles/.config/nvim/lua/telescope-conf.lua에 있음
- lsp_workspace_symbols의 정의를 찾고 싶음
- 아래 둘 중 하난를 하면 되겠지
- builtin.lsp_workspace_symbols: 이게 작동 안하는 게 문제
- builtin.lsp_dynamic_workspace_symbols

https://github.com/nvim-telescope/telescope.nvim/issues/964

/Users/gitp/dotfiles/.config/nvim/lua/telescope-conf.lua
cat symbols.txt | awk '{OFS = "|"} {if($1 ~ /^lua/) print $0}'

### workspace symbol
- reference
  - [workspace/symbol lsp spec](https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#workspaceFeatures)
  - :help vim.lsp.buf lsp기능(go to definition, search symbols) 다 여기 api 노출됨

### vim.lsp.buf
vim.lsp.buf.hover()
vim.lsp.buf.definition()
vim.lsp.buf.rename()
vim.lsp.buf.signature_help()

