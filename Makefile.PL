use ExtUtils::MakeMaker;

WriteMakefile(
	NAME => "cpan2rpm",
	AUTHOR => 'Erick Calder <ekkis@cpan.org>',
	VERSION_FROM => "cpan2rpm",
	ABSTRACT_FROM => "cpan2rpm",
	EXE_FILES => [ "cpan2rpm" ],
	);

package MY;

sub libscan {
	my $self = shift;
	my $path = shift;
	($path =~ / \bCVS\b | \~$ /x) ? undef : $path;
	}
1;
