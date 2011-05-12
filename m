From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 6/7] OMAP4: DSS2: DSI: Changes for DSI2 on OMAP4
Date: Thu, 12 May 2011 17:26:29 +0530
Message-ID: <1305201390-9724-7-git-send-email-archit@ti.com>
References: <1305201390-9724-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51610 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756027Ab1ELLwK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 May 2011 07:52:10 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4CBq9gR018393
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 12 May 2011 06:52:10 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p4CBq990023301
	for <linux-omap@vger.kernel.org>; Thu, 12 May 2011 06:52:09 -0500 (CDT)
In-Reply-To: <1305201390-9724-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Introduce DSI2 PLL clock sources needed by LCD2 channel and DSI2 Protocol
engine and DISPC Functional clock. Do the following:

- Modify dss_get_dsi_clk_source() and dss_select_dsi_clk_source() to take the
  dsi module number as an argument.
- Create debugfs files for dsi2, split the corresponding debugfs functions.
- Allow DPI to use these new clock sources.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/core.c         |    6 +-
 drivers/video/omap2/dss/dispc.c        |    8 ++
 drivers/video/omap2/dss/dpi.c          |    6 ++-
 drivers/video/omap2/dss/dsi.c          |  117 +++++++++++++++++++++++++++-----
 drivers/video/omap2/dss/dss.c          |   32 +++++++--
 drivers/video/omap2/dss/dss.h          |   15 +++-
 drivers/video/omap2/dss/dss_features.c |    2 +
 include/video/omapdss.h                |    2 +
 8 files changed, 157 insertions(+), 31 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 5fbf9e8..3da4267 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -127,8 +127,7 @@ static int dss_initialize_debugfs(void)
 #endif
 
 #if defined(CONFIG_OMAP2_DSS_DSI) && defined(CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS)
-	debugfs_create_file("dsi_irq", S_IRUGO, dss_debugfs_dir,
-			&dsi_dump_irqs, &dss_debug_fops);
+	dsi_create_debugfs_files_irq(dss_debugfs_dir, &dss_debug_fops);
 #endif
 
 	debugfs_create_file("dss", S_IRUGO, dss_debugfs_dir,
@@ -140,8 +139,7 @@ static int dss_initialize_debugfs(void)
 			&rfbi_dump_regs, &dss_debug_fops);
 #endif
 #ifdef CONFIG_OMAP2_DSS_DSI
-	debugfs_create_file("dsi", S_IRUGO, dss_debugfs_dir,
-			&dsi_dump_regs, &dss_debug_fops);
+	dsi_create_debugfs_files_reg(dss_debugfs_dir, &dss_debug_fops);
 #endif
 #ifdef CONFIG_OMAP2_DSS_VENC
 	debugfs_create_file("venc", S_IRUGO, dss_debugfs_dir,
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index df8c992..1a2d835 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2250,6 +2250,10 @@ unsigned long dispc_fclk_rate(void)
 		dsidev = dsi_get_dsidev_from_id(0);
 		r = dsi_get_pll_hsdiv_dispc_rate(dsidev);
 		break;
+	case OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC:
+		dsidev = dsi_get_dsidev_from_id(1);
+		r = dsi_get_pll_hsdiv_dispc_rate(dsidev);
+		break;
 	default:
 		BUG();
 	}
@@ -2276,6 +2280,10 @@ unsigned long dispc_lclk_rate(enum omap_channel channel)
 		dsidev = dsi_get_dsidev_from_id(0);
 		r = dsi_get_pll_hsdiv_dispc_rate(dsidev);
 		break;
+	case OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC:
+		dsidev = dsi_get_dsidev_from_id(1);
+		r = dsi_get_pll_hsdiv_dispc_rate(dsidev);
+		break;
 	default:
 		BUG();
 	}
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 4d661a9..ff6bd30 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -53,8 +53,12 @@ static bool dpi_use_dsi_pll(struct omap_dss_device *dssdev)
 {
 	if (dssdev->clocks.dispc.dispc_fclk_src ==
 			OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC ||
+			dssdev->clocks.dispc.dispc_fclk_src ==
+			OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC ||
 			dssdev->clocks.dispc.channel.lcd_clk_src ==
-			OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC)
+			OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC ||
+			dssdev->clocks.dispc.channel.lcd_clk_src ==
+			OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC)
 		return true;
 	else
 		return false;
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 762b0fe..85ec3d6 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -35,6 +35,7 @@
 #include <linux/workqueue.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/debugfs.h>
 
 #include <video/omapdss.h>
 #include <plat/clock.h>
