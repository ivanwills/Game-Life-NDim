#!perl -T

use Test::More tests => 4;

BEGIN {
    use_ok( 'Game::Life::Adv' );
    use_ok( 'Game::Life::Adv::Dim' );
    use_ok( 'Game::Life::Adv::Board' );
    use_ok( 'Game::Life::Adv::Life' );
}

diag( "Testing Game::Life::Adv $Game::Life::Adv::VERSION, Perl $], $^X" );
