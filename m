From: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Subject: [RFC PATCH v2 0/6] ARM: OMAP3+: Introduce ABB driver
Date: Mon, 15 Apr 2013 16:28:05 +0300
Message-ID: <1366032491-4162-1-git-send-email-andrii.tseglytskyi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46167 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741Ab3DON2O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Apr 2013 09:28:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>

From: "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>

Following patch series introduces the Adaptive Body-Bias
LDO driver, which handles LDOs voltage during OPP change routine.
Current implementation is based on patch series from
Mike Turquette:

http://marc.info/?l=linux-omap&m=134931341818379&w=2

ABB transition is a part of OPP changing sequence.
ABB can operate in the following modes:
- Bypass mode: Activated when ABB is not required
- FBB mode: Fast Body Bias mode, used on fast OPPs
- RBB mode: Reverse Body Bias mode, used on slow OPPs

In current implementation ABB is converted to regulator.
Standalone OPP table is used to store ABB mode, it is defined
in device tree for each ABB regulator. It has the following format:

operating-points = <
	       /* uV   ABB (0 - Bypass, 1 - FBB, 2 - RBB) */
	       880000		0
	       1060000		1
	       1250000		1
	       1260000		1
>;

ABB regulator is linked to regulator chain.

Related discussions:
regulator: query on regulator re-entrance
http://marc.info/?l=linux-omap&m=136513861315970&w=2

regulator: core: introduce regulator chain locking scheme
https://patchwork.kernel.org/patch/2445091/

clk: notifier handler for dynamic voltage scaling
https://lkml.org/lkml/2013/2/27/414

Andrii.Tseglytskyi (6):
  ARM: dts: OMAP36xx: add device tree for ABB
  ARM: dts: OMAP4: add device tree for ABB
  ARM: dts: OMAP5: add device tree for ABB
  ARM: OMAP3+: ABB: add aliases for sysclk used in ABB driver
  ARM: OMAP3+: ABB: introduce ABB driver
  ARM: OMAP3+: ABB: introduce debugfs entry

 Documentation/devicetree/bindings/power/abb.txt |   38 ++
 arch/arm/boot/dts/omap36xx.dtsi                 |   20 +
 arch/arm/boot/dts/omap4.dtsi                    |   22 +
 arch/arm/boot/dts/omap443x.dtsi                 |   23 +
 arch/arm/boot/dts/omap446x.dtsi                 |   39 ++
 arch/arm/boot/dts/omap5.dtsi                    |   39 ++
 arch/arm/mach-omap2/cclock3xxx_data.c           |    1 +
 arch/arm/mach-omap2/cclock44xx_data.c           |    2 +
 drivers/regulator/Kconfig                       |    6 +
 drivers/regulator/Makefile                      |    1 +
 drivers/regulator/abb-regulator.c               |  710 +++++++++++++++++++++++
 11 files changed, 901 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/abb.txt
 create mode 100644 arch/arm/boot/dts/omap446x.dtsi
 create mode 100644 drivers/regulator/abb-regulator.c

-- 
1.7.9.5

