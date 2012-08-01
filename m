From: Archit Taneja <archit@ti.com>
Subject: [RFC 01/17] OMAPDSS: APPLY: Constify timings argument in dss_mgr_set_timings
Date: Wed, 1 Aug 2012 16:01:12 +0530
Message-ID: <1343817088-29645-2-git-send-email-archit@ti.com>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43778 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751793Ab2HAKc5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Aug 2012 06:32:57 -0400
In-Reply-To: <1343817088-29645-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, sumit.semwal@ti.com, rob@ti.com, Archit Taneja <archit@ti.com>

The function dss_mgr_set_timings is supposed to apply timings passed by an
interface driver. It is not supposed to change the timings. Add const qualifier
to the omap_video_timings pointer argument in dss_mgr_set_timings().

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c |    4 ++--
 drivers/video/omap2/dss/dss.h   |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 0fefc68..52a5940 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -1302,7 +1302,7 @@ err:
 }
 
 static void dss_apply_mgr_timings(struct omap_overlay_manager *mgr,
-		struct omap_video_timings *timings)
+		const struct omap_video_timings *timings)
 {
 	struct mgr_priv_data *mp = get_mgr_priv(mgr);
 
@@ -1311,7 +1311,7 @@ static void dss_apply_mgr_timings(struct omap_overlay_manager *mgr,
 }
 
 void dss_mgr_set_timings(struct omap_overlay_manager *mgr,
-		struct omap_video_timings *timings)
+		const struct omap_video_timings *timings)
 {
 	unsigned long flags;
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 335ee93..8a9630b 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -207,7 +207,7 @@ int dss_mgr_set_device(struct omap_overlay_manager *mgr,
 		struct omap_dss_device *dssdev);
 int dss_mgr_unset_device(struct omap_overlay_manager *mgr);
 void dss_mgr_set_timings(struct omap_overlay_manager *mgr,
-		struct omap_video_timings *timings);
+		const struct omap_video_timings *timings);
 void dss_mgr_set_lcd_config(struct omap_overlay_manager *mgr,
 		const struct dss_lcd_mgr_config *config);
 const struct omap_video_timings *dss_mgr_get_timings(struct omap_overlay_manager *mgr);
-- 
1.7.9.5

