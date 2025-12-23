-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Keymaps for Documentation search
local actions = {
    {
        name = "man",
        action = function(word)
            vim.cmd("Man " .. word)
        end,
    },
    {
        name = "devdocs",
        action = function(word)
            vim.fn.jobstart({ "open", "https://devdocs.io/#q=" .. word })
        end,
    },
    {
        name = "google",
        action = function(word)
            vim.fn.jobstart({ "open", "https://www.google.com/search?q=" .. word })
        end,
    },
}

local function choose_doc()
    local word = vim.fn.expand("<cword>")
    if not word or word == "" then
        vim.notify("No word selected", vim.log.levels.WARN)
        return
    end
    vim.ui.select(actions, {
        prompt = "Choose documentation",
        format_item = function(item)
            return item.name
        end,
    }, function(choice)
        if choice and choice.action then
            choice.action(word)
        end
    end)
end

vim.keymap.del("n", "<leader>K")

-- Map <leader>K to new picker
vim.keymap.set("n", "<leader>K", choose_doc, { desc = "Search in Docs" })
