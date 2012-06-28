From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH 1/4] OMAPDSS: Cleanup implementation of LCD channels
Date: Thu, 28 Jun 2012 18:32:25 +0530
Message-ID: <1340888545-8190-1-git-send-email-cmahapatra@ti.com>
References: <013a8d0a8698b3f971c5963115b03701141a4688.1340874806.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37067 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794Ab2F1NCf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 09:02:35 -0400
In-Reply-To: <013a8d0a8698b3f971c5963115b03701141a4688.1340874806.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

The current implementation of LCD channels and managers consists of a number of
if-else construct which has been replaced by a simpler interface. A constant
structure mgr_desc has been created in Display Controller (DISPC) module. The
mgr_desc contains for each channel its name, irqs and  is initialized one time
with all registers and their corresponding fields to be written to enable
various features of Display Subsystem. This structure is later used by various
functions of DISPC which simplifies the further implementation of LCD channels
and its corresponding managers.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/dispc.c   |  232 +++++++++++++++++--------------------
 drivers/video/omap2/dss/dsi.c     |    6 +-
 drivers/video/omap2/dss/dss.h     |    6 +
 drivers/video/omap2/dss/manager.c |   12 +--
 4 files changed, 120 insertions(+), 136 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 4749ac3..8c39371 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -119,6 +119,80 @@ enum omap_color_component {
 	DISPC_COLOR_COMPONENT_UV		= 1 << 1,
 };
 
+enum mgr_reg_fields {
+	DISPC_MGR_FLD_ENABLE,
+	DISPC_MGR_FLD_STNTFT,
+	DISPC_MGR_FLD_GO,
+	DISPC_MGR_FLD_TFTDATALINES,
+	DISPC_MGR_FLD_STALLMODE,
+	DISPC_MGR_FLD_TCKENABLE,
+	DISPC_MGR_FLD_TCKSELECTION,
+	DISPC_MGR_FLD_CPR,
+	DISPC_MGR_FLD_FIFOHANDCHECK,
+	/* used to maintain a count of the above fields */
+	DISPC_MGR_FLD_NUM,
+};
+
+static const struct {
+	const char *name;
+	u32 vsync_irq;
+	u32 framedone_irq;
+	u32 sync_lost_irq;
+	struct reg_field reg_desc[DISPC_MGR_FLD_NUM];
+} mgr_desc[] = {
+	[OMAP_DSS_CHANNEL_LCD] = {
+		.name		= "LCD",
+		.vsync_irq	= DISPC_IRQ_VSYNC,
+		.framedone_irq	= DISPC_IRQ_FRAMEDONE,
+		.sync_lost_irq	= DISPC_IRQ_SYNC_LOST,
+		.reg_desc	= {
+			[DISPC_MGR_FLD_ENABLE]		= { DISPC_CONTROL,  0,  0 },
+			[DISPC_MGR_FLD_STNTFT]		= { DISPC_CONTROL,  3,  3 },
+			[DISPC_MGR_FLD_GO]		= { DISPC_CONTROL,  5,  5 },
+			[DISPC_MGR_FLD_TFTDATALINES]	= { DISPC_CONTROL,  9,  8 },
+			[DISPC_MGR_FLD_STALLMODE]	= { DISPC_CONTROL, 11, 11 },
+			[DISPC_MGR_FLD_TCKENABLE]	= { DISPC_CONFIG,  10, 10 },
+			[DISPC_MGR_FLD_TCKSELECTION]	= { DISPC_CONFIG,  11, 11 },
+			[DISPC_MGR_FLD_CPR]		= { DISPC_CONFIG,  15, 15 },
+			[DISPC_MGR_FLD_FIFOHANDCHECK]	= { DISPC_CONFIG,  16, 16 },
+		},
+	},
+	[OMAP_DSS_CHANNEL_DIGIT] = {
+		.name		= "DIGIT",
+		.vsync_irq	= DISPC_IRQ_EVSYNC_ODD | DISPC_IRQ_EVSYNC_EVEN,
+		.framedone_irq	= 0,
+		.sync_lost_irq	= DISPC_IRQ_SYNC_LOST_DIGIT,
+		.reg_desc	= {
+			[DISPC_MGR_FLD_ENABLE]		= { DISPC_CONTROL,  1,  1 },
+			[DISPC_MGR_FLD_STNTFT]		= { },
+			[DISPC_MGR_FLD_GO]		= { DISPC_CONTROL,  6,  6 },
+			[DISPC_MGR_FLD_TFTDATALINES]	= { },
+			[DISPC_MGR_FLD_STALLMODE]	= { },
+			[DISPC_MGR_FLD_TCKENABLE]	= { DISPC_CONFIG,  12, 12 },
+			[DISPC_MGR_FLD_TCKSELECTION]	= { DISPC_CONFIG,  13, 13 },
+			[DISPC_MGR_FLD_CPR]		= { },
+			[DISPC_MGR_FLD_FIFOHANDCHECK]	= { DISPC_CONFIG,  16, 16 },
+		},
+	},
+	[OMAP_DSS_CHANNEL_LCD2] = {
+		.name		= "LCD2",
+		.vsync_irq	= DISPC_IRQ_VSYNC2,
+		.framedone_irq	= DISPC_IRQ_FRAMEDONE2,
+		.sync_lost_irq	= DISPC_IRQ_SYNC_LOST2,
+		.reg_desc	= {
+			[DISPC_MGR_FLD_ENABLE]		= { DISPC_CONTROL2,  0,  0 },
+			[DISPC_MGR_FLD_STNTFT]		= { DISPC_CONTROL2,  3,  3 },
+			[DISPC_MGR_FLD_GO]		= { DISPC_CONTROL2,  5,  5 },
+			[DISPC_MGR_FLD_TFTDATALINES]	= { DISPC_CONTROL2,  9,  8 },
+			[DISPC_MGR_FLD_STALLMODE]	= { DISPC_CONTROL2, 11, 11 },
+			[DISPC_MGR_FLD_TCKENABLE]	= { DISPC_CONFIG2,  10, 10 },
+			[DISPC_MGR_FLD_TCKSELECTION]	= { DISPC_CONFIG2,  11, 11 },
+			[DISPC_MGR_FLD_CPR]		= { DISPC_CONFIG2,  15, 15 },
+			[DISPC_MGR_FLD_FIFOHANDCHECK]	= { DISPC_CONFIG2,  16, 16 },
+		},
+	},
+};
+
 static void _omap_dispc_set_irqs(void);
 
 static inline void dispc_write_reg(const u16 idx, u32 val)
