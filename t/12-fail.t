use strict;

use Test::More qw(no_plan);

use Test::Group;

use File::Temp qw( tempdir tempfile );

my $perl  = $^X || 'perl';
my $inc = join(' -I ', @INC) || '';
$inc = "-I $inc" if $inc;

test 'bad file 1' => sub {
    my $dir = make_bad_file_1();
    my ($fh, $outfile) = tempfile();
    ok( `$perl $inc -MTest::NoTabs -e "all_perl_files_ok( '$dir' )" 2>&1 > $outfile` );
    local $/ = undef;
    my $content = <$fh>;
    like( $content, qr/^not ok 1 - Found tabs in '[^']*' on line 4/m, 'tabs found in tmp file' );
};

test 'bad file 2' => sub {
    my $dir = make_bad_file_2();
    my ($fh, $outfile) = tempfile();
    ok( `$perl $inc -MTest::NoTabs -e "all_perl_files_ok( '$dir' )" 2>&1 > $outfile` );
    local $/ = undef;
    my $content = <$fh>;
    like( $content, qr/^not ok 1 - Found tabs in '[^']*' on line 12/m, 'tabs found in tmp file' );
};

test 'bad file 3' => sub {
    my $file = make_bad_file_3();
    my ($fh, $outfile) = tempfile();
    ok( `$perl $inc -MTest::NoTabs -e "all_perl_files_ok( '$file' )" 2>&1 > $outfile` );
    local $/ = undef;
    my $content = <$fh>;
    like( $content, qr/^not ok 1 - Found tabs in '[^']*' on line 6/m, 'tabs found in tmp file' );
};

sub make_bad_file_1 {
  my $tmpdir = tempdir();
  my ($fh, $filename) = tempfile( DIR => $tmpdir, SUFFIX => '.pL' );
  print $fh <<"DUMMY";
#!perl

sub main {
\tprint "Hello!\n";
}
DUMMY
  return $tmpdir;
}

sub make_bad_file_2 {
  my $tmpdir = tempdir();
  my ($fh, $filename) = tempfile( DIR => $tmpdir, SUFFIX => '.pL' );
  print $fh <<"DUMMY";
#!perl

=pod

=head1 NAME

test.pL -	A test script

=cut

sub main {
\tprint "Hello!\n";
}
DUMMY
  return $tmpdir;
}

sub make_bad_file_3 {
  my $tmpdir = tempdir();
  my ($fh, $filename) = tempfile( DIR => $tmpdir, SUFFIX => '.pm' );
  print $fh <<"DUMMY";
use strict;

package My::Test;

sub new {
\tmy (\$class) = @_;
\tmy \$self = bless { }, \$class;
\treturn \$self;
}

1;
__DATA__
nick	gerakines	software engineer	22
DUMMY
  return $filename;
}

