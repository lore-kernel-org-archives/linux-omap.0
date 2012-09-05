From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 16/17] OMAPDSS: Improve fifo management code
Date: Wed,  5 Sep 2012 11:25:54 +0300
Message-ID: <1346833555-31258-17-git-send-email-tomi.valkeinen@ti.com>
References: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:38255 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758190Ab2IEI0l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 04:26:41 -0400
Received: by lbbgj3 with SMTP id gj3so189986lbb.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Sep 2012 01:26:39 -0700 (PDT)
In-Reply-To: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

OMAP4+ allows assigning the overlay FIFOs freely, but that is not
supported by omapdss yet. This patch takes a step forward by improving
the fifo management to be more flexible.

dispc.c is changed to keep track of the sizes of each fifo, and also the
overlay using each fifo.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index e934abb..dc0f372 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -94,8 +94,11 @@ struct dispc_features {
 		u16 pos_x, unsigned long *core_clk);
 	unsigned long (*calc_core_clk) (enum omap_channel channel,
 		u16 width, u16 height, u16 out_width, u16 out_height);
+	u8 num_fifos;
 };
 
+#define DISPC_MAX_NR_FIFOS 5
+
 static struct {
 	struct platform_device *pdev;
 	void __iomem    *base;
@@ -105,7 +108,9 @@ static struct {
 	int irq;
 	struct clk *dss_clk;
 
-	u32	fifo_size[MAX_DSS_OVERLAYS];
+	u32 fifo_size[DISPC_MAX_NR_FIFOS];
+	/* maps which plane is using a fifo. fifo-id -> plane-id */
+	int fifo_assignment[DISPC_MAX_NR_FIFOS];
 
 	spinlock_t irq_lock;
 	u32 irq_error_mask;
@@ -1061,10 +1066,10 @@ static void dispc_mgr_set_size(enum omap_channel channel, u16 width,
 	dispc_write_reg(DISPC_SIZE_MGR(channel), val);
 }
 
-static void dispc_read_plane_fifo_sizes(void)
+static void dispc_init_fifos(void)
 {
 	u32 size;
-	int plane;
+	int fifo;
 	u8 start, end;
 	u32 unit;
 
@@ -1072,16 +1077,30 @@ static void dispc_read_plane_fifo_sizes(void)
 
 	dss_feat_get_reg_field(FEAT_REG_FIFOSIZE, &start, &end);
 
-	for (plane = 0; plane < dss_feat_get_num_ovls(); ++plane) {
-		size = REG_GET(DISPC_OVL_FIFO_SIZE_STATUS(plane), start, end);
+	for (fifo = 0; fifo < dispc.feat->num_fifos; ++fifo) {
+		size = REG_GET(DISPC_OVL_FIFO_SIZE_STATUS(fifo), start, end);
 		size *= unit;
-		dispc.fifo_size[plane] = size;
+		dispc.fifo_size[fifo] = size;
+
+		/*
+		 * By default fifos are mapped directly to overlays, fifo 0 to
+		 * ovl 0, fifo 1 to ovl 1, etc.
+		 */
+		dispc.fifo_assignment[fifo] = fifo;
 	}
 }
 
 static u32 dispc_ovl_get_fifo_size(enum omap_plane plane)
 {
-	return dispc.fifo_size[plane];
+	int fifo;
+	u32 size = 0;
+
+	for (fifo = 0; fifo < dispc.feat->num_fifos; ++fifo) {
+		if (dispc.fifo_assignment[fifo] == plane)
+			size += dispc.fifo_size[fifo];
+	}
+
+	return size;
 }
 
 void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high)
@@ -3708,7 +3727,7 @@ static void _omap_dispc_initial_config(void)
 
 	dispc_set_loadmode(OMAP_DSS_LOAD_FRAME_ONLY);
 
-	dispc_read_plane_fifo_sizes();
+	dispc_init_fifos();
 
 	dispc_configure_burst_sizes();
 
@@ -3724,6 +3743,7 @@ static const struct dispc_features omap24xx_dispc_feats __initconst = {
 	.hp_max			=	256,
 	.calc_scaling		=	dispc_ovl_calc_scaling_24xx,
 	.calc_core_clk		=	calc_core_clk_24xx,
+	.num_fifos		=	3,
 };
 
 static const struct dispc_features omap34xx_rev1_0_dispc_feats __initconst = {
@@ -3735,6 +3755,7 @@ static const struct dispc_features omap34xx_rev1_0_dispc_feats __initconst = {
 	.hp_max			=	256,
 	.calc_scaling		=	dispc_ovl_calc_scaling_34xx,
 	.calc_core_clk		=	calc_core_clk_34xx,
+	.num_fifos		=	3,
 };
 
 static const struct dispc_features omap34xx_rev3_0_dispc_feats __initconst = {
@@ -3746,6 +3767,7 @@ static const struct dispc_features omap34xx_rev3_0_dispc_feats __initconst = {
 	.hp_max			=	4096,
 	.calc_scaling		=	dispc_ovl_calc_scaling_34xx,
 	.calc_core_clk		=	calc_core_clk_34xx,
+	.num_fifos		=	3,
 };
 
 static const struct dispc_features omap44xx_dispc_feats __initconst = {
@@ -3757,6 +3779,7 @@ static const struct dispc_features omap44xx_dispc_feats __initconst = {
 	.hp_max			=	4096,
 	.calc_scaling		=	dispc_ovl_calc_scaling_44xx,
 	.calc_core_clk		=	calc_core_clk_44xx,
+	.num_fifos		=	5,
 };
 
 static int __init dispc_init_features(struct device *dev)
-- 
1.7.9.5

