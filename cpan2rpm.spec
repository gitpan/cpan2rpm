#
#    cpan2rpm - This spec file was automatically generated.
#    For further information please refer to: http://perl.arix.com/
#
%define pkgname    cpan2rpm
%define filelist %{pkgname}-%{version}-filelist
%define NVR %{pkgname}-%{version}-%{release}
Summary:       cpan2rpm - A Perl module packager
Name:          cpan2rpm
Version:       2.008
Release:       1
Group:         Applications/CPAN
Distribution:  Red Hat Linux release 7.0 (Guinness)
Vendor:        Erick Calder <ekkis@cpan.org>
Packager:      Arix International <cpan2rpm@arix.com>
License:       Artistic
Url:           http://www.cpan.org
BuildRoot:     %{_tmppath}/%{name}-%{version}-%(id -u -n)
BuildArch:     i386
Source:        %{pkgname}-%{version}.tar.gz
Requires: rpm-build
%description
cpan2rpm [options] <module>
This script generates an RPM package from a Perl module.  It uses the standard RPM file structure and creates a spec file, a source RPM, and a binary, leaving these in their respective directories.
The script can operate on local files, urls and CPAN module names.  Install this package if you want to create RPMs out of Perl modules.
#
# This package was automatically generated with the cpan2rpm
# utility.  To get this software or for more information
# please visit: http://perl.arix.com/
#
%prep
%setup -q -n cpan2rpm-2.008 
%build
CFLAGS="$RPM_OPT_FLAGS"
%{__perl} Makefile.PL 'PREFIX=$(MYDESTDIR)%{_prefix}' 
%{__make} 
%{__make} test
%install
[ "%{buildroot}" != "/" ] && rm -rf %{buildroot}
%{makeinstall} MYDESTDIR=%{buildroot} 
[ -x /usr/lib/rpm/brp-compress ] && /usr/lib/rpm/brp-compress
find %{buildroot} -name "perllocal.pod" \
-o -name ".packlist"                    \
-o -name "*.bs"                         \
|xargs -i rm -f {}
find %{buildroot}%{_prefix} -type d -depth -exec rmdir {} \; 2>/dev/null
%clean
[ "%{buildroot}" != "/" ] && rm -rf %{buildroot}
%files
%defattr(-,root,root)
%doc README Changes
%{_prefix}
%changelog
* Wed Dec 18 2002 ekkis@beowulf
- Initial build.
