From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 4/7] ARM: dts: am437x-idk: Add Industrial input support
Date: Fri, 7 Oct 2016 09:44:25 -0500
Message-ID: <20161007144428.16671-4-afd@ti.com>
References: <20161007144428.16671-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161007144428.16671-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: linux-omap@vger.kernel.org

The SN65HVS882 is available on the AM437x IDK and is attached to SPI1.
Input is attached to the I/O header.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Reviewed-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/am437x-idk-evm.dts | 42 ++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-idk-evm.dts b/arch/arm/boot/dts/am437x-idk-evm.dts
index 25ce611..fff7ef6 100644
--- a/arch/arm/boot/dts/am437x-idk-evm.dts
+++ b/arch/arm/boot/dts/am437x-idk-evm.dts
@@ -178,6 +178,24 @@
 		>;
 	};
 
+	spi1_pins_default: spi1_pins_default {
+		pinctrl-single,pins = <
+			AM4372_IOPAD(0x908, PIN_INPUT | MUX_MODE2)	/* mii1_col.spi1_sclk */
+			AM4372_IOPAD(0x910, PIN_INPUT | MUX_MODE2)	/* mii1_rx_er.spi1_d1 */
+			AM4372_IOPAD(0x944, PIN_OUTPUT | MUX_MODE2)	/* rmii1_ref_clk.spi1_cs0 */
+			AM4372_IOPAD(0x90c, PIN_OUTPUT | MUX_MODE7)	/* mii1_crs.gpio3_1 */
+		>;
+	};
+
+	spi1_pins_sleep: spi1_pins_sleep {
+		pinctrl-single,pins = <
+			AM4372_IOPAD(0x908, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM4372_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+		>;
+	};
+
 	ecap0_pins_default: backlight_pins_default {
 		pinctrl-single,pins = <
 			AM4372_IOPAD(0x964, PIN_OUTPUT | MUX_MODE0) /* ecap0_in_pwm0_out.ecap0_in_pwm0_out */
@@ -292,6 +310,26 @@
 	clock-frequency = <100000>;
 };
 
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&spi1_pins_default>;
+	pinctrl-1 = <&spi1_pins_sleep>;
+	ti,pindir-d0-out-d1-in;
+
+	sn65hvs882: sn65hvs882@0 {
+		compatible = "pisosr-gpio";
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		load-gpios = <&gpio3 1 GPIO_ACTIVE_LOW>;
+
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+		spi-cpol;
+	};
+};
+
 &epwmss0 {
 	status = "okay";
 };
@@ -310,6 +348,10 @@
 	status = "okay";
 };
 
+&gpio3 {
+	status = "okay";
+};
+
 &gpio4 {
 	status = "okay";
 };
-- 
2.10.0
