TERMUX_PKG_HOMEPAGE="https://github.com/indygreg/python-zstandard"
TERMUX_PKG_DESCRIPTION="Python bindings to the Zstandard (zstd) compression library"
TERMUX_PKG_LICENSE="BSD-3-Clause'"
TERMUX_PKG_LICENSE_FILE="LICENSE"
TERMUX_PKG_MAINTAINER="@tesuji"
TERMUX_PKG_VERSION=0.23.0
TERMUX_PKG_SRCURL=https://github.com/indygreg/python-zstandard/archive/$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=f29233338bcef11f233737eb58aba85074f0fd3163bec1a20303de1270e6fb16
TERMUX_PKG_DEPENDS="python"
TERMUX_PKG_PYTHON_COMMON_DEPS="wheel, setuptools, build, installer"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
	echo
}

termux_step_configure() {
    echo # none
}

termux_step_make() {
    python -m build --wheel --no-isolation --skip-dependency-check
}

termux_step_make_install() {
    python -m installer --prefix="${TERMUX_PREFIX}" dist/*.whl
}
