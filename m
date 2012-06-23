From: jaswinder.singh@linaro.org
Subject: [PATCH] OMAPDSS: Check if RPM enabled before trying to change state
Date: Sat, 23 Jun 2012 13:36:11 +0530
Message-ID: <1340438771-25587-1-git-send-email-jaswinder.singh@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60523 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711Ab2FWIGd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 Jun 2012 04:06:33 -0400
Received: by dady13 with SMTP id y13so3270050dad.19
        for <linux-omap@vger.kernel.org>; Sat, 23 Jun 2012 01:06:32 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com, Jassi Brar <jaswinder.singh@linaro.org>

From: Jassi Brar <jaswinder.singh@linaro.org>

If the runtime PM of the device is disabled (for example in resume from
suspend path), it doesn't make sense to attempt pm_runtime_get/put, esp
when their return values affect the control flow path.

Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---

 Currenlty HDMI fails to come up in the suspend-resume path.
This patch helps that real-world scenario.

 drivers/video/omap2/dss/dispc.c |    6 ++++++
 drivers/video/omap2/dss/dsi.c   |    6 ++++++
 drivers/video/omap2/dss/dss.c   |    6 ++++++
 drivers/video/omap2/dss/hdmi.c  |    6 ++++++
 drivers/video/omap2/dss/rfbi.c  |    6 ++++++
 drivers/video/omap2/dss/venc.c  |    6 ++++++
 6 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 4749ac3..2c3266f 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -372,6 +372,9 @@ int dispc_runtime_get(void)
 
 	DSSDBG("dispc_runtime_get\n");
 
+	if (!pm_runtime_enabled(&dispc.pdev->dev))
+		return 0;
+
 	r = pm_runtime_get_sync(&dispc.pdev->dev);
 	WARN_ON(r < 0);
 	return r < 0 ? r : 0;
@@ -383,6 +386,9 @@ void dispc_runtime_put(void)
 
 	DSSDBG("dispc_runtime_put\n");
 
+	if (!pm_runtime_enabled(&dispc.pdev->dev))
+		return;
+
 	r = pm_runtime_put_sync(&dispc.pdev->dev);
 	WARN_ON(r < 0);
 }
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index ca8382d..6db4cb1 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1062,6 +1062,9 @@ int dsi_runtime_get(struct platform_device *dsidev)
 
 	DSSDBG("dsi_runtime_get\n");
 
+	if (!pm_runtime_enabled(&dsi->pdev->dev))
+		return 0;
+
 	r = pm_runtime_get_sync(&dsi->pdev->dev);
 	WARN_ON(r < 0);
 	return r < 0 ? r : 0;
@@ -1074,6 +1077,9 @@ void dsi_runtime_put(struct platform_device *dsidev)
 
 	DSSDBG("dsi_runtime_put\n");
 
+	if (!pm_runtime_enabled(&dsi->pdev->dev))
+		return;
+
 	r = pm_runtime_put_sync(&dsi->pdev->dev);
 	WARN_ON(r < 0);
 }
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 7706323..5e52224 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -719,6 +719,9 @@ static int dss_runtime_get(void)
 
 	DSSDBG("dss_runtime_get\n");
 
+	if (!pm_runtime_enabled(&dss.pdev->dev))
+		return 0;
+
 	r = pm_runtime_get_sync(&dss.pdev->dev);
 	WARN_ON(r < 0);
 	return r < 0 ? r : 0;
@@ -730,6 +733,9 @@ static void dss_runtime_put(void)
 
 	DSSDBG("dss_runtime_put\n");
 
+	if (!pm_runtime_enabled(&dss.pdev->dev))
+		return;
+
 	r = pm_runtime_put_sync(&dss.pdev->dev);
 	WARN_ON(r < 0 && r != -EBUSY);
 }
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 0738090..900e621 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -123,6 +123,9 @@ static int hdmi_runtime_get(void)
 
 	DSSDBG("hdmi_runtime_get\n");
 
+	if (!pm_runtime_enabled(&hdmi.pdev->dev))
+		return 0;
+
 	r = pm_runtime_get_sync(&hdmi.pdev->dev);
 	WARN_ON(r < 0);
 	if (r < 0)
@@ -137,6 +140,9 @@ static void hdmi_runtime_put(void)
 
 	DSSDBG("hdmi_runtime_put\n");
 
+	if (!pm_runtime_enabled(&hdmi.pdev->dev))
+		return;
+
 	r = pm_runtime_put_sync(&hdmi.pdev->dev);
 	WARN_ON(r < 0);
 }
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 3d8c206..401384a 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -129,6 +129,9 @@ static int rfbi_runtime_get(void)
 
 	DSSDBG("rfbi_runtime_get\n");
 
+	if (!pm_runtime_enabled(&rfbi.pdev->dev))
+		return 0;
+
 	r = pm_runtime_get_sync(&rfbi.pdev->dev);
 	WARN_ON(r < 0);
 	return r < 0 ? r : 0;
@@ -140,6 +143,9 @@ static void rfbi_runtime_put(void)
 
 	DSSDBG("rfbi_runtime_put\n");
 
+	if (!pm_runtime_enabled(&rfbi.pdev->dev))
+		return;
+
 	r = pm_runtime_put_sync(&rfbi.pdev->dev);
 	WARN_ON(r < 0);
 }
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 2b89739..edd8710 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -390,6 +390,9 @@ static int venc_runtime_get(void)
 
 	DSSDBG("venc_runtime_get\n");
 
+	if (!pm_runtime_enabled(&venc.pdev->dev))
+		return 0;
+
 	r = pm_runtime_get_sync(&venc.pdev->dev);
 	WARN_ON(r < 0);
 	return r < 0 ? r : 0;
@@ -401,6 +404,9 @@ static void venc_runtime_put(void)
 
 	DSSDBG("venc_runtime_put\n");
 
+	if (!pm_runtime_enabled(&venc.pdev->dev))
+		return;
+
 	r = pm_runtime_put_sync(&venc.pdev->dev);
 	WARN_ON(r < 0);
 }
-- 
1.7.4.1

