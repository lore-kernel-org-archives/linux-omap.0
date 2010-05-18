From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 08/23] OMAP: DSS2: VENC: don't call platform_enable/disable() twice
Date: Tue, 18 May 2010 15:34:59 +0300
Message-ID: <1274186114-26951-9-git-send-email-tomi.valkeinen@nokia.com>
References: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62501 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757513Ab0ERMgM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 08:36:12 -0400
In-Reply-To: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Cc: Jani Nikula <ext-jani.1.nikula@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

platform_enable/disable() is already called in venc_power_on/off(), so
don't do it again in venc_panel_enable/disable().

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/dss/venc.c |   15 +--------------
 1 files changed, 1 insertions(+), 14 deletions(-)

diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index f0ba573..eff3505 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -479,12 +479,6 @@ static int venc_panel_enable(struct omap_dss_device *dssdev)
 		goto err1;
 	}
 
-	if (dssdev->platform_enable) {
-		r = dssdev->platform_enable(dssdev);
-		if (r)
-			goto err2;
-	}
-
 	venc_power_on(dssdev);
 
 	venc.wss_data = 0;
@@ -494,13 +488,9 @@ static int venc_panel_enable(struct omap_dss_device *dssdev)
 	/* wait couple of vsyncs until enabling the LCD */
 	msleep(50);
 
-	mutex_unlock(&venc.venc_lock);
-
-	return r;
-err2:
-	venc_power_off(dssdev);
 err1:
 	mutex_unlock(&venc.venc_lock);
+
 	return r;
 }
 
@@ -524,9 +514,6 @@ static void venc_panel_disable(struct omap_dss_device *dssdev)
 	/* wait at least 5 vsyncs after disabling the LCD */
 	msleep(100);
 
-	if (dssdev->platform_disable)
-		dssdev->platform_disable(dssdev);
-
 	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 end:
 	mutex_unlock(&venc.venc_lock);
-- 
1.7.0.4

