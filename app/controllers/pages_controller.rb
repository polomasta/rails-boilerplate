class PagesController < ApplicationController
  def index
    response.headers['X-FRAME-OPTIONS'] = 'ALLOW-FROM https://app.storyblok.com/'

    client = Storyblok::Client.new(
      cache_version: Time.now.to_i,
      token: ENV['STORYBLOK_TOKEN'],
      version: 'draft'
    )

    @story = JSON.parse(client.story(params[:path].blank? ? '/home' : params[:path])['data']['story'].to_json, object_class: OpenStruct)
    @navigation = client.tree

    respond_to do |format|
      format.html
      format.json { render json: {message: "Hello, robot, I am Gig Wage."} }
    end
  end
end
