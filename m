From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 11/27] OMAPDSS: Add DT support to VENC
Date: Mon, 16 Dec 2013 16:56:18 +0200
Message-ID: <1387205794-32246-12-git-send-email-tomi.valkeinen@ti.com>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33047 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754427Ab3LPO6P (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Dec 2013 09:58:15 -0500
In-Reply-To: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/venc.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 5f88ac47b7fa..12185fb6da0e 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -34,6 +34,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
 
 #include <video/omapdss.h>
 
@@ -804,6 +805,22 @@ static void __exit venc_uninit_output(struct platform_device *pdev)
 	omapdss_unregister_output(out);
 }
 
+static int venc_probe_of(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct device_node *ep;
+
+	ep = omapdss_of_get_first_endpoint(node);
+	if (!ep)
+		return 0;
+
+	venc.invert_polarity = of_property_read_bool(ep, "invert-polarity");
+
+	of_node_put(ep);
+
+	return 0;
+}
+
 /* VENC HW IP initialisation */
 static int omap_venchw_probe(struct platform_device *pdev)
 {
@@ -845,12 +862,21 @@ static int omap_venchw_probe(struct platform_device *pdev)
 
 	venc_runtime_put();
 
+	if (pdev->dev.of_node) {
+		r = venc_probe_of(pdev);
+		if (r) {
+			DSSERR("Invalid DT data\n");
+			goto err_probe_of;
+		}
+	}
+
 	dss_debugfs_create_file("venc", venc_dump_regs);
 
 	venc_init_output(pdev);
 
 	return 0;
 
+err_probe_of:
 err_runtime_get:
 	pm_runtime_disable(&pdev->dev);
 	return r;
@@ -894,6 +920,13 @@ static const struct dev_pm_ops venc_pm_ops = {
 	.runtime_resume = venc_runtime_resume,
 };
 
+
+static const struct of_device_id venc_of_match[] = {
+	{ .compatible = "ti,omap3-venc", },
+	{ .compatible = "ti,omap4-venc", },
+	{},
+};
+
 static struct platform_driver omap_venchw_driver = {
 	.probe		= omap_venchw_probe,
 	.remove         = __exit_p(omap_venchw_remove),
@@ -901,6 +934,7 @@ static struct platform_driver omap_venchw_driver = {
 		.name   = "omapdss_venc",
 		.owner  = THIS_MODULE,
 		.pm	= &venc_pm_ops,
+		.of_match_table = venc_of_match,
 	},
 };
 
-- 
1.8.3.2

