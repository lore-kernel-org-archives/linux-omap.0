From: Archit Taneja <archit@ti.com>
Subject: [PATCH 12/21] OMAPDSS: DISPC: Configure input and output sizes for writeback
Date: Thu, 13 Sep 2012 17:44:56 +0530
Message-ID: <1347538505-25359-13-git-send-email-archit@ti.com>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43605 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757923Ab2IMMPj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Sep 2012 08:15:39 -0400
In-Reply-To: <1347538505-25359-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Writeback uses the WB_PICTURE_SIZE register to define the size of the content
written to memory, this is the output of the scalar. It uses the WB_SIZE
register to define the size of the content coming from the overlay/manager to
which it is connected, this is the input to the scalar. This naming is different
as compared to overlays.

Add checks for writeback in dispc_plane_set_input_size() and
dispc_plane_set_output_size() to write to the correct registers.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 60a60fc..8673a33 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -723,7 +723,7 @@ static void dispc_plane_set_input_size(enum omap_plane plane, int width,
 {
 	u32 val = FLD_VAL(height - 1, 26, 16) | FLD_VAL(width - 1, 10, 0);
 
-	if (plane == OMAP_DSS_GFX)
+	if (plane == OMAP_DSS_GFX || plane == OMAP_DSS_WB)
 		dispc_write_reg(DISPC_OVL_SIZE(plane), val);
 	else
 		dispc_write_reg(DISPC_OVL_PICTURE_SIZE(plane), val);
@@ -738,7 +738,10 @@ static void dispc_plane_set_output_size(enum omap_plane plane, int width,
 
 	val = FLD_VAL(height - 1, 26, 16) | FLD_VAL(width - 1, 10, 0);
 
-	dispc_write_reg(DISPC_OVL_SIZE(plane), val);
+	if (plane == OMAP_DSS_WB)
+		dispc_write_reg(DISPC_OVL_PICTURE_SIZE(plane), val);
+	else
+		dispc_write_reg(DISPC_OVL_SIZE(plane), val);
 }
 
 static void dispc_plane_set_zorder(enum omap_plane plane,
-- 
1.7.9.5

