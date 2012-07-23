# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# NOTE: The comments in this file are for instruction and documentation.
# They're not meant to appear with your final, production ebuild.  Please
# remember to remove them before submitting or committing your ebuild.  That
# doesn't mean you can't add your own comments though.

# The 'Header' on the third line should just be left alone.  When your ebuild
# will be committed to cvs, the details on that line will be automatically
# generated to contain the correct data.

# The EAPI variable tells the ebuild format in use.
# Defaults to 0 if not specified.
# It is suggested that you use the latest EAPI approved by the Council.
# The PMS contains specifications for all EAPIs. Eclasses will test for this
# variable if they need to use EAPI > 0 features.
#PYTHON_DEPEND="python? 2"
EAPI=4

inherit eutils git-2
NCURSES_USE_WITH="unicode"
PYTHON_DEPEND="2"
DESCRIPTION="less.sh replacement"
HOMEPAGE="https://github.com/rkitover/vimpager"
EGIT_REPO_URI="git://github.com/rkitover/vimpager.git"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""

DEPEND=""

# Run-time dependencies. Must be defined to whatever this depends on to run.
# The below is valid if the same run-time depends are required to compile.
RDEPEND="${DEPEND}"
src_prepare() {
	epatch "${FILESDIR}"/vimpager-makefile.patch
}
src_compile() {
	#emake || die
}

src_install() {
	PREFIX="${D}/usr" emake DESTDIR="${D}" install || die
}
