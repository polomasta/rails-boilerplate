require 'storyblok/richtext'

module  StoryblokHelper

  def richtext(input)
    if input.nil?
      return ''
    end

    client = Storyblok::Client.new(
      cache_version: Time.now.to_i,
      token: 'DqUuzZizfjaQuajF37yhhwtt',
      version: 'draft'
    )

    renderer = Storyblok::Richtext::HtmlRenderer.new

    sanitize renderer.render(JSON.parse(open_struct_to_hash(input).to_json))
  end

  def markdown(input)
    sanitize Kramdown::Document.new(input).to_html
  end

  def open_struct_to_hash(object, hash = {})
    object.each_pair do |key, value|
      hash[key] = case value
                    when OpenStruct then open_struct_to_hash(value)
                    when Array then value.map { |v| open_struct_to_hash(v) }
                    else value
                  end
    end
    hash
  end
end
