From: Benoit Cousson <b-cousson@ti.com>
Subject: [RFC PATCH 3/7] arm/dts: Update OMAP4 Panda to include common omap4.dtsi
Date: Wed, 24 Aug 2011 12:17:16 +0200
Message-ID: <1314181040-22807-4-git-send-email-b-cousson@ti.com>
References: <1314181040-22807-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35511 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756596Ab1HXKTL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Aug 2011 06:19:11 -0400
In-Reply-To: <1314181040-22807-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, devicetree-discuss@lists.ozlabs.org, manjugk@ti.com, Benoit Cousson <b-cousson@ti.com>

Based on the original omap4-panda.dts file from Manju.
http://www.spinics.net/lists/linux-omap/msg55836.html

Add memory information and a default bootargs to allow
a boot from RAMDISK.

Add missing header.

Include the common omap4.dtsi.

Add a "ti,omap4" compatible value for OMAP4 based boards.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: G, Manjunath Kondaiah <manjugk@ti.com>
---
 arch/arm/boot/dts/omap4-panda.dts |   28 +++++++++++++++++++++++-----
 1 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index 58909e9..c702657 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -1,11 +1,29 @@
+/*
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
 /dts-v1/;
 
-/memreserve/ 0x9D000000 0x03000000; /* Frame buffer */
-/memreserve/ 0xB0000000 0x10000000; /* Top 256MB is unaccessable */
-
-/include/ "skeleton.dtsi"
+/include/ "omap4.dtsi"
 
 / {
 	model = "TI OMAP4 PandaBoard";
-	compatible = "ti,omap4-panda", "ti,omap4430";
+	compatible = "ti,omap4-panda", "ti,omap4430", "ti,omap4";
+
+	/*
+	 * Since the initial device tree board file does not create any
+	 * devices (MMC, network...), the only way to boot is to provide a
+	 * ramdisk.
+	 */
+	chosen {
+		bootargs = "root=/dev/ram0 rw console=ttyO2,115200n8 initrd=0x81600000,20M ramdisk_size=20480 no_console_suspend debug";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>; /* 1 GB */
+	};
 };
-- 
1.7.0.4

