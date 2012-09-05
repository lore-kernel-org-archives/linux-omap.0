From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 17/17] OMAPDSS: Use WB fifo for GFX overlay
Date: Wed,  5 Sep 2012 11:25:55 +0300
Message-ID: <1346833555-31258-18-git-send-email-tomi.valkeinen@ti.com>
References: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:58817 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758190Ab2IEI0y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 04:26:54 -0400
Received: by lagy9 with SMTP id y9so139512lag.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Sep 2012 01:26:41 -0700 (PDT)
In-Reply-To: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

OMAP4's GFX overlay has smaller fifo than the rest of the overlays
(including writeback "overlay"). This seems to be the reason for
underflows in some more demanding scenarios.

We can avoid the problems by using the WB fifo for GFX overlay, and vice
versa. WB usage is not supported yet, but when it will, it should
perform just fine with smaller fifo as there are no hard realtime
constraints with WB.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   27 +++++++++++++++++++++++++++
 drivers/video/omap2/dss/dispc.h |    4 ++++
 include/video/omapdss.h         |    1 +
 3 files changed, 32 insertions(+)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index dc0f372..d512c38 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -95,6 +95,9 @@ struct dispc_features {
 	unsigned long (*calc_core_clk) (enum omap_channel channel,
 		u16 width, u16 height, u16 out_width, u16 out_height);
 	u8 num_fifos;
+
+	/* swap GFX & WB fifos */
+	bool gfx_fifo_workaround:1;
 };
 
 #define DISPC_MAX_NR_FIFOS 5
@@ -1088,6 +1091,29 @@ static void dispc_init_fifos(void)
 		 */
 		dispc.fifo_assignment[fifo] = fifo;
 	}
+
+	/*
+	 * The GFX fifo on OMAP4 is smaller than the other fifos. The small fifo
+	 * causes problems with certain use cases, like using the tiler in 2D
+	 * mode. The below hack swaps the fifos of GFX and WB planes, thus
+	 * giving GFX plane a larger fifo. WB but should work fine with a
+	 * smaller fifo.
+	 */
+	if (dispc.feat->gfx_fifo_workaround) {
+		u32 v;
+
+		v = dispc_read_reg(DISPC_GLOBAL_BUFFER);
+
+		v = FLD_MOD(v, 4, 2, 0); /* GFX BUF top to WB */
+		v = FLD_MOD(v, 4, 5, 3); /* GFX BUF bottom to WB */
+		v = FLD_MOD(v, 0, 26, 24); /* WB BUF top to GFX */
+		v = FLD_MOD(v, 0, 29, 27); /* WB BUF bottom to GFX */
+
+		dispc_write_reg(DISPC_GLOBAL_BUFFER, v);
+
+		dispc.fifo_assignment[OMAP_DSS_GFX] = OMAP_DSS_WB;
+		dispc.fifo_assignment[OMAP_DSS_WB] = OMAP_DSS_GFX;
+	}
 }
 
 static u32 dispc_ovl_get_fifo_size(enum omap_plane plane)
@@ -3780,6 +3806,7 @@ static const struct dispc_features omap44xx_dispc_feats __initconst = {
 	.calc_scaling		=	dispc_ovl_calc_scaling_44xx,
 	.calc_core_clk		=	calc_core_clk_44xx,
 	.num_fifos		=	5,
+	.gfx_fifo_workaround	=	true,
 };
 
 static int __init dispc_init_features(struct device *dev)
diff --git a/drivers/video/omap2/dss/dispc.h b/drivers/video/omap2/dss/dispc.h
index 92d8a9b..42e56cc 100644
--- a/drivers/video/omap2/dss/dispc.h
+++ b/drivers/video/omap2/dss/dispc.h
@@ -36,6 +36,7 @@
 #define DISPC_CONTROL2			0x0238
 #define DISPC_CONFIG2			0x0620
 #define DISPC_DIVISOR			0x0804
+#define DISPC_GLOBAL_BUFFER		0x0800
 #define DISPC_CONTROL3                  0x0848
 #define DISPC_CONFIG3                   0x084C
 
@@ -355,6 +356,8 @@ static inline u16 DISPC_OVL_BASE(enum omap_plane plane)
 		return 0x014C;
 	case OMAP_DSS_VIDEO3:
 		return 0x0300;
+	case OMAP_DSS_WB:
+		return 0x0500;
 	default:
 		BUG();
 		return 0;
@@ -517,6 +520,7 @@ static inline u16 DISPC_FIFO_SIZE_STATUS_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO2:
 		return 0x0018;
 	case OMAP_DSS_VIDEO3:
+	case OMAP_DSS_WB:
 		return 0x0088;
 	default:
 		BUG();
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 24a7fa1..ac2e4cc 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -73,6 +73,7 @@ enum omap_plane {
 	OMAP_DSS_VIDEO1	= 1,
 	OMAP_DSS_VIDEO2	= 2,
 	OMAP_DSS_VIDEO3	= 3,
+	OMAP_DSS_WB	= 4,
 };
 
 enum omap_channel {
-- 
1.7.9.5

