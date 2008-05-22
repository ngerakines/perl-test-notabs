use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Test::NoTabs',
    license             => 'perl',
    dist_author         => 'Nick Gerakines <nick@socklabs.com>',
    dist_version_from   => 'lib/Test/NoTabs.pm',
    requires => {
        'Test::More' => 0,
        'Test::Builder' => 0,
        'File::Spec' => 0,
        'FindBin' => 0,
        'File::Find' => 0,
    },
    add_to_cleanup      => [ 'Test-NoTabs-*' ],
);

$builder->create_build_script();
