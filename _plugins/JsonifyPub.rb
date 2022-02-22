require 'nokogumbo'

module JsonifyPub

  def jsonify_pub(input)
    pub = {
      'id': input['slug'],
      'title': input['title'], 
      'year': input['year']
    }

    if input['stub'] then
      pub['caption'] = strip_html(input['teaser'])
      pub['abstract'] = strip_html(input['content'])
    else
      doc = Nokogiri::HTML5(input['content'])
      pub['caption'] = strip_html(doc.at_css('#teaser figcaption'))
      pub['abstract'] = strip_html(doc.at_css('#abstract p'))
    end
    escape(jsonify(pub))
  end
end

Liquid::Template.register_filter(JsonifyPub)
