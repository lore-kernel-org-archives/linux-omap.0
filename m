From: Joachim Eastwood <manabian@gmail.com>
Subject: [PATCH 0/4] Support for Variscite OM44 modules and boards
Date: Fri, 18 Apr 2014 17:10:45 +0200
Message-ID: <1397833849-22396-1-git-send-email-manabian@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:59079 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbaDRPLB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2014 11:11:01 -0400
Received: by mail-lb0-f182.google.com with SMTP id n15so1455161lbi.13
        for <linux-omap@vger.kernel.org>; Fri, 18 Apr 2014 08:11:00 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, bcousson@baylibre.com
Cc: linux-arm-kernel@lists.infradead.org, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, Joachim Eastwood <manabian@gmail.com>

Hello,

This patch set adds support for Variscite OM44 series of system on modules and boards.

Patch 1: Add support for the SoM itself and the reference carrier board. Together these make the VAR-STK-OM44 dev kit.

Patch 2: Add support for VAR-DVK-OM44 which is just the STK with a LCD display.

Last two patches add support for the WLAN/BT version of the SoM. If DT bindings for wl12xx gets ready for 3.16 the last patch, adding quirks, can be dropped.

Note that patch 1 relies upon a patch from Tomi Valkeinen add hpd-gpio (hotplug detect) to the "hdmi-connector".
See: http://marc.info/?l=linux-omap&m=139771947508021&w=2

Patch 2 also relies upon a patch from Tomi that adds DT support to panel-dpi.
See: http://marc.info/?l=devicetree&m=139030201815380&w=2

If it makes it easier to merge this patch set without the two dependencies above I can move the display stuff the separate patches.
This patch set replace the patch posted eariler here: http://marc.info/?l=linux-omap&m=139732809411445&w=2

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

