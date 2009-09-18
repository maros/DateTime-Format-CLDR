# -*- perl -*-

# t/014_bug_rt49605.t - check bug http://rt.cpan.org/Public/Bug/Display.html?id=49605

use strict;
use warnings;
no warnings qw(once);

use lib qw(t/lib);
use testlib;

use Test::More tests => 2;
use Test::NoWarnings;

use DateTime;
use DateTime::Format::CLDR;


my $fc = DateTime::Format::CLDR->new(
    pattern     => 'dd.MM.yyyy HH:mm:ss',
    locale      => 'de_DE',
    time_zone   => 'Europe/Berlin',
);

my $dt = DateTime->now;
$dt->set_formatter($fc);

like("DateTime formatter '$dt'",qr/DateTime formatter '\d\d\.\d\d.\d{4} \d\d:\d\d:\d\d'/);