# Copyright (C) 2002 Rob Brown (bbb@cpan.org)
# Chicken-And-Egg rpm SPEC file generator.

use strict;

my $req = q{ %([ `rpm -q rpm --qf %%{version}|awk -F . '{print $1}'` -gt 3 ] && echo rpm-build || echo rpm)};

my @cmd
  =("./cpan2rpm",
    ((eval("use File::Temp"),$@)?("--tempdir","/tmp/cpan2rpm"):()),
    "--force",
    "--spec-only",
    "--requires", $req,
    "--no-prfx",
    "--buildarch=noarch",
    "--doc", "perl.req.patch",
    "--spec", "./cpan2rpm.spec",
    ".");
exec(@cmd) or die "exec failure: $!";
