From: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Subject: [PATCH 2/2] ARM: dts: AM33XX: Add support for IGEP AQUILA EXPANSION board.
Date: Wed, 19 Jun 2013 10:27:03 +0200
Message-ID: <1371630423-2481-3-git-send-email-eballetbo@iseebcn.com>
References: <1371630423-2481-1-git-send-email-eballetbo@iseebcn.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:60134 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934052Ab3FSI1P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jun 2013 04:27:15 -0400
Received: by mail-wg0-f44.google.com with SMTP id m15so4202207wgh.11
        for <linux-omap@vger.kernel.org>; Wed, 19 Jun 2013 01:27:14 -0700 (PDT)
In-Reply-To: <1371630423-2481-1-git-send-email-eballetbo@iseebcn.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>

The IGEP AQUILA EXPANSION board is a development platform for the IGEP COM
AQUILA AM335x boards.

The board adds the following connectivity:

    o USB OTG
    o USB HOST
    o HDMI
    o Ethernet
    o Serial Debug (3.3V)
    o 2x46 pin headers
    o EEPROM

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
---
 arch/arm/boot/dts/Makefile            |  1 +
 arch/arm/boot/dts/am335x-base0033.dts | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-base0033.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 8e50761..cb675d2 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -154,6 +154,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	am335x-evm.dtb \
 	am335x-evmsk.dtb \
 	am335x-bone.dtb \
+	am335x-base0033.dtb \
 	am3517-evm.dtb \
 	am3517_mt_ventoux.dtb
 dtb-$(CONFIG_ARCH_ORION5X) += orion5x-lacie-ethernet-disk-mini-v2.dtb
diff --git a/arch/arm/boot/dts/am335x-base0033.dts b/arch/arm/boot/dts/am335x-base0033.dts
new file mode 100644
index 0000000..a365f11
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-base0033.dts
@@ -0,0 +1,17 @@
+/*
+ * Copyright (C) 2013 ISEE 2007 SL - http://www.isee.biz/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * IGEP AQUILA Expansion Board.
+ * 
+ */
+
+#include "am335x-igep0033.dtsi"
+
+/ {
+	model = "IGEP COM AM335x on AQUILA Expansion";
+	compatible = "ti,am335x-base0033", "ti,am335x-igep0033", "ti,am33xx";
+};
-- 
1.8.1.2

