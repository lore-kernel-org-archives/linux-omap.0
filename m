From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH V2 1/4] ARM: dts: omap5: Rename omap5-evm to omap5-uevm
Date: Thu, 6 Jun 2013 23:18:36 +0530
Message-ID: <1370540919-4339-2-git-send-email-r.sricharan@ti.com>
References: <1370540919-4339-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35977 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753522Ab3FFRt1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Jun 2013 13:49:27 -0400
In-Reply-To: <1370540919-4339-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: devicetree-discuss@lists.ozlabs.org, r.sricharan@ti.com, tony@atomide.com, rnayak@ti.com, b-cousson@ti.com

The uevm is the official board supported for the OMAP5 soc
in mainline. The uevm has an OMAP5432 with a DDR3 memory.
Renaming the board dts file and adding the following cleanups.

 * There are no devices connected on I2C 2,3,4 buses. So remove
   the pinmux data for the same.

 * DDR3 memory is used in the uevm. Neither DVFS or temperature
   polling is supported with DDR3. So remove the DDR3 device and
   emif nodes.

 * Keypad is not supported on uevm. So remove the device node.

Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
 arch/arm/boot/dts/Makefile                         |    2 +-
 .../arm/boot/dts/{omap5-evm.dts => omap5-uevm.dts} |   83 +-------------------
 2 files changed, 4 insertions(+), 81 deletions(-)
 rename arch/arm/boot/dts/{omap5-evm.dts => omap5-uevm.dts} (73%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f0895c5..13b86bf 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -149,7 +149,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	omap4-panda-es.dtb \
 	omap4-var-som.dtb \
 	omap4-sdp.dtb \
-	omap5-evm.dtb \
+	omap5-uevm.dtb \
 	am335x-evm.dtb \
 	am335x-evmsk.dtb \
 	am335x-bone.dtb
diff --git a/arch/arm/boot/dts/omap5-evm.dts b/arch/arm/boot/dts/omap5-uevm.dts
similarity index 73%
rename from arch/arm/boot/dts/omap5-evm.dts
rename to arch/arm/boot/dts/omap5-uevm.dts
index 22e9ee8..843a001 100644
--- a/arch/arm/boot/dts/omap5-evm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -8,11 +8,10 @@
 /dts-v1/;
 
 #include "omap5.dtsi"
-#include "samsung_k3pe0e000b.dtsi"
 
 / {
-	model = "TI OMAP5 EVM board";
-	compatible = "ti,omap5-evm", "ti,omap5";
+	model = "TI OMAP5 uEVM board";
+	compatible = "ti,omap5-uevm", "ti,omap5";
 
 	memory {
 		device_type = "memory";
@@ -88,27 +87,6 @@
 		>;
 	};
 
-	i2c2_pins: pinmux_i2c2_pins {
-		pinctrl-single,pins = <
-			0x178 (PIN_INPUT | MUX_MODE0)		/* i2c2_scl */
-			0x17a (PIN_INPUT | MUX_MODE0)		/* i2c2_sda */
-		>;
-	};
-
-	i2c3_pins: pinmux_i2c3_pins {
-		pinctrl-single,pins = <
-			0x13a (PIN_INPUT | MUX_MODE0)		/* i2c3_scl */
-			0x13c (PIN_INPUT | MUX_MODE0)		/* i2c3_sda */
-		>;
-	};
-
-	i2c4_pins: pinmux_i2c4_pins {
-		pinctrl-single,pins = <
-			0xb8 (PIN_INPUT | MUX_MODE0)		/* i2c4_scl */
-			0xba (PIN_INPUT | MUX_MODE0)		/* i2c4_sda */
-		>;
-	};
-
 	i2c5_pins: pinmux_i2c5_pins {
 		pinctrl-single,pins = <
 			0x184 (PIN_INPUT | MUX_MODE0)		/* i2c5_scl */
@@ -175,39 +153,6 @@
 	clock-frequency = <400000>;
 };
 
-&i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
-
-	clock-frequency = <400000>;
-
-	/* Pressure Sensor */
-	bmp085@77 {
-		compatible = "bosch,bmp085";
-		reg = <0x77>;
-	};
-};
-
-&i2c3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c3_pins>;
-
-	clock-frequency = <400000>;
-};
-
-&i2c4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c4_pins>;
-
-	clock-frequency = <400000>;
-
-	/* Temperature Sensor */
-	tmp102@48{
-		compatible = "ti,tmp102";
-		reg = <0x48>;
-	};
-};
-
 &i2c5 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c5_pins>;
@@ -215,32 +160,10 @@
 	clock-frequency = <400000>;
 };
 
-&keypad {
-	keypad,num-rows = <8>;
-	keypad,num-columns = <8>;
-	linux,keymap = <0x02020073	/* VOLUP */
-			0x02030072	/* VOLDOWM */
-			0x020400e7	/* SEND */
-			0x02050066	/* HOME */
-			0x0206006b	/* END */
-			0x020700d9>;	/* SEARCH */
-	linux,input-no-autorepeat;
-};
-
 &mcbsp3 {
 	status = "disabled";
 };
 
-&emif1 {
-	cs1-used;
-	device-handle = <&samsung_K3PE0E000B>;
-};
-
-&emif2 {
-	cs1-used;
-	device-handle = <&samsung_K3PE0E000B>;
-};
-
 &mcspi1 {
 
 };
-- 
1.7.9.5

