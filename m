From: Mythri P K <mythripk@ti.com>
Subject: [PATCH v3 1/9] OMAP4 : DSS2 : Add display type HDMI to DSS2
Date: Fri,  4 Mar 2011 13:18:19 +0530
Message-ID: <1299224907-11354-2-git-send-email-mythripk@ti.com>
References: <1299224907-11354-1-git-send-email-mythripk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59400 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753082Ab1CDHsi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Mar 2011 02:48:38 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p247mZwh008030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 4 Mar 2011 01:48:37 -0600
In-Reply-To: <1299224907-11354-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@ti.com
Cc: Mythri P K <mythripk@ti.com>

Adding HDMI type in dss_features , overlay and
the manager so that HDMI type of display will be recognized.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 arch/arm/plat-omap/include/plat/display.h |    1 +
 drivers/video/omap2/dss/display.c         |    5 +++++
 drivers/video/omap2/dss/dss_features.c    |    2 +-
 drivers/video/omap2/dss/manager.c         |    9 +++++++--
 drivers/video/omap2/dss/overlay.c         |    6 ++++--
 5 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index 4e936bd..e0bab29 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -60,6 +60,7 @@ enum omap_display_type {
 	OMAP_DISPLAY_TYPE_SDI		= 1 << 2,
 	OMAP_DISPLAY_TYPE_DSI		= 1 << 3,
 	OMAP_DISPLAY_TYPE_VENC		= 1 << 4,
+	OMAP_DISPLAY_TYPE_HDMI		= 1 << 5,
 };
 
 enum omap_plane {
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 22dd7a4..e10b303 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -345,6 +345,7 @@ int omapdss_default_get_recommended_bpp(struct omap_dss_device *dssdev)
 			return 16;
 	case OMAP_DISPLAY_TYPE_VENC:
 	case OMAP_DISPLAY_TYPE_SDI:
+	case OMAP_DISPLAY_TYPE_HDMI:
 		return 24;
 	default:
 		BUG();
@@ -371,6 +372,7 @@ bool dss_use_replication(struct omap_dss_device *dssdev,
 	case OMAP_DISPLAY_TYPE_DPI:
 		bpp = dssdev->phy.dpi.data_lines;
 		break;
+	case OMAP_DISPLAY_TYPE_HDMI:
 	case OMAP_DISPLAY_TYPE_VENC:
 	case OMAP_DISPLAY_TYPE_SDI:
 		bpp = 24;
@@ -409,6 +411,9 @@ void dss_init_device(struct platform_device *pdev,
 #ifdef CONFIG_OMAP2_DSS_VENC
 	case OMAP_DISPLAY_TYPE_VENC:
 #endif
+#ifdef CONFIG_OMAP2_DSS_HDMI
+	case OMAP_DISPLAY_TYPE_HDMI:
+#endif
 		break;
 	default:
 		DSSERR("Support for display '%s' not compiled in.\n",
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 569eb42..701a2ce 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -102,7 +102,7 @@ static const enum omap_display_type omap4_dss_supported_displays[] = {
 	OMAP_DISPLAY_TYPE_DBI | OMAP_DISPLAY_TYPE_DSI,
 
 	/* OMAP_DSS_CHANNEL_DIGIT */
-	OMAP_DISPLAY_TYPE_VENC,
+	OMAP_DISPLAY_TYPE_VENC | OMAP_DISPLAY_TYPE_HDMI,
 
 	/* OMAP_DSS_CHANNEL_LCD2 */
 	OMAP_DISPLAY_TYPE_DPI | OMAP_DISPLAY_TYPE_DBI |
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 690217b..490c2b8 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -516,6 +516,8 @@ static int dss_mgr_wait_for_vsync(struct omap_overlay_manager *mgr)
 
 	if (mgr->device->type == OMAP_DISPLAY_TYPE_VENC) {
 		irq = DISPC_IRQ_EVSYNC_ODD;
+	} else if (mgr->device->type == OMAP_DISPLAY_TYPE_HDMI) {
+		irq = DISPC_IRQ_EVSYNC_EVEN;
 	} else {
 		if (mgr->id == OMAP_DSS_CHANNEL_LCD)
 			irq = DISPC_IRQ_VSYNC;
@@ -537,7 +539,8 @@ static int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr)
 	if (!dssdev || dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
 		return 0;
 
-	if (dssdev->type == OMAP_DISPLAY_TYPE_VENC) {
+	if (dssdev->type == OMAP_DISPLAY_TYPE_VENC
+			|| dssdev->type == OMAP_DISPLAY_TYPE_HDMI) {
 		irq = DISPC_IRQ_EVSYNC_ODD | DISPC_IRQ_EVSYNC_EVEN;
 	} else {
 		if (dssdev->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE) {
@@ -614,7 +617,8 @@ int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl)
 	if (!dssdev || dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
 		return 0;
 
-	if (dssdev->type == OMAP_DISPLAY_TYPE_VENC) {
+	if (dssdev->type == OMAP_DISPLAY_TYPE_VENC
+			|| dssdev->type == OMAP_DISPLAY_TYPE_HDMI) {
 		irq = DISPC_IRQ_EVSYNC_ODD | DISPC_IRQ_EVSYNC_EVEN;
 	} else {
 		if (dssdev->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE) {
@@ -1381,6 +1385,7 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 		case OMAP_DISPLAY_TYPE_DBI:
 		case OMAP_DISPLAY_TYPE_SDI:
 		case OMAP_DISPLAY_TYPE_VENC:
+		case OMAP_DISPLAY_TYPE_HDMI:
 			default_get_overlay_fifo_thresholds(ovl->id, size,
 					&oc->burst_size, &oc->fifo_low,
 					&oc->fifo_high);
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index d558fb6..ea48936 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -737,7 +737,8 @@ void dss_recheck_connections(struct omap_dss_device *dssdev, bool force)
 			lcd2_mgr->set_device(lcd2_mgr, dssdev);
 			mgr = lcd2_mgr;
 		}
-	} else if (dssdev->type != OMAP_DISPLAY_TYPE_VENC) {
+	} else if (dssdev->type != OMAP_DISPLAY_TYPE_VENC
+			&& dssdev->type != OMAP_DISPLAY_TYPE_HDMI) {
 		if (!lcd_mgr->device || force) {
 			if (lcd_mgr->device)
 				lcd_mgr->unset_device(lcd_mgr);
@@ -746,7 +747,8 @@ void dss_recheck_connections(struct omap_dss_device *dssdev, bool force)
 		}
 	}
 
-	if (dssdev->type == OMAP_DISPLAY_TYPE_VENC) {
+	if (dssdev->type == OMAP_DISPLAY_TYPE_VENC
+			|| dssdev->type == OMAP_DISPLAY_TYPE_HDMI) {
 		if (!tv_mgr->device || force) {
 			if (tv_mgr->device)
 				tv_mgr->unset_device(tv_mgr);
-- 
1.5.6.3

