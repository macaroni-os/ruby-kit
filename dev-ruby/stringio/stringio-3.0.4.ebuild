# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby27 ruby30 ruby31"
RUBY_FAKEGEM_EXTRADOC="README.md"
RUBY_FAKEGEM_EXTENSIONS=(ext/stringio/extconf.rb)
RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="Pseudo `IO` class from/to `String`."
HOMEPAGE="https://github.com/ruby/stringio"
SRC_URI="https://github.com/ruby/stringio/tarball/003dd0d0035d47fdd7b10409ace9b0178693ecf3 -> stringio-3.0.4-003dd0d.tar.gz"

KEYWORDS="*"
LICENSE="BSD-2"
SLOT="0"
IUSE="test"

post_src_unpack() {
	if [ ! -d "${S}/all/${P}" ] ; then
		mv "${WORKDIR}"/all/ruby-stringio-* "${S}"/all/"${P}" || die
	fi
}

all_ruby_prepare() {
	sed -e "/s.version =/ s/source_version/'${PV}'/" \
		-e 's/__dir__/"."/' \
		-i ${RUBY_FAKEGEM_GEMSPEC} || die
}

each_ruby_test() {
	${RUBY} -Ilib:.:test -e 'Dir["test/test_*.rb"].each{|f| require f}' || die
}