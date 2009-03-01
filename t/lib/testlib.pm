package testlib;

use Test::More;

sub compare {
    my $dtf = shift;
    my $dt = shift;

    my $dts = $dtf->format_datetime($dt);
 
    my $dtc = $dtf->parse_datetime($dts);
    
    #use Data::Dumper;
    
    my $timezone = $dt->time_zone;  
    my $locale = $dt->locale->id;
      
    unless($dtc && ref $dtc && $dtc->isa('DateTime')) {
        
        fail(join ("\n",
            "Pattern: '$dtf->{pattern}'",
            "String: '$dts'",
            "Original: '$dt$timezone'",
            "Computed: UNDEF",
            "Locale: '$locale'"
            #,"Pattern: ". Dumper $dtf->{_built_pattern}
            )
        );   
         
        return;
    }
    
    unless ( DateTime->compare_ignore_floating( $dtc, $dt ) == 0) {
        
        fail(join ("\n",
            "Pattern: '$dtf->{pattern}'",
            "String: '$dts'",
            "Original: '$dt$timezone'",
            "Computed: '$dtc".$dtc->time_zone."'",
            "Locale: '$locale'",
            #,"Pattern: ". Dumper $dtf->{_built_pattern}
            )
        );
    }  else {
        ok('Successfully compared datetime');
    }
    #is($dtc->iso8601,$dt->iso8601);

    return;
}

1;