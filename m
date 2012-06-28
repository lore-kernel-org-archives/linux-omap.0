From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH 4/4] OMAPDSS: Add dump and debug support for LCD3
Date: Thu, 28 Jun 2012 15:11:42 +0530
Message-ID: <48752654ac49d86b04c320f0d07f0a33b908dcbf.1340874806.git.cmahapatra@ti.com>
References: <cover.1340874806.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46127 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932436Ab2F1Jls (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 05:41:48 -0400
In-Reply-To: <cover.1340874806.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

DISPC functions have been modified to provide clock and register dumps and debug
support for the LCD3 manager.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   70 ++++++++++++++++++++++----------------
 1 files changed, 40 insertions(+), 30 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 644ff53..29b92ea 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2854,12 +2854,32 @@ unsigned long dispc_core_clk_rate(void)
 	return fclk / lcd;
 }
 
-void dispc_dump_clocks(struct seq_file *s)
+void dispc_dump_clocks_channel(struct seq_file *s, enum omap_channel channel)
 {
 	int lcd, pcd;
+	enum omap_dss_clk_source lcd_clk_src;
+
+	seq_printf(s, "- %s -\n", mgr_desc[channel].name);
+
+	lcd_clk_src = dss_get_lcd_clk_source(channel);
+
+	seq_printf(s, "%s clk source = %s (%s)\n", mgr_desc[channel].name,
+		dss_get_generic_clk_source_name(lcd_clk_src),
+		dss_feat_get_clk_source_name(lcd_clk_src));
+
+	dispc_mgr_get_lcd_divisor(channel, &lcd, &pcd);
+
+	seq_printf(s, "lck\t\t%-16lulck div\t%u\n",
+		dispc_mgr_lclk_rate(channel), lcd);
+	seq_printf(s, "pck\t\t%-16lupck div\t%u\n",
+		dispc_mgr_pclk_rate(channel), pcd);
+}
+
+void dispc_dump_clocks(struct seq_file *s)
+{
+	int lcd;
 	u32 l;
 	enum omap_dss_clk_source dispc_clk_src = dss_get_dispc_clk_source();
-	enum omap_dss_clk_source lcd_clk_src;
 
 	if (dispc_runtime_get())
 		return;
@@ -2880,36 +2900,13 @@ void dispc_dump_clocks(struct seq_file *s)
 		seq_printf(s, "lck\t\t%-16lulck div\t%u\n",
 				(dispc_fclk_rate()/lcd), lcd);
 	}
-	seq_printf(s, "- LCD1 -\n");
 
-	lcd_clk_src = dss_get_lcd_clk_source(OMAP_DSS_CHANNEL_LCD);
+	dispc_dump_clocks_channel(s, OMAP_DSS_CHANNEL_LCD);
 
-	seq_printf(s, "lcd1_clk source = %s (%s)\n",
-		dss_get_generic_clk_source_name(lcd_clk_src),
-		dss_feat_get_clk_source_name(lcd_clk_src));
-
-	dispc_mgr_get_lcd_divisor(OMAP_DSS_CHANNEL_LCD, &lcd, &pcd);
-
-	seq_printf(s, "lck\t\t%-16lulck div\t%u\n",
-			dispc_mgr_lclk_rate(OMAP_DSS_CHANNEL_LCD), lcd);
-	seq_printf(s, "pck\t\t%-16lupck div\t%u\n",
-			dispc_mgr_pclk_rate(OMAP_DSS_CHANNEL_LCD), pcd);
-	if (dss_has_feature(FEAT_MGR_LCD2)) {
-		seq_printf(s, "- LCD2 -\n");
-
-		lcd_clk_src = dss_get_lcd_clk_source(OMAP_DSS_CHANNEL_LCD2);
-
-		seq_printf(s, "lcd2_clk source = %s (%s)\n",
-			dss_get_generic_clk_source_name(lcd_clk_src),
-			dss_feat_get_clk_source_name(lcd_clk_src));
-
-		dispc_mgr_get_lcd_divisor(OMAP_DSS_CHANNEL_LCD2, &lcd, &pcd);
-
-		seq_printf(s, "lck\t\t%-16lulck div\t%u\n",
-				dispc_mgr_lclk_rate(OMAP_DSS_CHANNEL_LCD2), lcd);
-		seq_printf(s, "pck\t\t%-16lupck div\t%u\n",
-				dispc_mgr_pclk_rate(OMAP_DSS_CHANNEL_LCD2), pcd);
-	}
+	if (dss_has_feature(FEAT_MGR_LCD2))
+		dispc_dump_clocks_channel(s, OMAP_DSS_CHANNEL_LCD2);
+	if (dss_has_feature(FEAT_MGR_LCD3))
+		dispc_dump_clocks_channel(s, OMAP_DSS_CHANNEL_LCD3);
 
 	dispc_runtime_put();
 }
@@ -2962,6 +2959,12 @@ void dispc_dump_irqs(struct seq_file *s)
 		PIS(ACBIAS_COUNT_STAT2);
 		PIS(SYNC_LOST2);
 	}
+	if (dss_has_feature(FEAT_MGR_LCD3)) {
+		PIS(FRAMEDONE3);
+		PIS(VSYNC3);
+		PIS(ACBIAS_COUNT_STAT3);
+		PIS(SYNC_LOST3);
+	}
 #undef PIS
 }
 #endif
@@ -2973,6 +2976,7 @@ static void dispc_dump_regs(struct seq_file *s)
 		[OMAP_DSS_CHANNEL_LCD]		= "LCD",
 		[OMAP_DSS_CHANNEL_DIGIT]	= "TV",
 		[OMAP_DSS_CHANNEL_LCD2]		= "LCD2",
+		[OMAP_DSS_CHANNEL_LCD3]		= "LCD3",
 	};
 	const char *ovl_names[] = {
 		[OMAP_DSS_GFX]		= "GFX",
@@ -3005,6 +3009,10 @@ static void dispc_dump_regs(struct seq_file *s)
 		DUMPREG(DISPC_CONTROL2);
 		DUMPREG(DISPC_CONFIG2);
 	}
+	if (dss_has_feature(FEAT_MGR_LCD3)) {
+		DUMPREG(DISPC_CONTROL3);
+		DUMPREG(DISPC_CONFIG3);
+	}
 
 #undef DUMPREG
 
@@ -3387,6 +3395,8 @@ static void print_irq_status(u32 status)
 	PIS(SYNC_LOST_DIGIT);
 	if (dss_has_feature(FEAT_MGR_LCD2))
 		PIS(SYNC_LOST2);
+	if (dss_has_feature(FEAT_MGR_LCD3))
+		PIS(SYNC_LOST3);
 #undef PIS
 
 	printk("\n");
-- 
1.7.1

