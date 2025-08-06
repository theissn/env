local M = {}

M.api_key = nil

function M.setup(opts)
  M.api_key = opts.api_key
end

function M.ask_gemini()
  if not M.api_key then
    print("Gemini API key not configured. Please run :lua require('gemini').setup{api_key='YOUR_API_KEY'}")
    return
  end

  local prompt = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
  local command = {
    "curl",
    "-s",
    "-X",
    "POST",
    "-H",
    "Content-Type: application/json",
    "-d",
    string.format('{"contents":[{"parts":[{"text":%q}]}]}', prompt),
    "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-pro-latest:generateContent?key=" .. M.api_key,
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
        print("Error calling Gemini API: " .. table.concat(data, "\n"))
      end
    end,
    on_exit = function(_, exit_code)
      if exit_code ~= 0 then
        print("Gemini API call failed with exit code: " .. exit_code)
        return
      end

      local full_response_str = table.concat(response_chunks)

      if full_response_str == "" or full_response_str:match("^%s*$") then
        print("Error: Received empty response from Gemini API")
        return
      end

      local ok, response = pcall(vim.fn.json_decode, full_response_str)
      if not ok then
        print("Error: Failed to decode JSON response from Gemini API.")
        return
      end

      if response and response.candidates and response.candidates[1] and response.candidates[1].content and response.candidates[1].
content.parts and response.candidates[1].content.parts[1] and response.candidates[1].content.parts[1].text then
        local text = response.candidates[1].content.parts[1].text
        local lines = vim.split(text, "\n")
        local replacement = {"", "---", "Gemini Response:", ""}
        vim.list_extend(replacement, lines)
        vim.api.nvim_buf_set_lines(0, -1, -1, false, replacement)
      else
        print("Error: Invalid response structure from Gemini API")
        if response and response.error then
          print("API Error: " .. response.error.message)
        end
      end
    end,
  })
end

return M
