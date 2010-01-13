#!/usr/bin/perl

BEGIN { $ENV{TESTING} = 1 }

use strict;
use warnings;
use Test::More tests => 2 + 1;
use Test::NoWarnings;

use Game::Life::Adv::Board;

my $board = Game::Life::Adv::Board->new( dims => Game::Life::Adv::Dim->new([1,1]) );

stringify();
looping();

sub looping {
	my $count = 0;
	$board->reset;

	$count++ while (ref $board->next_life);

	is($count, 4, "2 x 2 board has 4 lives");
}

sub stringify {
	is("$board", "0 0\n0 0\n", "Stringify");
}
