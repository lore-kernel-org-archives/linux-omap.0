From: Archit Taneja <archit@ti.com>
Subject: [PATCH v4 5/7] OMAP: DSS2: LCD2 Channel Changes for DISPC
Date: Mon,  8 Nov 2010 17:54:23 +0530
Message-ID: <1289219065-1362-6-git-send-email-archit@ti.com>
References: <1289219065-1362-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37589 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753435Ab0KHMX7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Nov 2010 07:23:59 -0500
In-Reply-To: <1289219065-1362-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Sumit Semwal <sumit.semwal@ti.com>, Mukund Mittal <mmittal@ti.com>, Samreen <samreen@ti.com>

From: Sumit Semwal <sumit.semwal@ti.com>

Modify DISPC functions to work with LCD2 as the DISPC Channel.

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
Signed-off-by: Mukund Mittal <mmittal@ti.com>
Signed-off-by: Samreen <samreen@ti.com>
---
 arch/arm/plat-omap/include/plat/display.h |    4 +
 drivers/video/omap2/dss/dispc.c           |  216 +++++++++++++++++++++++++----
 2 files changed, 191 insertions(+), 29 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index 3e6eec1..03d7893 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -42,6 +42,10 @@
 #define DISPC_IRQ_SYNC_LOST		(1 << 14)
 #define DISPC_IRQ_SYNC_LOST_DIGIT	(1 << 15)
 #define DISPC_IRQ_WAKEUP		(1 << 16)
+#define DISPC_IRQ_SYNC_LOST2		(1 << 17)
+#define DISPC_IRQ_VSYNC2		(1 << 18)
+#define DISPC_IRQ_ACBIAS_COUNT_STAT2	(1 << 21)
+#define DISPC_IRQ_FRAMEDONE2		(1 << 22)
 
 struct omap_dss_device;
 struct omap_overlay_manager;
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index b9be4fd..967fa87 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -232,6 +232,17 @@ void dispc_save_context(void)
 	SR(GLOBAL_ALPHA);
 	SR(SIZE_DIG);
 	SR(SIZE_LCD(0));
+	if (dss_has_feature(FEAT_MGR_LCD2)) {
+		SR(CONTROL(2));
+		SR(DEFAULT_COLOR(2));
+		SR(TRANS_COLOR(2));
+		SR(SIZE_LCD(2));
+		SR(TIMING_H(2));
+		SR(TIMING_V(2));
+		SR(POL_FREQ(2));
+		SR(DIVISOR(2));
+		SR(CONFIG(2));
+	}
 
 	SR(GFX_BA0);
 	SR(GFX_BA1);
@@ -251,6 +262,15 @@ void dispc_save_context(void)
 	SR(CPR_COEF_R(0));
 	SR(CPR_COEF_G(0));
 	SR(CPR_COEF_B(0));
+	if (dss_has_feature(FEAT_MGR_LCD2)) {
+		SR(CPR_COEF_B(2));
+		SR(CPR_COEF_G(2));
+		SR(CPR_COEF_R(2));
+
+		SR(DATA_CYCLE1(2));
+		SR(DATA_CYCLE2(2));
+		SR(DATA_CYCLE3(2));
+	}
 
 	SR(GFX_PRELOAD);
 
@@ -371,6 +391,16 @@ void dispc_restore_context(void)
 	RR(GLOBAL_ALPHA);
 	RR(SIZE_DIG);
 	RR(SIZE_LCD(0));
+	if (dss_has_feature(FEAT_MGR_LCD2)) {
+		RR(DEFAULT_COLOR(2));
+		RR(TRANS_COLOR(2));
+		RR(SIZE_LCD(2));
+		RR(TIMING_H(2));
+		RR(TIMING_V(2));
+		RR(POL_FREQ(2));
+		RR(DIVISOR(2));
+		RR(CONFIG(2));
+	}
 
 	RR(GFX_BA0);
 	RR(GFX_BA1);
@@ -390,6 +420,15 @@ void dispc_restore_context(void)
 	RR(CPR_COEF_R(0));
 	RR(CPR_COEF_G(0));
 	RR(CPR_COEF_B(0));
