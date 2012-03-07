From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 14/21] OMAPDSS: create DPI & SDI drivers
Date: Wed,  7 Mar 2012 14:44:43 +0200
Message-ID: <1331124290-6285-15-git-send-email-tomi.valkeinen@ti.com>
References: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:57300 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758537Ab2CGMpk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 07:45:40 -0500
Received: by mail-lpp01m010-f47.google.com with SMTP id w12so8121258lag.20
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 04:45:39 -0800 (PST)
In-Reply-To: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
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
index 95d312c..654962a 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -524,6 +524,18 @@ static int __init omap_dss_register_drivers(void)
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
@@ -557,6 +569,10 @@ err_dsi:
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
@@ -572,6 +588,8 @@ static void __exit omap_dss_unregister_drivers(void)
 	dsi_uninit_platform_driver();
 	venc_uninit_platform_driver();
 	rfbi_uninit_platform_driver();
+	sdi_uninit_platform_driver();
+	dpi_uninit_platform_driver();
 	dispc_uninit_platform_driver();
 	dss_uninit_platform_driver();
 
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index faaf305..5b7bbab 100644
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
index 34cc84f..3156851 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -782,18 +782,6 @@ static int omap_dsshw_probe(struct platform_device *pdev)
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
@@ -801,10 +789,7 @@ static int omap_dsshw_probe(struct platform_device *pdev)
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
@@ -813,9 +798,6 @@ err_runtime_get:
 
 static int omap_dsshw_remove(struct platform_device *pdev)
 {
-	dpi_exit();
-	sdi_exit();
-
 	pm_runtime_disable(&pdev->dev);
 
 	dss_put_clocks();
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index d37ed80..1981626 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -269,17 +269,12 @@ int dss_calc_clock_div(bool is_tft, unsigned long req_pck,
 
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
@@ -381,17 +376,12 @@ static inline struct platform_device *dsi_get_dsidev_from_id(int module)
 
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
index 8266ca0..d886d93 100644
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
1.7.4.1

