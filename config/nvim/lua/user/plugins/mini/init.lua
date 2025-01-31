MiniDeps.now(
  function()
    MiniDeps.add({
      source = "echasnovski/mini.nvim",
      depends = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
    })
  end
)

MiniDeps.now(function()
  -- ------------------------------------------------------------------------
  -- | mini.icons
  -- ------------------------------------------------------------------------
  local icons = require("mini.icons")
  icons.setup({})
  icons.mock_nvim_web_devicons()
  icons.tweak_lsp_kind("prepend")

  -- ------------------------------------------------------------------------
  -- | mini.notify
  -- ------------------------------------------------------------------------
  local notify = require("mini.notify")
  notify.setup({})
  vim.notify = notify.make_notify()
  vim.keymap.set("n", "<leader>hn", notify.show_history, { desc = "mini.notify show history" })

  -- ------------------------------------------------------------------------
  -- | mini.starter
  -- ------------------------------------------------------------------------
  require("user.plugins.mini.starter").setup()

  -- ------------------------------------------------------------------------
  -- | mini.statusline
  -- ------------------------------------------------------------------------
  require("mini.statusline").setup({})
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "DiffviewFiles" },
    callback = function() vim.b.ministatusline_disable = true end,
  })

  -- ------------------------------------------------------------------------
  -- | mini.completion
  -- ------------------------------------------------------------------------
  -- Needs to be loaded _now_, so that 'completefunc' gets set during the LspAttach event
  require("mini.completion").setup({
    set_vim_settings = false,
  })
  -- Disable MiniCompletion for some filetypes
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "minifiles" },
    callback = function() vim.b.minicompletion_disable = true end,
  })
end)

MiniDeps.later(function()
  require("user.plugins.mini.clue").setup()
  require("user.plugins.mini.files").setup()
  require("user.plugins.mini.git").setup()
  require("user.plugins.mini.pick").setup()
  require("user.plugins.mini.visits").setup()

  require("mini.align").setup({})
  require("mini.cursorword").setup({})
  require("mini.splitjoin").setup({})
  require("mini.trailspace").setup({})

  -- ------------------------------------------------------------------------
  -- | mini.ai
  -- ------------------------------------------------------------------------
  local spec_treesitter = require("mini.ai").gen_spec.treesitter
  require("mini.ai").setup({
    custom_textobjects = {
      i = spec_treesitter({ a = "@conditional.outer", i = "@conditional.inner" }),
      l = spec_treesitter({ a = "@loop.outer", i = "@loop.inner" }),
      m = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),
      o = spec_treesitter({ a = "@class.outer", i = "@class.inner" }),
      z = spec_treesitter({ a = "@comment.outer", i = "@comment.inner" }),
    },
  })

  -- ------------------------------------------------------------------------
  -- | mini.bracketed
  -- ------------------------------------------------------------------------
  require("mini.bracketed").setup({
    comment = { suffix = "z" },
    diagnostic = { suffix = "" },
    jump = { suffix = "" },
    undo = { suffix = "" },
    window = { suffix = "" },
    yank = { suffix = "" },
  })

  -- ------------------------------------------------------------------------
  -- | mini.diff
  -- ------------------------------------------------------------------------
  local minidiff = require("mini.diff")
  minidiff.setup({
    view = {
      style = "sign",
      signs = { add = "│", change = "│", delete = "-" },
    },
  })

  vim.keymap.set("n", "<leader>gO", minidiff.toggle_overlay, { desc = "mini.diff toggle overlay" })

  -- ------------------------------------------------------------------------
  -- | mini.hipatterns
  -- ------------------------------------------------------------------------
  local hipatterns = require("mini.hipatterns")
  hipatterns.setup({
    highlighters = {
      fixme = { pattern = "FIXME", group = "MiniHipatternsFixme" },
      hack = { pattern = "HACK", group = "MiniHipatternsHack" },
      todo = { pattern = "TODO", group = "MiniHipatternsTodo" },
      note = { pattern = "NOTE", group = "MiniHipatternsNote" },

      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })

  -- ------------------------------------------------------------------------
  -- | mini.misc
  -- ------------------------------------------------------------------------
  local minimisc = require("mini.misc")
  minimisc.setup({})
  minimisc.setup_termbg_sync()
  minimisc.setup_restore_cursor()

  -- ------------------------------------------------------------------------
  -- | mini.operators
  -- ------------------------------------------------------------------------
  require("mini.operators").setup({
    evaluate = { prefix = "g=" },
    exchange = { prefix = "gox" },
    multiply = { prefix = "gom" },
    replace = { prefix = "gor" },
    sort = { prefix = "gos" },
  })

  -- ------------------------------------------------------------------------
  -- | mini.snippets
  -- ------------------------------------------------------------------------
  local minisnippets = require("mini.snippets")
  minisnippets.setup({
    snippets = {
      -- Load custom file with global snippets first
      minisnippets.gen_loader.from_runtime("global.{json,lua}"),
      minisnippets.gen_loader.from_lang(),
    },
  })

  local expand_all = function() minisnippets.expand({ match = false }) end
  vim.keymap.set("i", "<C-g><C-j>", expand_all, { desc = "Expand all" })

  -- ------------------------------------------------------------------------
  -- | mini.surround
  -- ------------------------------------------------------------------------
  require("mini.surround").setup({
    mappings = {
      add = "gs",
      delete = "ds",
      find = "",
      find_left = "",
      highlight = "gsh",
      replace = "cs",
      update_n_lines = "gsu",

      suffix_last = "",
      suffix_next = "",
    },
    n_lines = 40,
    respect_selection_type = true,
    search_method = "cover_or_next",
  })
  vim.keymap.set("x", "gs", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })
end)
