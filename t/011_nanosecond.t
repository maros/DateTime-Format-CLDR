# -*- perl -*-

# t/011_nanosecond.t - nanosecond parsing

use strict;
use warnings;
no warnings qw(once);

use Test::More tests => 1 + (9 * 2) +2;
use Test::NoWarnings;

use lib qw(t/lib);
use testlib;

use DateTime::Format::CLDR;

explain("This test might fail on some plattforms due to unknown reasons");

my $dtf1 = DateTime::Format::CLDR->new(
    locale      => 'en_US',
    pattern     => 'dd.MM.yyy HH:mm:ss.SSSSSSSSS',
);

my $dtf2 = DateTime::Format::CLDR->new(
    locale      => 'en_US',
    pattern     => 'dd.MM.yyy HH:mm:ss.SSSSSSSSSSSS',
);

my $dtf3 = DateTime::Format::CLDR->new(
    locale      => 'en_US',
    pattern     => 'dd.MM.yyy HH:mm:ss.SS',
);

for my $count (0..8) {
    my $nano = 10 ** $count;
    
    my $dt = DateTime->new({
        year        => 2000,
        month       => 1,
        day         => 1,
        hour        => $count,
        minute      => 10,
        second      => 20,
        nanosecond  => $nano,
    });
    
    testlib::compare($dtf1,$dt);
    testlib::compare($dtf2,$dt);
    testlib::compare($dtf3,$dt)
        if $count >= 7;
}





    
 
    