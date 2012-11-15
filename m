From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 04/32] OMAPDSS: DISPC: add no_framedone_tv feat
Date: Thu, 15 Nov 2012 17:58:12 +0200
Message-ID: <1352995120-3288-5-git-send-email-tomi.valkeinen@ti.com>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52160 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768185Ab2KOP7P (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 10:59:15 -0500
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

OMAP2/3 do not have FRAMEDONETV irq, but later omaps do. We currently
always return 0 from dispc_mgr_get_framedone_irq() for TV output to be
compatible with OMAP2/3.

This patch implements "no_framedone_tv" dispc-feature that is used in
dispc_mgr_get_framedone_irq to return either 0 for OMAP2/3, or the
correct IRQ number for FRAMEDONETV on OMAP4+.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 170c98c..2ec6470 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -100,6 +100,9 @@ struct dispc_features {
 
 	/* swap GFX & WB fifos */
 	bool gfx_fifo_workaround:1;
+
+	/* no DISPC_IRQ_FRAMEDONETV on this SoC */
+	bool no_framedone_tv:1;
 };
 
 #define DISPC_MAX_NR_FIFOS 5
@@ -187,7 +190,7 @@ static const struct {
 	[OMAP_DSS_CHANNEL_DIGIT] = {
 		.name		= "DIGIT",
 		.vsync_irq	= DISPC_IRQ_EVSYNC_ODD | DISPC_IRQ_EVSYNC_EVEN,
-		.framedone_irq	= 0,
+		.framedone_irq	= DISPC_IRQ_FRAMEDONETV,
 		.sync_lost_irq	= DISPC_IRQ_SYNC_LOST_DIGIT,
 		.reg_desc	= {
 			[DISPC_MGR_FLD_ENABLE]		= { DISPC_CONTROL,  1,  1 },
@@ -539,6 +542,9 @@ u32 dispc_mgr_get_vsync_irq(enum omap_channel channel)
 
 u32 dispc_mgr_get_framedone_irq(enum omap_channel channel)
 {
+	if (channel == OMAP_DSS_CHANNEL_DIGIT && dispc.feat->no_framedone_tv)
+		return 0;
+
 	return mgr_desc[channel].framedone_irq;
 }
 
@@ -4085,6 +4091,7 @@ static const struct dispc_features omap24xx_dispc_feats __initconst = {
 	.calc_scaling		=	dispc_ovl_calc_scaling_24xx,
 	.calc_core_clk		=	calc_core_clk_24xx,
 	.num_fifos		=	3,
+	.no_framedone_tv	=	true,
 };
 
 static const struct dispc_features omap34xx_rev1_0_dispc_feats __initconst = {
@@ -4097,6 +4104,7 @@ static const struct dispc_features omap34xx_rev1_0_dispc_feats __initconst = {
 	.calc_scaling		=	dispc_ovl_calc_scaling_34xx,
 	.calc_core_clk		=	calc_core_clk_34xx,
 	.num_fifos		=	3,
+	.no_framedone_tv	=	true,
 };
 
 static const struct dispc_features omap34xx_rev3_0_dispc_feats __initconst = {
@@ -4109,6 +4117,7 @@ static const struct dispc_features omap34xx_rev3_0_dispc_feats __initconst = {
 	.calc_scaling		=	dispc_ovl_calc_scaling_34xx,
 	.calc_core_clk		=	calc_core_clk_34xx,
 	.num_fifos		=	3,
+	.no_framedone_tv	=	true,
 };
 
 static const struct dispc_features omap44xx_dispc_feats __initconst = {
-- 
1.7.10.4

