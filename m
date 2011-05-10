From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 6/8] OMAP: DSS2: RFIB: cleanup
Date: Tue, 10 May 2011 19:24:14 +0300
Message-ID: <1305044656-31512-7-git-send-email-tomi.valkeinen@ti.com>
References: <1305044656-31512-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:49238 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932983Ab1EJQYk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 May 2011 12:24:40 -0400
In-Reply-To: <1305044656-31512-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The RFBI driver is quite messy. Remove dead and unneeded code and add
statics to functions.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.h  |    7 --
 drivers/video/omap2/dss/rfbi.c |  124 +---------------------------------------
 2 files changed, 3 insertions(+), 128 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index f659cfb..6cc56a1 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -497,13 +497,6 @@ void hdmi_panel_exit(void);
 int rfbi_init_platform_driver(void);
 void rfbi_uninit_platform_driver(void);
 void rfbi_dump_regs(struct seq_file *s);
-
-int rfbi_configure(int rfbi_module, int bpp, int lines);
-void rfbi_enable_rfbi(bool enable);
-void rfbi_transfer_area(struct omap_dss_device *dssdev, u16 width,
-		u16 height, void (callback)(void *data), void *data);
-void rfbi_set_timings(int rfbi_module, struct rfbi_timings *t);
-unsigned long rfbi_get_max_tx_rate(void);
 int rfbi_init_display(struct omap_dss_device *display);
 #else
 static inline int rfbi_init_platform_driver(void)
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index e6bbb67..d09ba5f 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -66,9 +66,6 @@ struct rfbi_reg { u16 idx; };
 #define REG_FLD_MOD(idx, val, start, end) \
 	rfbi_write_reg(idx, FLD_MOD(rfbi_read_reg(idx), val, start, end))
 
