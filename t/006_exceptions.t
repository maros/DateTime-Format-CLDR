# -*- perl -*-

# t/006_exceptions.t - check exceptions

use strict;
use warnings;
no warnings qw(once);

use Test::More tests => 12;
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
    $cldr->on_error('XXX');
} qr/The value supplied to on_error must be either/;

throws_ok { 
    $cldr->incomplete('XXX');
} qr/The value supplied to incomplete must be either/;

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


my $cldr2 = DateTime::Format::CLDR->new(
    on_error    => 'croak',
    locale      => 'de_AT'
);

throws_ok { 
    $cldr2->parse_datetime('HASE');
} qr/Could not get datetime for HASE/;


my $cldr3 = DateTime::Format::CLDR->new(
    on_error    => sub { die 'LAPIN' },
    locale      => 'de_AT'
);

throws_ok { 
    $cldr3->parse_datetime('HASE');
} qr/LAPIN/;


my $cldr4 = DateTime::Format::CLDR->new(
    on_error    => 'croak',
    pattern     => 'dd.MM.yyy',
    locale      => 'de_AT'
);

throws_ok { 
    $cldr4->parse_datetime('31.02.2009');
} qr/Could not get datetime for/;

throws_ok { 
    $cldr4->parse_datetime('37.44.2009');
} qr/Could not get datetime for/;
