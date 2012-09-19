From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/8] OMAPDSS: omap_dss_register_device() doesn't take display index
Date: Wed, 19 Sep 2012 11:30:31 +0300
Message-ID: <1348043438-2624-2-git-send-email-tomi.valkeinen@ti.com>
References: <1348043438-2624-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:44321 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752498Ab2ISIbF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Sep 2012 04:31:05 -0400
Received: by lbbgj3 with SMTP id gj3so618891lbb.19
        for <linux-omap@vger.kernel.org>; Wed, 19 Sep 2012 01:31:01 -0700 (PDT)
In-Reply-To: <1348043438-2624-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

We used to have all the displays of the board in one list, and we made a
"displayX" directory in the sysfs, where X was the index of the display
in the list.

This doesn't work anymore with device tree, as there's no single list to
get the number from, and it doesn't work very well even with non-DT as
we need to do some tricks to get the index nowadays.

This patch changes omap_dss_register_device() so that it doesn't take
disp_num as a parameter anymore, but uses a private increasing counter
for the display number.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c |    9 +++++----
 drivers/video/omap2/dss/dpi.c  |    2 +-
 drivers/video/omap2/dss/dsi.c  |    2 +-
 drivers/video/omap2/dss/dss.h  |    2 +-
 drivers/video/omap2/dss/hdmi.c |    2 +-
 drivers/video/omap2/dss/rfbi.c |    2 +-
 drivers/video/omap2/dss/sdi.c  |    2 +-
 drivers/video/omap2/dss/venc.c |    2 +-
 8 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 58bd9c2..20c8bc8 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -450,16 +450,17 @@ static void omap_dss_dev_release(struct device *dev)
 	reset_device(dev, 0);
 }
 
+static int disp_num_counter;
+
 int omap_dss_register_device(struct omap_dss_device *dssdev,
-		struct device *parent, int disp_num)
+		struct device *parent)
 {
-	WARN_ON(!dssdev->driver_name);
-
 	reset_device(&dssdev->dev, 1);
+
 	dssdev->dev.bus = &dss_bus_type;
 	dssdev->dev.parent = parent;
 	dssdev->dev.release = omap_dss_dev_release;
-	dev_set_name(&dssdev->dev, "display%d", disp_num);
+	dev_set_name(&dssdev->dev, "display%d", disp_num_counter++);
 	return device_register(&dssdev->dev);
 }
 
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 5ccce9b..703fc1d 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -388,7 +388,7 @@ static void __init dpi_probe_pdata(struct platform_device *pdev)
 			continue;
 		}
 
-		r = omap_dss_register_device(dssdev, &pdev->dev, i);
+		r = omap_dss_register_device(dssdev, &pdev->dev);
 		if (r)
 			DSSERR("device %s register failed: %d\n",
 					dssdev->name, r);
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 8d815e3..f7078fc 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -5027,7 +5027,7 @@ static void __init dsi_probe_pdata(struct platform_device *dsidev)
 			continue;
 		}
 
-		r = omap_dss_register_device(dssdev, &dsidev->dev, i);
+		r = omap_dss_register_device(dssdev, &dsidev->dev);
 		if (r)
 			DSSERR("device %s register failed: %d\n",
 					dssdev->name, r);
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 5e9fd769..7bac8ee 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -185,7 +185,7 @@ int dss_set_min_bus_tput(struct device *dev, unsigned long tput);
 int dss_debugfs_create_file(const char *name, void (*write)(struct seq_file *));
 
 int omap_dss_register_device(struct omap_dss_device *dssdev,
-		struct device *parent, int disp_num);
+		struct device *parent);
 void omap_dss_unregister_device(struct omap_dss_device *dssdev);
 void omap_dss_unregister_child_devices(struct device *parent);
 
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 83f1845..bb07143 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -923,7 +923,7 @@ static void __init hdmi_probe_pdata(struct platform_device *pdev)
 			continue;
 		}
 
-		r = omap_dss_register_device(dssdev, &pdev->dev, i);
+		r = omap_dss_register_device(dssdev, &pdev->dev);
 		if (r)
 			DSSERR("device %s register failed: %d\n",
 					dssdev->name, r);
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 2e520d3..845b4e7 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -959,7 +959,7 @@ static void __init rfbi_probe_pdata(struct platform_device *pdev)
 			continue;
 		}
 
-		r = omap_dss_register_device(dssdev, &pdev->dev, i);
+		r = omap_dss_register_device(dssdev, &pdev->dev);
 		if (r)
 			DSSERR("device %s register failed: %d\n",
 				dssdev->name, r);
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 66c8de4..c9a9045 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -212,7 +212,7 @@ static void __init sdi_probe_pdata(struct platform_device *pdev)
 			continue;
 		}
 
-		r = omap_dss_register_device(dssdev, &pdev->dev, i);
+		r = omap_dss_register_device(dssdev, &pdev->dev);
 		if (r)
 			DSSERR("device %s register failed: %d\n",
 					dssdev->name, r);
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 17b3102..60bfc58 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -752,7 +752,7 @@ static void __init venc_probe_pdata(struct platform_device *pdev)
 			continue;
 		}
 
-		r = omap_dss_register_device(dssdev, &pdev->dev, i);
+		r = omap_dss_register_device(dssdev, &pdev->dev);
 		if (r)
 			DSSERR("device %s register failed: %d\n",
 					dssdev->name, r);
-- 
1.7.9.5

