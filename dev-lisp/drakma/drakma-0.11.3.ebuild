# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit common-lisp-2

DESCRIPTION="Drakma is a Common Lisp HTTP client."
HOMEPAGE="http://weitz.de/drakma/"
SRC_URI="http://common-lisp.net/~sionescu/files/ediware/${P}.tar.gz"
LICENSE="BSD-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
SLOT="0"

DEPEND="!dev-lisp/cl-${PN}
		dev-lisp/chunga
		dev-lisp/puri
		>=dev-lisp/cl-base64-3.3.2
		dev-lisp/usocket
		dev-lisp/cl-plus-ssl"

src_install() {
	common-lisp-install *.{lisp,asd}
	common-lisp-symlink-asdf
	dodoc CHANGELOG*
	dohtml doc/index.html
}