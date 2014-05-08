From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Thu, 8 May 2014 16:33:00 -0700
Message-ID: <20140508233300.GI2198@atomide.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-4-git-send-email-tony@atomide.com>
 <5369EAE7.3030705@ti.com>
 <20140507150343.GA9502@atomide.com>
 <536A5920.1020908@ti.com>
 <20140507175919.GH9502@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:60438 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932185AbaEHXdK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2014 19:33:10 -0400
Content-Disposition: inline
In-Reply-To: <20140507175919.GH9502@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [140507 11:00]:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140507 09:03]:
> > On 07/05/14 18:03, Tony Lindgren wrote:
> > > 
> > > BTW, I'm also personally fine with all five gpios showing in a single
> > > gpios property, I'm not too exited about naming anything in DT..
> > 
> > I don't have a strong opinion here. I don't have much experience with
> > DT, especially with making bindings compatible with other ones.
> > 
> > I'd just forget the simple-panel, and have single gpio array.
> 
> Well if it's a don't care flag for both of us, let's try to use
> the existing standard for simple-panel.txt and add mode-gpios
> property. I'll post a patch for that.

Here's an updated version using enable-gpios, reset-gpios and
mode-gpios. So it follows simple-panel.txt and adds mode-gpios
that's currently specific to this panel only.

Also updated for -EPROBE_DEFER handling, tested that by changing
one of the GPIOs to be a twl4030 GPIO.

Regards,

Tony

8<------------------
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 28 Apr 2014 20:22:21 -0700
Subject: [PATCH] OMAPDSS: panel-sharp-ls037v7dw01: add device tree support

We can pass the GPIO configuration for ls037v7dw01 in a standard
gpios property.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- /dev/null
+++ b/Documentation/devicetree/bindings/panel/sharp,ls037v7dw01.txt
@@ -0,0 +1,56 @@
+SHARP LS037V7DW01 TFT-LCD panel
+
+Required properties:
+- compatible: should be "sharp,ls037v7dw01"
+
+Optional properties:
+- enable-gpios: a GPIO spec for the optional enable pin
+  this pin is the INI pin as specified in the LS037V7DW01.pdf file.
+- reset-gpios: a GPIO spec for the optional reset pin
+  this pin is the RESB pin as specified in the LS037V7DW01.pdf file.
+- mode-gpios: a GPIO 
+  ordered MO, LR, and UD as specified in the LS037V7DW01.pdf file.
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
+
+This panel can have zero to five GPIOs to configure
+to change configuration between QVGA and VGA mode
+and the scan direction. As these pins can be also
+configured with external pulls, all the GPIOs are
+considered optional with holes in the array.
+
+Example when connected to a omap2+ based device:
+
+	lcd0: display {
+		compatible = "sharp,ls037v7dw01";
+		power-supply = <&lcd_3v3>;
+		enable-gpios = <&gpio5 24 GPIO_ACTIVE_HIGH>;	/* gpio152, lcd INI */
+		reset-gpios = <&gpio5 27 GPIO_ACTIVE_HIGH>;	/* gpio155, lcd RESB */
+		mode-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH	/* gpio154, lcd MO */
+			      &gpio1 2 GPIO_ACTIVE_HIGH		/* gpio2, lcd LR */
+			      &gpio1 3 GPIO_ACTIVE_HIGH>;	/* gpio3, lcd UD */
+
+		panel-timing {
+			clock-frequency = <19200000>;
+			hback-porch = <28>;
+			hactive = <480>;
+			hfront-porch = <1>;
+			hsync-len = <2>;
+			vback-porch = <1>;
+			vactive = <640>;
+			vfront-porch = <1>;
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
--- a/drivers/video/fbdev/omap2/displays-new/panel-sharp-ls037v7dw01.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-sharp-ls037v7dw01.c
@@ -12,15 +12,19 @@
 #include <linux/delay.h>
 #include <linux/gpio.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-
+#include <linux/regulator/consumer.h>
+#include <video/of_display_timing.h>
 #include <video/omapdss.h>
 #include <video/omap-panel-data.h>
 
 struct panel_drv_data {
 	struct omap_dss_device dssdev;
 	struct omap_dss_device *in;
+	struct regulator *vcc;
 
 	int data_lines;
 
@@ -95,7 +99,8 @@ static int sharp_ls_enable(struct omap_dss_device *dssdev)
 	if (omapdss_device_is_enabled(dssdev))
 		return 0;
 
-	in->ops.dpi->set_data_lines(in, ddata->data_lines);
+	if (ddata->data_lines)
+		in->ops.dpi->set_data_lines(in, ddata->data_lines);
 	in->ops.dpi->set_timings(in, &ddata->videomode);
 
 	r = in->ops.dpi->enable(in);
@@ -240,6 +245,88 @@ static int sharp_ls_probe_pdata(struct platform_device *pdev)
 	if (PTR_ERR(ddata->ini_gpio) == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 
+	ddata->videomode = sharp_ls_timings;
+
+	return 0;
+}
+
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
+	struct display_timing timing;
+	struct videomode vm;
+	int r;
+
+	ddata->vcc = devm_regulator_get(&pdev->dev, "envdd");
+	if (IS_ERR(ddata->vcc)) {
+		dev_err(&pdev->dev, "failed to get regulator\n");
+		return PTR_ERR(ddata->vcc);
+	}
+
+	r = regulator_enable(ddata->vcc);
+	if (r != 0) {
+		dev_err(&pdev->dev, "failed to enable regulator\n");
+		return r;
+	}
+
+	/* lcd INI */
+	ddata->ini_gpio = sharp_ls_get_gpio_of(&pdev->dev, 3, 0, "enable");
+	if (PTR_ERR(ddata->ini_gpio) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	/* lcd RESB */
+	ddata->resb_gpio = sharp_ls_get_gpio_of(&pdev->dev, 0, 0, "reset");
+	if (PTR_ERR(ddata->resb_gpio) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	/* lcd MO */
+	ddata->mo_gpio = sharp_ls_get_gpio_of(&pdev->dev, 0, 0, "mode");
+	if (PTR_ERR(ddata->mo_gpio) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
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
+	r = of_get_display_timing(node, "panel-timing", &timing);
+	if (r) {
+		dev_err(&pdev->dev, "failed to get video timing\n");
+		return r;
+	}
+
+	videomode_from_timing(&timing, &vm);
+	videomode_to_omap_video_timings(&vm, &ddata->videomode);
+
+	in = omapdss_of_find_source_for_first_ep(node);
+	if (IS_ERR(in)) {
+		dev_err(&pdev->dev, "failed to find video source\n");
+		return PTR_ERR(in);
+	}
+
+	ddata->in = in;
+
 	return 0;
 }
 
@@ -259,12 +346,14 @@ static int sharp_ls_probe(struct platform_device *pdev)
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
-
 	dssdev = &ddata->dssdev;
 	dssdev->dev = &pdev->dev;
 	dssdev->driver = &sharp_ls_ops;
@@ -302,12 +391,20 @@ static int __exit sharp_ls_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id sharp_ls_of_match[] = {
+	{ .compatible = "sharp,ls037v7dw01", },
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
 
