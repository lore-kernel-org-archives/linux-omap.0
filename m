From: Archit Taneja <archit@ti.com>
Subject: [PATCH 13/21] OMAPDSS: DISPC: Pass dummy scalar output rates for writeback pipeline
Date: Thu, 13 Sep 2012 17:44:57 +0530
Message-ID: <1347538505-25359-14-git-send-email-archit@ti.com>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52140 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757956Ab2IMMPm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Sep 2012 08:15:42 -0400
In-Reply-To: <1347538505-25359-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The scalar output rate for writeback pipeline when configured in memory to
memory mode isn't a fixed rate, it can increase or reduce based on the time
it needs to downscale. It also depends on the rate at which it can receive
and push out data from/to the interconnect.

Set the scalar output rates for writeback to a low dummy value(set to 1) to
represent that it can output at low rates, this is done so that maximum
downscaling is possible in memory to memory mode.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 8673a33..1d5dddf 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3011,21 +3011,30 @@ unsigned long dispc_core_clk_rate(void)
 
 static unsigned long dispc_plane_output_rate(enum omap_plane plane)
 {
-	enum omap_channel channel = dispc_ovl_get_channel_out(plane);
+	if (plane != OMAP_DSS_WB) {
+		enum omap_channel channel = dispc_ovl_get_channel_out(plane);
 
-	return dispc_mgr_pclk_rate(channel);
+		return dispc_mgr_pclk_rate(channel);
+	} else {
+		return 1;
+	}
 }
 
 static unsigned long dispc_plane_lclk_rate(enum omap_plane plane)
 {
-	enum omap_channel channel = dispc_ovl_get_channel_out(plane);
 
-	if (dss_mgr_is_lcd(channel))
-		return dispc_mgr_lclk_rate(channel);
-	else
-		return dispc_fclk_rate();
+	if (plane != OMAP_DSS_WB) {
+		enum omap_channel channel = dispc_ovl_get_channel_out(plane);
 
+		if (dss_mgr_is_lcd(channel))
+			return dispc_mgr_lclk_rate(channel);
+		else
+			return dispc_fclk_rate();
+	} else {
+		return 1;
+	}
 }
+
 static void dispc_dump_clocks_channel(struct seq_file *s, enum omap_channel channel)
 {
 	int lcd, pcd;
-- 
1.7.9.5