+	if (dss_has_feature(FEAT_MGR_LCD2)) {
+		RR(DATA_CYCLE1(2));
+		RR(DATA_CYCLE2(2));
+		RR(DATA_CYCLE3(2));
+
+		RR(CPR_COEF_B(2));
+		RR(CPR_COEF_G(2));
+		RR(CPR_COEF_R(2));
+	}
 
 	RR(GFX_PRELOAD);
 
@@ -493,6 +532,8 @@ void dispc_restore_context(void)
 
 	/* enable last, because LCD & DIGIT enable are here */
 	RR(CONTROL(0));
+	if (dss_has_feature(FEAT_MGR_LCD2))
+		RR(CONTROL(2));
 
 	/* clear spurious SYNC_LOST_DIGIT interrupts */
 	dispc_write_reg(DISPC_IRQSTATUS, DISPC_IRQ_SYNC_LOST_DIGIT);
@@ -519,7 +560,8 @@ bool dispc_go_busy(enum omap_channel channel)
 {
 	int bit;
 
-	if (channel == OMAP_DSS_CHANNEL_LCD)
+	if (channel == OMAP_DSS_CHANNEL_LCD ||
+			channel == OMAP_DSS_CHANNEL_LCD2)
 		bit = 5; /* GOLCD */
 	else
 		bit = 6; /* GODIGIT */
@@ -533,7 +575,8 @@ void dispc_go(enum omap_channel channel)
 
 	enable_clocks(1);
 
-	if (channel == OMAP_DSS_CHANNEL_LCD)
+	if (channel == OMAP_DSS_CHANNEL_LCD ||
+			channel == OMAP_DSS_CHANNEL_LCD2)
 		bit = 0; /* LCDENABLE */
 	else
 		bit = 1; /* DIGITALENABLE */
@@ -542,7 +585,8 @@ void dispc_go(enum omap_channel channel)
 	if (REG_GET(DISPC_CONTROL(channel), bit, bit) == 0)
 		goto end;
 
-	if (channel == OMAP_DSS_CHANNEL_LCD)
+	if (channel == OMAP_DSS_CHANNEL_LCD ||
+			channel == OMAP_DSS_CHANNEL_LCD2)
 		bit = 5; /* GOLCD */
 	else
 		bit = 6; /* GODIGIT */
@@ -552,7 +596,8 @@ void dispc_go(enum omap_channel channel)
 		goto end;
 	}
 
-	DSSDBG("GO %s\n", channel == OMAP_DSS_CHANNEL_LCD ? "LCD" : "DIGIT");
+	DSSDBG("GO %s\n", channel == OMAP_DSS_CHANNEL_LCD ? "LCD" :
+		(channel == OMAP_DSS_CHANNEL_LCD2 ? "LCD2" : "DIGIT"));
 
 	REG_FLD_MOD(DISPC_CONTROL(channel), 1, bit, bit);
 end:
