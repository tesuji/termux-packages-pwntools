TERMUX_PKG_HOMEPAGE=https://github.com/tummychow/git-absorb
TERMUX_PKG_DESCRIPTION="git commit --fixup, but automatic"
TERMUX_PKG_LICENSE="BSD 3-Clause"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="0.8.0"
TERMUX_PKG_SRCURL=https://github.com/tummychow/git-absorb/archive/refs/tags/${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=9ed6fef801fbfeb7110744cac38ae5b3387d8832749ae20077b9139d032211f1
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="git, libgit2"
TERMUX_PKG_BUILD_DEPENDS="asciidoc"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
	export CFLAGS_"${CARGO_TARGET_NAME//-/_}"+=" -Dindex=strchr"

	# See https://github.com/nagisa/rust_libloading/issues/54
	export CC_x86_64_unknown_linux_gnu=gcc
	export CFLAGS_x86_64_unknown_linux_gnu=""

	termux_setup_rust

	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	cargo fetch --target "${CARGO_TARGET_NAME}"

	local f
	for f in "$CARGO_HOME"/registry/src/*/libgit2-sys-*/build.rs; do
		sed -i -E 's/\.range_version\(([^)]*)\.\.[^)]*\)/.atleast_version(\1)/g' "${f}"
	done
}

termux_step_make() {
	pushd ./Documentation
	make
	popd
}

termux_step_post_make_install() {
	install -Dm644 ./Documentation/git-absorb.1 "$TERMUX_PREFIX/share/man/man1/"
}
