From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: [PATCH v3 0/4] ARM: add omap3 INCOstartec board support
Date: Mon, 27 Jan 2014 01:33:13 +0100
Message-ID: <1390782797-24105-1-git-send-email-chf.fritz@googlemail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:33062 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753566AbaA0Adj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 26 Jan 2014 19:33:39 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, bcousson@baylibre.com, Daniel Mack <zonque@gmail.com>, "Hans J. Koch" <hjk@hansjkoch.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

This set of patches adds board support for an omap3 system from INCOstartec.
It's based on next-20140124.

Due to a regression since next-20140115 the following errors are present:

 - pin sys_clkout2, which gets configured to 24 Mhz by the fourth patch
   in this set, erroneously outputs only 12 Mhz.
   Just out of curiosity, configuring it to 48 Mhz puts out desired 24 Mhz.

 - omap_dss, which gets configured by the third patch in this set, fails
   to do 'dss_set_fck_rate(fck);' in
   drivers/video/omap2/dss/dss.c:dss_setup_default_clock() which leads to:

    | omapdss_dss: probe of omapdss_dss failed with error -22
    | omapdss CORE error: Failed to initialize DSS platform driver
    | panel-dpi panel-dpi.0: failed to find video source 'dpi.0

  Both regressions seem to have something to do with the clock framework. 
  Could this be related to the DT clock conversion patches?

Changes compared to previous version (v3):
 - rebased on next-20140124
 - use pinctrl macros OMAP3_WKUP_IOPAD, OMAP3_CORE1_IOPAD
   and OMAP3630_CORE2_IOPAD
 - use same convention for all comments
 - dss-quirk: name twl4030 VPLL2 regulator as vdds_dsi
 - fix style
Changes compared to previous version (v2):
 - rebased on next-20140122 from next-20140115
 - using omap36xx.dtsi instead of unsupported 1ghz omap37xx100
Initial version (v1):
 - based on next-20140115

Christoph Fritz (4):
  ARM: dts: omap3: Add support for INCOstartec a83x module
  ARM: dts: omap3: Add support for INCOstartec DBB056 baseboard
  ARM: OMAP2+: add legacy display for omap3 DBB056
  ARM: OMAP2+: Add pdata quirk for sys_clkout2 for omap3 DBB056

 arch/arm/boot/dts/Makefile               |    1 +
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi  |  459 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-lilly-dbb056.dts |  165 +++++++++++
 arch/arm/mach-omap2/dss-common.c         |   49 ++++
 arch/arm/mach-omap2/dss-common.h         |    1 +
 arch/arm/mach-omap2/pdata-quirks.c       |   45 ++-
 6 files changed, 719 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/omap3-lilly-a83x.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-lilly-dbb056.dts

-- 
1.7.10.4

