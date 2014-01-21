From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv3 13/41] OMAPDSS: Add DT support to DSI
Date: Tue, 21 Jan 2014 12:56:45 +0200
Message-ID: <1390301833-24944-14-git-send-email-tomi.valkeinen@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33417 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754466AbaAUK74 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Jan 2014 05:59:56 -0500
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add the code to make the DSI driver work with device tree on OMAP3 and
OMAP4.

A minor hack is needed at the moment in the DSI driver: the DSS driver
needs to know the ID number of a DSI device, as clocks are routed in
different ways to the DSI devices. At the moment we don't have any
proper way to manage this, so this patchs adds a simple lookup table
that is used to deduce the ID from the DSI device's base address.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c | 139 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 138 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index b7c92705fb54..98bb2d68a462 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -38,6 +38,8 @@
 #include <linux/slab.h>
 #include <linux/debugfs.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 
 #include <video/omapdss.h>
 #include <video/mipi_display.h>
@@ -386,6 +388,13 @@ struct dsi_packet_sent_handler_data {
 	struct completion *completion;
 };
 
+struct dsi_module_id_data {
+	u32 address;
+	int id;
+};
+
+static const struct of_device_id dsi_of_match[];
+
 #ifdef DSI_PERF_MEASURE
 static bool dsi_perf;
 module_param(dsi_perf, bool, 0644);
@@ -5373,12 +5382,69 @@ static void dsi_uninit_output(struct platform_device *dsidev)
 	omapdss_unregister_output(out);
 }
 
+static int dsi_probe_of(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct dsi_data *dsi = dsi_get_dsidrv_data(pdev);
+	struct property *prop;
+	u32 lane_arr[10];
+	int len, num_pins;
+	int r, i;
+	struct device_node *ep;
+	struct omap_dsi_pin_config pin_cfg;
+
+	ep = omapdss_of_get_first_endpoint(node);
+	if (!ep)
+		return 0;
+
+	prop = of_find_property(ep, "lanes", &len);
+	if (prop == NULL) {
+		dev_err(&pdev->dev, "failed to find lane data\n");
+		r = -EINVAL;
+		goto err;
+	}
+
+	num_pins = len / sizeof(u32);
+
+	if (num_pins < 4 || num_pins % 2 != 0
+			|| num_pins > dsi->num_lanes_supported * 2) {
+		dev_err(&pdev->dev, "bad number of lanes\n");
+		r = -EINVAL;
+		goto err;
+	}
+
+	r = of_property_read_u32_array(ep, "lanes", lane_arr, num_pins);
+	if (r) {
+		dev_err(&pdev->dev, "failed to read lane data\n");
+		goto err;
+	}
+
+	pin_cfg.num_pins = num_pins;
+	for (i = 0; i < num_pins; ++i)
+		pin_cfg.pins[i] = (int)lane_arr[i];
+
+	r = dsi_configure_pins(&dsi->output, &pin_cfg);
+	if (r) {
+		dev_err(&pdev->dev, "failed to configure pins");
+		goto err;
+	}
+
+	of_node_put(ep);
+
+	return 0;
+
+err:
+	of_node_put(ep);
+	return r;
+}
+
 /* DSI1 HW IP initialisation */
 static int omap_dsihw_probe(struct platform_device *dsidev)
 {
 	u32 rev;
 	int r, i;
 	struct dsi_data *dsi;
+	struct resource *dsi_mem;
 	struct resource *res;
 	struct resource temp_res;
 
@@ -5386,7 +5452,6 @@ static int omap_dsihw_probe(struct platform_device *dsidev)
 	if (!dsi)
 		return -ENOMEM;
 
-	dsi->module_id = dsidev->id;
 	dsi->pdev = dsidev;
 	dev_set_drvdata(&dsidev->dev, dsi);
 
@@ -5424,6 +5489,8 @@ static int omap_dsihw_probe(struct platform_device *dsidev)
 		res = &temp_res;
 	}
 
