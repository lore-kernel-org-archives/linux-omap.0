From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 02/11] ARM: dts: omap3-igep: Add support for LBEE1USJYC WiFi connected to SDIO.
Date: Sat, 16 Nov 2013 14:23:35 +0100
Message-ID: <1384608224-9452-3-git-send-email-javier.martinez@collabora.co.uk>
References: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:60335 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837Ab3KPNYy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Nov 2013 08:24:54 -0500
In-Reply-To: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Enric Balletbo i Serra <eballetbo@gmail.com>

The LBEE1USJYC is a WiFi/BT combo module used on OMAP3-based IGEP boards. In
both cases, IGEPv2 Rev. C and IGEP COM MODULE, the module is connected using
the same MMC interface and uses the same GPIOs.

Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---
 arch/arm/boot/dts/omap3-igep.dtsi | 45 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index d4fecce..b3517b2 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -24,6 +24,25 @@
 		ti,mcbsp = <&mcbsp2>;
 		ti,codec = <&twl_audio>;
 	};
+
+	vdd33: regulator-vdd33 {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd33";
+		regulator-always-on;
+	};
+
+	lbee1usjyc_vmmc: lbee1usjyc_vmmc {
+		pinctrl-names = "default";
+		pinctrl-0 = <&lbee1usjyc_pins>;
+		compatible = "regulator-fixed";
+		regulator-name = "regulator-lbee1usjyc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio5 10 GPIO_ACTIVE_HIGH>;	/* gpio_138 WIFI_PDN */
+		startup-delay-us = <10000>;
+		enable-active-high;
+		vin-supply = <&vdd33>;
+	};
 };
 
 &omap3_pmx_core {
@@ -48,6 +67,15 @@
 		>;
 	};
 
+	/* WiFi/BT combo */
+	lbee1usjyc_pins: pinmux_lbee1usjyc_pins {
+		pinctrl-single,pins = <
+			0x136 (PIN_OUTPUT | MUX_MODE4)	/* sdmmc2_dat5.gpio_137 */
+			0x138 (PIN_OUTPUT | MUX_MODE4)	/* sdmmc2_dat6.gpio_138 */
+			0x13a (PIN_OUTPUT | MUX_MODE4)	/* sdmmc2_dat7.gpio_139 */
+		>;
+	};
+
 	mcbsp2_pins: pinmux_mcbsp2_pins {
 		pinctrl-single,pins = <
 			0x10c (PIN_INPUT | MUX_MODE0)		/* mcbsp2_fsx.mcbsp2_fsx */
@@ -68,6 +96,17 @@
 		>;
 	};
 
+	mmc2_pins: pinmux_mmc2_pins {
+		pinctrl-single,pins = <
+			0x128 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_clk.sdmmc2_clk */
+			0x12a (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_cmd.sdmmc2_cmd */
+			0x12c (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc2_dat0.sdmmc2_dat0 */
+			0x12e (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat1.sdmmc2_dat1 */
+			0x130 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat2.sdmmc2_dat2 */
+			0x132 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat3.sdmmc2_dat3 */
+		>;
+	};
+
 	smsc911x_pins: pinmux_smsc911x_pins {
 		pinctrl-single,pins = <
 			0x1a2 (PIN_INPUT | MUX_MODE4)		/* mcspi1_cs2.gpio_176 */
@@ -114,7 +153,11 @@
 };
 
 &mmc2 {
-	status = "disabled";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_pins>;
+	vmmc-supply = <&lbee1usjyc_vmmc>;
+	bus-width = <4>;
+	non-removable;
 };
 
 &mmc3 {
-- 
1.8.4.2

