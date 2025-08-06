local M = {}

M.api_key = nil
-- M.model = "meta-llama/llama-4-maverick"
M.model = "moonshotai/kimi-k2"

function M.setup(opts)
  M.api_key = opts.api_key
  if opts.model then
    M.model = opts.model
  end
end

function M.ask_openrouter()
  if not M.api_key then
    print("OpenRouter API key not configured. Please run :lua require('openrouter').setup{api_key='YOUR_API_KEY'}")
    return
  end

  local prompt = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")

  local data = {
    model = M.model,
    messages = {
      { role = "user", content = prompt }
    }
  }
  local json_data = vim.fn.json_encode(data)

  local command = {
    "curl",
    "-s",
    "-X", "POST",
    "-H", "Authorization: Bearer " .. M.api_key,
    "-H", "Content-Type: application/json",
    "-d", json_data,
    "https://openrouter.ai/api/v1/chat/completions",
  }

  local response_chunks = {}

  vim.fn.jobstart(command, {
    on_stdout = function(_, data)
      if data then
        for _, chunk in ipairs(data) do
          table.insert(response_chunks, chunk)
        end
      end
    end,
    on_stderr = function(_, data)
      if data and #data > 0 and data[1] ~= "" then
        print("Error calling OpenRouter API: " .. table.concat(data, "\n"))
      end
    end,
    on_exit = function(_, exit_code)
      if exit_code ~= 0 then
        print("OpenRouter API call failed with exit code: " .. exit_code)
        return
      end

      local full_response_str = table.concat(response_chunks)

      if full_response_str == "" or full_response_str:match("^%s*$") then
        print("Error: Received empty response from OpenRouter API")
        return
      end

      local ok, response = pcall(vim.fn.json_decode, full_response_str)
      if not ok then
        print("Error: Failed to decode JSON response from OpenRouter API.")
        return
      end

      if response and response.choices and response.choices[1] and response.choices[1].message and response.choices[1].message.content then
        local text = response.choices[1].message.content
        local lines = vim.split(text, "\n")
        local replacement = {"", "---", "OpenRouter ("..M.model.."):", ""}
        vim.list_extend(replacement, lines)
        vim.api.nvim_buf_set_lines(0, -1, -1, false, replacement)
      else
        print("Error: Invalid response structure from OpenRouter API")
        if response and response.error then
          print("API Error: " .. response.error.message)
        end
      end
    end,
  })
end

return M
