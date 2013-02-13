From: Archit Taneja <archit@ti.com>
Subject: [PATCH 30/33] OMAPDSS: VENC: remove platform_enable/disable calls
Date: Wed, 13 Feb 2013 19:52:22 +0530
Message-ID: <1360765345-19312-31-git-send-email-archit@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40272 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934039Ab3BMOYp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Feb 2013 09:24:45 -0500
In-Reply-To: <1360765345-19312-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The platform_enable/disable callbacks in board files for VENC omap_dss_device
instances don't do anything. Hence, we can remove these callbacks from the VENC
driver.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/venc.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 006caf3..1598d27 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -519,10 +519,6 @@ int omapdss_venc_display_enable(struct omap_dss_device *dssdev)
 		goto err0;
 	}
 
-	if (dssdev->platform_enable)
-		dssdev->platform_enable(dssdev);
-
-
 	r = venc_power_on(dssdev);
 	if (r)
 		goto err1;
@@ -533,8 +529,6 @@ int omapdss_venc_display_enable(struct omap_dss_device *dssdev)
 
 	return 0;
 err1:
-	if (dssdev->platform_disable)
-		dssdev->platform_disable(dssdev);
 	omap_dss_stop_device(dssdev);
 err0:
 	mutex_unlock(&venc.venc_lock);
@@ -551,9 +545,6 @@ void omapdss_venc_display_disable(struct omap_dss_device *dssdev)
 
 	omap_dss_stop_device(dssdev);
 
-	if (dssdev->platform_disable)
-		dssdev->platform_disable(dssdev);
-
 	mutex_unlock(&venc.venc_lock);
 }
 
-- 
1.7.9.5

