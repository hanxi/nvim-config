local M = {}

vim.cmd([[
" 关闭插件窗口
function! ClosePluginWindow() abort
  " Close quickfix
  cclose
  " Close Leaderf Buffer
  redir => message
  silent execute "ls!"
  redir END
  let l:buflist = split(message, '\n')
  for l:one in l:buflist
    let l:items = split(l:one, '"')
    if match(l:items[0], "u*a-") >= 0
      let l:bufid = matchstr(l:items[0], '\d\+')
      exe 'bd! '.l:bufid
    endif
  endfor
endfunction
]])

-- Close current window and all its floating subwindows
function M.close_plugin_window()
    vim.fn["ClosePluginWindow"]()
    local this_win = vim.fn.win_getid()
    -- close all floating windows that are relative to the current one
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local win_config = vim.api.nvim_win_get_config(win)
        -- If the mapping doesn't close enough windows, use the following line instead:
        -- if win_config.relative ~= "" then
        if win_config.relative == "win" and win_config.win == this_win then
            vim.api.nvim_win_close(win, false)
        end
    end

    local close_buffers = require("close_buffers")
    close_buffers.delete({ type = "nameless" })
end

function M.map(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
end

--- Get the region between two marks and the start and end positions for the region
---
--@param mark1 Name of mark starting the region
--@param mark2 Name of mark ending the region
--@param options Table containing the adjustment function, register type and selection mode
--@return region region between the two marks, as returned by |vim.region|
--@return start (row,col) tuple denoting the start of the region
--@return finish (row,col) tuple denoting the end of the region
local function get_marked_region(mark1, mark2, options)
    local bufnr = 0
    local adjust = options.adjust or function(pos1, pos2)
        return pos1, pos2
    end
    local regtype = options.regtype or vim.fn.visualmode()
    local selection = options.selection or (vim.o.selection ~= "exclusive")

    local pos1 = vim.fn.getpos(mark1)
    local pos2 = vim.fn.getpos(mark2)
    pos1, pos2 = adjust(pos1, pos2)

    local start = { pos1[2] - 1, pos1[3] - 1 + pos1[4] }
    local finish = { pos2[2] - 1, pos2[3] - 1 + pos2[4] }

    -- Return if start or finish are invalid
    if start[2] < 0 or finish[1] < start[1] then
        return
    end

    local region = vim.region(bufnr, start, finish, regtype, selection)
    return region, start, finish
end

--- Get the current visual selection as a string
---
--@return selection string containing the current visual selection
function M.get_visual_selection()
    local bufnr = 0
    local visual_modes = {
        v = true,
        V = true,
        -- [t'<C-v>'] = true, -- Visual block does not seem to be supported by vim.region
    }

    -- Return if not in visual mode
    if visual_modes[vim.api.nvim_get_mode().mode] == nil then
        return
    end

    local options = {}
    options.adjust = function(pos1, pos2)
        if vim.fn.visualmode() == "V" then
            pos1[3] = 1
            pos2[3] = 2 ^ 31 - 1
        end

        if pos1[2] > pos2[2] then
            pos2[3], pos1[3] = pos1[3], pos2[3]
            return pos2, pos1
        elseif pos1[2] == pos2[2] and pos1[3] > pos2[3] then
            return pos2, pos1
        else
            return pos1, pos2
        end
    end

    local region, start, finish = get_marked_region("v", ".", options)

    -- Compute the number of chars to get from the first line,
    -- because vim.region returns -1 as the ending col if the
    -- end of the line is included in the selection
    local lines = vim.api.nvim_buf_get_lines(bufnr, start[1], finish[1] + 1, false)
    local line1_end
    if region[start[1]][2] - region[start[1]][1] < 0 then
        line1_end = #lines[1] - region[start[1]][1]
    else
        line1_end = region[start[1]][2] - region[start[1]][1]
    end

    lines[1] = vim.fn.strpart(lines[1], region[start[1]][1], line1_end, true)
    if start[1] ~= finish[1] then
        lines[#lines] = vim.fn.strpart(lines[#lines], region[finish[1]][1], region[finish[1]][2] - region[finish[1]][1])
    end
    return table.concat(lines)
end

-- 将字符串转换为驼峰命名
function M.camel_case(str)
    str = string.gsub(str, "^%l", string.upper)
    str = string.gsub(str, "_(%w)", function(c)
        return string.upper(c)
    end)
    return str
end

-- 将驼峰命名转换为下划线
function M.snake_case(str)
    str = string.gsub(str, "%u", function(c)
        return "_" .. string.lower(c)
    end)
    return string.sub(str, 2) -- 去掉开头的下划线
end

function M.select_convert_case()
    local str = M.get_visual_selection()
    if string.find(str, "_") == nil then
        return M.snake_case(str)
    end
    return M.camel_case(str)
end

function M.goto_right_window()
    -- 获取当前窗口 ID 和位置信息
    local current_win = vim.api.nvim_get_current_win()
    local current_pos = vim.api.nvim_win_get_position(current_win)

    -- 获取所有窗口列表
    local win_list = vim.api.nvim_list_wins()

    -- 遍历窗口列表，查找右边的窗口
    local right_win = nil
    for _, win in ipairs(win_list) do
        if win ~= current_win then
            local pos = vim.api.nvim_win_get_position(win)
            local width = vim.api.nvim_win_get_width(win)
            if pos[1] == current_pos[1] and pos[2] > current_pos[2] and pos[2] + width > current_pos[2] then
                right_win = win
                break
            end
        end
    end

    -- 切换到右边的窗口
    if right_win ~= nil then
        vim.api.nvim_set_current_win(right_win)
    end
end

function M.profile(flag)
    local profile_log = vim.fn.expand("~/.cache/nvim/profile.log")
    if flag then
        vim.cmd("profile start " .. profile_log)
        vim.cmd("profile func *")
        vim.cmd("profile file *")
    else
        vim.cmd("profile stop")
        vim.cmd("edit " .. profile_log)
    end
end

return M
