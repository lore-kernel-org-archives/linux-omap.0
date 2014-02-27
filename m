From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH v2 0/8] ARM: dts: Better support for Gumstix Overo
Date: Thu, 27 Feb 2014 21:30:24 +0100
Message-ID: <1393533032-1619-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:39885 "EHLO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750942AbaB0Uar (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Feb 2014 15:30:47 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

Hello Tony, Benoit,

This is the second version of my Overo series.
Compared to the first version [1], I decided to split it into three parts:

1) Extend current support for Overo/Tobi boards (this part)
2) Add new expansion boards
3) Add display support based on Tomi's DSS series

I will send 2) and 3) in a couple of days.

Most patches are pretty obvious. Patch 6 adds some specific timings for
LAN9221 into a generic file. By using shorter timing, it is possible to
double the Ethernet bandwidth. Thus is may interest people using a similar
chip.

I tested this series with both the OMAP35xx Overo and the OMAP36xx Overo.
Wifi is functional, HSUSB works.

Regards,

Florian

[1] http://thread.gmane.org/gmane.linux.ports.arm.omap/109589

Florian Vaussard (8):
  ARM: dts: omap3-tobi: Add missing pinctrl
  ARM: dts: omap3-overo: Add missing pinctrl
  ARM: dts: omap3-overo: Use complete poweroff
  ARM: dts: omap3-overo: Enable WiFi/BT combo
  ARM: dts: omap3-overo: Add HSUSB PHY
  ARM: dts: omap: Add common file for SMSC9221
  ARM: dts: omap3-tobi: Use include file omap-gpmc-smsc9221
  ARM: dts: omap3-tobi: Add AT24C01 EEPROM

 arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi      |  58 ++++++++++
 arch/arm/boot/dts/omap3-overo-storm-tobi.dts   |  24 +++++
 arch/arm/boot/dts/omap3-overo-tobi-common.dtsi |  48 ++++-----
 arch/arm/boot/dts/omap3-overo-tobi.dts         |  24 +++++
 arch/arm/boot/dts/omap3-overo.dtsi             | 143 +++++++++++++++++++++++--
 5 files changed, 263 insertions(+), 34 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi

-- 
1.8.5.3

