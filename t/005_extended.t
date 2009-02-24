# -*- perl -*-

# t/005_extended.t - check extended 

use strict;
use warnings;
no warnings qw(once);
use utf8;

use Test::More tests => 101017;

use DateTime::Locale::Catalog;
use DateTime::TimeZone;

use_ok( 'DateTime::Format::CLDR' );

#my $time_zone = DateTime::TimeZone->new( name => 'Z' );
my $time_zone = DateTime::TimeZone->new(name => 'Europe/Vienna');

warn('Running extended tests: This may take a couple of minutes');

foreach my $localeid (DateTime::Locale::Catalog::Locales) {
    next if $localeid->{id} eq 'root';
    next unless (grep { $localeid->{id} eq $_ } qw(ar en de fr es pt bg ru nl it es fi cs si sk ru ro uk mk hu lt hi eu dk no se));

    warn("Running tests for locale '$localeid->{id}'");

    my $locale = DateTime::Locale->load( $localeid->{id} );
    
    foreach my $pattern (qw(
        datetime_format_long 
        datetime_format_full 
        datetime_format_medium
        datetime_format_short)) {
            
        #warn("SET LOCALE: $localeid->{id} : $pattern : ".$locale->$pattern()); 
            
        my $dtf = DateTime::Format::CLDR->new(
            locale      => $locale,
            pattern     => $locale->$pattern(),
            time_zone   => $time_zone
        );   
        
        
        my $dt1 = DateTime->new(
            year    => 2000,
            month   => 1,
            day     => 1,
            hour    => 01,
            minute  => 14,
            locale  => $locale,
            time_zone=> $time_zone,
            nanosecond  => 0,
        );
        
        my $dt2 = DateTime->new(
            year    => 1998,
            month   => 1,
            day     => 1,
            hour    => 12,
            minute  => 13,
            locale  => $locale,
            time_zone=> $time_zone,
            nanosecond  => 0,
        );
        
        my $dt3 = DateTime->new(
            year    => 2008,
            month   => 1,
            day     => 1,
            hour    => 23,
            minute  => 59,
            locale  => $locale,
            time_zone=> $time_zone,
            nanosecond  => 0,
        );
        
        
        while ($dt3->year == 2008) {

            
            compare($dtf,$dt1);
            compare($dtf,$dt2);
            compare($dtf,$dt3);
            
            $dt1->add( days => 1 );
            $dt2->add( days => 1 );
            $dt3->add( days => 1 );
        }
    }
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