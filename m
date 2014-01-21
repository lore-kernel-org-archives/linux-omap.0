From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv3 09/41] OMAPDSS: Add DT support to DSS
Date: Tue, 21 Jan 2014 12:56:41 +0200
Message-ID: <1390301833-24944-10-git-send-email-tomi.valkeinen@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Archit Taneja <archit-l0cyMroinI0@public.gmane.org>, Darren Etheridge <detheridge-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Stefan Roese <stefan.roese-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Dr . H . Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add DT support for DSS. Contrary to the non-DT version, the DSS in DT
mode contains DPI and SDI outputs, which better reflects the hardware.
The non-DT code will be removed after all boards have been converted to
DT, so there's no need to change the non-DT code to act the same way.

The code for DPI and SDI needs to be refined later to make it possible
to add multiple DPI ports. For now, handling just a single DPI port is
enough for all the boards.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
---
 drivers/video/omap2/dss/dpi.c | 47 +++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss.c | 64 +++++++++++++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss.h |  6 ++++
 drivers/video/omap2/dss/sdi.c | 45 ++++++++++++++++++++++++++++++
 4 files changed, 162 insertions(+)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index fcba3c129efb..8b8f670a0d7d 100644
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
@@ -727,3 +730,47 @@ void __exit dpi_uninit_platform_driver(void)
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
index bd01608e67e2..8316a0b56154 100644
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
@@ -955,12 +1009,22 @@ static const struct dev_pm_ops dss_pm_ops = {
 	.runtime_resume = dss_runtime_resume,
 };
 
+static const struct of_device_id dss_of_match[] = {
+	{ .compatible = "ti,omap2-dss", },
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
index 156d146a72a6..e4404ddefe5b 100644
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
@@ -388,3 +391,45 @@ void __exit sdi_uninit_platform_driver(void)
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
