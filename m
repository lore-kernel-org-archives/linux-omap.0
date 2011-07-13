From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH 2/4] dt: OMAP3: Beagle board: set clock freq for i2c devices
Date: Thu, 14 Jul 2011 03:06:13 +0500
Message-ID: <1310592975-25773-3-git-send-email-manjugk@ti.com>
References: <1310592975-25773-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [117.192.79.57] ([117.192.79.57]:45497 "EHLO manju-desktop"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752173Ab1GMVsz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jul 2011 17:48:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, grant.likely@secretlab.ca, ben-linux@fluff.org


Update omap3 beagle dts file with required clock frequencies for the i2c
client devices existing on beagle board.

Beagle custom board dts file is cleaned up so that it can coexist with omap3
soc dts file.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
---
 arch/arm/boot/dts/omap3-beagle-nunchuck.dts |   11 +---------
 arch/arm/boot/dts/omap3-beagle.dts          |   29 +++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle-nunchuck.dts b/arch/arm/boot/dts/omap3-beagle-nunchuck.dts
index 2607be5..324ff86 100644
--- a/arch/arm/boot/dts/omap3-beagle-nunchuck.dts
+++ b/arch/arm/boot/dts/omap3-beagle-nunchuck.dts
@@ -1,16 +1,7 @@
 /include/ "omap3-beagle.dts"
 
 / {
-	i2c@48072000 {
-		compatible = "ti,omap3-i2c";
-		reg = <0x48072000 0x80>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		eeprom@50 {
-			compatible = "at,at24c01";
-			reg = < 0x50 >;
-		};
+	i2c@2 {
 		joystick@52 {
 			compatible = "sparkfun,wiichuck";
 			reg = < 0x52 >;
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 4439466..b45fbc9 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -1,7 +1,32 @@
-/dts-v1/;
-/include/ "skeleton.dtsi"
+/include/ "omap3-soc.dtsi"
 
 / {
 	model = "TI OMAP3 BeagleBoard";
 	compatible = "ti,omap3-beagle";
+
+	i2c@1 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-frequency = <2600000>;
+		status = "disabled";
+	};
+
+	i2c@2 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-frequency = <400000>;
+	};
+
+	i2c@3 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-frequency = <400000>;
+
+		eeprom@50 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "at,at24c01";
+			reg = < 0x50 >;
+		};
+	};
 };
-- 
1.7.4.1

