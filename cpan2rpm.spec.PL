# Copyright (C) 2002 Rob Brown (bbb@cpan.org)
# Chicken-And-Egg rpm SPEC file generator.

use strict;

my $req = join $/, (
    "%if %distro suse",
    "Requires: rpm",
    "%else",
    "Requires: rpm-build",
    "%endif"
    );

my $cmd = qq|./cpan2rpm --force --spec-only --spec="./cpan2rpm.spec" --requires "$req" --nopkgprfx --buildarch=noarch --doc=perl.req.patch .|;
system($cmd) == 0 || exit 1;
