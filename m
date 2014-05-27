From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] ARM: dts: Add LCD panel sharp ls037v7dw01 support
 for omap3-evm and ldp
Date: Tue, 27 May 2014 14:14:06 -0700
Message-ID: <20140527211405.GF32336@atomide.com>
References: <CAGhQ9Vwa8xXQEo5dNEKAvmaS9DoBjVSthtd8=owk+atVdFuiiA@mail.gmail.com>
 <20140430174751.GA12362@atomide.com>
 <20140505183919.GA15463@atomide.com>
 <20140508233628.GJ2198@atomide.com>
 <536C7EA7.5000306@ti.com>
 <20140509153723.GD17814@atomide.com>
 <20140513213205.GB18001@atomide.com>
 <537C9FC6.8020104@ti.com>
 <20140521145053.GG17417@atomide.com>
 <20140527205910.GE32336@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:14094 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbaE0VOO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 May 2014 17:14:14 -0400
Content-Disposition: inline
In-Reply-To: <20140527205910.GE32336@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Joachim Eastwood <manabian@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Florian Vaussard <florian.vaussard@epfl.ch>

* Tony Lindgren <tony@atomide.com> [140527 14:00]:
> * Tony Lindgren <tony@atomide.com> [140521 07:51]:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [140521 05:45]:
> > > On 14/05/14 00:32, Tony Lindgren wrote:
> > > 
> > > > +&dss {
> > > > +	status = "ok";
> > > > +	vdds_dsi-supply = <&vpll2>;
> > > > +	port {
> > > > +		dpi_out: endpoint {
> > > > +			remote-endpoint = <&lcd_in>;
> > > > +			data-lines = <18>;
> > > > +		};
> > > > +	};
> > > > +};
> > > 
> > > I just noticed the vdds_dsi-supply there. While the driver currently
> > > uses that if available, I think it should be removed, and done the same
> > > way Florian did with his overo patches:
> > > 
> > > /* Needed to power the DPI pins */
> > > &vpll2 {
> > > 	regulator-always-on;
> > > };
> > > 
> > > That supply is not DSS's supply, but it's used to power up the pins. If
> > > the pins were used as GPIOs, that power should be enabled.
> > 
> > OK thanks for catching it.
> 
> In case you did not yet do it, here's this patch updated for you. I'm
> assuming you'll apply this to your panel dts branch. Let me know when the
> dependencies are in linux next and I'll test it one more time. The omap
> changes finally hit linux next as of today, so I'm only doing fixes
> and minimal changes for now.

Sorry here's the patch one more time with the regulator-always-on added.

FYI, I'm getting this with current linux next:

omapfb omapfb: failed to allocate framebuffer
omapfb omapfb: failed to allocate fbmem
omapfb omapfb: failed to setup omapfb
omapfb: probe of omapfb failed with error -12

Regards,

Tony

8< ---------------------
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 27 May 2014 11:31:02 -0700
Subject: [PATCH] ARM: dts: Add LCD panel sharp ls037v7dw01 support for omap3-evm and ldp

Looks like quite a few omap3 boards have sharp ls037v7dw01 that's
configured as various panel dpi entries for whatever legacy reasons.
For device tree based support, let's just configure these properly for
panel ls037v7dw01 instead of panel dpi.

This patch creates a common file for panel ls037v7dw01, and makes
boards ldp and omap3-evm to use it. The panel for ldp is configured
in the qvga mode and omap3-evm panel in vga mode.

The ls037v7dw01 also seems to be coupled with an ad7846 touchscreen
controller for the omaps, so let's add a basic configuration for
the touchscreen also using the default values.

Note that we can now remove the regulator-name = "vdds_dsi"
entry for ldp, that's no longer needed as we have the entry
for vdds_dsi-supply = <&vpll2>.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/boot/dts/omap3-evm-37xx.dts
+++ b/arch/arm/boot/dts/omap3-evm-37xx.dts
@@ -26,7 +26,44 @@
 	};
 };
 
