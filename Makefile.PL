use ExtUtils::MakeMaker;

WriteMakefile(
	NAME => "cpan2rpm",
	AUTHOR => 'Erick Calder <perl@arix.com>',
	VERSION_FROM => "cpan2rpm",
	ABSTRACT_FROM => "cpan2rpm",
	EXE_FILES => [ "cpan2rpm" ],
	PREREQ_PM => {
          'HTTP::Lite'    => '0',
        },
	);

package MY;

sub libscan {
	my $self = shift;
	my $path = shift;
	($path =~ / \bCVS\b | \~$ /x) ? undef : $path;
	}

sub postamble {
	return <<EOF;
pm_to_blib: README

README: \$(VERSION_FROM)
	pod2text \$(VERSION_FROM) > README
EOF
	}

1;
