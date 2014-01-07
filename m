From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/2] ARM: omap3: Split the pinmux core device
Date: Tue, 7 Jan 2014 14:36:06 -0800
Message-ID: <20140107223605.GB5074@atomide.com>
References: <1387554677-21100-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <1387554677-21100-3-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:47026 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707AbaAGWgN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jan 2014 17:36:13 -0500
Content-Disposition: inline
In-Reply-To: <1387554677-21100-3-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel <sre@debian.org>, Sakari Ailus <sakari.ailus@iki.fi>

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [131220 07:52]:
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -117,7 +117,18 @@
>  
>  		omap3_pmx_core: pinmux@48002030 {
>  			compatible = "ti,omap3-padconf", "pinctrl-single";
> -			reg = <0x48002030 0x05cc>;
> +			reg = <0x48002030 0x0238>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			#interrupt-cells = <1>;
> +			interrupt-controller;
> +			pinctrl-single,register-width = <16>;
> +			pinctrl-single,function-mask = <0xff1f>;
> +		};
> +
> +		omap3_pmx_core2: pinmux@480025a0 {
> +			compatible = "ti,omap3-padconf", "pinctrl-single";
> +			reg = <0x480025a0 0x005c>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			#interrupt-cells = <1>;

Looking at Nishant's similar patch, we need to have separate
omap3_pmx_core2 for 3430 and 3630. I've updated the patch accordingly
with the related parts from Nishant's patch and committed it into
omap-for-v3.14/dt branch.

Regards,

Tony

8< ------------------------------
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 7 Jan 2014 14:01:39 -0800
Subject: [PATCH] ARM: dts: Split omap3 pinmux core device

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

Note that the core2 padconf region is different for 3430 vs 3630,
and does not exist on 3517 as noted by Nishanth Menon <nm@ti.com>.

Reported-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-By: Sebastian Reichel <sre@debian.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
[tony@atomide.com: updated for 3430 vs 3630 core2 based on Nishant's patch]
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index df33a50..447e714 100644
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
+			OMAP3630_CORE2_IOPAD(0x25f0, PIN_OUTPUT | MUX_MODE3)		/* etk_d10.hsusb2_clk */
+			OMAP3630_CORE2_IOPAD(0x25f2, PIN_OUTPUT | MUX_MODE3)		/* etk_d11.hsusb2_stp */
+			OMAP3630_CORE2_IOPAD(0x25f4, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d12.hsusb2_dir */
+			OMAP3630_CORE2_IOPAD(0x25f6, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d13.hsusb2_nxt */
+			OMAP3630_CORE2_IOPAD(0x25f8, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d14.hsusb2_data0 */
+			OMAP3630_CORE2_IOPAD(0x25fa, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d15.hsusb2_data1 */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 3ba4a62..5053766 100644
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
+			OMAP3430_CORE2_IOPAD(0x25f0, PIN_OUTPUT | MUX_MODE3)		/* etk_d10.hsusb2_clk */
+			OMAP3430_CORE2_IOPAD(0x25f2, PIN_OUTPUT | MUX_MODE3)		/* etk_d11.hsusb2_stp */
+			OMAP3430_CORE2_IOPAD(0x25f4, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d12.hsusb2_dir */
+			OMAP3430_CORE2_IOPAD(0x25f6, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d13.hsusb2_nxt */
+			OMAP3430_CORE2_IOPAD(0x25f8, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d14.hsusb2_data0 */
+			OMAP3430_CORE2_IOPAD(0x25fa, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d15.hsusb2_data1 */
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
index 1c7e74d..25a2b5f 100644
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
+			OMAP3630_CORE2_IOPAD(0x25da, PIN_OUTPUT | MUX_MODE3)		/* etk_ctl.hsusb1_clk */
+			OMAP3630_CORE2_IOPAD(0x25d8, PIN_OUTPUT | MUX_MODE3)		/* etk_clk.hsusb1_stp */
+			OMAP3630_CORE2_IOPAD(0x25ec, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d8.hsusb1_dir */
+			OMAP3630_CORE2_IOPAD(0x25ee, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d9.hsusb1_nxt */
+			OMAP3630_CORE2_IOPAD(0x25dc, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d0.hsusb1_data0 */
+			OMAP3630_CORE2_IOPAD(0x25de, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d1.hsusb1_data1 */
+			OMAP3630_CORE2_IOPAD(0x25e0, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d2.hsusb1_data2 */
+			OMAP3630_CORE2_IOPAD(0x25e2, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d3.hsusb1_data7 */
+			OMAP3630_CORE2_IOPAD(0x25e4, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d4.hsusb1_data4 */
+			OMAP3630_CORE2_IOPAD(0x25e6, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d5.hsusb1_data5 */
+			OMAP3630_CORE2_IOPAD(0x25e8, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d6.hsusb1_data6 */
+			OMAP3630_CORE2_IOPAD(0x25ea, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d7.hsusb1_data3 */
+		>;
+	};
+
+	leds_pins: pinmux_leds_pins {
+		pinctrl-single,pins = <
+			OMAP3630_CORE2_IOPAD(0x25f4, PIN_OUTPUT | MUX_MODE4) /* etk_d12.gpio_26 */
+			OMAP3630_CORE2_IOPAD(0x25f6, PIN_OUTPUT | MUX_MODE4) /* etk_d13.gpio_27 */
+			OMAP3630_CORE2_IOPAD(0x25f8, PIN_OUTPUT | MUX_MODE4) /* etk_d14.gpio_28 */
+		>;
+	};
 };
 
 &i2c3 {
diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/omap3-igep0030.dts
index 02a23f8..145c58c 100644
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
+			OMAP3630_CORE2_IOPAD(0x25e0, PIN_OUTPUT | MUX_MODE4) /* etk_d2.gpio_16 */
+		>;
+	};
 };
 
 &gpmc {
diff --git a/arch/arm/boot/dts/omap3-zoom3.dts b/arch/arm/boot/dts/omap3-zoom3.dts
index 15eb9fe..6644f51 100644
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
+			OMAP3630_CORE2_IOPAD(0x25d8, PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_clk.sdmmc3_clk */
+			OMAP3630_CORE2_IOPAD(0x25e4, PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_d4.sdmmc3_dat0 */
+			OMAP3630_CORE2_IOPAD(0x25e6, WAKEUP_EN | PIN_INPUT_PULLUP | MUX_MODE2) /* etk_d5.sdmmc3_dat1 */
+			OMAP3630_CORE2_IOPAD(0x25e8, PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_d6.sdmmc3_dat2 */
+			OMAP3630_CORE2_IOPAD(0x25e2, PIN_INPUT_PULLUP | MUX_MODE2)	/* etk_d3.sdmmc3_dat3 */
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
index daabf99..427395c 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -117,7 +117,7 @@
 
 		omap3_pmx_core: pinmux@48002030 {
 			compatible = "ti,omap3-padconf", "pinctrl-single";
-			reg = <0x48002030 0x05cc>;
+			reg = <0x48002030 0x0238>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#interrupt-cells = <1>;
diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/omap34xx.dtsi
index 5355d61..77d1246 100644
--- a/arch/arm/boot/dts/omap34xx.dtsi
+++ b/arch/arm/boot/dts/omap34xx.dtsi
@@ -25,4 +25,17 @@
 			clock-latency = <300000>; /* From legacy driver */
 		};
 	};
+
+	ocp {
+		omap3_pmx_core2: pinmux@480025d8 {
+			compatible = "ti,omap3-padconf", "pinctrl-single";
+			reg = <0x480025d8 0x24>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			pinctrl-single,register-width = <16>;
+			pinctrl-single,function-mask = <0xff1f>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
index 380c22e..b7c7bd9 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -38,5 +38,16 @@
 			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
 		};
+
+		omap3_pmx_core2: pinmux@480025a0 {
+			compatible = "ti,omap3-padconf", "pinctrl-single";
+			reg = <0x480025a0 0x5c>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			pinctrl-single,register-width = <16>;
+			pinctrl-single,function-mask = <0xff1f>;
+		};
 	};
 };
