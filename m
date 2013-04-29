From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 07/10] OMAPDSS: DPI: Add error handling for dpi_probe_pdata
Date: Mon, 29 Apr 2013 13:22:34 +0300
Message-ID: <1367230957-32337-8-git-send-email-tomi.valkeinen@ti.com>
References: <1367230957-32337-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39886 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758072Ab3D2KXR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Apr 2013 06:23:17 -0400
In-Reply-To: <1367230957-32337-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, grygorii.strashko@ti.com, chf.fritz@googlemail.com, Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add proper error handling for dpi_probe_pdata(). This will cause
EPROBE_DEFER to be properly passed upwards, causing the DPI driver to be
probed again later if a resource was missing.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 2024787..757b57f 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -635,7 +635,7 @@ static struct omap_dss_device *dpi_find_dssdev(struct platform_device *pdev)
 	return def_dssdev;
 }
 
-static void dpi_probe_pdata(struct platform_device *dpidev)
+static int dpi_probe_pdata(struct platform_device *dpidev)
 {
 	struct omap_dss_device *plat_dssdev;
 	struct omap_dss_device *dssdev;
@@ -644,11 +644,11 @@ static void dpi_probe_pdata(struct platform_device *dpidev)
 	plat_dssdev = dpi_find_dssdev(dpidev);
 
 	if (!plat_dssdev)
-		return;
+		return 0;
 
 	dssdev = dss_alloc_and_init_device(&dpidev->dev);
 	if (!dssdev)
-		return;
+		return -ENOMEM;
 
 	dss_copy_device_pdata(dssdev, plat_dssdev);
 
@@ -656,7 +656,7 @@ static void dpi_probe_pdata(struct platform_device *dpidev)
 	if (r) {
 		DSSERR("device %s init failed: %d\n", dssdev->name, r);
 		dss_put_device(dssdev);
-		return;
+		return r;
 	}
 
 	r = omapdss_output_set_device(&dpi.output, dssdev);
@@ -664,7 +664,7 @@ static void dpi_probe_pdata(struct platform_device *dpidev)
 		DSSERR("failed to connect output to new device: %s\n",
 				dssdev->name);
 		dss_put_device(dssdev);
-		return;
+		return r;
 	}
 
 	r = dss_add_device(dssdev);
@@ -672,8 +672,10 @@ static void dpi_probe_pdata(struct platform_device *dpidev)
 		DSSERR("device %s register failed: %d\n", dssdev->name, r);
 		omapdss_output_unset_device(&dpi.output);
 		dss_put_device(dssdev);
-		return;
+		return r;
 	}
+
+	return 0;
 }
 
 static void dpi_init_output(struct platform_device *pdev)
@@ -698,11 +700,17 @@ static void __exit dpi_uninit_output(struct platform_device *pdev)
 
 static int omap_dpi_probe(struct platform_device *pdev)
 {
+	int r;
+
 	mutex_init(&dpi.lock);
 
 	dpi_init_output(pdev);
 
-	dpi_probe_pdata(pdev);
+	r = dpi_probe_pdata(pdev);
+	if (r) {
+		dpi_uninit_output(pdev);
+		return r;
+	}
 
 	return 0;
 }
-- 
1.7.10.4

