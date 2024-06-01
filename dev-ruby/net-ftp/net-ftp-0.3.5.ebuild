# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby27 ruby30 ruby31 ruby32"
RUBY_FAKEGEM_BINWRAP=""
RUBY_FAKEGEM_EXTRADOC="README.md"
RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="This class implements the File Transfer Protocol."
HOMEPAGE="https://github.com/ruby/net-ftp"
SRC_URI="https://github.com/ruby/net-ftp/tarball/b0bb021fc81633f1ef537fa533b7fc38da3ebcb9 -> net-ftp-0.3.5-b0bb021.tar.gz"

KEYWORDS="*"
LICENSE="|| ( Ruby-BSD BSD-2 )"
SLOT="0"
IUSE=""

post_src_unpack() {
	if [ ! -d "${S}/all/${P}" ] ; then
		mv "${WORKDIR}"/all/ruby-net-ftp-* "${S}"/all/"${P}" || die
	fi
}

all_ruby_prepare() {
	sed -e 's/__dir__/"."/' \
		-e 's/__FILE__/"'${RUBY_FAKEGEM_GEMSPEC}'"/' \
		-e 's/git ls-files -z/find * -print0/' \
		-i ${RUBY_FAKEGEM_GEMSPEC} || die
}