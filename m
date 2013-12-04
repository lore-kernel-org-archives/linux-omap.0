From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 11/26] OMAPDSS: Add DT support to DSS, DISPC, DPI, HDMI, VENC
Date: Wed, 4 Dec 2013 14:28:38 +0200
Message-ID: <1386160133-24026-12-git-send-email-tomi.valkeinen@ti.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52210 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932108Ab3LDMaO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Dec 2013 07:30:14 -0500
In-Reply-To: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add the code to make DSS, DISPC, DPI, HDMI and VENC drivers work with
device tree on OMAP3 and OMAP4.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |  7 ++++++
 drivers/video/omap2/dss/dpi.c   | 50 +++++++++++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss.c   | 10 +++++++++
 drivers/video/omap2/dss/hdmi4.c |  6 +++++
 drivers/video/omap2/dss/venc.c  | 34 ++++++++++++++++++++++++++++
 5 files changed, 107 insertions(+)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 4ec59ca72e5d..b702369fc895 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3744,12 +3744,19 @@ static const struct dev_pm_ops dispc_pm_ops = {
 	.runtime_resume = dispc_runtime_resume,
 };
 
+static const struct of_device_id dispc_of_match[] = {
+	{ .compatible = "ti,omap3-dispc", },
+	{ .compatible = "ti,omap4-dispc", },
+	{},
+};
+
 static struct platform_driver omap_dispchw_driver = {
 	.remove         = __exit_p(omap_dispchw_remove),
 	.driver         = {
 		.name   = "omapdss_dispc",
 		.owner  = THIS_MODULE,
 		.pm	= &dispc_pm_ops,
+		.of_match_table = dispc_of_match,
 	},
 };
 
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index bd48cde53561..247b1d524360 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -30,6 +30,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/string.h>
+#include <linux/of.h>
 
 #include <video/omapdss.h>
 
@@ -690,15 +691,57 @@ static void __exit dpi_uninit_output(struct platform_device *pdev)
 	omapdss_unregister_output(out);
 }
 
+static int dpi_probe_of(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct device_node *ep;
+	u32 datalines;
+	int r;
+
+	ep = omapdss_of_get_first_endpoint(node);
+	if (!ep)
+		return 0;
+
+	r = of_property_read_u32(ep, "data-lines", &datalines);
+	if (r) {
+		DSSERR("failed to parse datalines\n");
+		goto err;
+	}
+
+	dpi.data_lines = datalines;
+
+	of_node_put(ep);
+
+	return 0;
+err:
+	of_node_put(ep);
+
+	return r;
+}
+
 static int omap_dpi_probe(struct platform_device *pdev)
 {
+	int r;
+
 	dpi.pdev = pdev;
 
 	mutex_init(&dpi.lock);
 
 	dpi_init_output(pdev);
 
+	if (pdev->dev.of_node) {
+		r = dpi_probe_of(pdev);
+		if (r) {
+			DSSERR("Invalid DT data\n");
+			goto err_probe_of;
+		}
+	}
+
 	return 0;
+
+err_probe_of:
+	dpi_uninit_output(pdev);
+	return r;
 }
 
 static int __exit omap_dpi_remove(struct platform_device *pdev)
@@ -708,12 +751,19 @@ static int __exit omap_dpi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id dpi_of_match[] = {
+	{ .compatible = "ti,omap3-dpi", },
+	{ .compatible = "ti,omap4-dpi", },
+	{},
+};
+
 static struct platform_driver omap_dpi_driver = {
 	.probe		= omap_dpi_probe,
 	.remove         = __exit_p(omap_dpi_remove),
 	.driver         = {
 		.name   = "omapdss_dpi",
 		.owner  = THIS_MODULE,
+		.of_match_table = dpi_of_match,
 	},
 };
 
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index bd01608e67e2..d0d61b11c01e 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -23,6 +23,7 @@
 #define DSS_SUBSYS_NAME "DSS"
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/io.h>
 #include <linux/export.h>
 #include <linux/err.h>
@@ -955,12 +956,21 @@ static const struct dev_pm_ops dss_pm_ops = {
 	.runtime_resume = dss_runtime_resume,
 };
 
+static const struct of_device_id dss_of_match[] = {
+	{ .compatible = "ti,omap3-dss", },
+	{ .compatible = "ti,omap4-dss", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, dss_of_match);
+
 static struct platform_driver omap_dsshw_driver = {
 	.remove         = __exit_p(omap_dsshw_remove),
 	.driver         = {
 		.name   = "omapdss_dss",
 		.owner  = THIS_MODULE,
 		.pm	= &dss_pm_ops,
+		.of_match_table = dss_of_match,
 	},
 };
 
diff --git a/drivers/video/omap2/dss/hdmi4.c b/drivers/video/omap2/dss/hdmi4.c
index 16e598787522..97dd05f602f7 100644
--- a/drivers/video/omap2/dss/hdmi4.c
+++ b/drivers/video/omap2/dss/hdmi4.c
@@ -671,6 +671,11 @@ static const struct dev_pm_ops hdmi_pm_ops = {
 	.runtime_resume = hdmi_runtime_resume,
 };
 
+static const struct of_device_id hdmi_of_match[] = {
+	{ .compatible = "ti,omap4-hdmi", },
+	{},
+};
+
 static struct platform_driver omapdss_hdmihw_driver = {
 	.probe		= omapdss_hdmihw_probe,
 	.remove         = __exit_p(omapdss_hdmihw_remove),
@@ -678,6 +683,7 @@ static struct platform_driver omapdss_hdmihw_driver = {
 		.name   = "omapdss_hdmi",
 		.owner  = THIS_MODULE,
 		.pm	= &hdmi_pm_ops,
+		.of_match_table = hdmi_of_match,
 	},
 };
 
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

