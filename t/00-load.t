#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Test::NoTabs' );
}

diag( "Testing Test::NoTabs $Test::NoTabs::VERSION, Perl $], $^X" );
