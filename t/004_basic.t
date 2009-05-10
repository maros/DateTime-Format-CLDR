# -*- perl -*-

# t/004_basic.t - check basic stuff

use strict;
use warnings;
no warnings qw(once);

use Test::More tests => 14;
use Test::NoWarnings;

use_ok( 'DateTime::Format::CLDR' );

my $cldr = DateTime::Format::CLDR->new(
    locale  => 'de_AT',
);

isa_ok($cldr,'DateTime::Format::CLDR');
isa_ok($cldr->locale,'DateTime::Locale::de_AT');
isa_ok($cldr->time_zone,'DateTime::TimeZone::Floating');

$cldr->time_zone(DateTime::TimeZone::UTC->new);

isa_ok($cldr->time_zone,'DateTime::TimeZone::UTC','Timezone has been set');

$cldr->locale(DateTime::Locale->load( 'de_DE' ));

isa_ok($cldr->locale,'DateTime::Locale::de_DE','Locale has been set');

is($cldr->pattern,'dd.MM.yyyy');

my $datetime = $cldr->parse_datetime('22.11.2011');

isa_ok($datetime,'DateTime');
is($datetime->dmy,'22-11-2011','String has been parsed');
isa_ok($datetime->time_zone,'DateTime::TimeZone::UTC','String has correct timezone');
isa_ok($datetime->locale,'DateTime::Locale::de_DE','String has correct locale');

$cldr->pattern('dd.MMMM.yyyy');

is($cldr->pattern,'dd.MMMM.yyyy','Pattern has been set');

my $datetime2 = $cldr->parse_datetime('22.November.2011');

is($cldr->format_datetime(DateTime->new( year => 2011, day => 22, month => 11)),'22.November.2011','Formating works');