@@ -131,6 +205,18 @@ static inline u32 dispc_read_reg(const u16 idx)
 	return __raw_readl(dispc.base + idx);
 }
 
+static u32 mgr_fld_read(enum omap_channel channel, enum mgr_reg_fields regfld)
+{
+	const struct reg_field rfld = mgr_desc[channel].reg_desc[regfld];
+	return REG_GET(rfld.reg, rfld.high, rfld.low);
+}
+
+static void mgr_fld_write(enum omap_channel channel,
+					enum mgr_reg_fields regfld, int val) {
+	const struct reg_field rfld = mgr_desc[channel].reg_desc[regfld];
+	REG_FLD_MOD(rfld.reg, val, rfld.high, rfld.low);
+}
+
 #define SR(reg) \
 	dispc.ctx[DISPC_##reg / sizeof(u32)] = dispc_read_reg(DISPC_##reg)
 #define RR(reg) \
@@ -398,90 +484,39 @@ static inline bool dispc_mgr_is_lcd(enum omap_channel channel)
 
 u32 dispc_mgr_get_vsync_irq(enum omap_channel channel)
 {
-	switch (channel) {
-	case OMAP_DSS_CHANNEL_LCD:
-		return DISPC_IRQ_VSYNC;
-	case OMAP_DSS_CHANNEL_LCD2:
-		return DISPC_IRQ_VSYNC2;
-	case OMAP_DSS_CHANNEL_DIGIT:
-		return DISPC_IRQ_EVSYNC_ODD | DISPC_IRQ_EVSYNC_EVEN;
-	default:
-		BUG();
-		return 0;
-	}
+	return mgr_desc[channel].vsync_irq;
 }
 
 u32 dispc_mgr_get_framedone_irq(enum omap_channel channel)
 {
-	switch (channel) {
-	case OMAP_DSS_CHANNEL_LCD:
-		return DISPC_IRQ_FRAMEDONE;
-	case OMAP_DSS_CHANNEL_LCD2:
-		return DISPC_IRQ_FRAMEDONE2;
-	case OMAP_DSS_CHANNEL_DIGIT:
-		return 0;
-	default:
-		BUG();
-		return 0;
-	}
+	return mgr_desc[channel].framedone_irq;
 }
 
 bool dispc_mgr_go_busy(enum omap_channel channel)
 {
-	int bit;
-
-	if (dispc_mgr_is_lcd(channel))
-		bit = 5; /* GOLCD */
-	else
-		bit = 6; /* GODIGIT */
-
-	if (channel == OMAP_DSS_CHANNEL_LCD2)
-		return REG_GET(DISPC_CONTROL2, bit, bit) == 1;
-	else
-		return REG_GET(DISPC_CONTROL, bit, bit) == 1;
+	return mgr_fld_read(channel, DISPC_MGR_FLD_GO) == 1;
 }
 
 void dispc_mgr_go(enum omap_channel channel)
 {
-	int bit;
 	bool enable_bit, go_bit;
 
-	if (dispc_mgr_is_lcd(channel))
-		bit = 0; /* LCDENABLE */
-	else
-		bit = 1; /* DIGITALENABLE */
-
 	/* if the channel is not enabled, we don't need GO */
-	if (channel == OMAP_DSS_CHANNEL_LCD2)
-		enable_bit = REG_GET(DISPC_CONTROL2, bit, bit) == 1;
-	else
-		enable_bit = REG_GET(DISPC_CONTROL, bit, bit) == 1;
+	enable_bit = mgr_fld_read(channel, DISPC_MGR_FLD_ENABLE) == 1;
 
 	if (!enable_bit)
 		return;
 
-	if (dispc_mgr_is_lcd(channel))
-		bit = 5; /* GOLCD */
-	else
-		bit = 6; /* GODIGIT */
-
-	if (channel == OMAP_DSS_CHANNEL_LCD2)
-		go_bit = REG_GET(DISPC_CONTROL2, bit, bit) == 1;
-	else
-		go_bit = REG_GET(DISPC_CONTROL, bit, bit) == 1;
+	go_bit = mgr_fld_read(channel, DISPC_MGR_FLD_GO) == 1;
 
 	if (go_bit) {
 		DSSERR("GO bit not down for channel %d\n", channel);
 		return;
 	}
 
-	DSSDBG("GO %s\n", channel == OMAP_DSS_CHANNEL_LCD ? "LCD" :
-		(channel == OMAP_DSS_CHANNEL_LCD2 ? "LCD2" : "DIGIT"));
+	DSSDBG("GO %s\n", mgr_desc[channel].name);
 
-	if (channel == OMAP_DSS_CHANNEL_LCD2)
-		REG_FLD_MOD(DISPC_CONTROL2, 1, bit, bit);
-	else
-		REG_FLD_MOD(DISPC_CONTROL, 1, bit, bit);
+	mgr_fld_write(channel, DISPC_MGR_FLD_GO, 1);
 }
 
 static void dispc_ovl_write_firh_reg(enum omap_plane plane, int reg, u32 value)
@@ -922,16 +957,10 @@ void dispc_enable_gamma_table(bool enable)
 
 static void dispc_mgr_enable_cpr(enum omap_channel channel, bool enable)
 {
-	u16 reg;
-
-	if (channel == OMAP_DSS_CHANNEL_LCD)
-		reg = DISPC_CONFIG;
-	else if (channel == OMAP_DSS_CHANNEL_LCD2)
-		reg = DISPC_CONFIG2;
-	else
+	if (channel == OMAP_DSS_CHANNEL_DIGIT)
 		return;
 
-	REG_FLD_MOD(reg, enable, 15, 15);
+	mgr_fld_write(channel, DISPC_MGR_FLD_CPR, enable);
 }
 
 static void dispc_mgr_set_cpr_coef(enum omap_channel channel,
@@ -2254,14 +2283,9 @@ static void dispc_disable_isr(void *data, u32 mask)
 
 static void _enable_lcd_out(enum omap_channel channel, bool enable)
 {
-	if (channel == OMAP_DSS_CHANNEL_LCD2) {
-		REG_FLD_MOD(DISPC_CONTROL2, enable ? 1 : 0, 0, 0);
-		/* flush posted write */
-		dispc_read_reg(DISPC_CONTROL2);
-	} else {
-		REG_FLD_MOD(DISPC_CONTROL, enable ? 1 : 0, 0, 0);
-		dispc_read_reg(DISPC_CONTROL);
-	}
+	mgr_fld_write(channel, DISPC_MGR_FLD_ENABLE, enable);
+	/* flush posted write */
+	mgr_fld_read(channel, DISPC_MGR_FLD_ENABLE);
 }
 
 static void dispc_mgr_enable_lcd_out(enum omap_channel channel, bool enable)
@@ -2274,12 +2298,9 @@ static void dispc_mgr_enable_lcd_out(enum omap_channel channel, bool enable)
 	/* When we disable LCD output, we need to wait until frame is done.
 	 * Otherwise the DSS is still working, and turning off the clocks
 	 * prevents DSS from going to OFF mode */
-	is_on = channel == OMAP_DSS_CHANNEL_LCD2 ?
-			REG_GET(DISPC_CONTROL2, 0, 0) :
-			REG_GET(DISPC_CONTROL, 0, 0);
+	is_on = mgr_fld_read(channel, DISPC_MGR_FLD_ENABLE);
 
-	irq = channel == OMAP_DSS_CHANNEL_LCD2 ? DISPC_IRQ_FRAMEDONE2 :
-			DISPC_IRQ_FRAMEDONE;
+	irq = mgr_desc[channel].framedone_irq;
 
 	if (!enable && is_on) {
 		init_completion(&frame_done_completion);
@@ -2384,16 +2405,7 @@ static void dispc_mgr_enable_digit_out(bool enable)
 
 bool dispc_mgr_is_enabled(enum omap_channel channel)
 {
-	if (channel == OMAP_DSS_CHANNEL_LCD)
-		return !!REG_GET(DISPC_CONTROL, 0, 0);
-	else if (channel == OMAP_DSS_CHANNEL_DIGIT)
-		return !!REG_GET(DISPC_CONTROL, 1, 1);
-	else if (channel == OMAP_DSS_CHANNEL_LCD2)
-		return !!REG_GET(DISPC_CONTROL2, 0, 0);
-	else {
-		BUG();
-		return false;
-	}
+	return !!mgr_fld_read(channel, DISPC_MGR_FLD_ENABLE);
 }
 
 void dispc_mgr_enable(enum omap_channel channel, bool enable)
@@ -2432,10 +2444,7 @@ void dispc_pck_free_enable(bool enable)
 
 void dispc_mgr_enable_fifohandcheck(enum omap_channel channel, bool enable)
 {
-	if (channel == OMAP_DSS_CHANNEL_LCD2)
-		REG_FLD_MOD(DISPC_CONFIG2, enable ? 1 : 0, 16, 16);
-	else
-		REG_FLD_MOD(DISPC_CONFIG, enable ? 1 : 0, 16, 16);
+	mgr_fld_write(channel, DISPC_MGR_FLD_FIFOHANDCHECK, enable);
 }
 
 
@@ -2458,10 +2467,7 @@ void dispc_mgr_set_lcd_display_type(enum omap_channel channel,
 		return;
 	}
 
-	if (channel == OMAP_DSS_CHANNEL_LCD2)
-		REG_FLD_MOD(DISPC_CONTROL2, mode, 3, 3);
-	else
-		REG_FLD_MOD(DISPC_CONTROL, mode, 3, 3);
+	mgr_fld_write(channel, DISPC_MGR_FLD_STNTFT, mode);
 }
 
 void dispc_set_loadmode(enum omap_dss_load_mode mode)
@@ -2479,24 +2485,14 @@ static void dispc_mgr_set_trans_key(enum omap_channel ch,
 		enum omap_dss_trans_key_type type,
 		u32 trans_key)
 {
-	if (ch == OMAP_DSS_CHANNEL_LCD)
-		REG_FLD_MOD(DISPC_CONFIG, type, 11, 11);
-	else if (ch == OMAP_DSS_CHANNEL_DIGIT)
-		REG_FLD_MOD(DISPC_CONFIG, type, 13, 13);
-	else /* OMAP_DSS_CHANNEL_LCD2 */
-		REG_FLD_MOD(DISPC_CONFIG2, type, 11, 11);
+	mgr_fld_write(ch, DISPC_MGR_FLD_TCKSELECTION, type);
 
 	dispc_write_reg(DISPC_TRANS_COLOR(ch), trans_key);
 }
 
 static void dispc_mgr_enable_trans_key(enum omap_channel ch, bool enable)
 {
-	if (ch == OMAP_DSS_CHANNEL_LCD)
-		REG_FLD_MOD(DISPC_CONFIG, enable, 10, 10);
-	else if (ch == OMAP_DSS_CHANNEL_DIGIT)
-		REG_FLD_MOD(DISPC_CONFIG, enable, 12, 12);
-	else /* OMAP_DSS_CHANNEL_LCD2 */
-		REG_FLD_MOD(DISPC_CONFIG2, enable, 10, 10);
+	mgr_fld_write(ch, DISPC_MGR_FLD_TCKENABLE, enable);
 }
 
 static void dispc_mgr_enable_alpha_fixed_zorder(enum omap_channel ch,
@@ -2547,10 +2543,7 @@ void dispc_mgr_set_tft_data_lines(enum omap_channel channel, u8 data_lines)
 		return;
 	}
 
-	if (channel == OMAP_DSS_CHANNEL_LCD2)
-		REG_FLD_MOD(DISPC_CONTROL2, code, 9, 8);
-	else
-		REG_FLD_MOD(DISPC_CONTROL, code, 9, 8);
+	mgr_fld_write(channel, DISPC_MGR_FLD_TFTDATALINES, code);
 }
 
 void dispc_mgr_set_io_pad_mode(enum dss_io_pad_mode mode)
@@ -2584,10 +2577,7 @@ void dispc_mgr_set_io_pad_mode(enum dss_io_pad_mode mode)
 
 void dispc_mgr_enable_stallmode(enum omap_channel channel, bool enable)
 {
-	if (channel == OMAP_DSS_CHANNEL_LCD2)
-		REG_FLD_MOD(DISPC_CONTROL2, enable, 11, 11);
-	else
-		REG_FLD_MOD(DISPC_CONTROL, enable, 11, 11);
+	mgr_fld_write(channel, DISPC_MGR_FLD_STALLMODE, enable);
 }
 
 static bool _dispc_mgr_size_ok(u16 width, u16 height)
@@ -3450,12 +3440,6 @@ static void dispc_error_worker(struct work_struct *work)
 		DISPC_IRQ_VID3_FIFO_UNDERFLOW,
 	};
 
