From: Joachim Eastwood <manabian@gmail.com>
Subject: [PATCH v2 0/4] Support for Variscite OM44 modules and boards
Date: Thu,  1 May 2014 21:07:45 +0200
Message-ID: <1398971269-20515-1-git-send-email-manabian@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:52247 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbaEATIA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 May 2014 15:08:00 -0400
Received: by mail-la0-f51.google.com with SMTP id gl10so2476170lab.10
        for <linux-omap@vger.kernel.org>; Thu, 01 May 2014 12:07:59 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, bcousson@baylibre.com
Cc: linux-arm-kernel@lists.infradead.org, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, Joachim Eastwood <manabian@gmail.com>

Hello,

This patch set adds support for Variscite OM44 series of system on modules and boards.

There weren't many comments on v1 of this patch set so I hope this can make it into 3.16.
Changes since v2:
 * Use OMAP IOPAD macros

Patch 1: Add support for the SoM itself and the reference carrier board. Together these make the VAR-STK-OM44 dev kit.
Patch 2: Add support for VAR-DVK-OM44 which is just the STK with a LCD display.
Patch 3: Nodes for WLAN/BT support.
Patch 4: Add quirks so that WLAN can be used. Still waiting for proper DT bindings.

Since this patch set now uses the IOPAD macros a fix from Tony is need.
See: https://patchwork.kernel.org/patch/4025421/

Note that patch 1 relies upon a patch from Tomi Valkeinen add hpd-gpio (hotplug detect) to the "hdmi-connector".
See: http://marc.info/?l=linux-omap&m=139771947508021&w=2

Patch 2 also relies upon a patch from Tomi that adds DT support to panel-dpi.
See: http://marc.info/?l=devicetree&m=139030201815380&w=2

The Patches from Tony and Tomi mentioned above is destined for 3.16.

Joachim Eastwood (4):
  ARM: dts: Add support for OMAP4 Variscite OM44 family
  ARM: dts: Add support for OMAP4 VAR-DVK-OM44
  ARM: dts: Add VAR-SOM-OM44 WLAN nodes
  ARM: OMAP2+: Use pdata quirks for wl12xx on VAR-STK/DVK-OM44

 .../devicetree/bindings/arm/omap/omap.txt          |   6 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/omap4-var-dvk-om44.dts           |  71 +++++
 arch/arm/boot/dts/omap4-var-om44customboard.dtsi   | 235 ++++++++++++++
 arch/arm/boot/dts/omap4-var-som-om44-wlan.dtsi     |  68 ++++
 arch/arm/boot/dts/omap4-var-som-om44.dtsi          | 344 +++++++++++++++++++++
 arch/arm/boot/dts/omap4-var-som.dts                |  96 ------
 arch/arm/boot/dts/omap4-var-stk-om44.dts           |  17 +
 arch/arm/mach-omap2/pdata-quirks.c                 |   7 +
 10 files changed, 751 insertions(+), 97 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap4-var-dvk-om44.dts
 create mode 100644 arch/arm/boot/dts/omap4-var-om44customboard.dtsi
 create mode 100644 arch/arm/boot/dts/omap4-var-som-om44-wlan.dtsi
 create mode 100644 arch/arm/boot/dts/omap4-var-som-om44.dtsi
 delete mode 100644 arch/arm/boot/dts/omap4-var-som.dts
 create mode 100644 arch/arm/boot/dts/omap4-var-stk-om44.dts

-- 
1.8.0

