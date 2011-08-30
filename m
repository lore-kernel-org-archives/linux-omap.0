From: Archit Taneja <archit@ti.com>
Subject: [PATCH 03/10] OMAP: DSS2: Create enum for DSI operation modes
Date: Tue, 30 Aug 2011 16:21:28 +0530
Message-ID: <1314701495-11247-4-git-send-email-archit@ti.com>
References: <1314701495-11247-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42690 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006Ab1H3KxS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Aug 2011 06:53:18 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p7UArHk3000738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 05:53:17 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id p7UArHwc004782
	for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 05:53:17 -0500 (CDT)
Received: from DLEE74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7UArHtM025114
	for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 05:53:17 -0500 (CDT)
In-Reply-To: <1314701495-11247-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Create an enum for DSI operation modes, use this to set the capabilities of the
device in dsi_init_display().

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dsi.c |    7 ++++---
 include/video/omapdss.h       |    7 +++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index bdc2c9d..d3bffe8 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4123,9 +4123,10 @@ int dsi_init_display(struct omap_dss_device *dssdev)
 
 	DSSDBG("DSI init\n");
 
-	/* XXX these should be figured out dynamically */
-	dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE |
-		OMAP_DSS_DISPLAY_CAP_TEAR_ELIM;
+	if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_CMD_MODE) {
+		dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE |
+			OMAP_DSS_DISPLAY_CAP_TEAR_ELIM;
+	}
 
 	if (dsi->vdds_dsi_reg == NULL) {
 		struct regulator *vdds_dsi;
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 9398dd3..2babe7e 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -129,6 +129,11 @@ enum omap_dss_venc_type {
 	OMAP_DSS_VENC_TYPE_SVIDEO,
 };
 
+enum omap_dss_dsi_mode {
+	OMAP_DSS_DSI_CMD_MODE = 0,
+	OMAP_DSS_DSI_VIDEO_MODE,
+};
+
 enum omap_display_caps {
 	OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE	= 1 << 0,
 	OMAP_DSS_DISPLAY_CAP_TEAR_ELIM		= 1 << 1,
@@ -473,6 +478,8 @@ struct omap_dss_device {
 		int acb;	/* ac-bias pin frequency */
 
 		enum omap_panel_config config;
+
+		enum omap_dss_dsi_mode dsi_mode;
 	} panel;
 
 	struct {
-- 
1.7.1

