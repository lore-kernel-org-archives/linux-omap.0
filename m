From: Archit Taneja <archit@ti.com>
Subject: [PATCH 19/21] OMAPDSS: DISPC: Configure writeback FIFOs
Date: Thu, 13 Sep 2012 17:45:03 +0530
Message-ID: <1347538505-25359-20-git-send-email-archit@ti.com>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43624 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757976Ab2IMMQA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Sep 2012 08:16:00 -0400
In-Reply-To: <1347538505-25359-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Extend the DISPC fifo functions to also configure the writeback FIFO thresholds.

The most optimal configuration for writeback is to push out data to the
interconnect the moment writeback pushes enough pixels in the FIFO to form a
burst. This reduces the chance of writeback overflowing it's FIFO.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index a44cbac..6068271 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -997,7 +997,7 @@ void dispc_wb_set_channel_in(enum dss_writeback_channel channel)
 static void dispc_plane_set_burst_size(enum omap_plane plane,
 		enum omap_burst_size burst_size)
 {
-	static const unsigned shifts[] = { 6, 14, 14, 14, };
+	static const unsigned shifts[] = { 6, 14, 14, 14, 14, };
 	int shift;
 
 	shift = shifts[plane];
@@ -1229,6 +1229,14 @@ void dispc_plane_compute_fifo_thresholds(enum omap_plane plane,
 	if (manual_update && dss_has_feature(FEAT_OMAP3_DSI_FIFO_BUG)) {
 		*fifo_low = plane_fifo_size - burst_size * 2;
 		*fifo_high = total_fifo_size - burst_size;
+	} else if (plane == OMAP_DSS_WB) {
+		/*
+		 * Most optimal configuration for writeback is to push out data
+		 * to the interconnect the moment writeback pushes enough pixels
+		 * in the FIFO to form a burst
+		 */
+		*fifo_low = 0;
+		*fifo_high = burst_size;
 	} else {
 		*fifo_low = plane_fifo_size - burst_size;
 		*fifo_high = total_fifo_size - buf_unit;
-- 
1.7.9.5

