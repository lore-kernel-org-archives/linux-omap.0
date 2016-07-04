From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 00/10] clk: fix/remove module usage in non-modular code
Date: Mon, 4 Jul 2016 17:12:10 -0400
Message-ID: <20160704211220.5685-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Aleksandr Frid <afrid@nvidia.com>, Alexandre Courbot <gnurou@gmail.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Carlo Caione <carlo@caione.org>, Chen-Yu Tsai <wens@csie.org>, =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>, Kevin Hilman <khilman@baylibre.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Michael Turquette <mturquette@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, Padmavathi Venna <padma.v@samsung.com>, Paul Walmsley <pwalmsley@nvidia.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tero
List-Id: linux-omap@vger.kernel.org

This series covers the audit of non-modular module code use in the
drivers/clk/ directory.

Quasi generic boiler plate description follows; included for folks who
haven't yet seen what we are aiming to achieve with this operation.

We are trying to not use module support for code that can never be buil=
t
as a module because:

 (1) it is easy to accidentally write unused module_exit and remove cod=
e
 (2) it can be misleading when reading the source, thinking it can be
     modular when the Makefile and/or Kconfig prohibit it
 (3) it requires the include of the module.h header file which in turn
     includes nearly everything else, thus adding to CPP overhead.
 (4) it gets copied/replicated into other code and spreads like weeds.

With respect to #1 in this instance, we see for these 10 commits:
    15 files changed, 37 insertions(+), 227 deletions(-)
=2E..which is a respectable (IMHO) net amount of removal of unused code=
=2E

Changes seen here cover the following categories:

  -just replacement of modular macros with their non-modular
   equivalents that CPP would have inserted anyway, such as:
	module_init --> device_initcall
	module_platform_driver --> builtin_platform_driver

  -the removal of including module.h ; replaced with init.h
   as required based on whether the file used it.

  -the removal of any/all unused/orphaned __exit functions that
   would never be called.

  -the removal of instances of MODULE_DEVICE_TABLE and MODULE_ALIAS
   that become no-ops in the non-modular case.

  -the removal of any ".remove" functions that were hooked into
   the driver struct.   This ".remove" function would of
   course not be called from the __exit function since that was
   never run.  However in theory, someone could have triggered it
   via sysfs unbind, even though there isn't a sensible use case
   for doing so.  So to cover that possibility, we've also disabled
   sysfs unbind in the driver.

  -the removal of MODULE_DESCRIIPTION/AUTHOR/LICENSE tags that are
   also no-ops for non-modular ; we ensure the information in those
   tags is present in the top of file comments in each case.

There are no initcall level changes here; everything stays at the level
of initcall it was previously - either by not using modular versions to
begin with, or by using the builtin level equivalents.

As usual, we can consider making some of these tristate if an author
has strong feelings about extending support into the modular realm,
but I won't be able to run-time test any of that.

I batched the sunxi changes together since they had similar author
and maintainer fields and it helps avoid polluting history with too
many mundane commits, but I can split that up if so desired.

Build testing done on linux-next on arm/arm64 and x86/x86_64.

Paul.
---

Cc: Aleksandr Frid <afrid@nvidia.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Boris BREZILLON <boris.brezillon@free-electrons.com>
Cc: Carlo Caione <carlo@caione.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: "Emilio L=C3=B3pez" <emilio@elopez.com.ar>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Padmavathi Venna <padma.v@samsung.com>
Cc: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Prashant Gaikwad <pgaikwad@nvidia.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>

Cc: linux-amlogic@lists.infradead.org
Cc: linux-clk@vger.kernel.org
Cc: linux-omap@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-tegra@vger.kernel.org

Paul Gortmaker (10):
  clk: meson8b: make it explicitly non-modular
  clk: meson: make gxbb explicitly non-modular
  clk: mvebu: make cp110-system-controller explicitly non-modular
  clk: mvebu: make ap806-system-controller explicitly non-modular
  clk: oxnas: make it explicitly non-modular
  clk: samsung make clk-exynos-audss explicitly non-modular
  clk: samsung: make clk-s5pv210-audss explicitly non-modular
  clk: sunxi: make clk-* explicitly non-modular
  clk: tegra: make clk-tegra124-dfll-fcpu explicitly non-modular
  clk: ti: make clk-dra7-atl explicitly non-modular

 drivers/clk/clk-oxnas.c                     | 15 +++----------
 drivers/clk/meson/gxbb.c                    | 18 ++++-----------
 drivers/clk/meson/meson8b-clkc.c            | 19 ++++------------
 drivers/clk/mvebu/ap806-system-controller.c | 23 +++----------------
 drivers/clk/mvebu/cp110-system-controller.c | 34 +++------------------=
--------
 drivers/clk/samsung/clk-exynos-audss.c      | 13 +----------
 drivers/clk/samsung/clk-s5pv210-audss.c     | 29 ++-------------------=
---
 drivers/clk/sunxi/clk-factors.c             |  1 -
 drivers/clk/sunxi/clk-sun6i-apb0-gates.c    |  9 ++------
 drivers/clk/sunxi/clk-sun6i-apb0.c          |  9 ++------
 drivers/clk/sunxi/clk-sun6i-ar100.c         | 21 +++---------------
 drivers/clk/sunxi/clk-sun8i-apb0.c          |  9 ++------
 drivers/clk/sunxi/clk-sun9i-mmc.c           | 28 +++------------------=
---
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c  | 16 ++------------
 drivers/clk/ti/clk-dra7-atl.c               | 20 +++--------------
 15 files changed, 37 insertions(+), 227 deletions(-)

--=20
2.8.4
