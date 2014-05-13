From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Tue, 13 May 2014 14:26:39 -0700
Message-ID: <20140513212639.GA18001@atomide.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-4-git-send-email-tony@atomide.com>
 <5369EAE7.3030705@ti.com>
 <20140507150343.GA9502@atomide.com>
 <536A5920.1020908@ti.com>
 <20140507175919.GH9502@atomide.com>
 <20140508233300.GI2198@atomide.com>
 <536C924E.5000307@ti.com>
 <20140509153008.GC17814@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:54961 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753289AbaEMV0s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2014 17:26:48 -0400
Content-Disposition: inline
In-Reply-To: <20140509153008.GC17814@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [140509 08:31]:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140509 01:31]:
> > On 09/05/14 02:33, Tony Lindgren wrote:
> > > * Tony Lindgren <tony@atomide.com> [140507 11:00]:
> > >> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140507 09:03]:
> > >>> On 07/05/14 18:03, Tony Lindgren wrote:
> > >>>>
> > >>>> BTW, I'm also personally fine with all five gpios showing in a single
> > >>>> gpios property, I'm not too exited about naming anything in DT..
> > >>>
> > >>> I don't have a strong opinion here. I don't have much experience with
> > >>> DT, especially with making bindings compatible with other ones.
> > >>>
> > >>> I'd just forget the simple-panel, and have single gpio array.
> > >>
> > >> Well if it's a don't care flag for both of us, let's try to use
> > >> the existing standard for simple-panel.txt and add mode-gpios
> > >> property. I'll post a patch for that.
> > > 
> > > Here's an updated version using enable-gpios, reset-gpios and
> > > mode-gpios. So it follows simple-panel.txt and adds mode-gpios
> > > that's currently specific to this panel only.
> > > 
> > > Also updated for -EPROBE_DEFER handling, tested that by changing
> > > one of the GPIOs to be a twl4030 GPIO.
> > 
> > To speed things up a bit, I made the changes I suggested. Compile tested
> > only.
> 
> OK thanks did not get the penguin with it so need to look at it a bit
> more.

Here's this patch updated again for QVGA and VGA support and to use
your panel remapping. I've also made sure the blanking works properly
on evm-37xx and ldp.

Regards,

Tony

8< --------------------
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 28 Apr 2014 20:22:21 -0700
Subject: [PATCH] OMAPDSS: panel-sharp-ls037v7dw01: add device tree support

Add device tree support for sharp-ls037v7dw01 panel.

Note that this patch is using the remapping of the compatible
flag as implemented by Tomi (that I do not like), but seems
like that's currently needed to avoid redoing the panel
bindings later on. And for the record, that has been agreed
to be a temporary measure until the generic display bindings
can be used by DSS.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

