# Load the Module::Install bundled in ./inc/
use strict;
use inc::Module::Install;

# Define metadata
name            'DateTime-Format-CLDR';
all_from        'lib/DateTime/Format/CLDR.pm';

perl_version    '5.008';

# Specific dependencies
requires        'DateTime'                  => '0.44';
requires        'Params::Validate'          => 0;
requires        'DateTime::TimeZone'        => 0;
requires        'DateTime::Locale'          => '0.42';
requires        'DateTime::Incomplete'      => 0;

build_requires  'Exporter'                  => 0;
build_requires  'Test::Pod'                 => 0;
build_requires  'Test::Pod::Coverage'       => 0;
build_requires  'Test::Exception'           => 0;

WriteAll;
