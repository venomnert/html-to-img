defmodule HtmlImgApiWeb.ConverterController do
  use HtmlImgApiWeb, :controller
  require Logger
  alias HtmlImgApi.Engine

  def convert_html_to_img(conn, %{"body" => html}) do
    {:ok, data} = Engine.conv_html_img(html)

    conn
    |> Plug.Conn.put_resp_header("content-type", "application/json; charset=utf-8")
    |> Plug.Conn.send_resp(200, Jason.encode!(%{"ok" => data}))
  end
end
