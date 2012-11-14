From: Archit Taneja <archit@ti.com>
Subject: [PATCH 2/2] OMAPDSS: Add a dispc_features struct for OMAP5
Date: Wed, 14 Nov 2012 13:50:16 +0530
Message-ID: <1352881216-7490-3-git-send-email-archit@ti.com>
References: <1352881216-7490-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38011 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932187Ab2KNIUs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 03:20:48 -0500
In-Reply-To: <1352881216-7490-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Add a dispc_features struct for OMAP5. Previously, OMAP5 used the same struct
as OMAP4. The new struct for OMAP5 contains the updated register field offset
and maximum limit for overlay manager width and height.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 29e6aa1..c681460 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -4131,6 +4131,23 @@ static const struct dispc_features omap44xx_dispc_feats __initconst = {
 	.gfx_fifo_workaround	=	true,
 };
 
+static const struct dispc_features omap54xx_dispc_feats __initconst = {
+	.sw_start		=	7,
+	.fp_start		=	19,
+	.bp_start		=	31,
+	.sw_max			=	256,
+	.vp_max			=	4095,
+	.hp_max			=	4096,
+	.mgr_width_start	=	11,
+	.mgr_height_start	=	27,
+	.mgr_width_max		=	4096,
+	.mgr_height_max		=	4096,
+	.calc_scaling		=	dispc_ovl_calc_scaling_44xx,
+	.calc_core_clk		=	calc_core_clk_44xx,
+	.num_fifos		=	5,
+	.gfx_fifo_workaround	=	true,
+};
+
 static int __init dispc_init_features(struct platform_device *pdev)
 {
 	const struct dispc_features *src;
@@ -4164,7 +4181,7 @@ static int __init dispc_init_features(struct platform_device *pdev)
 		break;
 
 	case OMAPDSS_VER_OMAP5:
-		src = &omap44xx_dispc_feats;
+		src = &omap54xx_dispc_feats;
 		break;
 
 	default:
-- 
1.7.9.5

