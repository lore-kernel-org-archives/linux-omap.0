From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 09/32] OMAPDSS: DISPC: pclk & lclk rates for writeback
Date: Thu, 15 Nov 2012 17:58:17 +0200
Message-ID: <1352995120-3288-10-git-send-email-tomi.valkeinen@ti.com>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52170 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768125Ab2KOP7X (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 10:59:23 -0500
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Change the dispc_plane_pclk_rate and dispc_plane_lclk_rate functions to
return 0 if the given plane is the writeback plane. The clocks are not
valid for WB, but returning 0 from these functions instead of running
into BUG() will simplify the code that uses these functions.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index e219eda..8f8d628 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3226,14 +3226,24 @@ unsigned long dispc_core_clk_rate(void)
 
 static unsigned long dispc_plane_pclk_rate(enum omap_plane plane)
 {
-	enum omap_channel channel = dispc_ovl_get_channel_out(plane);
+	enum omap_channel channel;
+
+	if (plane == OMAP_DSS_WB)
+		return 0;
+
+	channel = dispc_ovl_get_channel_out(plane);
 
 	return dispc_mgr_pclk_rate(channel);
 }
 
 static unsigned long dispc_plane_lclk_rate(enum omap_plane plane)
 {
-	enum omap_channel channel = dispc_ovl_get_channel_out(plane);
+	enum omap_channel channel;
+
+	if (plane == OMAP_DSS_WB)
+		return 0;
+
+	channel	= dispc_ovl_get_channel_out(plane);
 
 	return dispc_mgr_lclk_rate(channel);
 }
-- 
1.7.10.4

