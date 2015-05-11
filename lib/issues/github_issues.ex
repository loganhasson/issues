defmodule Issues.GithubIssues do
  @user_agent [ {"User-agent", "Elixir logan.hasson@gmail.com"} ]

  def fetch(user, project) do
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end
  def issues_url(user, project) do
    "https://api.github.com/repos/#{user}/#{project}/issues"
  end
  def handle_response({:ok, %HTTPoison.Response{body: body, headers: headers, status_code: 200}}), do: { :ok, body }
  def handle_response({:ok, %HTTPoison.Response{body: body, headers: headers, status_code: ___}}), do: { :error, body }
  def handle_response({:error, %HTTPoison.Response{body: body, headers: headers, status_code: ___}}), do: { :error, body }
end
