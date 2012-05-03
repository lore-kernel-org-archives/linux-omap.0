From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 13/25] OMAPDSS: create DPI & SDI drivers
Date: Thu,  3 May 2012 16:57:49 +0300
Message-ID: <1336053481-25433-14-git-send-email-tomi.valkeinen@ti.com>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:43475 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755120Ab2ECN6m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 09:58:42 -0400
Received: by lagj5 with SMTP id j5so1453484lag.31
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 06:58:38 -0700 (PDT)
In-Reply-To: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

We currently have separate device/driver for each DSS HW module. The DPI
and SDI outputs are more or less parts of the DSS or DISPC hardware
modules, but in SW it makes sense to represent them as device/driver
pairs similarly to all the other outputs. This also makes sense for
device tree, as each node under dss will be a platform device, and
handling DPI & SDI somehow differently than the rest would just make the
code more complex.

This patch modifies the dpi.c and sdi.c to create drivers for the
platform devices.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c |   18 ++++++++++++++++++
 drivers/video/omap2/dss/dpi.c  |   23 +++++++++++++++++++++--
 drivers/video/omap2/dss/dss.c  |   20 +-------------------
 drivers/video/omap2/dss/dss.h  |   26 ++++++++------------------
 drivers/video/omap2/dss/sdi.c  |   25 +++++++++++++++++++++++--
 5 files changed, 71 insertions(+), 41 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index db45e6a..77fbd99 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -536,6 +536,18 @@ static int __init omap_dss_register_drivers(void)
 		goto err_dispc;
 	}
 
+	r = dpi_init_platform_driver();
+	if (r) {
+		DSSERR("Failed to initialize dpi platform driver\n");
+		goto err_dpi;
+	}
+
+	r = sdi_init_platform_driver();
+	if (r) {
+		DSSERR("Failed to initialize sdi platform driver\n");
+		goto err_sdi;
+	}
+
 	r = rfbi_init_platform_driver();
 	if (r) {
 		DSSERR("Failed to initialize rfbi platform driver\n");
@@ -569,6 +581,10 @@ err_dsi:
 err_venc:
 	rfbi_uninit_platform_driver();
 err_rfbi:
+	sdi_uninit_platform_driver();
+err_sdi:
+	dpi_uninit_platform_driver();
+err_dpi:
 	dispc_uninit_platform_driver();
 err_dispc:
 	dss_uninit_platform_driver();
@@ -584,6 +600,8 @@ static void __exit omap_dss_unregister_drivers(void)
 	dsi_uninit_platform_driver();
 	venc_uninit_platform_driver();
 	rfbi_uninit_platform_driver();
+	sdi_uninit_platform_driver();
+	dpi_uninit_platform_driver();
 	dispc_uninit_platform_driver();
 	dss_uninit_platform_driver();
 
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index cec1166..f4398fd 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -378,12 +378,31 @@ int dpi_init_display(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-int dpi_init(void)
+static int omap_dpi_probe(struct platform_device *pdev)
 {
 	return 0;
 }
 
-void dpi_exit(void)
+static int omap_dpi_remove(struct platform_device *pdev)
 {
+	return 0;
 }
 
+static struct platform_driver omap_dpi_driver = {
+	.probe		= omap_dpi_probe,
+	.remove         = omap_dpi_remove,
+	.driver         = {
+		.name   = "omapdss_dpi",
+		.owner  = THIS_MODULE,
+	},
+};
+
+int dpi_init_platform_driver(void)
+{
+	return platform_driver_register(&omap_dpi_driver);
+}
+
+void dpi_uninit_platform_driver(void)
+{
+	platform_driver_unregister(&omap_dpi_driver);
+}
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 2bdc400..17a1927 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -785,18 +785,6 @@ static int omap_dsshw_probe(struct platform_device *pdev)
 	dss.lcd_clk_source[0] = OMAP_DSS_CLK_SRC_FCK;
 	dss.lcd_clk_source[1] = OMAP_DSS_CLK_SRC_FCK;
 
-	r = dpi_init();
-	if (r) {
-		DSSERR("Failed to initialize DPI\n");
-		goto err_dpi;
-	}
-
-	r = sdi_init();
-	if (r) {
-		DSSERR("Failed to initialize SDI\n");
-		goto err_sdi;
-	}
-
 	rev = dss_read_reg(DSS_REVISION);
 	printk(KERN_INFO "OMAP DSS rev %d.%d\n",
 			FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
@@ -804,10 +792,7 @@ static int omap_dsshw_probe(struct platform_device *pdev)
 	dss_runtime_put();
 
 	return 0;
-err_sdi:
-	dpi_exit();
-err_dpi:
-	dss_runtime_put();
+
 err_runtime_get:
 	pm_runtime_disable(&pdev->dev);
 	dss_put_clocks();
@@ -816,9 +801,6 @@ err_runtime_get:
 
 static int omap_dsshw_remove(struct platform_device *pdev)
 {
-	dpi_exit();
-	sdi_exit();
-
 	pm_runtime_disable(&pdev->dev);
 
 	dss_put_clocks();
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index bb3079d..4373b15 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -267,17 +267,12 @@ int dss_calc_clock_div(bool is_tft, unsigned long req_pck,
 
 /* SDI */
 #ifdef CONFIG_OMAP2_DSS_SDI
-int sdi_init(void);
-void sdi_exit(void);
+int sdi_init_platform_driver(void);
+void sdi_uninit_platform_driver(void);
 int sdi_init_display(struct omap_dss_device *display);
 #else
-static inline int sdi_init(void)
-{
-	return 0;
-}
-static inline void sdi_exit(void)
-{
-}
+static inline int sdi_init_platform_driver(void) { return 0; }
+static inline void sdi_uninit_platform_driver(void) { }
 #endif
 
 /* DSI */
@@ -379,17 +374,12 @@ static inline struct platform_device *dsi_get_dsidev_from_id(int module)
 
 /* DPI */
 #ifdef CONFIG_OMAP2_DSS_DPI
-int dpi_init(void);
-void dpi_exit(void);
+int dpi_init_platform_driver(void);
+void dpi_uninit_platform_driver(void);
 int dpi_init_display(struct omap_dss_device *dssdev);
 #else
-static inline int dpi_init(void)
-{
-	return 0;
-}
-static inline void dpi_exit(void)
-{
-}
+static inline int dpi_init_platform_driver(void) { return 0; }
+static inline void dpi_uninit_platform_driver(void) { }
 #endif
 
 /* DISPC */
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 741b834..a047f44 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -24,6 +24,7 @@
 #include <linux/err.h>
 #include <linux/regulator/consumer.h>
 #include <linux/export.h>
+#include <linux/platform_device.h>
 
 #include <video/omapdss.h>
 #include "dss.h"
@@ -182,11 +183,31 @@ int sdi_init_display(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-int sdi_init(void)
+static int omap_sdi_probe(struct platform_device *pdev)
 {
 	return 0;
 }
 
-void sdi_exit(void)
+static int omap_sdi_remove(struct platform_device *pdev)
 {
+	return 0;
+}
+
+static struct platform_driver omap_sdi_driver = {
+	.probe		= omap_sdi_probe,
+	.remove         = omap_sdi_remove,
+	.driver         = {
+		.name   = "omapdss_sdi",
+		.owner  = THIS_MODULE,
+	},
+};
+
+int sdi_init_platform_driver(void)
+{
+	return platform_driver_register(&omap_sdi_driver);
+}
+
+void sdi_uninit_platform_driver(void)
+{
+	platform_driver_unregister(&omap_sdi_driver);
 }
-- 
1.7.9.5

