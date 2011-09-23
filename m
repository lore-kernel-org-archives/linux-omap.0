From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 06/11] arm/dts: Add support for OMAP3 Beagle board
Date: Fri, 23 Sep 2011 22:23:14 +0200
Message-ID: <1316809399-19579-7-git-send-email-b-cousson@ti.com>
References: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49173 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752251Ab1IWUYl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Sep 2011 16:24:41 -0400
In-Reply-To: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, grant.likely@secretlab.ca
Cc: paul@pwsan.com, khilman@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>

Add OMAP3 beagleboard DTS file to use the omap3.dtsi
SoC file.

Add a default bootargs line to allow a boot from RAMDISK

Add memory node information.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: G, Manjunath Kondaiah <manjugk@ti.com>
---
 arch/arm/boot/dts/omap3-beagle.dts |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-beagle.dts

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
new file mode 100644
index 0000000..9486be6
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+/include/ "omap3.dtsi"
+
+/ {
+	model = "TI OMAP3 BeagleBoard";
+	compatible = "ti,omap3-beagle", "ti,omap3";
+
+	/*
+	 * Since the initial device tree board file does not create any
+	 * devices (MMC, network...), the only way to boot is to provide a
+	 * ramdisk.
+	 */
+	chosen {
+		bootargs = "root=/dev/ram0 rw console=ttyO2,115200n8 initrd=0x81600000,20M ramdisk_size=20480 no_console_suspend debug earlyprintk";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>; /* 512 MB */
+	};
+};
-- 
1.7.0.4

