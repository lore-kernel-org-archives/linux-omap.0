From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 4/6] OMAPDSS: DISPC: print fifo threshold values in bytes
Date: Fri, 13 Jan 2012 13:46:31 +0200
Message-ID: <1326455193-19716-5-git-send-email-tomi.valkeinen@ti.com>
References: <1326455193-19716-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:49049 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757967Ab2AMLqu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jan 2012 06:46:50 -0500
In-Reply-To: <1326455193-19716-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, rob@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Fifo thresholds are calculated using bytes, but the debug print prints
values in buffer units. Change the prints to use bytes to be in line
with the calculations, and also to print in the same units on all OMAPs.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index d711518..ba907bd 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1039,13 +1039,13 @@ void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high)
 	dss_feat_get_reg_field(FEAT_REG_FIFOHIGHTHRESHOLD, &hi_start, &hi_end);
 	dss_feat_get_reg_field(FEAT_REG_FIFOLOWTHRESHOLD, &lo_start, &lo_end);
 
-	DSSDBG("fifo(%d) low/high old %u/%u, new %u/%u\n",
+	DSSDBG("fifo(%d) threshold (bytes), old %u/%u, new %u/%u\n",
 			plane,
 			REG_GET(DISPC_OVL_FIFO_THRESHOLD(plane),
-				lo_start, lo_end),
+				lo_start, lo_end) * unit,
 			REG_GET(DISPC_OVL_FIFO_THRESHOLD(plane),
-				hi_start, hi_end),
-			low, high);
+				hi_start, hi_end) * unit,
+			low * unit, high * unit);
 
 	dispc_write_reg(DISPC_OVL_FIFO_THRESHOLD(plane),
 			FLD_VAL(high, hi_start, hi_end) |
-- 
1.7.4.1

