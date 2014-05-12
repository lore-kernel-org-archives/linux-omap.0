From: Joachim Eastwood <manabian@gmail.com>
Subject: [PATCH v3 0/4] Support for Variscite OM44 modules and boards
Date: Mon, 12 May 2014 20:31:59 +0200
Message-ID: <1399919523-20330-1-git-send-email-manabian@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:41009 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924AbaELScm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 14:32:42 -0400
Received: by mail-la0-f48.google.com with SMTP id mc6so2217653lab.21
        for <linux-omap@vger.kernel.org>; Mon, 12 May 2014 11:32:41 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, bcousson@baylibre.com
Cc: linux-arm-kernel@lists.infradead.org, paul@pwsan.com, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, Joachim Eastwood <manabian@gmail.com>

Hello,

This patch set adds support for Variscite OM44 series of system on
modules and boards.

Changes v3:
 * Use new OMAP4_IOPAD macro
 * Add Tomi's Ack for patches with DSS DT nodes
 * Rebase on Tony's omap-for-v3.16/dt branch
v2:
 * Use OMAP IOPAD macros

Patch 1: Add support for the SoM itself and the reference carrier
board. Together these make the VAR-STK-OM44 dev kit.

Patch 2: Add support for VAR-DVK-OM44 which is just the STK with
a LCD display.

Patch 3: Nodes for WLAN/BT support.

Patch 4: Add quirks so that WLAN can be used. Still waiting for
proper DT bindings.

Since this patch set uses the new OMAP4_IOPAD macro the follow patch
must be applied: https://patchwork.kernel.org/patch/4160561/

Note that patch 1 and 2 relies upon the DSS panel and HDMI hpq DT
patches from Tomi Valkeinen. See Tomi's 3.16/omap branch.

The branch from Tomi mentioned above is destined for 3.16.

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
 arch/arm/boot/dts/omap4-var-som-om44.dtsi          | 343 +++++++++++++++++++++
 arch/arm/boot/dts/omap4-var-som.dts                |  96 ------
 arch/arm/boot/dts/omap4-var-stk-om44.dts           |  17 +
 arch/arm/mach-omap2/pdata-quirks.c                 |   7 +
 10 files changed, 750 insertions(+), 97 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap4-var-dvk-om44.dts
 create mode 100644 arch/arm/boot/dts/omap4-var-om44customboard.dtsi
 create mode 100644 arch/arm/boot/dts/omap4-var-som-om44-wlan.dtsi
 create mode 100644 arch/arm/boot/dts/omap4-var-som-om44.dtsi
 delete mode 100644 arch/arm/boot/dts/omap4-var-som.dts
 create mode 100644 arch/arm/boot/dts/omap4-var-stk-om44.dts

-- 
1.8.0