@@ -867,6 +912,7 @@ static void _dispc_set_channel_out(enum omap_plane plane,
 {
 	int shift;
 	u32 val;
+	int chan = 0, chan2 = 0;
 
 	switch (plane) {
 	case OMAP_DSS_GFX:
@@ -882,7 +928,29 @@ static void _dispc_set_channel_out(enum omap_plane plane,
 	}
 
 	val = dispc_read_reg(dispc_reg_att[plane]);
-	val = FLD_MOD(val, channel, shift, shift);
+	if (dss_has_feature(FEAT_MGR_LCD2)) {
+		switch (channel) {
+		case OMAP_DSS_CHANNEL_LCD:
+			chan = 0;
+			chan2 = 0;
+			break;
+		case OMAP_DSS_CHANNEL_DIGIT:
+			chan = 1;
+			chan2 = 0;
+			break;
+		case OMAP_DSS_CHANNEL_LCD2:
+			chan = 0;
+			chan2 = 1;
+			break;
+		default:
+			BUG();
+		}
+
+		val = FLD_MOD(val, chan, shift, shift);
+		val = FLD_MOD(val, chan2, 31, 30);
+	} else {
+		val = FLD_MOD(val, channel, shift, shift);
+	}
 	dispc_write_reg(dispc_reg_att[plane], val);
 }
 
@@ -1729,36 +1797,39 @@ static void dispc_disable_isr(void *data, u32 mask)
 	complete(compl);
 }
 
-static void _enable_lcd_out(bool enable)
+static void _enable_lcd_out(enum omap_channel channel, bool enable)
 {
-	REG_FLD_MOD(DISPC_CONTROL(OMAP_DSS_CHANNEL_LCD), enable ? 1 : 0, 0, 0);
+	REG_FLD_MOD(DISPC_CONTROL(channel), enable ? 1 : 0, 0, 0);
 }
 
-static void dispc_enable_lcd_out(bool enable)
+static void dispc_enable_lcd_out(enum omap_channel channel, bool enable)
 {
 	struct completion frame_done_completion;
 	bool is_on;
 	int r;
+	u32 irq;
 
 	enable_clocks(1);
 
 	/* When we disable LCD output, we need to wait until frame is done.
 	 * Otherwise the DSS is still working, and turning off the clocks
 	 * prevents DSS from going to OFF mode */
-	is_on = REG_GET(DISPC_CONTROL(OMAP_DSS_CHANNEL_LCD), 0, 0);
+	is_on = REG_GET(DISPC_CONTROL(channel), 0, 0);
+
+	irq = channel == OMAP_DSS_CHANNEL_LCD2 ? DISPC_IRQ_FRAMEDONE2 :
+			DISPC_IRQ_FRAMEDONE;
 
 	if (!enable && is_on) {
 		init_completion(&frame_done_completion);
 
 		r = omap_dispc_register_isr(dispc_disable_isr,
-				&frame_done_completion,
-				DISPC_IRQ_FRAMEDONE);
+				&frame_done_completion, irq);
 
 		if (r)
 			DSSERR("failed to register FRAMEDONE isr\n");
 	}
 
-	_enable_lcd_out(enable);
+	_enable_lcd_out(channel, enable);
 
 	if (!enable && is_on) {
 		if (!wait_for_completion_timeout(&frame_done_completion,
@@ -1766,8 +1837,7 @@ static void dispc_enable_lcd_out(bool enable)
 			DSSERR("timeout waiting for FRAME DONE\n");
 
 		r = omap_dispc_unregister_isr(dispc_disable_isr,
-				&frame_done_completion,
-				DISPC_IRQ_FRAMEDONE);
+				&frame_done_completion, irq);
 
 		if (r)
 			DSSERR("failed to unregister FRAMEDONE isr\n");
@@ -1838,6 +1908,8 @@ static void dispc_enable_digit_out(bool enable)
 		unsigned long flags;
 		spin_lock_irqsave(&dispc.irq_lock, flags);
 		dispc.irq_error_mask = DISPC_IRQ_MASK_ERROR;
+		if (dss_has_feature(FEAT_MGR_LCD2))
+			dispc.irq_error_mask |= DISPC_IRQ_SYNC_LOST2;
 		dispc_write_reg(DISPC_IRQSTATUS, DISPC_IRQ_SYNC_LOST_DIGIT);
 		_omap_dispc_set_irqs();
 		spin_unlock_irqrestore(&dispc.irq_lock, flags);
@@ -1848,7 +1920,8 @@ static void dispc_enable_digit_out(bool enable)
 
 bool dispc_is_channel_enabled(enum omap_channel channel)
 {
-	if (channel == OMAP_DSS_CHANNEL_LCD)
+	if (channel == OMAP_DSS_CHANNEL_LCD ||
+			channel == OMAP_DSS_CHANNEL_LCD2)
 		return !!REG_GET(DISPC_CONTROL(channel), 0, 0);
 	else if (channel == OMAP_DSS_CHANNEL_DIGIT)
 		return !!REG_GET(DISPC_CONTROL(channel), 1, 1);
@@ -1858,8 +1931,9 @@ bool dispc_is_channel_enabled(enum omap_channel channel)
 
 void dispc_enable_channel(enum omap_channel channel, bool enable)
 {
-	if (channel == OMAP_DSS_CHANNEL_LCD)
-		dispc_enable_lcd_out(enable);
+	if (channel == OMAP_DSS_CHANNEL_LCD ||
+			channel == OMAP_DSS_CHANNEL_LCD2)
+		dispc_enable_lcd_out(channel, enable);
 	else if (channel == OMAP_DSS_CHANNEL_DIGIT)
 		dispc_enable_digit_out(enable);
 	else
@@ -1942,7 +2016,8 @@ u32 dispc_get_default_color(enum omap_channel channel)
 	u32 l;
 
 	BUG_ON(channel != OMAP_DSS_CHANNEL_DIGIT &&
-	       channel != OMAP_DSS_CHANNEL_LCD);
+		channel != OMAP_DSS_CHANNEL_LCD &&
+		channel != OMAP_DSS_CHANNEL_LCD2);
 
 	enable_clocks(1);
 	l = dispc_read_reg(DISPC_DEFAULT_COLOR(channel));
@@ -1956,7 +2031,7 @@ void dispc_set_trans_key(enum omap_channel ch,
 		u32 trans_key)
 {
 	enable_clocks(1);
-	if (ch == OMAP_DSS_CHANNEL_LCD)
+	if (ch == OMAP_DSS_CHANNEL_LCD || ch == OMAP_DSS_CHANNEL_LCD2)
 		REG_FLD_MOD(DISPC_CONFIG(ch), type, 11, 11);
 	else /* OMAP_DSS_CHANNEL_DIGIT */
 		REG_FLD_MOD(DISPC_CONFIG(ch), type, 13, 13);
@@ -1971,7 +2046,7 @@ void dispc_get_trans_key(enum omap_channel ch,
 {
 	enable_clocks(1);
 	if (type) {
-		if (ch == OMAP_DSS_CHANNEL_LCD)
+		if (ch == OMAP_DSS_CHANNEL_LCD || ch == OMAP_DSS_CHANNEL_LCD2)
 			*type = REG_GET(DISPC_CONFIG(ch), 11, 11);
 		else if (ch == OMAP_DSS_CHANNEL_DIGIT)
 			*type = REG_GET(DISPC_CONFIG(ch), 13, 13);
@@ -1987,7 +2062,7 @@ void dispc_get_trans_key(enum omap_channel ch,
 void dispc_enable_trans_key(enum omap_channel ch, bool enable)
 {
 	enable_clocks(1);
-	if (ch == OMAP_DSS_CHANNEL_LCD)
+	if (ch == OMAP_DSS_CHANNEL_LCD || ch == OMAP_DSS_CHANNEL_LCD2)
 		REG_FLD_MOD(DISPC_CONFIG(ch), enable, 10, 10);
 	else /* OMAP_DSS_CHANNEL_DIGIT */
 		REG_FLD_MOD(DISPC_CONFIG(ch), enable, 12, 12);
@@ -1999,7 +2074,7 @@ void dispc_enable_alpha_blending(enum omap_channel ch, bool enable)
 		return;
 
 	enable_clocks(1);
-	if (ch == OMAP_DSS_CHANNEL_LCD)
+	if (ch == OMAP_DSS_CHANNEL_LCD || ch == OMAP_DSS_CHANNEL_LCD2)
 		REG_FLD_MOD(DISPC_CONFIG(ch), enable, 18, 18);
 	else /* OMAP_DSS_CHANNEL_DIGIT */
 		REG_FLD_MOD(DISPC_CONFIG(ch), enable, 19, 19);
@@ -2013,7 +2088,7 @@ bool dispc_alpha_blending_enabled(enum omap_channel ch)
 		return false;
 
 	enable_clocks(1);
-	if (ch == OMAP_DSS_CHANNEL_LCD)
+	if (ch == OMAP_DSS_CHANNEL_LCD || ch == OMAP_DSS_CHANNEL_LCD2)
 		enabled = REG_GET(DISPC_CONFIG(ch), 18, 18);
 	else if (ch == OMAP_DSS_CHANNEL_DIGIT)
 		enabled = REG_GET(DISPC_CONFIG(ch), 19, 19);
@@ -2030,7 +2105,7 @@ bool dispc_trans_key_enabled(enum omap_channel ch)
 	bool enabled;
 
 	enable_clocks(1);
-	if (ch == OMAP_DSS_CHANNEL_LCD)
+	if (ch == OMAP_DSS_CHANNEL_LCD || ch == OMAP_DSS_CHANNEL_LCD2)
 		enabled = REG_GET(DISPC_CONFIG(ch), 10, 10);
 	else if (ch == OMAP_DSS_CHANNEL_DIGIT)
 		enabled = REG_GET(DISPC_CONFIG(ch), 12, 12);
@@ -2193,7 +2268,8 @@ void dispc_set_lcd_timings(enum omap_channel channel,
 	ht = (timings->pixel_clock * 1000) / xtot;
 	vt = (timings->pixel_clock * 1000) / xtot / ytot;
 
-	DSSDBG("xres %u yres %u\n", timings->x_res, timings->y_res);
+	DSSDBG("channel %d xres %u yres %u\n", channel, timings->x_res,
+			timings->y_res);
 	DSSDBG("pck %u\n", timings->pixel_clock);
 	DSSDBG("hsw %d hfp %d hbp %d vsw %d vfp %d vbp %d\n",
 			timings->hsw, timings->hfp, timings->hbp,
@@ -2214,10 +2290,11 @@ static void dispc_set_lcd_divisor(enum omap_channel channel, u16 lck_div,
 	enable_clocks(0);
 }
 
-static void dispc_get_lcd_divisor(int *lck_div, int *pck_div)
+static void dispc_get_lcd_divisor(enum omap_channel channel, int *lck_div,
+		int *pck_div)
 {
 	u32 l;
-	l = dispc_read_reg(DISPC_DIVISOR(OMAP_DSS_CHANNEL_LCD));
+	l = dispc_read_reg(DISPC_DIVISOR(channel));
 	*lck_div = FLD_GET(l, 23, 16);
 	*pck_div = FLD_GET(l, 7, 0);
 }
@@ -2274,8 +2351,6 @@ void dispc_dump_clocks(struct seq_file *s)
 
 	enable_clocks(1);
 
-	dispc_get_lcd_divisor(&lcd, &pcd);
-
 	seq_printf(s, "- DISPC -\n");
 
 	seq_printf(s, "dispc fclk source = %s\n",
@@ -2283,11 +2358,25 @@ void dispc_dump_clocks(struct seq_file *s)
 			"dss1_alwon_fclk" : "dsi1_pll_fclk");
 
 	seq_printf(s, "fck\t\t%-16lu\n", dispc_fclk_rate());
+
+	seq_printf(s, "- LCD1 -\n");
+
+	dispc_get_lcd_divisor(OMAP_DSS_CHANNEL_LCD, &lcd, &pcd);
+
 	seq_printf(s, "lck\t\t%-16lulck div\t%u\n",
 			dispc_lclk_rate(OMAP_DSS_CHANNEL_LCD), lcd);
 	seq_printf(s, "pck\t\t%-16lupck div\t%u\n",
 			dispc_pclk_rate(OMAP_DSS_CHANNEL_LCD), pcd);
+	if (dss_has_feature(FEAT_MGR_LCD2)) {
+		seq_printf(s, "- LCD2 -\n");
 
+		dispc_get_lcd_divisor(OMAP_DSS_CHANNEL_LCD2, &lcd, &pcd);
+
+		seq_printf(s, "lck\t\t%-16lulck div\t%u\n",
+				dispc_lclk_rate(OMAP_DSS_CHANNEL_LCD2), lcd);
+		seq_printf(s, "pck\t\t%-16lupck div\t%u\n",
+				dispc_pclk_rate(OMAP_DSS_CHANNEL_LCD2), pcd);
+	}
 	enable_clocks(0);
 }
 
@@ -2329,6 +2418,12 @@ void dispc_dump_irqs(struct seq_file *s)
 	PIS(SYNC_LOST);
 	PIS(SYNC_LOST_DIGIT);
 	PIS(WAKEUP);
+	if (dss_has_feature(FEAT_MGR_LCD2)) {
+		PIS(FRAMEDONE2);
+		PIS(VSYNC2);
+		PIS(ACBIAS_COUNT_STAT2);
+		PIS(SYNC_LOST2);
+	}
 #undef PIS
 }
 #endif
@@ -2360,6 +2455,17 @@ void dispc_dump_regs(struct seq_file *s)
 	DUMPREG(DISPC_GLOBAL_ALPHA);
 	DUMPREG(DISPC_SIZE_DIG);
 	DUMPREG(DISPC_SIZE_LCD(0));
+	if (dss_has_feature(FEAT_MGR_LCD2)) {
+		DUMPREG(DISPC_CONTROL(2));
+		DUMPREG(DISPC_CONFIG(2));
+		DUMPREG(DISPC_DEFAULT_COLOR(2));
+		DUMPREG(DISPC_TRANS_COLOR(2));
+		DUMPREG(DISPC_TIMING_H(2));
+		DUMPREG(DISPC_TIMING_V(2));
+		DUMPREG(DISPC_POL_FREQ(2));
+		DUMPREG(DISPC_DIVISOR(2));
+		DUMPREG(DISPC_SIZE_LCD(2));
+	}
 
 	DUMPREG(DISPC_GFX_BA0);
 	DUMPREG(DISPC_GFX_BA1);
@@ -2380,6 +2486,15 @@ void dispc_dump_regs(struct seq_file *s)
 	DUMPREG(DISPC_CPR_COEF_R(0));
 	DUMPREG(DISPC_CPR_COEF_G(0));
 	DUMPREG(DISPC_CPR_COEF_B(0));
+	if (dss_has_feature(FEAT_MGR_LCD2)) {
+		DUMPREG(DISPC_DATA_CYCLE1(2));
+		DUMPREG(DISPC_DATA_CYCLE2(2));
+		DUMPREG(DISPC_DATA_CYCLE3(2));
+
+		DUMPREG(DISPC_CPR_COEF_R(2));
+		DUMPREG(DISPC_CPR_COEF_G(2));
+		DUMPREG(DISPC_CPR_COEF_B(2));
+	}
 
 	DUMPREG(DISPC_GFX_PRELOAD);
 
@@ -2731,6 +2846,8 @@ static void print_irq_status(u32 status)
 	PIS(VID2_FIFO_UNDERFLOW);
 	PIS(SYNC_LOST);
 	PIS(SYNC_LOST_DIGIT);
+	if (dss_has_feature(FEAT_MGR_LCD2))
+		PIS(SYNC_LOST2);
 #undef PIS
 
 	printk("\n");
@@ -2949,6 +3066,45 @@ static void dispc_error_worker(struct work_struct *work)
 		}
 	}
 
+	if (errors & DISPC_IRQ_SYNC_LOST2) {
+		struct omap_overlay_manager *manager = NULL;
+		bool enable = false;
+
+		DSSERR("SYNC_LOST for LCD2, disabling LCD2\n");
+
+		for (i = 0; i < omap_dss_get_num_overlay_managers(); ++i) {
+			struct omap_overlay_manager *mgr;
+			mgr = omap_dss_get_overlay_manager(i);
+
+			if (mgr->id == OMAP_DSS_CHANNEL_LCD2) {
+				manager = mgr;
+				enable = mgr->device->state ==
+						OMAP_DSS_DISPLAY_ACTIVE;
+				mgr->device->driver->disable(mgr->device);
+				break;
+			}
+		}
+
+		if (manager) {
+			struct omap_dss_device *dssdev = manager->device;
+			for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
+				struct omap_overlay *ovl;
+				ovl = omap_dss_get_overlay(i);
+
+				if (!(ovl->caps & OMAP_DSS_OVL_CAP_DISPC))
+					continue;
+
+				if (ovl->id != 0 && ovl->manager == manager)
+					dispc_enable_plane(ovl->id, 0);
+			}
+
+			dispc_go(manager->id);
+			mdelay(50);
+			if (enable)
+				dssdev->driver->enable(dssdev);
+		}
+	}
+
 	if (errors & DISPC_IRQ_OCP_ERR) {
 		DSSERR("OCP_ERR\n");
 		for (i = 0; i < omap_dss_get_num_overlay_managers(); ++i) {
@@ -3056,6 +3212,8 @@ static void _omap_dispc_initialize_irq(void)
 	memset(dispc.registered_isr, 0, sizeof(dispc.registered_isr));
 
 	dispc.irq_error_mask = DISPC_IRQ_MASK_ERROR;
+	if (dss_has_feature(FEAT_MGR_LCD2))
+		dispc.irq_error_mask |= DISPC_IRQ_SYNC_LOST2;
 
 	/* there's SYNC_LOST_DIGIT waiting after enabling the DSS,
 	 * so clear it */
-- 
1.7.0.4

