From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 6/8] OMAPDSS: cleanup dss_recheck_connections
Date: Wed, 19 Sep 2012 11:30:36 +0300
Message-ID: <1348043438-2624-7-git-send-email-tomi.valkeinen@ti.com>
References: <1348043438-2624-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:36866 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753792Ab2ISIbO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Sep 2012 04:31:14 -0400
Received: by lbbgj3 with SMTP id gj3so618972lbb.19
        for <linux-omap@vger.kernel.org>; Wed, 19 Sep 2012 01:31:12 -0700 (PDT)
In-Reply-To: <1348043438-2624-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

dss_recheck_connections is quite a mess. With the previous commit that
initializes the channel field for HDMI and VENC displays, we can greatly
simplify the dss_recheck_connections.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/overlay.c |   49 +++++--------------------------------
 1 file changed, 6 insertions(+), 43 deletions(-)

diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index e3d4068..1bf05ef 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -109,52 +109,15 @@ void dss_init_overlays(struct platform_device *pdev)
  * selected, connect always. */
 void dss_recheck_connections(struct omap_dss_device *dssdev, bool force)
 {
-	int i;
-	struct omap_overlay_manager *lcd_mgr;
-	struct omap_overlay_manager *tv_mgr;
-	struct omap_overlay_manager *lcd2_mgr = NULL;
-	struct omap_overlay_manager *lcd3_mgr = NULL;
 	struct omap_overlay_manager *mgr = NULL;
+	int i;
 
-	lcd_mgr = omap_dss_get_overlay_manager(OMAP_DSS_CHANNEL_LCD);
-	tv_mgr = omap_dss_get_overlay_manager(OMAP_DSS_CHANNEL_DIGIT);
-	if (dss_has_feature(FEAT_MGR_LCD3))
-		lcd3_mgr = omap_dss_get_overlay_manager(OMAP_DSS_CHANNEL_LCD3);
-	if (dss_has_feature(FEAT_MGR_LCD2))
-		lcd2_mgr = omap_dss_get_overlay_manager(OMAP_DSS_CHANNEL_LCD2);
-
-	if (dssdev->channel == OMAP_DSS_CHANNEL_LCD3) {
-		if (!lcd3_mgr->device || force) {
-			if (lcd3_mgr->device)
-				lcd3_mgr->unset_device(lcd3_mgr);
-			lcd3_mgr->set_device(lcd3_mgr, dssdev);
-			mgr = lcd3_mgr;
-		}
-	} else if (dssdev->channel == OMAP_DSS_CHANNEL_LCD2) {
-		if (!lcd2_mgr->device || force) {
-			if (lcd2_mgr->device)
-				lcd2_mgr->unset_device(lcd2_mgr);
-			lcd2_mgr->set_device(lcd2_mgr, dssdev);
-			mgr = lcd2_mgr;
-		}
-	} else if (dssdev->type != OMAP_DISPLAY_TYPE_VENC
-			&& dssdev->type != OMAP_DISPLAY_TYPE_HDMI) {
-		if (!lcd_mgr->device || force) {
-			if (lcd_mgr->device)
-				lcd_mgr->unset_device(lcd_mgr);
-			lcd_mgr->set_device(lcd_mgr, dssdev);
-			mgr = lcd_mgr;
-		}
-	}
+	mgr =  omap_dss_get_overlay_manager(dssdev->channel);
 
-	if (dssdev->type == OMAP_DISPLAY_TYPE_VENC
-			|| dssdev->type == OMAP_DISPLAY_TYPE_HDMI) {
-		if (!tv_mgr->device || force) {
-			if (tv_mgr->device)
-				tv_mgr->unset_device(tv_mgr);
-			tv_mgr->set_device(tv_mgr, dssdev);
-			mgr = tv_mgr;
-		}
+	if (!mgr->device || force) {
+		if (mgr->device)
+			mgr->unset_device(mgr);
+		mgr->set_device(mgr, dssdev);
 	}
 
 	if (mgr) {
-- 
1.7.9.5

