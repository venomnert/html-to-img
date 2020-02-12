defmodule HtmlImgApiWeb.Router do
  use HtmlImgApiWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", HtmlImgApiWeb do
    pipe_through(:api)

    post("/html-img", ConverterController, :convert_html_to_img)
  end
end
