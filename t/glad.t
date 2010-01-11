#!/usr/bin/perl

BEGIN { $ENV{TESTING} = 1 }

use strict;
use warnings;
use Test::More tests => 6 + 1;
use Test::NoWarnings;

use Game::Life::Adv::Dim;

my $dim = Game::Life::Adv::Dim->new([0, 0, 0]);

is_deeply($dim->increment([1,1,2])->elements, [0, 0, 1], 'basic increment');
is_deeply($dim->increment([1,1,2])->elements, [0, 0, 2], 'basic increment');
is_deeply($dim->increment([1,1,2])->elements, [0, 1, 0], 'flip level basic increment');
$dim->increment([1,1,2]);
$dim->increment([1,1,2]);
is_deeply($dim->increment([1,1,2])->elements, [1, 0, 0], 'flip level basic increment');
$dim->increment([1,1,2]);
$dim->increment([1,1,2]);
$dim->increment([1,1,2]);
$dim->increment([1,1,2]);
is_deeply($dim->increment([1,1,2])->elements, [1, 1, 2], 'basic increment');
is_deeply($dim->increment([1,1,2]), undef , 'finish increment');

