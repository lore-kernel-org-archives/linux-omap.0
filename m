From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 5/9] OMAP: DSS2: VENC: Remove sleeps at venc enable/disable
Date: Thu, 31 Mar 2011 13:11:02 +0300
Message-ID: <1301566266-11187-6-git-send-email-tomi.valkeinen@ti.com>
References: <1301566266-11187-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:56829 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933501Ab1CaKLb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Mar 2011 06:11:31 -0400
In-Reply-To: <1301566266-11187-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

VENC code had 50ms sleep after enabling the output and 100ms sleep after
disabling the output. I don't see any reason for these sleeps.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/venc.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 8c7af90..fe18800 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -487,9 +487,6 @@ static int venc_panel_enable(struct omap_dss_device *dssdev)
 
 	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
 
-	/* wait couple of vsyncs until enabling the LCD */
-	msleep(50);
-
 err1:
 	mutex_unlock(&venc.venc_lock);
 
@@ -513,9 +510,6 @@ static void venc_panel_disable(struct omap_dss_device *dssdev)
 
 	venc_power_off(dssdev);
 
-	/* wait at least 5 vsyncs after disabling the LCD */
-	msleep(100);
-
 	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 end:
 	mutex_unlock(&venc.venc_lock);
-- 
1.7.1