+&dss {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+		&dss_dpi_pins1
+		&dss_dpi_pins2
+	>;
+};
+
 &omap3_pmx_core {
+	dss_dpi_pins1: pinmux_dss_dpi_pins2 {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x20d4, PIN_OUTPUT | MUX_MODE0)   /* dss_pclk.dss_pclk */
+			OMAP3_CORE1_IOPAD(0x20d6, PIN_OUTPUT | MUX_MODE0)   /* dss_hsync.dss_hsync */
+			OMAP3_CORE1_IOPAD(0x20d8, PIN_OUTPUT | MUX_MODE0)   /* dss_vsync.dss_vsync */
+			OMAP3_CORE1_IOPAD(0x20da, PIN_OUTPUT | MUX_MODE0)   /* dss_acbias.dss_acbias */
+
+			OMAP3_CORE1_IOPAD(0x20e8, PIN_OUTPUT | MUX_MODE0)   /* dss_data6.dss_data6 */
+			OMAP3_CORE1_IOPAD(0x20ea, PIN_OUTPUT | MUX_MODE0)   /* dss_data7.dss_data7 */
+			OMAP3_CORE1_IOPAD(0x20ec, PIN_OUTPUT | MUX_MODE0)   /* dss_data8.dss_data8 */
+			OMAP3_CORE1_IOPAD(0x20ee, PIN_OUTPUT | MUX_MODE0)   /* dss_data9.dss_data9 */
+			OMAP3_CORE1_IOPAD(0x20f0, PIN_OUTPUT | MUX_MODE0)   /* dss_data10.dss_data10 */
+			OMAP3_CORE1_IOPAD(0x20f2, PIN_OUTPUT | MUX_MODE0)   /* dss_data11.dss_data11 */
+			OMAP3_CORE1_IOPAD(0x20f4, PIN_OUTPUT | MUX_MODE0)   /* dss_data12.dss_data12 */
+			OMAP3_CORE1_IOPAD(0x20f6, PIN_OUTPUT | MUX_MODE0)   /* dss_data13.dss_data13 */
+			OMAP3_CORE1_IOPAD(0x20f8, PIN_OUTPUT | MUX_MODE0)   /* dss_data14.dss_data14 */
+			OMAP3_CORE1_IOPAD(0x20fa, PIN_OUTPUT | MUX_MODE0)   /* dss_data15.dss_data15 */
+			OMAP3_CORE1_IOPAD(0x20fc, PIN_OUTPUT | MUX_MODE0)   /* dss_data16.dss_data16 */
+			OMAP3_CORE1_IOPAD(0x20fe, PIN_OUTPUT | MUX_MODE0)   /* dss_data17.dss_data17 */
+
+			OMAP3_CORE1_IOPAD(0x2100, PIN_OUTPUT | MUX_MODE3)   /* dss_data18.dss_data0 */
+			OMAP3_CORE1_IOPAD(0x2102, PIN_OUTPUT | MUX_MODE3)   /* dss_data19.dss_data1 */
+			OMAP3_CORE1_IOPAD(0x2104, PIN_OUTPUT | MUX_MODE3)   /* dss_data20.dss_data2 */
+			OMAP3_CORE1_IOPAD(0x2106, PIN_OUTPUT | MUX_MODE3)   /* dss_data21.dss_data3 */
+			OMAP3_CORE1_IOPAD(0x2108, PIN_OUTPUT | MUX_MODE3)   /* dss_data22.dss_data4 */
+			OMAP3_CORE1_IOPAD(0x210a, PIN_OUTPUT | MUX_MODE3)   /* dss_data23.dss_data5 */
+		>;
+	};
+
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
 			0x114 (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk.sdmmc1_clk */
@@ -75,6 +112,19 @@
 	};
 };
 
+&omap3_pmx_wkup {
+	dss_dpi_pins2: pinmux_dss_dpi_pins1 {
+		pinctrl-single,pins = <
+			0x0a (PIN_OUTPUT | MUX_MODE3)   /* sys_boot0.dss_data18 */
+			0x0c (PIN_OUTPUT | MUX_MODE3)   /* sys_boot1.dss_data19 */
+			0x10 (PIN_OUTPUT | MUX_MODE3)   /* sys_boot3.dss_data20 */
+			0x12 (PIN_OUTPUT | MUX_MODE3)   /* sys_boot4.dss_data21 */
+			0x14 (PIN_OUTPUT | MUX_MODE3)   /* sys_boot5.dss_data22 */
+			0x16 (PIN_OUTPUT | MUX_MODE3)   /* sys_boot6.dss_data23 */
+		>;
+	};
+};
+
 &mmc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
--- a/arch/arm/boot/dts/omap3-evm-common.dtsi
+++ b/arch/arm/boot/dts/omap3-evm-common.dtsi
@@ -44,6 +44,11 @@
 
 #include "twl4030.dtsi"
 #include "twl4030_omap3.dtsi"
+#include "omap3-panel-sharp-ls037v7dw01.dtsi"
+
+&backlight0 {
+	gpios = <&twl_gpio 18 GPIO_ACTIVE_LOW>;
+};
 
 &twl {
 	twl_power: power {
@@ -68,6 +73,32 @@
 	};
 };
 
