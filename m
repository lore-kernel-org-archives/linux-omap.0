From: Archit Taneja <archit@ti.com>
Subject: [PATCH 7/9] OMAP4: DSS2: DSI: Changes for DSI2 on OMAP4
Date: Wed,  4 May 2011 13:08:22 +0530
Message-ID: <1304494704-7285-8-git-send-email-archit@ti.com>
References: <1304494704-7285-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37724 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751463Ab1EDHd5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 May 2011 03:33:57 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p447Xvik030694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 4 May 2011 02:33:57 -0500
In-Reply-To: <1304494704-7285-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Introduce DSI2 PLL clock sources needed by LCD2 channel and DSI2 Protocol
engine and DISPC Functional clock. Do the following:

- Modify dss_get_dsi_clk_source() and dss_select_dsi_clk_source() to take the
  dsi module number as an argument.
- Create debugfs files for dsi2, split the corresponding debugfs functions.
- Split packet_sent_handler irqs for dsi1 and dsi2.
- Allow DPI to use these new clock sources.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/plat-omap/include/plat/display.h |    2 +
 drivers/video/omap2/dss/core.c            |   14 ++++--
 drivers/video/omap2/dss/dispc.c           |    8 +++
 drivers/video/omap2/dss/dpi.c             |    6 ++-
 drivers/video/omap2/dss/dsi.c             |   73 ++++++++++++++++++++++------
 drivers/video/omap2/dss/dss.c             |   36 +++++++++++---
 drivers/video/omap2/dss/dss.h             |   15 ++++--
 drivers/video/omap2/dss/dss_features.c    |    5 ++-
 drivers/video/omap2/dss/dss_features.h    |    1 +
 9 files changed, 126 insertions(+), 34 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index 6305ff6..5568984 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -181,6 +181,8 @@ enum omap_dss_clk_source {
 						 * OMAP4: PLL1_CLK1 */
 	OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI,	/* OMAP3: DSI2_PLL_FCLK
 						 * OMAP4: PLL1_CLK2 */
+	OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC,	/* OMAP4: PLL2_CLK1 */
+	OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DSI,	/* OMAP4: PLL2_CLK2 */
 };
 
 /* RFBI */
diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 9bcb0b8..9c52e38 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -127,8 +127,11 @@ static int dss_initialize_debugfs(void)
 #endif
 
 #if defined(CONFIG_OMAP2_DSS_DSI) && defined(CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS)
-	debugfs_create_file("dsi_irq", S_IRUGO, dss_debugfs_dir,
-			&dsi_dump_irqs, &dss_debug_fops);
+	debugfs_create_file("dsi1_irq", S_IRUGO, dss_debugfs_dir,
+			&dsi1_dump_irqs, &dss_debug_fops);
+	if (dss_has_feature(FEAT_DSS_DSI2))
+		debugfs_create_file("dsi2_irq", S_IRUGO, dss_debugfs_dir,
+			&dsi2_dump_irqs, &dss_debug_fops);
 #endif
 
 	debugfs_create_file("dss", S_IRUGO, dss_debugfs_dir,
@@ -140,8 +143,11 @@ static int dss_initialize_debugfs(void)
 			&rfbi_dump_regs, &dss_debug_fops);
 #endif
 #ifdef CONFIG_OMAP2_DSS_DSI
-	debugfs_create_file("dsi", S_IRUGO, dss_debugfs_dir,
-			&dsi_dump_regs, &dss_debug_fops);
+	debugfs_create_file("dsi1", S_IRUGO, dss_debugfs_dir,
+			&dsi1_dump_regs, &dss_debug_fops);
+	if (dss_has_feature(FEAT_DSS_DSI2))
+		debugfs_create_file("dsi2", S_IRUGO, dss_debugfs_dir,
+				&dsi2_dump_regs, &dss_debug_fops);
 #endif
 #ifdef CONFIG_OMAP2_DSS_VENC
 	debugfs_create_file("venc", S_IRUGO, dss_debugfs_dir,
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 7927660..92a1172 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2364,6 +2364,10 @@ unsigned long dispc_fclk_rate(void)
 		dsidev = dsi_get_dsi_device_module(0);
 		r = dsi_get_pll_hsdiv_dispc_rate(dsidev);
 		break;
+	case OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC:
+		dsidev = dsi_get_dsi_device_module(1);
+		r = dsi_get_pll_hsdiv_dispc_rate(dsidev);
+		break;
 	default:
 		BUG();
 	}
@@ -2390,6 +2394,10 @@ unsigned long dispc_lclk_rate(enum omap_channel channel)
 		dsidev = dsi_get_dsi_device_module(0);
 		r = dsi_get_pll_hsdiv_dispc_rate(dsidev);
 		break;
