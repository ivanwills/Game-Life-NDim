package Game::Life::Adv::Dim;

# Created on: 2010-01-08 18:43:32
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

use overload
	'""'  => sub { '[' . ( join ',', @{ $_[0]->elements } ) . ']' },
	'@{}' => sub { $_[0]->elements };

our $VERSION     = version->new('0.0.1');
our @EXPORT_OK   = qw//;
our %EXPORT_TAGS = ();

has elements => (
	is       => 'rw',
	isa      => 'ArrayRef',
	required => 1,
);

has max => (
	is       => 'rw',
	isa      => 'ArrayRef[Int]',
	weak_ref => 1,
);

around new => sub {
	my ($new, $class, @args) = @_;

	if ( @args == 1 && ref $args[0] eq 'ARRAY' ) {
		@args = ( elements => $args[0] );
	}
	else {
		my %params = @args;
		if (!exists $params{elements} && exists $params{max}) {
			$params{elements} = [ @{ $params{max} } ];
			return $new->($class, %params)->zero;
		}
	}

	return $new->($class, @args);
};

sub increment {
	my ($self, $max) = @_;
	my $last;

	for my $i ( reverse 0 .. @{ $max } - 1 ) {
		die "max[$i] == 0 which is not allowed!" if $max->[$i] == 0;
		if ( $self->[$i] + 1 <= $max->[$i] ) {
			$self->[$i]++;
			$last = $i;
			last;
		}
		$self->[$i] = 0;
	}

	return undef if !defined $last;

	return $self;
}

sub clone {
	my ($self) = @_;

	return $self->new(elements => [ @{ $self } ]);
}

sub zero {
	my ($self) = @_;

	for my $item (@{ $self }) {
		$item = 0;
	}

	return $self;
}

1;

__END__

=head1 NAME

Game::Life::Adv::Dim - <One-line description of module's purpose>

=head1 VERSION

This documentation refers to Game::Life::Adv::Dim version 0.1.


=head1 SYNOPSIS

   use Game::Life::Adv::Dim;

   # Brief but working code example(s) here showing the most common usage(s)
   # This section will be as far as many users bother reading, so make it as
   # educational and exemplary as possible.


=head1 DESCRIPTION

A full description of the module and its features.

May include numerous subsections (i.e., =head2, =head3, etc.).


=head1 SUBROUTINES/METHODS

A separate section listing the public components of the module's interface.

These normally consist of either subroutines that may be exported, or methods
that may be called on objects belonging to the classes that the module
provides.

Name the section accordingly.

In an object-oriented module, this section should begin with a sentence (of the
form "An object of this class represents ...") to give the reader a high-level
context to help them understand the methods that are subsequently described.




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