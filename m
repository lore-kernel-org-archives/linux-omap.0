From: Archit Taneja <archit@ti.com>
Subject: [RFC v2][PATCH 3/7] OMAP: DSS2: Modify dss_recheck_connections
Date: Wed, 14 Jul 2010 12:02:43 +0530
Message-ID: <1279089167-14057-4-git-send-email-archit@ti.com>
References: <1279089167-14057-1-git-send-email-archit@ti.com>
 <1279089167-14057-2-git-send-email-archit@ti.com>
 <1279089167-14057-3-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56869 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751738Ab0GNGdK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Jul 2010 02:33:10 -0400
In-Reply-To: <1279089167-14057-3-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Sumit Semwal <sumit.semwal@ti.com>, Senthilvadivu Guruswamy <svadivu@ti.com>, Mukund Mittal <mmittal@ti.com>, Archit Taneja <archit@ti.com>, Samreen <samreen@ti.com>

From: Sumit Semwal <sumit.semwal@ti.com>

The addition of the new lcd2 manager requires modifications in the
dss_recheck_connections patch, this function behaves the same if
the lcd2 manager doesn't exist

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
Signed-off-by: Mukund Mittal <mmittal@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
Signed-off-by: Samreen <samreen@ti.com>
---
 drivers/video/omap2/dss/overlay.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index 244dca8..29aa157 
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -627,12 +627,22 @@ void dss_recheck_connections(struct omap_dss_device *dssdev, bool force)
 	int i;
 	struct omap_overlay_manager *lcd_mgr;
 	struct omap_overlay_manager *tv_mgr;
+	struct omap_overlay_manager *lcd2_mgr = NULL;
 	struct omap_overlay_manager *mgr = NULL;
 
 	lcd_mgr = omap_dss_get_overlay_manager(OMAP_DSS_OVL_MGR_LCD);
 	tv_mgr = omap_dss_get_overlay_manager(OMAP_DSS_OVL_MGR_TV);
-
-	if (dssdev->type != OMAP_DISPLAY_TYPE_VENC) {
+	if (cpu_is_omap44xx())
+		lcd2_mgr = omap_dss_get_overlay_manager(OMAP_DSS_OVL_MGR_LCD2);
+
+	if (dssdev->channel == OMAP_DSS_CHANNEL_LCD2) {
+		if (!lcd2_mgr->device || force) {
+			if (lcd2_mgr->device)
+				lcd2_mgr->unset_device(lcd2_mgr);
+			lcd2_mgr->set_device(lcd2_mgr, dssdev);
+			mgr = lcd2_mgr;
+		}
+	} else if (dssdev->type != OMAP_DISPLAY_TYPE_VENC) {
 		if (!lcd_mgr->device || force) {
 			if (lcd_mgr->device)
 				lcd_mgr->unset_device(lcd_mgr);
-- 
1.6.3.3

