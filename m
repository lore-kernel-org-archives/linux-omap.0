From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 60/65] OMAPDSS: Add comments about blocking of ovl/mgr functions
Date: Tue, 22 Nov 2011 11:21:59 +0200
Message-ID: <1321953724-6350-61-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:48359 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758216Ab1KVJYs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:24:48 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add comments specifying what ovl/mgr functions may block.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 include/video/omapdss.h |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 98fc026..39862b8 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -384,6 +384,17 @@ struct omap_overlay {
 	/* dynamic fields */
 	struct omap_overlay_manager *manager;
 
+	/*
+	 * The following functions do not block:
+	 *
+	 * is_enabled
+	 * set_overlay_info
+	 * get_overlay_info
+	 *
+	 * The rest of the functions may block and cannot be called from
+	 * interrupt context
+	 */
+
 	int (*enable)(struct omap_overlay *ovl);
 	int (*disable)(struct omap_overlay *ovl);
 	bool (*is_enabled)(struct omap_overlay *ovl);
@@ -426,6 +437,17 @@ struct omap_overlay_manager {
 	/* dynamic fields */
 	struct omap_dss_device *device;
 
+	/*
+	 * The following functions do not block:
+	 *
+	 * set_manager_info
+	 * get_manager_info
+	 * apply
+	 *
+	 * The rest of the functions may block and cannot be called from
+	 * interrupt context
+	 */
+
 	int (*set_device)(struct omap_overlay_manager *mgr,
 		struct omap_dss_device *dssdev);
 	int (*unset_device)(struct omap_overlay_manager *mgr);
-- 
1.7.4.1