+&lcd_3v3 {
+	gpio = <&gpio5 25 GPIO_ACTIVE_LOW>;	/* gpio153 */
+	enable-active-low;
+};
+
+&lcd0 {
+	enable-gpios = <&gpio5 24 GPIO_ACTIVE_HIGH>;	/* gpio152, lcd INI */
+	reset-gpios = <&gpio5 27 GPIO_ACTIVE_HIGH>;	/* gpio155, lcd RESB */
+	/*
+	 * The LCD is sideways, so we want the VGA mode instead of
+	 * QVGA mode. Probably also want to have omapfb.rotate=3
+	 * in the kernel cmdline until there's a binding for that.
+	 */
+	mode-gpios = <&gpio5 26 GPIO_ACTIVE_LOW		/* gpio154, lcd MO */
+		      &gpio1 2 GPIO_ACTIVE_HIGH		/* gpio2, lcd LR */
+		      &gpio1 3 GPIO_ACTIVE_HIGH>;	/* gpio3, lcd UD */
+};
+
+&mcspi1 {
+	tsc2046@0 {
+		interrupt-parent = <&gpio6>;
+		interrupts = <15 0>;		/* gpio175 */
+		pendown-gpio = <&gpio6 15 0>;
+	};
+};
+
 &mmc1 {
 	vmmc-supply = <&vmmc1>;
 	vmmc_aux-supply = <&vsim>;
--- a/arch/arm/boot/dts/omap3-ldp.dts
+++ b/arch/arm/boot/dts/omap3-ldp.dts
@@ -164,6 +164,11 @@
 
 #include "twl4030.dtsi"
 #include "twl4030_omap3.dtsi"
+#include "omap3-panel-sharp-ls037v7dw01.dtsi"
+
+&backlight0 {
+	gpios = <&twl_gpio 7 GPIO_ACTIVE_HIGH>;
+};
 
 &i2c2 {
 	clock-frequency = <400000>;
@@ -173,6 +178,25 @@
 	clock-frequency = <400000>;
 };
 
+/* tps61130rsa enabled by twl4030 regen */
+&lcd_3v3 {
+	regulator-always-on;
+};
+
+&lcd0 {
+	enable-gpios = <&twl_gpio 15 GPIO_ACTIVE_HIGH>;	/* lcd INI */
+	reset-gpios = <&gpio2 23 GPIO_ACTIVE_HIGH>;	/* gpio55, lcd RESB */
+	mode-gpios = <&gpio2 24 GPIO_ACTIVE_HIGH>;	/* gpio56, lcd MO */
+};
+
+&mcspi1 {
+	tsc2046@0 {
+		interrupt-parent = <&gpio2>;
+		interrupts = <22 0>;		/* gpio54 */
+		pendown-gpio = <&gpio2 22 0>;
+	};
+};
+
 &mmc1 {
 	/* See 35xx errata 2.1.1.128 in SPRZ278F */
 	compatible = "ti,omap3-pre-es3-hsmmc";
@@ -251,8 +275,3 @@
 	/* Needed for ads7846 */
         regulator-name = "vcc";
 };
-
-&vpll2 {
-       /* Needed for DSS */
-       regulator-name = "vdds_dsi";
-};
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi
@@ -0,0 +1,72 @@
+/*
+ * Common file for omap dpi panels with QVGA and reset pins
+ *
+ * Note that the board specifc DTS file needs to specify
+ * at minimum the GPIO enable-gpios for display, and
+ * gpios for gpio-backlight.
+ */
+
+/ {
+	aliases {
+		display0 = &lcd0;
+	};
+
+	backlight0: backlight {
+		compatible = "gpio-backlight";
+		default-on;
+	};
+
+	/* 3.3V GPIO controlled regulator for LCD_ENVDD */
+	lcd_3v3: regulator-lcd-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <70000>;
+	};
+
+	lcd0: display {
+		compatible = "sharp,ls037v7dw01";
+		label = "lcd";
+		power-supply = <&lcd_3v3>;
+
+		port {
+			lcd_in: endpoint {
+				remote-endpoint = <&dpi_out>;
+			};
+		};
+	};
+};
+
+&dss {
+	status = "ok";
+	port {
+		dpi_out: endpoint {
+			remote-endpoint = <&lcd_in>;
+			data-lines = <18>;
+		};
+	};
+};
+
+&mcspi1 {
+	tsc2046@0 {
+		reg = <0>;			/* CS0 */
+		compatible = "ti,tsc2046";
+		spi-max-frequency = <1000000>;
+		vcc-supply = <&lcd_3v3>;
+		ti,x-min = /bits/ 16 <0>;
+		ti,x-max = /bits/ 16 <8000>;
+		ti,y-min = /bits/ 16 <0>;
+		ti,y-max = /bits/ 16 <4800>;
+		ti,x-plate-ohms = /bits/ 16 <40>;
+		ti,pressure-max = /bits/ 16 <255>;
+		ti,swap-xy;
+		linux,wakeup;
+	};
+};
+
+/* Needed to power the DPI pins */
+&vpll2 {
+	regulator-always-on;
+};
+
