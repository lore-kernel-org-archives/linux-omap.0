From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 09/27] OMAPDSS: Add DT support to DSS, DISPC, DPI and SDI.
Date: Mon, 16 Dec 2013 16:56:16 +0200
Message-ID: <1387205794-32246-10-git-send-email-tomi.valkeinen@ti.com>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42581 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754395Ab3LPO6M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Dec 2013 09:58:12 -0500
In-Reply-To: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |  7 +++++
 drivers/video/omap2/dss/dpi.c   | 47 ++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss.c   | 63 +++++++++++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss.h   |  6 ++++
 drivers/video/omap2/dss/sdi.c   | 45 +++++++++++++++++++++++++++++
 5 files changed, 168 insertions(+)

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
index bd48cde53561..cc452796b734 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -30,6 +30,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/string.h>
+#include <linux/of.h>
 
 #include <video/omapdss.h>
 
@@ -49,6 +50,8 @@ static struct {
 	int data_lines;
 
 	struct omap_dss_device output;
+
+	bool port_initialized;
 } dpi;
 
 static struct platform_device *dpi_get_dsidev(enum omap_channel channel)
@@ -726,3 +729,47 @@ void __exit dpi_uninit_platform_driver(void)
 {
 	platform_driver_unregister(&omap_dpi_driver);
 }
+
+int __init dpi_init_port(struct platform_device *pdev, struct device_node *port)
+{
+	struct device_node *ep;
+	u32 datalines;
+	int r;
+
+	ep = omapdss_of_get_next_endpoint(port, NULL);
+	if (!ep)
+		return 0;
+
+	r = of_property_read_u32(ep, "data-lines", &datalines);
+	if (r) {
+		DSSERR("failed to parse datalines\n");
+		goto err_datalines;
+	}
+
+	dpi.data_lines = datalines;
+
+	of_node_put(ep);
+
+	dpi.pdev = pdev;
+
+	mutex_init(&dpi.lock);
+
+	dpi_init_output(pdev);
+
+	dpi.port_initialized = true;
+
+	return 0;
+
+err_datalines:
+	of_node_put(ep);
+
+	return r;
+}
+
+void __exit dpi_uninit_port(void)
+{
+	if (!dpi.port_initialized)
+		return;
+
+	dpi_uninit_output(dpi.pdev);
+}
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index bd01608e67e2..1082fadd004f 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -23,6 +23,7 @@
 #define DSS_SUBSYS_NAME "DSS"
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/io.h>
 #include <linux/export.h>
 #include <linux/err.h>
@@ -33,6 +34,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/gfp.h>
 #include <linux/sizes.h>
+#include <linux/of.h>
 
 #include <video/omapdss.h>
 
@@ -841,6 +843,54 @@ static int __init dss_init_features(struct platform_device *pdev)
 	return 0;
 }
 
