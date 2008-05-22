use strict;

use Test::NoTabs;

use File::Temp qw( tempdir tempfile );

all_perl_files_ok();

notabs_ok( $0, "$0 is tab free" );

my $tabbed_file1 = make_tabbed_file1();
notabs_ok( $tabbed_file1 );

my $tabbed_file2 = make_tabbed_file2();
notabs_ok( $tabbed_file2 );

my $tabbed_file3 = make_tabbed_file3();
notabs_ok( $tabbed_file3 );


sub make_tabbed_file1 {
  my $tmpdir = tempdir();
  my ($fh, $filename) = tempfile( DIR => $tmpdir, SUFFIX => '.pL' );
  print $fh <<'DUMMY';
#!/usr/bin/perl -w

=pod

=head1 NAME

This test script doesn't do anything.

=cut

sub main {
    my ($name) = @_;
    print "Hello $name!\n";
}

DUMMY
  return $filename;
}

sub make_tabbed_file2 {
  my $tmpdir = tempdir();
  my ($fh, $filename) = tempfile( DIR => $tmpdir, SUFFIX => '.pL' );
  print $fh <<'DUMMY';
#!/usr/bin/perl -w

=pod

=head1 NAME

This test script doesn't do anything.

	Its OK to have tabs in pod

=cut

sub main {
    my ($name) = @_;
    print "Hello $name!\n";
}

DUMMY
  return $filename;
}

sub make_tabbed_file3 {
  my $tmpdir = tempdir();
  my ($fh, $filename) = tempfile( DIR => $tmpdir, SUFFIX => '.pm' );
  print $fh <<'DUMMY';
package My::Test;

use strict;
use warnings;

sub new {
    my ($class) = @_;
    my $self = bless {}, $class;
    return $self;
}

1;
__END__
	I can have tabs here too!
DUMMY
  return $filename;
}
