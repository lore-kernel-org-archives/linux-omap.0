From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 20/28] OMAP: DSS2: Use PM runtime & HWMOD support
Date: Thu,  9 Jun 2011 16:56:42 +0300
Message-ID: <1307627810-3768-21-git-send-email-tomi.valkeinen@ti.com>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:41419 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758130Ab1FIN5v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 09:57:51 -0400
In-Reply-To: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use PM runtime and HWMOD support to handle enabling and disabling of DSS
modules.

Each DSS module will have get and put functions which can be used to
enable and disable that module. The functions use pm_runtime and hwmod
opt-clocks to enable the hardware.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c   |  326 ++++++++++++++++++++++----------
 drivers/video/omap2/dss/dpi.c     |   70 +++++---
 drivers/video/omap2/dss/dsi.c     |  244 +++++++++++++++---------
 drivers/video/omap2/dss/dss.c     |  376 ++++++++-----------------------------
 drivers/video/omap2/dss/dss.h     |   33 ++--
 drivers/video/omap2/dss/hdmi.c    |  161 ++++++++++++----
 drivers/video/omap2/dss/manager.c |    8 +-
 drivers/video/omap2/dss/overlay.c |   24 ++-
 drivers/video/omap2/dss/rfbi.c    |  110 +++++++++--
 drivers/video/omap2/dss/sdi.c     |   40 +++--
 drivers/video/omap2/dss/venc.c    |  165 ++++++++++++++---
 11 files changed, 923 insertions(+), 634 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index ee2052f..3f2265f 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -34,6 +34,7 @@
 #include <linux/hardirq.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 
 #include <plat/sram.h>
 #include <plat/clock.h>
@@ -93,7 +94,11 @@ struct dispc_irq_stats {
 static struct {
 	struct platform_device *pdev;
 	void __iomem    *base;
+
+	int		ctx_loss_cnt;
+
 	int irq;
+	struct clk *dss_clk;
 
 	u32	fifo_size[3];
 
@@ -140,13 +145,12 @@ static inline u32 dispc_read_reg(const u16 idx)
 #define RR(reg) \
 	dispc_write_reg(DISPC_##reg, dispc.ctx[DISPC_##reg / sizeof(u32)])
 
-void dispc_save_context(void)
+static void dispc_save_context(void)
 {
 	int i;
-	if (cpu_is_omap24xx())
-		return;
 
-	SR(SYSCONFIG);
+	DSSDBG("dispc_save_context\n");
+
 	SR(IRQENABLE);
 	SR(CONTROL);
 	SR(CONFIG);
@@ -314,10 +318,12 @@ void dispc_save_context(void)
 		SR(DIVISOR);
 }
 
-void dispc_restore_context(void)
+static void dispc_restore_context(void)
 {
 	int i;
-	RR(SYSCONFIG);
+
+	DSSDBG("dispc_restore_context\n");
+
 	/*RR(IRQENABLE);*/
 	/*RR(CONTROL);*/
 	RR(CONFIG);
@@ -501,14 +507,82 @@ void dispc_restore_context(void)
 #undef SR
 #undef RR
 
-static inline void enable_clocks(bool enable)
+static void dispc_init_ctx_loss_count(void)
 {
-	if (enable)
-		dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
-	else
-		dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
+	struct device *dev = &dispc.pdev->dev;
+	struct omap_display_platform_data *pdata = dev->platform_data;
+	struct omap_dss_board_info *board_data = pdata->board_data;
+	int cnt = 0;
+
+	/*
+	 * get_context_loss_count returns negative on error. We'll ignore the
+	 * error and store the error to ctx_loss_cnt, which will cause
+	 * dispc_need_ctx_restore() call to return true.
+	 */
+
+	if (board_data->get_context_loss_count)
+		cnt = board_data->get_context_loss_count(dev);
+
+	WARN_ON(cnt < 0);
+
+	dispc.ctx_loss_cnt = cnt;
+
+	DSSDBG("initial ctx_loss_cnt %u\n", cnt);
+}
+
+static bool dispc_need_ctx_restore(void)
+{
+	struct device *dev = &dispc.pdev->dev;
+	struct omap_display_platform_data *pdata = dev->platform_data;
+	struct omap_dss_board_info *board_data = pdata->board_data;
+	int cnt;
+
+	/*
+	 * If get_context_loss_count is not available, assume that we need
+	 * context restore always.
+	 */
+	if (!board_data->get_context_loss_count)
+		return true;
+
+	cnt = board_data->get_context_loss_count(dev);
+	if (cnt < 0) {
+		dev_err(dev, "getting context loss count failed, will force "
+				"context restore\n");
+		dispc.ctx_loss_cnt = cnt;
+		return true;
+	}
+
+	if (cnt == dispc.ctx_loss_cnt)
+		return false;
+
+	DSSDBG("ctx_loss_cnt %d -> %d\n", dispc.ctx_loss_cnt, cnt);
+	dispc.ctx_loss_cnt = cnt;
+
+	return true;
+}
+
+int dispc_runtime_get(void)
+{
+	int r;
+
+	DSSDBG("dispc_runtime_get\n");
+
+	r = pm_runtime_get_sync(&dispc.pdev->dev);
+	WARN_ON(r < 0);
+	return r < 0 ? r : 0;
+}
+
+void dispc_runtime_put(void)
+{
+	int r;
+
+	DSSDBG("dispc_runtime_put\n");
+
+	r = pm_runtime_put(&dispc.pdev->dev);
+	WARN_ON(r < 0);
 }
 
+
 bool dispc_go_busy(enum omap_channel channel)
 {
 	int bit;
@@ -530,7 +604,7 @@ void dispc_go(enum omap_channel channel)
 	int bit;
 	bool enable_bit, go_bit;
 
-	enable_clocks(1);
+	dispc_runtime_get();
 
 	if (channel == OMAP_DSS_CHANNEL_LCD ||
 			channel == OMAP_DSS_CHANNEL_LCD2)
@@ -571,7 +645,7 @@ void dispc_go(enum omap_channel channel)
 	else
 		REG_FLD_MOD(DISPC_CONTROL, 1, bit, bit);
 end:
-	enable_clocks(0);
+	dispc_runtime_put();
 }
 
 static void _dispc_write_firh_reg(enum omap_plane plane, int reg, u32 value)
@@ -998,7 +1072,7 @@ void dispc_set_burst_size(enum omap_plane plane,
 	int shift;
 	u32 val;
 
-	enable_clocks(1);
+	dispc_runtime_get();
 
 	switch (plane) {
 	case OMAP_DSS_GFX:
@@ -1017,7 +1091,7 @@ void dispc_set_burst_size(enum omap_plane plane,
 	val = FLD_MOD(val, burst_size, shift+1, shift);
 	dispc_write_reg(DISPC_OVL_ATTRIBUTES(plane), val);
 
-	enable_clocks(0);
+	dispc_runtime_put();
 }
 
 void dispc_enable_gamma_table(bool enable)
@@ -1054,9 +1128,9 @@ void dispc_enable_replication(enum omap_plane plane, bool enable)
 	else
 		bit = 10;
 
-	enable_clocks(1);
+	dispc_runtime_get();
 	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), enable, bit, bit);
-	enable_clocks(0);
+	dispc_runtime_put();
 }
 
 void dispc_set_lcd_size(enum omap_channel channel, u16 width, u16 height)
@@ -1064,9 +1138,9 @@ void dispc_set_lcd_size(enum omap_channel channel, u16 width, u16 height)
 	u32 val;
 	BUG_ON((width > (1 << 11)) || (height > (1 << 11)));
 	val = FLD_VAL(height - 1, 26, 16) | FLD_VAL(width - 1, 10, 0);
-	enable_clocks(1);
+	dispc_runtime_get();
 	dispc_write_reg(DISPC_SIZE_MGR(channel), val);
-	enable_clocks(0);
+	dispc_runtime_put();
 }
 
 void dispc_set_digit_size(u16 width, u16 height)
@@ -1074,9 +1148,9 @@ void dispc_set_digit_size(u16 width, u16 height)
 	u32 val;
 	BUG_ON((width > (1 << 11)) || (height > (1 << 11)));
 	val = FLD_VAL(height - 1, 26, 16) | FLD_VAL(width - 1, 10, 0);
-	enable_clocks(1);
+	dispc_runtime_get();
 	dispc_write_reg(DISPC_SIZE_MGR(OMAP_DSS_CHANNEL_DIGIT), val);
-	enable_clocks(0);
+	dispc_runtime_put();
 }
 
 static void dispc_read_plane_fifo_sizes(void)
@@ -1085,7 +1159,7 @@ static void dispc_read_plane_fifo_sizes(void)
 	int plane;
 	u8 start, end;
 
-	enable_clocks(1);
+	dispc_runtime_get();
 
 	dss_feat_get_reg_field(FEAT_REG_FIFOSIZE, &start, &end);
 
@@ -1095,7 +1169,7 @@ static void dispc_read_plane_fifo_sizes(void)
 		dispc.fifo_size[plane] = size;
 	}
 
-	enable_clocks(0);
+	dispc_runtime_put();
 }
 
 u32 dispc_get_plane_fifo_size(enum omap_plane plane)
@@ -1110,7 +1184,7 @@ void dispc_setup_plane_fifo(enum omap_plane plane, u32 low, u32 high)
 	dss_feat_get_reg_field(FEAT_REG_FIFOHIGHTHRESHOLD, &hi_start, &hi_end);
 	dss_feat_get_reg_field(FEAT_REG_FIFOLOWTHRESHOLD, &lo_start, &lo_end);
 
-	enable_clocks(1);
+	dispc_runtime_get();
 
 	DSSDBG("fifo(%d) low/high old %u/%u, new %u/%u\n",
 			plane,
@@ -1124,17 +1198,17 @@ void dispc_setup_plane_fifo(enum omap_plane plane, u32 low, u32 high)
 			FLD_VAL(high, hi_start, hi_end) |
 			FLD_VAL(low, lo_start, lo_end));
 