+static int dss_init_ports(struct platform_device *pdev)
+{
+	struct device_node *parent = pdev->dev.of_node;
+	struct device_node *port;
+	int r;
+
+	port = omapdss_of_get_next_port(parent, NULL);
+	if (!port) {
+
+#ifdef CONFIG_OMAP2_DSS_DPI
+		dpi_init_port(pdev, parent);
+#endif
+		return 0;
+	}
+
+	do {
+		u32 reg;
+
+		r = of_property_read_u32(port, "reg", &reg);
+		if (r)
+			reg = 0;
+
+#ifdef CONFIG_OMAP2_DSS_DPI
+		if (reg == 0)
+			dpi_init_port(pdev, port);
+#endif
+
+#ifdef CONFIG_OMAP2_DSS_SDI
+		if (reg == 1)
+			sdi_init_port(pdev, port);
+#endif
+
+	} while ((port = omapdss_of_get_next_port(parent, port)) != NULL);
+
+	return 0;
+}
+
+static void dss_uninit_ports(void)
+{
+#ifdef CONFIG_OMAP2_DSS_DPI
+	dpi_uninit_port();
+#endif
+
+#ifdef CONFIG_OMAP2_DSS_SDI
+	sdi_uninit_port();
+#endif
+}
+
 /* DSS HW IP initialisation */
 static int __init omap_dsshw_probe(struct platform_device *pdev)
 {
@@ -899,6 +949,8 @@ static int __init omap_dsshw_probe(struct platform_device *pdev)
 	dss.lcd_clk_source[0] = OMAP_DSS_CLK_SRC_FCK;
 	dss.lcd_clk_source[1] = OMAP_DSS_CLK_SRC_FCK;
 
+	dss_init_ports(pdev);
+
 	rev = dss_read_reg(DSS_REVISION);
 	printk(KERN_INFO "OMAP DSS rev %d.%d\n",
 			FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
@@ -918,6 +970,8 @@ err_setup_clocks:
 
 static int __exit omap_dsshw_remove(struct platform_device *pdev)
 {
+	dss_uninit_ports();
+
 	pm_runtime_disable(&pdev->dev);
 
 	dss_put_clocks();
@@ -955,12 +1009,21 @@ static const struct dev_pm_ops dss_pm_ops = {
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
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index f538e867c0f8..81c6bc8befea 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -261,6 +261,9 @@ bool dss_div_calc(unsigned long fck_min, dss_div_calc_func func, void *data);
 int sdi_init_platform_driver(void) __init;
 void sdi_uninit_platform_driver(void) __exit;
 
+int sdi_init_port(struct platform_device *pdev, struct device_node *port) __init;
+void sdi_uninit_port(void) __exit;
+
 /* DSI */
 
 typedef bool (*dsi_pll_calc_func)(int regn, int regm, unsigned long fint,
@@ -372,6 +375,9 @@ static inline bool dsi_pll_calc(struct platform_device *dsidev,
 int dpi_init_platform_driver(void) __init;
 void dpi_uninit_platform_driver(void) __exit;
 
+int dpi_init_port(struct platform_device *pdev, struct device_node *port) __init;
+void dpi_uninit_port(void) __exit;
+
 /* DISPC */
 int dispc_init_platform_driver(void) __init;
 void dispc_uninit_platform_driver(void) __exit;
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index ccc569ae7cca..337e3dbb65aa 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -26,6 +26,7 @@
 #include <linux/export.h>
 #include <linux/platform_device.h>
 #include <linux/string.h>
+#include <linux/of.h>
 
 #include <video/omapdss.h>
 #include "dss.h"
@@ -41,6 +42,8 @@ static struct {
 	int datapairs;
 
 	struct omap_dss_device output;
+
+	bool port_initialized;
 } sdi;
 
 struct sdi_clk_calc_ctx {
@@ -387,3 +390,45 @@ void __exit sdi_uninit_platform_driver(void)
 {
 	platform_driver_unregister(&omap_sdi_driver);
 }
+
+int __init sdi_init_port(struct platform_device *pdev, struct device_node *port)
+{
+	struct device_node *ep;
+	u32 datapairs;
+	int r;
+
+	ep = omapdss_of_get_next_endpoint(port, NULL);
+	if (!ep)
+		return 0;
+
+	r = of_property_read_u32(ep, "datapairs", &datapairs);
+	if (r) {
+		DSSERR("failed to parse datapairs\n");
+		goto err_datapairs;
+	}
+
+	sdi.datapairs = datapairs;
+
+	of_node_put(ep);
+
+	sdi.pdev = pdev;
+
+	sdi_init_output(pdev);
+
+	sdi.port_initialized = true;
+
+	return 0;
+
+err_datapairs:
+	of_node_put(ep);
+
+	return r;
+}
+
+void __exit sdi_uninit_port(void)
+{
+	if (!sdi.port_initialized)
+		return;
+
+	sdi_uninit_output(sdi.pdev);
+}
-- 
1.8.3.2