@@ -1143,8 +1144,9 @@ static unsigned long dsi_get_txbyteclkhs(struct platform_device *dsidev)
 static unsigned long dsi_fclk_rate(struct platform_device *dsidev)
 {
 	unsigned long r;
+	int dsi_module = dsi_get_dsidev_id(dsidev);
 
-	if (dss_get_dsi_clk_source() == OMAP_DSS_CLK_SRC_FCK) {
+	if (dss_get_dsi_clk_source(dsi_module) == OMAP_DSS_CLK_SRC_FCK) {
 		/* DSI FCLK source is DSS_CLK_FCK */
 		r = dss_clk_get_rate(DSS_CLK_FCK);
 	} else {
@@ -1670,19 +1672,20 @@ void dsi_pll_uninit(struct platform_device *dsidev, bool disconnect_lanes)
 	DSSDBG("PLL uninit done\n");
 }
 
-void dsi_dump_clocks(struct seq_file *s)
+static void dsi_dump_dsidev_clocks(struct platform_device *dsidev,
+		struct seq_file *s)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_id(0);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	struct dsi_clock_info *cinfo = &dsi->current_cinfo;
 	enum omap_dss_clk_source dispc_clk_src, dsi_clk_src;
+	int dsi_module = dsi_get_dsidev_id(dsidev);
 
 	dispc_clk_src = dss_get_dispc_clk_source();
-	dsi_clk_src = dss_get_dsi_clk_source();
+	dsi_clk_src = dss_get_dsi_clk_source(dsi_module);
 
 	enable_clocks(1);
 
-	seq_printf(s,	"- DSI PLL -\n");
+	seq_printf(s,	"- DSI%d PLL -\n", dsi_module + 1);
 
 	seq_printf(s,	"dsi pll source = %s\n",
 			cinfo->use_sys_clk ? "dss_sys_clk" : "pclkfree");
@@ -1708,7 +1711,7 @@ void dsi_dump_clocks(struct seq_file *s)
 			dsi_clk_src == OMAP_DSS_CLK_SRC_FCK ?
 			"off" : "on");
 
-	seq_printf(s,	"- DSI -\n");
+	seq_printf(s,	"- DSI%d -\n", dsi_module + 1);
 
 	seq_printf(s,	"dsi fclk source = %s (%s)\n",
 			dss_get_generic_clk_source_name(dsi_clk_src),
@@ -1731,13 +1734,26 @@ void dsi_dump_clocks(struct seq_file *s)
 	enable_clocks(0);
 }
 
+void dsi_dump_clocks(struct seq_file *s)
+{
+	struct platform_device *dsidev;
+	int i;
+
+	for  (i = 0; i < MAX_NUM_DSI; i++) {
+		dsidev = dsi_get_dsidev_from_id(i);
+		if (dsidev)
+			dsi_dump_dsidev_clocks(dsidev, s);
+	}
+}
+
 #ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
-void dsi_dump_irqs(struct seq_file *s)
+static void dsi_dump_dsidev_irqs(struct platform_device *dsidev,
+		struct seq_file *s)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_id(0);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	unsigned long flags;
 	struct dsi_irq_stats stats;
+	int dsi_module = dsi_get_dsidev_id(dsidev);
 
 	spin_lock_irqsave(&dsi->irq_stats_lock, flags);
 
@@ -1754,7 +1770,7 @@ void dsi_dump_irqs(struct seq_file *s)
 #define PIS(x) \
 	seq_printf(s, "%-20s %10d\n", #x, stats.dsi_irqs[ffs(DSI_IRQ_##x)-1]);
 
-	seq_printf(s, "-- DSI interrupts --\n");
+	seq_printf(s, "-- DSI%d interrupts --\n", dsi_module + 1);
 	PIS(VC0);
 	PIS(VC1);
 	PIS(VC2);
@@ -1820,12 +1836,41 @@ void dsi_dump_irqs(struct seq_file *s)
 	PIS(ULPSACTIVENOT_ALL1);
 #undef PIS
 }
-#endif
 
-void dsi_dump_regs(struct seq_file *s)
+static void dsi1_dump_irqs(struct seq_file *s)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_id(0);
 
+	dsi_dump_dsidev_irqs(dsidev, s);
+}
+
+static void dsi2_dump_irqs(struct seq_file *s)
+{
+	struct platform_device *dsidev = dsi_get_dsidev_from_id(1);
+
+	dsi_dump_dsidev_irqs(dsidev, s);
+}
+
+void dsi_create_debugfs_files_irq(struct dentry *debugfs_dir,
+		const struct file_operations *debug_fops)
+{
+	struct platform_device *dsidev;
+
+	dsidev = dsi_get_dsidev_from_id(0);
+	if (dsidev)
+		debugfs_create_file("dsi1_irqs", S_IRUGO, debugfs_dir,
+			&dsi1_dump_irqs, debug_fops);
+
+	dsidev = dsi_get_dsidev_from_id(1);
+	if (dsidev)
+		debugfs_create_file("dsi2_irqs", S_IRUGO, debugfs_dir,
+			&dsi2_dump_irqs, debug_fops);
+}
+#endif
+
+static void dsi_dump_dsidev_regs(struct platform_device *dsidev,
+		struct seq_file *s)
+{
 #define DUMPREG(r) seq_printf(s, "%-35s %08x\n", #r, dsi_read_reg(dsidev, r))
 
 	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
@@ -1906,6 +1951,35 @@ void dsi_dump_regs(struct seq_file *s)
 #undef DUMPREG
 }
 
