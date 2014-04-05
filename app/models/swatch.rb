class Swatch
  include ActiveModel::Model
  
  attr_accessor :id, :name, :color
  
  validates_presence_of :name, :color
  
  def self.all
    @swatches = []
    @data = JSON.parse(RestClient.get(self._base_url))
    @data.each do |_swatch|
      @swatches << Swatch.new(:id => _swatch['_id'], :name => _swatch['name'], :color => _swatch['color'])
    end
    @swatches
  end
  
  def self.create(params)
    @swatch = Swatch.new(:name => params[:name], :color => params[:color])
    RestClient.post(self._base_url, {:name => @swatch.name, :color => @swatch.color}.to_json)
    @swatch
  end
  
  def self.find(id)
    @data = JSON.parse(RestClient.get(self._base_url + "/#{id}"))
    @swatch = Swatch.new(:id => @data['_id'], :name => @data['name'], :color => @data['color'])
  end
  
  def self.update(id, params)
    @swatch = self.find(id)
    @swatch.name = params[:name]
    @swatch.color = params[:color]
    RestClient.put(self._base_url + "/#{id}", {:name => @swatch.name, :color => @swatch.color}.to_json)
    @swatch
  end
  
  def self.destroy(id)
    @swatch = self.find(id)
    RestClient.delete(self._base_url + "/#{id}")
    @swatch
  end
  
  private
  
  def self._base_url
    Rails.env.production? ? 'http://obscure-spire-1682.herokuapp.com/swatches' : 'http://swatches.dev/swatches'
  end
end