-	enable_clocks(0);
+	dispc_runtime_put();
 }
 
 void dispc_enable_fifomerge(bool enable)
 {
-	enable_clocks(1);
+	dispc_runtime_get();
 
 	DSSDBG("FIFO merge %s\n", enable ? "enabled" : "disabled");
 	REG_FLD_MOD(DISPC_CONFIG, enable ? 1 : 0, 14, 14);
 
-	enable_clocks(0);
+	dispc_runtime_put();
 }
 
 static void _dispc_set_fir(enum omap_plane plane,
@@ -1756,9 +1830,9 @@ static unsigned long calc_fclk(enum omap_channel channel, u16 width,
 
 void dispc_set_channel_out(enum omap_plane plane, enum omap_channel channel_out)
 {
-	enable_clocks(1);
+	dispc_runtime_get();
 	_dispc_set_channel_out(plane, channel_out);
-	enable_clocks(0);
+	dispc_runtime_put();
 }
 
 static int _dispc_setup_plane(enum omap_plane plane,
@@ -1954,7 +2028,7 @@ static void dispc_enable_lcd_out(enum omap_channel channel, bool enable)
 	int r;
 	u32 irq;
 
-	enable_clocks(1);
+	dispc_runtime_get();
 
 	/* When we disable LCD output, we need to wait until frame is done.
 	 * Otherwise the DSS is still working, and turning off the clocks
@@ -1990,7 +2064,7 @@ static void dispc_enable_lcd_out(enum omap_channel channel, bool enable)
 			DSSERR("failed to unregister FRAMEDONE isr\n");
 	}
 
-	enable_clocks(0);
+	dispc_runtime_put();
 }
 
 static void _enable_digit_out(bool enable)
@@ -2003,10 +2077,10 @@ static void dispc_enable_digit_out(bool enable)
 	struct completion frame_done_completion;
 	int r;
 
-	enable_clocks(1);
+	dispc_runtime_get();
 
 	if (REG_GET(DISPC_CONTROL, 1, 1) == enable) {
-		enable_clocks(0);
+		dispc_runtime_put();
 		return;
 	}
 
@@ -2061,7 +2135,7 @@ static void dispc_enable_digit_out(bool enable)
 		spin_unlock_irqrestore(&dispc.irq_lock, flags);
 	}
 
-	enable_clocks(0);
+	dispc_runtime_put();
 }
 
 bool dispc_is_channel_enabled(enum omap_channel channel)
@@ -2092,9 +2166,9 @@ void dispc_lcd_enable_signal_polarity(bool act_high)
 	if (!dss_has_feature(FEAT_LCDENABLEPOL))
 		return;
 
-	enable_clocks(1);
+	dispc_runtime_get();
 	REG_FLD_MOD(DISPC_CONTROL, act_high ? 1 : 0, 29, 29);
-	enable_clocks(0);
+	dispc_runtime_put();
 }
 
 void dispc_lcd_enable_signal(bool enable)
@@ -2102,9 +2176,9 @@ void dispc_lcd_enable_signal(bool enable)
 	if (!dss_has_feature(FEAT_LCDENABLESIGNAL))
 		return;
 
-	enable_clocks(1);
+	dispc_runtime_get();
 	REG_FLD_MOD(DISPC_CONTROL, enable ? 1 : 0, 28, 28);
-	enable_clocks(0);
+	dispc_runtime_put();
 }
 
 void dispc_pck_free_enable(bool enable)
@@ -2112,19 +2186,19 @@ void dispc_pck_free_enable(bool enable)
 	if (!dss_has_feature(FEAT_PCKFREEENABLE))
 		return;
 
-	enable_clocks(1);
+	dispc_runtime_get();
 	REG_FLD_MOD(DISPC_CONTROL, enable ? 1 : 0, 27, 27);
-	enable_clocks(0);
+	dispc_runtime_put();
 }
 
 void dispc_enable_fifohandcheck(enum omap_channel channel, bool enable)
 {
-	enable_clocks(1);
+	dispc_runtime_get();
 	if (channel == OMAP_DSS_CHANNEL_LCD2)
 		REG_FLD_MOD(DISPC_CONFIG2, enable ? 1 : 0, 16, 16);
 	else
 		REG_FLD_MOD(DISPC_CONFIG, enable ? 1 : 0, 16, 16);
-	enable_clocks(0);
+	dispc_runtime_put();
 }
 
 
@@ -2147,27 +2221,27 @@ void dispc_set_lcd_display_type(enum omap_channel channel,
 		return;
 	}
 
-	enable_clocks(1);
+	dispc_runtime_get();
 	if (channel == OMAP_DSS_CHANNEL_LCD2)
 		REG_FLD_MOD(DISPC_CONTROL2, mode, 3, 3);
 	else
 		REG_FLD_MOD(DISPC_CONTROL, mode, 3, 3);
-	enable_clocks(0);
+	dispc_runtime_put();
 }
 
 void dispc_set_loadmode(enum omap_dss_load_mode mode)
 {
-	enable_clocks(1);
+	dispc_runtime_get();
 	REG_FLD_MOD(DISPC_CONFIG, mode, 2, 1);
-	enable_clocks(0);
+	dispc_runtime_put();
 }
 
 
 void dispc_set_default_color(enum omap_channel channel, u32 color)
 {
-	enable_clocks(1);
+	dispc_runtime_get();
 	dispc_write_reg(DISPC_DEFAULT_COLOR(channel), color);
-	enable_clocks(0);
+	dispc_runtime_put();
 }
 
 u32 dispc_get_default_color(enum omap_channel channel)
@@ -2178,9 +2252,9 @@ u32 dispc_get_default_color(enum omap_channel channel)
 		channel != OMAP_DSS_CHANNEL_LCD &&
 		channel != OMAP_DSS_CHANNEL_LCD2);
 
-	enable_clocks(1);
+	dispc_runtime_get();
 	l = dispc_read_reg(DISPC_DEFAULT_COLOR(channel));
-	enable_clocks(0);
+	dispc_runtime_put();
 
 	return l;
 }
@@ -2189,7 +2263,7 @@ void dispc_set_trans_key(enum omap_channel ch,
 		enum omap_dss_trans_key_type type,
 		u32 trans_key)
 {
-	enable_clocks(1);
+	dispc_runtime_get();
 	if (ch == OMAP_DSS_CHANNEL_LCD)
 		REG_FLD_MOD(DISPC_CONFIG, type, 11, 11);
 	else if (ch == OMAP_DSS_CHANNEL_DIGIT)
@@ -2198,14 +2272,14 @@ void dispc_set_trans_key(enum omap_channel ch,
 		REG_FLD_MOD(DISPC_CONFIG2, type, 11, 11);
 
 	dispc_write_reg(DISPC_TRANS_COLOR(ch), trans_key);
-	enable_clocks(0);
+	dispc_runtime_put();
 }
 
 void dispc_get_trans_key(enum omap_channel ch,
 		enum omap_dss_trans_key_type *type,
 		u32 *trans_key)
 {
-	enable_clocks(1);
+	dispc_runtime_get();
 	if (type) {
 		if (ch == OMAP_DSS_CHANNEL_LCD)
 			*type = REG_GET(DISPC_CONFIG, 11, 11);
@@ -2219,33 +2293,33 @@ void dispc_get_trans_key(enum omap_channel ch,
 
 	if (trans_key)
 		*trans_key = dispc_read_reg(DISPC_TRANS_COLOR(ch));
-	enable_clocks(0);
+	dispc_runtime_put();
 }
 
 void dispc_enable_trans_key(enum omap_channel ch, bool enable)
 {
-	enable_clocks(1);
+	dispc_runtime_get();
 	if (ch == OMAP_DSS_CHANNEL_LCD)
 		REG_FLD_MOD(DISPC_CONFIG, enable, 10, 10);
 	else if (ch == OMAP_DSS_CHANNEL_DIGIT)
 		REG_FLD_MOD(DISPC_CONFIG, enable, 12, 12);
 	else /* OMAP_DSS_CHANNEL_LCD2 */
 		REG_FLD_MOD(DISPC_CONFIG2, enable, 10, 10);
-	enable_clocks(0);
+	dispc_runtime_put();
 }
 void dispc_enable_alpha_blending(enum omap_channel ch, bool enable)
 {
 	if (!dss_has_feature(FEAT_GLOBAL_ALPHA))
 		return;
 
-	enable_clocks(1);
+	dispc_runtime_get();
 	if (ch == OMAP_DSS_CHANNEL_LCD)
 		REG_FLD_MOD(DISPC_CONFIG, enable, 18, 18);
 	else if (ch == OMAP_DSS_CHANNEL_DIGIT)
 		REG_FLD_MOD(DISPC_CONFIG, enable, 19, 19);
 	else /* OMAP_DSS_CHANNEL_LCD2 */
 		REG_FLD_MOD(DISPC_CONFIG2, enable, 18, 18);
-	enable_clocks(0);
+	dispc_runtime_put();
 }
 bool dispc_alpha_blending_enabled(enum omap_channel ch)
 {
@@ -2254,7 +2328,7 @@ bool dispc_alpha_blending_enabled(enum omap_channel ch)
 	if (!dss_has_feature(FEAT_GLOBAL_ALPHA))
 		return false;
 
-	enable_clocks(1);
+	dispc_runtime_get();
 	if (ch == OMAP_DSS_CHANNEL_LCD)
 		enabled = REG_GET(DISPC_CONFIG, 18, 18);
 	else if (ch == OMAP_DSS_CHANNEL_DIGIT)
@@ -2263,7 +2337,7 @@ bool dispc_alpha_blending_enabled(enum omap_channel ch)
 		enabled = REG_GET(DISPC_CONFIG2, 18, 18);
 	else
 		BUG();
-	enable_clocks(0);
+	dispc_runtime_put();
 
 	return enabled;
 }
@@ -2273,7 +2347,7 @@ bool dispc_trans_key_enabled(enum omap_channel ch)
 {
 	bool enabled;
 
-	enable_clocks(1);
+	dispc_runtime_get();
 	if (ch == OMAP_DSS_CHANNEL_LCD)
 		enabled = REG_GET(DISPC_CONFIG, 10, 10);
 	else if (ch == OMAP_DSS_CHANNEL_DIGIT)
@@ -2282,7 +2356,7 @@ bool dispc_trans_key_enabled(enum omap_channel ch)
 		enabled = REG_GET(DISPC_CONFIG2, 10, 10);
 	else
 		BUG();
-	enable_clocks(0);
+	dispc_runtime_put();
 
 	return enabled;
 }
@@ -2310,12 +2384,12 @@ void dispc_set_tft_data_lines(enum omap_channel channel, u8 data_lines)
 		return;
 	}
 
-	enable_clocks(1);
+	dispc_runtime_get();
 	if (channel == OMAP_DSS_CHANNEL_LCD2)
 		REG_FLD_MOD(DISPC_CONTROL2, code, 9, 8);
 	else
 		REG_FLD_MOD(DISPC_CONTROL, code, 9, 8);
-	enable_clocks(0);
+	dispc_runtime_put();
 }
 
 void dispc_set_parallel_interface_mode(enum omap_channel channel,
@@ -2347,7 +2421,7 @@ void dispc_set_parallel_interface_mode(enum omap_channel channel,
 		return;
 	}
 
-	enable_clocks(1);
+	dispc_runtime_get();
 
 	if (channel == OMAP_DSS_CHANNEL_LCD2) {
 		l = dispc_read_reg(DISPC_CONTROL2);
@@ -2361,7 +2435,7 @@ void dispc_set_parallel_interface_mode(enum omap_channel channel,
 		dispc_write_reg(DISPC_CONTROL, l);
 	}
 
-	enable_clocks(0);
+	dispc_runtime_put();
 }
 
 static bool _dispc_lcd_timings_ok(int hsw, int hfp, int hbp,
@@ -2414,10 +2488,10 @@ static void _dispc_set_lcd_timings(enum omap_channel channel, int hsw,
 			FLD_VAL(vbp, 31, 20);
 	}
 
-	enable_clocks(1);
+	dispc_runtime_get();
 	dispc_write_reg(DISPC_TIMING_H(channel), timing_h);
 	dispc_write_reg(DISPC_TIMING_V(channel), timing_v);
-	enable_clocks(0);
+	dispc_runtime_put();
 }
 
 /* change name to mode? */
@@ -2460,10 +2534,10 @@ static void dispc_set_lcd_divisor(enum omap_channel channel, u16 lck_div,
 	BUG_ON(lck_div < 1);
 	BUG_ON(pck_div < 2);
 
-	enable_clocks(1);
+	dispc_runtime_get();
 	dispc_write_reg(DISPC_DIVISORo(channel),
 			FLD_VAL(lck_div, 23, 16) | FLD_VAL(pck_div, 7, 0));
-	enable_clocks(0);
+	dispc_runtime_put();
 }
 
 static void dispc_get_lcd_divisor(enum omap_channel channel, int *lck_div,
@@ -2482,7 +2556,7 @@ unsigned long dispc_fclk_rate(void)
 
 	switch (dss_get_dispc_clk_source()) {
 	case OMAP_DSS_CLK_SRC_FCK:
-		r = dss_clk_get_rate(DSS_CLK_FCK);
+		r = clk_get_rate(dispc.dss_clk);
 		break;
 	case OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC:
 		dsidev = dsi_get_dsidev_from_id(0);
@@ -2512,7 +2586,7 @@ unsigned long dispc_lclk_rate(enum omap_channel channel)
 
 	switch (dss_get_lcd_clk_source(channel)) {
 	case OMAP_DSS_CLK_SRC_FCK:
-		r = dss_clk_get_rate(DSS_CLK_FCK);
+		r = clk_get_rate(dispc.dss_clk);
 		break;
 	case OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC:
 		dsidev = dsi_get_dsidev_from_id(0);
@@ -2551,7 +2625,8 @@ void dispc_dump_clocks(struct seq_file *s)
 	enum omap_dss_clk_source dispc_clk_src = dss_get_dispc_clk_source();
 	enum omap_dss_clk_source lcd_clk_src;
 
-	enable_clocks(1);
+	if (dispc_runtime_get())
+		return;
 
 	seq_printf(s, "- DISPC -\n");
 
@@ -2599,7 +2674,8 @@ void dispc_dump_clocks(struct seq_file *s)
 		seq_printf(s, "pck\t\t%-16lupck div\t%u\n",
 				dispc_pclk_rate(OMAP_DSS_CHANNEL_LCD2), pcd);
 	}
-	enable_clocks(0);
+
+	dispc_runtime_put();
 }
 
 #ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
@@ -2654,7 +2730,8 @@ void dispc_dump_regs(struct seq_file *s)
 {
 #define DUMPREG(r) seq_printf(s, "%-50s %08x\n", #r, dispc_read_reg(r))
 
-	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
+	if (dispc_runtime_get())
+		return;
 
 	DUMPREG(DISPC_REVISION);
 	DUMPREG(DISPC_SYSCONFIG);
@@ -2899,7 +2976,7 @@ void dispc_dump_regs(struct seq_file *s)
 		DUMPREG(DISPC_OVL_PRELOAD(OMAP_DSS_VIDEO2));
 	}
 
-	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
+	dispc_runtime_put();
 #undef DUMPREG
 }
 
@@ -2920,9 +2997,9 @@ static void _dispc_set_pol_freq(enum omap_channel channel, bool onoff, bool rf,
 	l |= FLD_VAL(acbi, 11, 8);
 	l |= FLD_VAL(acb, 7, 0);
 
-	enable_clocks(1);
+	dispc_runtime_get();
 	dispc_write_reg(DISPC_POL_FREQ(channel), l);
-	enable_clocks(0);
+	dispc_runtime_put();
 }
 
 void dispc_set_pol_freq(enum omap_channel channel,
@@ -3043,7 +3120,7 @@ static void _omap_dispc_set_irqs(void)
 		mask |= isr_data->mask;
 	}
 
-	enable_clocks(1);
+	dispc_runtime_get();
 
 	old_mask = dispc_read_reg(DISPC_IRQENABLE);
 	/* clear the irqstatus for newly enabled irqs */
@@ -3051,7 +3128,7 @@ static void _omap_dispc_set_irqs(void)
 
 	dispc_write_reg(DISPC_IRQENABLE, mask);
 
-	enable_clocks(0);
+	dispc_runtime_put();
 }
 
 int omap_dispc_register_isr(omap_dispc_isr_t isr, void *arg, u32 mask)
