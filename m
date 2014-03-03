From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH v3 3/7] ARM: dts: omap3-overo: Enable WiFi/BT combo
Date: Mon,  3 Mar 2014 10:34:03 +0100
Message-ID: <1393839247-6516-4-git-send-email-florian.vaussard@epfl.ch>
References: <1393839247-6516-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:41458 "EHLO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752988AbaCCJe2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Mar 2014 04:34:28 -0500
In-Reply-To: <1393839247-6516-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, florian.vaussard@epfl.ch

MMC2 is used by the on-board WiFi module populated on some boards
(based on Marvell Libertas 8688 SDIO). The Bluetooth is connected
to UART2.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-overo-storm-tobi.dts |  8 ++++
 arch/arm/boot/dts/omap3-overo-tobi.dts       |  8 ++++
 arch/arm/boot/dts/omap3-overo.dtsi           | 58 ++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-overo-storm-tobi.dts b/arch/arm/boot/dts/omap3-overo-storm-tobi.dts
index 966b5c9..2033b52 100644
--- a/arch/arm/boot/dts/omap3-overo-storm-tobi.dts
+++ b/arch/arm/boot/dts/omap3-overo-storm-tobi.dts
@@ -20,3 +20,11 @@
 	compatible = "gumstix,omap3-overo-tobi", "gumstix,omap3-overo", "ti,omap36xx", "ti,omap3";
 };
 
+&omap3_pmx_core2 {
+	w3cbw003c_2_pins: pinmux_w3cbw003c_2_pins {
+		pinctrl-single,pins = <
+			OMAP3630_CORE2_IOPAD(0x25e0, PIN_OUTPUT | MUX_MODE4)		/* etk_d2.gpio_16 */
+		>;
+	};
+};
+
diff --git a/arch/arm/boot/dts/omap3-overo-tobi.dts b/arch/arm/boot/dts/omap3-overo-tobi.dts
index de5653e..21de31d 100644
--- a/arch/arm/boot/dts/omap3-overo-tobi.dts
+++ b/arch/arm/boot/dts/omap3-overo-tobi.dts
@@ -20,3 +20,11 @@
 	compatible = "gumstix,omap3-overo-tobi", "gumstix,omap3-overo", "ti,omap3430", "ti,omap3";
 };
 
+&omap3_pmx_core2 {
+	w3cbw003c_2_pins: pinmux_w3cbw003c_2_pins {
+		pinctrl-single,pins = <
+			OMAP3430_CORE2_IOPAD(0x25e0, PIN_OUTPUT | MUX_MODE4)		/* etk_d2.gpio_16 */
+		>;
+	};
+};
+
diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/omap3-overo.dtsi
index aea64c0..07467cc 100644
--- a/arch/arm/boot/dts/omap3-overo.dtsi
+++ b/arch/arm/boot/dts/omap3-overo.dtsi
@@ -29,6 +29,38 @@
 		ti,mcbsp = <&mcbsp2>;
 		ti,codec = <&twl_audio>;
 	};
+
+	/* Regulator to trigger the nPoweron signal of the Wifi module */
+	w3cbw003c_npoweron: regulator-w3cbw003c-npoweron {
+		compatible = "regulator-fixed";
+		regulator-name = "regulator-w3cbw003c-npoweron";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 22 GPIO_ACTIVE_HIGH>;		/* gpio_54: nPoweron */
+		enable-active-high;
+	};
+
+	/* Regulator to trigger the nReset signal of the Wifi module */
+	w3cbw003c_wifi_nreset: regulator-w3cbw003c-wifi-nreset {
+		pinctrl-names = "default";
+		pinctrl-0 = <&w3cbw003c_pins &w3cbw003c_2_pins>;
+		compatible = "regulator-fixed";
+		regulator-name = "regulator-w3cbw003c-wifi-nreset";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio1 16 GPIO_ACTIVE_HIGH>;		/* gpio_16: WiFi nReset */
+		startup-delay-us = <10000>;
+	};
+
+	/* Regulator to trigger the nReset signal of the Bluetooth module */
+	w3cbw003c_bt_nreset: regulator-w3cbw003c-bt-nreset {
+		compatible = "regulator-fixed";
+		regulator-name = "regulator-w3cbw003c-bt-nreset";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio6 4 GPIO_ACTIVE_HIGH>;		/* gpio_164: BT nReset */
+		startup-delay-us = <10000>;
+	};
 };
 
 &omap3_pmx_core {
@@ -56,6 +88,25 @@
 			OMAP3_CORE1_IOPAD(0x214e, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc1_dat3.sdmmc1_dat3 */
 		>;
 	};
+
+	mmc2_pins: pinmux_mmc2_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2158, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_clk.sdmmc2_clk */
+			OMAP3_CORE1_IOPAD(0x215a, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_cmd.sdmmc2_cmd */
+			OMAP3_CORE1_IOPAD(0x215c, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_dat0.sdmmc2_dat0 */
+			OMAP3_CORE1_IOPAD(0x215e, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_dat1.sdmmc2_dat1 */
+			OMAP3_CORE1_IOPAD(0x2160, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_dat2.sdmmc2_dat2 */
+			OMAP3_CORE1_IOPAD(0x2162, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_dat3.sdmmc2_dat3 */
+		>;
+	};
+
+	/* WiFi/BT combo */
+	w3cbw003c_pins: pinmux_w3cbw003c_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x20b4, PIN_OUTPUT | MUX_MODE4)		/* gpmc_ncs3.gpio_54 */
+			OMAP3_CORE1_IOPAD(0x219c, PIN_OUTPUT | MUX_MODE4)		/* uart3_rts_sd.gpio_164 */
+		>;
+	};
 };
 
 &i2c1 {
@@ -94,7 +145,14 @@
 
 /* optional on board WiFi */
 &mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_pins>;
+	vmmc-supply = <&w3cbw003c_npoweron>;
+	vqmmc-supply = <&w3cbw003c_bt_nreset>;
+	vmmc_aux-supply = <&w3cbw003c_wifi_nreset>;
 	bus-width = <4>;
+	cap-sdio-irq;
+	non-removable;
 };
 
 &twl_gpio {
-- 
1.8.3.2

