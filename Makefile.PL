use ExtUtils::MakeMaker;

WriteMakefile
  NAME => "cpan2rpm",
  AUTHOR => 'Erick Calder <ecalder@cpan.org>',
  VERSION_FROM => "cpan2rpm",
  ABSTRACT_FROM => "cpan2rpm",
  EXE_FILES => [ "cpan2rpm" ],
  PREREQ_PM => { # e.g., Module::Name => 1.1
    'ExtUtils::MakeMaker' => 5.45,
    'LWP::UserAgent' => 0,
    'HTTP::Request' => 0,
  },
  dist => {
    COMPRESS => "gzip -9 -vf",
  },
  ;

package MY;

sub processPL {
  my $self = shift;
  my $block = $self->SUPER::processPL(@_);
  # "Version:" in spec needs to match
  # "$VERSION" from VERSION_FROM
  $block =~ s%(spec.PL\s*)$%$1 \$\(VERSION_FROM\)%m;
  $block;
}

sub libscan {
  my $self = shift;
  my $path = shift;
  ($path =~ / \bCVS\b | \~$ /x) ? undef : $path;
  }
1;
