From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 05/10] OMAPDSS: DSI: Add error handling for dsi_probe_pdata
Date: Mon, 29 Apr 2013 13:22:32 +0300
Message-ID: <1367230957-32337-6-git-send-email-tomi.valkeinen@ti.com>
References: <1367230957-32337-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39878 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758053Ab3D2KXK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Apr 2013 06:23:10 -0400
In-Reply-To: <1367230957-32337-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, grygorii.strashko@ti.com, chf.fritz@googlemail.com, Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add proper error handling for dsi_probe_pdata(). This will cause
EPROBE_DEFER to be properly passed upwards, causing the DSI driver to be
probed again later if a resource was missing.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 55fc0d4..a73dedc 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -5398,7 +5398,7 @@ static struct omap_dss_device *dsi_find_dssdev(struct platform_device *pdev)
 	return def_dssdev;
 }
 
-static void dsi_probe_pdata(struct platform_device *dsidev)
+static int dsi_probe_pdata(struct platform_device *dsidev)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	struct omap_dss_device *plat_dssdev;
@@ -5408,11 +5408,11 @@ static void dsi_probe_pdata(struct platform_device *dsidev)
 	plat_dssdev = dsi_find_dssdev(dsidev);
 
 	if (!plat_dssdev)
-		return;
+		return 0;
 
 	dssdev = dss_alloc_and_init_device(&dsidev->dev);
 	if (!dssdev)
-		return;
+		return -ENOMEM;
 
 	dss_copy_device_pdata(dssdev, plat_dssdev);
 
@@ -5420,7 +5420,7 @@ static void dsi_probe_pdata(struct platform_device *dsidev)
 	if (r) {
 		DSSERR("device %s init failed: %d\n", dssdev->name, r);
 		dss_put_device(dssdev);
-		return;
+		return r;
 	}
 
 	r = omapdss_output_set_device(&dsi->output, dssdev);
@@ -5428,7 +5428,7 @@ static void dsi_probe_pdata(struct platform_device *dsidev)
 		DSSERR("failed to connect output to new device: %s\n",
 				dssdev->name);
 		dss_put_device(dssdev);
-		return;
+		return r;
 	}
 
 	r = dss_add_device(dssdev);
@@ -5458,7 +5458,7 @@ static void dsi_init_output(struct platform_device *dsidev)
 	dss_register_output(out);
 }
 
-static void __exit dsi_uninit_output(struct platform_device *dsidev)
+static void dsi_uninit_output(struct platform_device *dsidev)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	struct omap_dss_output *out = &dsi->output;
@@ -5563,7 +5563,13 @@ static int omap_dsihw_probe(struct platform_device *dsidev)
 
 	dsi_init_output(dsidev);
 
-	dsi_probe_pdata(dsidev);
+	r = dsi_probe_pdata(dsidev);
+	if (r) {
+		dsi_runtime_put(dsidev);
+		dsi_uninit_output(dsidev);
+		pm_runtime_disable(&dsidev->dev);
+		return r;
+	}
 
 	dsi_runtime_put(dsidev);
 
-- 
1.7.10.4

