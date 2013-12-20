From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 2/2] ARM: omap3: Split the pinmux core device
Date: Fri, 20 Dec 2013 16:51:17 +0100
Message-ID: <1387554677-21100-3-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1387554677-21100-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:53458 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753714Ab3LTPvA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Dec 2013 10:51:00 -0500
In-Reply-To: <1387554677-21100-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel <sre@debian.org>, Sakari Ailus <sakari.ailus@iki.fi>

The omap3_pmx_core pinmux device in the device tree handles the system
controller module (SCM) PADCONFS fonction. Its control registers are
split in two distinct areas, with other SCM registers in-between. Those
other registers can't thus be requested by other drivers as the memory
region gets reserved by the pinmux driver.

Split the omap3_pmx_core device tree node in two for the two memory
regions. The second region address and size depends on the SoC model.

The change in omap3.dtsi fixes an "external abort on non-linefetch" when
doing

cat /sys/kernel/debug/pinctrl/.../pins

on a Nokia N900.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-By: Sebastian Reichel <sre@debian.org>
---
 arch/arm/boot/dts/omap3-beagle-xm.dts | 40 +++++++++++++++++----------
 arch/arm/boot/dts/omap3-beagle.dts    | 40 +++++++++++++++++----------
 arch/arm/boot/dts/omap3-igep.dtsi     |  2 --
 arch/arm/boot/dts/omap3-igep0020.dts  | 52 +++++++++++++++++++----------------
 arch/arm/boot/dts/omap3-igep0030.dts  | 10 ++++---
 arch/arm/boot/dts/omap3-zoom3.dts     | 23 ++++++++++------
 arch/arm/boot/dts/omap3.dtsi          | 13 ++++++++-
 7 files changed, 114 insertions(+), 66 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index df33a50..093c33c 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -99,7 +99,7 @@
 &omap3_pmx_core {
 	pinctrl-names = "default";
 	pinctrl-0 = <
-			&hsusbb2_pins
+			&hsusb2_pins
 	>;
 
 	uart3_pins: pinmux_uart3_pins {
@@ -109,20 +109,32 @@
 		>;
 	};
 
-	hsusbb2_pins: pinmux_hsusbb2_pins {
+	hsusb2_pins: pinmux_hsusb2_pins {
 		pinctrl-single,pins = <
-			0x5c0 (PIN_OUTPUT | MUX_MODE3)		/* etk_d10.hsusb2_clk */
-			0x5c2 (PIN_OUTPUT | MUX_MODE3)		/* etk_d11.hsusb2_stp */
-			0x5c4 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d12.hsusb2_dir */
-			0x5c6 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d13.hsusb2_nxt */
-			0x5c8 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d14.hsusb2_data0 */
-			0x5cA (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d15.hsusb2_data1 */
-			0x1a4 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi1_cs3.hsusb2_data2 */
-			0x1a6 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_clk.hsusb2_data7 */
-			0x1a8 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_simo.hsusb2_data4 */
-			0x1aa (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_somi.hsusb2_data5 */
-			0x1ac (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_cs0.hsusb2_data6 */
-			0x1ae (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_cs1.hsusb2_data3 */
+			OMAP3_CORE1_IOPAD(0x21d4, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi1_cs3.hsusb2_data2 */
+			OMAP3_CORE1_IOPAD(0x21d6, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_clk.hsusb2_data7 */
+			OMAP3_CORE1_IOPAD(0x21d8, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_simo.hsusb2_data4 */
+			OMAP3_CORE1_IOPAD(0x21da, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_somi.hsusb2_data5 */
+			OMAP3_CORE1_IOPAD(0x21dc, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_cs0.hsusb2_data6 */
+			OMAP3_CORE1_IOPAD(0x21de, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_cs1.hsusb2_data3 */
+		>;
+	};
+};
+
+&omap3_pmx_core2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+			&hsusb2_2_pins
+	>;
+
+	hsusb2_2_pins: pinmux_hsusb2_2_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE2_IOPAD(0x25f0, PIN_OUTPUT | MUX_MODE3)		/* etk_d10.hsusb2_clk */
+			OMAP3_CORE2_IOPAD(0x25f2, PIN_OUTPUT | MUX_MODE3)		/* etk_d11.hsusb2_stp */
+			OMAP3_CORE2_IOPAD(0x25f4, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d12.hsusb2_dir */
+			OMAP3_CORE2_IOPAD(0x25f6, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d13.hsusb2_nxt */
+			OMAP3_CORE2_IOPAD(0x25f8, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d14.hsusb2_data0 */
+			OMAP3_CORE2_IOPAD(0x25fa, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d15.hsusb2_data1 */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 3ba4a62..4034fd2 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -93,23 +93,17 @@
 &omap3_pmx_core {
 	pinctrl-names = "default";
 	pinctrl-0 = <
-			&hsusbb2_pins
+			&hsusb2_pins
 	>;
 
-	hsusbb2_pins: pinmux_hsusbb2_pins {
+	hsusb2_pins: pinmux_hsusb2_pins {
 		pinctrl-single,pins = <
-			0x5c0 (PIN_OUTPUT | MUX_MODE3)		/* etk_d10.hsusb2_clk */
-			0x5c2 (PIN_OUTPUT | MUX_MODE3)		/* etk_d11.hsusb2_stp */
-			0x5c4 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d12.hsusb2_dir */
-			0x5c6 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d13.hsusb2_nxt */
-			0x5c8 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d14.hsusb2_data0 */
-			0x5cA (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d15.hsusb2_data1 */
-			0x1a4 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi1_cs3.hsusb2_data2 */
-			0x1a6 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_clk.hsusb2_data7 */
-			0x1a8 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_simo.hsusb2_data4 */
-			0x1aa (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_somi.hsusb2_data5 */
-			0x1ac (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_cs0.hsusb2_data6 */
-			0x1ae (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_cs1.hsusb2_data3 */
+			OMAP3_CORE1_IOPAD(0x21d4, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi1_cs3.hsusb2_data2 */
+			OMAP3_CORE1_IOPAD(0x21d6, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_clk.hsusb2_data7 */
+			OMAP3_CORE1_IOPAD(0x21d8, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_simo.hsusb2_data4 */
+			OMAP3_CORE1_IOPAD(0x21da, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_somi.hsusb2_data5 */
+			OMAP3_CORE1_IOPAD(0x21dc, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_cs0.hsusb2_data6 */
+			OMAP3_CORE1_IOPAD(0x21de, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_cs1.hsusb2_data3 */
 		>;
 	};
 
@@ -121,6 +115,24 @@
 	};
 };
 
+&omap3_pmx_core2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+			&hsusb2_2_pins
+	>;
+
+	hsusb2_2_pins: pinmux_hsusb2_2_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE2_IOPAD(0x25f0, PIN_OUTPUT | MUX_MODE3)		/* etk_d10.hsusb2_clk */
+			OMAP3_CORE2_IOPAD(0x25f2, PIN_OUTPUT | MUX_MODE3)		/* etk_d11.hsusb2_stp */
+			OMAP3_CORE2_IOPAD(0x25f4, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d12.hsusb2_dir */
+			OMAP3_CORE2_IOPAD(0x25f6, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d13.hsusb2_nxt */
+			OMAP3_CORE2_IOPAD(0x25f8, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d14.hsusb2_data0 */
+			OMAP3_CORE2_IOPAD(0x25fa, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d15.hsusb2_data1 */
+		>;
+	};
+};
+
 &i2c1 {
 	clock-frequency = <2600000>;
 
diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index 165aaf7..c1700932 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -133,8 +133,6 @@
 			0x194 (PIN_INPUT | MUX_MODE0)   /* i2c3_sda.i2c3_sda */
 		>;
 	};
-
-	leds_pins: pinmux_leds_pins { };
 };
 
 &i2c1 {
diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index 1c7e74d..f4eb4c2 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -66,28 +66,10 @@
 &omap3_pmx_core {
 	pinctrl-names = "default";
 	pinctrl-0 = <
-		&hsusbb1_pins
 		&tfp410_pins
 		&dss_pins
 	>;
 
-	hsusbb1_pins: pinmux_hsusbb1_pins {
-		pinctrl-single,pins = <
-			0x5aa (PIN_OUTPUT | MUX_MODE3)		/* etk_ctl.hsusb1_clk */
-			0x5a8 (PIN_OUTPUT | MUX_MODE3)		/* etk_clk.hsusb1_stp */
-			0x5bc (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d8.hsusb1_dir */
-			0x5be (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d9.hsusb1_nxt */
-			0x5ac (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d0.hsusb1_data0 */
-			0x5ae (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d1.hsusb1_data1 */
-			0x5b0 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d2.hsusb1_data2 */
-			0x5b2 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d3.hsusb1_data7 */
-			0x5b4 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d4.hsusb1_data4 */
-			0x5b6 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d5.hsusb1_data5 */
-			0x5b8 (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d6.hsusb1_data6 */
-			0x5ba (PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d7.hsusb1_data3 */
-		>;
-	};
-
 	tfp410_pins: tfp410_dvi_pins {
 		pinctrl-single,pins = <
 			0x196 (PIN_OUTPUT | MUX_MODE4)   /* hdq_sio.gpio_170 */
@@ -128,12 +110,36 @@
 	};
 };
 
-&leds_pins {
-	pinctrl-single,pins = <
-		0x5c4 (PIN_OUTPUT | MUX_MODE4) /* etk_d12.gpio_26 */
-		0x5c6 (PIN_OUTPUT | MUX_MODE4) /* etk_d13.gpio_27 */
-		0x5c8 (PIN_OUTPUT | MUX_MODE4) /* etk_d14.gpio_28 */
+&omap3_pmx_core2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+		&hsusbb1_pins
 	>;
+
+	hsusbb1_pins: pinmux_hsusbb1_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE2_IOPAD(0x25da, PIN_OUTPUT | MUX_MODE3)		/* etk_ctl.hsusb1_clk */
+			OMAP3_CORE2_IOPAD(0x25d8, PIN_OUTPUT | MUX_MODE3)		/* etk_clk.hsusb1_stp */
+			OMAP3_CORE2_IOPAD(0x25ec, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d8.hsusb1_dir */
+			OMAP3_CORE2_IOPAD(0x25ee, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d9.hsusb1_nxt */
+			OMAP3_CORE2_IOPAD(0x25dc, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d0.hsusb1_data0 */
+			OMAP3_CORE2_IOPAD(0x25de, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d1.hsusb1_data1 */
+			OMAP3_CORE2_IOPAD(0x25e0, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d2.hsusb1_data2 */
+			OMAP3_CORE2_IOPAD(0x25e2, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d3.hsusb1_data7 */
+			OMAP3_CORE2_IOPAD(0x25e4, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d4.hsusb1_data4 */
+			OMAP3_CORE2_IOPAD(0x25e6, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d5.hsusb1_data5 */
+			OMAP3_CORE2_IOPAD(0x25e8, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d6.hsusb1_data6 */
+			OMAP3_CORE2_IOPAD(0x25ea, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d7.hsusb1_data3 */
+		>;
+	};
+
+	leds_pins: pinmux_leds_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE2_IOPAD(0x25f4, PIN_OUTPUT | MUX_MODE4) /* etk_d12.gpio_26 */
+			OMAP3_CORE2_IOPAD(0x25f6, PIN_OUTPUT | MUX_MODE4) /* etk_d13.gpio_27 */
+			OMAP3_CORE2_IOPAD(0x25f8, PIN_OUTPUT | MUX_MODE4) /* etk_d14.gpio_28 */
+		>;
+	};
 };
 
 &i2c3 {
diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/omap3-igep0030.dts
index 02a23f8..4425ae8 100644
--- a/arch/arm/boot/dts/omap3-igep0030.dts
+++ b/arch/arm/boot/dts/omap3-igep0030.dts
@@ -46,10 +46,12 @@
 	};
 };
 
-&leds_pins {
-	pinctrl-single,pins = <
-		0x5b0 (PIN_OUTPUT | MUX_MODE4) /* etk_d2.gpio_16 */
-	>;
+&omap3_pmx_core2 {
+	leds_pins: pinmux_leds_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE2_IOPAD(0x25e0, PIN_OUTPUT | MUX_MODE4) /* etk_d2.gpio_16 */
+		>;
+	};
 };
 
 &gpmc {
diff --git a/arch/arm/boot/dts/omap3-zoom3.dts b/arch/arm/boot/dts/omap3-zoom3.dts
index 15eb9fe..417111c 100644
--- a/arch/arm/boot/dts/omap3-zoom3.dts
+++ b/arch/arm/boot/dts/omap3-zoom3.dts
@@ -80,13 +80,8 @@
 
 	mmc3_pins: pinmux_mmc3_pins {
 		pinctrl-single,pins = <
-			0x168 (PIN_INPUT | MUX_MODE4)	/* mcbsp1_clkx.gpio_162 WLAN IRQ */
-			0x1a0 (PIN_INPUT_PULLUP | MUX_MODE3)	/* mcspi1_cs1.sdmmc3_cmd */
-			0x5a8 (PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_clk.sdmmc3_clk */
-			0x5b4 (PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_d4.sdmmc3_dat0 */
-			0x5b6 (WAKEUP_EN | PIN_INPUT_PULLUP | MUX_MODE2) /* etk_d5.sdmmc3_dat1 */
-			0x5b8 (PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_d6.sdmmc3_dat2 */
-			0x5b2 (PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_d3.sdmmc3_dat3 */
+			OMAP3_CORE1_IOPAD(0x2198, PIN_INPUT | MUX_MODE4)	/* mcbsp1_clkx.gpio_162 WLAN IRQ */
+			OMAP3_CORE1_IOPAD(0x21d0, PIN_INPUT_PULLUP | MUX_MODE3)	/* mcspi1_cs1.sdmmc3_cmd */
 		>;
 	};
 
@@ -125,6 +120,18 @@
 	};
 };
 
+&omap3_pmx_core2 {
+	mmc3_2_pins: pinmux_mmc3_2_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE2_IOPAD(0x25d8, PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_clk.sdmmc3_clk */
+			OMAP3_CORE2_IOPAD(0x25e4, PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_d4.sdmmc3_dat0 */
+			OMAP3_CORE2_IOPAD(0x25e6, WAKEUP_EN | PIN_INPUT_PULLUP | MUX_MODE2) /* etk_d5.sdmmc3_dat1 */
+			OMAP3_CORE2_IOPAD(0x25e8, PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_d6.sdmmc3_dat2 */
+			OMAP3_CORE2_IOPAD(0x25e2, PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_d3.sdmmc3_dat3 */
+		>;
+	};
+};
+
 &omap3_pmx_wkup {
 	wlan_host_wkup: pinmux_wlan_host_wkup_pins {
 		pinctrl-single,pins = <
@@ -187,7 +194,7 @@
 	bus-width = <4>;
 	cap-power-off-card;
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc3_pins>;
+	pinctrl-0 = <&mmc3_pins &mmc3_2_pins>;
 };
 
 &uart1 {
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index daabf99..d2bba78 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -117,7 +117,18 @@
 
 		omap3_pmx_core: pinmux@48002030 {
 			compatible = "ti,omap3-padconf", "pinctrl-single";
-			reg = <0x48002030 0x05cc>;
+			reg = <0x48002030 0x0238>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			pinctrl-single,register-width = <16>;
+			pinctrl-single,function-mask = <0xff1f>;
+		};
+
+		omap3_pmx_core2: pinmux@480025a0 {
+			compatible = "ti,omap3-padconf", "pinctrl-single";
+			reg = <0x480025a0 0x005c>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#interrupt-cells = <1>;
-- 
1.8.3.2