+	dsi_mem = res;
+
 	dsi->proto_base = devm_ioremap(&dsidev->dev, res->start,
 		resource_size(res));
 	if (!dsi->proto_base) {
@@ -5484,6 +5551,31 @@ static int omap_dsihw_probe(struct platform_device *dsidev)
 		return r;
 	}
 
+	if (dsidev->dev.of_node) {
+		const struct of_device_id *match;
+		const struct dsi_module_id_data *d;
+
+		match = of_match_node(dsi_of_match, dsidev->dev.of_node);
+		if (!match) {
+			DSSERR("unsupported DSI module\n");
+			return -ENODEV;
+		}
+
+		d = match->data;
+
+		while (d->address != 0 && d->address != dsi_mem->start)
+			d++;
+
+		if (d->address == 0) {
+			DSSERR("unsupported DSI module\n");
+			return -ENODEV;
+		}
+
+		dsi->module_id = d->id;
+	} else {
+		dsi->module_id = dsidev->id;
+	}
+
 	/* DSI VCs initialization */
 	for (i = 0; i < ARRAY_SIZE(dsi->vc); i++) {
 		dsi->vc[i].source = DSI_VC_SOURCE_L4;
@@ -5519,6 +5611,19 @@ static int omap_dsihw_probe(struct platform_device *dsidev)
 
 	dsi_init_output(dsidev);
 
+	if (dsidev->dev.of_node) {
+		r = dsi_probe_of(dsidev);
+		if (r) {
+			DSSERR("Invalid DSI DT data\n");
+			goto err_probe_of;
+		}
+
+		r = of_platform_populate(dsidev->dev.of_node, NULL, NULL,
+			&dsidev->dev);
+		if (r)
+			DSSERR("Failed to populate DSI child devices: %d\n", r);
+	}
+
 	dsi_runtime_put(dsidev);
 
 	if (dsi->module_id == 0)
@@ -5532,17 +5637,31 @@ static int omap_dsihw_probe(struct platform_device *dsidev)
 	else if (dsi->module_id == 1)
 		dss_debugfs_create_file("dsi2_irqs", dsi2_dump_irqs);
 #endif
+
 	return 0;
 
+err_probe_of:
+	dsi_uninit_output(dsidev);
+	dsi_runtime_put(dsidev);
+
 err_runtime_get:
 	pm_runtime_disable(&dsidev->dev);
 	return r;
 }
 
+static int dsi_unregister_child(struct device *dev, void *data)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	platform_device_unregister(pdev);
+	return 0;
+}
+
 static int __exit omap_dsihw_remove(struct platform_device *dsidev)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
+	device_for_each_child(&dsidev->dev, NULL, dsi_unregister_child);
+
 	WARN_ON(dsi->scp_clk_refcount > 0);
 
 	dsi_uninit_output(dsidev);
@@ -5580,6 +5699,23 @@ static const struct dev_pm_ops dsi_pm_ops = {
 	.runtime_resume = dsi_runtime_resume,
 };
 
+static const struct dsi_module_id_data dsi_of_data_omap3[] = {
+	{ .address = 0x4804fc00, .id = 0, },
+	{ },
+};
+
+static const struct dsi_module_id_data dsi_of_data_omap4[] = {
+	{ .address = 0x58004000, .id = 0, },
+	{ .address = 0x58005000, .id = 1, },
+	{ },
+};
+
+static const struct of_device_id dsi_of_match[] = {
+	{ .compatible = "ti,omap3-dsi", .data = dsi_of_data_omap3, },
+	{ .compatible = "ti,omap4-dsi", .data = dsi_of_data_omap4, },
+	{},
+};
+
 static struct platform_driver omap_dsihw_driver = {
 	.probe		= omap_dsihw_probe,
 	.remove         = __exit_p(omap_dsihw_remove),
@@ -5587,6 +5723,7 @@ static struct platform_driver omap_dsihw_driver = {
 		.name   = "omapdss_dsi",
 		.owner  = THIS_MODULE,
 		.pm	= &dsi_pm_ops,
+		.of_match_table = dsi_of_match,
 	},
 };
 
-- 
1.8.3.2

