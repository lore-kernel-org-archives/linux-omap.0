From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH v3 0/7] ARM: dts: Better support for Gumstix Overo (for 3.15?)
Date: Mon,  3 Mar 2014 10:34:00 +0100
Message-ID: <1393839247-6516-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:41429 "EHLO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752263AbaCCJeZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Mar 2014 04:34:25 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, florian.vaussard@epfl.ch

Hello Tony, Benoit,

This is the third version of my Overo series. No major changes since v2,
I just dropped the patch related to the "ti,use_poweroff" binding, and
will address this issue later.

Most patches are pretty obvious. Patch 5 adds some specific timings for
LAN9221 into a generic file. By using shorter timing, it is possible to
double the Ethernet bandwidth. Thus is may interest people using a similar
chip.

I tested this series with both the OMAP35xx Overo and the OMAP36xx Overo.
Wifi is functional, HSUSB works.

Note: I hope that this can go into 3.15, since the patches were first
posted before the 3.14 merge window. They add a number of useful peripherals,
so this would be much appreciated.


Regards,
Florian


Florian Vaussard (7):
  ARM: dts: omap3-tobi: Add missing pinctrl
  ARM: dts: omap3-overo: Add missing pinctrl
  ARM: dts: omap3-overo: Enable WiFi/BT combo
  ARM: dts: omap3-overo: Add HSUSB PHY
  ARM: dts: omap: Add common file for SMSC9221
  ARM: dts: omap3-tobi: Use include file omap-gpmc-smsc9221
  ARM: dts: omap3-tobi: Add AT24C01 EEPROM

 arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi      |  58 +++++++++++
 arch/arm/boot/dts/omap3-overo-storm-tobi.dts   |  24 +++++
 arch/arm/boot/dts/omap3-overo-tobi-common.dtsi |  48 ++++-----
 arch/arm/boot/dts/omap3-overo-tobi.dts         |  24 +++++
 arch/arm/boot/dts/omap3-overo.dtsi             | 138 +++++++++++++++++++++++--
 5 files changed, 258 insertions(+), 34 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi

-- 
1.8.3.2

