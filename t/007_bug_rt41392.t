# -*- perl -*-

# t/007_bug_rt41392.t - check bug http://rt.cpan.org/Public/Bug/Display.html?id=41392

use strict;
use warnings;
no warnings qw(once);

use lib qw(t/);
use Test::More tests => 367;

use_ok( 'DateTime::Format::CLDR' );

my $dtf = DateTime::Format::CLDR->new(
    locale      => 'en_US',
    pattern     => 'yyyyMMddHH'
);

my $dt = DateTime->new(
    year    => 2008,
    month   => 1,
    day     => 1,
    hour    => 12,
    minute  => 0,
    locale  => 'en_US',
    nanosecond  => 0,
);

while ($dt->year == 2008) {
    compare($dtf,$dt);
    $dt->add( days => 1 );
}

sub compare {
    my $dtf = shift;
    my $dt = shift;

    my $dts = $dtf->format_datetime($dt);
 
    my $dtc = $dtf->parse_datetime($dts);
    
    unless($dtc && ref $dtc && $dtc->isa('DateTime')) {
        fail('Not a DateTime: '.$dts);
        return;
    }
    
    unless ( DateTime->compare_ignore_floating( $dtc, $dt ) == 0) {
        #.'::'.$dtc->nanosecond.'::'.$dtc->time_zone.'::'.$dtc->locale.
        fail('Pattern: "'.$dtf->{pattern}.'"; '.
            'String: "'.$dts.'"; '.
            'Original: '.$dt.$dt->time_zone.'; '.
            'Computed: '.$dtc.$dtc->time_zone.'; '.
            'Locale: '.$dt->locale->id);  
    }  else {
        ok('Successfully compared datetime');
    }
    #is($dtc->iso8601,$dt->iso8601);

    return;
}