+static void dsi1_dump_regs(struct seq_file *s)
+{
+	struct platform_device *dsidev = dsi_get_dsidev_from_id(0);
+
+	dsi_dump_dsidev_regs(dsidev, s);
+}
+
+static void dsi2_dump_regs(struct seq_file *s)
+{
+	struct platform_device *dsidev = dsi_get_dsidev_from_id(1);
+
+	dsi_dump_dsidev_regs(dsidev, s);
+}
+
+void dsi_create_debugfs_files_reg(struct dentry *debugfs_dir,
+		const struct file_operations *debug_fops)
+{
+	struct platform_device *dsidev;
+
+	dsidev = dsi_get_dsidev_from_id(0);
+	if (dsidev)
+		debugfs_create_file("dsi1_regs", S_IRUGO, debugfs_dir,
+			&dsi1_dump_regs, debug_fops);
+
+	dsidev = dsi_get_dsidev_from_id(1);
+	if (dsidev)
+		debugfs_create_file("dsi2_regs", S_IRUGO, debugfs_dir,
+			&dsi2_dump_regs, debug_fops);
+}
 enum dsi_cio_power_state {
 	DSI_COMPLEXIO_POWER_OFF		= 0x0,
 	DSI_COMPLEXIO_POWER_ON		= 0x1,
@@ -3847,9 +3921,13 @@ EXPORT_SYMBOL(omap_dsi_update);
 static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 {
 	int r;
+	u32 irq;
+
+	irq = dssdev->manager->id == OMAP_DSS_CHANNEL_LCD ?
+		DISPC_IRQ_FRAMEDONE : DISPC_IRQ_FRAMEDONE2;
 
 	r = omap_dispc_register_isr(dsi_framedone_irq_callback, (void *) dssdev,
-			DISPC_IRQ_FRAMEDONE);
+			irq);
 	if (r) {
 		DSSERR("can't get FRAMEDONE irq\n");
 		return r;
@@ -3882,8 +3960,13 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 
 static void dsi_display_uninit_dispc(struct omap_dss_device *dssdev)
 {
+	u32 irq;
+
+	irq = dssdev->manager->id == OMAP_DSS_CHANNEL_LCD ?
+		DISPC_IRQ_FRAMEDONE : DISPC_IRQ_FRAMEDONE2;
+
 	omap_dispc_unregister_isr(dsi_framedone_irq_callback, (void *) dssdev,
-			DISPC_IRQ_FRAMEDONE);
+			irq);
 }
 
 static int dsi_configure_dsi_clocks(struct omap_dss_device *dssdev)
@@ -3943,6 +4026,7 @@ static int dsi_configure_dispc_clocks(struct omap_dss_device *dssdev)
 static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	int dsi_module = dsi_get_dsidev_id(dsidev);
 	int r;
 
 	r = dsi_pll_init(dsidev, true, true);
@@ -3954,7 +4038,7 @@ static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
 		goto err1;
 
 	dss_select_dispc_clk_source(dssdev->clocks.dispc.dispc_fclk_src);
-	dss_select_dsi_clk_source(dssdev->clocks.dsi.dsi_fclk_src);
+	dss_select_dsi_clk_source(dsi_module, dssdev->clocks.dsi.dsi_fclk_src);
 	dss_select_lcd_clk_source(dssdev->manager->id,
 			dssdev->clocks.dispc.channel.lcd_clk_src);
 
@@ -3993,7 +4077,7 @@ err3:
 	dsi_cio_uninit(dsidev);
 err2:
 	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
-	dss_select_dsi_clk_source(OMAP_DSS_CLK_SRC_FCK);
+	dss_select_dsi_clk_source(dsi_module, OMAP_DSS_CLK_SRC_FCK);
 err1:
 	dsi_pll_uninit(dsidev, true);
 err0:
@@ -4005,6 +4089,7 @@ static void dsi_display_uninit_dsi(struct omap_dss_device *dssdev,
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	int dsi_module = dsi_get_dsidev_id(dsidev);
 
 	if (enter_ulps && !dsi->ulps_enabled)
 		dsi_enter_ulps(dsidev);
@@ -4017,7 +4102,7 @@ static void dsi_display_uninit_dsi(struct omap_dss_device *dssdev,
 	dsi_vc_enable(dsidev, 3, 0);
 
 	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
-	dss_select_dsi_clk_source(OMAP_DSS_CLK_SRC_FCK);
+	dss_select_dsi_clk_source(dsi_module, OMAP_DSS_CLK_SRC_FCK);
 	dsi_cio_uninit(dsidev);
 	dsi_pll_uninit(dsidev, disconnect_lanes);
 }
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 3bf6e62..d9489d5 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -74,7 +74,7 @@ static struct {
 	struct dss_clock_info cache_dss_cinfo;
 	struct dispc_clock_info cache_dispc_cinfo;
 
-	enum omap_dss_clk_source dsi_clk_source;
+	enum omap_dss_clk_source dsi_clk_source[MAX_NUM_DSI];
 	enum omap_dss_clk_source dispc_clk_source;
 	enum omap_dss_clk_source lcd_clk_source[MAX_DSS_LCD_MANAGERS];
 
@@ -313,6 +313,11 @@ void dss_select_dispc_clk_source(enum omap_dss_clk_source clk_src)
 		dsidev = dsi_get_dsidev_from_id(0);
 		dsi_wait_pll_hsdiv_dispc_active(dsidev);
 		break;
+	case OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC:
+		b = 2;
+		dsidev = dsi_get_dsidev_from_id(1);
+		dsi_wait_pll_hsdiv_dispc_active(dsidev);
+		break;
 	default:
 		BUG();
 	}
@@ -324,7 +329,8 @@ void dss_select_dispc_clk_source(enum omap_dss_clk_source clk_src)
 	dss.dispc_clk_source = clk_src;
 }
 
-void dss_select_dsi_clk_source(enum omap_dss_clk_source clk_src)
+void dss_select_dsi_clk_source(int dsi_module,
+		enum omap_dss_clk_source clk_src)
 {
 	struct platform_device *dsidev;
 	int b;
@@ -334,17 +340,24 @@ void dss_select_dsi_clk_source(enum omap_dss_clk_source clk_src)
 		b = 0;
 		break;
 	case OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI:
+		BUG_ON(dsi_module != 0);
 		b = 1;
 		dsidev = dsi_get_dsidev_from_id(0);
 		dsi_wait_pll_hsdiv_dsi_active(dsidev);
 		break;
+	case OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DSI:
+		BUG_ON(dsi_module != 1);
+		b = 1;
+		dsidev = dsi_get_dsidev_from_id(1);
+		dsi_wait_pll_hsdiv_dsi_active(dsidev);
+		break;
 	default:
 		BUG();
 	}
 
 	REG_FLD_MOD(DSS_CONTROL, b, 1, 1);	/* DSI_CLK_SWITCH */
 
-	dss.dsi_clk_source = clk_src;
+	dss.dsi_clk_source[dsi_module] = clk_src;
 }
 
 void dss_select_lcd_clk_source(enum omap_channel channel,
@@ -366,6 +379,12 @@ void dss_select_lcd_clk_source(enum omap_channel channel,
 		dsidev = dsi_get_dsidev_from_id(0);
 		dsi_wait_pll_hsdiv_dispc_active(dsidev);
 		break;
+	case OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC:
+		BUG_ON(channel != OMAP_DSS_CHANNEL_LCD2);
+		b = 1;
+		dsidev = dsi_get_dsidev_from_id(1);
+		dsi_wait_pll_hsdiv_dispc_active(dsidev);
+		break;
 	default:
 		BUG();
 	}
@@ -382,9 +401,9 @@ enum omap_dss_clk_source dss_get_dispc_clk_source(void)
 	return dss.dispc_clk_source;
 }
 
