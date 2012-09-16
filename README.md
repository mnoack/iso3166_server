Iso3166
=======

An application to provide 2 global APIs for use in client apps:
* /countries maps to a list of iso-3166-1 country code and names
* /subdivisions/:name maps to a list of iso-3166-2 subdivision (state/province/territory) code, name and country code's

Contributing
============
Contributions are very welcome.

Acknowledgements/Sources
========================
Debian iso-codes package:
http://pkg-isocodes.alioth.debian.org/

Usage
=====
Import the database schema and load the data via:
```ruby
rake db:setup
rackup
```

Requirements
============
You either need to iso-codes package installed in Debian/Ubuntu or it will download it from:

http://anonscm.debian.org/gitweb/?p=iso-codes/iso-codes.git;a=blob_plain;f=iso_3166/iso_3166.xml;hb=HEAD
http://anonscm.debian.org/gitweb/?p=iso-codes/iso-codes.git;a=blob_plain;f=iso_3166_2/iso_3166_2.xml;hb=HEAD

Licence
=======
This project itself is just the standard MIT license, but for data has it own licenses.

The iso-3166 data comes from the debian iso-codes software packages and thus is
likely GPL or GPL compatible.
