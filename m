From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH v3 0/5] ARM: dts: OMAP2+: use preprocessor for device trees
Date: Mon, 27 May 2013 16:52:29 +0200
Message-ID: <1369666354-29152-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:40728 "HELO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756230Ab3E0Oxf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 May 2013 10:53:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Stephen Warren <swarren@wwwdotorg.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

Hello,

Following a similar proposal by Stephen Warren for tegra [1], this series
makes use of the C preprocessor when compiling OMAP DT files, and
accomplishes some improvements to improve overall readability.

Patch 1 is a preparation for the rest of the series.
Patch 2 uses existing constants for GPIOs. Patch 3 does the same for
IRQs. Patch 4 creates a new header for OMAP's padmux, and patch 5 uses
it to simplify pinctrl DT.

As for v2, the .dtb files were diff-tested before and after
applying the series to guarantee identity for all targets.

Best regards,

Florian

>From v2:
- Address Tony's comments (standardize comments, remove OMAP_ prefix)

>From v1:
- Remove duplicated fix
- Remove OMAP_GPIO macro
- Add pinctrl constants

Florian Vaussard (5):
  ARM: dts: OMAP2+: use #include for all device trees
  ARM: dts: OMAP2+: use existing constants for GPIOs
  ARM: dts: OMAP4/5: use existing constants for IRQs
  ARM: dts: OMAP2+: header file for pinctrl constants
  ARM: dts: OMAP2+: use pinctrl constants

 arch/arm/boot/dts/omap2.dtsi              |    5 +-
 arch/arm/boot/dts/omap2420-h4.dts         |    2 +-
 arch/arm/boot/dts/omap2420.dtsi           |    2 +-
 arch/arm/boot/dts/omap2430.dtsi           |    2 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts     |    8 +-
 arch/arm/boot/dts/omap3-beagle.dts        |   34 ++++----
 arch/arm/boot/dts/omap3-devkit8000.dts    |   10 +-
 arch/arm/boot/dts/omap3-evm.dts           |    6 +-
 arch/arm/boot/dts/omap3-igep.dtsi         |   36 ++++----
 arch/arm/boot/dts/omap3-igep0020.dts      |   10 +-
 arch/arm/boot/dts/omap3-igep0030.dts      |   10 +-
 arch/arm/boot/dts/omap3-overo.dtsi        |    4 +-
 arch/arm/boot/dts/omap3-tobi.dts          |    4 +-
 arch/arm/boot/dts/omap3.dtsi              |    5 +-
 arch/arm/boot/dts/omap3430-sdp.dts        |    4 +-
 arch/arm/boot/dts/omap34xx.dtsi           |    2 +-
 arch/arm/boot/dts/omap36xx.dtsi           |    2 +-
 arch/arm/boot/dts/omap4-panda-a4.dts      |   10 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi |   66 ++++++++--------
 arch/arm/boot/dts/omap4-panda-es.dts      |   10 +-
 arch/arm/boot/dts/omap4-panda.dts         |    4 +-
 arch/arm/boot/dts/omap4-sdp-es23plus.dts  |    8 +-
 arch/arm/boot/dts/omap4-sdp.dts           |  122 ++++++++++++++--------------
 arch/arm/boot/dts/omap4-var-som.dts       |    8 +-
 arch/arm/boot/dts/omap4.dtsi              |  118 ++++++++++++++-------------
 arch/arm/boot/dts/omap443x.dtsi           |    2 +-
 arch/arm/boot/dts/omap4460.dtsi           |    6 +-
 arch/arm/boot/dts/omap5-evm.dts           |   92 +++++++++++-----------
 arch/arm/boot/dts/omap5.dtsi              |  126 +++++++++++++++--------------
 include/dt-bindings/pinctrl/omap.h        |   50 +++++++++++
 30 files changed, 416 insertions(+), 352 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/omap.h

-- 
1.7.5.4