@@ -3560,13 +3637,6 @@ static void _omap_dispc_initial_config(void)
 {
 	u32 l;
 
-	l = dispc_read_reg(DISPC_SYSCONFIG);
-	l = FLD_MOD(l, 2, 13, 12);	/* MIDLEMODE: smart standby */
-	l = FLD_MOD(l, 2, 4, 3);	/* SIDLEMODE: smart idle */
-	l = FLD_MOD(l, 1, 2, 2);	/* ENWAKEUP */
-	l = FLD_MOD(l, 1, 0, 0);	/* AUTOIDLE */
-	dispc_write_reg(DISPC_SYSCONFIG, l);
-
 	/* Exclusively enable DISPC_CORE_CLK and set divider to 1 */
 	if (dss_has_feature(FEAT_CORE_CLK_DIV)) {
 		l = dispc_read_reg(DISPC_DIVISOR);
@@ -3596,9 +3666,9 @@ int dispc_enable_plane(enum omap_plane plane, bool enable)
 {
 	DSSDBG("dispc_enable_plane %d, %d\n", plane, enable);
 
-	enable_clocks(1);
+	dispc_runtime_get();
 	_dispc_enable_plane(plane, enable);
-	enable_clocks(0);
+	dispc_runtime_put();
 
 	return 0;
 }
@@ -3625,7 +3695,7 @@ int dispc_setup_plane(enum omap_plane plane,
 	       ilace, color_mode,
 	       rotation, mirror, channel);
 
-	enable_clocks(1);
+	dispc_runtime_get();
 
 	r = _dispc_setup_plane(plane,
 			   paddr, screen_width,
@@ -3639,7 +3709,7 @@ int dispc_setup_plane(enum omap_plane plane,
 			   pre_mult_alpha,
 			   channel, puv_addr);
 
-	enable_clocks(0);
+	dispc_runtime_put();
 
 	return r;
 }
@@ -3650,9 +3720,19 @@ static int omap_dispchw_probe(struct platform_device *pdev)
 	u32 rev;
 	int r = 0;
 	struct resource *dispc_mem;
+	struct clk *clk;
 
 	dispc.pdev = pdev;
 
+	clk = clk_get(&pdev->dev, "dss_clk");
+	if (IS_ERR(clk)) {
+		DSSERR("can't get dss_clk\n");
+		r = PTR_ERR(clk);
+		goto err_get_clk;
+	}
+
+	dispc.dss_clk = clk;
+
 	spin_lock_init(&dispc.irq_lock);
 
 #ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
@@ -3666,62 +3746,106 @@ static int omap_dispchw_probe(struct platform_device *pdev)
 	if (!dispc_mem) {
 		DSSERR("can't get IORESOURCE_MEM DISPC\n");
 		r = -EINVAL;
-		goto fail0;
+		goto err_ioremap;
 	}
 	dispc.base = ioremap(dispc_mem->start, resource_size(dispc_mem));
 	if (!dispc.base) {
 		DSSERR("can't ioremap DISPC\n");
 		r = -ENOMEM;
-		goto fail0;
+		goto err_ioremap;
 	}
 	dispc.irq = platform_get_irq(dispc.pdev, 0);
 	if (dispc.irq < 0) {
 		DSSERR("platform_get_irq failed\n");
 		r = -ENODEV;
-		goto fail1;
+		goto err_irq;
 	}
 
 	r = request_irq(dispc.irq, omap_dispc_irq_handler, IRQF_SHARED,
 		"OMAP DISPC", dispc.pdev);
 	if (r < 0) {
 		DSSERR("request_irq failed\n");
-		goto fail1;
+		goto err_irq;
 	}
 
-	enable_clocks(1);
+	dispc_init_ctx_loss_count();
+
+	pm_runtime_enable(&pdev->dev);
+
+	r = dispc_runtime_get();
+	if (r)
+		goto err_runtime_get;
 
 	_omap_dispc_initial_config();
 
 	_omap_dispc_initialize_irq();
 
-	dispc_save_context();
-
 	rev = dispc_read_reg(DISPC_REVISION);
 	dev_dbg(&pdev->dev, "OMAP DISPC rev %d.%d\n",
 	       FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
 
-	enable_clocks(0);
+	dispc_runtime_put();
 
 	return 0;
-fail1:
+
+err_runtime_get:
+	pm_runtime_disable(&pdev->dev);
+	free_irq(dispc.irq, dispc.pdev);
+err_irq:
 	iounmap(dispc.base);
-fail0:
+err_ioremap:
+	clk_put(dispc.dss_clk);
+err_get_clk:
 	return r;
 }
 
 static int omap_dispchw_remove(struct platform_device *pdev)
 {
+	pm_runtime_disable(&pdev->dev);
+
+	clk_put(dispc.dss_clk);
+
 	free_irq(dispc.irq, dispc.pdev);
 	iounmap(dispc.base);
 	return 0;
 }
 
+static int dispc_runtime_suspend(struct device *dev)
+{
+	dispc_save_context();
+	clk_disable(dispc.dss_clk);
+	dss_runtime_put();
+
+	return 0;
+}
+
+static int dispc_runtime_resume(struct device *dev)
+{
+	int r;
+
+	r = dss_runtime_get();
+	if (r < 0)
+		return r;
+
+	clk_enable(dispc.dss_clk);
+	if (dispc_need_ctx_restore())
+		dispc_restore_context();
+
+	return 0;
+}
+
+static const struct dev_pm_ops dispc_pm_ops = {
+	.runtime_suspend = dispc_runtime_suspend,
+	.runtime_resume = dispc_runtime_resume,
+};
+
 static struct platform_driver omap_dispchw_driver = {
 	.probe          = omap_dispchw_probe,
 	.remove         = omap_dispchw_remove,
 	.driver         = {
 		.name   = "omapdss_dispc",
 		.owner  = THIS_MODULE,
+		.pm	= &dispc_pm_ops,
 	},
 };
 
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index bab55cd..f053b18 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -23,7 +23,6 @@
 #define DSS_SUBSYS_NAME "DPI"
 
 #include <linux/kernel.h>
-#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/errno.h>
@@ -130,8 +129,6 @@ static int dpi_set_mode(struct omap_dss_device *dssdev)
 	bool is_tft;
 	int r = 0;
 
-	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
-
 	dispc_set_pol_freq(dssdev->manager->id, dssdev->panel.config,
 			dssdev->panel.acbi, dssdev->panel.acb);
 
@@ -144,7 +141,7 @@ static int dpi_set_mode(struct omap_dss_device *dssdev)
 		r = dpi_set_dispc_clk(dssdev, is_tft, t->pixel_clock * 1000,
 				&fck, &lck_div, &pck_div);
 	if (r)
-		goto err0;
+		return r;
 
 	pck = fck / lck_div / pck_div / 1000;
 
@@ -158,12 +155,10 @@ static int dpi_set_mode(struct omap_dss_device *dssdev)
 
 	dispc_set_lcd_timings(dssdev->manager->id, t);
 
-err0:
-	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
-	return r;
+	return 0;
 }
 
-static int dpi_basic_init(struct omap_dss_device *dssdev)
+static void dpi_basic_init(struct omap_dss_device *dssdev)
 {
 	bool is_tft;
 
@@ -175,8 +170,6 @@ static int dpi_basic_init(struct omap_dss_device *dssdev)
 			OMAP_DSS_LCD_DISPLAY_TFT : OMAP_DSS_LCD_DISPLAY_STN);
 	dispc_set_tft_data_lines(dssdev->manager->id,
 			dssdev->phy.dpi.data_lines);
-
-	return 0;
 }
 
 int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
@@ -186,30 +179,38 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 	r = omap_dss_start_device(dssdev);
 	if (r) {
 		DSSERR("failed to start device\n");
-		goto err0;
+		goto err_start_dev;
 	}
 
 	if (cpu_is_omap34xx()) {
 		r = regulator_enable(dpi.vdds_dsi_reg);
 		if (r)
-			goto err1;
+			goto err_reg_enable;
 	}
 
-	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
+	r = dss_runtime_get();
+	if (r)
+		goto err_get_dss;
 
-	r = dpi_basic_init(dssdev);
+	r = dispc_runtime_get();
 	if (r)
-		goto err2;
+		goto err_get_dispc;
+
+	dpi_basic_init(dssdev);
 
 	if (dpi_use_dsi_pll(dssdev)) {
+		r = dsi_runtime_get(dpi.dsidev);
+		if (r)
+			goto err_get_dsi;
+
 		r = dsi_pll_init(dpi.dsidev, 0, 1);
 		if (r)
-			goto err2;
+			goto err_dsi_pll_init;
 	}
 
 	r = dpi_set_mode(dssdev);
 	if (r)
-		goto err3;
+		goto err_set_mode;
 
 	mdelay(2);
 
@@ -217,16 +218,22 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 
 	return 0;
 
-err3:
+err_set_mode:
 	if (dpi_use_dsi_pll(dssdev))
 		dsi_pll_uninit(dpi.dsidev, true);
-err2:
-	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
+err_dsi_pll_init:
+	if (dpi_use_dsi_pll(dssdev))
+		dsi_runtime_put(dpi.dsidev);
+err_get_dsi:
+	dispc_runtime_put();
+err_get_dispc:
+	dss_runtime_put();
+err_get_dss:
 	if (cpu_is_omap34xx())
 		regulator_disable(dpi.vdds_dsi_reg);
-err1:
+err_reg_enable:
 	omap_dss_stop_device(dssdev);
-err0:
+err_start_dev:
 	return r;
 }
 EXPORT_SYMBOL(omapdss_dpi_display_enable);
@@ -238,9 +245,11 @@ void omapdss_dpi_display_disable(struct omap_dss_device *dssdev)
 	if (dpi_use_dsi_pll(dssdev)) {
 		dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
 		dsi_pll_uninit(dpi.dsidev, true);
+		dsi_runtime_put(dpi.dsidev);
 	}
 
-	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
+	dispc_runtime_put();
+	dss_runtime_put();
 
 	if (cpu_is_omap34xx())
 		regulator_disable(dpi.vdds_dsi_reg);
@@ -252,11 +261,26 @@ EXPORT_SYMBOL(omapdss_dpi_display_disable);
 void dpi_set_timings(struct omap_dss_device *dssdev,
 			struct omap_video_timings *timings)
 {
+	int r;
+
 	DSSDBG("dpi_set_timings\n");
 	dssdev->panel.timings = *timings;
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
+		r = dss_runtime_get();
+		if (r)
+			return;
+
+		r = dispc_runtime_get();
+		if (r) {
+			dss_runtime_put();
+			return;
+		}
+
 		dpi_set_mode(dssdev);
 		dispc_go(dssdev->manager->id);
+
+		dispc_runtime_put();
+		dss_runtime_put();
 	}
 }
 EXPORT_SYMBOL(dpi_set_timings);
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 0609885..b6a57bb 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -36,6 +36,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/debugfs.h>
+#include <linux/pm_runtime.h>
 
 #include <video/omapdss.h>
 #include <plat/clock.h>
