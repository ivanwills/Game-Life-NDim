use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Game::Life::Adv',
    license             => 'perl',
    dist_author         => q{Ivan Wills <ivan.wills@gmail.com>},
    dist_version_from   => 'lib/Game/Life/Adv.pm',
    build_requires => {
        'Test::More' => 0,
    },
    add_to_cleanup      => [ 'Game-Life-Adv-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
