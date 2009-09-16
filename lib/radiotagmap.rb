# Author::    Claudio Baccigalupo
# Copyright:: Copyright (c) 2009 - see LICENSE file

# require 'rubygems'
require 'logger'
require 'yaml'
require 'nokogiri'
require 'yesradio'
require 'scrobbler'

module Radiotagmap

  RADIOTAGMAP_KML = "overlay.kml"
  
  @log = Logger.new(STDERR)
  @log.level = Logger::WARN
  @log.level = Logger::DEBUG  ### Only for debug purpose ###
  
  # Returns the index of the family of genres/tags that is currently 
  # most playing on the FM radios of a given U.S. state.
  #
  # == Parameters
  # [+state+] The 2-letters code of the U.S. state where to search
  # [+among+] Array of arrays of admitted genres/tags. Each sub-array indicates equivalent words.
  #           The result is the index of the most played family of genres/tags in this array.
  #
  # == Examples
  #     get_main_tag "CA", [['Rock', 'Indie Rock'], ['Country', 'Alt Country']]
  #--
  def self.get_tags_weight(state = "CA", among = [['Rock'], ['Country']])
    among = among.collect{|family| family.collect(&:downcase)}
    
    # stations = Yesradio::search_stations(:loc => state) 
    stations = Yesradio::search_stations(:match => ", #{state}")
    return if stations.nil?
    @log.debug "#{state} | #{stations.length} stations"

    threads = []
    for station in stations
      threads << Thread.new(station) do |st|
        Yesradio::get_station :name => st.name
      end
    end
    artists = threads.collect{|aThread| aThread.join.value.array_artist}.compact
    return if artists.nil?
    @log.debug "#{state} | #{artists.length} artists"
    @log.debug "#{state} | #{artists.join(' ')}"

    # The same function as above, but without threads, would be:
    # artists = stations.collect do |station| 
    #   Yesradio::get_station :name => station.name
    # end.collect(&:array_artist).compact
    # return if artists.nil?
    
    threads = []
    for artist in artists
      threads << Thread.new(artist) do |ar|
        ar_tags = Scrobbler::Artist.new(artist).top_tags.first(10).collect do |tag|
          tag.name.downcase
        end
        top_tag = (ar_tags & among.flatten).first
        among.collect {|family| family.include?(top_tag)}.index(true)
      end
    end
    tags = threads.collect{|aThread| aThread.join.value}
    return if tags.nil?
    @log.debug "#{state} | #{tags.length} tags"
    @log.debug "#{state} | #{tags.join(' ')}"

    # The same function as above, but without threads, would be:
    # tags = artists.collect do |artist| 
    #   ar_tags = Scrobbler::Artist.new(artist).top_tags.first(10).map do |tag|
    #     tag.name.downcase
    #   end
    #   top_tag = (ar_tags & among.flatten).first
    #   among.collect {|family| family.include?(top_tag)}.index(true)
    # end # .compact to remove other tags

    weights = (0...among.size).collect do |index|
      tags.select{|x| x == index}.size/tags.size.to_f
    end
  end


  # Returns the color with which to represent a U.S. state on a map
  # depending on the most played genre/tag in its FM radios.
  #
  # == Parameters
  # [+state+] The 2-letters code of the U.S. state where to search
  # [+among+] Array of arrays of admitted genres/tags. Each sub-array indicates equivalent words.
  #           The result is the index of the most played family of genres/tags in this array.
  #
  # == Examples
  #     get_map_color "CA", [['Rock', 'Indie Rock'], ['Country', 'Alt Country']]
  #--
  # TODO: Parametrize, allowing users to specify among and colors
  def self.get_map_color(weights = [0.5, 0.2])
    a = "aa"
    if weights.nil?
      a << "ffffff"
    else
      r = "%02x" % (255*weights[0]).round
      b = "%02x" % (255*weights[1]).round
      g = "%02x" % (255*(1-weights.sum)).round
      a << b << g << r
    end
  end

  # Update a KML file (or create if inexistent) with the overlays
  # of the U.S. states, colored according to the most played genres/tags
  # in their FM radios.
  #
  # == Parameters
  # [+among+] Array of arrays of admitted genres/tags. Each sub-array indicates equivalent words.
  #           The result is the index of the most played family of genres/tags in this array.
  # [+forever+] If true, the updating process continues forever
  #
  # == Examples
  #     update_kml
  #--
  def self.update_kml(among = [['Rock'], ['Country']], forever = false)
    states_coords = YAML.load_file('us_states_coords.yml')
    begin
      states_coords.each do |state, coords|
        color = get_map_color(get_tags_weight(state, among))
        @log.debug "#{state} | The new color is #{color}"

        if File.exists?(RADIOTAGMAP_KML)
          kml_file = File.open(RADIOTAGMAP_KML, 'r+')
          xml = Nokogiri::XML(kml_file)
          @log.debug "#{state} | KML map created"
        else
          kml_file = File.new(RADIOTAGMAP_KML, 'w')
          xml = create_kml(states_coords)
          @log.debug "#{state} | KML map loaded"
        end

        xml.xpath("kml/Document/Style[@id='#{state}']/PolyStyle/color").first.content = color
        @log.debug "#{state} | Color updated"
      
        kml_file.rewind
        kml_file.write(xml)
        kml_file.close
      end
      @log.info "Updated KML with all the states"
    end while forever  
  end
   
  private

  # Create a KML file with the overlays of the U.S. states and no colors
  #
  # == Parameters
  # [+state_coords+] An hash containing the coordinates of the border of each state
  #
  #--
  def self.create_kml(state_coords)
    basic_color = "33ffffff"
    xml = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
      xml.kml( "kmlns" => "http://earth.google.com/kml/2.0" ) do
        xml.Document {
          state_coords.each do |state, coords|
            xml.Style("id" => "#{state}") {
              xml.PolyStyle {
                xml.color(basic_color)
                xml.outline("0")
              }
            }
            xml.Placemark {
              # xml.name(state.name)
              xml.styleUrl("##{state}")
              xml.Polygon {
                xml.LinearRing {
                  xml.coordinates(coords)
                }
              }
            }
          end
        }
      end
    end
    xml.doc
  end
end