@@ -267,8 +268,12 @@ struct dsi_isr_tables {
 struct dsi_data {
 	struct platform_device *pdev;
 	void __iomem	*base;
+
 	int irq;
 
+	struct clk *dss_clk;
+	struct clk *sys_clk;
+
 	void (*dsi_mux_pads)(bool enable);
 
 	struct dsi_clock_info current_cinfo;
@@ -389,15 +394,6 @@ static inline u32 dsi_read_reg(struct platform_device *dsidev,
 	return __raw_readl(dsi->base + idx.idx);
 }
 
-
-void dsi_save_context(void)
-{
-}
-
-void dsi_restore_context(void)
-{
-}
-
 void dsi_bus_lock(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
@@ -1048,13 +1044,27 @@ static u32 dsi_get_errors(struct platform_device *dsidev)
 	return e;
 }
 
-/* DSI func clock. this could also be dsi_pll_hsdiv_dsi_clk */
-static inline void enable_clocks(bool enable)
+int dsi_runtime_get(struct platform_device *dsidev)
 {
-	if (enable)
-		dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
-	else
-		dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
+	int r;
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
+	DSSDBG("dsi_runtime_get\n");
+
+	r = pm_runtime_get_sync(&dsi->pdev->dev);
+	WARN_ON(r < 0);
+	return r < 0 ? r : 0;
+}
+
+void dsi_runtime_put(struct platform_device *dsidev)
+{
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	int r;
+
+	DSSDBG("dsi_runtime_put\n");
+
+	r = pm_runtime_put(&dsi->pdev->dev);
+	WARN_ON(r < 0);
 }
 
 /* source clock for DSI PLL. this could also be PCLKFREE */
@@ -1064,9 +1074,9 @@ static inline void dsi_enable_pll_clock(struct platform_device *dsidev,
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	if (enable)
-		dss_clk_enable(DSS_CLK_SYSCK);
+		clk_enable(dsi->sys_clk);
 	else
-		dss_clk_disable(DSS_CLK_SYSCK);
+		clk_disable(dsi->sys_clk);
 
 	if (enable && dsi->pll_locked) {
 		if (wait_for_bit_change(dsidev, DSI_PLL_STATUS, 1, 1) != 1)
@@ -1159,10 +1169,11 @@ static unsigned long dsi_fclk_rate(struct platform_device *dsidev)
 {
 	unsigned long r;
 	int dsi_module = dsi_get_dsidev_id(dsidev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	if (dss_get_dsi_clk_source(dsi_module) == OMAP_DSS_CLK_SRC_FCK) {
 		/* DSI FCLK source is DSS_CLK_FCK */
-		r = dss_clk_get_rate(DSS_CLK_FCK);
+		r = clk_get_rate(dsi->dss_clk);
 	} else {
 		/* DSI FCLK source is dsi_pll_hsdiv_dsi_clk */
 		r = dsi_get_pll_hsdiv_dsi_rate(dsidev);
@@ -1271,7 +1282,7 @@ static int dsi_calc_clock_rates(struct omap_dss_device *dssdev,
 		return -EINVAL;
 
 	if (cinfo->use_sys_clk) {
-		cinfo->clkin = dss_clk_get_rate(DSS_CLK_SYSCK);
+		cinfo->clkin = clk_get_rate(dsi->sys_clk);
 		/* XXX it is unclear if highfreq should be used
 		 * with DSS_SYS_CLK source also */
 		cinfo->highfreq = 0;
@@ -1320,7 +1331,7 @@ int dsi_pll_calc_clock_div_pck(struct platform_device *dsidev, bool is_tft,
 	int match = 0;
 	unsigned long dss_sys_clk, max_dss_fck;
 
-	dss_sys_clk = dss_clk_get_rate(DSS_CLK_SYSCK);
+	dss_sys_clk = clk_get_rate(dsi->sys_clk);
 
 	max_dss_fck = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
 
@@ -1610,7 +1621,6 @@ int dsi_pll_init(struct platform_device *dsidev, bool enable_hsclk,
 		dsi->vdds_dsi_reg = vdds_dsi;
 	}
 
-	enable_clocks(1);
 	dsi_enable_pll_clock(dsidev, 1);
 	/*
 	 * Note: SCP CLK is not required on OMAP3, but it is required on OMAP4.
@@ -1662,7 +1672,6 @@ err1:
 	}
 err0:
 	dsi_disable_scp_clk(dsidev);
-	enable_clocks(0);
 	dsi_enable_pll_clock(dsidev, 0);
 	return r;
 }
@@ -1680,7 +1689,6 @@ void dsi_pll_uninit(struct platform_device *dsidev, bool disconnect_lanes)
 	}
 
 	dsi_disable_scp_clk(dsidev);
-	enable_clocks(0);
 	dsi_enable_pll_clock(dsidev, 0);
 
 	DSSDBG("PLL uninit done\n");
@@ -1697,7 +1705,8 @@ static void dsi_dump_dsidev_clocks(struct platform_device *dsidev,
 	dispc_clk_src = dss_get_dispc_clk_source();
 	dsi_clk_src = dss_get_dsi_clk_source(dsi_module);
 
-	enable_clocks(1);
+	if (dsi_runtime_get(dsidev))
+		return;
 
 	seq_printf(s,	"- DSI%d PLL -\n", dsi_module + 1);
 
@@ -1740,7 +1749,7 @@ static void dsi_dump_dsidev_clocks(struct platform_device *dsidev,
 
 	seq_printf(s,	"LP_CLK\t\t%lu\n", cinfo->lp_clk);
 
-	enable_clocks(0);
+	dsi_runtime_put(dsidev);
 }
 
 void dsi_dump_clocks(struct seq_file *s)
@@ -1882,7 +1891,8 @@ static void dsi_dump_dsidev_regs(struct platform_device *dsidev,
 {
 #define DUMPREG(r) seq_printf(s, "%-35s %08x\n", #r, dsi_read_reg(dsidev, r))
 
-	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
+	if (dsi_runtime_get(dsidev))
+		return;
 	dsi_enable_scp_clk(dsidev);
 
 	DUMPREG(DSI_REVISION);
@@ -1956,7 +1966,7 @@ static void dsi_dump_dsidev_regs(struct platform_device *dsidev,
 	DUMPREG(DSI_PLL_CONFIGURATION2);
 
 	dsi_disable_scp_clk(dsidev);
-	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
+	dsi_runtime_put(dsidev);
 #undef DUMPREG
 }
 
@@ -2472,28 +2482,6 @@ static void dsi_cio_uninit(struct platform_device *dsidev)
 		dsi->dsi_mux_pads(false);
 }
 
-static int _dsi_wait_reset(struct platform_device *dsidev)
-{
-	int t = 0;
-
-	while (REG_GET(dsidev, DSI_SYSSTATUS, 0, 0) == 0) {
-		if (++t > 5) {
-			DSSERR("soft reset failed\n");
-			return -ENODEV;
-		}
-		udelay(1);
-	}
-
-	return 0;
-}
-
-static int _dsi_reset(struct platform_device *dsidev)
-{
-	/* Soft reset */
-	REG_FLD_MOD(dsidev, DSI_SYSCONFIG, 1, 1, 1);
-	return _dsi_wait_reset(dsidev);
-}
-
 static void dsi_config_tx_fifo(struct platform_device *dsidev,
 		enum fifo_size size1, enum fifo_size size2,
 		enum fifo_size size3, enum fifo_size size4)
@@ -4211,22 +4199,6 @@ static void dsi_display_uninit_dsi(struct omap_dss_device *dssdev,
 	dsi_pll_uninit(dsidev, disconnect_lanes);
 }
 
-static int dsi_core_init(struct platform_device *dsidev)
-{
-	/* Autoidle */
-	REG_FLD_MOD(dsidev, DSI_SYSCONFIG, 1, 0, 0);
-
-	/* ENWAKEUP */
-	REG_FLD_MOD(dsidev, DSI_SYSCONFIG, 1, 2, 2);
-
-	/* SIDLEMODE smart-idle */
-	REG_FLD_MOD(dsidev, DSI_SYSCONFIG, 2, 4, 3);
-
-	_dsi_initialize_irq(dsidev);
-
-	return 0;
-}
-
 int omapdss_dsi_display_enable(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
@@ -4242,37 +4214,37 @@ int omapdss_dsi_display_enable(struct omap_dss_device *dssdev)
 	r = omap_dss_start_device(dssdev);
 	if (r) {
 		DSSERR("failed to start device\n");
-		goto err0;
+		goto err_start_dev;
 	}
 
-	enable_clocks(1);
-	dsi_enable_pll_clock(dsidev, 1);
-
-	r = _dsi_reset(dsidev);
+	r = dsi_runtime_get(dsidev);
 	if (r)
-		goto err1;
+		goto err_get_dsi;
+
+	dsi_enable_pll_clock(dsidev, 1);
 
-	dsi_core_init(dsidev);
+	_dsi_initialize_irq(dsidev);
 
 	r = dsi_display_init_dispc(dssdev);
 	if (r)
-		goto err1;
+		goto err_init_dispc;
 
 	r = dsi_display_init_dsi(dssdev);
 	if (r)
-		goto err2;
+		goto err_init_dsi;
 
 	mutex_unlock(&dsi->lock);
 
 	return 0;
 
-err2:
+err_init_dsi:
 	dsi_display_uninit_dispc(dssdev);
-err1:
-	enable_clocks(0);
+err_init_dispc:
 	dsi_enable_pll_clock(dsidev, 0);
+	dsi_runtime_put(dsidev);
+err_get_dsi:
 	omap_dss_stop_device(dssdev);
-err0:
+err_start_dev:
 	mutex_unlock(&dsi->lock);
 	DSSDBG("dsi_display_enable FAILED\n");
 	return r;
@@ -4295,7 +4267,7 @@ void omapdss_dsi_display_disable(struct omap_dss_device *dssdev,
 
 	dsi_display_uninit_dsi(dssdev, disconnect_lanes, enter_ulps);
 
-	enable_clocks(0);
+	dsi_runtime_put(dsidev);
 	dsi_enable_pll_clock(dsidev, 0);
 
 	omap_dss_stop_device(dssdev);
@@ -4450,6 +4422,42 @@ static void dsi_calc_clock_param_ranges(struct platform_device *dsidev)
 	dsi->lpdiv_max = dss_feat_get_param_max(FEAT_PARAM_DSIPLL_LPDIV);
 }
 
+static int dsi_get_clocks(struct platform_device *dsidev)
+{
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	struct clk *clk;
+
+	clk = clk_get(&dsidev->dev, "dss_clk");
+	if (IS_ERR(clk)) {
+		DSSERR("can't get dss_clk\n");
+		return PTR_ERR(clk);
+	}
+
+	dsi->dss_clk = clk;
+
+	clk = clk_get(&dsidev->dev, "sys_clk");
+	if (IS_ERR(clk)) {
+		DSSERR("can't get sys_clk\n");
+		clk_put(dsi->dss_clk);
+		dsi->dss_clk = NULL;
+		return PTR_ERR(clk);
+	}
+
+	dsi->sys_clk = clk;
+
+	return 0;
+}
+
+static void dsi_put_clocks(struct platform_device *dsidev)
+{
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
+	if (dsi->dss_clk)
+		clk_put(dsi->dss_clk);
+	if (dsi->sys_clk)
+		clk_put(dsi->sys_clk);
+}
+
 /* DSI1 HW IP initialisation */
 static int omap_dsi1hw_probe(struct platform_device *dsidev)
 {
@@ -4463,7 +4471,7 @@ static int omap_dsi1hw_probe(struct platform_device *dsidev)
 	dsi = kzalloc(sizeof(*dsi), GFP_KERNEL);
 	if (!dsi) {
 		r = -ENOMEM;
-		goto err0;
+		goto err_alloc;
 	}
 
 	dsi->pdev = dsidev;
@@ -4486,6 +4494,12 @@ static int omap_dsi1hw_probe(struct platform_device *dsidev)
 	mutex_init(&dsi->lock);
 	sema_init(&dsi->bus_lock, 1);
 
+	r = dsi_get_clocks(dsidev);
+	if (r)
+		goto err_get_clk;
+
+	pm_runtime_enable(&dsidev->dev);
+
 	INIT_DELAYED_WORK_DEFERRABLE(&dsi->framedone_timeout_work,
 			dsi_framedone_timeout_work_callback);
 
@@ -4498,26 +4512,26 @@ static int omap_dsi1hw_probe(struct platform_device *dsidev)
 	if (!dsi_mem) {
 		DSSERR("can't get IORESOURCE_MEM DSI\n");
 		r = -EINVAL;
-		goto err1;
+		goto err_ioremap;
 	}
 	dsi->base = ioremap(dsi_mem->start, resource_size(dsi_mem));
 	if (!dsi->base) {
 		DSSERR("can't ioremap DSI\n");
 		r = -ENOMEM;
-		goto err1;
+		goto err_ioremap;
 	}
 	dsi->irq = platform_get_irq(dsi->pdev, 0);
 	if (dsi->irq < 0) {
 		DSSERR("platform_get_irq failed\n");
 		r = -ENODEV;
-		goto err2;
+		goto err_get_irq;
 	}
 
 	r = request_irq(dsi->irq, omap_dsi_irq_handler, IRQF_SHARED,
 		dev_name(&dsidev->dev), dsi->pdev);
 	if (r < 0) {
 		DSSERR("request_irq failed\n");
-		goto err2;
+		goto err_get_irq;
 	}
 
 	/* DSI VCs initialization */
@@ -4529,7 +4543,9 @@ static int omap_dsi1hw_probe(struct platform_device *dsidev)
 
 	dsi_calc_clock_param_ranges(dsidev);
 
-	enable_clocks(1);
+	r = dsi_runtime_get(dsidev);
+	if (r)
+		goto err_get_dsi;
 
 	rev = dsi_read_reg(dsidev, DSI_REVISION);
 	dev_dbg(&dsidev->dev, "OMAP DSI rev %d.%d\n",
@@ -4537,14 +4553,19 @@ static int omap_dsi1hw_probe(struct platform_device *dsidev)
 
 	dsi->num_data_lanes = dsi_get_num_data_lanes(dsidev);
 
-	enable_clocks(0);
+	dsi_runtime_put(dsidev);
 
 	return 0;
-err2:
+
+err_get_dsi:
+	free_irq(dsi->irq, dsi->pdev);
+err_get_irq:
 	iounmap(dsi->base);
-err1:
+err_ioremap:
+	pm_runtime_disable(&dsidev->dev);
+err_get_clk:
 	kfree(dsi);
-err0:
+err_alloc:
 	return r;
 }
 
@@ -4554,6 +4575,10 @@ static int omap_dsi1hw_remove(struct platform_device *dsidev)
 
 	WARN_ON(dsi->scp_clk_refcount > 0);
 
+	pm_runtime_disable(&dsidev->dev);
+
+	dsi_put_clocks(dsidev);
+
 	if (dsi->vdds_dsi_reg != NULL) {
 		if (dsi->vdds_dsi_enabled) {
 			regulator_disable(dsi->vdds_dsi_reg);
@@ -4572,12 +4597,53 @@ static int omap_dsi1hw_remove(struct platform_device *dsidev)
 	return 0;
 }
 
+static int dsi_runtime_suspend(struct device *dev)
+{
+	struct dsi_data *dsi = dsi_get_dsidrv_data(to_platform_device(dev));
+
+	clk_disable(dsi->dss_clk);
+
+	dispc_runtime_put();
+	dss_runtime_put();
+
+	return 0;
+}
+
+static int dsi_runtime_resume(struct device *dev)
+{
+	struct dsi_data *dsi = dsi_get_dsidrv_data(to_platform_device(dev));
+	int r;
+
+	r = dss_runtime_get();
+	if (r)
+		goto err_get_dss;
+
+	r = dispc_runtime_get();
+	if (r)
+		goto err_get_dispc;
+
+	clk_enable(dsi->dss_clk);
+
+	return 0;
+
+err_get_dispc:
+	dss_runtime_put();
+err_get_dss:
+	return r;
+}
+
+static const struct dev_pm_ops dsi_pm_ops = {
+	.runtime_suspend = dsi_runtime_suspend,
+	.runtime_resume = dsi_runtime_resume,
+};
+
 static struct platform_driver omap_dsi1hw_driver = {
 	.probe          = omap_dsi1hw_probe,
 	.remove         = omap_dsi1hw_remove,
 	.driver         = {
 		.name   = "omapdss_dsi1",
 		.owner  = THIS_MODULE,
+		.pm	= &dsi_pm_ops,
 	},
 };
 
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 810ea8c..4e36a07 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -29,6 +29,7 @@
 #include <linux/seq_file.h>
 #include <linux/clk.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 
 #include <video/omapdss.h>
 #include <plat/clock.h>
@@ -60,15 +61,11 @@ struct dss_reg {
 static struct {
 	struct platform_device *pdev;
 	void __iomem    *base;
+
 	int		ctx_loss_cnt;
 
 	struct clk	*dpll4_m4_ck;
-	struct clk	*dss_ick;
-	struct clk	*dss_fck;
-	struct clk	*dss_sys_clk;
-	struct clk	*dss_tv_fck;
-	struct clk	*dss_video_fck;
-	unsigned	num_clks_enabled;
+	struct clk	*dss_clk;
 
 	unsigned long	cache_req_pck;
 	unsigned long	cache_prate;
@@ -88,13 +85,6 @@ static const char * const dss_generic_clk_source_names[] = {
 	[OMAP_DSS_CLK_SRC_FCK]			= "DSS_FCK",
 };
 
-static void dss_clk_enable_all_no_ctx(void);
-static void dss_clk_disable_all_no_ctx(void);
-static void dss_clk_enable_no_ctx(enum dss_clock clks);
-static void dss_clk_disable_no_ctx(enum dss_clock clks);
-
-static int _omap_dss_wait_reset(void);
-
 static inline void dss_write_reg(const struct dss_reg idx, u32 val)
 {
 	__raw_writel(val, dss.base + idx.idx);
@@ -110,12 +100,10 @@ static inline u32 dss_read_reg(const struct dss_reg idx)
 #define RR(reg) \
 	dss_write_reg(DSS_##reg, dss.ctx[(DSS_##reg).idx / sizeof(u32)])
 
-void dss_save_context(void)
+static void dss_save_context(void)
 {
-	if (cpu_is_omap24xx())
-		return;
+	DSSDBG("dss_save_context\n");
 
-	SR(SYSCONFIG);
 	SR(CONTROL);
 
 	if (dss_feat_get_supported_displays(OMAP_DSS_CHANNEL_LCD) &
@@ -125,12 +113,10 @@ void dss_save_context(void)
 	}
 }
 
-void dss_restore_context(void)
+static void dss_restore_context(void)
 {
-	if (_omap_dss_wait_reset())
-		DSSERR("DSS not coming out of reset after sleep\n");
+	DSSDBG("dss_restore_context\n");
 
-	RR(SYSCONFIG);
 	RR(CONTROL);
 
 	if (dss_feat_get_supported_displays(OMAP_DSS_CHANNEL_LCD) &
@@ -235,6 +221,7 @@ const char *dss_get_generic_clk_source_name(enum omap_dss_clk_source clk_src)
 	return dss_generic_clk_source_names[clk_src];
 }
 
+
 void dss_dump_clocks(struct seq_file *s)
 {
 	unsigned long dpll4_ck_rate;
@@ -242,13 +229,14 @@ void dss_dump_clocks(struct seq_file *s)
 	const char *fclk_name, *fclk_real_name;
 	unsigned long fclk_rate;
 
-	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
+	if (dss_runtime_get())
+		return;
 
 	seq_printf(s, "- DSS -\n");
 
 	fclk_name = dss_get_generic_clk_source_name(OMAP_DSS_CLK_SRC_FCK);
 	fclk_real_name = dss_feat_get_clk_source_name(OMAP_DSS_CLK_SRC_FCK);
-	fclk_rate = dss_clk_get_rate(DSS_CLK_FCK);
+	fclk_rate = clk_get_rate(dss.dss_clk);
 
 	if (dss.dpll4_m4_ck) {
 		dpll4_ck_rate = clk_get_rate(clk_get_parent(dss.dpll4_m4_ck));
@@ -274,14 +262,15 @@ void dss_dump_clocks(struct seq_file *s)
 				fclk_rate);
 	}
 
-	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
+	dss_runtime_put();
 }
 
 void dss_dump_regs(struct seq_file *s)
 {
 #define DUMPREG(r) seq_printf(s, "%-35s %08x\n", #r, dss_read_reg(r))
 
-	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
+	if (dss_runtime_get())
+		return;
 
 	DUMPREG(DSS_REVISION);
 	DUMPREG(DSS_SYSCONFIG);
@@ -295,7 +284,7 @@ void dss_dump_regs(struct seq_file *s)
 		DUMPREG(DSS_SDI_STATUS);
 	}
 
-	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
+	dss_runtime_put();
 #undef DUMPREG
 }
 
@@ -438,7 +427,7 @@ int dss_calc_clock_rates(struct dss_clock_info *cinfo)
 	} else {
 		if (cinfo->fck_div != 0)
 			return -EINVAL;
-		cinfo->fck = dss_clk_get_rate(DSS_CLK_FCK);
+		cinfo->fck = clk_get_rate(dss.dss_clk);
 	}
 
 	return 0;
@@ -468,7 +457,7 @@ int dss_set_clock_div(struct dss_clock_info *cinfo)
 
 int dss_get_clock_div(struct dss_clock_info *cinfo)
 {
-	cinfo->fck = dss_clk_get_rate(DSS_CLK_FCK);
+	cinfo->fck = clk_get_rate(dss.dss_clk);
 
 	if (dss.dpll4_m4_ck) {
 		unsigned long prate;
@@ -513,7 +502,7 @@ int dss_calc_clock_div(bool is_tft, unsigned long req_pck,
 
 	max_dss_fck = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
 
-	fck = dss_clk_get_rate(DSS_CLK_FCK);
+	fck = clk_get_rate(dss.dss_clk);
 	if (req_pck == dss.cache_req_pck &&
 			((cpu_is_omap34xx() && prate == dss.cache_prate) ||
 			 dss.cache_dss_cinfo.fck == fck)) {
@@ -540,7 +529,7 @@ retry:
 	if (dss.dpll4_m4_ck == NULL) {
 		struct dispc_clock_info cur_dispc;
 		/* XXX can we change the clock on omap2? */
-		fck = dss_clk_get_rate(DSS_CLK_FCK);
+		fck = clk_get_rate(dss.dss_clk);
 		fck_div = 1;
 
 		dispc_find_clk_divs(is_tft, req_pck, fck, &cur_dispc);
@@ -617,28 +606,6 @@ found:
 	return 0;
 }
 
-static int _omap_dss_wait_reset(void)
-{
-	int t = 0;
-
-	while (REG_GET(DSS_SYSSTATUS, 0, 0) == 0) {
-		if (++t > 1000) {
-			DSSERR("soft reset failed\n");
-			return -ENODEV;
-		}
-		udelay(1);
-	}
-
-	return 0;
-}
-
-static int _omap_dss_reset(void)
-{
-	/* Soft reset */
-	REG_FLD_MOD(DSS_SYSCONFIG, 1, 1, 1);
-	return _omap_dss_wait_reset();
-}
-
 void dss_set_venc_output(enum omap_dss_venc_type type)
 {
 	int l = 0;
@@ -719,131 +686,45 @@ static bool dss_need_ctx_restore(void)
 	return true;
 }
 
-static void save_all_ctx(void)
-{
-	DSSDBG("save context\n");
-
-	dss_clk_enable_no_ctx(DSS_CLK_ICK | DSS_CLK_FCK);
-
-	dss_save_context();
-	dispc_save_context();
-#ifdef CONFIG_OMAP2_DSS_DSI
-	dsi_save_context();
-#endif
-
-	dss_clk_disable_no_ctx(DSS_CLK_ICK | DSS_CLK_FCK);
-}
-
-static void restore_all_ctx(void)
-{
-	DSSDBG("restore context\n");
-
-	dss_clk_enable_all_no_ctx();
-
-	dss_restore_context();
-	dispc_restore_context();
-#ifdef CONFIG_OMAP2_DSS_DSI
-	dsi_restore_context();
-#endif
-
-	dss_clk_disable_all_no_ctx();
-}
-
-static int dss_get_clock(struct clk **clock, const char *clk_name)
-{
-	struct clk *clk;
-
-	clk = clk_get(&dss.pdev->dev, clk_name);
-
-	if (IS_ERR(clk)) {
-		DSSERR("can't get clock %s", clk_name);
-		return PTR_ERR(clk);
-	}
-
-	*clock = clk;
-
-	DSSDBG("clk %s, rate %ld\n", clk_name, clk_get_rate(clk));
-
-	return 0;
-}
-
 static int dss_get_clocks(void)
 {
+	struct clk *clk;
 	int r;
-	struct clk *dpll4_m4_ck;
-	struct omap_display_platform_data *pdata = dss.pdev->dev.platform_data;
-
-	dss.dss_ick = NULL;
-	dss.dss_fck = NULL;
-	dss.dss_sys_clk = NULL;
-	dss.dss_tv_fck = NULL;
-	dss.dss_video_fck = NULL;
-
-	r = dss_get_clock(&dss.dss_ick, "ick");
-	if (r)
-		goto err;
 
-	r = dss_get_clock(&dss.dss_fck, "fck");
-	if (r)
-		goto err;
-
-	if (!pdata->opt_clock_available) {
-		r = -ENODEV;
+	clk = clk_get(&dss.pdev->dev, "dss_clk");
+	if (IS_ERR(clk)) {
+		DSSERR("can't get clock dss_clk\n");
+		r = PTR_ERR(clk);
 		goto err;
 	}
 
-	if (pdata->opt_clock_available("sys_clk")) {
-		r = dss_get_clock(&dss.dss_sys_clk, "sys_clk");
-		if (r)
-			goto err;
-	}
-
-	if (pdata->opt_clock_available("tv_clk")) {
-		r = dss_get_clock(&dss.dss_tv_fck, "tv_clk");
-		if (r)
-			goto err;
-	}
-
-	if (pdata->opt_clock_available("video_clk")) {
-		r = dss_get_clock(&dss.dss_video_fck, "video_clk");
-		if (r)
-			goto err;
-	}
+	dss.dss_clk = clk;
 
 	if (cpu_is_omap34xx()) {
-		dpll4_m4_ck = clk_get(NULL, "dpll4_m4_ck");
-		if (IS_ERR(dpll4_m4_ck)) {
+		clk = clk_get(NULL, "dpll4_m4_ck");
+		if (IS_ERR(clk)) {
 			DSSERR("Failed to get dpll4_m4_ck\n");
-			r = PTR_ERR(dpll4_m4_ck);
+			r = PTR_ERR(clk);
 			goto err;
 		}
 	} else if (cpu_is_omap44xx()) {
-		dpll4_m4_ck = clk_get(NULL, "dpll_per_m5x2_ck");
-		if (IS_ERR(dpll4_m4_ck)) {
+		clk = clk_get(NULL, "dpll_per_m5x2_ck");
+		if (IS_ERR(clk)) {
 			DSSERR("Failed to get dpll_per_m5x2_ck\n");
-			r = PTR_ERR(dpll4_m4_ck);
+			r = PTR_ERR(clk);
 			goto err;
 		}
 	} else { /* omap24xx */
-		dpll4_m4_ck = NULL;
+		clk = NULL;
 	}
 
-	dss.dpll4_m4_ck = dpll4_m4_ck;
-
+	dss.dpll4_m4_ck = clk;
 
 	return 0;
 
 err:
-	if (dss.dss_ick)
-		clk_put(dss.dss_ick);
-	if (dss.dss_fck)
-		clk_put(dss.dss_fck);
-	if (dss.dss_sys_clk)
-		clk_put(dss.dss_sys_clk);
-	if (dss.dss_tv_fck)
-		clk_put(dss.dss_tv_fck);
-	if (dss.dss_video_fck)
-		clk_put(dss.dss_video_fck);
+	if (dss.dss_clk)
+		clk_put(dss.dss_clk);
 	if (dss.dpll4_m4_ck)
 		clk_put(dss.dpll4_m4_ck);
 
@@ -854,139 +735,28 @@ static void dss_put_clocks(void)
 {
 	if (dss.dpll4_m4_ck)
 		clk_put(dss.dpll4_m4_ck);
-	if (dss.dss_video_fck)
-		clk_put(dss.dss_video_fck);
-	if (dss.dss_tv_fck)
-		clk_put(dss.dss_tv_fck);
-	if (dss.dss_sys_clk)
-		clk_put(dss.dss_sys_clk);
-	clk_put(dss.dss_fck);
-	clk_put(dss.dss_ick);
-}
-
-unsigned long dss_clk_get_rate(enum dss_clock clk)
-{
-	switch (clk) {
-	case DSS_CLK_ICK:
-		return clk_get_rate(dss.dss_ick);
-	case DSS_CLK_FCK:
-		return clk_get_rate(dss.dss_fck);
-	case DSS_CLK_SYSCK:
-		return clk_get_rate(dss.dss_sys_clk);
-	case DSS_CLK_TVFCK:
-		return clk_get_rate(dss.dss_tv_fck);
-	case DSS_CLK_VIDFCK:
-		return clk_get_rate(dss.dss_video_fck);
-	}
-
-	BUG();
-	return 0;
+	clk_put(dss.dss_clk);
 }
 
-static unsigned count_clk_bits(enum dss_clock clks)
+int dss_runtime_get(void)
 {
-	unsigned num_clks = 0;
-
-	if (clks & DSS_CLK_ICK)
-		++num_clks;
-	if (clks & DSS_CLK_FCK)
-		++num_clks;
-	if (clks & DSS_CLK_SYSCK)
-		++num_clks;
-	if (clks & DSS_CLK_TVFCK)
-		++num_clks;
-	if (clks & DSS_CLK_VIDFCK)
-		++num_clks;
-
-	return num_clks;
-}
-
-static void dss_clk_enable_no_ctx(enum dss_clock clks)
-{
-	unsigned num_clks = count_clk_bits(clks);
-
-	if (clks & DSS_CLK_ICK)
-		clk_enable(dss.dss_ick);
-	if (clks & DSS_CLK_FCK)
-		clk_enable(dss.dss_fck);
-	if ((clks & DSS_CLK_SYSCK) && dss.dss_sys_clk)
-		clk_enable(dss.dss_sys_clk);
-	if ((clks & DSS_CLK_TVFCK) && dss.dss_tv_fck)
-		clk_enable(dss.dss_tv_fck);
-	if ((clks & DSS_CLK_VIDFCK) && dss.dss_video_fck)
-		clk_enable(dss.dss_video_fck);
-
-	dss.num_clks_enabled += num_clks;
-}
-
-void dss_clk_enable(enum dss_clock clks)
-{
-	bool check_ctx = dss.num_clks_enabled == 0;
-
-	dss_clk_enable_no_ctx(clks);
-
-	/*
-	 * HACK: On omap4 the registers may not be accessible right after
-	 * enabling the clocks. At some point this will be handled by
-	 * pm_runtime, but for the time begin this should make things work.
-	 */
-	if (cpu_is_omap44xx() && check_ctx)
-		udelay(10);
-
-	if (check_ctx && cpu_is_omap34xx() && dss_need_ctx_restore())
-		restore_all_ctx();
-}
-
-static void dss_clk_disable_no_ctx(enum dss_clock clks)
-{
-	unsigned num_clks = count_clk_bits(clks);
-
-	if (clks & DSS_CLK_ICK)
-		clk_disable(dss.dss_ick);
-	if (clks & DSS_CLK_FCK)
-		clk_disable(dss.dss_fck);
-	if ((clks & DSS_CLK_SYSCK) && dss.dss_sys_clk)
-		clk_disable(dss.dss_sys_clk);
-	if ((clks & DSS_CLK_TVFCK) && dss.dss_tv_fck)
-		clk_disable(dss.dss_tv_fck);
-	if ((clks & DSS_CLK_VIDFCK) && dss.dss_video_fck)
-		clk_disable(dss.dss_video_fck);
-
-	dss.num_clks_enabled -= num_clks;
-}
-
-void dss_clk_disable(enum dss_clock clks)
-{
-	if (cpu_is_omap34xx()) {
-		unsigned num_clks = count_clk_bits(clks);
-
-		BUG_ON(dss.num_clks_enabled < num_clks);
+	int r;
 
-		if (dss.num_clks_enabled == num_clks)
-			save_all_ctx();
-	}
+	DSSDBG("dss_runtime_get\n");
 
-	dss_clk_disable_no_ctx(clks);
+	r = pm_runtime_get_sync(&dss.pdev->dev);
+	WARN_ON(r < 0);
+	return r < 0 ? r : 0;
 }
 
-static void dss_clk_enable_all_no_ctx(void)
+void dss_runtime_put(void)
 {
-	enum dss_clock clks;
-
-	clks = DSS_CLK_ICK | DSS_CLK_FCK | DSS_CLK_SYSCK | DSS_CLK_TVFCK;
-	if (cpu_is_omap34xx())
-		clks |= DSS_CLK_VIDFCK;
-	dss_clk_enable_no_ctx(clks);
-}
+	int r;
 
-static void dss_clk_disable_all_no_ctx(void)
-{
-	enum dss_clock clks;
+	DSSDBG("dss_runtime_put\n");
 
-	clks = DSS_CLK_ICK | DSS_CLK_FCK | DSS_CLK_SYSCK | DSS_CLK_TVFCK;
-	if (cpu_is_omap34xx())
-		clks |= DSS_CLK_VIDFCK;
-	dss_clk_disable_no_ctx(clks);
+	r = pm_runtime_put(&dss.pdev->dev);
+	WARN_ON(r < 0);
 }
 
 /* DEBUGFS */
@@ -1001,7 +771,6 @@ void dss_debug_dump_clocks(struct seq_file *s)
 }
 #endif
 
-
 /* DSS HW IP initialisation */
 static int omap_dsshw_probe(struct platform_device *pdev)
 {
@@ -1028,19 +797,13 @@ static int omap_dsshw_probe(struct platform_device *pdev)
 	if (r)
 		goto err_clocks;
 
-	dss_clk_enable_all_no_ctx();
-
 	dss_init_ctx_loss_count();
 
-	/* disable LCD and DIGIT output. This seems to fix the synclost
-	 * problem that we get, if the bootloader starts the DSS and
-	 * the kernel resets it */
-	omap_writel(omap_readl(0x48050440) & ~0x3, 0x48050440);
+	pm_runtime_enable(&pdev->dev);
 
-	_omap_dss_reset();
-
-	/* autoidle */
-	REG_FLD_MOD(DSS_SYSCONFIG, 1, 0, 0);
+	r = dss_runtime_get();
+	if (r)
+		goto err_runtime_get;
 
 	/* Select DPLL */
 	REG_FLD_MOD(DSS_CONTROL, 0, 0, 0);
@@ -1068,19 +831,19 @@ static int omap_dsshw_probe(struct platform_device *pdev)
 		goto err_sdi;
 	}
 
-	dss_save_context();
-
 	rev = dss_read_reg(DSS_REVISION);
 	printk(KERN_INFO "OMAP DSS rev %d.%d\n",
 			FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
 
-	dss_clk_disable_all_no_ctx();
+	dss_runtime_put();
 
 	return 0;
 err_sdi:
 	dpi_exit();
 err_dpi:
-	dss_clk_disable_all_no_ctx();
+	dss_runtime_put();
+err_runtime_get:
+	pm_runtime_disable(&pdev->dev);
 	dss_put_clocks();
 err_clocks:
 	iounmap(dss.base);
@@ -1095,25 +858,40 @@ static int omap_dsshw_remove(struct platform_device *pdev)
 
 	iounmap(dss.base);
 
-	/*
-	 * As part of hwmod changes, DSS is not the only controller of dss
-	 * clocks; hwmod framework itself will also enable clocks during hwmod
-	 * init for dss, and autoidle is set in h/w for DSS. Hence, there's no
-	 * need to disable clocks if their usecounts > 1.
-	 */
-	WARN_ON(dss.num_clks_enabled > 0);
+	pm_runtime_disable(&pdev->dev);
 
 	dss_put_clocks();
 
 	return 0;
 }
 
+static int dss_runtime_suspend(struct device *dev)
+{
+	dss_save_context();
+	clk_disable(dss.dss_clk);
+	return 0;
+}
+
+static int dss_runtime_resume(struct device *dev)
+{
+	clk_enable(dss.dss_clk);
+	if (dss_need_ctx_restore())
+		dss_restore_context();
+	return 0;
+}
+
+static const struct dev_pm_ops dss_pm_ops = {
+	.runtime_suspend = dss_runtime_suspend,
+	.runtime_resume = dss_runtime_resume,
+};
+
 static struct platform_driver omap_dsshw_driver = {
 	.probe          = omap_dsshw_probe,
 	.remove         = omap_dsshw_remove,
 	.driver         = {
 		.name   = "omapdss_dss",
 		.owner  = THIS_MODULE,
+		.pm	= &dss_pm_ops,
 	},
 };
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index aeb611d..ce17a61 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -109,14 +109,6 @@ enum omap_parallel_interface_mode {
 	OMAP_DSS_PARALLELMODE_DSI,
 };
 
-enum dss_clock {
-	DSS_CLK_ICK	= 1 << 0,	/* DSS_L3_ICLK and DSS_L4_ICLK */
-	DSS_CLK_FCK	= 1 << 1,	/* DSS1_ALWON_FCLK */
-	DSS_CLK_SYSCK	= 1 << 2,	/* DSS2_ALWON_FCLK */
-	DSS_CLK_TVFCK	= 1 << 3,	/* DSS_TV_FCLK */
-	DSS_CLK_VIDFCK	= 1 << 4,	/* DSS_96M_FCLK*/
-};
-
 enum dss_hdmi_venc_clk_source_select {
 	DSS_VENC_TV_CLK = 0,
 	DSS_HDMI_M_PCLK = 1,
@@ -220,12 +212,10 @@ void dss_recheck_connections(struct omap_dss_device *dssdev, bool force);
 int dss_init_platform_driver(void);
 void dss_uninit_platform_driver(void);
 
+int dss_runtime_get(void);
+void dss_runtime_put(void);
+
 void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select);
-void dss_save_context(void);
-void dss_restore_context(void);
-void dss_clk_enable(enum dss_clock clks);
-void dss_clk_disable(enum dss_clock clks);
-unsigned long dss_clk_get_rate(enum dss_clock clk);
 const char *dss_get_generic_clk_source_name(enum omap_dss_clk_source clk_src);
 void dss_dump_clocks(struct seq_file *s);
 
@@ -282,15 +272,15 @@ struct file_operations;
 int dsi_init_platform_driver(void);
 void dsi_uninit_platform_driver(void);
 
+int dsi_runtime_get(struct platform_device *dsidev);
+void dsi_runtime_put(struct platform_device *dsidev);
+
 void dsi_dump_clocks(struct seq_file *s);
 void dsi_create_debugfs_files_irq(struct dentry *debugfs_dir,
 		const struct file_operations *debug_fops);
 void dsi_create_debugfs_files_reg(struct dentry *debugfs_dir,
 		const struct file_operations *debug_fops);
 
-void dsi_save_context(void);
-void dsi_restore_context(void);
-
 int dsi_init_display(struct omap_dss_device *display);
 void dsi_irq_handler(void);
 unsigned long dsi_get_pll_hsdiv_dispc_rate(struct platform_device *dsidev);
@@ -316,6 +306,13 @@ static inline int dsi_init_platform_driver(void)
 static inline void dsi_uninit_platform_driver(void)
 {
 }
+static inline int dsi_runtime_get(struct platform_device *dsidev)
+{
+	return 0;
+}
+static inline void dsi_runtime_put(struct platform_device *dsidev)
+{
+}
 static inline unsigned long dsi_get_pll_hsdiv_dispc_rate(struct platform_device *dsidev)
 {
 	WARN("%s: DSI not compiled in, returning rate as 0\n", __func__);
@@ -383,8 +380,8 @@ void dispc_dump_regs(struct seq_file *s);
 void dispc_irq_handler(void);
 void dispc_fake_vsync_irq(void);
 
-void dispc_save_context(void);
-void dispc_restore_context(void);
+int dispc_runtime_get(void);
+void dispc_runtime_put(void);
 
 void dispc_enable_sidle(void);
 void dispc_disable_sidle(void);
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index b630c98..1bbf313 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -30,6 +30,8 @@
 #include <linux/delay.h>
 #include <linux/string.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/clk.h>
 #include <video/omapdss.h>
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
@@ -52,6 +54,9 @@ static struct {
 	u8 edid_set;
 	bool custom_set;
 	struct hdmi_config cfg;
+
+	struct clk *sys_clk;
+	struct clk *hdmi_clk;
 } hdmi;
 
 /*
@@ -163,6 +168,27 @@ static inline int hdmi_wait_for_bit_change(const struct hdmi_reg idx,
 	return val;
 }
 
+static int hdmi_runtime_get(void)
+{
+	int r;
+
+	DSSDBG("hdmi_runtime_get\n");
+
+	r = pm_runtime_get_sync(&hdmi.pdev->dev);
+	WARN_ON(r < 0);
+	return r < 0 ? r : 0;
+}
+
+static void hdmi_runtime_put(void)
+{
+	int r;
+
+	DSSDBG("hdmi_runtime_put\n");
+
+	r = pm_runtime_put(&hdmi.pdev->dev);
+	WARN_ON(r < 0);
+}
+
 int hdmi_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("init_display\n");
@@ -312,30 +338,11 @@ static int hdmi_phy_init(void)
 	return 0;
 }
 
-static int hdmi_wait_softreset(void)
-{
-	/* reset W1 */
-	REG_FLD_MOD(HDMI_WP_SYSCONFIG, 0x1, 0, 0);
-
-	/* wait till SOFTRESET == 0 */
-	if (hdmi_wait_for_bit_change(HDMI_WP_SYSCONFIG, 0, 0, 0) != 0) {
-		DSSERR("sysconfig reset failed\n");
-		return -ETIMEDOUT;
-	}
-
-	return 0;
-}
-
 static int hdmi_pll_program(struct hdmi_pll_info *fmt)
 {
 	u16 r = 0;
 	enum hdmi_clk_refsel refsel;
 
-	/* wait for wrapper reset */
-	r = hdmi_wait_softreset();
-	if (r)
-		return r;
-
 	r = hdmi_set_pll_pwr(HDMI_PLLPWRCMD_ALLOFF);
 	if (r)
 		return r;
@@ -1065,7 +1072,7 @@ static void hdmi_compute_pll(struct omap_dss_device *dssdev, int phy,
 	unsigned long clkin, refclk;
 	u32 mf;
 
-	clkin = dss_clk_get_rate(DSS_CLK_SYSCK) / 10000;
+	clkin = clk_get_rate(hdmi.sys_clk) / 10000;
 	/*
 	 * Input clock is predivided by N + 1
 	 * out put of which is reference clk
@@ -1099,16 +1106,6 @@ static void hdmi_compute_pll(struct omap_dss_device *dssdev, int phy,
 	DSSDBG("range = %d sd = %d\n", pi->dcofreq, pi->regsd);
 }
 
-static void hdmi_enable_clocks(int enable)
-{
-	if (enable)
-		dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK |
-				DSS_CLK_SYSCK | DSS_CLK_VIDFCK);
-	else
-		dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK |
-				DSS_CLK_SYSCK | DSS_CLK_VIDFCK);
-}
-
 static int hdmi_power_on(struct omap_dss_device *dssdev)
 {
 	int r, code = 0;
@@ -1116,7 +1113,9 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	struct omap_video_timings *p;
 	unsigned long phy;
 
-	hdmi_enable_clocks(1);
+	r = hdmi_runtime_get();
+	if (r)
+		return r;
 
 	dispc_enable_channel(OMAP_DSS_CHANNEL_DIGIT, 0);
 
@@ -1181,7 +1180,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 
 	return 0;
 err:
-	hdmi_enable_clocks(0);
+	hdmi_runtime_put();
 	return -EIO;
 }
 
@@ -1192,7 +1191,7 @@ static void hdmi_power_off(struct omap_dss_device *dssdev)
 	hdmi_wp_video_start(0);
 	hdmi_phy_off();
 	hdmi_set_pll_pwr(HDMI_PLLPWRCMD_ALLOFF);
-	hdmi_enable_clocks(0);
+	hdmi_runtime_put();
 
 	hdmi.edid_set = 0;
 }
@@ -1687,14 +1686,43 @@ static struct snd_soc_dai_driver hdmi_codec_dai_drv = {
 };
 #endif
 
+static int hdmi_get_clocks(struct platform_device *pdev)
+{
+	struct clk *clk;
+
+	clk = clk_get(&pdev->dev, "sys_clk");
+	if (IS_ERR(clk)) {
+		DSSERR("can't get sys_clk\n");
+		return PTR_ERR(clk);
+	}
+
+	hdmi.sys_clk = clk;
+
+	clk = clk_get(&pdev->dev, "hdmi_clk");
+	if (IS_ERR(clk)) {
+		DSSERR("can't get hdmi_clk\n");
+		clk_put(hdmi.sys_clk);
+		return PTR_ERR(clk);
+	}
+
+	hdmi.hdmi_clk = clk;
+
+	return 0;
+}
+
+static void hdmi_put_clocks(void)
+{
+	if (hdmi.sys_clk)
+		clk_put(hdmi.sys_clk);
+	if (hdmi.hdmi_clk)
+		clk_put(hdmi.hdmi_clk);
+}
+
 /* HDMI HW IP initialisation */
 static int omapdss_hdmihw_probe(struct platform_device *pdev)
 {
 	struct resource *hdmi_mem;
-#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
-	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
-	int ret;
-#endif
+	int r;
 
 	hdmi.pdata = pdev->dev.platform_data;
 	hdmi.pdev = pdev;
@@ -1714,17 +1742,25 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	r = hdmi_get_clocks(pdev);
+	if (r) {
+		iounmap(hdmi.base_wp);
+		return r;
+	}
+
+	pm_runtime_enable(&pdev->dev);
+
 	hdmi_panel_init();
 
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
 
 	/* Register ASoC codec DAI */
-	ret = snd_soc_register_codec(&pdev->dev, &hdmi_audio_codec_drv,
+	r = snd_soc_register_codec(&pdev->dev, &hdmi_audio_codec_drv,
 					&hdmi_codec_dai_drv, 1);
-	if (ret) {
+	if (r) {
 		DSSERR("can't register ASoC HDMI audio codec\n");
-		return ret;
+		return r;
 	}
 #endif
 	return 0;
@@ -1739,17 +1775,62 @@ static int omapdss_hdmihw_remove(struct platform_device *pdev)
 	snd_soc_unregister_codec(&pdev->dev);
 #endif
 
+	pm_runtime_disable(&pdev->dev);
+
+	hdmi_put_clocks();
+
 	iounmap(hdmi.base_wp);
 
 	return 0;
 }
 
+static int hdmi_runtime_suspend(struct device *dev)
+{
+	clk_disable(hdmi.hdmi_clk);
+	clk_disable(hdmi.sys_clk);
+
+	dispc_runtime_put();
+	dss_runtime_put();
+
+	return 0;
+}
+
+static int hdmi_runtime_resume(struct device *dev)
+{
+	int r;
+
+	r = dss_runtime_get();
+	if (r < 0)
+		goto err_get_dss;
+
+	r = dispc_runtime_get();
+	if (r < 0)
+		goto err_get_dispc;
+
+
+	clk_enable(hdmi.sys_clk);
+	clk_enable(hdmi.hdmi_clk);
+
+	return 0;
+
+err_get_dispc:
+	dss_runtime_put();
+err_get_dss:
+	return r;
+}
+
+static const struct dev_pm_ops hdmi_pm_ops = {
+	.runtime_suspend = hdmi_runtime_suspend,
+	.runtime_resume = hdmi_runtime_resume,
+};
+
 static struct platform_driver omapdss_hdmihw_driver = {
 	.probe          = omapdss_hdmihw_probe,
 	.remove         = omapdss_hdmihw_remove,
 	.driver         = {
 		.name   = "omapdss_hdmi",
 		.owner  = THIS_MODULE,
+		.pm	= &hdmi_pm_ops,
 	},
 };
 
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 9aeea50..a148a80 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -1236,6 +1236,10 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 
 	DSSDBG("omap_dss_mgr_apply(%s)\n", mgr->name);
 
+	r = dispc_runtime_get();
+	if (r)
+		return r;
+
 	spin_lock_irqsave(&dss_cache.lock, flags);
 
 	/* Configure overlays */
@@ -1409,7 +1413,6 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 	}
 
 	r = 0;
-	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
 	if (!dss_cache.irq_enabled) {
 		u32 mask;
 
@@ -1422,10 +1425,11 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 		dss_cache.irq_enabled = true;
 	}
 	configure_dispc();
-	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
 
 	spin_unlock_irqrestore(&dss_cache.lock, flags);
 
+	dispc_runtime_put();
+
 	return r;
 }
 
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index cfbfc57..c84380c 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -84,32 +84,42 @@ static ssize_t overlay_manager_store(struct omap_overlay *ovl, const char *buf,
 
 	old_mgr = ovl->manager;
 
+	r = dispc_runtime_get();
+	if (r)
+		return r;
+
 	/* detach old manager */
 	if (old_mgr) {
 		r = ovl->unset_manager(ovl);
 		if (r) {
 			DSSERR("detach failed\n");
-			return r;
+			goto err;
 		}
 
 		r = old_mgr->apply(old_mgr);
 		if (r)
-			return r;
+			goto err;
 	}
 
 	if (mgr) {
 		r = ovl->set_manager(ovl, mgr);
 		if (r) {
 			DSSERR("Failed to attach overlay\n");
-			return r;
+			goto err;
 		}
 
 		r = mgr->apply(mgr);
 		if (r)
-			return r;
+			goto err;
 	}
 
+	dispc_runtime_put();
+
 	return size;
+
+err:
+	dispc_runtime_put();
+	return r;
 }
 
 static ssize_t overlay_input_size_show(struct omap_overlay *ovl, char *buf)
@@ -507,7 +517,6 @@ static int omap_dss_set_manager(struct omap_overlay *ovl,
 
 	ovl->manager = mgr;
 
-	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
 	/* XXX: When there is an overlay on a DSI manual update display, and
 	 * the overlay is first disabled, then moved to tv, and enabled, we
 	 * seem to get SYNC_LOST_DIGIT error.
@@ -521,7 +530,6 @@ static int omap_dss_set_manager(struct omap_overlay *ovl,
 	 * the overlay, but before moving the overlay to TV.
 	 */
 	dispc_set_channel_out(ovl->id, mgr->id);
-	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
 
 	return 0;
 }
@@ -722,6 +730,8 @@ void dss_recheck_connections(struct omap_dss_device *dssdev, bool force)
 	}
 
 	if (mgr) {
+		dispc_runtime_get();
+
 		for (i = 0; i < dss_feat_get_num_ovls(); i++) {
 			struct omap_overlay *ovl;
 			ovl = omap_dss_get_overlay(i);
@@ -731,6 +741,8 @@ void dss_recheck_connections(struct omap_dss_device *dssdev, bool force)
 				omap_dss_set_manager(ovl, mgr);
 			}
 		}
+
+		dispc_runtime_put();
 	}
 }
 
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index a873104..c57e3fb 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -34,6 +34,7 @@
 #include <linux/seq_file.h>
 #include <linux/semaphore.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 
 #include <video/omapdss.h>
 #include "dss.h"
@@ -121,12 +122,25 @@ static inline u32 rfbi_read_reg(const struct rfbi_reg idx)
 	return __raw_readl(rfbi.base + idx.idx);
 }
 
-static void rfbi_enable_clocks(bool enable)
+static int rfbi_runtime_get(void)
 {
-	if (enable)
-		dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
-	else
-		dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
+	int r;
+
+	DSSDBG("rfbi_runtime_get\n");
+
+	r = pm_runtime_get_sync(&rfbi.pdev->dev);
+	WARN_ON(r < 0);
+	return r < 0 ? r : 0;
+}
+
+static void rfbi_runtime_put(void)
+{
+	int r;
+
+	DSSDBG("rfbi_runtime_put\n");
+
+	r = pm_runtime_put(&rfbi.pdev->dev);
+	WARN_ON(r < 0);
 }
 
 void rfbi_bus_lock(void)
@@ -806,7 +820,8 @@ void rfbi_dump_regs(struct seq_file *s)
 {
 #define DUMPREG(r) seq_printf(s, "%-35s %08x\n", #r, rfbi_read_reg(r))
 
-	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
+	if (rfbi_runtime_get())
+		return;
 
 	DUMPREG(RFBI_REVISION);
 	DUMPREG(RFBI_SYSCONFIG);
@@ -837,7 +852,7 @@ void rfbi_dump_regs(struct seq_file *s)
 	DUMPREG(RFBI_VSYNC_WIDTH);
 	DUMPREG(RFBI_HSYNC_WIDTH);
 
-	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
+	rfbi_runtime_put();
 #undef DUMPREG
 }
 
@@ -845,7 +860,9 @@ int omapdss_rfbi_display_enable(struct omap_dss_device *dssdev)
 {
 	int r;
 
-	rfbi_enable_clocks(1);
+	r = rfbi_runtime_get();
+	if (r)
+		return r;
 
 	r = omap_dss_start_device(dssdev);
 	if (r) {
@@ -880,6 +897,7 @@ int omapdss_rfbi_display_enable(struct omap_dss_device *dssdev)
 err1:
 	omap_dss_stop_device(dssdev);
 err0:
+	rfbi_runtime_put();
 	return r;
 }
 EXPORT_SYMBOL(omapdss_rfbi_display_enable);
@@ -890,7 +908,7 @@ void omapdss_rfbi_display_disable(struct omap_dss_device *dssdev)
 			DISPC_IRQ_FRAMEDONE);
 	omap_dss_stop_device(dssdev);
 
-	rfbi_enable_clocks(0);
+	rfbi_runtime_put();
 }
 EXPORT_SYMBOL(omapdss_rfbi_display_disable);
 
@@ -905,8 +923,9 @@ int rfbi_init_display(struct omap_dss_device *dssdev)
 static int omap_rfbihw_probe(struct platform_device *pdev)
 {
 	u32 rev;
-	u32 l;
 	struct resource *rfbi_mem;
+	struct clk *clk;
+	int r;
 
 	rfbi.pdev = pdev;
 
@@ -915,46 +934,99 @@ static int omap_rfbihw_probe(struct platform_device *pdev)
 	rfbi_mem = platform_get_resource(rfbi.pdev, IORESOURCE_MEM, 0);
 	if (!rfbi_mem) {
 		DSSERR("can't get IORESOURCE_MEM RFBI\n");
-		return -EINVAL;
+		r = -EINVAL;
+		goto err_ioremap;
 	}
 	rfbi.base = ioremap(rfbi_mem->start, resource_size(rfbi_mem));
 	if (!rfbi.base) {
 		DSSERR("can't ioremap RFBI\n");
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto err_ioremap;
 	}
 
-	rfbi_enable_clocks(1);
+	pm_runtime_enable(&pdev->dev);
+
+	r = rfbi_runtime_get();
+	if (r)
+		goto err_get_rfbi;
 
 	msleep(10);
 
-	rfbi.l4_khz = dss_clk_get_rate(DSS_CLK_ICK) / 1000;
+	clk = clk_get(&pdev->dev, "rfbi_iclk");
+	if (IS_ERR(clk)) {
+		DSSERR("can't get rfbi_iclk\n");
+		r = PTR_ERR(clk);
+		goto err_get_ick;
+	}
+
+	rfbi.l4_khz = clk_get_rate(clk) / 1000;
 
-	/* Enable autoidle and smart-idle */
-	l = rfbi_read_reg(RFBI_SYSCONFIG);
-	l |= (1 << 0) | (2 << 3);
-	rfbi_write_reg(RFBI_SYSCONFIG, l);
+	clk_put(clk);
 
 	rev = rfbi_read_reg(RFBI_REVISION);
 	dev_dbg(&pdev->dev, "OMAP RFBI rev %d.%d\n",
 	       FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
 
-	rfbi_enable_clocks(0);
+	rfbi_runtime_put();
 
 	return 0;
+
+err_get_ick:
+	rfbi_runtime_put();
+err_get_rfbi:
+	pm_runtime_disable(&pdev->dev);
+	iounmap(rfbi.base);
+err_ioremap:
+	return r;
 }
 
 static int omap_rfbihw_remove(struct platform_device *pdev)
 {
+	pm_runtime_disable(&pdev->dev);
 	iounmap(rfbi.base);
 	return 0;
 }
 
+static int rfbi_runtime_suspend(struct device *dev)
+{
+	dispc_runtime_put();
+	dss_runtime_put();
+
+	return 0;
+}
+
+static int rfbi_runtime_resume(struct device *dev)
+{
+	int r;
+
+	r = dss_runtime_get();
+	if (r < 0)
+		goto err_get_dss;
+
+	r = dispc_runtime_get();
+	if (r < 0)
+		goto err_get_dispc;
+
+	return 0;
+
+err_get_dispc:
+	dss_runtime_put();
+err_get_dss:
+	return r;
+}
+
+static const struct dev_pm_ops rfbi_pm_ops = {
+	.runtime_suspend = rfbi_runtime_suspend,
+	.runtime_resume = rfbi_runtime_resume,
+};
+
 static struct platform_driver omap_rfbihw_driver = {
 	.probe          = omap_rfbihw_probe,
 	.remove         = omap_rfbihw_remove,
 	.driver         = {
 		.name   = "omapdss_rfbi",
 		.owner  = THIS_MODULE,
+		.pm	= &rfbi_pm_ops,
 	},
 };
 
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 0bd4b03..3a688c8 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -20,13 +20,11 @@
 #define DSS_SUBSYS_NAME "SDI"
 
 #include <linux/kernel.h>
-#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/regulator/consumer.h>
 
 #include <video/omapdss.h>
-#include <plat/cpu.h>
 #include "dss.h"
 
 static struct {
@@ -60,14 +58,20 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 	r = omap_dss_start_device(dssdev);
 	if (r) {
 		DSSERR("failed to start device\n");
-		goto err0;
+		goto err_start_dev;
 	}
 
 	r = regulator_enable(sdi.vdds_sdi_reg);
 	if (r)
-		goto err1;
+		goto err_reg_enable;
 
-	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
+	r = dss_runtime_get();
+	if (r)
+		goto err_get_dss;
+
+	r = dispc_runtime_get();
+	if (r)
+		goto err_get_dispc;
 
 	sdi_basic_init(dssdev);
 
@@ -80,7 +84,7 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 	r = dss_calc_clock_div(1, t->pixel_clock * 1000,
 			&dss_cinfo, &dispc_cinfo);
 	if (r)
-		goto err2;
+		goto err_calc_clock_div;
 
 	fck = dss_cinfo.fck;
 	lck_div = dispc_cinfo.lck_div;
@@ -101,27 +105,34 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 
 	r = dss_set_clock_div(&dss_cinfo);
 	if (r)
-		goto err2;
+		goto err_set_dss_clock_div;
 
 	r = dispc_set_clock_div(dssdev->manager->id, &dispc_cinfo);
 	if (r)
-		goto err2;
+		goto err_set_dispc_clock_div;
 
 	dss_sdi_init(dssdev->phy.sdi.datapairs);
 	r = dss_sdi_enable();
 	if (r)
-		goto err1;
+		goto err_sdi_enable;
 	mdelay(2);
 
 	dssdev->manager->enable(dssdev->manager);
 
 	return 0;
-err2:
-	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
+
+err_sdi_enable:
+err_set_dispc_clock_div:
+err_set_dss_clock_div:
+err_calc_clock_div:
+	dispc_runtime_put();
+err_get_dispc:
+	dss_runtime_put();
+err_get_dss:
 	regulator_disable(sdi.vdds_sdi_reg);
-err1:
+err_reg_enable:
 	omap_dss_stop_device(dssdev);
-err0:
+err_start_dev:
 	return r;
 }
 EXPORT_SYMBOL(omapdss_sdi_display_enable);
@@ -132,7 +143,8 @@ void omapdss_sdi_display_disable(struct omap_dss_device *dssdev)
 
 	dss_sdi_disable();
 
-	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
+	dispc_runtime_put();
+	dss_runtime_put();
 
 	regulator_disable(sdi.vdds_sdi_reg);
 
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 15b4431..67abff2 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -33,6 +33,7 @@
 #include <linux/seq_file.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
+#include <linux/pm_runtime.h>
 
 #include <video/omapdss.h>
 #include <plat/cpu.h>
@@ -293,6 +294,9 @@ static struct {
 	struct mutex venc_lock;
 	u32 wss_data;
 	struct regulator *vdda_dac_reg;
+
+	struct clk	*tv_clk;
+	struct clk	*tv_dac_clk;
 } venc;
 
 static inline void venc_write_reg(int idx, u32 val)
@@ -381,17 +385,25 @@ static void venc_reset(void)
 #endif
 }
 
-static void venc_enable_clocks(int enable)
+static int venc_runtime_get(void)
 {
-	if (enable) {
-		dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK | DSS_CLK_TVFCK);
-		if (dss_has_feature(FEAT_VENC_REQUIRES_TV_DAC_CLK))
-			dss_clk_enable(DSS_CLK_VIDFCK);
-	} else {
-		dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK | DSS_CLK_TVFCK);
-		if (dss_has_feature(FEAT_VENC_REQUIRES_TV_DAC_CLK))
-			dss_clk_disable(DSS_CLK_VIDFCK);
-	}
+	int r;
+
+	DSSDBG("venc_runtime_get\n");
+
+	r = pm_runtime_get_sync(&venc.pdev->dev);
+	WARN_ON(r < 0);
+	return r < 0 ? r : 0;
+}
+
+static void venc_runtime_put(void)
+{
+	int r;
+
+	DSSDBG("venc_runtime_put\n");
+
+	r = pm_runtime_put(&venc.pdev->dev);
+	WARN_ON(r < 0);
 }
 
 static const struct venc_config *venc_timings_to_config(
@@ -410,8 +422,6 @@ static void venc_power_on(struct omap_dss_device *dssdev)
 {
 	u32 l;
 
-	venc_enable_clocks(1);
-
 	venc_reset();
 	venc_write_config(venc_timings_to_config(&dssdev->panel.timings));
 
@@ -452,8 +462,6 @@ static void venc_power_off(struct omap_dss_device *dssdev)
 		dssdev->platform_disable(dssdev);
 
 	regulator_disable(venc.vdda_dac_reg);
-
-	venc_enable_clocks(0);
 }
 
 
@@ -491,6 +499,10 @@ static int venc_panel_enable(struct omap_dss_device *dssdev)
 		goto err1;
 	}
 
+	r = venc_runtime_get();
+	if (r)
+		goto err1;
+
 	venc_power_on(dssdev);
 
 	venc.wss_data = 0;
@@ -524,6 +536,8 @@ static void venc_panel_disable(struct omap_dss_device *dssdev)
 
 	venc_power_off(dssdev);
 
+	venc_runtime_put();
+
 	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 
 	omap_dss_stop_device(dssdev);
@@ -602,6 +616,7 @@ static u32 venc_get_wss(struct omap_dss_device *dssdev)
 static int venc_set_wss(struct omap_dss_device *dssdev,	u32 wss)
 {
 	const struct venc_config *config;
+	int r;
 
 	DSSDBG("venc_set_wss\n");
 
@@ -612,16 +627,19 @@ static int venc_set_wss(struct omap_dss_device *dssdev,	u32 wss)
 	/* Invert due to VENC_L21_WC_CTL:INV=1 */
 	venc.wss_data = (wss ^ 0xfffff) << 8;
 
-	venc_enable_clocks(1);
+	r = venc_runtime_get();
+	if (r)
+		goto err;
 
 	venc_write_reg(VENC_BSTAMP_WSS_DATA, config->bstamp_wss_data |
 			venc.wss_data);
 
-	venc_enable_clocks(0);
+	venc_runtime_put();
 
+err:
 	mutex_unlock(&venc.venc_lock);
 
-	return 0;
+	return r;
 }
 
 static struct omap_dss_driver venc_driver = {
@@ -677,7 +695,8 @@ void venc_dump_regs(struct seq_file *s)
 {
 #define DUMPREG(r) seq_printf(s, "%-35s %08x\n", #r, venc_read_reg(r))
 
-	venc_enable_clocks(1);
+	if (venc_runtime_get())
+		return;
 
 	DUMPREG(VENC_F_CONTROL);
 	DUMPREG(VENC_VIDOUT_CTRL);
@@ -721,16 +740,53 @@ void venc_dump_regs(struct seq_file *s)
 	DUMPREG(VENC_OUTPUT_CONTROL);
 	DUMPREG(VENC_OUTPUT_TEST);
 
-	venc_enable_clocks(0);
+	venc_runtime_put();
 
 #undef DUMPREG
 }
 
+static int venc_get_clocks(struct platform_device *pdev)
+{
+	struct clk *clk;
+
+	clk = clk_get(&pdev->dev, "tv_clk");
+	if (IS_ERR(clk)) {
+		DSSERR("can't get tv_clk\n");
+		return PTR_ERR(clk);
+	}
+
+	venc.tv_clk = clk;
+
+	if (dss_has_feature(FEAT_VENC_REQUIRES_TV_DAC_CLK)) {
+		clk = clk_get(&pdev->dev, "tv_dac_clk");
+		if (IS_ERR(clk)) {
+			DSSERR("can't get tv_dac_clk\n");
+			clk_put(venc.tv_clk);
+			return PTR_ERR(clk);
+		}
+	} else {
+		clk = NULL;
+	}
+
+	venc.tv_dac_clk = clk;
+
+	return 0;
+}
+
+static void venc_put_clocks(void)
+{
+	if (venc.tv_clk)
+		clk_put(venc.tv_clk);
+	if (venc.tv_dac_clk)
+		clk_put(venc.tv_dac_clk);
+}
+
 /* VENC HW IP initialisation */
 static int omap_venchw_probe(struct platform_device *pdev)
 {
 	u8 rev_id;
 	struct resource *venc_mem;
+	int r;
 
 	venc.pdev = pdev;
 
@@ -741,22 +797,40 @@ static int omap_venchw_probe(struct platform_device *pdev)
 	venc_mem = platform_get_resource(venc.pdev, IORESOURCE_MEM, 0);
 	if (!venc_mem) {
 		DSSERR("can't get IORESOURCE_MEM VENC\n");
-		return -EINVAL;
+		r = -EINVAL;
+		goto err_ioremap;
 	}
 	venc.base = ioremap(venc_mem->start, resource_size(venc_mem));
 	if (!venc.base) {
 		DSSERR("can't ioremap VENC\n");
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto err_ioremap;
 	}
 
-	venc_enable_clocks(1);
+	r = venc_get_clocks(pdev);
+	if (r)
+		goto err_get_clk;
+
+	pm_runtime_enable(&pdev->dev);
+
+	r = venc_runtime_get();
+	if (r)
+		goto err_get_venc;
 
 	rev_id = (u8)(venc_read_reg(VENC_REV_ID) & 0xff);
 	dev_dbg(&pdev->dev, "OMAP VENC rev %d\n", rev_id);
 
-	venc_enable_clocks(0);
+	venc_runtime_put();
 
 	return omap_dss_register_driver(&venc_driver);
+
+err_get_venc:
+	pm_runtime_disable(&pdev->dev);
+	venc_put_clocks();
+err_get_clk:
+	iounmap(venc.base);
+err_ioremap:
+	return r;
 }
 
 static int omap_venchw_remove(struct platform_device *pdev)
@@ -767,16 +841,61 @@ static int omap_venchw_remove(struct platform_device *pdev)
 	}
 	omap_dss_unregister_driver(&venc_driver);
 
+	pm_runtime_disable(&pdev->dev);
+	venc_put_clocks();
+
 	iounmap(venc.base);
 	return 0;
 }
 
+static int venc_runtime_suspend(struct device *dev)
+{
+	if (venc.tv_dac_clk)
+		clk_disable(venc.tv_dac_clk);
+	clk_disable(venc.tv_clk);
+
+	dispc_runtime_put();
+	dss_runtime_put();
+
+	return 0;
+}
+
+static int venc_runtime_resume(struct device *dev)
+{
+	int r;
+
+	r = dss_runtime_get();
+	if (r < 0)
+		goto err_get_dss;
+
+	r = dispc_runtime_get();
+	if (r < 0)
+		goto err_get_dispc;
+
+	clk_enable(venc.tv_clk);
+	if (venc.tv_dac_clk)
+		clk_enable(venc.tv_dac_clk);
+
+	return 0;
+
+err_get_dispc:
+	dss_runtime_put();
+err_get_dss:
+	return r;
+}
+
+static const struct dev_pm_ops venc_pm_ops = {
+	.runtime_suspend = venc_runtime_suspend,
+	.runtime_resume = venc_runtime_resume,
+};
+
 static struct platform_driver omap_venchw_driver = {
 	.probe          = omap_venchw_probe,
 	.remove         = omap_venchw_remove,
 	.driver         = {
 		.name   = "omapdss_venc",
 		.owner  = THIS_MODULE,
+		.pm	= &venc_pm_ops,
 	},
 };
 
-- 
1.7.4.1

