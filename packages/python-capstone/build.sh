TERMUX_PKG_HOMEPAGE="https://www.capstone-engine.org"
TERMUX_PKG_DESCRIPTION="Python bindings for Capstone disassembly framework"
TERMUX_PKG_LICENSE="BSD"
TERMUX_PKG_LICENSE_FILE="LICENSE.TXT"
TERMUX_PKG_MAINTAINER="@tesuji"
TERMUX_PKG_VERSION=5.0.6
TERMUX_PKG_SRCURL=https://github.com/capstone-engine/capstone/archive/$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=240ebc834c51aae41ca9215d3190cc372fd132b9c5c8aa2d5f19ca0c325e28f9
TERMUX_PKG_DEPENDS="capstone, python"
TERMUX_PKG_PYTHON_COMMON_DEPS="wheel, setuptools, build, installer"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
    # Android NDK specific flags
    export CS_UNDEF_THREADS=1
    export CFLAGS+=" -I$TERMUX_PREFIX/include/python${TERMUX_PYTHON_VERSION}"
    export LDFLAGS+=" -L$TERMUX_PREFIX/lib"
}

termux_step_configure() {
    echo # none
}

termux_step_make() {
    cd bindings/python
    python -m build --wheel --no-isolation
}

termux_step_make_install() {
    cd bindings/python
    python -m installer --prefix="${TERMUX_PREFIX}" dist/*.whl
}
