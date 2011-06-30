From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [RFC PATCH 1/5] OMAP3:I2C: Add device tree nodes for beagle board
Date: Thu, 30 Jun 2011 15:07:23 +0500
Message-ID: <1309426647-31587-2-git-send-email-manjugk@ti.com>
References: <1309426647-31587-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [117.192.67.160] ([117.192.67.160]:41589 "EHLO manju-desktop"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751825Ab1F3JtK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Jun 2011 05:49:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: grant.likely@secretlab.ca, ben-linux@fluff.org


Add I2C and it's child device nodes for beagle board.
The I2C1 controller child devices are not populated and it
should be handled along with OMAP clock changes.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
---
 arch/arm/boot/dts/omap3-beagle-nunchuck.dts |    5 ---
 arch/arm/boot/dts/omap3-beagle.dts          |   42 +++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle-nunchuck.dts b/arch/arm/boot/dts/omap3-beagle-nunchuck.dts
index 2607be5..479be11 100644
--- a/arch/arm/boot/dts/omap3-beagle-nunchuck.dts
+++ b/arch/arm/boot/dts/omap3-beagle-nunchuck.dts
@@ -2,11 +2,6 @@
 
 / {
 	i2c@48072000 {
-		compatible = "ti,omap3-i2c";
-		reg = <0x48072000 0x80>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
 		eeprom@50 {
 			compatible = "at,at24c01";
 			reg = < 0x50 >;
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 4439466..491ee2b 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -4,4 +4,46 @@
 / {
 	model = "TI OMAP3 BeagleBoard";
 	compatible = "ti,omap3-beagle";
+	interrupt-parent = <&gic>;
+
+	gic: interrupt-controller@48241000 {
+		compatible = "ti,omap-gic", "arm,gic";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		reg = <0x48200000 0x1000>;
+	};
+
+	i2c@48070000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "ti,omap_i2c";
+		reg = <0x48070000 0x100>;
+		interrupts = < 88 >;
+		interrupt-parent = <&gic>;
+		clock-frequency = <2600>;
+		status = "disabled";
+	};
+
+	i2c@48072000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "ti,omap_i2c";
+		reg = <0x48072000 0x100>;
+		interrupts = < 89 >;
+		interrupt-parent = <&gic>;
+		clock-frequency = <400>;
+		status = "ok";
+	};
+
+	i2c@48060000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "ti,omap_i2c";
+		reg = <0x48060000 0x100>;
+		interrupts = < 93 >;
+		interrupt-parent = <&gic>;
+		clock-frequency = <100>;
+		status = "ok";
+	};
+
 };
-- 
1.7.4.1

