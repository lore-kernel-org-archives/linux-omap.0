From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH 00/12] ARM: dts: sbc-t3x: add support for more boards
Date: Sun, 19 Jan 2014 10:48:55 +0200
Message-ID: <1390121335-4917-1-git-send-email-lifshitz@compulab.co.il>
References: <1389532975-28281-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:40711 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818AbaASItT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 19 Jan 2014 03:49:19 -0500
In-Reply-To: <1389532975-28281-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This is the fixed cover letter.
The previous one was not consistent with respect to the actual path set.

Add support for CompuLab SBC-T3530 and SBC-T3517 boards:

https://compulab.co.il/products/sbcs/sbc-t3530/
https://compulab.co.il/products/sbcs/sbc-t3517/

along with respective CoMs - CM-T3530 and CM-T3517:

https://compulab.co.il/products/computer-on-modules/cm-t3530/
https://compulab.co.il/products/computer-on-modules/cm-t3517/

The device tree files have the following structure:

omap3-cm-t3x.dtsi
 |
 |<-- omap3-cm-t3x30.dtsi
 |     |
 |     |
 |     |     -----                  -------          ------------
 |     |    | CoM |                | Board |        | Base board |
 |     |     -----                  -------          ------------
 |     |                                            omap3-sb-t35.dtsi
 |     |                                                  |
 |     |<-- omap3-cm-t3730.dts <-- omap3-sbc-t3730.dts -->|
 |     |                                                  |
 |     |<-- omap3-cm-t3530.dts <-- omap3-sbc-t3530.dts -->|
 |                                                        |
 |<-------- omap3-cm-t3517.dts <-- omap3-sbc-t3517.dts -->|


where omap3-cm-t3730.dts, omap3-cm-t3530.dts, omap3-cm-t3517.dts
contain CoMs specific data, while omap3-sbc-t3730.dts, omap3-sbc-t3530.dts,
omap3-sbc-t3517.dts represent eval boards with respective core modules.

This series is based on Tony's omap-for-v3.14/dt branch

Dmitry Lifshitz (12):
  ARM: dts: sbc-t3x: use omap specific pinctrl defines
  ARM: dts: sbc-t3x: refactor DT support
  ARM: dts: sbc-t3x: disable mmc3
  ARM: dts: sb-t35: fix Ethernet power supply
  ARM: dts: cm-t3x: add gpio-led pinmux
  ARM: dts: cm-t3x30: add twl4030 gpio pullups
  ARM: dts: cm-t3x30: add HS USB Host support
  ARM: dts: sbc-t3730: add pinmux for usb hub reset
  ARM: dts: cm-t3x30: add USB OTG support
  ARM: dts: sbc-t3530: add support for sbc-t3530
  ARM: dts: sbc-t3517: add support for sbc-t3517
  ARM: OMAP2+: make reset pulse for sbc-t3x usb hubs

 arch/arm/boot/dts/Makefile            |    4 +
 arch/arm/boot/dts/omap3-cm-t3517.dts  |  136 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-cm-t3530.dts  |   12 +++
 arch/arm/boot/dts/omap3-cm-t3730.dts  |   57 ++------------
 arch/arm/boot/dts/omap3-cm-t3x.dtsi   |  110 ++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-cm-t3x30.dtsi |   74 +++++++++++++-----
 arch/arm/boot/dts/omap3-sb-t35.dtsi   |   29 +++++++-
 arch/arm/boot/dts/omap3-sbc-t3517.dts |   43 ++++++++++
 arch/arm/boot/dts/omap3-sbc-t3530.dts |   36 +++++++++
 arch/arm/boot/dts/omap3-sbc-t3730.dts |   23 +++---
 arch/arm/mach-omap2/pdata-quirks.c    |   67 ++++++++++++++++-
 11 files changed, 506 insertions(+), 85 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-cm-t3517.dts
 create mode 100644 arch/arm/boot/dts/omap3-cm-t3530.dts
 create mode 100644 arch/arm/boot/dts/omap3-cm-t3x.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-sbc-t3517.dts
 create mode 100644 arch/arm/boot/dts/omap3-sbc-t3530.dts

-- 
1.7.5.4

