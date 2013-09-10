From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH 2/2] ARM: dts: AM33XX: Add support for IGEP AQUILA EXPANSION board.
Date: Tue, 10 Sep 2013 16:55:49 +0200
Message-ID: <1378824949-18792-3-git-send-email-eballetbo@gmail.com>
References: <1378824949-18792-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f171.google.com ([209.85.215.171]:50776 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001Ab3IJO5G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Sep 2013 10:57:06 -0400
Received: by mail-ea0-f171.google.com with SMTP id n15so3958843ead.16
        for <linux-omap@vger.kernel.org>; Tue, 10 Sep 2013 07:57:05 -0700 (PDT)
In-Reply-To: <1378824949-18792-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>, Enric Balletbo i Serra <eballetbo@iseebcn.com>

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
Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/Makefile            |  1 +
 arch/arm/boot/dts/am335x-base0033.dts | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-base0033.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 641b3c9..12c2949 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -171,6 +171,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	am335x-evm.dtb \
 	am335x-evmsk.dtb \
 	am335x-bone.dtb \
+	am335x-base0033.dtb \
 	am3517-evm.dtb \
 	am3517_mt_ventoux.dtb \
 	am43x-epos-evm.dtb
diff --git a/arch/arm/boot/dts/am335x-base0033.dts b/arch/arm/boot/dts/am335x-base0033.dts
new file mode 100644
index 0000000..7a079db
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-base0033.dts
@@ -0,0 +1,16 @@
+/*
+ * am335x-base0033.dtsi - Device Tree file for IGEP AQUILA EXPANSION
+ *
+ * Copyright (C) 2013 ISEE 2007 SL - http://www.isee.biz
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "am335x-igep0033.dtsi"
+
+/ {
+	model = "IGEP COM AM335x on AQUILA Expansion";
+	compatible = "isee,am335x-base0033", "isee,am335x-igep0033", "ti,am33xx";
+};
-- 
1.8.1.2