--- /dev/null
+++ b/Documentation/devicetree/bindings/video/sharp,ls037v7dw01.txt
@@ -0,0 +1,44 @@
+SHARP LS037V7DW01 TFT-LCD panel
+===================================
+
+Required properties:
+- compatible: "sharp,ls037v7dw01"
+
+Optional properties:
+- label: a symbolic name for the panel
+- enable-gpios: a GPIO spec for the optional enable pin
+  this pin is the INI pin as specified in the LS037V7DW01.pdf file.
+- reset-gpios: a GPIO spec for the optional reset pin
+  this pin is the RESB pin as specified in the LS037V7DW01.pdf file.
+- mode-gpios: a GPIO
+  ordered MO, LR, and UD as specified in the LS037V7DW01.pdf file.
+
+Required nodes:
+- Video port for DPI input
+
+This panel can have zero to five GPIOs to configure
+to change configuration between QVGA and VGA mode
+and the scan direction. As these pins can be also
+configured with external pulls, all the GPIOs are
+considered optional with holes in the array.
+
+Example
+-------
+
+Example when connected to a omap2+ based device:
+
+lcd0: display {
+	compatible = "sharp,ls037v7dw01";
+	power-supply = <&lcd_3v3>;
+	enable-gpios = <&gpio5 24 GPIO_ACTIVE_HIGH>;	/* gpio152, lcd INI */
+	reset-gpios = <&gpio5 27 GPIO_ACTIVE_HIGH>;	/* gpio155, lcd RESB */
+	mode-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH	/* gpio154, lcd MO */
+		      &gpio1 2 GPIO_ACTIVE_HIGH		/* gpio2, lcd LR */
+		      &gpio1 3 GPIO_ACTIVE_HIGH>;	/* gpio3, lcd UD */
+
+	port {
+		lcd_in: endpoint {
+			remote-endpoint = <&dpi_out>;
+		};
+	};
+};
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -562,6 +562,7 @@ static const char * const dss_compat_conv_list[] __initconst = {
 	"hdmi-connector",
 	"panel-dpi",
 	"panel-dsi-cm",
+	"sharp,ls037v7dw01",
 	"sony,acx565akm",
 	"svideo-connector",
 	"ti,tfp410",
--- a/drivers/video/fbdev/omap2/displays-new/panel-sharp-ls037v7dw01.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-sharp-ls037v7dw01.c
@@ -12,15 +12,18 @@
 #include <linux/delay.h>
 #include <linux/gpio.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-
+#include <linux/regulator/consumer.h>
 #include <video/omapdss.h>
 #include <video/omap-panel-data.h>
 
 struct panel_drv_data {
 	struct omap_dss_device dssdev;
 	struct omap_dss_device *in;
+	struct regulator *vcc;
 
 	int data_lines;
 
@@ -31,9 +34,33 @@ struct panel_drv_data {
 	struct gpio_desc *mo_gpio;	/* low = 480x640, high = 240x320 */
 	struct gpio_desc *lr_gpio;	/* high = conventional horizontal scanning */
 	struct gpio_desc *ud_gpio;	/* high = conventional vertical scanning */
+
+#define SHARP_LS_QVGA	(1 << 0)
+	u32 flags;
+};
+
+static const struct omap_video_timings sharp_ls_qvga_timings = {
+	.x_res = 240,
+	.y_res = 320,
+
+	.pixelclock	= 5400000,
+
+	.hsw		= 3,
+	.hfp		= 3,
+	.hbp		= 39,
+
+	.vsw		= 1,
+	.vfp		= 2,
+	.vbp		= 7,
+
+	.vsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
+	.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
+	.data_pclk_edge	= OMAPDSS_DRIVE_SIG_RISING_EDGE,
+	.de_level	= OMAPDSS_SIG_ACTIVE_HIGH,
+	.sync_pclk_edge	= OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES,
 };
 
-static const struct omap_video_timings sharp_ls_timings = {
+static const struct omap_video_timings sharp_ls_vga_timings = {
 	.x_res = 480,
 	.y_res = 640,
 
@@ -95,12 +122,21 @@ static int sharp_ls_enable(struct omap_dss_device *dssdev)
 	if (omapdss_device_is_enabled(dssdev))
 		return 0;
 
-	in->ops.dpi->set_data_lines(in, ddata->data_lines);
+	if (ddata->data_lines)
+		in->ops.dpi->set_data_lines(in, ddata->data_lines);
 	in->ops.dpi->set_timings(in, &ddata->videomode);
 
+	if (ddata->vcc) {
+		r = regulator_enable(ddata->vcc);
+		if (r != 0)
+			return r;
+	}
+
 	r = in->ops.dpi->enable(in);
-	if (r)
+	if (r) {
+		regulator_disable(ddata->vcc);
 		return r;
+	}
 
 	/* wait couple of vsyncs until enabling the LCD */
 	msleep(50);
@@ -136,6 +172,9 @@ static void sharp_ls_disable(struct omap_dss_device *dssdev)
 
 	in->ops.dpi->disable(in);
 
+	if (ddata->vcc)
+		regulator_disable(ddata->vcc);
+
 	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 }
 
@@ -243,6 +282,72 @@ static int sharp_ls_probe_pdata(struct platform_device *pdev)
 	return 0;
 }
 
+static struct gpio_desc *
+sharp_ls_get_gpio_of(struct device *dev, int index, int val, char *desc)
+{
+	struct gpio_desc *gpio;
+
+	gpio = devm_gpiod_get_index(dev, desc, index);
+	if (IS_ERR(gpio))
+		return gpio;
+
+	gpiod_direction_output(gpio, val);
+
+	return gpio;
+}
+
+static int sharp_ls_probe_of(struct platform_device *pdev)
+{
+	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct device_node *node = pdev->dev.of_node;
+	struct omap_dss_device *in;
+
+	ddata->vcc = devm_regulator_get(&pdev->dev, "envdd");
+	if (IS_ERR(ddata->vcc)) {
+		dev_err(&pdev->dev, "failed to get regulator\n");
+		return PTR_ERR(ddata->vcc);
+	}
+
+	/* lcd INI */
+	ddata->ini_gpio = sharp_ls_get_gpio_of(&pdev->dev, 0, 0, "enable");
+	if (PTR_ERR(ddata->ini_gpio) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	/* lcd RESB */
+	ddata->resb_gpio = sharp_ls_get_gpio_of(&pdev->dev, 0, 1, "reset");
+	if (PTR_ERR(ddata->resb_gpio) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	/* lcd MO */
+	ddata->mo_gpio = sharp_ls_get_gpio_of(&pdev->dev, 0, 1, "mode");
+	if (PTR_ERR(ddata->mo_gpio) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	if (!IS_ERR(ddata->mo_gpio))
+		if (gpiod_get_raw_value_cansleep(ddata->mo_gpio))
+			ddata->flags |= SHARP_LS_QVGA;
+
+	/* lcd LR */
+	ddata->lr_gpio = sharp_ls_get_gpio_of(&pdev->dev, 1, 1, "mode");
+	if (PTR_ERR(ddata->lr_gpio) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	/* lcd UD */
+	ddata->ud_gpio = sharp_ls_get_gpio_of(&pdev->dev, 2, 1, "mode");
+	if (PTR_ERR(ddata->ud_gpio) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	in = omapdss_of_find_source_for_first_ep(node);
+	if (IS_ERR(in)) {
+		dev_err(&pdev->dev, "failed to find video source\n");
+		return PTR_ERR(in);
+	}
+
+	ddata->in = in;
+
+	return 0;
+}
+
 static int sharp_ls_probe(struct platform_device *pdev)
 {
 	struct panel_drv_data *ddata;
@@ -259,11 +364,18 @@ static int sharp_ls_probe(struct platform_device *pdev)
 		r = sharp_ls_probe_pdata(pdev);
 		if (r)
 			return r;
+	} else if (pdev->dev.of_node) {
+		r = sharp_ls_probe_of(pdev);
+		if (r)
+			return r;
 	} else {
 		return -ENODEV;
 	}
 
-	ddata->videomode = sharp_ls_timings;
+	if (ddata->flags & SHARP_LS_QVGA)
+		ddata->videomode = sharp_ls_qvga_timings;
+	else
+		ddata->videomode = sharp_ls_vga_timings;
 
 	dssdev = &ddata->dssdev;
 	dssdev->dev = &pdev->dev;
@@ -302,12 +414,20 @@ static int __exit sharp_ls_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id sharp_ls_of_match[] = {
+	{ .compatible = "omapdss,sharp,ls037v7dw01", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, sharp_ls_of_match);
+
 static struct platform_driver sharp_ls_driver = {
 	.probe = sharp_ls_probe,
 	.remove = __exit_p(sharp_ls_remove),
 	.driver = {
 		.name = "panel-sharp-ls037v7dw01",
 		.owner = THIS_MODULE,
+		.of_match_table = sharp_ls_of_match,
 	},
 };
 
