From: Archit Taneja <archit@ti.com>
Subject: [RFC][PATCH 3/8] OMAP: DSS2: Modify dss_recheck_connections
Date: Thu,  1 Jul 2010 16:01:20 +0530
Message-ID: <1277980285-20996-4-git-send-email-archit@ti.com>
References: <1277980285-20996-1-git-send-email-archit@ti.com>
 <1277980285-20996-2-git-send-email-archit@ti.com>
 <1277980285-20996-3-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50279 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755044Ab0GAKbs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Jul 2010 06:31:48 -0400
In-Reply-To: <1277980285-20996-3-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@nokia.com, Sumit Semwal <sumit.semwal@ti.com>, Senthilvadivu Guruswamy <svadivu@ti.com>, Mukund Mittal <mmittal@ti.com>, Archit Taneja <archit@ti.com>, Samreen <samreen@ti.com>

From: Sumit Semwal <sumit.semwal@ti.com>

The addition of the new 2lcd manager requires modifications in the
dss_recheck_connections patch, this function behaves the same if
the 2lcd manager doesn't exist

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
Signed-off-by: Mukund Mittal <mmittal@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
Signed-off-by: Samreen <samreen@ti.com>
---
 drivers/video/omap2/dss/overlay.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index 8233658..c7ad1d1
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

