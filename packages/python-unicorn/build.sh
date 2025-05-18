TERMUX_PKG_HOMEPAGE=https://www.unicorn-engine.org/
TERMUX_PKG_DESCRIPTION="Unicorn is a lightweight multi-platform, multi-architecture CPU emulator framework"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_VERSION="2.1.3"
TERMUX_PKG_SRCURL=https://github.com/unicorn-engine/unicorn/archive/$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=5572eecd903fff0e66694310ca438531243b18782ce331a4262eeb6f6ad675bc
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_BREAKS="unicorn-dev"
TERMUX_PKG_REPLACES="unicorn-dev"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-DTERMUX_ARCH=$TERMUX_ARCH"
TERMUX_PKG_MAINTAINER="@tesuji"
TERMUX_PKG_DEPENDS="unicorn, python"
TERMUX_PKG_PYTHON_COMMON_DEPS="wheel, setuptools, build, installer, setuptools-scm, versioningit"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
	echo
}

termux_step_configure() {
    echo # none
}

termux_step_make() {
    cd bindings
    python const_generator.py python
    cd python
    export SETUPTOOLS_SCM_PRETEND_VERSION=$TERMUX_PKG_VERSION
    # avoid rebuilding libunicorn.so
    env LIBUNICORN_PATH="/doesnotexist" python -m build --wheel --no-isolation
}

termux_step_make_install() {
    cd bindings/python
    export SETUPTOOLS_SCM_PRETEND_VERSION=$TERMUX_PKG_VERSION
    env LIBUNICORN_PATH="/doesnotexist" \
      python -m installer --prefix="${TERMUX_PREFIX}" dist/*.whl
}
