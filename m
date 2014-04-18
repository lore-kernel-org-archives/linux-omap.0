From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAPDSS and panel-dpi
Date: Thu, 17 Apr 2014 19:50:25 -0700
Message-ID: <20140418025024.GB25732@atomide.com>
References: <CAGhQ9VzL5fLHCNZ=y-exBAds03f8Bw_hO+KjYnwO4MgRWOfpuw@mail.gmail.com>
 <20140417192215.GA24931@atomide.com>
 <CAGhQ9VwM-rnXcMXNW40jbx6yDGCQwjODDyKhtbZNyCsexX2f3w@mail.gmail.com>
 <20140417225025.GA25732@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:12731 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750970AbaDRCub (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Apr 2014 22:50:31 -0400
Content-Disposition: inline
In-Reply-To: <20140417225025.GA25732@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [140417 15:50]:
> * Joachim Eastwood <manabian@gmail.com> [140417 13:51]:
> > On 17 April 2014 21:22, Tony Lindgren <tony@atomide.com> wrote:
> > > * Joachim Eastwood <manabian@gmail.com> [140417 11:05]:
> > >> Hi Tomi,
> > >>
> > >> My VAR-DVK-OM44 (OMAP4460) has both a HDMI and a LCD panel. As HDMI is
> > >> now working (thanks) I also taken a look at panel-dpi.
> > >>
> > >> I found the DT patch for panel-dpi on the mailing list.
> > >> OMAPDSS: panel-dpi: Add DT support:
> > >> http://marc.info/?l=devicetree&m=139030201815380&w=2
> > >>
> > >> And I got my display working with DT :)
> > >> So you add can my: Tested-by: Joachim Eastwood <manabian@gmail.com>
> > >>
> > >> Could you upstream the panel-dpi DT support and the HDMI connector
> > >> gpio hpd patch in 3.16?
> > >> I hope it's easier to upstream the stuff when it gets some users in DT.
> > >
> > > Good to hear. The DPI panel support should use gpio-backlight
> > > driver as discussed in the DPI thread. Did you have to patch
> > > anything for the timings etc?
> > 
> > The only driver patches I use are those two from Tomi mentioned above.
> > (panel-dpi DT support and HDMI connector gpio-hpd)
> >
> > > If you have the board working, care to take a look at making
> > > the gpio-backlight change?
> > 
> > I am already using the gpio-backlight driver.
> 
> OK great, so then we can just drop that GPIO backlight handling
> from the DPI DT patch I presume.
>  
> > You can take a look at the device tree for VAR-DVK-OM44 here:
> > http://slexy.org/raw/s2Pz4BELGe
> > 
> > I'll post the patch set on list tomorrow.
> 
> Thanks for the link, that pretty much clarifies all the parts
> I was wondering about.

OK so based on the link above, I got the LDP panel DPI working with
the quirks now shrunk to the two panel specific GPIOs.

Probably best to set those up based on "omapdss,panel-dpi-ldp"
compatible flag?

That is after removing the backlight_gpio from panel_dpi_probe_of()
so the panel specific GPIOs can be handled easily based on the
compatible flag. Current work in progress patch below for reference
in case anybody has better ideas for dealing with the remaining
to GPIOs.

Regards,

Tony

8< ----------------------
--- a/arch/arm/boot/dts/omap3-ldp.dts
+++ b/arch/arm/boot/dts/omap3-ldp.dts
@@ -25,6 +25,10 @@
 		};
 	};
 
+	aliases {
+		display0 = &lcd0;
+	};
+
 	gpio_keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
@@ -93,6 +97,50 @@
 			gpio-key,wakeup;
 		};
 	};
+
+	lcd0: display {
+		compatible = "panel-dpi";
+		label = "lcd";
+		gpios = <&twl_gpio 7 GPIO_ACTIVE_LOW>;
+
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
+
+	backlight {
+		compatible = "gpio-backlight";
+		gpios = <&twl_gpio 15 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&dss {
+	status = "ok";
+
+	port {
+		dpi_out: endpoint {
+			remote-endpoint = <&lcd_in>;
+			data-lines = <18>;
+		};
+	};
 };
 
 &gpmc {
@@ -249,6 +297,6 @@
 };
 
 &vpll2 {
-       /* Needed for DSS */
-       regulator-name = "vdds_dsi";
+	/* Needed for DSS */
+	regulator-name = "vdds_dsi";
 };
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -148,6 +148,30 @@ static void __init omap3_evm_legacy_init(void)
 	legacy_init_wl12xx(WL12XX_REFCLOCK_38, 0, 149);
 }
 
+int __init ldp_twl_gpio_setup(struct device *dev, unsigned gpio, unsigned ngpio)
+{
+	int r;
+
+	static struct gpio gpios[] = {
+		{ 55, GPIOF_OUT_INIT_HIGH, "LCD RESET" },
+		{ 56, GPIOF_OUT_INIT_HIGH, "LCD QVGA" },
+	};
+
+	r = gpio_request_array(gpios, ARRAY_SIZE(gpios));
+	if (r) {
+		pr_err("Cannot request LCD GPIOs, error %d\n", r);
+		return r;
+	}
+	omap_ads7846_init(1, 54, 310, NULL);
+
+	return 0;
+}
+
+static void __init omap3_ldp_legacy_init(void)
+{
+	twl_gpio_auxdata.setup = ldp_twl_gpio_setup;
+}
+
 static void __init omap3_zoom_legacy_init(void)
 {
 	legacy_init_wl12xx(WL12XX_REFCLOCK_26, 0, 162);
@@ -358,6 +382,7 @@ static struct pdata_init pdata_quirks[] __initdata = {
 	{ "nokia,omap3-n950", hsmmc2_internal_input_clk, },
 	{ "isee,omap3-igep0020", omap3_igep0020_legacy_init, },
 	{ "ti,omap3-evm-37xx", omap3_evm_legacy_init, },
+	{ "ti,omap3-ldp", omap3_ldp_legacy_init, },
 	{ "ti,omap3-zoom3", omap3_zoom_legacy_init, },
 	{ "ti,am3517-evm", am3517_evm_legacy_init, },
 #endif
