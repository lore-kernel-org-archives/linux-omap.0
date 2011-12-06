From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 2/3] arm/dts: OMAP: Remove bootargs node from board files
Date: Tue, 6 Dec 2011 17:49:08 +0100
Message-ID: <1323190149-6492-3-git-send-email-b-cousson@ti.com>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47781 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846Ab1LFQuI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Dec 2011 11:50:08 -0500
In-Reply-To: <y>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>

Since 3.2, the CONFIG_ARM_ATAG_DTB_COMPAT config allows
an old bootloader to still use ATAG to provide cmdline.

Remove chosen/bootargs from the DTS board files.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/boot/dts/omap3-beagle.dts |    9 ---------
 arch/arm/boot/dts/omap4-panda.dts  |    9 ---------
 arch/arm/boot/dts/omap4-sdp.dts    |    9 ---------
 3 files changed, 0 insertions(+), 27 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 9486be6..9f72cd4 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -13,15 +13,6 @@
 	model = "TI OMAP3 BeagleBoard";
 	compatible = "ti,omap3-beagle", "ti,omap3";
 
-	/*
-	 * Since the initial device tree board file does not create any
-	 * devices (MMC, network...), the only way to boot is to provide a
-	 * ramdisk.
-	 */
-	chosen {
-		bootargs = "root=/dev/ram0 rw console=ttyO2,115200n8 initrd=0x81600000,20M ramdisk_size=20480 no_console_suspend debug earlyprintk";
-	};
-
 	memory {
 		device_type = "memory";
 		reg = <0x80000000 0x20000000>; /* 512 MB */
diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index c702657..9755ad5 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -13,15 +13,6 @@
 	model = "TI OMAP4 PandaBoard";
 	compatible = "ti,omap4-panda", "ti,omap4430", "ti,omap4";
 
-	/*
-	 * Since the initial device tree board file does not create any
-	 * devices (MMC, network...), the only way to boot is to provide a
-	 * ramdisk.
-	 */
-	chosen {
-		bootargs = "root=/dev/ram0 rw console=ttyO2,115200n8 initrd=0x81600000,20M ramdisk_size=20480 no_console_suspend debug";
-	};
-
 	memory {
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>; /* 1 GB */
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 066e28c..63c6b2b 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -13,15 +13,6 @@
 	model = "TI OMAP4 SDP board";
 	compatible = "ti,omap4-sdp", "ti,omap4430", "ti,omap4";
 
-	/*
-	 * Since the initial device tree board file does not create any
-	 * devices (MMC, network...), the only way to boot is to provide a
-	 * ramdisk.
-	 */
-	chosen {
-		bootargs = "root=/dev/ram0 rw console=ttyO2,115200n8 initrd=0x81600000,20M ramdisk_size=20480 no_console_suspend debug";
-	};
-
 	memory {
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>; /* 1 GB */
-- 
1.7.0.4

