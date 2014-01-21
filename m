From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv3 12/41] OMAPDSS: Add DT support to VENC
Date: Tue, 21 Jan 2014 12:56:44 +0200
Message-ID: <1390301833-24944-13-git-send-email-tomi.valkeinen@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39062 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754438AbaAUK7m (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Jan 2014 05:59:42 -0500
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add DT support to VENC.

In contrast to non-DT version, the DT version gets the invert-polarity
and connector type via venc's endpoint, not from the connector.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/venc.c | 61 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index c0e4def29795..b962a01961f5 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -34,6 +34,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
 
 #include <video/omapdss.h>
 
@@ -808,6 +809,48 @@ static void __exit venc_uninit_output(struct platform_device *pdev)
 	omapdss_unregister_output(out);
 }
 
+static int venc_probe_of(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct device_node *ep;
+	u32 channels;
+	int r;
+
+	ep = omapdss_of_get_first_endpoint(node);
+	if (!ep)
+		return 0;
+
+	venc.invert_polarity = of_property_read_bool(ep, "ti,invert-polarity");
+
+	r = of_property_read_u32(ep, "ti,channels", &channels);
+	if (r) {
+		dev_err(&pdev->dev,
+			"failed to read property 'ti,channels': %d\n", r);
+		goto err;
+	}
+
+	switch (channels) {
+	case 1:
+		venc.type = OMAP_DSS_VENC_TYPE_COMPOSITE;
+		break;
+	case 2:
+		venc.type = OMAP_DSS_VENC_TYPE_SVIDEO;
+		break;
+	default:
+		dev_err(&pdev->dev, "bad channel propert '%d'\n", channels);
+		r = -EINVAL;
+		goto err;
+	}
+
+	of_node_put(ep);
+
+	return 0;
+err:
+	of_node_put(ep);
+
+	return 0;
+}
+
 /* VENC HW IP initialisation */
 static int omap_venchw_probe(struct platform_device *pdev)
 {
@@ -849,12 +892,21 @@ static int omap_venchw_probe(struct platform_device *pdev)
 
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
@@ -898,6 +950,14 @@ static const struct dev_pm_ops venc_pm_ops = {
 	.runtime_resume = venc_runtime_resume,
 };
 
+
+static const struct of_device_id venc_of_match[] = {
+	{ .compatible = "ti,omap2-venc", },
+	{ .compatible = "ti,omap3-venc", },
+	{ .compatible = "ti,omap4-venc", },
+	{},
+};
+
 static struct platform_driver omap_venchw_driver = {
 	.probe		= omap_venchw_probe,
 	.remove         = __exit_p(omap_venchw_remove),
@@ -905,6 +965,7 @@ static struct platform_driver omap_venchw_driver = {
 		.name   = "omapdss_venc",
 		.owner  = THIS_MODULE,
 		.pm	= &venc_pm_ops,
+		.of_match_table = venc_of_match,
 	},
 };
 
-- 
1.8.3.2

