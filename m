From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 03/15] OMAP: DSS2: Collect interrupt statistics
Date: Fri,  8 Jan 2010 15:22:37 +0200
Message-ID: <1262956969-1664-4-git-send-email-tomi.valkeinen@nokia.com>
References: <1262956969-1664-1-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-2-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-3-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:57066 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753199Ab0AHNWh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 08:22:37 -0500
In-Reply-To: <1262956969-1664-3-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Collect interrupt statistics, printable via debugfs:

debugfs/omapdss/dispc_irq
debugfs/omapdss/dsi_irq

The counters are reset when printed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/dss/Kconfig |    7 ++
 drivers/video/omap2/dss/core.c  |    8 +++
 drivers/video/omap2/dss/dispc.c |   67 +++++++++++++++++++++
 drivers/video/omap2/dss/dsi.c   |  125 +++++++++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss.h   |   14 ++++
 5 files changed, 221 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kconfig
index 71d8dec..c63ce76 100644
--- a/drivers/video/omap2/dss/Kconfig
+++ b/drivers/video/omap2/dss/Kconfig
@@ -25,6 +25,13 @@ config OMAP2_DSS_DEBUG_SUPPORT
 	  This enables debug messages. You need to enable printing
 	  with 'debug' module parameter.
 
+config OMAP2_DSS_COLLECT_IRQ_STATS
+	bool "Collect DSS IRQ statistics"
+	depends on OMAP2_DSS_DEBUG_SUPPORT
+	default n
+	help
+	  Collect DSS IRQ statistics, printable via debugfs
+
 config OMAP2_DSS_RFBI
 	bool "RFBI support"
         default n
diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 29497a0..dbb0ce2 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -395,6 +395,14 @@ static int dss_initialize_debugfs(void)
 	debugfs_create_file("clk", S_IRUGO, dss_debugfs_dir,
 			&dss_debug_dump_clocks, &dss_debug_fops);
 
