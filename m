From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 00/37] ARM: dts: Fix fixed regulators enable GPIO polarity
Date: Tue, 13 Oct 2015 00:12:29 +0300
Message-ID: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-omap@vger.kernel.org

Hello,

While working on regulators, GPIOs and DT I noticed that many of our DT source
files incorrectly describe fixed regulators. The common error patterns are

- Usage of the undefined (and never parsed) enable-active-low property
- Usage of the enable-active-high property without specifying an enable GPIO
- Typos in the enabl GPIO property name (gpios instead of gpio)
- Mismatch between the enable-active-high property (or the lack thereof) and
  the enable GPIO flags

This patch series fixes those issues in all the DT sources after locating the
errors using the following script.

------------------------------------------------------------------------------
#!/bin/sh

echo $1
cat $1 | awk '
BEGIN {
	open_drain = 0;
	active_high = 0;
	gpio = 0;
	flags = 0;
}

match($0, /([a-zA-Z0-9@_-]*) {/, ary) {
	name = ary[1];
}

/compatible.*"regulator-fixed"/ {
	found = 1;
}

/enable-active-high/ {
	active_high = 1;
}

/gpio-open-drain/ {
	open_drain = 1;
}

match($0, /gpio += <.* ([^ ]*)>/, ary) {
	gpio = 1;
	flags = ary[1];
	if (flags == 0)
		flags = "GPIO_ACTIVE_HIGH";
}

/}/ {
	if (found) {
		if (gpio) {
			print "\t" name ": active high " active_high " " flags " open drain " open_drain;
			if ((active_high && flags == "GPIO_ACTIVE_LOW") ||
			    (!active_high && flags == "GPIO_ACTIVE_HIGH"))
				print "WARNING: enable-active-high and flags do not match"
		} else {
			if (active_high)
				print "WARNING: active high without GPIO"
			if (open_drain)
				print "WARNING: open drain without GPIO"
		}
	}

	gpio = 0;
	found = 0;
	active_high = 0;
	open_drain = 0;
	flags = 0;
}
'
------------------------------------------------------------------------------

All patches except for the ones touching omap3-beagle-xm and omap3-overo-base
are untested as I lack test hardware.

As there's no dependency between the patches touching different source files
the appropriate maintainers could take their share of the patches in their
tree. Alternatively I could send a single pull request after collecting all
acks but that might be more complex.

Cc: devicetree@vger.kernel.org
Cc: linux-omap@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Benoit Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>

