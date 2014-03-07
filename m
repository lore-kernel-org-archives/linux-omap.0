From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH v4 0/9] ARM: dts: Better support for Gumstix Overo (for 3.15?)
Date: Fri,  7 Mar 2014 20:22:10 +0100
Message-ID: <1394220139-1760-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:45124 "EHLO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752387AbaCGTW2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Mar 2014 14:22:28 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: Roger Quadros <rogerq@ti.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello Tony, Benoit,

This is the fourth version of my Overo series. Compared to v3, I reorganized
a bit the include files (omap3-overo.dtsi -> omap3-overo-base.dtsi and created
SoC-specific omap3-overo.dtsi and omap3-overo-storm.dtsi). This was necessary
to correctly define the pinmux for the processor board's pins belonging to the
omap3_pmx_core2 pinctrl. For details, see the discussion on the v3 [1].

Most patches are pretty obvious. Patch 6 adds some specific timings for
LAN9221 into a generic file. By using shorter timing, it is possible to
double the Ethernet bandwidth. Thus is may interest people using a similar
chip.

I tested this series with both the OMAP35xx Overo and the OMAP36xx Overo.
Wifi and Bluetooth are functional, HSUSB works.

Note: I hope that this can go into 3.15, since the patches were first
posted before the 3.14 merge window. They add a number of useful peripherals,
so this would be much appreciated.

Regards,
Florian

[1] http://thread.gmane.org/gmane.linux.ports.arm.omap/111143

Florian Vaussard (9):
  ARM: dts: overo: reorganize include files
  ARM: dts: omap3-tobi: Add missing pinctrl
  ARM: dts: omap3-overo: Add missing pinctrl
  ARM: dts: omap3-overo: Enable WiFi/BT combo
  ARM: dts: omap3-overo: Add HSUSB PHY
  ARM: dts: omap: Add common file for SMSC9221
  ARM: dts: omap3-tobi: Use include file omap-gpmc-smsc9221
  ARM: dts: omap3-tobi: Add AT24C01 EEPROM
  ARM: dts: overo: Push uart3 pinmux down to expansion board

 arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi      |  58 +++++++
 arch/arm/boot/dts/omap3-overo-base.dtsi        | 221 +++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-overo-storm-tobi.dts   |   2 +-
 arch/arm/boot/dts/omap3-overo-storm.dtsi       |  35 ++++
 arch/arm/boot/dts/omap3-overo-tobi-common.dtsi |  67 ++++----
 arch/arm/boot/dts/omap3-overo-tobi.dts         |   2 +-
 arch/arm/boot/dts/omap3-overo.dtsi             |  97 +++--------
 7 files changed, 365 insertions(+), 117 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-overo-base.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-overo-storm.dtsi

-- 
1.8.3.2

