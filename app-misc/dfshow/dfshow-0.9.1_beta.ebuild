# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools bash-completion-r1

MY_PV="${PV//_beta/-beta}"
DESCRIPTION="DF-SHOW is a Unix-like rewrite of some of the applications from DF-EDIT"
HOMEPAGE="https://github.com/roberthawdon/dfshow"
SRC_URI="https://github.com/roberthawdon/dfshow/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-libs/libconfig
	sys-libs/ncurses:0=
"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	sed -i 's/LDADD = -lncursesw -lm -lconfig/LDADD = -lncursesw -lm -lconfig -ltinfow/' Makefile.am ||
		die "sed in Makefile.am failed"

	eautoreconf
}

src_install() {
	default

	newbashcomp "${S}/misc/auto-completion/bash/sf-completion.bash" sf-completion
	newbashcomp "${S}/misc/auto-completion/bash/show-completion.bash" show-completion

	insinto /usr/share/zsh/site-functions
	doins "${S}/misc/auto-completion/zsh/_sf"
	doins "${S}/misc/auto-completion/zsh/_show"
}
