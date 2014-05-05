From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 4/4] ARM: dts: Add LCD panel sharp ls037v7dw01 support
 for omap3-evm and ldp
Date: Mon, 5 May 2014 11:39:20 -0700
Message-ID: <20140505183919.GA15463@atomide.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-5-git-send-email-tony@atomide.com>
 <CAGhQ9Vwa8xXQEo5dNEKAvmaS9DoBjVSthtd8=owk+atVdFuiiA@mail.gmail.com>
 <20140430174751.GA12362@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140430174751.GA12362-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [140430 10:48]:
> * Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [140429 18:08]:
> > On 30 April 2014 01:52, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> > > Looks like quite a few omaps have sharp ls037v7dw01 that's configured
> > > as various panel dpi entries for whatever legacy reasons. For device
> > > tree based support, let's just configure these properly for panel
> > > ls037v7dw01 instead of panel dpi.
> > >
> > > This patch creates a common file for panel ls037v7dw01, and makes
> > > boards ldp and omap3-evm to use it. The panel for ldp is configured
> > > in the qvga mode and omap3-evm panel in vga mode.
> > >
> > > The ls037v7dw01 also seems to be coupled with an ad7846 touchscreen
> > > controller for the omaps, so let's add a basic configuration for
> > > the touchscreen also using the default values.
> > >
> > > Note that we can now remove the regulator-name = "vdds_dsi"
> > > entry for ldp, that's no longer needed as we have the entry
> > > for vdds_dsi-supply = <&vpll2>.
> > >
> > > Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > > ---
> > >  .../arm/boot/dts/omap-panel-sharp-ls037v7dw01.dtsi | 82 ++++++++++++++++++++++
> > >  arch/arm/boot/dts/omap3-evm-37xx.dts               | 50 +++++++++++++
> > >  arch/arm/boot/dts/omap3-evm-common.dtsi            | 47 +++++++++++++
> > >  arch/arm/boot/dts/omap3-ldp.dts                    | 31 ++++++--
> > >  4 files changed, 205 insertions(+), 5 deletions(-)
> > >  create mode 100644 arch/arm/boot/dts/omap-panel-sharp-ls037v7dw01.dtsi
> > 
> > > diff --git a/arch/arm/boot/dts/omap3-ldp.dts b/arch/arm/boot/dts/omap3-ldp.dts
> > > index 0abe986..50fdac9 100644
> > > --- a/arch/arm/boot/dts/omap3-ldp.dts
> > > +++ b/arch/arm/boot/dts/omap3-ldp.dts
> > > @@ -164,6 +164,7 @@
> > >
> > >  #include "twl4030.dtsi"
> > >  #include "twl4030_omap3.dtsi"
> > > +#include "omap-panel-sharp-ls037v7dw01.dtsi"
> > >
> > >  &i2c2 {
> > >         clock-frequency = <400000>;
> > > @@ -173,6 +174,31 @@
> > >         clock-frequency = <400000>;
> > >  };
> > >
> > > +&lcd_3v3 {
> > > +       gpio = <&twl_gpio 7 GPIO_ACTIVE_HIGH>;
> > > +       enable-active-high;
> > > +};
> > > +
> > > +&lcd0 {
> > > +       reset-gpios = <&gpio2 23 GPIO_ACTIVE_HIGH>;     /* gpio55, lcd RESB */
> > > +       gpios = <&gpio2 24 GPIO_ACTIVE_LOW      /* gpio56, lcd MO */
> > 
> > enable-gpios ?
> 
> Oops yes, changed from gpios to enable-gpios while reading the panel
> binding doc, probably forgot to commit the change, will update.

Here's an updated version of this one.

Tony


From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Date: Mon, 28 Apr 2014 20:22:21 -0700
Subject: [PATCH] ARM: dts: Add LCD panel sharp ls037v7dw01 support for omap3-evm and ldp

Looks like quite a few omaps have sharp ls037v7dw01 that's configured
as various panel dpi entries for whatever legacy reasons. For device
tree based support, let's just configure these properly for panel
ls037v7dw01 instead of panel dpi.

This patch creates a common file for panel ls037v7dw01, and makes
boards ldp and omap3-evm to use it. The panel for ldp is configured
in the qvga mode and omap3-evm panel in vga mode.

The ls037v7dw01 also seems to be coupled with an ad7846 touchscreen
controller for the omaps, so let's add a basic configuration for
the touchscreen also using the default values.

Note that we can now remove the regulator-name = "vdds_dsi"
entry for ldp, that's no longer needed as we have the entry
for vdds_dsi-supply = <&vpll2>.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

diff --git a/arch/arm/boot/dts/omap-panel-sharp-ls037v7dw01.dtsi b/arch/arm/boot/dts/omap-panel-sharp-ls037v7dw01.dtsi
new file mode 100644
index 0000000..f5252da
--- /dev/null
+++ b/arch/arm/boot/dts/omap-panel-sharp-ls037v7dw01.dtsi
@@ -0,0 +1,82 @@
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
+	};
+
+	/* 3.3V GPIO controlled regulator for LCD_ENVDD */
+	lcd_3v3: regulator-lcd-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <70000>;
+		regulator-always-on;
+	};
+
+	lcd0: display {
+		compatible = "sharp,ls037v7dw01";
+		label = "lcd";
+		power-supply = <&lcd_3v3>;
+		panel-timing {
+			clock-frequency = <5400000>;
+			hback-porch = <39>;
+			hactive = <240>;
+			hfront-porch = <3>;
+			hsync-len = <3>;
+			vback-porch = <7>;
+			vactive = <320>;
+			vfront-porch = <2>;
+			vsync-len = <1>;
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <1>;
+			pixelclk-active = <1>;
+		};
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
+	vdds_dsi-supply = <&vpll2>;
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
diff --git a/arch/arm/boot/dts/omap3-evm-37xx.dts b/arch/arm/boot/dts/omap3-evm-37xx.dts
index 4df68ad..a181e30 100644
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
diff --git a/arch/arm/boot/dts/omap3-evm-common.dtsi b/arch/arm/boot/dts/omap3-evm-common.dtsi
index 3007e79..0ab9650 100644
--- a/arch/arm/boot/dts/omap3-evm-common.dtsi
+++ b/arch/arm/boot/dts/omap3-evm-common.dtsi
@@ -44,6 +44,11 @@
 
 #include "twl4030.dtsi"
 #include "twl4030_omap3.dtsi"
+#include "omap-panel-sharp-ls037v7dw01.dtsi"
+
+&backlight0 {
+	gpios = <&twl_gpio 18 GPIO_ACTIVE_HIGH>;
+};
 
 &i2c2 {
 	clock-frequency = <400000>;
@@ -61,6 +66,48 @@
 	};
 };
 
