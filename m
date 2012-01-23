From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/3] OMAPDSS: use sync versions of pm_runtime_put
Date: Mon, 23 Jan 2012 14:15:30 +0200
Message-ID: <1327320930-14550-4-git-send-email-tomi.valkeinen@ti.com>
References: <1327320930-14550-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:54914 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752194Ab2AWMPw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jan 2012 07:15:52 -0500
In-Reply-To: <1327320930-14550-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, paul@pwsan.com
Cc: archit@ti.com, neilb@suse.de, jean.pihet@newoldbits.com, khilman@ti.com, jw@terrafix.co.uk, Tomi Valkeinen <tomi.valkeinen@ti.com>

omapdss doesn't work properly on system suspend. The problem seems to be
the fact that omapdss uses pm_runtime_put() functions when turning off
the hardware, and when system suspend is in process only sync versions
are allowed.

Using non-sync versions normally and sync versions when suspending would
need rather ugly hacks to convey the information of
suspending/not-suspending to different functions. Optimally the driver
wouldn't even need to care about this, and the PM layer would handle
syncing when suspend is in process.

This patch changes all omapdss's pm_runtime_put calls to
pm_runtime_put_sync. This fixes the suspend problem, and probably the
performance penalty of always using sync versions is negligible.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    2 +-
 drivers/video/omap2/dss/dsi.c   |    2 +-
 drivers/video/omap2/dss/dss.c   |    2 +-
 drivers/video/omap2/dss/hdmi.c  |    2 +-
 drivers/video/omap2/dss/rfbi.c  |    2 +-
 drivers/video/omap2/dss/venc.c  |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index a5ec7f3..e1626a1 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -401,7 +401,7 @@ void dispc_runtime_put(void)
 
 	DSSDBG("dispc_runtime_put\n");
 
-	r = pm_runtime_put(&dispc.pdev->dev);
+	r = pm_runtime_put_sync(&dispc.pdev->dev);
 	WARN_ON(r < 0);
 }
 
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index d4d676c..52f36ec 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1079,7 +1079,7 @@ void dsi_runtime_put(struct platform_device *dsidev)
 
 	DSSDBG("dsi_runtime_put\n");
 
-	r = pm_runtime_put(&dsi->pdev->dev);
+	r = pm_runtime_put_sync(&dsi->pdev->dev);
 	WARN_ON(r < 0);
 }
 
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 1703345..77c2b5a 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -720,7 +720,7 @@ void dss_runtime_put(void)
 
 	DSSDBG("dss_runtime_put\n");
 
-	r = pm_runtime_put(&dss.pdev->dev);
+	r = pm_runtime_put_sync(&dss.pdev->dev);
 	WARN_ON(r < 0);
 }
 
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index b4c270e..c39f9c3 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -176,7 +176,7 @@ static void hdmi_runtime_put(void)
 
 	DSSDBG("hdmi_runtime_put\n");
 
-	r = pm_runtime_put(&hdmi.pdev->dev);
+	r = pm_runtime_put_sync(&hdmi.pdev->dev);
 	WARN_ON(r < 0);
 }
 
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 814bb95..55f3980 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -140,7 +140,7 @@ static void rfbi_runtime_put(void)
 
 	DSSDBG("rfbi_runtime_put\n");
 
-	r = pm_runtime_put(&rfbi.pdev->dev);
+	r = pm_runtime_put_sync(&rfbi.pdev->dev);
 	WARN_ON(r < 0);
 }
 
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index b3e9f90..5c3d0f9 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -401,7 +401,7 @@ static void venc_runtime_put(void)
 
 	DSSDBG("venc_runtime_put\n");
 
-	r = pm_runtime_put(&venc.pdev->dev);
+	r = pm_runtime_put_sync(&venc.pdev->dev);
 	WARN_ON(r < 0);
 }
 
-- 
1.7.4.1

