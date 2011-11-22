From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 15/65] OMAPDSS: DISPC: remove unused functions
Date: Tue, 22 Nov 2011 11:21:14 +0200
Message-ID: <1321953724-6350-16-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:42881 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757455Ab1KVJXH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:23:07 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Remove unused functions:

dispc_mgr_get_default_color
dispc_mgr_get_trans_key
dispc_mgr_trans_key_enabled
dispc_mgr_alpha_fixed_zorder_enabled

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   65 ---------------------------------------
 drivers/video/omap2/dss/dss.h   |    6 ---
 2 files changed, 0 insertions(+), 71 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 3f2efdc..5ac00a2 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2163,19 +2163,6 @@ static void dispc_mgr_set_default_color(enum omap_channel channel, u32 color)
 	dispc_write_reg(DISPC_DEFAULT_COLOR(channel), color);
 }
 
-u32 dispc_mgr_get_default_color(enum omap_channel channel)
-{
-	u32 l;
-
-	BUG_ON(channel != OMAP_DSS_CHANNEL_DIGIT &&
-		channel != OMAP_DSS_CHANNEL_LCD &&
-		channel != OMAP_DSS_CHANNEL_LCD2);
-
-	l = dispc_read_reg(DISPC_DEFAULT_COLOR(channel));
-
-	return l;
-}
-
 static void dispc_mgr_set_trans_key(enum omap_channel ch,
 		enum omap_dss_trans_key_type type,
 		u32 trans_key)
@@ -2190,25 +2177,6 @@ static void dispc_mgr_set_trans_key(enum omap_channel ch,
 	dispc_write_reg(DISPC_TRANS_COLOR(ch), trans_key);
 }
 
-void dispc_mgr_get_trans_key(enum omap_channel ch,
-		enum omap_dss_trans_key_type *type,
-		u32 *trans_key)
-{
-	if (type) {
-		if (ch == OMAP_DSS_CHANNEL_LCD)
-			*type = REG_GET(DISPC_CONFIG, 11, 11);
-		else if (ch == OMAP_DSS_CHANNEL_DIGIT)
-			*type = REG_GET(DISPC_CONFIG, 13, 13);
-		else if (ch == OMAP_DSS_CHANNEL_LCD2)
-			*type = REG_GET(DISPC_CONFIG2, 11, 11);
-		else
-			BUG();
-	}
-
-	if (trans_key)
-		*trans_key = dispc_read_reg(DISPC_TRANS_COLOR(ch));
-}
-
 static void dispc_mgr_enable_trans_key(enum omap_channel ch, bool enable)
 {
 	if (ch == OMAP_DSS_CHANNEL_LCD)
@@ -2231,39 +2199,6 @@ static void dispc_mgr_enable_alpha_fixed_zorder(enum omap_channel ch,
 		REG_FLD_MOD(DISPC_CONFIG, enable, 19, 19);
 }
 
-bool dispc_mgr_alpha_fixed_zorder_enabled(enum omap_channel ch)
-{
-	bool enabled;
-
-	if (!dss_has_feature(FEAT_ALPHA_FIXED_ZORDER))
-		return false;
-
-	if (ch == OMAP_DSS_CHANNEL_LCD)
-		enabled = REG_GET(DISPC_CONFIG, 18, 18);
-	else if (ch == OMAP_DSS_CHANNEL_DIGIT)
-		enabled = REG_GET(DISPC_CONFIG, 19, 19);
-	else
-		BUG();
-
-	return enabled;
-}
-
-bool dispc_mgr_trans_key_enabled(enum omap_channel ch)
-{
-	bool enabled;
-
-	if (ch == OMAP_DSS_CHANNEL_LCD)
-		enabled = REG_GET(DISPC_CONFIG, 10, 10);
-	else if (ch == OMAP_DSS_CHANNEL_DIGIT)
-		enabled = REG_GET(DISPC_CONFIG, 12, 12);
-	else if (ch == OMAP_DSS_CHANNEL_LCD2)
-		enabled = REG_GET(DISPC_CONFIG2, 10, 10);
-	else
-		BUG();
-
-	return enabled;
-}
-
 void dispc_mgr_setup(enum omap_channel channel,
 		struct omap_overlay_manager_info *info)
 {
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 3e01bba..2d6081e 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -415,12 +415,6 @@ void dispc_mgr_enable_stallmode(enum omap_channel channel, bool enable);
 void dispc_mgr_set_tft_data_lines(enum omap_channel channel, u8 data_lines);
 void dispc_mgr_set_lcd_display_type(enum omap_channel channel,
 		enum omap_lcd_display_type type);
-u32 dispc_mgr_get_default_color(enum omap_channel channel);
-void dispc_mgr_get_trans_key(enum omap_channel ch,
-		enum omap_dss_trans_key_type *type,
-		u32 *trans_key);
-bool dispc_mgr_trans_key_enabled(enum omap_channel ch);
-bool dispc_mgr_alpha_fixed_zorder_enabled(enum omap_channel ch);
 void dispc_mgr_set_lcd_timings(enum omap_channel channel,
 		struct omap_video_timings *timings);
 void dispc_mgr_set_pol_freq(enum omap_channel channel,
-- 
1.7.4.1

