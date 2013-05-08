From: Jason Cooper <jason@lakedaemon.net>
Subject: [RFC PATCH 3/3] ARM: omap3: wireless plus gpmc wip
Date: Wed,  8 May 2013 19:23:34 +0000
Message-ID: <35ebdefa151c2f2d49ccfed5ddba0cd627963581.1368038129.git.jason@lakedaemon.net>
References: <cover.1368038129.git.jason@lakedaemon.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:57539 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753196Ab3EHTX6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 May 2013 15:23:58 -0400
In-Reply-To: <cover.1368038129.git.jason@lakedaemon.net>
In-Reply-To: <cover.1368038129.git.jason@lakedaemon.net>
References: <cover.1368038129.git.jason@lakedaemon.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>

Need this in order to add the nand node and then the partitions.

in it's current state, crashes the system. :(
---
 arch/arm/boot/dts/omap3-wireless_plus.dts | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-wireless_plus.dts b/arch/arm/boot/dts/omap3-wireless_plus.dts
index 8a0acdf..6f33731 100644
--- a/arch/arm/boot/dts/omap3-wireless_plus.dts
+++ b/arch/arm/boot/dts/omap3-wireless_plus.dts
@@ -17,6 +17,23 @@
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
+
+	gpmc: gpmc@6800A000 {
+		compatible = "ti,omap2430-gpmc";
+		ti,hwmods = "gpmc";
+		reg = <0x6800A000 0x2000>;
+		/* interrupts = <100>; */
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpmc_pins>;
+
+		gpmc,num-cs = <8>;
+		gpmc,num-waitpins = <2>;
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges = <0 0 0x08000000 0x10000000>;
+
+		/* child nodes go here */
+	};
 };
 
 &omap3_pmx_core {
@@ -26,7 +43,7 @@
 	 * itself during the boot (or just set them up in the bootloader)
 	 */
 	pinctrl-names = "default";
-	pinctrl-0 = <&sdrc_pins &gpmc_pins &hsusb1_pins>;
+	pinctrl-0 = <&sdrc_pins &hsusb1_pins>;
 
 	/* AM3703CUS pins for this board */
 	sdrc_pins: pinmux_sdrc_pins {
-- 
1.8.2.1

