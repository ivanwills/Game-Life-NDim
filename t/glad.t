#!/usr/bin/perl

BEGIN { $ENV{TESTING} = 1 }

use strict;
use warnings;
use Test::More tests => 8 + 1;
use Test::NoWarnings;
use Data::Dumper qw/Dumper/;

use Game::Life::Adv::Dim;

my $max = [1,1,2];
my $dim = Game::Life::Adv::Dim->new([@$max]);

is_deeply($dim->zero->elements, [0, 0, 0], 'Zeros corectly');
$dim = Game::Life::Adv::Dim->new(max => $max);
is_deeply($dim->elements, [0, 0, 0], 'Max Zeros corectly');

is_deeply($dim->increment($max)->elements, [0, 0, 1], 'basic increment');
is_deeply($dim->increment($max)->elements, [0, 0, 2], 'basic increment');
is_deeply($dim->increment($max)->elements, [0, 1, 0], 'flip level basic increment');
$dim->increment($max);
$dim->increment($max);
is_deeply($dim->increment($max)->elements, [1, 0, 0], 'flip level basic increment');
$dim->increment($max);
$dim->increment($max);
$dim->increment($max);
$dim->increment($max);
is_deeply($dim->increment($max)->elements, $max, 'now equal the $max');
is_deeply(scalar $dim->increment($max), undef, 'finish increment');

