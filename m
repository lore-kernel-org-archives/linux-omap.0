From: Rolf Peukert <rolf.peukert-cSCHQGRfioA@public.gmane.org>
Subject: [PATCH 3/5] Add device tree support for M-USB on AM35xx SOCs
Date: Fri, 23 Oct 2015 17:51:47 +0200
Message-ID: <562A5793.3020200@imms.de>
References: <562A557B.4090501@imms.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <562A557B.4090501-cSCHQGRfioA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add a function that sets up necessary data structures. In older kernels
this was done in a board_ file. To support initialization via a DT, this
now needs to be included in the probe() function.
Also declare a new device 'compatible' name (am35x-musb) to
differentiate it from omap3-musb.

Signed-off-by: Rolf Peukert <rolf.peukert-cSCHQGRfioA@public.gmane.org>
---
 drivers/usb/musb/am35x.c | 73
++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index c41fe58..3c1477a 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -462,6 +462,59 @@ static const struct platform_device_info
am35x_dev_info = {
 	.dma_mask	= DMA_BIT_MASK(32),
 };

+static struct musb_hdrc_platform_data *am35x_get_config(
+	struct platform_device *pdev)
+{
+	struct musb_hdrc_platform_data *pdata;
+	struct omap_musb_board_data *bdata;
+	struct musb_hdrc_config *config;
+	struct device_node *np;
+	int val, ret;
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		goto err_out;
+
+	bdata = devm_kzalloc(&pdev->dev, sizeof(*bdata), GFP_KERNEL);
+	if (!bdata)
+		goto err_pdata;
+
+	config = devm_kzalloc(&pdev->dev, sizeof(*config), GFP_KERNEL);
+	if (!config)
+		goto err_bdata;
+
+	bdata->clear_irq = am35x_musb_clear_irq;
+	bdata->reset = am35x_musb_reset;
+	bdata->set_mode = am35x_set_mode;
+	bdata->set_phy_power = am35x_musb_phy_power;
+
+	pdata->board_data = bdata;
+	pdata->config = config;
+
+	/* Read settings from device tree */
+	np = pdev->dev.of_node;
+	if (np) {
+		of_property_read_u32(np, "mode", (u32 *)&pdata->mode);
+		of_property_read_u32(np, "interface-type",
+				(u32 *)&bdata->interface_type);
+		of_property_read_u32(np, "num-eps", (u32 *)&config->num_eps);
+		of_property_read_u32(np, "ram-bits", (u32 *)&config->ram_bits);
+		of_property_read_u32(np, "power", (u32 *)&pdata->power);
+
+		ret = of_property_read_u32(np, "multipoint", &val);
+		if (!ret && val)
+			config->multipoint = true;
+	}
+	return pdata;
+
+err_bdata:
+	devm_kfree(&pdev->dev, bdata);
+err_pdata:
+	devm_kfree(&pdev->dev, pdata);
+err_out:
+	return NULL;
+}
+
 static int am35x_probe(struct platform_device *pdev)
 {
 	struct musb_hdrc_platform_data	*pdata = dev_get_platdata(&pdev->dev);
@@ -479,6 +532,12 @@ static int am35x_probe(struct platform_device *pdev)
 		goto err0;
 	}

+	if (!pdata) {
+		pdata = am35x_get_config(pdev);
+		if (!pdata)
+			goto err1;
+	}
+
 	phy_clk = clk_get(&pdev->dev, "fck");
 	if (IS_ERR(phy_clk)) {
 		dev_err(&pdev->dev, "failed to get PHY clock\n");
@@ -548,6 +607,7 @@ err4:
 	clk_put(phy_clk);

 err3:
+err1:
 	kfree(glue);

 err0:
@@ -615,12 +675,25 @@ static int am35x_resume(struct device *dev)

 static SIMPLE_DEV_PM_OPS(am35x_pm_ops, am35x_suspend, am35x_resume);

+#ifdef CONFIG_OF
+static const struct of_device_id am35x_id_table[] = {
+	{
+		.compatible = "ti,am35x-musb"
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, am35x_id_table);
+#endif
+
 static struct platform_driver am35x_driver = {
 	.probe		= am35x_probe,
 	.remove		= am35x_remove,
 	.driver		= {
 		.name	= "musb-am35x",
 		.pm	= &am35x_pm_ops,
+#ifdef CONFIG_OF
+		.of_match_table = of_match_ptr(am35x_id_table),
+#endif
 	},
 };

-- 
2.4.10

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
