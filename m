From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH] ARM: dts: N950: Add wlan support
Date: Sat,  9 Jan 2016 04:19:34 +0100
Message-ID: <1452309574-12921-1-git-send-email-sre@kernel.org>
References: <1451482533-8624-4-git-send-email-uri.mashiach@compulab.co.il>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1451482533-8624-4-git-send-email-uri.mashiach@compulab.co.il>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

Add support for the wl1271 wlan chip. As far as I can see N9 uses the
same chip with the same enable and irq gpio, but they use the mmc
interface instead of the spi interface.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
Hi,

I got working Wifi on Nokia N950 with this patch and the following
patches from Uri Mashiach (using 4.4-rc8 as base):

 * wlcore/wl12xx: spi: add power operation function
 * wlcore/wl12xx: spi: add device tree support
 * wlcore/wl12xx: spi: fix oops on firmware load

-- Sebastian
---
 arch/arm/boot/dts/omap3-n950-n9.dtsi | 15 +++++++++++++++
 arch/arm/boot/dts/omap3-n950.dts     | 29 +++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3-n950-n9.dtsi
index e9ee1df0e467..655deb99010a 100644
--- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
+++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
@@ -31,6 +31,14 @@
 		startup-delay-us = <150>;
 		enable-active-high;
 	};
+
+	vwlan_fixed: fixedregulator@2 {
+		compatible = "regulator-fixed";
+		regulator-name = "VWLAN";
+		gpio = <&gpio2 3 GPIO_ACTIVE_HIGH>; /* gpio 35 */
+		enable-active-high;
+		regulator-boot-off;
+	};
 };
 
 &omap3_pmx_core {
@@ -44,6 +52,13 @@
 			0x132 (PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_dat3 */
 		>;
 	};
+
+	wlan_pins: pinmux_wlan_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x207c, PIN_OUTPUT | MUX_MODE4) /* gpio 35 - wlan enable */
+			OMAP3_CORE1_IOPAD(0x208a, PIN_INPUT | MUX_MODE4) /* gpio 42 - wlan irq */
+		>;
+	};
 };
 
 &i2c1 {
diff --git a/arch/arm/boot/dts/omap3-n950.dts b/arch/arm/boot/dts/omap3-n950.dts
index 0885b34d5d7d..e5967262f28b 100644
--- a/arch/arm/boot/dts/omap3-n950.dts
+++ b/arch/arm/boot/dts/omap3-n950.dts
@@ -17,6 +17,17 @@
 	compatible = "nokia,omap3-n950", "ti,omap36xx", "ti,omap3";
 };
 
+&omap3_pmx_core {
+	spi4_pins: pinmux_spi4_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x218c, PIN_INPUT_PULLDOWN | MUX_MODE1) /* mcspi4_clk */
+			OMAP3_CORE1_IOPAD(0x2190, PIN_OUTPUT | MUX_MODE1) /* mcspi4_simo */
+			OMAP3_CORE1_IOPAD(0x2192, PIN_INPUT_PULLDOWN | MUX_MODE1) /* mcspi4_somi */
+			OMAP3_CORE1_IOPAD(0x2196, PIN_OUTPUT | MUX_MODE1) /* mcspi4_cs0 */
+		>;
+	};
+};
+
 &i2c2 {
 	smia_1: camera@10 {
 		compatible = "nokia,smia";
@@ -53,3 +64,21 @@
 		};
 	};
 };
+
+&mcspi4 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi4_pins>;
+
+	wlcore: wlcore@0 {
+		compatible = "ti,wl1271";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_pins>;
+		reg = <0>;
+		spi-max-frequency = <48000000>;
+		clock-xtal;
+		ref-clock-frequency = <38400000>;
+		interrupts-extended = <&gpio2 10 IRQ_TYPE_LEVEL_HIGH>; /* gpio 42 */
+		vwlan-supply = <&vwlan_fixed>;
+	};
+};
-- 
2.6.4
