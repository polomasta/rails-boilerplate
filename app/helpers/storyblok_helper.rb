module  StoryblokHelper
  require 'storyblok/richtext'

  def richtext(input)
    if input.nil?
      return ''
    end

    client = Storyblok::Client.new(
      cache_version: Time.now.to_i,
      token: ENV['STORYBLOK_TOKEN'],
      version: 'draft',
      component_resolver: ->(component, data) {
        "Placeholder for #{component}: #{data['text']}"
      }
    )

    renderer = Storyblok::Richtext::HtmlRenderer.new


    sanitize renderer.render(JSON.parse(JSON.generate(input)))
  end

  def markdown(input)
    sanitize Kramdown::Document.new(input).to_html
  end
end
