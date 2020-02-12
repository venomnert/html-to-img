defmodule HtmlImgApi.Engine do
  @root File.cwd!()
  @tmp_html Path.join(@root, "./tmp_input.html")

  def conv_html_img(html) do
    @tmp_html
    |> File.write!(html, [:write])

    IO.inspect(File.exists?(@tmp_html), label: "EXISTS")

    Porcelain.shell("wkhtmltoimage #{@tmp_html} #{DateTime.utc_now() |> DateTime.to_unix()}.png")

    base_img =
      (@root <> "/*.png")
      |> IO.inspect(label: "PATHING")
      |> Path.wildcard()
      |> IO.inspect(label: "LIST")
      |> List.first()
      |> File.read!()
      |> :base64.encode()

    delete_temp_files()
    {:ok, base_img}
  end

  defp delete_temp_files() do
    File.rm!(@tmp_html)

    (@root <> "/*.png")
    |> Path.wildcard()
    |> List.first()
    |> case do
      nil -> :ok
      img_path -> File.rm!(img_path)
    end
  end
end
