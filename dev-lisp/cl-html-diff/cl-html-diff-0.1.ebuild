# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit common-lisp-2

DESCRIPTION="CL-HTML-DIFF is a Common Lisp library for generating a human-readable diff of two HTML documents, using HTML."
HOMEPAGE="http://www.cliki.net/CL-HTML-DIFF"
SRC_URI="http://lemonodor.com/code/${PN}_${PV}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-lisp/cl-difflib"

S="${WORKDIR}"/${PN}_${PV}