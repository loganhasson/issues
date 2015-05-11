defmodule Issues.GithubIssues do
  @user_agent [ {"User-agent", "Elixir logan.hasson@gmail.com"} ]
  @github_url Application.get_env(:issues, :github_url)

  def fetch(user, project) do
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def handle_response({:ok, %HTTPoison.Response{body: body, headers: headers, status_code: 200}}) do
    { :ok, :jsx.decode(body) }
  end
  def handle_response({:ok, %HTTPoison.Response{body: body, headers: headers, status_code: ___}}) do
    { :error, :jsx.decode(body) }
  end
  def handle_response({:error, %HTTPoison.Response{body: body, headers: headers, status_code: ___}}) do
    { :error, :jsx.decode(body) }
  end
end
