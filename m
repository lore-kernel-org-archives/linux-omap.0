From: Mythri P K <mythripk@ti.com>
Subject: [PATCH v4 1/9] OMAP4 : DSS2 : Add display type HDMI to DSS2
Date: Wed,  9 Mar 2011 17:15:10 +0530
Message-ID: <1299671118-20839-2-git-send-email-mythripk@ti.com>
References: <1299671118-20839-1-git-send-email-mythripk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41927 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756880Ab1CILv4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Mar 2011 06:51:56 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p29Bpq4B017228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 9 Mar 2011 05:51:55 -0600
In-Reply-To: <1299671118-20839-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@ti.com
Cc: Mythri P K <mythripk@ti.com>

Adding HDMI type in dss_features , overlay and
the manager so that HDMI type of display will be recognized.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 arch/arm/plat-omap/include/plat/display.h |    1 +
 drivers/video/omap2/dss/display.c         |    2 ++
 drivers/video/omap2/dss/dss_features.c    |    2 +-
 drivers/video/omap2/dss/manager.c         |    9 +++++++--
 drivers/video/omap2/dss/overlay.c         |    6 ++++--
 5 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index e81ca66..5e04ddc 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -58,6 +58,7 @@ enum omap_display_type {
 	OMAP_DISPLAY_TYPE_SDI		= 1 << 2,
 	OMAP_DISPLAY_TYPE_DSI		= 1 << 3,
 	OMAP_DISPLAY_TYPE_VENC		= 1 << 4,
+	OMAP_DISPLAY_TYPE_HDMI		= 1 << 5,
 };
 
 enum omap_plane {
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 7d96b72..c40bcbd 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -342,6 +342,7 @@ int omapdss_default_get_recommended_bpp(struct omap_dss_device *dssdev)
 			return 16;
 	case OMAP_DISPLAY_TYPE_VENC:
 	case OMAP_DISPLAY_TYPE_SDI:
+	case OMAP_DISPLAY_TYPE_HDMI:
 		return 24;
 	default:
 		BUG();
@@ -368,6 +369,7 @@ bool dss_use_replication(struct omap_dss_device *dssdev,
 	case OMAP_DISPLAY_TYPE_DPI:
 		bpp = dssdev->phy.dpi.data_lines;
 		break;
+	case OMAP_DISPLAY_TYPE_HDMI:
 	case OMAP_DISPLAY_TYPE_VENC:
 	case OMAP_DISPLAY_TYPE_SDI:
 		bpp = 24;
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index dc170ad..f4a4ca9 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -112,7 +112,7 @@ static const enum omap_display_type omap4_dss_supported_displays[] = {
 	OMAP_DISPLAY_TYPE_DBI | OMAP_DISPLAY_TYPE_DSI,
 
 	/* OMAP_DSS_CHANNEL_DIGIT */
-	OMAP_DISPLAY_TYPE_VENC,
+	OMAP_DISPLAY_TYPE_VENC | OMAP_DISPLAY_TYPE_HDMI,
 
 	/* OMAP_DSS_CHANNEL_LCD2 */
 	OMAP_DISPLAY_TYPE_DPI | OMAP_DISPLAY_TYPE_DBI |
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 1f53bf2..bcd37ec 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -515,6 +515,8 @@ static int dss_mgr_wait_for_vsync(struct omap_overlay_manager *mgr)
 
 	if (mgr->device->type == OMAP_DISPLAY_TYPE_VENC) {
 		irq = DISPC_IRQ_EVSYNC_ODD;
+	} else if (mgr->device->type == OMAP_DISPLAY_TYPE_HDMI) {
+		irq = DISPC_IRQ_EVSYNC_EVEN;
 	} else {
 		if (mgr->id == OMAP_DSS_CHANNEL_LCD)
 			irq = DISPC_IRQ_VSYNC;
@@ -536,7 +538,8 @@ static int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr)
 	if (!dssdev || dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
 		return 0;
 
-	if (dssdev->type == OMAP_DISPLAY_TYPE_VENC) {
+	if (dssdev->type == OMAP_DISPLAY_TYPE_VENC
+			|| dssdev->type == OMAP_DISPLAY_TYPE_HDMI) {
 		irq = DISPC_IRQ_EVSYNC_ODD | DISPC_IRQ_EVSYNC_EVEN;
 	} else {
 		if (dssdev->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE) {
@@ -613,7 +616,8 @@ int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl)
 	if (!dssdev || dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
 		return 0;
 
-	if (dssdev->type == OMAP_DISPLAY_TYPE_VENC) {
+	if (dssdev->type == OMAP_DISPLAY_TYPE_VENC
+			|| dssdev->type == OMAP_DISPLAY_TYPE_HDMI) {
 		irq = DISPC_IRQ_EVSYNC_ODD | DISPC_IRQ_EVSYNC_EVEN;
 	} else {
 		if (dssdev->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE) {
@@ -1377,6 +1381,7 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 		case OMAP_DISPLAY_TYPE_DBI:
 		case OMAP_DISPLAY_TYPE_SDI:
 		case OMAP_DISPLAY_TYPE_VENC:
+		case OMAP_DISPLAY_TYPE_HDMI:
 			default_get_overlay_fifo_thresholds(ovl->id, size,
 					&oc->burst_size, &oc->fifo_low,
 					&oc->fifo_high);
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index 996e9a4..f1aca6d 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -679,7 +679,8 @@ void dss_recheck_connections(struct omap_dss_device *dssdev, bool force)
 			lcd2_mgr->set_device(lcd2_mgr, dssdev);
 			mgr = lcd2_mgr;
 		}
-	} else if (dssdev->type != OMAP_DISPLAY_TYPE_VENC) {
+	} else if (dssdev->type != OMAP_DISPLAY_TYPE_VENC
+			&& dssdev->type != OMAP_DISPLAY_TYPE_HDMI) {
 		if (!lcd_mgr->device || force) {
 			if (lcd_mgr->device)
 				lcd_mgr->unset_device(lcd_mgr);
@@ -688,7 +689,8 @@ void dss_recheck_connections(struct omap_dss_device *dssdev, bool force)
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

