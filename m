From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 1/7] ARM: dts: am335x-icev2: Add Industrial input support
Date: Fri, 7 Oct 2016 09:44:22 -0500
Message-ID: <20161007144428.16671-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: linux-omap@vger.kernel.org

The SN65HVS882 is available on the AM335x-ICEv2 and is attached to SPI0.
Input is attached to the I/O header.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/am335x-icev2.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-icev2.dts b/arch/arm/boot/dts/am335x-icev2.dts
index 85e04c2..d46efc6 100644
--- a/arch/arm/boot/dts/am335x-icev2.dts
+++ b/arch/arm/boot/dts/am335x-icev2.dts
@@ -187,6 +187,8 @@
 			AM33XX_IOPAD(0x954, PIN_INPUT_PULLUP | MUX_MODE0) /* (B17) spi0_d0.spi0_d0 */
 			AM33XX_IOPAD(0x958, PIN_INPUT_PULLUP | MUX_MODE0) /* (B16) spi0_d1.spi0_d1 */
 			AM33XX_IOPAD(0x95c, PIN_INPUT_PULLUP | MUX_MODE0) /* (A16) spi0_cs0.spi0_cs0 */
+			AM33XX_IOPAD(0x960, PIN_INPUT_PULLUP | MUX_MODE0) /* (C15) spi0_cs1.spi0_cs1 */
+			AM33XX_IOPAD(0x9a0, PIN_INPUT_PULLUP | MUX_MODE7) /* (B12) mcasp0_aclkr.gpio3[18] */
 		>;
 	};
 
@@ -224,6 +226,24 @@
 	};
 };
 
+&spi0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins_default>;
+
+	sn65hvs882@1 {
+		compatible = "pisosr-gpio";
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		load-gpios = <&gpio3 18 GPIO_ACTIVE_LOW>;
+
+		reg = <1>;
+		spi-max-frequency = <1000000>;
+		spi-cpol;
+	};
+};
+
 #include "tps65910.dtsi"
 
 &tps {
-- 
2.10.0