+&lcd_3v3 {
+	gpio = <&gpio5 25 GPIO_ACTIVE_LOW>;	/* gpio153 */
+	enable-active-low;
+};
+
+&lcd0 {
+	reset-gpios = <&gpio5 27 GPIO_ACTIVE_HIGH>;	/* gpio155, lcd RESB */
+	/*
+	 * The LCD is sideways, so we want the VGA mode instead of
+	 * QVGA mode. Probably also want to have omapfb.rotate=3
+	 * in the kernel cmdline until there's a binding for that.
+	 */
+	enable-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH	/* gpio154, lcd MO */
+			&gpio1 2 GPIO_ACTIVE_HIGH	/* gpio2, lcd LR */
+			&gpio1 3 GPIO_ACTIVE_HIGH	/* gpio3, lcd UD */
+			&gpio5 24 GPIO_ACTIVE_HIGH>;	/* gpio152, lcd INI */
+
+	panel-timing {
+		clock-frequency = <19200000>;
+		hback-porch = <28>;
+		hactive = <480>;
+		hfront-porch = <1>;
+		hsync-len = <2>;
+		vback-porch = <1>;
+		vactive = <640>;
+		vfront-porch = <1>;
+		vsync-len = <1>;
+		hsync-active = <0>;
+		vsync-active = <0>;
+		de-active = <1>;
+		pixelclk-active = <1>;
+	};
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
diff --git a/arch/arm/boot/dts/omap3-ldp.dts b/arch/arm/boot/dts/omap3-ldp.dts
index 0abe986..01b0808 100644
--- a/arch/arm/boot/dts/omap3-ldp.dts
+++ b/arch/arm/boot/dts/omap3-ldp.dts
@@ -164,6 +164,11 @@
 
 #include "twl4030.dtsi"
 #include "twl4030_omap3.dtsi"
+#include "omap-panel-sharp-ls037v7dw01.dtsi"
+
+&backlight0 {
+	gpios = <&twl_gpio 15 GPIO_ACTIVE_LOW>;
+};
 
 &i2c2 {
 	clock-frequency = <400000>;
@@ -173,6 +178,27 @@
 	clock-frequency = <400000>;
 };
 
+&lcd_3v3 {
+	gpio = <&twl_gpio 7 GPIO_ACTIVE_HIGH>;
+	enable-active-high;
+};
+
+&lcd0 {
+	reset-gpios = <&gpio2 23 GPIO_ACTIVE_HIGH>;	/* gpio55, lcd RESB */
+	enable-gpios = <&gpio2 24 GPIO_ACTIVE_LOW	/* gpio56, lcd MO */
+			0				/* lcd LR */
+			0				/* lcd UD */
+			0>;				/* lcd INI */
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
@@ -247,8 +273,3 @@
 	/* Needed for ads7846 */
         regulator-name = "vcc";
 };
-
-&vpll2 {
-       /* Needed for DSS */
-       regulator-name = "vdds_dsi";
-};
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
