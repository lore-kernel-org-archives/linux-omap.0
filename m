From: Luis de Bethencourt <luisbg@osg.samsung.com>
Subject: [PATCH] OMAPDSS: DISPC: Remove boolean comparisons
Date: Thu, 15 Oct 2015 13:29:38 +0100
Message-ID: <1444912178-15989-1-git-send-email-luisbg@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, laurent.pinchart@ideasonboard.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Luis de Bethencourt <luisbg@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

Boolean tests do not need explicit comparison to true or false.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---
 drivers/video/fbdev/omap2/dss/dispc-compat.c | 6 +++---
 drivers/video/fbdev/omap2/dss/dispc.c        | 6 +++---
 drivers/video/fbdev/omap2/dss/manager.c      | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dispc-compat.c b/drivers/video/fbdev/omap2/dss/dispc-compat.c
index 633c461..0918b3b 100644
--- a/drivers/video/fbdev/omap2/dss/dispc-compat.c
+++ b/drivers/video/fbdev/omap2/dss/dispc-compat.c
@@ -476,7 +476,7 @@ static void dispc_mgr_disable_lcd_out(enum omap_channel channel)
 	int r;
 	u32 irq;
 
-	if (dispc_mgr_is_enabled(channel) == false)
+	if (!dispc_mgr_is_enabled(channel))
 		return;
 
 	/*
@@ -524,7 +524,7 @@ static void dispc_mgr_enable_digit_out(void)
 	int r;
 	u32 irq_mask;
 
-	if (dispc_mgr_is_enabled(OMAP_DSS_CHANNEL_DIGIT) == true)
+	if (dispc_mgr_is_enabled(OMAP_DSS_CHANNEL_DIGIT))
 		return;
 
 	/*
@@ -562,7 +562,7 @@ static void dispc_mgr_disable_digit_out(void)
 	u32 irq_mask;
 	int num_irqs;
 
-	if (dispc_mgr_is_enabled(OMAP_DSS_CHANNEL_DIGIT) == false)
+	if (!dispc_mgr_is_enabled(OMAP_DSS_CHANNEL_DIGIT))
 		return;
 
 	/*
diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index be716c9..43b0367 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -571,7 +571,7 @@ EXPORT_SYMBOL(dispc_mgr_go_busy);
 
 void dispc_mgr_go(enum omap_channel channel)
 {
-	WARN_ON(dispc_mgr_is_enabled(channel) == false);
+	WARN_ON(!dispc_mgr_is_enabled(channel));
 	WARN_ON(dispc_mgr_go_busy(channel));
 
 	DSSDBG("GO %s\n", mgr_desc[channel].name);
@@ -3220,7 +3220,7 @@ void dispc_mgr_set_timings(enum omap_channel channel,
 
 		DSSDBG("hsync %luHz, vsync %luHz\n", ht, vt);
 	} else {
-		if (t.interlace == true)
+		if (t.interlace)
 			t.y_res /= 2;
 	}
 
@@ -3237,7 +3237,7 @@ static void dispc_mgr_set_lcd_divisor(enum omap_channel channel, u16 lck_div,
 	dispc_write_reg(DISPC_DIVISORo(channel),
 			FLD_VAL(lck_div, 23, 16) | FLD_VAL(pck_div, 7, 0));
 
-	if (dss_has_feature(FEAT_CORE_CLK_DIV) == false &&
+	if (!dss_has_feature(FEAT_CORE_CLK_DIV) &&
 			channel == OMAP_DSS_CHANNEL_LCD)
 		dispc.core_clk_rate = dispc_fclk_rate() / lck_div;
 }
diff --git a/drivers/video/fbdev/omap2/dss/manager.c b/drivers/video/fbdev/omap2/dss/manager.c
index 1aac9b4..08a67f4 100644
--- a/drivers/video/fbdev/omap2/dss/manager.c
+++ b/drivers/video/fbdev/omap2/dss/manager.c
@@ -210,7 +210,7 @@ static int dss_mgr_check_lcd_config(struct omap_overlay_manager *mgr,
 		return -EINVAL;
 
 	/* fifohandcheck should be used only with stallmode */
-	if (stallmode == false && fifohandcheck == true)
+	if (!stallmode && fifohandcheck)
 		return -EINVAL;
 
 	/*
-- 
2.5.1
