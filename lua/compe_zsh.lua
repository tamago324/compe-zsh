local compe = require'compe'
local Job = require 'plenary.job'

local Source = {}

function Source.new()
  local self = setmetatable({}, { __index = Source })
  self.capture = vim.api.nvim_eval([[expand('<sfile>:h:h:h') .. '/bin/compe_capture.zsh']])
  self.executable_zsh = vim.fn.executable('zsh')
  return self
end


-- デフォルトの設定を返す
function Source.get_metadata(self)
  return {
    priority = 100,
    dup = 0,
    menu = '[Zsh]',
    filetypes = {'zsh'},
  }
end


function Source.determine(self, context)
  -- return compe.helper.determine(context, {
  --   keyword_pattern = '\\S\\+$',
  -- })
  return compe.helper.determine(context)
end

function Source.documentation(self, args)
  if not args.completed_item.info then
    return args.abort()
  end
  args.callback(args.completed_item.info)
end

function Source.complete(self, args)
  if not self.executable_zsh then
    return args.abort()
  end
  self:collect(args.context.before_line, args.callback)
end

function Source.collect(self, input, callback)
  local results = {}
  local job = Job:new {
    command = 'zsh',
    args = {self.capture, input},
    cwd = vim.fn.getcwd(),
    on_stdout = function(_, data)
      local pieces = vim.split(data, ' -- ', true)
      if #pieces > 1 then
        table.insert(results, {word = pieces[1], info = pieces[2]})
      else
        table.insert(results, {word = pieces[1]})
      end
    end,
    on_exit = function(_, _, _)
      vim.schedule(function()
        callback({
          items = results,
          incomplete = true,
        })
      end)
    end
  }

  job:start()
  return results
end

return Source.new()
