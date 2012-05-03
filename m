From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 20/25] OMAPDSS: change default_device handling
Date: Thu,  3 May 2012 16:57:56 +0300
Message-ID: <1336053481-25433-21-git-send-email-tomi.valkeinen@ti.com>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:46898 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756360Ab2ECN6y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 09:58:54 -0400
Received: by lbjn8 with SMTP id n8so1808543lbj.14
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 06:58:50 -0700 (PDT)
In-Reply-To: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

We currently have a two ways to set a "default panel device" for dss, to
which the overlays are connected when the omapdss driver is loaded:

- in textual format (name of the display) as cmdline parameter
- as a pointer to the panel device from board file via pdata

The current code handles this in a bit too complex way by using both of
the above methods during runtime. However, with DT we don't have pdata
anymore, so the code handling the second case won't work anymore. The
current code has also the problem that it modifies the platform_data.

This patch simplifies the code a bit by using the pointer method only
inside the probe function, and stores the name of the panel device. This
way we only need to handle the textual format during operation and also
avoid modifying the platform_data.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 9b84f13..c3566a0 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -43,6 +43,8 @@ static struct {
 
 	struct regulator *vdds_dsi_reg;
 	struct regulator *vdds_sdi_reg;
+
+	const char *default_display_name;
 } core;
 
 static char *def_disp_name;
@@ -222,6 +224,11 @@ static int __init omap_dss_probe(struct platform_device *pdev)
 	if (r)
 		goto err_debugfs;
 
+	if (def_disp_name)
+		core.default_display_name = def_disp_name;
+	else if (pdata->default_device)
+		core.default_display_name = pdata->default_device->name;
+
 	for (i = 0; i < pdata->num_devices; ++i) {
 		struct omap_dss_device *dssdev = pdata->devices[i];
 
@@ -235,9 +242,6 @@ static int __init omap_dss_probe(struct platform_device *pdev)
 
 			goto err_register;
 		}
-
-		if (def_disp_name && strcmp(def_disp_name, dssdev->name) == 0)
-			pdata->default_device = dssdev;
 	}
 
 	return 0;
@@ -360,7 +364,6 @@ static int dss_driver_probe(struct device *dev)
 	int r;
 	struct omap_dss_driver *dssdrv = to_dss_driver(dev->driver);
 	struct omap_dss_device *dssdev = to_dss_device(dev);
-	struct omap_dss_board_info *pdata = core.pdev->dev.platform_data;
 	bool force;
 
 	DSSDBG("driver_probe: dev %s/%s, drv %s\n",
@@ -369,7 +372,8 @@ static int dss_driver_probe(struct device *dev)
 
 	dss_init_device(core.pdev, dssdev);
 
-	force = pdata->default_device == dssdev;
+	force = core.default_display_name &&
+		strcmp(core.default_display_name, dssdev->name) == 0;
 	dss_recheck_connections(dssdev, force);
 
 	r = dssdrv->probe(dssdev);
-- 
1.7.9.5

