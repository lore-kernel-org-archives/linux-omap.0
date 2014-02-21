From: Stefan Roese <sr@denx.de>
Subject: [PATCH] arm: dts: Add support for Compulab sbc-t3530 with cm-t35
Date: Fri, 21 Feb 2014 13:36:05 +0100
Message-ID: <1392986165-12238-1-git-send-email-sr@denx.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo4-p05-ob.smtp.rzone.de ([81.169.146.183]:41340 "EHLO
	mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbaBUMgI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Feb 2014 07:36:08 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Igor Grinberg <grinberg@compulab.co.il>, Dmitry Lifshitz <lifshitz@compulab.co.il>, Tony Lindgren <tony@atomide.com>

The cm-t3530 SOM is equipped with the OMAP3530 and does not boot with
the cm-t3730 dts file as it used the omap36xx.dtsi. Add a separate
dts/dtsi for this board to support it correctly.

I moved some common parts into omap3-cm-t3x30.dtsi. And removed
the SDIO/WLAN support for now. As I don't know exactly how this
should be done. Perhaps somebody else might jump in here...

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/Makefile            |  1 +
 arch/arm/boot/dts/omap3-cm-t3530.dts  | 29 +++++++++++++++++++
 arch/arm/boot/dts/omap3-cm-t3730.dts  | 54 ++++-------------------------------
 arch/arm/boot/dts/omap3-cm-t3x30.dtsi | 44 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-sbc-t3530.dts | 30 +++++++++++++++++++
 5 files changed, 110 insertions(+), 48 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-cm-t3530.dts
 create mode 100644 arch/arm/boot/dts/omap3-sbc-t3530.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 6d1e43d..6fd1b34 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -200,6 +200,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	omap3430-sdp.dtb \
 	omap3-beagle.dtb \
 	omap3-cm-t3730.dtb \
+	omap3-sbc-t3530.dtb \
 	omap3-sbc-t3730.dtb \
 	omap3-devkit8000.dtb \
 	omap3-beagle-xm.dtb \
diff --git a/arch/arm/boot/dts/omap3-cm-t3530.dts b/arch/arm/boot/dts/omap3-cm-t3530.dts
new file mode 100644
index 0000000..35a1fc2
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-cm-t3530.dts
@@ -0,0 +1,29 @@
+/*
+ * Support for CompuLab CM-T3530
+ */
+/dts-v1/;
+
+#include "omap34xx-hs.dtsi"
+#include "omap3-cm-t3x30.dtsi"
+
+/ {
+	model = "CompuLab CM-T3530";
+	compatible = "compulab,omap3-cm-t3530", "ti,omap34xx", "ti,omap3";
+};
+
+&mmc1 {
+	vmmc-supply = <&vmmc1>;
+	bus-width = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+};
+
+&smsc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&smsc1_pins>;
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
+};
diff --git a/arch/arm/boot/dts/omap3-cm-t3730.dts b/arch/arm/boot/dts/omap3-cm-t3730.dts
index 486f4d6..3e05b11 100644
--- a/arch/arm/boot/dts/omap3-cm-t3730.dts
+++ b/arch/arm/boot/dts/omap3-cm-t3730.dts
@@ -32,39 +32,14 @@
 };
 
 &omap3_pmx_core {
-	mmc1_pins: pinmux_mmc1_pins {
-		pinctrl-single,pins = <
-			0x114 (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk.sdmmc1_clk */
-			0x116 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_cmd.sdmmc1_cmd */
-			0x118 (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat0.sdmmc1_dat0 */
-			0x11a (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat1.sdmmc1_dat1 */
-			0x11c (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat2.sdmmc1_dat2 */
-			0x11e (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat3.sdmmc1_dat3 */
-		>;
-	};
-
 	mmc2_pins: pinmux_mmc2_pins {
 		pinctrl-single,pins = <
-			0x128 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_clk.sdmmc2_clk */
-			0x12a (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_cmd.sdmmc2_cmd */
-			0x12c (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat0.sdmmc2_dat0 */
-			0x12e (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat1.sdmmc2_dat1 */
-			0x130 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat2.sdmmc2_dat2 */
-			0x132 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat3.sdmmc2_dat3 */
-		>;
-	};
-
-	smsc1_pins: pinmux_smsc1_pins {
-		pinctrl-single,pins = <
-			0x88 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_ncs5.gpmc_ncs5 */
-			0x16a (PIN_INPUT_PULLUP | MUX_MODE4)	/* uart3_cts_rctx.gpio_163 */
-		>;
-	};
-
-	uart3_pins: pinmux_uart3_pins {
-		pinctrl-single,pins = <
-			0x16e (PIN_INPUT | MUX_MODE0)		/* uart3_rx_irrx.uart3_rx_irrx */
-			0x170 (PIN_OUTPUT | MUX_MODE0)		/* uart3_tx_irtx.uart3_tx_irtx */
+			0x128 (PIN_INPUT_PULLUP | MUX_MODE0)    /* sdmmc2_clk.sdmmc2_clk */
+			0x12a (PIN_INPUT_PULLUP | MUX_MODE0)    /* sdmmc2_cmd.sdmmc2_cmd */
+			0x12c (PIN_INPUT_PULLUP | MUX_MODE0)    /* sdmmc2_dat0.sdmmc2_dat0 */
+			0x12e (PIN_INPUT_PULLUP | MUX_MODE0)    /* sdmmc2_dat1.sdmmc2_dat1 */
+			0x130 (PIN_INPUT_PULLUP | MUX_MODE0)    /* sdmmc2_dat2.sdmmc2_dat2 */
+			0x132 (PIN_INPUT_PULLUP | MUX_MODE0)    /* sdmmc2_dat3.sdmmc2_dat3 */
 		>;
 	};
 
@@ -76,13 +51,6 @@
 	};
 };
 
-&mmc1 {
-	vmmc-supply = <&vmmc1>;
-	bus-width = <4>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins>;
-};
-
 &mmc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins>;
@@ -92,13 +60,3 @@
 	bus-width = <4>;
 	cap-power-off-card;
 };
-
-&smsc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&smsc1_pins>;
-};
-
-&uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart3_pins>;
-};
diff --git a/arch/arm/boot/dts/omap3-cm-t3x30.dtsi b/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
index 3a9f004..0eadd4a 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
@@ -36,6 +36,33 @@
 	};
 };
 
+&omap3_pmx_core {
+	mmc1_pins: pinmux_mmc1_pins {
+		pinctrl-single,pins = <
+			0x114 (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk.sdmmc1_clk */
+			0x116 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_cmd.sdmmc1_cmd */
+			0x118 (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat0.sdmmc1_dat0 */
+			0x11a (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat1.sdmmc1_dat1 */
+			0x11c (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat2.sdmmc1_dat2 */
+			0x11e (PIN_INPUT_PULLUP | MUX_MODE0) 	/* sdmmc1_dat3.sdmmc1_dat3 */
+		>;
+	};
+
+	smsc1_pins: pinmux_smsc1_pins {
+		pinctrl-single,pins = <
+			0x88 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_ncs5.gpmc_ncs5 */
+			0x16a (PIN_INPUT_PULLUP | MUX_MODE4)	/* uart3_cts_rctx.gpio_163 */
+		>;
+	};
+
+	uart3_pins: pinmux_uart3_pins {
+		pinctrl-single,pins = <
+			0x16e (PIN_INPUT | MUX_MODE0)		/* uart3_rx_irrx.uart3_rx_irrx */
+			0x170 (PIN_OUTPUT | MUX_MODE0)		/* uart3_tx_irtx.uart3_tx_irtx */
+		>;
+	};
+};
+
 &gpmc {
 	ranges = <5 0 0x2c000000 0x01000000>;
 
@@ -83,6 +110,23 @@
 	};
 };
 
+&mmc1 {
+	vmmc-supply = <&vmmc1>;
+	bus-width = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+};
+
+&smsc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&smsc1_pins>;
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
+};
+
 #include "twl4030.dtsi"
 #include "twl4030_omap3.dtsi"
 
diff --git a/arch/arm/boot/dts/omap3-sbc-t3530.dts b/arch/arm/boot/dts/omap3-sbc-t3530.dts
new file mode 100644
index 0000000..b548343
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-sbc-t3530.dts
@@ -0,0 +1,30 @@
+/*
+ * Support for CompuLab SBC-T3530 with CM-T3530
+ */
+
+#include "omap3-cm-t3530.dts"
+#include "omap3-sb-t35.dtsi"
+
+/ {
+	model = "CompuLab SBC-T3530 with CM-T3530";
+	compatible = "compulab,omap3-sbc-t3530", "compulab,omap3-cm-t3530", "ti,omap34xx", "ti,omap3";
+};
+
+&gpmc {
+	ranges = <5 0 0x2c000000 0x01000000>,
+		 <4 0 0x2d000000 0x01000000>;
+};
+
+&smsc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&smsc2_pins>;
+};
+
+&omap3_pmx_core {
+	smsc2_pins: pinmux_smsc2_pins {
+		pinctrl-single,pins = <
+			0x86 (PIN_OUTPUT | MUX_MODE0)		/* gpmc_ncs4.gpmc_ncs4 */
+			0xa2 (PIN_INPUT_PULLUP | MUX_MODE4)	/* gpmc_wait3.gpio_65 */
+		>;
+	};
+};
-- 
1.8.5.5

