#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Game::Life::Adv' );
}

diag( "Testing Game::Life::Adv $Game::Life::Adv::VERSION, Perl $], $^X" );
