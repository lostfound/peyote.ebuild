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
inherit eutils
PYTHON_USE_WITH="threads ncurses"
NCURSES_USE_WITH="unicode"
PYTHON_DEPEND="2"

DESCRIPTION="Peyote is an audio player with friendly MC-like interface"
HOMEPAGE="http://peyote.sourceforge.net/"
MY_P="peyote_0.9.11.7"
SRC_URI="http://peyote.itbuben.org/src/peyote_0.9.11.7.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="inotify oss alsa jack pulse wavpack ogg mp3 lame flac pitch"

DEPEND="media-libs/mutagen
dev-python/pygobject
dev-python/dbus-python
inotify? ( dev-python/pyinotify )
dev-python/gst-python
media-libs/gst-plugins-base
media-libs/gst-plugins-good
sys-libs/ncurses

oss? ( media-plugins/gst-plugins-oss )
pulse? ( media-plugins/gst-plugins-pulse )
jack? ( media-plugins/gst-plugins-jack )
alsa? ( media-plugins/gst-plugins-alsa )

pitch? ( media-plugins/gst-plugins-soundtouch )
flac? ( media-plugins/gst-plugins-flac )
lame? ( media-plugins/gst-plugins-lame )
ogg? ( media-plugins/gst-plugins-ogg  media-plugins/gst-plugins-vorbis )
wavpack? ( media-plugins/gst-plugins-wavpack )
mp3? ( media-plugins/gst-plugins-mad )
"

# Run-time dependencies. Must be defined to whatever this depends on to run.
# The below is valid if the same run-time depends are required to compile.
RDEPEND="${DEPEND}"

# Source directory; the dir where the sources can be found (automatically
# unpacked) inside ${WORKDIR}.  The default value for S is ${WORKDIR}/${P}
# If you don't need to change it, leave the S= line out of the ebuild
# to keep it tidy.
#S="${WORKDIR}/${P}"
S="${WORKDIR}/${MY_P}"


# The following src_configure function is implemented as default by portage, so
# you only need to call it if you need a different behaviour.
# This function is available only in EAPI 2 and later.
#src_configure() {
	# Most open-source packages use GNU autoconf for configuration.
	# The default, quickest (and preferred) way of running configure is:
	#econf
	#
	# You could use something similar to the following lines to
	# configure your package before compilation.  The "|| die" portion
	# at the end will stop the build process if the command fails.
	# You should use this at the end of critical commands in the build
	# process.  (Hint: Most commands are critical, that is, the build
	# process should abort if they aren't successful.)
	#./configure \
	#	--host=${CHOST} \
	#	--prefix=/usr \
	#	--infodir=/usr/share/info \
	#	--mandir=/usr/share/man || die
	# Note the use of --infodir and --mandir, above. This is to make
	# this package FHS 2.2-compliant.  For more information, see
	#   http://www.pathname.com/fhs/
#}
src_configure() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--disable-gst-plugins-check \
		--mandir=/usr/share/man || die
}

# The following src_compile function is implemented as default by portage, so
# you only need to call it, if you need different behaviour.
# For EAPI < 2 src_compile runs also commands currently present in
# src_configure. Thus, if you're using an older EAPI, you need to copy them
# to your src_compile and drop the src_configure function.
src_compile() {
	emake || die
}

# The following src_install function is implemented as default by portage, so
# you only need to call it, if you need different behaviour.
# For EAPI < 4 src_install is just returing true, so you need to always specify
# this function in older EAPIs.
src_install() {
	emake DESTDIR="${D}" install || die
}