+	debugfs_create_file("dispc_irq", S_IRUGO, dss_debugfs_dir,
+			&dispc_dump_irqs, &dss_debug_fops);
+
+#ifdef CONFIG_OMAP2_DSS_DSI
+	debugfs_create_file("dsi_irq", S_IRUGO, dss_debugfs_dir,
+			&dsi_dump_irqs, &dss_debug_fops);
+#endif
+
 	debugfs_create_file("dss", S_IRUGO, dss_debugfs_dir,
 			&dss_dump_regs, &dss_debug_fops);
 	debugfs_create_file("dispc", S_IRUGO, dss_debugfs_dir,
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 6dabf4b..e2e0f9a 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -148,6 +148,12 @@ static const struct dispc_reg dispc_reg_att[] = { DISPC_GFX_ATTRIBUTES,
 	DISPC_VID_ATTRIBUTES(0),
 	DISPC_VID_ATTRIBUTES(1) };
 
+struct dispc_irq_stats {
+	unsigned long last_reset;
+	unsigned irq_count;
+	unsigned irqs[32];
+};
+
 static struct {
 	void __iomem    *base;
 
@@ -160,6 +166,11 @@ static struct {
 	struct work_struct error_work;
 
 	u32		ctx[DISPC_SZ_REGS / sizeof(u32)];
+
+#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
+	spinlock_t irq_stats_lock;
+	struct dispc_irq_stats irq_stats;
+#endif
 } dispc;
 
 static void _omap_dispc_set_irqs(void);
@@ -2247,6 +2258,50 @@ void dispc_dump_clocks(struct seq_file *s)
 	enable_clocks(0);
 }
 
+#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
+void dispc_dump_irqs(struct seq_file *s)
+{
+	unsigned long flags;
+	struct dispc_irq_stats stats;
+
+	spin_lock_irqsave(&dispc.irq_stats_lock, flags);
+
+	stats = dispc.irq_stats;
+	memset(&dispc.irq_stats, 0, sizeof(dispc.irq_stats));
+	dispc.irq_stats.last_reset = jiffies;
+
+	spin_unlock_irqrestore(&dispc.irq_stats_lock, flags);
+
+	seq_printf(s, "period %u ms\n",
+			jiffies_to_msecs(jiffies - stats.last_reset));
+
+	seq_printf(s, "irqs %d\n", stats.irq_count);
+#define PIS(x) \
+	seq_printf(s, "%-20s %10d\n", #x, stats.irqs[ffs(DISPC_IRQ_##x)-1]);
+
+	PIS(FRAMEDONE);
+	PIS(VSYNC);
+	PIS(EVSYNC_EVEN);
+	PIS(EVSYNC_ODD);
+	PIS(ACBIAS_COUNT_STAT);
+	PIS(PROG_LINE_NUM);
+	PIS(GFX_FIFO_UNDERFLOW);
+	PIS(GFX_END_WIN);
+	PIS(PAL_GAMMA_MASK);
+	PIS(OCP_ERR);
+	PIS(VID1_FIFO_UNDERFLOW);
+	PIS(VID1_END_WIN);
+	PIS(VID2_FIFO_UNDERFLOW);
+	PIS(VID2_END_WIN);
+	PIS(SYNC_LOST);
+	PIS(SYNC_LOST_DIGIT);
+	PIS(WAKEUP);
+#undef PIS
+}
+#else
+void dispc_dump_irqs(struct seq_file *s) { }
+#endif
+
 void dispc_dump_regs(struct seq_file *s)
 {
 #define DUMPREG(r) seq_printf(s, "%-35s %08x\n", #r, dispc_read_reg(r))
@@ -2665,6 +2720,13 @@ void dispc_irq_handler(void)
 
 	irqstatus = dispc_read_reg(DISPC_IRQSTATUS);
 
+#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
+	spin_lock(&dispc.irq_stats_lock);
+	dispc.irq_stats.irq_count++;
+	dss_collect_irq_stats(irqstatus, dispc.irq_stats.irqs);
+	spin_unlock(&dispc.irq_stats_lock);
+#endif
+
 #ifdef DEBUG
 	if (dss_debug)
 		print_irq_status(irqstatus);
@@ -3012,6 +3074,11 @@ int dispc_init(void)
 
 	spin_lock_init(&dispc.irq_lock);
 
+#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
+	spin_lock_init(&dispc.irq_stats_lock);
+	dispc.irq_stats.last_reset = jiffies;
+#endif
+
 	INIT_WORK(&dispc.error_work, dispc_error_worker);
 
 	dispc.base = ioremap(DISPC_BASE, DISPC_SZ_REGS);
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index dda7b3f..f3eaf12 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -204,6 +204,14 @@ struct dsi_update_region {
 	struct omap_dss_device *device;
 };
 
+struct dsi_irq_stats {
+	unsigned long last_reset;
+	unsigned irq_count;
+	unsigned dsi_irqs[32];
+	unsigned vc_irqs[4][32];
+	unsigned cio_irqs[32];
+};
+
 static struct
 {
 	void __iomem	*base;
@@ -258,6 +266,11 @@ static struct
 #endif
 	int debug_read;
 	int debug_write;
+
+#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
+	spinlock_t irq_stats_lock;
+	struct dsi_irq_stats irq_stats;
+#endif
 } dsi;
 
 #ifdef DEBUG
@@ -528,6 +541,12 @@ void dsi_irq_handler(void)
 
 	irqstatus = dsi_read_reg(DSI_IRQSTATUS);
 
+#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
+	spin_lock(&dsi.irq_stats_lock);
+	dsi.irq_stats.irq_count++;
+	dss_collect_irq_stats(irqstatus, dsi.irq_stats.dsi_irqs);
+#endif
+
 	if (irqstatus & DSI_IRQ_ERROR_MASK) {
 		DSSERR("DSI error, irqstatus %x\n", irqstatus);
 		print_irq_status(irqstatus);
@@ -549,6 +568,10 @@ void dsi_irq_handler(void)
 
 		vcstatus = dsi_read_reg(DSI_VC_IRQSTATUS(i));
 
+#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
+		dss_collect_irq_stats(vcstatus, dsi.irq_stats.vc_irqs[i]);
+#endif
+
 		if (vcstatus & DSI_VC_IRQ_BTA)
 			complete(&dsi.bta_completion);
 
@@ -568,6 +591,10 @@ void dsi_irq_handler(void)
 	if (irqstatus & DSI_IRQ_COMPLEXIO_ERR) {
 		ciostatus = dsi_read_reg(DSI_COMPLEXIO_IRQ_STATUS);
 
+#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
+		dss_collect_irq_stats(ciostatus, dsi.irq_stats.cio_irqs);
+#endif
+
 		dsi_write_reg(DSI_COMPLEXIO_IRQ_STATUS, ciostatus);
 		/* flush posted write */
 		dsi_read_reg(DSI_COMPLEXIO_IRQ_STATUS);
@@ -579,6 +606,10 @@ void dsi_irq_handler(void)
 	dsi_write_reg(DSI_IRQSTATUS, irqstatus & ~DSI_IRQ_CHANNEL_MASK);
 	/* flush posted write */
 	dsi_read_reg(DSI_IRQSTATUS);
+
+#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
+	spin_unlock(&dsi.irq_stats_lock);
+#endif
 }
 
 
@@ -1226,6 +1257,95 @@ void dsi_dump_clocks(struct seq_file *s)
 	enable_clocks(0);
 }
 
+#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
+void dsi_dump_irqs(struct seq_file *s)
+{
+	unsigned long flags;
+	struct dsi_irq_stats stats;
+
+	spin_lock_irqsave(&dsi.irq_stats_lock, flags);
+
+	stats = dsi.irq_stats;
+	memset(&dsi.irq_stats, 0, sizeof(dsi.irq_stats));
+	dsi.irq_stats.last_reset = jiffies;
+
+	spin_unlock_irqrestore(&dsi.irq_stats_lock, flags);
+
+	seq_printf(s, "period %u ms\n",
+			jiffies_to_msecs(jiffies - stats.last_reset));
+
+	seq_printf(s, "irqs %d\n", stats.irq_count);
+#define PIS(x) \
+	seq_printf(s, "%-20s %10d\n", #x, stats.dsi_irqs[ffs(DSI_IRQ_##x)-1]);
+
+	seq_printf(s, "-- DSI interrupts --\n");
+	PIS(VC0);
+	PIS(VC1);
+	PIS(VC2);
+	PIS(VC3);
+	PIS(WAKEUP);
+	PIS(RESYNC);
+	PIS(PLL_LOCK);
+	PIS(PLL_UNLOCK);
+	PIS(PLL_RECALL);
+	PIS(COMPLEXIO_ERR);
+	PIS(HS_TX_TIMEOUT);
+	PIS(LP_RX_TIMEOUT);
+	PIS(TE_TRIGGER);
+	PIS(ACK_TRIGGER);
+	PIS(SYNC_LOST);
+	PIS(LDO_POWER_GOOD);
+	PIS(TA_TIMEOUT);
+#undef PIS
+
+#define PIS(x) \
+	seq_printf(s, "%-20s %10d %10d %10d %10d\n", #x, \
+			stats.vc_irqs[0][ffs(DSI_VC_IRQ_##x)-1], \
+			stats.vc_irqs[1][ffs(DSI_VC_IRQ_##x)-1], \
+			stats.vc_irqs[2][ffs(DSI_VC_IRQ_##x)-1], \
+			stats.vc_irqs[3][ffs(DSI_VC_IRQ_##x)-1]);
+
+	seq_printf(s, "-- VC interrupts --\n");
+	PIS(CS);
+	PIS(ECC_CORR);
+	PIS(PACKET_SENT);
+	PIS(FIFO_TX_OVF);
+	PIS(FIFO_RX_OVF);
+	PIS(BTA);
+	PIS(ECC_NO_CORR);
+	PIS(FIFO_TX_UDF);
+	PIS(PP_BUSY_CHANGE);
+#undef PIS
+
+#define PIS(x) \
+	seq_printf(s, "%-20s %10d\n", #x, \
+			stats.cio_irqs[ffs(DSI_CIO_IRQ_##x)-1]);
+
+	seq_printf(s, "-- CIO interrupts --\n");
+	PIS(ERRSYNCESC1);
+	PIS(ERRSYNCESC2);
+	PIS(ERRSYNCESC3);
+	PIS(ERRESC1);
+	PIS(ERRESC2);
+	PIS(ERRESC3);
+	PIS(ERRCONTROL1);
+	PIS(ERRCONTROL2);
+	PIS(ERRCONTROL3);
+	PIS(STATEULPS1);
+	PIS(STATEULPS2);
+	PIS(STATEULPS3);
+	PIS(ERRCONTENTIONLP0_1);
+	PIS(ERRCONTENTIONLP1_1);
+	PIS(ERRCONTENTIONLP0_2);
+	PIS(ERRCONTENTIONLP1_2);
+	PIS(ERRCONTENTIONLP0_3);
+	PIS(ERRCONTENTIONLP1_3);
+	PIS(ULPSACTIVENOT_ALL0);
+	PIS(ULPSACTIVENOT_ALL1);
+#undef PIS
+}
+#endif
+
 void dsi_dump_regs(struct seq_file *s)
 {
 #define DUMPREG(r) seq_printf(s, "%-35s %08x\n", #r, dsi_read_reg(r))
@@ -3638,6 +3758,11 @@ int dsi_init(struct platform_device *pdev)
 	spin_lock_init(&dsi.errors_lock);
 	dsi.errors = 0;
 
+#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
+	spin_lock_init(&dsi.irq_stats_lock);
+	dsi.irq_stats.last_reset = jiffies;
+#endif
+
 	init_completion(&dsi.bta_completion);
 	init_completion(&dsi.update_completion);
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 8da5ac4..2bcb124 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -240,6 +240,7 @@ int dsi_init(struct platform_device *pdev);
 void dsi_exit(void);
 
 void dsi_dump_clocks(struct seq_file *s);
+void dsi_dump_irqs(struct seq_file *s);
 void dsi_dump_regs(struct seq_file *s);
 
 void dsi_save_context(void);
@@ -268,6 +269,7 @@ int dpi_init_display(struct omap_dss_device *dssdev);
 int dispc_init(void);
 void dispc_exit(void);
 void dispc_dump_clocks(struct seq_file *s);
+void dispc_dump_irqs(struct seq_file *s);
 void dispc_dump_regs(struct seq_file *s);
 void dispc_irq_handler(void);
 void dispc_fake_vsync_irq(void);
@@ -367,4 +369,16 @@ void rfbi_set_timings(int rfbi_module, struct rfbi_timings *t);
 unsigned long rfbi_get_max_tx_rate(void);
 int rfbi_init_display(struct omap_dss_device *display);
 
+
+#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
+static inline void dss_collect_irq_stats(u32 irqstatus, unsigned *irq_arr)
+{
+	int b;
+	for (b = 0; b < 32; ++b) {
+		if (irqstatus & (1 << b))
+			irq_arr[b]++;
+	}
+}
+#endif
+
 #endif
-- 
1.6.5

