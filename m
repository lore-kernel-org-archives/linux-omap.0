From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 09/10] OMAPDSS: HDMI: Add error handling for hdmi_probe_pdata
Date: Mon, 29 Apr 2013 13:22:36 +0300
Message-ID: <1367230957-32337-10-git-send-email-tomi.valkeinen@ti.com>
References: <1367230957-32337-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37189 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757408Ab3D2KXR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Apr 2013 06:23:17 -0400
In-Reply-To: <1367230957-32337-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, grygorii.strashko@ti.com, chf.fritz@googlemail.com, Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add proper error handling for hdmi_probe_pdata(). This will cause
EPROBE_DEFER to be properly passed upwards, causing the HDMI driver to be
probed again later if a resource was missing.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 9aefe60..17f4d55 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -982,7 +982,7 @@ static struct omap_dss_device *hdmi_find_dssdev(struct platform_device *pdev)
 	return def_dssdev;
 }
 
-static void hdmi_probe_pdata(struct platform_device *pdev)
+static int hdmi_probe_pdata(struct platform_device *pdev)
 {
 	struct omap_dss_device *plat_dssdev;
 	struct omap_dss_device *dssdev;
@@ -992,11 +992,11 @@ static void hdmi_probe_pdata(struct platform_device *pdev)
 	plat_dssdev = hdmi_find_dssdev(pdev);
 
 	if (!plat_dssdev)
-		return;
+		return 0;
 
 	dssdev = dss_alloc_and_init_device(&pdev->dev);
 	if (!dssdev)
-		return;
+		return -ENOMEM;
 
 	dss_copy_device_pdata(dssdev, plat_dssdev);
 
@@ -1010,7 +1010,7 @@ static void hdmi_probe_pdata(struct platform_device *pdev)
 	if (r) {
 		DSSERR("device %s init failed: %d\n", dssdev->name, r);
 		dss_put_device(dssdev);
-		return;
+		return r;
 	}
 
 	r = omapdss_output_set_device(&hdmi.output, dssdev);
@@ -1018,7 +1018,7 @@ static void hdmi_probe_pdata(struct platform_device *pdev)
 		DSSERR("failed to connect output to new device: %s\n",
 				dssdev->name);
 		dss_put_device(dssdev);
-		return;
+		return r;
 	}
 
 	r = dss_add_device(dssdev);
@@ -1027,8 +1027,10 @@ static void hdmi_probe_pdata(struct platform_device *pdev)
 		omapdss_output_unset_device(&hdmi.output);
 		hdmi_uninit_display(dssdev);
 		dss_put_device(dssdev);
-		return;
+		return r;
 	}
+
+	return 0;
 }
 
 static void hdmi_init_output(struct platform_device *pdev)
@@ -1096,7 +1098,13 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 
 	dss_debugfs_create_file("hdmi", hdmi_dump_regs);
 
-	hdmi_probe_pdata(pdev);
+	r = hdmi_probe_pdata(pdev);
+	if (r) {
+		hdmi_panel_exit();
+		hdmi_uninit_output(pdev);
+		pm_runtime_disable(&pdev->dev);
+		return r;
+	}
 
 	return 0;
 }
-- 
1.7.10.4

