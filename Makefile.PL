use ExtUtils::MakeMaker;

WriteMakefile(
	NAME => "cpan2rpm",
	AUTHOR => 'Erick Calder <perl@arix.com>',
	VERSION_FROM => "cpan2rpm",
	ABSTRACT_FROM => "cpan2rpm",
	EXE_FILES => [ "cpan2rpm" ],
	);

package MY;

$pkg = "cpan2rpm";

sub libscan {
	my $self = shift;
	my $path = shift;
	($path =~ / \bCVS\b | \~$ /x) ? undef : $path;
	}

sub postamble {
	return <<EOF;
pm_to_blib: README

README: $pkg
	pod2text cpan2rpm > README
EOF
	}

1;