+	case OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC:
+		dsidev = dsi_get_dsi_device_module(1);
+		r = dsi_get_pll_hsdiv_dispc_rate(dsidev);
+		break;
 	default:
 		BUG();
 	}
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 97d7985..7f65ee2 100644
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
index a8478be..eead89a 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1134,7 +1134,7 @@ static unsigned long dsi_fclk_rate(struct platform_device *dsidev)
 {
 	unsigned long r;
 
-	if (dss_get_dsi_clk_source() == OMAP_DSS_CLK_SRC_FCK) {
+	if (dss_get_dsi_clk_source(dsidev->id) == OMAP_DSS_CLK_SRC_FCK) {
 		/* DSI FCLK source is DSS_CLK_FCK */
 		r = dss_clk_get_rate(DSS_CLK_FCK);
 	} else {
@@ -1660,19 +1660,18 @@ void dsi_pll_uninit(struct platform_device *dsidev, bool disconnect_lanes)
 	DSSDBG("PLL uninit done\n");
 }
 
-void dsi_dump_clocks(struct seq_file *s)
+static void dsi_dump_clocks(struct platform_device *dsidev, struct seq_file *s)
 {
-	struct platform_device *dsidev = dsi_get_dsi_device_module(0);
 	struct dsi_data *dsi = dsi_get_dsi_data(dsidev);
 	struct dsi_clock_info *cinfo = &dsi->current_cinfo;
 	enum omap_dss_clk_source dispc_clk_src, dsi_clk_src;
 
 	dispc_clk_src = dss_get_dispc_clk_source();
-	dsi_clk_src = dss_get_dsi_clk_source();
+	dsi_clk_src = dss_get_dsi_clk_source(dsidev->id);
 
 	enable_clocks(1);
 
-	seq_printf(s,	"- DSI PLL -\n");
+	seq_printf(s,	"- DSI%d PLL -\n", dsidev->id + 1);
 
 	seq_printf(s,	"dsi pll source = %s\n",
 			cinfo->use_sys_clk ? "dss_sys_clk" : "pclkfree");
@@ -1698,7 +1697,7 @@ void dsi_dump_clocks(struct seq_file *s)
 			dsi_clk_src == OMAP_DSS_CLK_SRC_FCK ?
 			"off" : "on");
 
-	seq_printf(s,	"- DSI -\n");
+	seq_printf(s,	"- DSI%d -\n", dsidev->id + 1);
 
 	seq_printf(s,	"dsi fclk source = %s (%s)\n",
 			dss_get_generic_clk_source_name(dsi_clk_src),
@@ -1721,10 +1720,21 @@ void dsi_dump_clocks(struct seq_file *s)
 	enable_clocks(0);
 }
 
-#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
-void dsi_dump_irqs(struct seq_file *s)
+void dsi1_dump_clocks(struct seq_file *s)
 {
 	struct platform_device *dsidev = dsi_get_dsi_device_module(0);
+	dsi_dump_clocks(dsidev, s);
+}
+
+void dsi2_dump_clocks(struct seq_file *s)
+{
+	struct platform_device *dsidev = dsi_get_dsi_device_module(1);
+	dsi_dump_clocks(dsidev, s);
+}
+
+#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
+static void dsi_dump_irqs(struct platform_device *dsidev, struct seq_file *s)
+{
 	struct dsi_data *dsi = dsi_get_dsi_data(dsidev);
 	unsigned long flags;
 	struct dsi_irq_stats stats;
@@ -1744,7 +1754,7 @@ void dsi_dump_irqs(struct seq_file *s)
 #define PIS(x) \
 	seq_printf(s, "%-20s %10d\n", #x, stats.dsi_irqs[ffs(DSI_IRQ_##x)-1]);
 
-	seq_printf(s, "-- DSI interrupts --\n");
+	seq_printf(s, "-- DSI%d interrupts --\n", dsidev->id + 1);
 	PIS(VC0);
 	PIS(VC1);
 	PIS(VC2);
@@ -1810,12 +1820,22 @@ void dsi_dump_irqs(struct seq_file *s)
 	PIS(ULPSACTIVENOT_ALL1);
 #undef PIS
 }
-#endif
 
-void dsi_dump_regs(struct seq_file *s)
+void dsi1_dump_irqs(struct seq_file *s)
 {
 	struct platform_device *dsidev = dsi_get_dsi_device_module(0);
+	dsi_dump_irqs(dsidev, s);
+}
+
+void dsi2_dump_irqs(struct seq_file *s)
+{
+	struct platform_device *dsidev = dsi_get_dsi_device_module(1);
+	dsi_dump_irqs(dsidev, s);
+}
+#endif
 
+static void dsi_dump_regs(struct platform_device *dsidev, struct seq_file *s)
+{
 #define DUMPREG(r) seq_printf(s, "%-35s %08x\n", #r, dsi_read_reg(dsidev, r))
 
 	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
@@ -1896,6 +1916,18 @@ void dsi_dump_regs(struct seq_file *s)
 #undef DUMPREG
 }
 
+void dsi1_dump_regs(struct seq_file *s)
+{
+	struct platform_device *dsidev = dsi_get_dsi_device_module(0);
+	dsi_dump_regs(dsidev, s);
+}
+
+void dsi2_dump_regs(struct seq_file *s)
+{
+	struct platform_device *dsidev = dsi_get_dsi_device_module(1);
+	dsi_dump_regs(dsidev, s);
+}
+
 enum dsi_cio_power_state {
 	DSI_COMPLEXIO_POWER_OFF		= 0x0,
 	DSI_COMPLEXIO_POWER_ON		= 0x1,
@@ -3833,9 +3865,13 @@ EXPORT_SYMBOL(omap_dsi_update);
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
@@ -3868,8 +3904,13 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 
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
@@ -3940,7 +3981,7 @@ static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
 		goto err1;
 
 	dss_select_dispc_clk_source(dssdev->clocks.dispc.dispc_fclk_src);
-	dss_select_dsi_clk_source(dssdev->clocks.dsi.dsi_fclk_src);
+	dss_select_dsi_clk_source(dsidev->id, dssdev->clocks.dsi.dsi_fclk_src);
 	dss_select_lcd_clk_source(dssdev->manager->id,
 			dssdev->clocks.dispc.channel.lcd_clk_src);
 
@@ -3979,7 +4020,7 @@ err3:
 	dsi_cio_uninit(dsidev);
 err2:
 	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
-	dss_select_dsi_clk_source(OMAP_DSS_CLK_SRC_FCK);
+	dss_select_dsi_clk_source(dsidev->id, OMAP_DSS_CLK_SRC_FCK);
 err1:
 	dsi_pll_uninit(dsidev, true);
 err0:
@@ -4003,7 +4044,7 @@ static void dsi_display_uninit_dsi(struct omap_dss_device *dssdev,
 	dsi_vc_enable(dsidev, 3, 0);
 
 	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
-	dss_select_dsi_clk_source(OMAP_DSS_CLK_SRC_FCK);
+	dss_select_dsi_clk_source(dsidev->id, OMAP_DSS_CLK_SRC_FCK);
 	dsi_cio_uninit(dsidev);
 	dsi_pll_uninit(dsidev, disconnect_lanes);
 }
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 30f4c02..be4eb69 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -75,7 +75,7 @@ static struct {
 	struct dss_clock_info cache_dss_cinfo;
 	struct dispc_clock_info cache_dispc_cinfo;
 
-	enum omap_dss_clk_source dsi_clk_source;
+	enum omap_dss_clk_source dsi_clk_source[MAX_NUM_DSI];
 	enum omap_dss_clk_source dispc_clk_source;
 	enum omap_dss_clk_source lcd_clk_source[MAX_DSS_LCD_MANAGERS];
 
@@ -315,6 +315,11 @@ void dss_select_dispc_clk_source(enum omap_dss_clk_source clk_src)
 		dsidev = dsi_get_dsi_device_module(0);
 		dsi_wait_pll_hsdiv_dispc_active(dsidev);
 		break;
+	case OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC:
+		b = 2;
+		dsidev = dsi_get_dsi_device_module(1);
+		dsi_wait_pll_hsdiv_dispc_active(dsidev);
+		break;
 	default:
 		BUG();
 	}
@@ -326,7 +331,8 @@ void dss_select_dispc_clk_source(enum omap_dss_clk_source clk_src)
 	dss.dispc_clk_source = clk_src;
 }
 
-void dss_select_dsi_clk_source(enum omap_dss_clk_source clk_src)
+void dss_select_dsi_clk_source(int dsi_module,
+		enum omap_dss_clk_source clk_src)
 {
 	struct platform_device *dsidev;
 	int b;
@@ -336,17 +342,24 @@ void dss_select_dsi_clk_source(enum omap_dss_clk_source clk_src)
 		b = 0;
 		break;
 	case OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI:
+		BUG_ON(dsi_module != 0);
 		b = 1;
 		dsidev = dsi_get_dsi_device_module(0);
 		dsi_wait_pll_hsdiv_dsi_active(dsidev);
 		break;
+	case OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DSI:
+		BUG_ON(dsi_module != 1);
+		b = 1;
+		dsidev = dsi_get_dsi_device_module(1);
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
@@ -368,6 +381,12 @@ void dss_select_lcd_clk_source(enum omap_channel channel,
 		dsidev = dsi_get_dsi_device_module(0);
 		dsi_wait_pll_hsdiv_dispc_active(dsidev);
 		break;
+	case OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC:
+		BUG_ON(channel != OMAP_DSS_CHANNEL_LCD2);
+		b = 1;
+		dsidev = dsi_get_dsi_device_module(1);
+		dsi_wait_pll_hsdiv_dispc_active(dsidev);
+		break;
 	default:
 		BUG();
 	}
@@ -384,9 +403,9 @@ enum omap_dss_clk_source dss_get_dispc_clk_source(void)
 	return dss.dispc_clk_source;
 }
 
-enum omap_dss_clk_source dss_get_dsi_clk_source(void)
+enum omap_dss_clk_source dss_get_dsi_clk_source(int dsi_module)
 {
-	return dss.dsi_clk_source;
+	return dss.dsi_clk_source[dsi_module];
 }
 
 enum omap_dss_clk_source dss_get_lcd_clk_source(enum omap_channel channel)
@@ -717,7 +736,8 @@ static int dss_init(void)
 
 	dss.dpll4_m4_ck = dpll4_m4_ck;
 
-	dss.dsi_clk_source = OMAP_DSS_CLK_SRC_FCK;
+	dss.dsi_clk_source[0] = OMAP_DSS_CLK_SRC_FCK;
+	dss.dsi_clk_source[1] = OMAP_DSS_CLK_SRC_FCK;
 	dss.dispc_clk_source = OMAP_DSS_CLK_SRC_FCK;
 	dss.lcd_clk_source[0] = OMAP_DSS_CLK_SRC_FCK;
 	dss.lcd_clk_source[1] = OMAP_DSS_CLK_SRC_FCK;
@@ -1066,7 +1086,9 @@ void dss_debug_dump_clocks(struct seq_file *s)
 	dss_dump_clocks(s);
 	dispc_dump_clocks(s);
 #ifdef CONFIG_OMAP2_DSS_DSI
-	dsi_dump_clocks(s);
+	dsi1_dump_clocks(s);
+	if (dss_has_feature(FEAT_DSS_DSI2))
+		dsi2_dump_clocks(s);
 #endif
 }
 #endif
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index bca64f9..216c87a 100644
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
@@ -278,9 +279,13 @@ static inline void sdi_exit(void)
 int dsi_init_platform_driver(void);
 void dsi_uninit_platform_driver(void);
 
-void dsi_dump_clocks(struct seq_file *s);
-void dsi_dump_irqs(struct seq_file *s);
-void dsi_dump_regs(struct seq_file *s);
+void dsi1_dump_clocks(struct seq_file *s);
+void dsi1_dump_irqs(struct seq_file *s);
+void dsi1_dump_regs(struct seq_file *s);
+
+void dsi2_dump_clocks(struct seq_file *s);
+void dsi2_dump_irqs(struct seq_file *s);
+void dsi2_dump_regs(struct seq_file *s);
 
 void dsi_save_context(void);
 void dsi_restore_context(void);
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index f8c9503..2809239 100644
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
@@ -292,7 +294,8 @@ static const struct omap_dss_features omap4_dss_features = {
 		FEAT_GLOBAL_ALPHA | FEAT_PRE_MULT_ALPHA |
 		FEAT_MGR_LCD2 | FEAT_GLOBAL_ALPHA_VID1 |
 		FEAT_CORE_CLK_DIV | FEAT_LCD_CLK_SRC |
-		FEAT_DSI_DCS_CMD_CONFIG_VC | FEAT_DSI_VC_OCP_WIDTH,
+		FEAT_DSI_DCS_CMD_CONFIG_VC | FEAT_DSI_VC_OCP_WIDTH |
+		FEAT_DSS_DSI2,
 
 	.num_mgrs = 3,
 	.num_ovls = 3,
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 857162b..cc74523 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -47,6 +47,7 @@ enum dss_feat_id {
 	FEAT_DSI_DCS_CMD_CONFIG_VC	= 1 << 15,
 	FEAT_DSI_VC_OCP_WIDTH		= 1 << 16,
 	FEAT_DSI_REVERSE_TXCLKESC	= 1 << 17,
+	FEAT_DSS_DSI2			= 1 << 18,
 };
 
 /* DSS register field id */
-- 
1.7.1

