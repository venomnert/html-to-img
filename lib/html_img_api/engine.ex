defmodule HtmlImgApi.Engine do
  require Logger

  # @root Application.app_dir(:html_img_api)
  @tmp "/tmp"
  # @tmp_html Path.join(@tmp, "tmp_input.html")
  @tmp_html "/tmp/tmp_input.html"

  def conv_html_img(html) do
    tmp_img = "/tmp/#{DateTime.utc_now() |> DateTime.to_unix()}.jpg"

    @tmp_html
    |> File.write!(html)
    |> case do
      :ok ->
        Porcelain.shell(
          "wkhtmltoimage --width 400 #{@tmp_html} #{tmp_img}"
        )

      _ ->
        {:error, "error creating tmp html file"}
    end

    Logger.info("Logging this text!")
    IO.inspect(File.exists?(@tmp_html), label: "FILE VALUE")

    base_img =
      tmp_img
      |> Path.wildcard()
      |> IO.inspect(label: "LIST")
      |> List.first()
      |> File.read!()
      |> :base64.encode()

    tmp_img
    |> delete_temp_files()

    {:ok, base_img}
  end

  defp delete_temp_files(tmp_img) do
    File.rm!(@tmp_html)

    tmp_img
    |> Path.wildcard()
    |> List.first()
    |> case do
      nil -> :ok
      img_path -> File.rm!(img_path)
    end
  end
end
