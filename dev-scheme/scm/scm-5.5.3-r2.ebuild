# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/scm/scm-5.5.3.ebuild,v 1.5 2007/06/25 10:25:57 hkbst Exp $

inherit versionator eutils

#version magic thanks to masterdriverz and UberLord using bash array instead of tr
trarr="0abcdefghi"
MY_PV="$(get_version_component_range 1)${trarr:$(get_version_component_range 2):1}$(get_version_component_range 3)"

MY_P=${PN}${MY_PV}
S=${WORKDIR}/${PN}
DESCRIPTION="Scheme implementation from author of slib"

SRC_URI="http://swiss.csail.mit.edu/ftpdir/scm/${MY_P}.zip"

HOMEPAGE="http://swiss.csail.mit.edu/~jaffer/SCM"

SLOT="0"
LICENSE="GPL-2-with-linking-exception"
KEYWORDS="~x86 ~amd64"
IUSE=""

#unzip for unpacking
RDEPEND=""
DEPEND="app-arch/unzip
		>=dev-scheme/slib-3.1.4-r2"

src_unpack() {
	unpack ${A}; cd "${S}"

	sed "s#.*../wb/rwb-isam.scm.*##" -i Makefile
	sed "s#local/##" -i Makefile
	epatch ${FILESDIR}/scm-fixinstall.patch
	epatch ${FILESDIR}/findexec.diff
}

src_compile() {

	einfo "Making scmlit"
	#parallel make fails sometimes
	emake -j1 scmlit
	make clean
	einfo "Building"
	echo "srcdir=/usr/share/scm/" > srcdir.mk
	#stdout to temp.sh to execute...
	./build --compiler-options="${CFLAGS}" --linker-options="${LDFLAGS}" \
	-F macro inexact &>temp.sh
	chmod +x temp.sh
	./temp.sh || die "Compilation failed"
}

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"
}

pkg_postinst() {
	[ "${ROOT}" == "/" ] && pkg_config
}

pkg_config() {
	einfo "Regenerating catalog..."
	scm -e "(require 'new-catalog)"
}
