# -*- perl -*-

# t/006_exceptions.t - check exceptions

use strict;
use warnings;
no warnings qw(once);

use Test::More tests => 6;
use Test::Exception;

use DateTime::Format::CLDR;

my $cldr = DateTime::Format::CLDR->new();

throws_ok { 
    $cldr->locale('xx');
} qr/Invalid locale name or id: xx/;

throws_ok { 
    $cldr->time_zone('+9999');
} qr/Invalid offset: \+9999/;

throws_ok { 
    $cldr->time_zone('Europe/Absurdistan');
} qr/The timezone 'Europe\/Absurdistan' could not be loaded, or is an invalid name/;

my $datetime;

$datetime = $cldr->parse_datetime('HASE');

is($datetime,undef);

$datetime = $cldr->parse_datetime('Jun 31 , 2008');

is($datetime,undef);

$datetime = $cldr->parse_datetime('Xer 12 , 2008');

is($datetime,undef);

