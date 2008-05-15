use inc::Module::Install;

name           'Test-Tagged';
all_from       'lib/Test/Tagged.pm';

requires 'Test::Harness' => '3.0';

build_requires 'Test::More';

WriteAll;