-enum omap_dss_clk_source dss_get_dsi_clk_source(void)
+enum omap_dss_clk_source dss_get_dsi_clk_source(int dsi_module)
 {
-	return dss.dsi_clk_source;
+	return dss.dsi_clk_source[dsi_module];
 }
 
 enum omap_dss_clk_source dss_get_lcd_clk_source(enum omap_channel channel)
@@ -715,7 +734,8 @@ static int dss_init(void)
 
 	dss.dpll4_m4_ck = dpll4_m4_ck;
 
-	dss.dsi_clk_source = OMAP_DSS_CLK_SRC_FCK;
+	dss.dsi_clk_source[0] = OMAP_DSS_CLK_SRC_FCK;
+	dss.dsi_clk_source[1] = OMAP_DSS_CLK_SRC_FCK;
 	dss.dispc_clk_source = OMAP_DSS_CLK_SRC_FCK;
 	dss.lcd_clk_source[0] = OMAP_DSS_CLK_SRC_FCK;
 	dss.lcd_clk_source[1] = OMAP_DSS_CLK_SRC_FCK;
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 90b4d51..3e6dbd5 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -240,11 +240,12 @@ int dss_sdi_enable(void);
 void dss_sdi_disable(void);
 
 void dss_select_dispc_clk_source(enum omap_dss_clk_source clk_src);
