# Copyright (C) 2002 Rob Brown (bbb@cpan.org)
# Chicken-And-Egg rpm SPEC file generator.

use strict;
use ExtUtils::MakeMaker;

my $output = shift or die "create what?";
my $version = ExtUtils::MM_Unix->parse_version("cpan2rpm") or die "No VERSION?";
print "CREATING [$output] ...\n";

# Versions before 5.91 need PREFIX= on install line.
# Versions after 6.05 need DESTDIR= on install line.
# Versions in between need PREFIX= on Makefile.PL line.
$ENV{MM_MAKER_DANCE} = q{`%{__perl} -MExtUtils::MakeMaker -e 'if ($ExtUtils::MakeMaker::VERSION =~ /5\.9[1-6]|6\.0[0-5]/) {print "PREFIX=%{buildroot}%{_prefix}";}'`};
$ENV{MM_INSTALL_DANCE} = q{`%{__perl} -MExtUtils::MakeMaker -e 'if ($ExtUtils::MakeMaker::VERSION <= 6.05) {print "PREFIX=%{buildroot}%{_prefix}";} else {print "DESTDIR=%{buildroot}";}'`};

system(<<SH);
touch $output
make && (make dist > /dev/null) && (./cpan2rpm --requires rpm-build --spec-only --spec $output --nopkgprfx --buildarch=noarch --doc=perl.req.patch --make-maker "\$MM_MAKER_DANCE" --make-install "\$MM_INSTALL_DANCE" cpan2rpm-$version.tar.gz)
make dist > /dev/null
SH
