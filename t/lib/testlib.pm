package testlib;

use Test::More;

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

1;