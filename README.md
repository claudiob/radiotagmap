# RadioTagMap #

Ruby gem to map by U.S. state the music played on FM radios

## Installation ##

    sudo gem install claudiob-radiotagmap -s http://gems.github.com

## Documentation ##

[http://rdoc.info/projects/claudiob/radiotagmap](http://rdoc.info/projects/claudiob/radiotagmap)

## Examples ##

### To create a KML map according to compare current 'Rock' and 'Country' songs 

    require 'radiotagmap'
    Radiotagmap::update_kml [['Rock'], ['Country']]

## History ##

v0.0.1  2009/09/16
        First commit to compare two families of tags against the others.
        API calls are threaded. Needs more control and documentation.

## Copyright ##

Copyright (c) 2009 Claudio Baccigalupo. See LICENSE for details.
