From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH v4 3/9] ARM: dts: omap3-overo: Add missing pinctrl
Date: Fri,  7 Mar 2014 20:22:13 +0100
Message-ID: <1394220139-1760-4-git-send-email-florian.vaussard@epfl.ch>
References: <1394220139-1760-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:45149 "EHLO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752807AbaCGTWa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Mar 2014 14:22:30 -0500
In-Reply-To: <1394220139-1760-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: Roger Quadros <rogerq@ti.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Add missing pinctrl entries for:
- i2c1
- mmc1

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-overo-base.dtsi | 40 +++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-overo-base.dtsi b/arch/arm/boot/dts/omap3-overo-base.dtsi
index 5970999..aea64c0 100644
--- a/arch/arm/boot/dts/omap3-overo-base.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-base.dtsi
@@ -31,7 +31,36 @@
 	};
 };
 
+&omap3_pmx_core {
+	uart3_pins: pinmux_uart3_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x219e, PIN_INPUT | PIN_OFF_WAKEUPENABLE | MUX_MODE0)	/* uart3_rx_irrx.uart3_rx_irrx */
+			OMAP3_CORE1_IOPAD(0x21a0, PIN_OUTPUT | MUX_MODE0)		/* uart3_tx_irtx.uart3_tx_irtx */
+		>;
+	};
+
+	i2c1_pins: pinmux_i2c1_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21ba, PIN_INPUT | MUX_MODE0)		/* i2c1_scl.i2c1_scl */
+			OMAP3_CORE1_IOPAD(0x21bc, PIN_INPUT | MUX_MODE0)		/* i2c1_sda.i2c1_sda */
+		>;
+	};
+
+	mmc1_pins: pinmux_mmc1_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2144, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc1_clk.sdmmc1_clk */
+			OMAP3_CORE1_IOPAD(0x2146, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc1_cmd.sdmmc1_cmd */
+			OMAP3_CORE1_IOPAD(0x2148, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc1_dat0.sdmmc1_dat0 */
+			OMAP3_CORE1_IOPAD(0x214a, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc1_dat1.sdmmc1_dat1 */
+			OMAP3_CORE1_IOPAD(0x214c, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc1_dat2.sdmmc1_dat2 */
+			OMAP3_CORE1_IOPAD(0x214e, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc1_dat3.sdmmc1_dat3 */
+		>;
+	};
+};
+
 &i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
 	clock-frequency = <2600000>;
 
 	twl: twl@48 {
@@ -57,6 +86,8 @@
 
 /* on board microSD slot */
 &mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&vmmc1>;
 	bus-width = <4>;
 };
@@ -79,15 +110,6 @@
 	power = <50>;
 };
 
-&omap3_pmx_core {
-	uart3_pins: pinmux_uart3_pins {
-		pinctrl-single,pins = <
-			0x16e (PIN_INPUT | PIN_OFF_WAKEUPENABLE | MUX_MODE0) /* uart3_rx_irrx.uart3_rx_irrx */
-			0x170 (PIN_OUTPUT | MUX_MODE0) /* uart3_tx_irtx.uart3_tx_irtx */
-		>;
-	};
-};
-
 &uart3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart3_pins>;
-- 
1.8.3.2

