use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
	module_name       => 'Game::Life::Adv',
	license           => 'perl',
	dist_author       => q{Ivan Wills <ivan.wills@gmail.com>},
	dist_version_from => 'lib/Game/Life/Adv.pm',
	requires          => {
		'perl'           => 5.010,
		'Moose'          => 0,
		'Params::Coerce' => 0,
	},
	build_requires => {
		'Test::More'       => 0,
		'Test::NoWarnings' => 0,
	},
	add_to_cleanup     => [ 'Game-Life-Adv-*' ],
	create_makefile_pl => 'traditional',
	create_license     => 1,
	meta_merge         => {
		resources => {
			repository => 'http://github.com/ivanwills/Game-Life-Adv',
			bugtracker => 'http://rt.cpan.org/NoAuth/Bugs.html?Dist=Game-Life-Adv',
		},
	},
);

$builder->create_build_script();
