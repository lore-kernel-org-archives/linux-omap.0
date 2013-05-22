From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 0/5] ARM: dts: OMAP2+: use preprocessor for device trees
Date: Wed, 22 May 2013 16:27:39 +0200
Message-ID: <1369232864-14460-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:35761 "HELO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755409Ab3EVO2T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 May 2013 10:28:19 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Stephen Warren <swarren@wwwdotorg.org>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

Hello,

Following a similar proposal by Stephen Warren for tegra [1], this series
makes use of the C preprocessor when compiling OMAP DT files, and
accomplishes some improvements to improve overall readability.

Patch 2 creates a header file to define the OMAP_GPIO() macro, used by
patch 3 to make GPIOs more readable.
Likewise patch 5 uses the existing constants to make IRQs more readable.
Patch 4 is a small random fix.

This series was boot-tested on omap3-tobi. For other targets, the
decompiled .dtb were diff'ed before and after applying the series
to guarantee identity.

Best regards,

Florian

[1] https://patchwork.kernel.org/patch/2560091/

Florian Vaussard (5):
  ARM: dts: OMAP2+: use #include for all device trees
  ARM: dts: OMAP2+: create a DT header for GPIO
  ARM: dts: OMAP2+: convert DT files to use the new OMAP_GPIO macro
  ARM: dts: OMAP3: fix incorrect notation for musb-hdrc interrupt
  ARM: dts: OMAP4/5: use existing constants for IRQs

 arch/arm/boot/dts/omap2.dtsi              |    4 +-
 arch/arm/boot/dts/omap2420-h4.dts         |    2 +-
 arch/arm/boot/dts/omap2420.dtsi           |    2 +-
 arch/arm/boot/dts/omap2430.dtsi           |    2 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts     |    8 +-
 arch/arm/boot/dts/omap3-beagle.dts        |   10 +-
 arch/arm/boot/dts/omap3-devkit8000.dts    |   10 +-
 arch/arm/boot/dts/omap3-evm.dts           |    4 +-
 arch/arm/boot/dts/omap3-igep.dtsi         |    4 +-
 arch/arm/boot/dts/omap3-igep0020.dts      |    8 +-
 arch/arm/boot/dts/omap3-igep0030.dts      |    4 +-
 arch/arm/boot/dts/omap3-overo.dtsi        |    4 +-
 arch/arm/boot/dts/omap3-tobi.dts          |    4 +-
 arch/arm/boot/dts/omap3.dtsi              |    6 +-
 arch/arm/boot/dts/omap3430-sdp.dts        |    4 +-
 arch/arm/boot/dts/omap34xx.dtsi           |    2 +-
 arch/arm/boot/dts/omap36xx.dtsi           |    2 +-
 arch/arm/boot/dts/omap4-panda-a4.dts      |    4 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi |   18 +-
 arch/arm/boot/dts/omap4-panda-es.dts      |    4 +-
 arch/arm/boot/dts/omap4-panda.dts         |    4 +-
 arch/arm/boot/dts/omap4-sdp-es23plus.dts  |    2 +-
 arch/arm/boot/dts/omap4-sdp.dts           |   32 ++--
 arch/arm/boot/dts/omap4-var-som.dts       |    8 +-
 arch/arm/boot/dts/omap4.dtsi              |  117 ++++++------
 arch/arm/boot/dts/omap443x.dtsi           |    2 +-
 arch/arm/boot/dts/omap4460.dtsi           |    6 +-
 arch/arm/boot/dts/omap5-evm.dts           |    4 +-
 arch/arm/boot/dts/omap5.dtsi              |  125 +++++++------
 include/dt-bindings/gpio/omap-gpio.h      |  289 +++++++++++++++++++++++++++++
 30 files changed, 497 insertions(+), 198 deletions(-)
 create mode 100644 include/dt-bindings/gpio/omap-gpio.h

-- 
1.7.5.4

