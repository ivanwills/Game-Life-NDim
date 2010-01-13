package Game::Life::Adv::Life;

# Created on: 2010-01-04 18:54:13
# Create by:  Ivan Wills
# $Id$
# $Revision$, $HeadURL$, $Date$
# $Revision$, $Source$, $Date$

use Moose;
use warnings;
use version;
use Carp;
use Data::Dumper qw/Dumper/;
use English qw/ -no_match_vars /;

use overload '""' => \&to_string;

our $VERSION     = version->new('0.0.1');
our @EXPORT_OK   = qw//;
our %EXPORT_TAGS = ();
#our @EXPORT      = qw//;

has type => (
	is      => 'rw',
	isa     => 'Str',
	default => 0,
);

has board => (
	is       => 'rw',
	isa      => 'Game::Life::Adv::Board',
	required => 1,
	weak_ref => 1,
);

has position => (
	is  => 'rw',
	isa => 'Game::Life::Adv::Dim',
	required => 1,
);

sub seed {
	my ($self, $types) = @_;
	my $new_type;

	TYPE:
	while (!defined $new_type) {
		for my $type (keys %{$types}) {
			if ( rand() < $types->{$type} ) {
				$new_type = $type;
				last TYPE;
			}
		}
	}

	$self->type($new_type);

	return $self;
}

sub process {
	my ($self, $rules) = @_;

	my $new_self = $self->clone;

	RULE:
	for my $rule (@{ $rules } ) {
		my $change = $rule->($self);
		next RULE if !defined $change;

		$new_self->type($change);
		last RULE;
	}

	return $new_self;
}

sub surround {
	my ($self, $level) = @_;
	my $max   = $self->board->dims;
	my $lives = [];
	my $cursor = $self->position->clone;

	$level ||= 1;

	for my $dim ( 0 .. @{ $max } - 1 ) {
		;
	}

	return $lives;
}

sub clone {
	my ($self) = @_;

	return __PACKAGE__->new(type => $self->type, board => $self->board, position => $self->position);
}

sub to_string {
	my ($self) = @_;

	return $self->type;
}

1;

__END__

=head1 NAME

Game::Life::Adv::Life - <One-line description of module's purpose>

=head1 VERSION

This documentation refers to Game::Life::Adv::Life version 0.1.


=head1 SYNOPSIS

   use Game::Life::Adv::Life;

   # Brief but working code example(s) here showing the most common usage(s)
   # This section will be as far as many users bother reading, so make it as
   # educational and exemplary as possible.


=head1 DESCRIPTION

A full description of the module and its features.

May include numerous subsections (i.e., =head2, =head3, etc.).


=head1 SUBROUTINES/METHODS

=head2 C<seed (  )>

=head2 C<process (  )>

=head2 C<surround (  )>

=head2 C<clone (  )>

=head2 C<to_string (  )>


=head1 DIAGNOSTICS

A list of every error and warning message that the module can generate (even
the ones that will "never happen"), with a full explanation of each problem,
one or more likely causes, and any suggested remedies.

=head1 CONFIGURATION AND ENVIRONMENT

A full explanation of any configuration system(s) used by the module, including
the names and locations of any configuration files, and the meaning of any
environment variables or properties that can be set. These descriptions must
also include details of any configuration language used.

=head1 DEPENDENCIES

A list of all of the other modules that this module relies upon, including any
restrictions on versions, and an indication of whether these required modules
are part of the standard Perl distribution, part of the module's distribution,
or must be installed separately.

=head1 INCOMPATIBILITIES

A list of any modules that this module cannot be used in conjunction with.
This may be due to name conflicts in the interface, or competition for system
or program resources, or due to internal limitations of Perl (for example, many
modules that use source code filters are mutually incompatible).

=head1 BUGS AND LIMITATIONS

A list of known problems with the module, together with some indication of
whether they are likely to be fixed in an upcoming release.

Also, a list of restrictions on the features the module does provide: data types
that cannot be handled, performance issues and the circumstances in which they
may arise, practical limitations on the size of data sets, special cases that
are not (yet) handled, etc.

The initial template usually just has:

There are no known bugs in this module.

Please report problems to Ivan Wills (ivan.wills@gmail.com).

Patches are welcome.

=head1 AUTHOR

Ivan Wills - (ivan.wills@gmail.com)
<Author name(s)>  (<contact address>)

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2010 Ivan Wills (14 Mullion Close, Hornsby Heights, NSW Australia 2077).
All rights reserved.

This module is free software; you can redistribute it and/or modify it under
the same terms as Perl itself. See L<perlartistic>.  This program is
distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.

=cut
