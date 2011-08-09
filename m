From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [RFC/PATCH 12/14] dt: omap3: beagle board: set clock freq for i2c devices
Date: Tue, 09 Aug 2011 19:10:30 +0500
Message-ID: <1312897232-4792-13-git-send-email-manjugk@ti.com>
References: <1312897232-4792-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [117.192.76.145] ([117.192.76.145]:53466 "EHLO manju-desktop"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751239Ab1HINyu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Aug 2011 09:54:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca


Update omap3 beagle dts file with required clock frequencies for the i2c
client devices existing on beagle board.

Beagle custom board dts file is cleaned up so that it can coexist with omap3
soc dts file.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
---
 arch/arm/boot/dts/omap3-beagle-nunchuck.dts |   11 +----------
 arch/arm/boot/dts/omap3-beagle.dts          |   18 +++++++++++++++---
 2 files changed, 16 insertions(+), 13 deletions(-)

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
index 4439466..49a5ac7 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -1,7 +1,19 @@
-/dts-v1/;
-/include/ "skeleton.dtsi"
+/include/ "omap3-soc.dtsi"
 
 / {
 	model = "TI OMAP3 BeagleBoard";
-	compatible = "ti,omap3-beagle";
+	compatible = "ti,omap3-beagle", "ti,omap3";
+
+
+	i2c1 {
+		clock-frequency = <2600000>;
+	};
+
+	i2c2 {
+		clock-frequency = <400000>;
+	};
+
+	i2c3 {
+		clock-frequency = <400000>;
+	};
 };
-- 
1.7.1

