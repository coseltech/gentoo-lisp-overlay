# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-rt/cl-rt-20040621.ebuild,v 1.4 2005/05/24 18:48:35 mkennedy Exp $

inherit common-lisp eutils

DEB_PV=2

DESCRIPTION="Common Lisp regression tester from MIT"
HOMEPAGE="http://www-2.cs.cmu.edu/afs/cs/project/ai-repository/ai/lang/lisp/code/testing/rt/ http://packages.debian.org/unstable/devel/cl-rt.html http://www.cliki.net/rt"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/cl-rt/${PN}_${PV}.orig.tar.gz
	http://ftp.debian.org/debian/pool/main/c/cl-rt/cl-rt_${PV}-${DEB_PV}.diff.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=rt

src_unpack() {
	unpack ${A}
	epatch cl-rt_${PV}-${DEB_PV}.diff
}

src_install() {
	common-lisp-install rt.lisp "${FILESDIR}"/rt.asd
	common-lisp-system-symlink
	dodoc rt-doc.txt rt-test.lisp
	do-debian-credits
}
