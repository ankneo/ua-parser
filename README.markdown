ua-parser [![Build Status](https://secure.travis-ci.org/tobie/ua-parser.png?branch=master)](https://travis-ci.org/tobie/ua-parser)
=========

`ua-parser` is a multi-language port of [BrowserScope][1]'s [user agent string parser][2].

The crux of the original parser--the data collected by [Steve Souders][3] over the years--has been extracted into a separate [YAML file][4] so as to be reusable _as is_ by implementations in other programming languages.

`ua-parser` is just a small wrapper around this data.

Maintainers
-----------

* PHP: [Dave Olsen](https://github.com/dmolsen) ([@dmolsen](https://twitter.com/dmolsen))
* `regexes.yaml`: Lindsey Simon & Tobie Langel

irc channel
-----------

[#ua-parser on freenode](irc://chat.freenode.net#ua-parse).

Contributing Changes to regexes.yaml
------------------------------------

Please read the [contributors' guide](https://github.com/tobie/ua-parser/blob/master/CONTRIBUTING.md)

Other ua-parser Libraries
-------------------------

There are a few other libraries which make use of ua-parser's patterns. These include:



Usage :: php
------------

```php
require("uaparser.php");

$ua = "Mozilla/5.0 (Macintosh; Intel Ma...";

$parser = new UAParser;
$result = $parser->parse($ua);

print $result->ua->family;                // Safari
print $result->ua->major;                 // 6
print $result->ua->minor;                 // 0
print $result->ua->patch;                 // 2
print $result->ua->toString;              // Safari 6.0.2
print $result->ua->toVersionString;       // 6.0.2

print $result->os->family;                // Mac OS X
print $result->os->major;                 // 10
print $result->os->minor;                 // 7
print $result->os->patch;                 // 5
print $result->os->patch_minor;           // [null]
print $result->os->toString;              // Mac OS X 10.7.5
print $result->os->toVersionString;       // 10.7.5

print $result->device->family;            // Other

print $result->toFullString;              // Safari 6.0.2/Mac OS X 10.7.5
print $result->uaOriginal;                // Mozilla/5.0 (Macintosh; Intel Ma...
```

[More information is available in the README](https://github.com/tobie/ua-parser/tree/master/php) in the PHP directory


License
-------

The data contained in `regexes.yaml` is Copyright 2009 Google Inc. and available under the [Apache License, Version 2.0][5].

The PHP port is Copyright (c) 2011-2012 Dave Olsen and is available under the [MIT license][6].

[1]: http://www.browserscope.org
[2]: http://code.google.com/p/ua-parser/
[3]: http://stevesouders.com/
[4]: https://raw.github.com/tobie/ua-parser/master/regexes.yaml
[5]: http://www.apache.org/licenses/LICENSE-2.0
[6]: https://raw.github.com/tobie/ua-parser/master/php/LICENSE
