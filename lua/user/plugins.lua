local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins

  -- TODO setup
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use "kyazdani42/nvim-tree.lua" -- file explorer
  use {
     "akinsho/bufferline.nvim",
     branch = "main",
  } -- show buffers (open files) at the top
  use "moll/vim-bbye" -- tweak to make nicer handling of buffers
  use "nvim-lualine/lualine.nvim" -- special statusline. can have mode, git info, filename, stuff..
  use "ahmedkhalf/project.nvim" -- groups of files as projects
  --use "lewis6991/impatient.nvim" -- speed up nvim startup time by caching certain plugin things
  use "lukas-reineke/indent-blankline.nvim" -- nice features for looking at indented lines!
  
  use "folke/which-key.nvim" -- pop up to help guide completion of keyboard shortcuts
  use "nvim-telescope/telescope.nvim" -- for finding files? 

  -- Treesitter. more intelligent file knowledge, syntax highlighting helper..
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  use "lewis6991/gitsigns.nvim"

  -- themes
  use "lunarvim/darkplus.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

