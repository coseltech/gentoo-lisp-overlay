# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

inherit multilib elisp-common

DESCRIPTION="Chicken is a Scheme interpreter and native Scheme to C compiler"
SRC_URI="http://chicken.wiki.br/dev-snapshots/2008/03/12/${P}.tar.gz"
HOMEPAGE="http://www.call-with-current-continuation.org/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86"
IUSE="emacs"

DEPEND=">=dev-libs/libpcre-7.6
		sys-apps/texinfo
		emacs? ( virtual/emacs )"

SITEFILE=50hen-gentoo.el

src_unpack() {
	unpack ${A}; cd "${S}"
	sed "s:/lib:/$(get_libdir):g" -i defaults.make
}

src_compile() {
	# $A is used by the makefile so >_>
	unset A

	OPTIONS="PLATFORM=linux PREFIX=/usr"

	emake ${OPTIONS} C_COMPILER_OPTIMIZATION_OPTIONS="$CFLAGS" \
		USE_HOST_PCRE=1 || die

	use emacs && elisp-comp hen.el
}

# chicken doesn't seem to honor CHICKEN_PREFIX CHICKEN_HOME or LD_LIBRARY_PATH=${S}/.libs/
RESTRICT=test

src_install() {
	unset A

	emake ${OPTIONS} DESTDIR="${D}" USE_HOST_PCRE=1 install || die
	dodoc ChangeLog* NEWS
	dohtml -r html/
	rm -rf "${D}"/usr/share/chicken/doc

	if use emacs; then
		elisp-install ${PN} *.{el,elc}
		elisp-site-file-install "${FILESDIR}"/${SITEFILE}
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}