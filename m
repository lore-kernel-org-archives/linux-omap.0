From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/4] OMAPDSS: fix missing EXPORT_SYMBOL()s
Date: Mon, 18 Nov 2013 14:44:06 +0200
Message-ID: <1384778649-9396-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45203 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750731Ab3KRMoS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Nov 2013 07:44:18 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Functions dispc_ovl_set_fifo_threshold and
dispc_ovl_compute_fifo_thresholds need to be exported. Add the
EXPORT_SYMBOLs.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 91c687f..aa95ba5 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1201,6 +1201,7 @@ void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high)
 			FLD_VAL(high, hi_start, hi_end) |
 			FLD_VAL(low, lo_start, lo_end));
 }
+EXPORT_SYMBOL(dispc_ovl_set_fifo_threshold);
 
 void dispc_enable_fifomerge(bool enable)
 {
@@ -1259,6 +1260,7 @@ void dispc_ovl_compute_fifo_thresholds(enum omap_plane plane,
 		*fifo_high = total_fifo_size - buf_unit;
 	}
 }
+EXPORT_SYMBOL(dispc_ovl_compute_fifo_thresholds);
 
 static void dispc_ovl_set_fir(enum omap_plane plane,
 				int hinc, int vinc,
-- 
1.8.3.2

