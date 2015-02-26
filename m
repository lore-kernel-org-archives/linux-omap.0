From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 11/15] OMAPDSS: setup default fifo thresholds
Date: Thu, 26 Feb 2015 14:49:05 +0200
Message-ID: <1424954949-12801-11-git-send-email-tomi.valkeinen@ti.com>
References: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37398 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932213AbbBZMtr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2015 07:49:47 -0500
In-Reply-To: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

At the moment we don't setup FIFO thresholds by default in omapdss. It's
supposed to be done by the user of omapdss. And that is missing from
omapdrm, causing unoptimal thresholds to be used when using omapdrm.

While I believe it's in theory better to allow the user of omapdss to
setup the fifo thresholds, in practice we always use the same values,
and we could as well setup the thresholds in omapdss.

Furthermore, in omapdss init we always swap the FIFO used for GFX and WB
overlays, but we don't swap the FIFO thresholds for those overlays
(which is the reason for omapdrm using unoptimal HW reset values). So
it would make sense to setup the thresholds to account for the swapping
of the FIFOs.

So, this patch adds code to setup default FIFO tresholds at omapdss
init.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index 766c985cbfa7..6296a3e5124f 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -1138,6 +1138,7 @@ static void dispc_init_fifos(void)
 	int fifo;
 	u8 start, end;
 	u32 unit;
+	int i;
 
 	unit = dss_feat_get_buffer_size_unit();
 
@@ -1177,6 +1178,20 @@ static void dispc_init_fifos(void)
 		dispc.fifo_assignment[OMAP_DSS_GFX] = OMAP_DSS_WB;
 		dispc.fifo_assignment[OMAP_DSS_WB] = OMAP_DSS_GFX;
 	}
+
+	/*
+	 * Setup default fifo thresholds.
+	 */
+	for (i = 0; i < dss_feat_get_num_ovls(); ++i) {
+		u32 low, high;
+		const bool use_fifomerge = false;
+		const bool manual_update = false;
+
+		dispc_ovl_compute_fifo_thresholds(i, &low, &high,
+			use_fifomerge, manual_update);
+
+		dispc_ovl_set_fifo_threshold(i, low, high);
+	}
 }
 
 static u32 dispc_ovl_get_fifo_size(enum omap_plane plane)
-- 
2.3.0

