package Game::Life::Adv;

# Created on: 2010-01-04 18:52:01
# Create by:  Ivan Wills
# $Id$
# $Revision$, $HeadURL$, $Date$
# $Revision$, $Source$, $Date$

use Moose;
use warnings;
use version;
use Carp;
use Scalar::Util;
use List::Util;
#use List::MoreUtils;
use Data::Dumper qw/Dumper/;
use English qw/ -no_match_vars /;
use Game::Life::Adv::Board;

use overload '""' => \&to_string;

our $VERSION     = version->new('0.0.1');
our @EXPORT_OK   = qw/game_of_life/;
our %EXPORT_TAGS = ();

has board => (
	is       => 'rw',
	isa      => 'Game::Life::Adv::Board',
	required => 1,
);

has rules => (
	is       => 'rw',
	isa      => 'ArrayRef',
	default  => sub {[]},
);

sub game_of_life {
	my %params = @_;

	my $board = Game::Life::Adv::Board->new(%params);
	my %new = (board => $board);
	$new{types} = $params{types} if $params{types};

	return __PACKAGE__->new(%new);
}

sub add_rule {
	my ($self, $sub, %rule) = @_ == 1 ? @_ : (shift @_, undef, @_);

	if ( defined $sub ) {
		push @{ $self->rules }, $sub;
	}
	else {
		for my $rule (keys %rule) {
			push @{ $self->rules },
				  $rule eq 'live' ? sub { sum $_[0]->surround > $rule{$rule} ? 1 : undef }
				: $rule eq 'die'  ? sub { sum $_[0]->surround < $rule{$rule} ? 0 : undef }
				:                   die "The rule "$rule" is unknown\n";
	}

	return $self;
}

sub process {
	my ($self) = @_;

	while ( my $life = $self->board->next_life() ) {
		my $new = $life->process($self->rules);
		$self->board->set_life($new);
	}

	return $self;
}

sub to_string {
	my ($self) = @_;

	return $self->board->to_string();
}

1;

__END__

=head1 NAME

Game::Life::Adv - Infrastructure for playing Conway's game of life with
support for multiple cell types and 2D or 3D boards.

=head1 VERSION

This documentation refers to Game::Life::Adv version 0.1.

=head1 SYNOPSIS

   use Game::Life::Adv;

   # Brief but working code example(s) here showing the most common usage(s)
   # This section will be as far as many users bother reading, so make it as
   # educational and exemplary as possible.


=head1 DESCRIPTION

TODO

=head1 SUBROUTINES/METHODS

=head1 DIAGNOSTICS

=head1 CONFIGURATION AND ENVIRONMENT

=head1 DEPENDENCIES

=head1 INCOMPATIBILITIES

=head1 BUGS AND LIMITATIONS

There are no known bugs in this module.

Please report problems to Ivan Wills (ivan.wills@gmail.com).

Patches are welcome.

=head1 AUTHOR

Ivan Wills - (ivan.wills@gmail.com)

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2010 Ivan Wills (14 Mullion Close, Hornsby Heights, NSW Australia 2077).
All rights reserved.

This module is free software; you can redistribute it and/or modify it under
the same terms as Perl itself. See L<perlartistic>.  This program is
distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.

=cut
