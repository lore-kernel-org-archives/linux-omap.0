From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree support
Date: Tue, 29 Apr 2014 16:52:41 -0700
Message-ID: <1398815562-24113-4-git-send-email-tony@atomide.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:38234 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754461AbaD2Xww (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Apr 2014 19:52:52 -0400
In-Reply-To: <1398815562-24113-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com

We can pass the GPIO configuration for ls037v7dw01 in a standard
gpios property.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 .../bindings/panel/sharp,ls037v7dw01.txt           | 53 ++++++++++++++
 .../omap2/displays-new/panel-sharp-ls037v7dw01.c   | 84 ++++++++++++++++++++--
 2 files changed, 133 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/panel/sharp,ls037v7dw01.txt

diff --git a/Documentation/devicetree/bindings/panel/sharp,ls037v7dw01.txt b/Documentation/devicetree/bindings/panel/sharp,ls037v7dw01.txt
new file mode 100644
index 0000000..7f6f5e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/panel/sharp,ls037v7dw01.txt
@@ -0,0 +1,53 @@
+SHARP LS037V7DW01 TFT-LCD panel
+
+Required properties:
+- compatible: should be "sharp,ls037v7dw01"
+
+Optional properties:
+- reset-gpios: a GPIO spec for the optional reset pin
+- enable-gpios: a GPIO array for the optional configuration GPIOs
+  ordered MO, LR, UD, INI as specified in the LS037V7DW01.pdf file.
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
+		reset-gpios = <&gpio5 27 GPIO_ACTIVE_HIGH>;	/* gpio155, lcd RESB */
+		enable-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH	/* gpio154, lcd MO */
+				&gpio1 2 GPIO_ACTIVE_HIGH	/* gpio2, lcd LR */
+				&gpio1 3 GPIO_ACTIVE_HIGH	/* gpio3, lcd UD */
+				&gpio5 24 GPIO_ACTIVE_HIGH>;	/* gpio152, lcd INI */
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
diff --git a/drivers/video/fbdev/omap2/displays-new/panel-sharp-ls037v7dw01.c b/drivers/video/fbdev/omap2/displays-new/panel-sharp-ls037v7dw01.c
index de8473a..3a04fb0 100644
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
@@ -230,6 +235,67 @@ static int sharp_ls_probe_pdata(struct platform_device *pdev)
 	ddata->ini_gpio = sharp_ls_get_gpio(&pdev->dev, pdata->ini_gpio,
 					    GPIOF_OUT_INIT_LOW, "lcd INI");
 
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
+	if (!IS_ERR(gpio))
+		gpiod_direction_output(gpio, val);
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
+	ddata->resb_gpio = sharp_ls_get_gpio_of(&pdev->dev, 0, 0, "reset");	/* lcd RESB */
+	ddata->mo_gpio = sharp_ls_get_gpio_of(&pdev->dev, 0, 0, "enable");	/* lcd MO */
+	ddata->lr_gpio = sharp_ls_get_gpio_of(&pdev->dev, 1, 1, "enable");	/* lcd LR */
+	ddata->ud_gpio = sharp_ls_get_gpio_of(&pdev->dev, 2, 1, "enable");	/* lcd UD */
+	ddata->ini_gpio = sharp_ls_get_gpio_of(&pdev->dev, 3, 0, "enable");	/* lcd INI */
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
 
@@ -249,12 +315,14 @@ static int sharp_ls_probe(struct platform_device *pdev)
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
@@ -292,12 +360,20 @@ static int __exit sharp_ls_remove(struct platform_device *pdev)
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
 
-- 
1.8.1.1