-/* To work around an RFBI transfer rate limitation */
-#define OMAP_RFBI_RATE_LIMIT    1
-
 enum omap_rfbi_cycleformat {
 	OMAP_DSS_RFBI_CYCLEFORMAT_1_1 = 0,
 	OMAP_DSS_RFBI_CYCLEFORMAT_2_1 = 1,
@@ -90,11 +87,6 @@ enum omap_rfbi_parallelmode {
 	OMAP_DSS_RFBI_PARALLELMODE_16 = 3,
 };
 
-enum update_cmd {
-	RFBI_CMD_UPDATE = 0,
-	RFBI_CMD_SYNC   = 1,
-};
-
 static int rfbi_convert_timings(struct rfbi_timings *t);
 static void rfbi_get_clk_info(u32 *clk_period, u32 *max_clk_div);
 
@@ -115,22 +107,9 @@ static struct {
 
 	struct omap_dss_device *dssdev[2];
 
-	struct kfifo      cmd_fifo;
-	spinlock_t        cmd_lock;
-	struct completion cmd_done;
-	atomic_t          cmd_fifo_full;
-	atomic_t          cmd_pending;
-
 	struct semaphore bus_lock;
 } rfbi;
 
-struct update_region {
-	u16	x;
-	u16     y;
-	u16     w;
-	u16     h;
-};
-
 static inline void rfbi_write_reg(const struct rfbi_reg idx, u32 val)
 {
 	__raw_writel(val, rfbi.base + idx.idx);
@@ -305,7 +284,7 @@ void omap_rfbi_write_pixels(const void __iomem *buf, int scr_width,
 }
 EXPORT_SYMBOL(omap_rfbi_write_pixels);
 
-void rfbi_transfer_area(struct omap_dss_device *dssdev, u16 width,
+static void rfbi_transfer_area(struct omap_dss_device *dssdev, u16 width,
 		u16 height, void (*callback)(void *data), void *data)
 {
 	u32 l;
@@ -345,8 +324,6 @@ static void framedone_callback(void *data, u32 mask)
 
 	if (callback != NULL)
 		callback(rfbi.framedone_callback_data);
-
-	atomic_set(&rfbi.cmd_pending, 0);
 }
 
 #if 1 /* VERBOSE */
@@ -436,7 +413,7 @@ static int calc_extif_timings(struct rfbi_timings *t)
 }
 
 
-void rfbi_set_timings(int rfbi_module, struct rfbi_timings *t)
+static void rfbi_set_timings(int rfbi_module, struct rfbi_timings *t)
 {
 	int r;
 
@@ -471,59 +448,6 @@ static int ps_to_rfbi_ticks(int time, int div)
 	return ret;
 }
 
-#ifdef OMAP_RFBI_RATE_LIMIT
-unsigned long rfbi_get_max_tx_rate(void)
-{
-	unsigned long   l4_rate, dss1_rate;
-	int             min_l4_ticks = 0;
-	int             i;
-
-	/* According to TI this can't be calculated so make the
-	 * adjustments for a couple of known frequencies and warn for
-	 * others.
-	 */
-	static const struct {
-		unsigned long l4_clk;           /* HZ */
-		unsigned long dss1_clk;         /* HZ */
-		unsigned long min_l4_ticks;
-	} ftab[] = {
-		{ 55,   132,    7, },           /* 7.86 MPix/s */
-		{ 110,  110,    12, },          /* 9.16 MPix/s */
-		{ 110,  132,    10, },          /* 11   Mpix/s */
-		{ 120,  120,    10, },          /* 12   Mpix/s */
-		{ 133,  133,    10, },          /* 13.3 Mpix/s */
-	};
-
-	l4_rate = rfbi.l4_khz / 1000;
-	dss1_rate = dss_clk_get_rate(DSS_CLK_FCK) / 1000000;
-
-	for (i = 0; i < ARRAY_SIZE(ftab); i++) {
-		/* Use a window instead of an exact match, to account
-		 * for different DPLL multiplier / divider pairs.
-		 */
-		if (abs(ftab[i].l4_clk - l4_rate) < 3 &&
-		    abs(ftab[i].dss1_clk - dss1_rate) < 3) {
-			min_l4_ticks = ftab[i].min_l4_ticks;
-			break;
-		}
-	}
-	if (i == ARRAY_SIZE(ftab)) {
-		/* Can't be sure, return anyway the maximum not
-		 * rate-limited. This might cause a problem only for the
-		 * tearing synchronisation.
-		 */
-		DSSERR("can't determine maximum RFBI transfer rate\n");
-		return rfbi.l4_khz * 1000;
-	}
-	return rfbi.l4_khz * 1000 / min_l4_ticks;
-}
-#else
-int rfbi_get_max_tx_rate(void)
-{
-	return rfbi.l4_khz * 1000;
-}
-#endif
-
 static void rfbi_get_clk_info(u32 *clk_period, u32 *max_clk_div)
 {
 	*clk_period = 1000000000 / rfbi.l4_khz;
@@ -683,44 +607,7 @@ int omap_rfbi_enable_te(bool enable, unsigned line)
 }
 EXPORT_SYMBOL(omap_rfbi_enable_te);
 
-#if 0
-static void rfbi_enable_config(int enable1, int enable2)
-{
-	u32 l;
-	int cs = 0;
-
-	if (enable1)
-		cs |= 1<<0;
-	if (enable2)
-		cs |= 1<<1;
-
-	rfbi_enable_clocks(1);
-
-	l = rfbi_read_reg(RFBI_CONTROL);
-
-	l = FLD_MOD(l, cs, 3, 2);
-	l = FLD_MOD(l, 0, 1, 1);
-
-	rfbi_write_reg(RFBI_CONTROL, l);
-
-
-	l = rfbi_read_reg(RFBI_CONFIG(0));
-	l = FLD_MOD(l, 0, 3, 2); /* TRIGGERMODE: ITE */
-	/*l |= FLD_VAL(2, 8, 7); */ /* L4FORMAT, 2pix/L4 */
-	/*l |= FLD_VAL(0, 8, 7); */ /* L4FORMAT, 1pix/L4 */
-
-	l = FLD_MOD(l, 0, 16, 16); /* A0POLARITY */
-	l = FLD_MOD(l, 1, 20, 20); /* TE_VSYNC_POLARITY */
-	l = FLD_MOD(l, 1, 21, 21); /* HSYNCPOLARITY */
-
-	l = FLD_MOD(l, OMAP_DSS_RFBI_PARALLELMODE_8, 1, 0);
-	rfbi_write_reg(RFBI_CONFIG(0), l);
-
-	rfbi_enable_clocks(0);
-}
-#endif
-
-int rfbi_configure(int rfbi_module, int bpp, int lines)
+static int rfbi_configure(int rfbi_module, int bpp, int lines)
 {
 	u32 l;
 	int cycle1 = 0, cycle2 = 0, cycle3 = 0;
@@ -1022,13 +909,8 @@ static int omap_rfbihw_probe(struct platform_device *pdev)
 
 	rfbi.pdev = pdev;
 
-	spin_lock_init(&rfbi.cmd_lock);
 	sema_init(&rfbi.bus_lock, 1);
 
-	init_completion(&rfbi.cmd_done);
-	atomic_set(&rfbi.cmd_fifo_full, 0);
-	atomic_set(&rfbi.cmd_pending, 0);
-
 	rfbi_mem = platform_get_resource(rfbi.pdev, IORESOURCE_MEM, 0);
 	if (!rfbi_mem) {
 		DSSERR("can't get IORESOURCE_MEM RFBI\n");
-- 
1.7.4.1

