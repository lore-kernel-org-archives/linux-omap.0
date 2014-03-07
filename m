From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH v4 4/9] ARM: dts: omap3-overo: Enable WiFi/BT combo
Date: Fri,  7 Mar 2014 20:22:14 +0100
Message-ID: <1394220139-1760-5-git-send-email-florian.vaussard@epfl.ch>
References: <1394220139-1760-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:45157 "EHLO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752387AbaCGTWb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Mar 2014 14:22:31 -0500
In-Reply-To: <1394220139-1760-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: Roger Quadros <rogerq@ti.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

MMC2 is used by the on-board WiFi module populated on some boards
(based on Marvell Libertas 8688 SDIO). The Bluetooth is connected
to UART2.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-overo-base.dtsi  | 72 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-overo-storm.dtsi |  8 ++++
 arch/arm/boot/dts/omap3-overo.dtsi       |  8 ++++
 3 files changed, 88 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-overo-base.dtsi b/arch/arm/boot/dts/omap3-overo-base.dtsi
index aea64c0..edac70e 100644
--- a/arch/arm/boot/dts/omap3-overo-base.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-base.dtsi
@@ -29,9 +29,50 @@
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
+	uart2_pins: pinmux_uart2_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x216c, PIN_INPUT | MUX_MODE1)	/* mcbsp3_dx.uart2_cts */
+			OMAP3_CORE1_IOPAD(0x216e, PIN_OUTPUT | MUX_MODE1)	/* mcbsp3_dr.uart2_rts */
+			OMAP3_CORE1_IOPAD(0x2170, PIN_OUTPUT | MUX_MODE1)	/* mcbsp3_clk.uart2_tx */
+			OMAP3_CORE1_IOPAD(0x2172, PIN_INPUT | MUX_MODE1)	/* mcbsp3_fsx.uart2_rx */
+		>;
+	};
+
 	uart3_pins: pinmux_uart3_pins {
 		pinctrl-single,pins = <
 			OMAP3_CORE1_IOPAD(0x219e, PIN_INPUT | PIN_OFF_WAKEUPENABLE | MUX_MODE0)	/* uart3_rx_irrx.uart3_rx_irrx */
@@ -56,6 +97,25 @@
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
@@ -94,7 +154,14 @@
 
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
@@ -110,6 +177,11 @@
 	power = <50>;
 };
 
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+};
+
 &uart3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart3_pins>;
diff --git a/arch/arm/boot/dts/omap3-overo-storm.dtsi b/arch/arm/boot/dts/omap3-overo-storm.dtsi
index c30efb3..c235ae8 100644
--- a/arch/arm/boot/dts/omap3-overo-storm.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-storm.dtsi
@@ -9,3 +9,11 @@
 #include "omap36xx.dtsi"
 #include "omap3-overo-base.dtsi"
 
+&omap3_pmx_core2 {
+	w3cbw003c_2_pins: pinmux_w3cbw003c_2_pins {
+		pinctrl-single,pins = <
+			OMAP3630_CORE2_IOPAD(0x25e0, PIN_OUTPUT | MUX_MODE4)		/* etk_d2.gpio_16 */
+		>;
+	};
+};
+
diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/omap3-overo.dtsi
index 7bbda68..95c59b2 100644
--- a/arch/arm/boot/dts/omap3-overo.dtsi
+++ b/arch/arm/boot/dts/omap3-overo.dtsi
@@ -9,3 +9,11 @@
 #include "omap34xx.dtsi"
 #include "omap3-overo-base.dtsi"
 
+&omap3_pmx_core2 {
+	w3cbw003c_2_pins: pinmux_w3cbw003c_2_pins {
+		pinctrl-single,pins = <
+			OMAP3430_CORE2_IOPAD(0x25e0, PIN_OUTPUT | MUX_MODE4)		/* etk_d2.gpio_16 */
+		>;
+	};
+};
+
-- 
1.8.3.2

