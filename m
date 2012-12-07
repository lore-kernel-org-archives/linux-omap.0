From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 4/5] OMAPDSS: manage output-dssdev connection in output drivers
Date: Fri, 7 Dec 2012 13:55:08 +0200
Message-ID: <1354881309-17625-4-git-send-email-tomi.valkeinen@ti.com>
References: <1354881309-17625-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58704 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933037Ab2LGLza (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Dec 2012 06:55:30 -0500
In-Reply-To: <1354881309-17625-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

We currently attach an output to a dssdev in the initialization code for
dssdevices in display.c. This works, but doesn't quite make sense: an
output entity represents (surprisingly) an output of DSS, which is
managed by an output driver. The output driver also handles adding new
dssdev's for that particular output.

It makes more sense to make the output-dssdev connection in the output
driver. This is also in line with common display framework.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/display.c |   12 ------------
 drivers/video/omap2/dss/dpi.c     |    9 +++++++++
 drivers/video/omap2/dss/dsi.c     |   10 ++++++++++
 drivers/video/omap2/dss/dss.h     |    1 -
 drivers/video/omap2/dss/hdmi.c    |    9 +++++++++
 drivers/video/omap2/dss/output.c  |   33 ---------------------------------
 drivers/video/omap2/dss/rfbi.c    |    9 +++++++++
 drivers/video/omap2/dss/sdi.c     |    9 +++++++++
 drivers/video/omap2/dss/venc.c    |    9 +++++++++
 9 files changed, 55 insertions(+), 46 deletions(-)

diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 008e9ee..05f21b6 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -79,17 +79,8 @@ EXPORT_SYMBOL(omapdss_default_get_timings);
 int dss_init_device(struct platform_device *pdev,
 		struct omap_dss_device *dssdev)
 {
-	struct omap_dss_output *out;
 	int r;
 
-	out = omapdss_get_output_from_dssdev(dssdev);
-
-	r = omapdss_output_set_device(out, dssdev);
-	if (r) {
-		DSSERR("failed to connect output to new device\n");
-		return r;
-	}
-
 	r = display_init_sysfs(pdev, dssdev);
 	if (r) {
 		omapdss_output_unset_device(dssdev->output);
@@ -103,9 +94,6 @@ void dss_uninit_device(struct platform_device *pdev,
 		struct omap_dss_device *dssdev)
 {
 	display_uninit_sysfs(pdev, dssdev);
-
-	if (dssdev->output)
-		omapdss_output_unset_device(dssdev->output);
 }
 
 static int dss_suspend_device(struct device *dev, void *data)
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index c109fa6..d5bc47a 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -477,9 +477,18 @@ static void __init dpi_probe_pdata(struct platform_device *dpidev)
 		return;
 	}
 
+	r = omapdss_output_set_device(&dpi.output, dssdev);
+	if (r) {
+		DSSERR("failed to connect output to new device: %s\n",
+				dssdev->name);
+		dss_put_device(dssdev);
+		return;
+	}
+
 	r = dss_add_device(dssdev);
 	if (r) {
 		DSSERR("device %s register failed: %d\n", dssdev->name, r);
+		omapdss_output_unset_device(&dpi.output);
 		dss_put_device(dssdev);
 		return;
 	}
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index cf32dc7..db9663d 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -5146,6 +5146,7 @@ static struct omap_dss_device * __init dsi_find_dssdev(struct platform_device *p
 
 static void __init dsi_probe_pdata(struct platform_device *dsidev)
 {
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	struct omap_dss_device *plat_dssdev;
 	struct omap_dss_device *dssdev;
 	int r;
@@ -5168,9 +5169,18 @@ static void __init dsi_probe_pdata(struct platform_device *dsidev)
 		return;
 	}
 
+	r = omapdss_output_set_device(&dsi->output, dssdev);
+	if (r) {
+		DSSERR("failed to connect output to new device: %s\n",
+				dssdev->name);
+		dss_put_device(dssdev);
+		return;
+	}
+
 	r = dss_add_device(dssdev);
 	if (r) {
 		DSSERR("device %s register failed: %d\n", dssdev->name, r);
+		omapdss_output_unset_device(&dsi->output);
 		dss_put_device(dssdev);
 		return;
 	}
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 4d6f325..bdf8431 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -212,7 +212,6 @@ int dss_ovl_unset_manager(struct omap_overlay *ovl);
 /* output */
 void dss_register_output(struct omap_dss_output *out);
 void dss_unregister_output(struct omap_dss_output *out);
-struct omap_dss_output *omapdss_get_output_from_dssdev(struct omap_dss_device *dssdev);
 
 /* display */
 int dss_suspend_all_devices(void);
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 24a2eef..769d082 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -1026,9 +1026,18 @@ static void __init hdmi_probe_pdata(struct platform_device *pdev)
 		return;
 	}
 
+	r = omapdss_output_set_device(&hdmi.output, dssdev);
+	if (r) {
+		DSSERR("failed to connect output to new device: %s\n",
+				dssdev->name);
+		dss_put_device(dssdev);
+		return;
+	}
+
 	r = dss_add_device(dssdev);
 	if (r) {
 		DSSERR("device %s register failed: %d\n", dssdev->name, r);
+		omapdss_output_unset_device(&hdmi.output);
 		hdmi_uninit_display(dssdev);
 		dss_put_device(dssdev);
 		return;
diff --git a/drivers/video/omap2/dss/output.c b/drivers/video/omap2/dss/output.c
index 813f266..1a84b79 100644
--- a/drivers/video/omap2/dss/output.c
+++ b/drivers/video/omap2/dss/output.c
@@ -113,36 +113,3 @@ struct omap_dss_output *omap_dss_get_output(enum omap_dss_output_id id)
 
 	return NULL;
 }
-
-struct omap_dss_output *omapdss_get_output_from_dssdev(struct omap_dss_device *dssdev)
-{
-	struct omap_dss_output *out = NULL;
-	enum omap_dss_output_id id;
-
-	switch (dssdev->type) {
-	case OMAP_DISPLAY_TYPE_DPI:
-		out = omap_dss_get_output(OMAP_DSS_OUTPUT_DPI);
-		break;
-	case OMAP_DISPLAY_TYPE_DBI:
-		out = omap_dss_get_output(OMAP_DSS_OUTPUT_DBI);
-		break;
-	case OMAP_DISPLAY_TYPE_SDI:
-		out = omap_dss_get_output(OMAP_DSS_OUTPUT_SDI);
-		break;
-	case OMAP_DISPLAY_TYPE_VENC:
-		out = omap_dss_get_output(OMAP_DSS_OUTPUT_VENC);
-		break;
-	case OMAP_DISPLAY_TYPE_HDMI:
-		out = omap_dss_get_output(OMAP_DSS_OUTPUT_HDMI);
-		break;
-	case OMAP_DISPLAY_TYPE_DSI:
-		id = dssdev->phy.dsi.module == 0 ? OMAP_DSS_OUTPUT_DSI1 :
-					OMAP_DSS_OUTPUT_DSI2;
-		out = omap_dss_get_output(id);
-		break;
-	default:
-		break;
-	}
-
-	return out;
-}
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 7bfeb13..ec9fde5 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -999,9 +999,18 @@ static void __init rfbi_probe_pdata(struct platform_device *rfbidev)
 		return;
 	}
 
+	r = omapdss_output_set_device(&rfbi.output, dssdev);
+	if (r) {
+		DSSERR("failed to connect output to new device: %s\n",
+				dssdev->name);
+		dss_put_device(dssdev);
+		return;
+	}
+
 	r = dss_add_device(dssdev);
 	if (r) {
 		DSSERR("device %s register failed: %d\n", dssdev->name, r);
+		omapdss_output_unset_device(&rfbi.output);
 		dss_put_device(dssdev);
 		return;
 	}
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 882ce89..62b5374 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -254,9 +254,18 @@ static void __init sdi_probe_pdata(struct platform_device *sdidev)
 		return;
 	}
 
+	r = omapdss_output_set_device(&sdi.output, dssdev);
+	if (r) {
+		DSSERR("failed to connect output to new device: %s\n",
+				dssdev->name);
+		dss_put_device(dssdev);
+		return;
+	}
+
 	r = dss_add_device(dssdev);
 	if (r) {
 		DSSERR("device %s register failed: %d\n", dssdev->name, r);
+		omapdss_output_unset_device(&sdi.output);
 		dss_put_device(dssdev);
 		return;
 	}
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index e8fddc9..006caf3 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -795,9 +795,18 @@ static void __init venc_probe_pdata(struct platform_device *vencdev)
 		return;
 	}
 
+	r = omapdss_output_set_device(&venc.output, dssdev);
+	if (r) {
+		DSSERR("failed to connect output to new device: %s\n",
+				dssdev->name);
+		dss_put_device(dssdev);
+		return;
+	}
+
 	r = dss_add_device(dssdev);
 	if (r) {
 		DSSERR("device %s register failed: %d\n", dssdev->name, r);
+		omapdss_output_unset_device(&venc.output);
 		dss_put_device(dssdev);
 		return;
 	}
-- 
1.7.10.4

