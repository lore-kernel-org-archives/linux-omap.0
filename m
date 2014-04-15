From: Robert Nelson <robertcnelson@gmail.com>
Subject: [PATCH] ARM: dts: Add support for the BeagleBoard xM A/B
Date: Tue, 15 Apr 2014 10:09:59 -0500
Message-ID: <1397574599-29573-1-git-send-email-robertcnelson@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:57441 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbaDOPKG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Apr 2014 11:10:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Robert Nelson <robertcnelson@gmail.com>

BeagleBoard xM A/B has an inverted usb hub enable line vs the xM C

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
---
 arch/arm/boot/dts/Makefile               |  1 +
 arch/arm/boot/dts/omap3-beagle-xm-ab.dts | 15 +++++++++++++++
 2 files changed, 16 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap3-beagle-xm-ab.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 35c146f..0bdeba3 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -246,6 +246,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	omap3-sbc-t3730.dtb \
 	omap3-devkit8000.dtb \
 	omap3-beagle-xm.dtb \
+	omap3-beagle-xm-ab.dtb \
 	omap3-evm.dtb \
 	omap3-evm-37xx.dtb \
 	omap3-ldp.dtb \
diff --git a/arch/arm/boot/dts/omap3-beagle-xm-ab.dts b/arch/arm/boot/dts/omap3-beagle-xm-ab.dts
new file mode 100644
index 0000000..9d81123
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-beagle-xm-ab.dts
@@ -0,0 +1,15 @@
+/*
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "omap3-beagle-xm.dts"
+
+/ {
+	/* HS USB Port 2 Power enable was inverted with the xM C */
+	hsusb2_power: hsusb2_power_reg {
+		enable-active-high;
+};
-- 
1.9.1

