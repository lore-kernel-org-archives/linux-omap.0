From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH 02/12] ARM: dts: sbc-t3x: refactor DT support
Date: Sun, 12 Jan 2014 15:22:45 +0200
Message-ID: <1389532975-28281-3-git-send-email-lifshitz@compulab.co.il>
References: <1389532975-28281-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:33968 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751065AbaALNXE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 12 Jan 2014 08:23:04 -0500
In-Reply-To: <1389532975-28281-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Refactor the sbc-t3x device tree as a preparation for additional
(sbc-t3530, sbc-t3517, etc.) boards support.

No functional changes.

The device tree will have the following structure:

omap3-cm-t3x.dtsi
 |
 |<-- omap3-cm-t3x30.dtsi
 |     |
 |     |
 |     |     -----                  -------          ------------
 |     |    | CoM |                | Board |        | Base board |
 |     |     -----                  -------          ------------
 |     |                                            omap3-sb-t35.dtsi
 |     |                                                  |
 |     |<-- omap3-cm-t3730.dts <-- omap3-sbc-t3730.dts -->|
 |     |                                                  |
 |     |<-- omap3-cm-t3530.dts <-- omap3-sbc-t3530.dts -->|
 |                                                        |
 |<-------- omap3-cm-t3517.dts <-- omap3-sbc-t3517.dts -->|

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/omap3-cm-t3730.dts  |   41 ----------------------
 arch/arm/boot/dts/omap3-cm-t3x.dtsi   |   60 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-cm-t3x30.dtsi |   36 +++++++++----------
 arch/arm/boot/dts/omap3-sb-t35.dtsi   |   11 ++++++
 arch/arm/boot/dts/omap3-sbc-t3730.dts |   14 --------
 arch/arm/mach-omap2/pdata-quirks.c    |    2 +-
 6 files changed, 89 insertions(+), 75 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-cm-t3x.dtsi