-void dss_select_dsi_clk_source(enum omap_dss_clk_source clk_src);
+void dss_select_dsi_clk_source(int dsi_module,
+		enum omap_dss_clk_source clk_src);
 void dss_select_lcd_clk_source(enum omap_channel channel,
 		enum omap_dss_clk_source clk_src);
 enum omap_dss_clk_source dss_get_dispc_clk_source(void);
-enum omap_dss_clk_source dss_get_dsi_clk_source(void);
+enum omap_dss_clk_source dss_get_dsi_clk_source(int dsi_module);
 enum omap_dss_clk_source dss_get_lcd_clk_source(enum omap_channel channel);
 
 void dss_set_venc_output(enum omap_dss_venc_type type);
@@ -275,12 +276,18 @@ static inline void sdi_exit(void)
 
 /* DSI */
 #ifdef CONFIG_OMAP2_DSS_DSI
+
+struct dentry;
+struct file_operations;
+
 int dsi_init_platform_driver(void);
 void dsi_uninit_platform_driver(void);
 
 void dsi_dump_clocks(struct seq_file *s);
-void dsi_dump_irqs(struct seq_file *s);
-void dsi_dump_regs(struct seq_file *s);
+void dsi_create_debugfs_files_irq(struct dentry *debugfs_dir,
+		const struct file_operations *debug_fops);
+void dsi_create_debugfs_files_reg(struct dentry *debugfs_dir,
+		const struct file_operations *debug_fops);
 
 void dsi_save_context(void);
 void dsi_restore_context(void);
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 66f8711..5be5eb0 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -193,6 +193,8 @@ static const char * const omap4_dss_clk_source_names[] = {
 	[OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC]	= "PLL1_CLK1",
 	[OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI]	= "PLL1_CLK2",
 	[OMAP_DSS_CLK_SRC_FCK]			= "DSS_FCLK",
+	[OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC]	= "PLL2_CLK1",
+	[OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DSI]	= "PLL2_CLK2",
 };
 
 static const struct dss_param_range omap2_dss_param_range[] = {
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 9129065..e3c9e08 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -179,6 +179,8 @@ enum omap_dss_clk_source {
 						 * OMAP4: PLL1_CLK1 */
 	OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI,	/* OMAP3: DSI2_PLL_FCLK
 						 * OMAP4: PLL1_CLK2 */
+	OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC,	/* OMAP4: PLL2_CLK1 */
+	OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DSI,	/* OMAP4: PLL2_CLK2 */
 };
 
 /* RFBI */
-- 
1.7.1