-	static const unsigned sync_lost_bits[] = {
-		DISPC_IRQ_SYNC_LOST,
-		DISPC_IRQ_SYNC_LOST_DIGIT,
-		DISPC_IRQ_SYNC_LOST2,
-	};
-
 	spin_lock_irqsave(&dispc.irq_lock, flags);
 	errors = dispc.error_irqs;
 	dispc.error_irqs = 0;
@@ -3484,7 +3468,7 @@ static void dispc_error_worker(struct work_struct *work)
 		unsigned bit;
 
 		mgr = omap_dss_get_overlay_manager(i);
-		bit = sync_lost_bits[i];
+		bit = mgr_desc[i].sync_lost_irq;
 
 		if (bit & errors) {
 			struct omap_dss_device *dssdev = mgr->device;
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index ca8382d..2faf913 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4360,8 +4360,7 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 		timings.x_res = dw;
 		timings.y_res = dh;
 
-		irq = dssdev->manager->id == OMAP_DSS_CHANNEL_LCD ?
-			DISPC_IRQ_FRAMEDONE : DISPC_IRQ_FRAMEDONE2;
+		irq = dispc_mgr_get_framedone_irq(dssdev->manager->id);
 
 		r = omap_dispc_register_isr(dsi_framedone_irq_callback,
 			(void *) dssdev, irq);
@@ -4393,8 +4392,7 @@ static void dsi_display_uninit_dispc(struct omap_dss_device *dssdev)
 	if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_CMD_MODE) {
 		u32 irq;
 
-		irq = dssdev->manager->id == OMAP_DSS_CHANNEL_LCD ?
-			DISPC_IRQ_FRAMEDONE : DISPC_IRQ_FRAMEDONE2;
+		irq = dispc_mgr_get_framedone_irq(dssdev->manager->id);
 
 		omap_dispc_unregister_isr(dsi_framedone_irq_callback,
 			(void *) dssdev, irq);
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index dd1092c..df131fc 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -152,6 +152,12 @@ struct dsi_clock_info {
 	u16 lp_clk_div;
 };
 
+struct reg_field {
+	u16 reg;
+	u8 high;
+	u8 low;
+};
+
 struct seq_file;
 struct platform_device;
 
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 0cbcde4..bb602a2 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -500,16 +500,12 @@ static int dss_mgr_wait_for_vsync(struct omap_overlay_manager *mgr)
 	if (r)
 		return r;
 
-	if (mgr->device->type == OMAP_DISPLAY_TYPE_VENC) {
+	if (mgr->device->type == OMAP_DISPLAY_TYPE_VENC)
 		irq = DISPC_IRQ_EVSYNC_ODD;
-	} else if (mgr->device->type == OMAP_DISPLAY_TYPE_HDMI) {
+	else if (mgr->device->type == OMAP_DISPLAY_TYPE_HDMI)
 		irq = DISPC_IRQ_EVSYNC_EVEN;
-	} else {
-		if (mgr->id == OMAP_DSS_CHANNEL_LCD)
-			irq = DISPC_IRQ_VSYNC;
-		else
-			irq = DISPC_IRQ_VSYNC2;
-	}
+	else
+		irq = dispc_mgr_get_vsync_irq(mgr->id);
 
 	r = omap_dispc_wait_for_irq_interruptible_timeout(irq, timeout);
 
-- 
1.7.1

