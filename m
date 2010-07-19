From: Archit Taneja <archit@ti.com>
Subject: [PATCH 4/5] OMAP: DSS2: Video3 pipeline IRQs
Date: Mon, 19 Jul 2010 17:25:43 +0530
Message-ID: <1279540544-12682-5-git-send-email-archit@ti.com>
References: <1279540544-12682-1-git-send-email-archit@ti.com>
 <1279540544-12682-2-git-send-email-archit@ti.com>
 <1279540544-12682-3-git-send-email-archit@ti.com>
 <1279540544-12682-4-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46556 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760621Ab0GSL4I (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Jul 2010 07:56:08 -0400
In-Reply-To: <1279540544-12682-4-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Sumit Semwal <sumit.semwal@ti.com>, Mukund Mittal <mmittal@ti.com>, Archit Taneja <archit@ti.com>

From: Sumit Semwal <sumit.semwal@ti.com>

Introduce Video3 pipeline IRQS for dumps and error handling

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
Signed-off-by: Mukund Mittal <mmittal@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/plat-omap/include/plat/display.h |    2 ++
 drivers/video/omap2/dss/dispc.c           |   23 ++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletions(-)
 
diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index be83766..91796b6
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -44,6 +44,8 @@
 #define DISPC_IRQ_WAKEUP		(1 << 16)
 #define DISPC_IRQ_SYNC_LOST_2  (1 << 17)
 #define DISPC_IRQ_VSYNC2               (1 << 18)
+#define DISPC_IRQ_VID3_END_WIN		(1 << 19)
+#define DISPC_IRQ_VID3_FIFO_UNDERFLOW	(1 << 20)
 #define DISPC_IRQ_ACBIAS_COUNT_STAT2   (1 << 21)
 #define DISPC_IRQ_FRAMEDONE2           (1 << 22)
 
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 00aad04..8345ed7
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -173,7 +173,8 @@ struct dispc_reg { u16 idx; };
 					 DISPC_IRQ_SYNC_LOST | \
 					 DISPC_IRQ_SYNC_LOST_DIGIT | \
 					 (cpu_is_omap44xx() ? \
-					 DISPC_IRQ_SYNC_LOST_2 : 0))
+					 (DISPC_IRQ_VID3_FIFO_UNDERFLOW | \
+					 DISPC_IRQ_SYNC_LOST_2) : 0))
 
 #define DISPC_MAX_NR_ISRS		8
 
@@ -2540,6 +2541,8 @@ void dispc_dump_irqs(struct seq_file *s)
 		PIS(VSYNC2);
 		PIS(ACBIAS_COUNT_STAT2);
 		PIS(SYNC_LOST_2);
+		PIS(VID3_FIFO_UNDERFLOW);
+		PIS(VID3_END_WIN);
 	}
 #undef PIS
 }
@@ -3151,6 +3154,24 @@ static void dispc_error_worker(struct work_struct *work)
 		}
 	}
 
+	if (errors & DISPC_IRQ_VID3_FIFO_UNDERFLOW) {
+		DSSERR("VID3_FIFO_UNDERFLOW, disabling VID2\n");
+		for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
+			struct omap_overlay *ovl;
+			ovl = omap_dss_get_overlay(i);
+
+			if (!(ovl->caps & OMAP_DSS_OVL_CAP_DISPC))
+				continue;
+
+			if (ovl->id == 3) {
+				dispc_enable_plane(ovl->id, 0);
+				dispc_go(ovl->manager->id);
+				mdelay(50);
+				break;
+			}
+		}
+	}
+
 	if (errors & DISPC_IRQ_SYNC_LOST) {
 		struct omap_overlay_manager *manager = NULL;
 		bool enable = false;
-- 
1.5.4.7

