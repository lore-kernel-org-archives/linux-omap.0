From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 5/9] OMAPDSS: remove declarations for non-existing funcs
Date: Wed, 17 Oct 2012 14:20:31 +0300
Message-ID: <1350472835-28727-6-git-send-email-tomi.valkeinen@ti.com>
References: <1350472835-28727-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59179 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756300Ab2JQLUr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Oct 2012 07:20:47 -0400
In-Reply-To: <1350472835-28727-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

dss_mgr_set_device and dss_mgr_unset_device are declared in dss.h, but
the functions do not exist. Remove the declarations.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.h |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 8447871..373847c 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -217,9 +217,6 @@ int dss_mgr_set_info(struct omap_overlay_manager *mgr,
 		struct omap_overlay_manager_info *info);
 void dss_mgr_get_info(struct omap_overlay_manager *mgr,
 		struct omap_overlay_manager_info *info);
-int dss_mgr_set_device(struct omap_overlay_manager *mgr,
-		struct omap_dss_device *dssdev);
-int dss_mgr_unset_device(struct omap_overlay_manager *mgr);
 int dss_mgr_set_output(struct omap_overlay_manager *mgr,
 		struct omap_dss_output *output);
 int dss_mgr_unset_output(struct omap_overlay_manager *mgr);
-- 
1.7.9.5

