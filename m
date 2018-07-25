From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 29/32] ARM: dts: omap3-gta04a5: add support for ti,wl1837 module
Date: Wed, 25 Jul 2018 08:59:01 +0200
Message-ID: <82be54d8bb11b36cabfa2827101f4f2e48c646c3.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

GTA04A5 uses a ti,wl1837 WiFi/Bluetooth module. Overwrite
the mmc2 node and child.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04a5.dts | 58 +++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04a5.dts b/arch/arm/boot/dts/omap3-gta04a5.dts
index e3352cc97c91..453a87ebb860 100644
--- a/arch/arm/boot/dts/omap3-gta04a5.dts
+++ b/arch/arm/boot/dts/omap3-gta04a5.dts
@@ -15,6 +15,20 @@
 		ti,jack-det-gpio = <&twl_gpio 2 GPIO_ACTIVE_HIGH>;	/* GTA04A5 only */
 	};
 
+	wlan_en: wlan_en_regulator {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_pins>;
+		regulator-name = "wlan-en-regulator";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		gpio = <&gpio5 10 GPIO_ACTIVE_HIGH>;	/* GPIO_138 */
+
+		startup-delay-us = <70000>;
+		enable-active-high;
+	};
+
 	pps {
 		compatible = "pps-gpio";
 		pinctrl-names = "default";
@@ -34,6 +48,18 @@
 };
 
 &omap3_pmx_core {
+	wlan_pins: pinmux_wlan_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2168, PIN_OUTPUT | MUX_MODE4)	/* mmc2_dat6 = mmc3_dat2 = gpio138 */
+		>;
+	};
+
+	wlan_irq_pin: pinmux_wlan_irq_pin {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x216a, PIN_INPUT_PULLUP | MUX_MODE4)	/* mmc2_dat7 = mmc3_dat3 = gpio139 */
+		>;
+	};
+
 	irda_pins: pinmux_irda {
 		pinctrl-single,pins = <
 			OMAP3_CORE1_IOPAD(0x21d0, PIN_OUTPUT_PULLUP | MUX_MODE4)	/* mcspi1_cs1 = gpio175 */
@@ -47,3 +73,35 @@
 	};
 
 };
+
+/*
+ * for WL183x module see
+ * http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/net/wireless/ti,wlcore.txt
+ */
+
+&wifi_pwrseq {
+	/delete-property/ reset-gpios;
+};
+
+&mmc2 {
+	vmmc-supply = <&wlan_en>;
+	bus-width = <4>;
+	cap-power-off-card;
+	non-removable;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&wlan_irq_pin>;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/delete-property/ mmc-pwrseq;
+
+	wlcore: wlcore@2 {
+		compatible = "ti,wl1837";
+		reg = <2>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;	/* GPIO_139 */
+		ref-clock-frequency = <26000000>;
+	};
+};
-- 
2.12.2
