# Copyright (C) 2002 Rob Brown (bbb@cpan.org)
# Chicken-And-Egg rpm SPEC file generator.

use strict;

my $rpmver; ($rpmver = qx/rpm --version/) =~ s/\D+//g;
my @cmd = (
    "./cpan2rpm",
    ((eval("use File::Temp"),$@) ? ("--tempdir","/tmp/cpan2rpm") : ()),
    "--force",
    "--spec-only",
    "--spec", "./cpan2rpm.spec",
    "--requires", $rpmver >= 400 ? "rpm-build" : "rpm",
    "--no-prfx",
    "--buildarch=noarch",
    "--doc", "perl.req.patch",
    "."
    );

exec(@cmd) or die "exec failure: $!";
