# Copyright (C) 2002 Rob Brown (bbb@cpan.org)
# Chicken-And-Egg rpm SPEC file generator.

use strict;
use ExtUtils::MakeMaker;

my $output = shift or die "create what?";
my $version = ExtUtils::MM_Unix->parse_version("cpan2rpm") or die "No VERSION?";

print "CREATING [$output] ...\n";
system(<<SH);
touch $output
make && (make dist > /dev/null) && (./cpan2rpm --requires rpm-build --spec-only --nopkgprfx cpan2rpm-$version.tar.gz > $output)
make dist > /dev/null
SH
