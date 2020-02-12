defmodule HtmlImgApi.Engine do
  @tmp File.cwd!()
  @tmp_html "./tmp_input.html"
  @tmp_img_path "./tmp_imgs/"

  def conv_html_img(html) do
    @tmp_html
    |> File.write!(html, [:write])

    Porcelain.shell(
      "wkhtmltoimage #{@tmp_html} #{@tmp_img_path}#{DateTime.utc_now() |> DateTime.to_unix()}.png"
    )

    base_img =
      (@tmp_img_path <> "*.png")
      |> Path.wildcard()
      |> List.first()
      |> File.read!()
      |> :base64.encode()

    # delete_temp_files()
    {:ok, base_img}
  end

  defp delete_temp_files() do
    File.rm!(@tmp_html)

    (@tmp_img_path <> "*.png")
    |> Path.wildcard()
    |> List.first()
    |> case do
      nil -> :ok
      img_path -> File.rm!(img_path)
    end
  end
end
