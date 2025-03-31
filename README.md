# what is this 
Hallo, I am university(yonsei univ) student in korea. sorry about my poor english first.
This is my neovim config which grew from foundation of [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).
This config code is piece of shit. still needs refactoring.

I hope this repository help you config neovim
If you have no idea of config neovim. I highly recommand you to start from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).


# it works in
- machine: macbook air m2(arm64)
- os: macos 14
- neovim_version: 0.10.2

# what this config code contains
- plugins
  - git
  - oil: file explorer
  - nvim-tree
  - telescope
  - vim-fugitive
  - nvim-cmp
  - nvim-lspconfig
  - nvim-dap
  - nvim-treesitter
- my-commands
  - `Wipehidden`: remove hidden buffers(which is saved. exclude not saved buffers)
  - `Wh`: alias of `WipeHidden`
  - `Rc`: run external command and copy output to new scratch buf
  - `Rvc`: run vim command and copy output to new scratch buf
  - `Rvlc`: run neovim lua command and copy output to new scratch buf
  - `Cwd`: change current work space directorya to parent directory of current buffer file
  - `Cp`: copy current buffer file absolute path
  - `Vnew`: vertical and create scratch buffer
  - `New`: split and create scratch buffer


