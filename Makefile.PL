use inc::Module::Install;
name     'Test-NoTabs',
license  'perl',
author   'Nick Gerakines <nick@socklabs.com>',
all_from 'lib/Test/NoTabs.pm',
requires 'Test::More';
requires 'Test::Builder';
requires 'File::Spec';
requires 'FindBin';
requires 'File::Find';
requires 'Test::Group';

WriteAll;