Laurent Pinchart (37):
  ARM: dts: am437x-gp-evm: Remove unneeded regulator property
  ARM: dts: am43xx-epos-evm: Remove unneeded regulator property
  ARM: mvebu: Armada 388 GP: Remove unneeded regulator property
  ARM: imx6sx-sdb: Fix typo in regulator enable GPIO property
  ARM: dts: s5pv210-aquila: Fix typo in regulator enable GPIO property
  ARM: dts: s5pv210-goni: Fix typo in regulator enable GPIO property
  ARM: dts: omap3-evm: Remove invalid enable-active-low regulator
    property
  ARM: dts: omap3-sb-t35: Remove invalid enable-active-low regulator
    property
  ARM: dts: omap3-tao3530: Remove invalid enable-active-low regulator
    property
  ARM: dts: imx6qdl-tx6: Fix regulator enable GPIO polarity
  ARM: dts: dove-cm-a510: Fix regulator enable GPIO polarity
  ARM: dts: dove-sbc-a510: Fix regulator enable GPIO polarity
  ARM: dts: exynos5250-arndale: Fix regulator enable GPIO polarity
  ARM: dts: imx23-evk: Fix regulator enable GPIO polarity
  ARM: dts: imx23-stmp378x_devb: Fix regulator enable GPIO polarity
  ARM: dts: imx25-pdk: Fix regulator enable GPIO polarity
  ARM: dts: imx28-cfa10036: Fix regulator enable GPIO polarity
  ARM: dts: imx28-evk: Fix regulator enable GPIO polarity
  ARM: dts: imx28-m28cu3: Fix regulator enable GPIO polarity
  ARM: dts: imx28-m28evk: Fix regulator enable GPIO polarity
  ARM: dts: imx28-sps1: Fix regulator enable GPIO polarity
  ARM: dts: imx28-tx28: Fix regulator enable GPIO polarity
  ARM: dts: imx53-m53evk: Fix regulator enable GPIO polarity
  ARM: dts: imx53-mba53: Fix regulator enable GPIO polarity
  ARM: dts: imx53-tx53: Fix regulator enable GPIO polarity
  ARM: dts: imx6q-dmo-edmqmx6: Fix regulator enable GPIO polarity
  ARM: dts: kirkwood-blackarmor-nas220: Fix regulator enable GPIO
    polarity
  ARM: dts: omap4-duovero: Fix regulator enable GPIO polarity
  ARM: dts: kirkwood-nsa3x0-common: Fix regulator enable GPIO polarity
  ARM: dts: omap3-beagle-xm: Fix regulator enable GPIO polarity
  ARM: dts: omap3-beagle: Fix regulator enable GPIO polarity
  ARM: dts: omap3-overo-base: Fix regulator enable GPIO polarity
  ARM: dts: omap3-tao3530: Fix regulator enable GPIO polarity
  ARM: dts: tegra20-harmony: Fix regulator enable GPIO polarity
  ARM: dts: tegra20-iris-512: Fix regulator enable GPIO polarity
  ARM: dts: tegra20-seaboard: Fix regulator enable GPIO polarity
  ARM: dts: tegra20-ventana: Fix regulator enable GPIO polarity

 arch/arm/boot/dts/am437x-gp-evm.dts              | 1 -
 arch/arm/boot/dts/am43x-epos-evm.dts             | 1 -
 arch/arm/boot/dts/armada-388-gp.dts              | 2 --
 arch/arm/boot/dts/dove-cm-a510.dtsi              | 2 +-
 arch/arm/boot/dts/dove-sbc-a510.dts              | 4 ++--
 arch/arm/boot/dts/exynos5250-arndale.dts         | 2 +-
 arch/arm/boot/dts/imx23-evk.dts                  | 3 ++-
 arch/arm/boot/dts/imx23-stmp378x_devb.dts        | 3 ++-
 arch/arm/boot/dts/imx25-pdk.dts                  | 2 +-
 arch/arm/boot/dts/imx28-cfa10036.dts             | 2 +-
 arch/arm/boot/dts/imx28-evk.dts                  | 4 ++--
 arch/arm/boot/dts/imx28-m28cu3.dts               | 4 ++--
 arch/arm/boot/dts/imx28-m28evk.dts               | 6 +++---
 arch/arm/boot/dts/imx28-sps1.dts                 | 2 +-
 arch/arm/boot/dts/imx28-tx28.dts                 | 2 +-
 arch/arm/boot/dts/imx53-m53evk.dts               | 2 +-
 arch/arm/boot/dts/imx53-mba53.dts                | 2 +-
 arch/arm/boot/dts/imx53-tx53.dtsi                | 2 +-
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts          | 2 +-
 arch/arm/boot/dts/imx6qdl-tx6.dtsi               | 3 +--
 arch/arm/boot/dts/imx6sx-sdb.dtsi                | 2 +-
 arch/arm/boot/dts/kirkwood-blackarmor-nas220.dts | 4 ++--
 arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi    | 2 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts            | 2 +-
 arch/arm/boot/dts/omap3-beagle.dts               | 2 +-
 arch/arm/boot/dts/omap3-evm-common.dtsi          | 1 -
 arch/arm/boot/dts/omap3-overo-base.dtsi          | 4 ++--
 arch/arm/boot/dts/omap3-sb-t35.dtsi              | 1 -
 arch/arm/boot/dts/omap3-tao3530.dtsi             | 3 +--
 arch/arm/boot/dts/omap4-duovero.dtsi             | 2 +-
 arch/arm/boot/dts/s5pv210-aquila.dts             | 2 +-
 arch/arm/boot/dts/s5pv210-goni.dts               | 4 ++--
 arch/arm/boot/dts/tegra20-harmony.dts            | 2 +-
 arch/arm/boot/dts/tegra20-iris-512.dts           | 2 +-
 arch/arm/boot/dts/tegra20-seaboard.dts           | 2 +-
 arch/arm/boot/dts/tegra20-ventana.dts            | 2 +-
 36 files changed, 41 insertions(+), 47 deletions(-)

-- 
Regards,

Laurent Pinchart
