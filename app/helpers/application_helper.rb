module ApplicationHelper
  def recent_articles
    Article.recent
  end

  def markdown(text)
    options = [:hard_wrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
    syntax_highlighter(Redcarpet.new(text, *options).to_html).html_safe
      
  end

  def syntax_highlighter(html)
    doc = Nokogiri::HTML(html)
    doc.search("//pre[@lang]").each do |pre|
      # pre.replace Albino.colorize(pre.text.rstrip, pre[:lang])
      pre.replace CodeRay.scan(pre.text.rstrip, pre[:lang]).div
    end
    doc.to_s
  end

  def title(page_title, show_title = true)
    content_for(:title) { h(page_title.to_s) }
    @show_title = show_title
  end

  def show_title?
    @show_title
  end
end
