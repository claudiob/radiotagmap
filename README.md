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

v0.0.5  2009/09/18
        Updated to require yesradio v0.1.2

v0.0.4  2009/09/17
        Added a parameter to specify the path to the KML file to create

v0.0.3  2009/09/17
        Moved state coords from an external YAML file to the same ruby file
        in order to avoid calling YAML.load which did not find the right path
        when run as a gem

v0.0.2  2009/09/17
        Added gem dependencies.

v0.0.1  2009/09/16
        First commit to compare two families of tags against the others.
        API calls are threaded. Needs more control and documentation.

## Copyright ##

Copyright (c) 2009 Claudio Baccigalupo. See LICENSE for details.
