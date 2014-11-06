From: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Subject: [PATCH 10/11] ARM: dts: omap3-igep00x0: Remove i2c2 node.
Date: Thu,  6 Nov 2014 13:01:50 +0100
Message-ID: <1415275311-6857-11-git-send-email-eballetbo@iseebcn.com>
References: <1415275311-6857-1-git-send-email-eballetbo@iseebcn.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33538 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbaKFMCe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2014 07:02:34 -0500
In-Reply-To: <1415275311-6857-1-git-send-email-eballetbo@iseebcn.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: javier@dowhile0.org, devicetree@vger.kernel.org, Enric Balletbo i Serra <eballetbo@iseebcn.com>

We can't suppose that the i2c2 pins are configured as I2C bus, these pins are
connected to expansion connectors.

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
---
 arch/arm/boot/dts/omap3-igep.dtsi | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index 6118e7f..8a63ad2 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -92,13 +92,6 @@
 		>;
 	};
 
-	i2c2_pins: pinmux_i2c2_pins {
-		pinctrl-single,pins = <
-			0x18e (PIN_INPUT | MUX_MODE0)   /* i2c2_scl.i2c2_scl */
-			0x190 (PIN_INPUT | MUX_MODE0)   /* i2c2_sda.i2c2_sda */
-		>;
-	};
-
 	i2c3_pins: pinmux_i2c3_pins {
 		pinctrl-single,pins = <
 			0x192 (PIN_INPUT | MUX_MODE0)   /* i2c3_scl.i2c3_scl */
@@ -177,12 +170,6 @@
 #include "twl4030.dtsi"
 #include "twl4030_omap3.dtsi"
 
-&i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
-	clock-frequency = <400000>;
-};
-
 &i2c3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c3_pins>;
-- 
1.9.1

