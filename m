From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 21/21] OMAPDSS: change default_device handling
Date: Wed,  7 Mar 2012 14:44:50 +0200
Message-ID: <1331124290-6285-22-git-send-email-tomi.valkeinen@ti.com>
References: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:60827 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758604Ab2CGMq4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 07:46:56 -0500
Received: by mail-lpp01m010-f50.google.com with SMTP id m13so7719460lah.9
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 04:46:54 -0800 (PST)
In-Reply-To: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
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
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index aa294d7..dd8f07c 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -43,6 +43,8 @@ static struct {
 
 	struct regulator *vdds_dsi_reg;
 	struct regulator *vdds_sdi_reg;
+
+	const char *default_display_name;
 } core;
 
 static char *def_disp_name;
@@ -212,6 +214,11 @@ static int __init omap_dss_probe(struct platform_device *pdev)
 	if (r)
 		goto err_debugfs;
 
+	if (def_disp_name)
+		core.default_display_name = def_disp_name;
+	else if (pdata->default_device)
+		core.default_display_name = pdata->default_device->name;
+
 	for (i = 0; i < pdata->num_devices; ++i) {
 		struct omap_dss_device *dssdev = pdata->devices[i];
 
@@ -225,9 +232,6 @@ static int __init omap_dss_probe(struct platform_device *pdev)
 
 			goto err_register;
 		}
-
-		if (def_disp_name && strcmp(def_disp_name, dssdev->name) == 0)
-			pdata->default_device = dssdev;
 	}
 
 	return 0;
@@ -350,7 +354,6 @@ static int dss_driver_probe(struct device *dev)
 	int r;
 	struct omap_dss_driver *dssdrv = to_dss_driver(dev->driver);
 	struct omap_dss_device *dssdev = to_dss_device(dev);
-	struct omap_dss_board_info *pdata = core.pdev->dev.platform_data;
 	bool force;
 
 	DSSDBG("driver_probe: dev %s/%s, drv %s\n",
@@ -359,7 +362,8 @@ static int dss_driver_probe(struct device *dev)
 
 	dss_init_device(core.pdev, dssdev);
 
-	force = pdata->default_device == dssdev;
+	force = core.default_display_name &&
+		strcmp(core.default_display_name, dssdev->name) == 0;
 	dss_recheck_connections(dssdev, force);
 
 	r = dssdrv->probe(dssdev);
-- 
1.7.4.1

