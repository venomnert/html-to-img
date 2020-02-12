defmodule HtmlImgApi.Engine do
  require Logger

  # @root Application.app_dir(:html_img_api)
  @tmp "/tmp"
  @tmp_html Path.join(@tmp, "tmp_input.html")

  def conv_html_img(html) do
    @tmp_html
    |> File.write!(html, [:write])
    |> case do
      :ok -> Porcelain.shell("wkhtmltoimage #{@tmp_html} #{@tmp}/#{DateTime.utc_now() |> DateTime.to_unix()}.png")
      _ -> {:error, "error creating tmp html file"}
    end

    Logger.info("Logging this text!")
    Logger.debug("Var value: #{inspect(File.exists?(@tmp_html))}")


    base_img =
      (@tmp <> "/*.png")
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

    (@tmp <> "/*.png")
    |> Path.wildcard()
    |> List.first()
    |> case do
      nil -> :ok
      img_path -> File.rm!(img_path)
    end
  end
end
