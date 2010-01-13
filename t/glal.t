#!/usr/bin/perl

BEGIN { $ENV{TESTING} = 1 }

use strict;
use warnings;
use Test::More tests => 2 + 1;
use Test::NoWarnings;

use Game::Life::Adv;
use Game::Life::Adv::Dim;

my $gof = Game::Life::Adv::game_of_life(dims => [2, 2], rand => 1);
my $life = Game::Life::Adv::Life->new( board => $gof->board, type => 0, position => Game::Life::Adv::Dim->new([0,0]) );

is($life->type, 0, 'Type is 0');
is("$life", 0, 'Stringified is 0');