diff --git a/arch/arm/boot/dts/omap3-cm-t3730.dts b/arch/arm/boot/dts/omap3-cm-t3730.dts
index 508cd9b..b3f9a50 100644
--- a/arch/arm/boot/dts/omap3-cm-t3730.dts
+++ b/arch/arm/boot/dts/omap3-cm-t3730.dts
@@ -32,16 +32,6 @@
 };
 
 &omap3_pmx_core {
-	mmc1_pins: pinmux_mmc1_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x2144, PIN_OUTPUT_PULLUP | MUX_MODE0)/* sdmmc1_clk.sdmmc1_clk */
-			OMAP3_CORE1_IOPAD(0x2146, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_cmd.sdmmc1_cmd */
-			OMAP3_CORE1_IOPAD(0x2148, PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc1_dat0.sdmmc1_dat0 */
-			OMAP3_CORE1_IOPAD(0x214a, PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc1_dat1.sdmmc1_dat1 */
-			OMAP3_CORE1_IOPAD(0x214c, PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc1_dat2.sdmmc1_dat2 */
-			OMAP3_CORE1_IOPAD(0x214e, PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc1_dat3.sdmmc1_dat3 */
-		>;
-	};
 
 	mmc2_pins: pinmux_mmc2_pins {
 		pinctrl-single,pins = <
@@ -54,20 +44,6 @@
 		>;
 	};
 
-	smsc1_pins: pinmux_smsc1_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x20b8, PIN_OUTPUT | MUX_MODE0)	/* gpmc_ncs5.gpmc_ncs5 */
-			OMAP3_CORE1_IOPAD(0x219a, PIN_INPUT_PULLUP | MUX_MODE4)	/* uart3_cts_rctx.gpio_163 */
-		>;
-	};
-
-	uart3_pins: pinmux_uart3_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x219e, PIN_INPUT | MUX_MODE0)	/* uart3_rx_irrx.uart3_rx_irrx */
-			OMAP3_CORE1_IOPAD(0x21a0, PIN_OUTPUT | MUX_MODE0)	/* uart3_tx_irtx.uart3_tx_irtx */
-		>;
-	};
-
 	wl12xx_gpio: pinmux_wl12xx_gpio {
 		pinctrl-single,pins = <
 			OMAP3_CORE1_IOPAD(0x20e2, PIN_OUTPUT | MUX_MODE4)	/* dss_data3.gpio_73 */
@@ -76,13 +52,6 @@
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
@@ -92,13 +61,3 @@
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
diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
new file mode 100644
index 0000000..ca6090d
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
@@ -0,0 +1,60 @@
+/*
+ * Common support for CompuLab CM-T3x CoMs
+ */
+
+/ {
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x10000000>; /* 256 MB */
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		ledb {
+			label = "cm-t3x:green";
+			gpios = <&gpio6 26 GPIO_ACTIVE_HIGH>;  /* gpio186 */
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&omap3_pmx_core {
+
+	uart3_pins: pinmux_uart3_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x219e, PIN_INPUT  | MUX_MODE0)	/* uart3_rx_irrx.uart3_rx_irrx */
+			OMAP3_CORE1_IOPAD(0x21a0, PIN_OUTPUT | MUX_MODE0)	/* uart3_tx_irtx.uart3_tx_irtx */
+		>;
+	};
+
+	mmc1_pins: pinmux_mmc1_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2144, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk.sdmmc1_clk */
+			OMAP3_CORE1_IOPAD(0x2146, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_cmd.sdmmc1_cmd */
+			OMAP3_CORE1_IOPAD(0x2148, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat0.sdmmc1_dat0 */
+			OMAP3_CORE1_IOPAD(0x214a, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat1.sdmmc1_dat1 */
+			OMAP3_CORE1_IOPAD(0x214c, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat2.sdmmc1_dat2 */
+			OMAP3_CORE1_IOPAD(0x214e, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat3.sdmmc1_dat3 */
+		>;
+	};
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
+};
+
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	bus-width = <4>;
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+};
+
+&i2c3 {
+	clock-frequency = <400000>;
+};
diff --git a/arch/arm/boot/dts/omap3-cm-t3x30.dtsi b/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
index 3a9f004..4bcc639 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
@@ -1,28 +1,16 @@
 /*
- * Common support for CompuLab CM-T3530 and  CM-T3730
+ * Common support for CompuLab CM-T3x30 CoMs
  */
 
-/ {
-	memory {
-		device_type = "memory";
-		reg = <0x80000000 0x10000000>; /* 256 MB */
-	};
+#include "omap3-cm-t3x.dtsi"
 
+/ {
 	cpus {
 		cpu@0 {
 			cpu0-supply = <&vcc>;
 		};
 	};
 
-	leds {
-		compatible = "gpio-leds";
-		ledb {
-			label = "cm-t35:green";
-			gpios = <&gpio6 26 GPIO_ACTIVE_HIGH>;  /* gpio186 */
-			linux,default-trigger = "heartbeat";
-		};
-	};
-
 	vddvario: regulator-vddvario {
 		compatible = "regulator-fixed";
 		regulator-name = "vddvario";
@@ -36,11 +24,23 @@
 	};
 };
 
+&omap3_pmx_core {
+
+	smsc1_pins: pinmux_smsc1_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x20b8, PIN_OUTPUT | MUX_MODE0)	/* gpmc_ncs5.gpmc_ncs5 */
+			OMAP3_CORE1_IOPAD(0x219a, PIN_INPUT_PULLUP | MUX_MODE4)	/* uart3_cts_rctx.gpio_163 */
+		>;
+	};
+};
+
 &gpmc {
 	ranges = <5 0 0x2c000000 0x01000000>;
 
 	smsc1: ethernet@5,0 {
 		compatible = "smsc,lan9221", "smsc,lan9115";
+		pinctrl-names = "default";
+		pinctrl-0 = <&smsc1_pins>;
 		interrupt-parent = <&gpio6>;
 		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
 		reg = <5 0 0xff>;
@@ -74,8 +74,6 @@
 };
 
 &i2c1 {
-	clock-frequency = <400000>;
-
 	twl: twl@48 {
 		reg = <0x48>;
 		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
@@ -86,8 +84,8 @@
 #include "twl4030.dtsi"
 #include "twl4030_omap3.dtsi"
 
-&i2c3 {
-	clock-frequency = <400000>;
+&mmc1 {
+	vmmc-supply = <&vmmc1>;
 };
 
 &twl_gpio {
diff --git a/arch/arm/boot/dts/omap3-sb-t35.dtsi b/arch/arm/boot/dts/omap3-sb-t35.dtsi
index b9a2fed..b3b6e43 100644
--- a/arch/arm/boot/dts/omap3-sb-t35.dtsi
+++ b/arch/arm/boot/dts/omap3-sb-t35.dtsi
@@ -2,11 +2,22 @@
  * Common support for CompuLab SB-T35 used on SBC-T3530, SBC-T3517 and SBC-T3730
  */
 
+&omap3_pmx_core {
+	smsc2_pins: pinmux_smsc2_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x20b6, PIN_OUTPUT | MUX_MODE0)	/* gpmc_ncs4.gpmc_ncs4 */
+			OMAP3_CORE1_IOPAD(0x20d2, PIN_INPUT_PULLUP | MUX_MODE4)	/* gpmc_wait3.gpio_65 */
+		>;
+	};
+};
+
 &gpmc {
 	ranges = <4 0 0x2d000000 0x01000000>;
 
 	smsc2: ethernet@4,0 {
 		compatible = "smsc,lan9221", "smsc,lan9115";
+		pinctrl-names = "default";
+		pinctrl-0 = <&smsc2_pins>;
 		interrupt-parent = <&gpio3>;
 		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
 		reg = <4 0 0xff>;
diff --git a/arch/arm/boot/dts/omap3-sbc-t3730.dts b/arch/arm/boot/dts/omap3-sbc-t3730.dts
index 0a8849f..565099c 100644
--- a/arch/arm/boot/dts/omap3-sbc-t3730.dts
+++ b/arch/arm/boot/dts/omap3-sbc-t3730.dts
@@ -14,17 +14,3 @@
 	ranges = <5 0 0x2c000000 0x01000000>,
 		 <4 0 0x2d000000 0x01000000>;
 };
-
-&smsc2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&smsc2_pins>;
-};
-
-&omap3_pmx_core {
-	smsc2_pins: pinmux_smsc2_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x20b6, PIN_OUTPUT | MUX_MODE0)	/* gpmc_ncs4.gpmc_ncs4 */
-			OMAP3_CORE1_IOPAD(0x20d2, PIN_INPUT_PULLUP | MUX_MODE4)	/* gpmc_wait3.gpio_65 */
-		>;
-	};
-};
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 3d5b24d..0748ade 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -99,7 +99,7 @@ static int omap3_sbc_t3730_twl_callback(struct device *dev,
 	int res;
 
 	res = gpio_request_one(gpio + 2, GPIOF_OUT_INIT_HIGH,
-			       "wlan rst");
+			       "wlan pwr");
 	if (res)
 		return res;
 
-- 
1.7.5.4

