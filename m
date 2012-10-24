From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 06/20] OMAPDSS: DISPC: use dss_feat_get_num_ovls()
Date: Wed, 24 Oct 2012 12:28:57 +0300
Message-ID: <1351070951-18616-7-git-send-email-tomi.valkeinen@ti.com>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47949 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932150Ab2JXJ3f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Oct 2012 05:29:35 -0400
In-Reply-To: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Use dss_feat_get_num_ovls() in dispc.c instead of
omap_dss_get_num_overlays() to remove the dependency to overlay.c. Note
that we still have uses of omap_dss_get_num_overlays() in dispc.c, but
these will be moved out in the future patches.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 198e321..392445a 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1046,7 +1046,7 @@ static void dispc_configure_burst_sizes(void)
 	const int burst_size = BURST_SIZE_X8;
 
 	/* Configure burst size always to maximum size */
-	for (i = 0; i < omap_dss_get_num_overlays(); ++i)
+	for (i = 0; i < dss_feat_get_num_ovls(); ++i)
 		dispc_ovl_set_burst_size(i, burst_size);
 }
 
@@ -1250,7 +1250,7 @@ void dispc_ovl_compute_fifo_thresholds(enum omap_plane plane,
 
 	if (use_fifomerge) {
 		total_fifo_size = 0;
-		for (i = 0; i < omap_dss_get_num_overlays(); ++i)
+		for (i = 0; i < dss_feat_get_num_ovls(); ++i)
 			total_fifo_size += dispc_ovl_get_fifo_size(i);
 	} else {
 		total_fifo_size = ovl_fifo_size;
-- 
1.7.9.5

