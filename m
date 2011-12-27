From: Archit Taneja <archit@ti.com>
Subject: [RFC PATCH 20/29] OMAPDSS: Writeback: Add writeback capabilities
Date: Tue, 27 Dec 2011 18:07:03 +0530
Message-ID: <1324989432-3625-21-git-send-email-archit@ti.com>
References: <1324989432-3625-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52239 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753752Ab1L0Mjs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Dec 2011 07:39:48 -0500
In-Reply-To: <1324989432-3625-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rohitkc@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Add a capabilities parameter of type omap_overlay_caps to omap_dss_writeback.
These caps let us reuse some of the DISPC overlay functions. Set the
capabilities so the writeback supports scaling and pre multiplied alpha.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/writeback.c |    3 +++
 include/video/omapdss.h             |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/writeback.c b/drivers/video/omap2/dss/writeback.c
index 540e61d..14103bf 100644
--- a/drivers/video/omap2/dss/writeback.c
+++ b/drivers/video/omap2/dss/writeback.c
@@ -90,6 +90,9 @@ void dss_init_writeback(void)
 		wb->id = i;
 		wb->plane_id = OMAP_DSS_WB + i;
 
+		wb->caps = OMAP_DSS_OVL_CAP_SCALE |
+				OMAP_DSS_OVL_CAP_PRE_MULT_ALPHA;
+
 		wb->set_wb_info = &dss_wb_set_info;
 		wb->get_wb_info = &dss_wb_get_info;
 	}
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 49e3ccb..291457c 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -493,6 +493,9 @@ struct omap_dss_writeback {
 	int id;
 	int plane_id;
 
+	/* overlay-like capabilities writeback supports */
+	enum omap_overlay_caps caps;
+
 	/* dummy panel we are connected to */
 	struct omap_dss_device *dssdev;
 
-- 
1.7.4.1

