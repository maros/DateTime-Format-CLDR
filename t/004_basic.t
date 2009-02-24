# -*- perl -*-

# t/004_basic.t - check basic stuff

use strict;
use warnings;
no warnings qw(once);

use Test::More tests => 10;
use Test::NoWarnings;

use_ok( 'DateTime::Format::CLDR' );

my $cldr = DateTime::Format::CLDR->new(
    locale  => 'de_AT',
);

isa_ok($cldr,'DateTime::Format::CLDR');
isa_ok($cldr->locale,'DateTime::Locale::de_AT');
isa_ok($cldr->time_zone,'DateTime::TimeZone::Floating');

$cldr->time_zone(DateTime::TimeZone::UTC->new);

isa_ok($cldr->time_zone,'DateTime::TimeZone::UTC');

$cldr->locale(DateTime::Locale->load( 'de_DE' ));

isa_ok($cldr->locale,'DateTime::Locale::de_DE');

is($cldr->pattern,'dd.MM.yyyy');

my $datetime = $cldr->parse_datetime('22.11.2011');

isa_ok($datetime,'DateTime');
is($datetime->dmy,'22-11-2011');