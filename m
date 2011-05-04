From: Archit Taneja <archit@ti.com>
Subject: [PATCH 4/9] OMAP: DSS2: Pass platform_device as an argument in dsi functions
Date: Wed,  4 May 2011 13:08:19 +0530
Message-ID: <1304494704-7285-5-git-send-email-archit@ti.com>
References: <1304494704-7285-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51274 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374Ab1EDHdr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 May 2011 03:33:47 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p447XlFn027891
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 4 May 2011 02:33:47 -0500
In-Reply-To: <1304494704-7285-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The DSI interface is represented as a platform device, using the DSI platform
driver(dsi.c). The current DSI driver design is capable of running only one
instance of a DSI device. On OMAP4, there are 2 very similar DSI modules which
can be represented as instances of "omapdss_dsi" platform device.

Add member "module" in "dssdev.phy.dsi" that tells us which DSI module's lanes
the panel is connected to. Modify dsi.c functions to take the device's
platform_device struct pointer, provide functions dsi_get_dsi_device() and
dsi_get_dsi_device_module() take the panel's omap_dss_device and module number
respectively, and return the platform_device pointer. Currently, the dsi struct
is declared globally and is accessed when dsi data is needed. The new pdev
argument will be used later to provide the platform device's dsi related data.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/plat-omap/include/plat/display.h |    2 +
 drivers/video/omap2/dss/dispc.c           |    8 +-
 drivers/video/omap2/dss/dpi.c             |   30 +-
 drivers/video/omap2/dss/dsi.c             |  934 ++++++++++++++++-------------
 drivers/video/omap2/dss/dss.c             |   12 +-
 drivers/video/omap2/dss/dss.h             |   31 +-
 drivers/video/omap2/dss/dss_features.h    |    1 +
 7 files changed, 573 insertions(+), 445 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index d17a7a8..6305ff6 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -419,6 +419,8 @@ struct omap_dss_device {
 			u8 data2_lane;
 			u8 data2_pol;
 
+			int module;
+
 			bool ext_te;
 			u8 ext_te_gpio;
 		} dsi;
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index d728904..7927660 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2353,6 +2353,7 @@ static void dispc_get_lcd_divisor(enum omap_channel channel, int *lck_div,
 
 unsigned long dispc_fclk_rate(void)
 {
+	struct platform_device *dsidev;
 	unsigned long r = 0;
 
 	switch (dss_get_dispc_clk_source()) {
@@ -2360,7 +2361,8 @@ unsigned long dispc_fclk_rate(void)
 		r = dss_clk_get_rate(DSS_CLK_FCK);
 		break;
 	case OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC:
-		r = dsi_get_pll_hsdiv_dispc_rate();
+		dsidev = dsi_get_dsi_device_module(0);
+		r = dsi_get_pll_hsdiv_dispc_rate(dsidev);
 		break;
 	default:
 		BUG();
@@ -2371,6 +2373,7 @@ unsigned long dispc_fclk_rate(void)
 
 unsigned long dispc_lclk_rate(enum omap_channel channel)
 {
+	struct platform_device *dsidev;
 	int lcd;
 	unsigned long r;
 	u32 l;
@@ -2384,7 +2387,8 @@ unsigned long dispc_lclk_rate(enum omap_channel channel)
 		r = dss_clk_get_rate(DSS_CLK_FCK);
 		break;
 	case OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC:
-		r = dsi_get_pll_hsdiv_dispc_rate();
+		dsidev = dsi_get_dsi_device_module(0);
+		r = dsi_get_pll_hsdiv_dispc_rate(dsidev);
 		break;
 	default:
 		BUG();
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 426177b..97d7985 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -37,8 +37,18 @@
 
 static struct {
 	struct regulator *vdds_dsi_reg;
+	struct platform_device *dsidev;
 } dpi;
 
+static struct platform_device *dpi_get_dsi_device(enum omap_dss_clk_source clk)
+{
+	int dsi_module;
+
+	dsi_module = clk == OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC ? 0 : 1;
+
+	return dsi_get_dsi_device_module(dsi_module);
+}
+
 static bool dpi_use_dsi_pll(struct omap_dss_device *dssdev)
 {
 	if (dssdev->clocks.dispc.dispc_fclk_src ==
@@ -58,12 +68,12 @@ static int dpi_set_dsi_clk(struct omap_dss_device *dssdev, bool is_tft,
 	struct dispc_clock_info dispc_cinfo;
 	int r;
 
-	r = dsi_pll_calc_clock_div_pck(is_tft, pck_req, &dsi_cinfo,
-			&dispc_cinfo);
+	r = dsi_pll_calc_clock_div_pck(dpi.dsidev, is_tft, pck_req,
+			&dsi_cinfo, &dispc_cinfo);
 	if (r)
 		return r;
 
-	r = dsi_pll_set_clock_div(&dsi_cinfo);
+	r = dsi_pll_set_clock_div(dpi.dsidev, &dsi_cinfo);
 	if (r)
 		return r;
 
@@ -189,7 +199,7 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 
 	if (dpi_use_dsi_pll(dssdev)) {
 		dss_clk_enable(DSS_CLK_SYSCK);
-		r = dsi_pll_init(0, 1);
+		r = dsi_pll_init(dpi.dsidev, 0, 1);
 		if (r)
 			goto err3;
 	}
@@ -206,7 +216,7 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 
 err4:
 	if (dpi_use_dsi_pll(dssdev))
-		dsi_pll_uninit(true);
+		dsi_pll_uninit(dpi.dsidev, true);
 err3:
 	if (dpi_use_dsi_pll(dssdev))
 		dss_clk_disable(DSS_CLK_SYSCK);
@@ -227,7 +237,7 @@ void omapdss_dpi_display_disable(struct omap_dss_device *dssdev)
 
 	if (dpi_use_dsi_pll(dssdev)) {
 		dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
-		dsi_pll_uninit(true);
+		dsi_pll_uninit(dpi.dsidev, true);
 		dss_clk_disable(DSS_CLK_SYSCK);
 	}
 
@@ -272,7 +282,7 @@ int dpi_check_timings(struct omap_dss_device *dssdev,
 
 	if (dpi_use_dsi_pll(dssdev)) {
 		struct dsi_clock_info dsi_cinfo;
-		r = dsi_pll_calc_clock_div_pck(is_tft,
+		r = dsi_pll_calc_clock_div_pck(dpi.dsidev, is_tft,
 				timings->pixel_clock * 1000,
 				&dsi_cinfo, &dispc_cinfo);
 
@@ -319,6 +329,12 @@ int dpi_init_display(struct omap_dss_device *dssdev)
 		dpi.vdds_dsi_reg = vdds_dsi;
 	}
 
+	if (dpi_use_dsi_pll(dssdev)) {
+		enum omap_dss_clk_source dispc_fclk_src =
+			dssdev->clocks.dispc.dispc_fclk_src;
+		dpi.dsidev = dpi_get_dsi_device(dispc_fclk_src);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 22dd57c..c0e272b 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -101,11 +101,11 @@ struct dsi_reg { u16 idx; };
 #define DSI_PLL_CONFIGURATION1		DSI_REG(0x300 + 0x000C)
 #define DSI_PLL_CONFIGURATION2		DSI_REG(0x300 + 0x0010)
 
-#define REG_GET(idx, start, end) \
-	FLD_GET(dsi_read_reg(idx), start, end)
+#define REG_GET(dsidev, idx, start, end) \
+	FLD_GET(dsi_read_reg(dsidev, idx), start, end)
 
-#define REG_FLD_MOD(idx, val, start, end) \
-	dsi_write_reg(idx, FLD_MOD(dsi_read_reg(idx), val, start, end))
+#define REG_FLD_MOD(dsidev, idx, val, start, end) \
+	dsi_write_reg(dsidev, idx, FLD_MOD(dsi_read_reg(dsidev, idx), val, start, end))
 
 /* Global interrupts */
 #define DSI_IRQ_VC0		(1 << 0)
@@ -257,8 +257,7 @@ struct dsi_isr_tables {
 	struct dsi_isr_data isr_table_cio[DSI_MAX_NR_ISRS];
 };
 
-static struct
-{
+static struct dsi_data {
 	struct platform_device *pdev;
 	void __iomem	*base;
 	int irq;
@@ -330,17 +329,31 @@ static struct
 	unsigned scp_clk_refcount;
 } dsi;
 
+static struct platform_device *dsi_pdev_map[MAX_NUM_DSI];
+
 #ifdef DEBUG
 static unsigned int dsi_perf;
 module_param_named(dsi_perf, dsi_perf, bool, 0644);
 #endif
 
-static inline void dsi_write_reg(const struct dsi_reg idx, u32 val)
+static inline struct platform_device *dsi_get_dsi_device(struct omap_dss_device *dssdev)
+{
+	return dsi_pdev_map[dssdev->phy.dsi.module];
+}
+
+struct platform_device *dsi_get_dsi_device_module(int module)
+{
+	return dsi_pdev_map[module];
+}
+
+static inline void dsi_write_reg(struct platform_device *dsidev,
+		const struct dsi_reg idx, u32 val)
 {
 	__raw_writel(val, dsi.base + idx.idx);
 }
 
-static inline u32 dsi_read_reg(const struct dsi_reg idx)
+static inline u32 dsi_read_reg(struct platform_device *dsidev,
+		const struct dsi_reg idx)
 {
 	return __raw_readl(dsi.base + idx.idx);
 }
@@ -366,7 +379,7 @@ void dsi_bus_unlock(struct omap_dss_device *dssdev)
 }
 EXPORT_SYMBOL(dsi_bus_unlock);
 
-static bool dsi_bus_is_locked(void)
+static bool dsi_bus_is_locked(struct platform_device *dsidev)
 {
 	return dsi.bus_lock.count == 0;
 }
@@ -376,12 +389,12 @@ static void dsi_completion_handler(void *data, u32 mask)
 	complete((struct completion *)data);
 }
 
-static inline int wait_for_bit_change(const struct dsi_reg idx, int bitnum,
-		int value)
+static inline int wait_for_bit_change(struct platform_device *dsidev,
+		const struct dsi_reg idx, int bitnum, int value)
 {
 	int t = 100000;
 
-	while (REG_GET(idx, bitnum, bitnum) != value) {
+	while (REG_GET(dsidev, idx, bitnum, bitnum) != value) {
 		if (--t == 0)
 			return !value;
 	}
@@ -390,17 +403,17 @@ static inline int wait_for_bit_change(const struct dsi_reg idx, int bitnum,
 }
 
 #ifdef DEBUG
-static void dsi_perf_mark_setup(void)
+static void dsi_perf_mark_setup(struct platform_device *dsidev)
 {
 	dsi.perf_setup_time = ktime_get();
 }
 
-static void dsi_perf_mark_start(void)
+static void dsi_perf_mark_start(struct platform_device *dsidev)
 {
 	dsi.perf_start_time = ktime_get();
 }
 
-static void dsi_perf_show(const char *name)
+static void dsi_perf_show(struct platform_device *dsidev, const char *name)
 {
 	ktime_t t, setup_time, trans_time;
 	u32 total_bytes;
@@ -438,9 +451,9 @@ static void dsi_perf_show(const char *name)
 			total_bytes * 1000 / total_us);
 }
 #else
-#define dsi_perf_mark_setup()
-#define dsi_perf_mark_start()
-#define dsi_perf_show(x)
+#define dsi_perf_mark_setup(x)
+#define dsi_perf_mark_start(x)
+#define dsi_perf_show(x, y)
 #endif
 
 static void print_irq_status(u32 status)
@@ -546,7 +559,8 @@ static void print_irq_status_cio(u32 status)
 }
 
 #ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
-static void dsi_collect_irq_stats(u32 irqstatus, u32 *vcstatus, u32 ciostatus)
+static void dsi_collect_irq_stats(struct platform_device *dsidev, u32 irqstatus,
+		u32 *vcstatus, u32 ciostatus)
 {
 	int i;
 
@@ -563,12 +577,13 @@ static void dsi_collect_irq_stats(u32 irqstatus, u32 *vcstatus, u32 ciostatus)
 	spin_unlock(&dsi.irq_stats_lock);
 }
 #else
-#define dsi_collect_irq_stats(irqstatus, vcstatus, ciostatus)
+#define dsi_collect_irq_stats(dsidev, irqstatus, vcstatus, ciostatus)
 #endif
 
 static int debug_irq;
 
-static void dsi_handle_irq_errors(u32 irqstatus, u32 *vcstatus, u32 ciostatus)
+static void dsi_handle_irq_errors(struct platform_device *dsidev, u32 irqstatus,
+		u32 *vcstatus, u32 ciostatus)
 {
 	int i;
 
@@ -638,12 +653,15 @@ static void dsi_handle_isrs(struct dsi_isr_tables *isr_tables,
 
 static irqreturn_t omap_dsi_irq_handler(int irq, void *arg)
 {
+	struct platform_device *dsidev;
 	u32 irqstatus, vcstatus[4], ciostatus;
 	int i;
 
+	dsidev = (struct platform_device *) arg;
+
 	spin_lock(&dsi.irq_lock);
 
-	irqstatus = dsi_read_reg(DSI_IRQSTATUS);
+	irqstatus = dsi_read_reg(dsidev, DSI_IRQSTATUS);
 
 	/* IRQ is not for us */
 	if (!irqstatus) {
@@ -651,9 +669,9 @@ static irqreturn_t omap_dsi_irq_handler(int irq, void *arg)
 		return IRQ_NONE;
 	}
 
-	dsi_write_reg(DSI_IRQSTATUS, irqstatus & ~DSI_IRQ_CHANNEL_MASK);
+	dsi_write_reg(dsidev, DSI_IRQSTATUS, irqstatus & ~DSI_IRQ_CHANNEL_MASK);
 	/* flush posted write */
-	dsi_read_reg(DSI_IRQSTATUS);
+	dsi_read_reg(dsidev, DSI_IRQSTATUS);
 
 	for (i = 0; i < 4; ++i) {
 		if ((irqstatus & (1 << i)) == 0) {
@@ -661,19 +679,19 @@ static irqreturn_t omap_dsi_irq_handler(int irq, void *arg)
 			continue;
 		}
 
-		vcstatus[i] = dsi_read_reg(DSI_VC_IRQSTATUS(i));
+		vcstatus[i] = dsi_read_reg(dsidev, DSI_VC_IRQSTATUS(i));
 
-		dsi_write_reg(DSI_VC_IRQSTATUS(i), vcstatus[i]);
+		dsi_write_reg(dsidev, DSI_VC_IRQSTATUS(i), vcstatus[i]);
 		/* flush posted write */
-		dsi_read_reg(DSI_VC_IRQSTATUS(i));
+		dsi_read_reg(dsidev, DSI_VC_IRQSTATUS(i));
 	}
 
 	if (irqstatus & DSI_IRQ_COMPLEXIO_ERR) {
-		ciostatus = dsi_read_reg(DSI_COMPLEXIO_IRQ_STATUS);
+		ciostatus = dsi_read_reg(dsidev, DSI_COMPLEXIO_IRQ_STATUS);
 
-		dsi_write_reg(DSI_COMPLEXIO_IRQ_STATUS, ciostatus);
+		dsi_write_reg(dsidev, DSI_COMPLEXIO_IRQ_STATUS, ciostatus);
 		/* flush posted write */
-		dsi_read_reg(DSI_COMPLEXIO_IRQ_STATUS);
+		dsi_read_reg(dsidev, DSI_COMPLEXIO_IRQ_STATUS);
 	} else {
 		ciostatus = 0;
 	}
@@ -691,15 +709,16 @@ static irqreturn_t omap_dsi_irq_handler(int irq, void *arg)
 
 	dsi_handle_isrs(&dsi.isr_tables_copy, irqstatus, vcstatus, ciostatus);
 
-	dsi_handle_irq_errors(irqstatus, vcstatus, ciostatus);
+	dsi_handle_irq_errors(dsidev, irqstatus, vcstatus, ciostatus);
 
-	dsi_collect_irq_stats(irqstatus, vcstatus, ciostatus);
+	dsi_collect_irq_stats(dsidev, irqstatus, vcstatus, ciostatus);
 
 	return IRQ_HANDLED;
 }
 
 /* dsi.irq_lock has to be locked by the caller */
-static void _omap_dsi_configure_irqs(struct dsi_isr_data *isr_array,
+static void _omap_dsi_configure_irqs(struct platform_device *dsidev,
+		struct dsi_isr_data *isr_array,
 		unsigned isr_array_size, u32 default_mask,
 		const struct dsi_reg enable_reg,
 		const struct dsi_reg status_reg)
@@ -720,47 +739,47 @@ static void _omap_dsi_configure_irqs(struct dsi_isr_data *isr_array,
 		mask |= isr_data->mask;
 	}
 
-	old_mask = dsi_read_reg(enable_reg);
+	old_mask = dsi_read_reg(dsidev, enable_reg);
 	/* clear the irqstatus for newly enabled irqs */
-	dsi_write_reg(status_reg, (mask ^ old_mask) & mask);
-	dsi_write_reg(enable_reg, mask);
+	dsi_write_reg(dsidev, status_reg, (mask ^ old_mask) & mask);
+	dsi_write_reg(dsidev, enable_reg, mask);
 
 	/* flush posted writes */
-	dsi_read_reg(enable_reg);
-	dsi_read_reg(status_reg);
+	dsi_read_reg(dsidev, enable_reg);
+	dsi_read_reg(dsidev, status_reg);
 }
 
 /* dsi.irq_lock has to be locked by the caller */
-static void _omap_dsi_set_irqs(void)
+static void _omap_dsi_set_irqs(struct platform_device *dsidev)
 {
 	u32 mask = DSI_IRQ_ERROR_MASK;
 #ifdef DSI_CATCH_MISSING_TE
 	mask |= DSI_IRQ_TE_TRIGGER;
 #endif
-	_omap_dsi_configure_irqs(dsi.isr_tables.isr_table,
+	_omap_dsi_configure_irqs(dsidev, dsi.isr_tables.isr_table,
 			ARRAY_SIZE(dsi.isr_tables.isr_table), mask,
 			DSI_IRQENABLE, DSI_IRQSTATUS);
 }
 
 /* dsi.irq_lock has to be locked by the caller */
-static void _omap_dsi_set_irqs_vc(int vc)
+static void _omap_dsi_set_irqs_vc(struct platform_device *dsidev, int vc)
 {
-	_omap_dsi_configure_irqs(dsi.isr_tables.isr_table_vc[vc],
+	_omap_dsi_configure_irqs(dsidev, dsi.isr_tables.isr_table_vc[vc],
 			ARRAY_SIZE(dsi.isr_tables.isr_table_vc[vc]),
 			DSI_VC_IRQ_ERROR_MASK,
 			DSI_VC_IRQENABLE(vc), DSI_VC_IRQSTATUS(vc));
 }
 
 /* dsi.irq_lock has to be locked by the caller */
-static void _omap_dsi_set_irqs_cio(void)
+static void _omap_dsi_set_irqs_cio(struct platform_device *dsidev)
 {
-	_omap_dsi_configure_irqs(dsi.isr_tables.isr_table_cio,
+	_omap_dsi_configure_irqs(dsidev, dsi.isr_tables.isr_table_cio,
 			ARRAY_SIZE(dsi.isr_tables.isr_table_cio),
 			DSI_CIO_IRQ_ERROR_MASK,
 			DSI_COMPLEXIO_IRQ_ENABLE, DSI_COMPLEXIO_IRQ_STATUS);
 }
 
-static void _dsi_initialize_irq(void)
+static void _dsi_initialize_irq(struct platform_device *dsidev)
 {
 	unsigned long flags;
 	int vc;
@@ -769,10 +788,10 @@ static void _dsi_initialize_irq(void)
 
 	memset(&dsi.isr_tables, 0, sizeof(dsi.isr_tables));
 
-	_omap_dsi_set_irqs();
+	_omap_dsi_set_irqs(dsidev);
 	for (vc = 0; vc < 4; ++vc)
-		_omap_dsi_set_irqs_vc(vc);
-	_omap_dsi_set_irqs_cio();
+		_omap_dsi_set_irqs_vc(dsidev, vc);
+	_omap_dsi_set_irqs_cio(dsidev);
 
 	spin_unlock_irqrestore(&dsi.irq_lock, flags);
 }
@@ -833,7 +852,8 @@ static int _dsi_unregister_isr(omap_dsi_isr_t isr, void *arg, u32 mask,
 	return -EINVAL;
 }
 
-static int dsi_register_isr(omap_dsi_isr_t isr, void *arg, u32 mask)
+static int dsi_register_isr(struct platform_device *dsidev, omap_dsi_isr_t isr,
+		void *arg, u32 mask)
 {
 	unsigned long flags;
 	int r;
@@ -844,14 +864,15 @@ static int dsi_register_isr(omap_dsi_isr_t isr, void *arg, u32 mask)
 			ARRAY_SIZE(dsi.isr_tables.isr_table));
 
 	if (r == 0)
-		_omap_dsi_set_irqs();
+		_omap_dsi_set_irqs(dsidev);
 
 	spin_unlock_irqrestore(&dsi.irq_lock, flags);
 
 	return r;
 }
 
-static int dsi_unregister_isr(omap_dsi_isr_t isr, void *arg, u32 mask)
+static int dsi_unregister_isr(struct platform_device *dsidev,
+		omap_dsi_isr_t isr, void *arg, u32 mask)
 {
 	unsigned long flags;
 	int r;
@@ -862,15 +883,15 @@ static int dsi_unregister_isr(omap_dsi_isr_t isr, void *arg, u32 mask)
 			ARRAY_SIZE(dsi.isr_tables.isr_table));
 
 	if (r == 0)
-		_omap_dsi_set_irqs();
+		_omap_dsi_set_irqs(dsidev);
 
 	spin_unlock_irqrestore(&dsi.irq_lock, flags);
 
 	return r;
 }
 
-static int dsi_register_isr_vc(int channel, omap_dsi_isr_t isr, void *arg,
-		u32 mask)
+static int dsi_register_isr_vc(struct platform_device *dsidev, int channel,
+		omap_dsi_isr_t isr, void *arg, u32 mask)
 {
 	unsigned long flags;
 	int r;
@@ -882,15 +903,15 @@ static int dsi_register_isr_vc(int channel, omap_dsi_isr_t isr, void *arg,
 			ARRAY_SIZE(dsi.isr_tables.isr_table_vc[channel]));
 
 	if (r == 0)
-		_omap_dsi_set_irqs_vc(channel);
+		_omap_dsi_set_irqs_vc(dsidev, channel);
 
 	spin_unlock_irqrestore(&dsi.irq_lock, flags);
 
 	return r;
 }
 
-static int dsi_unregister_isr_vc(int channel, omap_dsi_isr_t isr, void *arg,
-		u32 mask)
+static int dsi_unregister_isr_vc(struct platform_device *dsidev, int channel,
+		omap_dsi_isr_t isr, void *arg, u32 mask)
 {
 	unsigned long flags;
 	int r;
@@ -902,14 +923,15 @@ static int dsi_unregister_isr_vc(int channel, omap_dsi_isr_t isr, void *arg,
 			ARRAY_SIZE(dsi.isr_tables.isr_table_vc[channel]));
 
 	if (r == 0)
-		_omap_dsi_set_irqs_vc(channel);
+		_omap_dsi_set_irqs_vc(dsidev, channel);
 
 	spin_unlock_irqrestore(&dsi.irq_lock, flags);
 
 	return r;
 }
 
-static int dsi_register_isr_cio(omap_dsi_isr_t isr, void *arg, u32 mask)
+static int dsi_register_isr_cio(struct platform_device *dsidev,
+		omap_dsi_isr_t isr, void *arg, u32 mask)
 {
 	unsigned long flags;
 	int r;
@@ -920,14 +942,15 @@ static int dsi_register_isr_cio(omap_dsi_isr_t isr, void *arg, u32 mask)
 			ARRAY_SIZE(dsi.isr_tables.isr_table_cio));
 
 	if (r == 0)
-		_omap_dsi_set_irqs_cio();
+		_omap_dsi_set_irqs_cio(dsidev);
 
 	spin_unlock_irqrestore(&dsi.irq_lock, flags);
 
 	return r;
 }
 
-static int dsi_unregister_isr_cio(omap_dsi_isr_t isr, void *arg, u32 mask)
+static int dsi_unregister_isr_cio(struct platform_device *dsidev,
+		omap_dsi_isr_t isr, void *arg, u32 mask)
 {
 	unsigned long flags;
 	int r;
@@ -938,14 +961,14 @@ static int dsi_unregister_isr_cio(omap_dsi_isr_t isr, void *arg, u32 mask)
 			ARRAY_SIZE(dsi.isr_tables.isr_table_cio));
 
 	if (r == 0)
-		_omap_dsi_set_irqs_cio();
+		_omap_dsi_set_irqs_cio(dsidev);
 
 	spin_unlock_irqrestore(&dsi.irq_lock, flags);
 
 	return r;
 }
 
-static u32 dsi_get_errors(void)
+static u32 dsi_get_errors(struct platform_device *dsidev)
 {
 	unsigned long flags;
 	u32 e;
@@ -966,7 +989,8 @@ static inline void enable_clocks(bool enable)
 }
 
 /* source clock for DSI PLL. this could also be PCLKFREE */
-static inline void dsi_enable_pll_clock(bool enable)
+static inline void dsi_enable_pll_clock(struct platform_device *dsidev,
+		bool enable)
 {
 	if (enable)
 		dss_clk_enable(DSS_CLK_SYSCK);
@@ -974,13 +998,13 @@ static inline void dsi_enable_pll_clock(bool enable)
 		dss_clk_disable(DSS_CLK_SYSCK);
 
 	if (enable && dsi.pll_locked) {
-		if (wait_for_bit_change(DSI_PLL_STATUS, 1, 1) != 1)
+		if (wait_for_bit_change(dsidev, DSI_PLL_STATUS, 1, 1) != 1)
 			DSSERR("cannot lock PLL when enabling clocks\n");
 	}
 }
 
 #ifdef DEBUG
-static void _dsi_print_reset_status(void)
+static void _dsi_print_reset_status(struct platform_device *dsidev)
 {
 	u32 l;
 	int b0, b1, b2;
@@ -991,14 +1015,14 @@ static void _dsi_print_reset_status(void)
 	/* A dummy read using the SCP interface to any DSIPHY register is
 	 * required after DSIPHY reset to complete the reset of the DSI complex
 	 * I/O. */
-	l = dsi_read_reg(DSI_DSIPHY_CFG5);
+	l = dsi_read_reg(dsidev, DSI_DSIPHY_CFG5);
 
 	printk(KERN_DEBUG "DSI resets: ");
 
-	l = dsi_read_reg(DSI_PLL_STATUS);
+	l = dsi_read_reg(dsidev, DSI_PLL_STATUS);
 	printk("PLL (%d) ", FLD_GET(l, 0, 0));
 
-	l = dsi_read_reg(DSI_COMPLEXIO_CFG1);
+	l = dsi_read_reg(dsidev, DSI_COMPLEXIO_CFG1);
 	printk("CIO (%d) ", FLD_GET(l, 29, 29));
 
 	if (dss_has_feature(FEAT_DSI_REVERSE_TXCLKESC)) {
@@ -1011,7 +1035,7 @@ static void _dsi_print_reset_status(void)
 		b2 = 26;
 	}
 
-	l = dsi_read_reg(DSI_DSIPHY_CFG5);
+	l = dsi_read_reg(dsidev, DSI_DSIPHY_CFG5);
 	printk("PHY (%x%x%x, %d, %d, %d)\n",
 			FLD_GET(l, b0, b0),
 			FLD_GET(l, b1, b1),
@@ -1021,17 +1045,17 @@ static void _dsi_print_reset_status(void)
 			FLD_GET(l, 31, 31));
 }
 #else
-#define _dsi_print_reset_status()
+#define _dsi_print_reset_status(x)
 #endif
 
-static inline int dsi_if_enable(bool enable)
+static inline int dsi_if_enable(struct platform_device *dsidev, bool enable)
 {
 	DSSDBG("dsi_if_enable(%d)\n", enable);
 
 	enable = enable ? 1 : 0;
-	REG_FLD_MOD(DSI_CTRL, enable, 0, 0); /* IF_EN */
+	REG_FLD_MOD(dsidev, DSI_CTRL, enable, 0, 0); /* IF_EN */
 
-	if (wait_for_bit_change(DSI_CTRL, 0, enable) != enable) {
+	if (wait_for_bit_change(dsidev, DSI_CTRL, 0, enable) != enable) {
 			DSSERR("Failed to set dsi_if_enable to %d\n", enable);
 			return -EIO;
 	}
@@ -1039,22 +1063,22 @@ static inline int dsi_if_enable(bool enable)
 	return 0;
 }
 
-unsigned long dsi_get_pll_hsdiv_dispc_rate(void)
+unsigned long dsi_get_pll_hsdiv_dispc_rate(struct platform_device *dsidev)
 {
 	return dsi.current_cinfo.dsi_pll_hsdiv_dispc_clk;
 }
 
-static unsigned long dsi_get_pll_hsdiv_dsi_rate(void)
+static unsigned long dsi_get_pll_hsdiv_dsi_rate(struct platform_device *dsidev)
 {
 	return dsi.current_cinfo.dsi_pll_hsdiv_dsi_clk;
 }
 
-static unsigned long dsi_get_txbyteclkhs(void)
+static unsigned long dsi_get_txbyteclkhs(struct platform_device *dsidev)
 {
 	return dsi.current_cinfo.clkin4ddr / 16;
 }
 
-static unsigned long dsi_fclk_rate(void)
+static unsigned long dsi_fclk_rate(struct platform_device *dsidev)
 {
 	unsigned long r;
 
@@ -1063,7 +1087,7 @@ static unsigned long dsi_fclk_rate(void)
 		r = dss_clk_get_rate(DSS_CLK_FCK);
 	} else {
 		/* DSI FCLK source is dsi_pll_hsdiv_dsi_clk */
-		r = dsi_get_pll_hsdiv_dsi_rate();
+		r = dsi_get_pll_hsdiv_dsi_rate(dsidev);
 	}
 
 	return r;
@@ -1071,6 +1095,7 @@ static unsigned long dsi_fclk_rate(void)
 
 static int dsi_set_lp_clk_divisor(struct omap_dss_device *dssdev)
 {
+	struct platform_device *dsidev = dsi_get_dsi_device(dssdev);
 	unsigned long dsi_fclk;
 	unsigned lp_clk_div;
 	unsigned long lp_clk;
@@ -1080,7 +1105,7 @@ static int dsi_set_lp_clk_divisor(struct omap_dss_device *dssdev)
 	if (lp_clk_div == 0 || lp_clk_div > dsi.lpdiv_max)
 		return -EINVAL;
 
-	dsi_fclk = dsi_fclk_rate();
+	dsi_fclk = dsi_fclk_rate(dsidev);
 
 	lp_clk = dsi_fclk / 2 / lp_clk_div;
 
@@ -1088,25 +1113,26 @@ static int dsi_set_lp_clk_divisor(struct omap_dss_device *dssdev)
 	dsi.current_cinfo.lp_clk = lp_clk;
 	dsi.current_cinfo.lp_clk_div = lp_clk_div;
 
-	REG_FLD_MOD(DSI_CLK_CTRL, lp_clk_div, 12, 0);   /* LP_CLK_DIVISOR */
+	/* LP_CLK_DIVISOR */
+	REG_FLD_MOD(dsidev, DSI_CLK_CTRL, lp_clk_div, 12, 0);
 
-	REG_FLD_MOD(DSI_CLK_CTRL, dsi_fclk > 30000000 ? 1 : 0,
-			21, 21);		/* LP_RX_SYNCHRO_ENABLE */
+	/* LP_RX_SYNCHRO_ENABLE */
+	REG_FLD_MOD(dsidev, DSI_CLK_CTRL, dsi_fclk > 30000000 ? 1 : 0, 21, 21);
 
 	return 0;
 }
 
-static void dsi_enable_scp_clk(void)
+static void dsi_enable_scp_clk(struct platform_device *dsidev)
 {
 	if (dsi.scp_clk_refcount++ == 0)
-		REG_FLD_MOD(DSI_CLK_CTRL, 1, 14, 14); /* CIO_CLK_ICG */
+		REG_FLD_MOD(dsidev, DSI_CLK_CTRL, 1, 14, 14); /* CIO_CLK_ICG */
 }
 
-static void dsi_disable_scp_clk(void)
+static void dsi_disable_scp_clk(struct platform_device *dsidev)
 {
 	WARN_ON(dsi.scp_clk_refcount == 0);
 	if (--dsi.scp_clk_refcount == 0)
-		REG_FLD_MOD(DSI_CLK_CTRL, 0, 14, 14); /* CIO_CLK_ICG */
+		REG_FLD_MOD(dsidev, DSI_CLK_CTRL, 0, 14, 14); /* CIO_CLK_ICG */
 }
 
 enum dsi_pll_power_state {
@@ -1116,7 +1142,8 @@ enum dsi_pll_power_state {
 	DSI_PLL_POWER_ON_DIV	= 0x3,
 };
 
-static int dsi_pll_power(enum dsi_pll_power_state state)
+static int dsi_pll_power(struct platform_device *dsidev,
+		enum dsi_pll_power_state state)
 {
 	int t = 0;
 
@@ -1125,10 +1152,11 @@ static int dsi_pll_power(enum dsi_pll_power_state state)
 			state == DSI_PLL_POWER_ON_DIV)
 		state = DSI_PLL_POWER_ON_ALL;
 
-	REG_FLD_MOD(DSI_CLK_CTRL, state, 31, 30);	/* PLL_PWR_CMD */
+	/* PLL_PWR_CMD */
+	REG_FLD_MOD(dsidev, DSI_CLK_CTRL, state, 31, 30);
 
 	/* PLL_PWR_STATUS */
-	while (FLD_GET(dsi_read_reg(DSI_CLK_CTRL), 29, 28) != state) {
+	while (FLD_GET(dsi_read_reg(dsidev, DSI_CLK_CTRL), 29, 28) != state) {
 		if (++t > 1000) {
 			DSSERR("Failed to set DSI PLL power mode to %d\n",
 					state);
@@ -1195,8 +1223,8 @@ static int dsi_calc_clock_rates(struct omap_dss_device *dssdev,
 	return 0;
 }
 
-int dsi_pll_calc_clock_div_pck(bool is_tft, unsigned long req_pck,
-		struct dsi_clock_info *dsi_cinfo,
+int dsi_pll_calc_clock_div_pck(struct platform_device *dsidev, bool is_tft,
+		unsigned long req_pck, struct dsi_clock_info *dsi_cinfo,
 		struct dispc_clock_info *dispc_cinfo)
 {
 	struct dsi_clock_info cur, best;
@@ -1332,7 +1360,8 @@ found:
 	return 0;
 }
 
-int dsi_pll_set_clock_div(struct dsi_clock_info *cinfo)
+int dsi_pll_set_clock_div(struct platform_device *dsidev,
+		struct dsi_clock_info *cinfo)
 {
 	int r = 0;
 	u32 l;
@@ -1393,9 +1422,10 @@ int dsi_pll_set_clock_div(struct dsi_clock_info *cinfo)
 	dss_feat_get_reg_field(FEAT_REG_DSIPLL_REGM_DSI, &regm_dsi_start,
 			&regm_dsi_end);
 
-	REG_FLD_MOD(DSI_PLL_CONTROL, 0, 0, 0); /* DSI_PLL_AUTOMODE = manual */
+	/* DSI_PLL_AUTOMODE = manual */
+	REG_FLD_MOD(dsidev, DSI_PLL_CONTROL, 0, 0, 0);
 
-	l = dsi_read_reg(DSI_PLL_CONFIGURATION1);
+	l = dsi_read_reg(dsidev, DSI_PLL_CONFIGURATION1);
 	l = FLD_MOD(l, 1, 0, 0);		/* DSI_PLL_STOPMODE */
 	/* DSI_PLL_REGN */
 	l = FLD_MOD(l, cinfo->regn - 1, regn_start, regn_end);
@@ -1407,7 +1437,7 @@ int dsi_pll_set_clock_div(struct dsi_clock_info *cinfo)
 	/* DSIPROTO_CLOCK_DIV */
 	l = FLD_MOD(l, cinfo->regm_dsi > 0 ? cinfo->regm_dsi - 1 : 0,
 			regm_dsi_start, regm_dsi_end);
-	dsi_write_reg(DSI_PLL_CONFIGURATION1, l);
+	dsi_write_reg(dsidev, DSI_PLL_CONFIGURATION1, l);
 
 	BUG_ON(cinfo->fint < dsi.fint_min || cinfo->fint > dsi.fint_max);
 
@@ -1419,7 +1449,7 @@ int dsi_pll_set_clock_div(struct dsi_clock_info *cinfo)
 			0x7;
 	}
 
-	l = dsi_read_reg(DSI_PLL_CONFIGURATION2);
+	l = dsi_read_reg(dsidev, DSI_PLL_CONFIGURATION2);
 
 	if (dss_has_feature(FEAT_DSI_PLL_FREQSEL))
 		l = FLD_MOD(l, f, 4, 1);	/* DSI_PLL_FREQSEL */
@@ -1430,17 +1460,17 @@ int dsi_pll_set_clock_div(struct dsi_clock_info *cinfo)
 	l = FLD_MOD(l, 1, 13, 13);		/* DSI_PLL_REFEN */
 	l = FLD_MOD(l, 0, 14, 14);		/* DSIPHY_CLKINEN */
 	l = FLD_MOD(l, 1, 20, 20);		/* DSI_HSDIVBYPASS */
-	dsi_write_reg(DSI_PLL_CONFIGURATION2, l);
+	dsi_write_reg(dsidev, DSI_PLL_CONFIGURATION2, l);
 
-	REG_FLD_MOD(DSI_PLL_GO, 1, 0, 0);	/* DSI_PLL_GO */
+	REG_FLD_MOD(dsidev, DSI_PLL_GO, 1, 0, 0);	/* DSI_PLL_GO */
 
-	if (wait_for_bit_change(DSI_PLL_GO, 0, 0) != 0) {
+	if (wait_for_bit_change(dsidev, DSI_PLL_GO, 0, 0) != 0) {
 		DSSERR("dsi pll go bit not going down.\n");
 		r = -EIO;
 		goto err;
 	}
 
-	if (wait_for_bit_change(DSI_PLL_STATUS, 1, 1) != 1) {
+	if (wait_for_bit_change(dsidev, DSI_PLL_STATUS, 1, 1) != 1) {
 		DSSERR("cannot lock PLL\n");
 		r = -EIO;
 		goto err;
@@ -1448,7 +1478,7 @@ int dsi_pll_set_clock_div(struct dsi_clock_info *cinfo)
 
 	dsi.pll_locked = 1;
 
-	l = dsi_read_reg(DSI_PLL_CONFIGURATION2);
+	l = dsi_read_reg(dsidev, DSI_PLL_CONFIGURATION2);
 	l = FLD_MOD(l, 0, 0, 0);	/* DSI_PLL_IDLE */
 	l = FLD_MOD(l, 0, 5, 5);	/* DSI_PLL_PLLLPMODE */
 	l = FLD_MOD(l, 0, 6, 6);	/* DSI_PLL_LOWCURRSTBY */
@@ -1463,14 +1493,15 @@ int dsi_pll_set_clock_div(struct dsi_clock_info *cinfo)
 	l = FLD_MOD(l, 1, 18, 18);	/* DSI_PROTO_CLOCK_EN */
 	l = FLD_MOD(l, 0, 19, 19);	/* DSI_PROTO_CLOCK_PWDN */
 	l = FLD_MOD(l, 0, 20, 20);	/* DSI_HSDIVBYPASS */
-	dsi_write_reg(DSI_PLL_CONFIGURATION2, l);
+	dsi_write_reg(dsidev, DSI_PLL_CONFIGURATION2, l);
 
 	DSSDBG("PLL config done\n");
 err:
 	return r;
 }
 
-int dsi_pll_init(bool enable_hsclk, bool enable_hsdiv)
+int dsi_pll_init(struct platform_device *dsidev, bool enable_hsclk,
+		bool enable_hsdiv)
 {
 	int r = 0;
 	enum dsi_pll_power_state pwstate;
@@ -1491,11 +1522,11 @@ int dsi_pll_init(bool enable_hsclk, bool enable_hsdiv)
 	}
 
 	enable_clocks(1);
-	dsi_enable_pll_clock(1);
+	dsi_enable_pll_clock(dsidev, 1);
 	/*
 	 * Note: SCP CLK is not required on OMAP3, but it is required on OMAP4.
 	 */
-	dsi_enable_scp_clk();
+	dsi_enable_scp_clk(dsidev);
 
 	if (!dsi.vdds_dsi_enabled) {
 		r = regulator_enable(dsi.vdds_dsi_reg);
@@ -1507,7 +1538,7 @@ int dsi_pll_init(bool enable_hsclk, bool enable_hsdiv)
 	/* XXX PLL does not come out of reset without this... */
 	dispc_pck_free_enable(1);
 
-	if (wait_for_bit_change(DSI_PLL_STATUS, 0, 1) != 1) {
+	if (wait_for_bit_change(dsidev, DSI_PLL_STATUS, 0, 1) != 1) {
 		DSSERR("PLL not coming out of reset.\n");
 		r = -ENODEV;
 		dispc_pck_free_enable(0);
@@ -1527,7 +1558,7 @@ int dsi_pll_init(bool enable_hsclk, bool enable_hsdiv)
 	else
 		pwstate = DSI_PLL_POWER_OFF;
 
-	r = dsi_pll_power(pwstate);
+	r = dsi_pll_power(dsidev, pwstate);
 
 	if (r)
 		goto err1;
@@ -1541,31 +1572,32 @@ err1:
 		dsi.vdds_dsi_enabled = false;
 	}
 err0:
-	dsi_disable_scp_clk();
+	dsi_disable_scp_clk(dsidev);
 	enable_clocks(0);
-	dsi_enable_pll_clock(0);
+	dsi_enable_pll_clock(dsidev, 0);
 	return r;
 }
 
-void dsi_pll_uninit(bool disconnect_lanes)
+void dsi_pll_uninit(struct platform_device *dsidev, bool disconnect_lanes)
 {
 	dsi.pll_locked = 0;
-	dsi_pll_power(DSI_PLL_POWER_OFF);
+	dsi_pll_power(dsidev, DSI_PLL_POWER_OFF);
 	if (disconnect_lanes) {
 		WARN_ON(!dsi.vdds_dsi_enabled);
 		regulator_disable(dsi.vdds_dsi_reg);
 		dsi.vdds_dsi_enabled = false;
 	}
 
-	dsi_disable_scp_clk();
+	dsi_disable_scp_clk(dsidev);
 	enable_clocks(0);
-	dsi_enable_pll_clock(0);
+	dsi_enable_pll_clock(dsidev, 0);
 
 	DSSDBG("PLL uninit done\n");
 }
 
 void dsi_dump_clocks(struct seq_file *s)
 {
+	struct platform_device *dsidev = dsi_get_dsi_device_module(0);
 	struct dsi_clock_info *cinfo = &dsi.current_cinfo;
 	enum omap_dss_clk_source dispc_clk_src, dsi_clk_src;
 
@@ -1606,12 +1638,12 @@ void dsi_dump_clocks(struct seq_file *s)
 			dss_get_generic_clk_source_name(dsi_clk_src),
 			dss_feat_get_clk_source_name(dsi_clk_src));
 
-	seq_printf(s,	"DSI_FCLK\t%lu\n", dsi_fclk_rate());
+	seq_printf(s,	"DSI_FCLK\t%lu\n", dsi_fclk_rate(dsidev));
 
 	seq_printf(s,	"DDR_CLK\t\t%lu\n",
 			cinfo->clkin4ddr / 4);
 
-	seq_printf(s,	"TxByteClkHS\t%lu\n", dsi_get_txbyteclkhs());
+	seq_printf(s,	"TxByteClkHS\t%lu\n", dsi_get_txbyteclkhs(dsidev));
 
 	seq_printf(s,	"LP_CLK\t\t%lu\n", cinfo->lp_clk);
 
@@ -1714,10 +1746,12 @@ void dsi_dump_irqs(struct seq_file *s)
 
 void dsi_dump_regs(struct seq_file *s)
 {
-#define DUMPREG(r) seq_printf(s, "%-35s %08x\n", #r, dsi_read_reg(r))
+	struct platform_device *dsidev = dsi_get_dsi_device_module(0);
+
+#define DUMPREG(r) seq_printf(s, "%-35s %08x\n", #r, dsi_read_reg(dsidev, r))
 
 	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
-	dsi_enable_scp_clk();
+	dsi_enable_scp_clk(dsidev);
 
 	DUMPREG(DSI_REVISION);
 	DUMPREG(DSI_SYSCONFIG);
@@ -1789,7 +1823,7 @@ void dsi_dump_regs(struct seq_file *s)
 	DUMPREG(DSI_PLL_CONFIGURATION1);
 	DUMPREG(DSI_PLL_CONFIGURATION2);
 
-	dsi_disable_scp_clk();
+	dsi_disable_scp_clk(dsidev);
 	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
 #undef DUMPREG
 }
@@ -1800,15 +1834,16 @@ enum dsi_cio_power_state {
 	DSI_COMPLEXIO_POWER_ULPS	= 0x2,
 };
 
-static int dsi_cio_power(enum dsi_cio_power_state state)
+static int dsi_cio_power(struct platform_device *dsidev,
+		enum dsi_cio_power_state state)
 {
 	int t = 0;
 
 	/* PWR_CMD */
-	REG_FLD_MOD(DSI_COMPLEXIO_CFG1, state, 28, 27);
+	REG_FLD_MOD(dsidev, DSI_COMPLEXIO_CFG1, state, 28, 27);
 
 	/* PWR_STATUS */
-	while (FLD_GET(dsi_read_reg(DSI_COMPLEXIO_CFG1), 26, 25) != state) {
+	while (FLD_GET(dsi_read_reg(dsidev, DSI_COMPLEXIO_CFG1), 26, 25) != state) {
 		if (++t > 1000) {
 			DSSERR("failed to set complexio power state to "
 					"%d\n", state);
@@ -1822,6 +1857,7 @@ static int dsi_cio_power(enum dsi_cio_power_state state)
 
 static void dsi_set_lane_config(struct omap_dss_device *dssdev)
 {
+	struct platform_device *dsidev = dsi_get_dsi_device(dssdev);
 	u32 r;
 
 	int clk_lane   = dssdev->phy.dsi.clk_lane;
@@ -1831,14 +1867,14 @@ static void dsi_set_lane_config(struct omap_dss_device *dssdev)
 	int data1_pol  = dssdev->phy.dsi.data1_pol;
 	int data2_pol  = dssdev->phy.dsi.data2_pol;
 
-	r = dsi_read_reg(DSI_COMPLEXIO_CFG1);
+	r = dsi_read_reg(dsidev, DSI_COMPLEXIO_CFG1);
 	r = FLD_MOD(r, clk_lane, 2, 0);
 	r = FLD_MOD(r, clk_pol, 3, 3);
 	r = FLD_MOD(r, data1_lane, 6, 4);
 	r = FLD_MOD(r, data1_pol, 7, 7);
 	r = FLD_MOD(r, data2_lane, 10, 8);
 	r = FLD_MOD(r, data2_pol, 11, 11);
-	dsi_write_reg(DSI_COMPLEXIO_CFG1, r);
+	dsi_write_reg(dsidev, DSI_COMPLEXIO_CFG1, r);
 
 	/* The configuration of the DSI complex I/O (number of data lanes,
 	   position, differential order) should not be changed while
@@ -1852,27 +1888,27 @@ static void dsi_set_lane_config(struct omap_dss_device *dssdev)
 	   DSI complex I/O configuration is unknown. */
 
 	/*
-	REG_FLD_MOD(DSI_CTRL, 1, 0, 0);
-	REG_FLD_MOD(DSI_CTRL, 0, 0, 0);
-	REG_FLD_MOD(DSI_CLK_CTRL, 1, 20, 20);
-	REG_FLD_MOD(DSI_CTRL, 1, 0, 0);
+	REG_FLD_MOD(dsidev, DSI_CTRL, 1, 0, 0);
+	REG_FLD_MOD(dsidev, DSI_CTRL, 0, 0, 0);
+	REG_FLD_MOD(dsidev, DSI_CLK_CTRL, 1, 20, 20);
+	REG_FLD_MOD(dsidev, DSI_CTRL, 1, 0, 0);
 	*/
 }
 
-static inline unsigned ns2ddr(unsigned ns)
+static inline unsigned ns2ddr(struct platform_device *dsidev, unsigned ns)
 {
 	/* convert time in ns to ddr ticks, rounding up */
 	unsigned long ddr_clk = dsi.current_cinfo.clkin4ddr / 4;
 	return (ns * (ddr_clk / 1000 / 1000) + 999) / 1000;
 }
 
-static inline unsigned ddr2ns(unsigned ddr)
+static inline unsigned ddr2ns(struct platform_device *dsidev, unsigned ddr)
 {
 	unsigned long ddr_clk = dsi.current_cinfo.clkin4ddr / 4;
 	return ddr * 1000 * 1000 / (ddr_clk / 1000);
 }
 
-static void dsi_cio_timings(void)
+static void dsi_cio_timings(struct platform_device *dsidev)
 {
 	u32 r;
 	u32 ths_prepare, ths_prepare_ths_zero, ths_trail, ths_exit;
@@ -1884,67 +1920,68 @@ static void dsi_cio_timings(void)
 	/* 1 * DDR_CLK = 2 * UI */
 
 	/* min 40ns + 4*UI	max 85ns + 6*UI */
-	ths_prepare = ns2ddr(70) + 2;
+	ths_prepare = ns2ddr(dsidev, 70) + 2;
 
 	/* min 145ns + 10*UI */
-	ths_prepare_ths_zero = ns2ddr(175) + 2;
+	ths_prepare_ths_zero = ns2ddr(dsidev, 175) + 2;
 
 	/* min max(8*UI, 60ns+4*UI) */
-	ths_trail = ns2ddr(60) + 5;
+	ths_trail = ns2ddr(dsidev, 60) + 5;
 
 	/* min 100ns */
-	ths_exit = ns2ddr(145);
+	ths_exit = ns2ddr(dsidev, 145);
 
 	/* tlpx min 50n */
-	tlpx_half = ns2ddr(25);
+	tlpx_half = ns2ddr(dsidev, 25);
 
 	/* min 60ns */
-	tclk_trail = ns2ddr(60) + 2;
+	tclk_trail = ns2ddr(dsidev, 60) + 2;
 
 	/* min 38ns, max 95ns */
-	tclk_prepare = ns2ddr(65);
+	tclk_prepare = ns2ddr(dsidev, 65);
 
 	/* min tclk-prepare + tclk-zero = 300ns */
-	tclk_zero = ns2ddr(260);
+	tclk_zero = ns2ddr(dsidev, 260);
 
 	DSSDBG("ths_prepare %u (%uns), ths_prepare_ths_zero %u (%uns)\n",
-		ths_prepare, ddr2ns(ths_prepare),
-		ths_prepare_ths_zero, ddr2ns(ths_prepare_ths_zero));
+		ths_prepare, ddr2ns(dsidev, ths_prepare),
+		ths_prepare_ths_zero, ddr2ns(dsidev, ths_prepare_ths_zero));
 	DSSDBG("ths_trail %u (%uns), ths_exit %u (%uns)\n",
-			ths_trail, ddr2ns(ths_trail),
-			ths_exit, ddr2ns(ths_exit));
+			ths_trail, ddr2ns(dsidev, ths_trail),
+			ths_exit, ddr2ns(dsidev, ths_exit));
 
 	DSSDBG("tlpx_half %u (%uns), tclk_trail %u (%uns), "
 			"tclk_zero %u (%uns)\n",
-			tlpx_half, ddr2ns(tlpx_half),
-			tclk_trail, ddr2ns(tclk_trail),
-			tclk_zero, ddr2ns(tclk_zero));
+			tlpx_half, ddr2ns(dsidev, tlpx_half),
+			tclk_trail, ddr2ns(dsidev, tclk_trail),
+			tclk_zero, ddr2ns(dsidev, tclk_zero));
 	DSSDBG("tclk_prepare %u (%uns)\n",
-			tclk_prepare, ddr2ns(tclk_prepare));
+			tclk_prepare, ddr2ns(dsidev, tclk_prepare));
 
 	/* program timings */
 
-	r = dsi_read_reg(DSI_DSIPHY_CFG0);
+	r = dsi_read_reg(dsidev, DSI_DSIPHY_CFG0);
 	r = FLD_MOD(r, ths_prepare, 31, 24);
 	r = FLD_MOD(r, ths_prepare_ths_zero, 23, 16);
 	r = FLD_MOD(r, ths_trail, 15, 8);
 	r = FLD_MOD(r, ths_exit, 7, 0);
-	dsi_write_reg(DSI_DSIPHY_CFG0, r);
+	dsi_write_reg(dsidev, DSI_DSIPHY_CFG0, r);
 
-	r = dsi_read_reg(DSI_DSIPHY_CFG1);
+	r = dsi_read_reg(dsidev, DSI_DSIPHY_CFG1);
 	r = FLD_MOD(r, tlpx_half, 22, 16);
 	r = FLD_MOD(r, tclk_trail, 15, 8);
 	r = FLD_MOD(r, tclk_zero, 7, 0);
-	dsi_write_reg(DSI_DSIPHY_CFG1, r);
+	dsi_write_reg(dsidev, DSI_DSIPHY_CFG1, r);
 
-	r = dsi_read_reg(DSI_DSIPHY_CFG2);
+	r = dsi_read_reg(dsidev, DSI_DSIPHY_CFG2);
 	r = FLD_MOD(r, tclk_prepare, 7, 0);
-	dsi_write_reg(DSI_DSIPHY_CFG2, r);
+	dsi_write_reg(dsidev, DSI_DSIPHY_CFG2, r);
 }
 
 static void dsi_cio_enable_lane_override(struct omap_dss_device *dssdev,
 		enum dsi_lane lanes)
 {
+	struct platform_device *dsidev = dsi_get_dsi_device(dssdev);
 	int clk_lane   = dssdev->phy.dsi.clk_lane;
 	int data1_lane = dssdev->phy.dsi.data1_lane;
 	int data2_lane = dssdev->phy.dsi.data2_lane;
@@ -1977,22 +2014,27 @@ static void dsi_cio_enable_lane_override(struct omap_dss_device *dssdev,
 	 */
 
 	/* Set the lane override configuration */
-	REG_FLD_MOD(DSI_DSIPHY_CFG10, l, 22, 17); /* REGLPTXSCPDAT4TO0DXDY */
+
+	/* REGLPTXSCPDAT4TO0DXDY */
+	REG_FLD_MOD(dsidev, DSI_DSIPHY_CFG10, l, 22, 17);
 
 	/* Enable lane override */
-	REG_FLD_MOD(DSI_DSIPHY_CFG10, 1, 27, 27); /* ENLPTXSCPDAT */
+
+	/* ENLPTXSCPDAT */
+	REG_FLD_MOD(dsidev, DSI_DSIPHY_CFG10, 1, 27, 27);
 }
 
-static void dsi_cio_disable_lane_override(void)
+static void dsi_cio_disable_lane_override(struct platform_device *dsidev)
 {
 	/* Disable lane override */
-	REG_FLD_MOD(DSI_DSIPHY_CFG10, 0, 27, 27); /* ENLPTXSCPDAT */
+	REG_FLD_MOD(dsidev, DSI_DSIPHY_CFG10, 0, 27, 27); /* ENLPTXSCPDAT */
 	/* Reset the lane override configuration */
-	REG_FLD_MOD(DSI_DSIPHY_CFG10, 0, 22, 17); /* REGLPTXSCPDAT4TO0DXDY */
+	REG_FLD_MOD(dsidev, DSI_DSIPHY_CFG10, 0, 22, 17); /* REGLPTXSCPDAT4TO0DXDY */
 }
 
 static int dsi_cio_wait_tx_clk_esc_reset(struct omap_dss_device *dssdev)
 {
+	struct platform_device *dsidev = dsi_get_dsi_device(dssdev);
 	int t;
 	int bits[3];
 	bool in_use[3];
@@ -2024,7 +2066,7 @@ static int dsi_cio_wait_tx_clk_esc_reset(struct omap_dss_device *dssdev)
 		int i;
 		int ok;
 
-		l = dsi_read_reg(DSI_DSIPHY_CFG5);
+		l = dsi_read_reg(dsidev, DSI_DSIPHY_CFG5);
 
 		ok = 0;
 		for (i = 0; i < 3; ++i) {
@@ -2052,6 +2094,7 @@ static int dsi_cio_wait_tx_clk_esc_reset(struct omap_dss_device *dssdev)
 
 static int dsi_cio_init(struct omap_dss_device *dssdev)
 {
+	struct platform_device *dsidev = dsi_get_dsi_device(dssdev);
 	int r;
 	u32 l;
 
@@ -2060,14 +2103,14 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 	if (dsi.dsi_mux_pads)
 		dsi.dsi_mux_pads(true);
 
-	dsi_enable_scp_clk();
+	dsi_enable_scp_clk(dsidev);
 
 	/* A dummy read using the SCP interface to any DSIPHY register is
 	 * required after DSIPHY reset to complete the reset of the DSI complex
 	 * I/O. */
-	dsi_read_reg(DSI_DSIPHY_CFG5);
+	dsi_read_reg(dsidev, DSI_DSIPHY_CFG5);
 
-	if (wait_for_bit_change(DSI_DSIPHY_CFG5, 30, 1) != 1) {
+	if (wait_for_bit_change(dsidev, DSI_DSIPHY_CFG5, 30, 1) != 1) {
 		DSSERR("CIO SCP Clock domain not coming out of reset.\n");
 		r = -EIO;
 		goto err_scp_clk_dom;
@@ -2076,12 +2119,12 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 	dsi_set_lane_config(dssdev);
 
 	/* set TX STOP MODE timer to maximum for this operation */
-	l = dsi_read_reg(DSI_TIMING1);
+	l = dsi_read_reg(dsidev, DSI_TIMING1);
 	l = FLD_MOD(l, 1, 15, 15);	/* FORCE_TX_STOP_MODE_IO */
 	l = FLD_MOD(l, 1, 14, 14);	/* STOP_STATE_X16_IO */
 	l = FLD_MOD(l, 1, 13, 13);	/* STOP_STATE_X4_IO */
 	l = FLD_MOD(l, 0x1fff, 12, 0);	/* STOP_STATE_COUNTER_IO */
-	dsi_write_reg(DSI_TIMING1, l);
+	dsi_write_reg(dsidev, DSI_TIMING1, l);
 
 	if (dsi.ulps_enabled) {
 		DSSDBG("manual ulps exit\n");
@@ -2098,19 +2141,19 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 				DSI_CLK_P | DSI_DATA1_P | DSI_DATA2_P);
 	}
 
-	r = dsi_cio_power(DSI_COMPLEXIO_POWER_ON);
+	r = dsi_cio_power(dsidev, DSI_COMPLEXIO_POWER_ON);
 	if (r)
 		goto err_cio_pwr;
 
-	if (wait_for_bit_change(DSI_COMPLEXIO_CFG1, 29, 1) != 1) {
+	if (wait_for_bit_change(dsidev, DSI_COMPLEXIO_CFG1, 29, 1) != 1) {
 		DSSERR("CIO PWR clock domain not coming out of reset.\n");
 		r = -ENODEV;
 		goto err_cio_pwr_dom;
 	}
 
-	dsi_if_enable(true);
-	dsi_if_enable(false);
-	REG_FLD_MOD(DSI_CLK_CTRL, 1, 20, 20); /* LP_CLK_ENABLE */
+	dsi_if_enable(dsidev, true);
+	dsi_if_enable(dsidev, false);
+	REG_FLD_MOD(dsidev, DSI_CLK_CTRL, 1, 20, 20); /* LP_CLK_ENABLE */
 
 	r = dsi_cio_wait_tx_clk_esc_reset(dssdev);
 	if (r)
@@ -2124,13 +2167,13 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 
 		/* Disable the override. The lanes should be set to Mark-11
 		 * state by the HW */
-		dsi_cio_disable_lane_override();
+		dsi_cio_disable_lane_override(dsidev);
 	}
 
 	/* FORCE_TX_STOP_MODE_IO */
-	REG_FLD_MOD(DSI_TIMING1, 0, 15, 15);
+	REG_FLD_MOD(dsidev, DSI_TIMING1, 0, 15, 15);
 
-	dsi_cio_timings();
+	dsi_cio_timings(dsidev);
 
 	dsi.ulps_enabled = false;
 
@@ -2139,32 +2182,32 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 	return 0;
 
 err_tx_clk_esc_rst:
-	REG_FLD_MOD(DSI_CLK_CTRL, 0, 20, 20); /* LP_CLK_ENABLE */
+	REG_FLD_MOD(dsidev, DSI_CLK_CTRL, 0, 20, 20); /* LP_CLK_ENABLE */
 err_cio_pwr_dom:
-	dsi_cio_power(DSI_COMPLEXIO_POWER_OFF);
+	dsi_cio_power(dsidev, DSI_COMPLEXIO_POWER_OFF);
 err_cio_pwr:
 	if (dsi.ulps_enabled)
-		dsi_cio_disable_lane_override();
+		dsi_cio_disable_lane_override(dsidev);
 err_scp_clk_dom:
-	dsi_disable_scp_clk();
+	dsi_disable_scp_clk(dsidev);
 	if (dsi.dsi_mux_pads)
 		dsi.dsi_mux_pads(false);
 	return r;
 }
 
-static void dsi_cio_uninit(void)
+static void dsi_cio_uninit(struct platform_device *dsidev)
 {
-	dsi_cio_power(DSI_COMPLEXIO_POWER_OFF);
-	dsi_disable_scp_clk();
+	dsi_cio_power(dsidev, DSI_COMPLEXIO_POWER_OFF);
+	dsi_disable_scp_clk(dsidev);
 	if (dsi.dsi_mux_pads)
 		dsi.dsi_mux_pads(false);
 }
 
-static int _dsi_wait_reset(void)
+static int _dsi_wait_reset(struct platform_device *dsidev)
 {
 	int t = 0;
 
-	while (REG_GET(DSI_SYSSTATUS, 0, 0) == 0) {
+	while (REG_GET(dsidev, DSI_SYSSTATUS, 0, 0) == 0) {
 		if (++t > 5) {
 			DSSERR("soft reset failed\n");
 			return -ENODEV;
@@ -2175,14 +2218,15 @@ static int _dsi_wait_reset(void)
 	return 0;
 }
 
-static int _dsi_reset(void)
+static int _dsi_reset(struct platform_device *dsidev)
 {
 	/* Soft reset */
-	REG_FLD_MOD(DSI_SYSCONFIG, 1, 1, 1);
-	return _dsi_wait_reset();
+	REG_FLD_MOD(dsidev, DSI_SYSCONFIG, 1, 1, 1);
+	return _dsi_wait_reset(dsidev);
 }
 
-static void dsi_config_tx_fifo(enum fifo_size size1, enum fifo_size size2,
+static void dsi_config_tx_fifo(struct platform_device *dsidev,
+		enum fifo_size size1, enum fifo_size size2,
 		enum fifo_size size3, enum fifo_size size4)
 {
 	u32 r = 0;
@@ -2209,10 +2253,11 @@ static void dsi_config_tx_fifo(enum fifo_size size1, enum fifo_size size2,
 		add += size;
 	}
 
-	dsi_write_reg(DSI_TX_FIFO_VC_SIZE, r);
+	dsi_write_reg(dsidev, DSI_TX_FIFO_VC_SIZE, r);
 }
 
-static void dsi_config_rx_fifo(enum fifo_size size1, enum fifo_size size2,
+static void dsi_config_rx_fifo(struct platform_device *dsidev,
+		enum fifo_size size1, enum fifo_size size2,
 		enum fifo_size size3, enum fifo_size size4)
 {
 	u32 r = 0;
@@ -2239,18 +2284,18 @@ static void dsi_config_rx_fifo(enum fifo_size size1, enum fifo_size size2,
 		add += size;
 	}
 
-	dsi_write_reg(DSI_RX_FIFO_VC_SIZE, r);
+	dsi_write_reg(dsidev, DSI_RX_FIFO_VC_SIZE, r);
 }
 
-static int dsi_force_tx_stop_mode_io(void)
+static int dsi_force_tx_stop_mode_io(struct platform_device *dsidev)
 {
 	u32 r;
 
-	r = dsi_read_reg(DSI_TIMING1);
+	r = dsi_read_reg(dsidev, DSI_TIMING1);
 	r = FLD_MOD(r, 1, 15, 15);	/* FORCE_TX_STOP_MODE_IO */
-	dsi_write_reg(DSI_TIMING1, r);
+	dsi_write_reg(dsidev, DSI_TIMING1, r);
 
-	if (wait_for_bit_change(DSI_TIMING1, 15, 0) != 0) {
+	if (wait_for_bit_change(dsidev, DSI_TIMING1, 15, 0) != 0) {
 		DSSERR("TX_STOP bit not going down\n");
 		return -EIO;
 	}
@@ -2258,21 +2303,22 @@ static int dsi_force_tx_stop_mode_io(void)
 	return 0;
 }
 
-static bool dsi_vc_is_enabled(int channel)
+static bool dsi_vc_is_enabled(struct platform_device *dsidev, int channel)
 {
-	return REG_GET(DSI_VC_CTRL(channel), 0, 0);
+	return REG_GET(dsidev, DSI_VC_CTRL(channel), 0, 0);
 }
 
 static void dsi_packet_sent_handler_vp(void *data, u32 mask)
 {
+	struct platform_device *dsidev = dsi_get_dsi_device_module(0);
 	const int channel = dsi.update_channel;
 	u8 bit = dsi.te_enabled ? 30 : 31;
 
-	if (REG_GET(DSI_VC_TE(channel), bit, bit) == 0)
+	if (REG_GET(dsidev, DSI_VC_TE(channel), bit, bit) == 0)
 		complete((struct completion *)data);
 }
 
-static int dsi_sync_vc_vp(int channel)
+static int dsi_sync_vc_vp(struct platform_device *dsidev, int channel)
 {
 	int r = 0;
 	u8 bit;
@@ -2281,13 +2327,13 @@ static int dsi_sync_vc_vp(int channel)
 
 	bit = dsi.te_enabled ? 30 : 31;
 
-	r = dsi_register_isr_vc(channel, dsi_packet_sent_handler_vp,
+	r = dsi_register_isr_vc(dsidev, channel, dsi_packet_sent_handler_vp,
 		&completion, DSI_VC_IRQ_PACKET_SENT);
 	if (r)
 		goto err0;
 
 	/* Wait for completion only if TE_EN/TE_START is still set */
-	if (REG_GET(DSI_VC_TE(channel), bit, bit)) {
+	if (REG_GET(dsidev, DSI_VC_TE(channel), bit, bit)) {
 		if (wait_for_completion_timeout(&completion,
 				msecs_to_jiffies(10)) == 0) {
 			DSSERR("Failed to complete previous frame transfer\n");
@@ -2296,38 +2342,39 @@ static int dsi_sync_vc_vp(int channel)
 		}
 	}
 
-	dsi_unregister_isr_vc(channel, dsi_packet_sent_handler_vp,
+	dsi_unregister_isr_vc(dsidev, channel, dsi_packet_sent_handler_vp,
 		&completion, DSI_VC_IRQ_PACKET_SENT);
 
 	return 0;
 err1:
-	dsi_unregister_isr_vc(channel, dsi_packet_sent_handler_vp, &completion,
-		DSI_VC_IRQ_PACKET_SENT);
+	dsi_unregister_isr_vc(dsidev, channel, dsi_packet_sent_handler_vp,
+		&completion, DSI_VC_IRQ_PACKET_SENT);
 err0:
 	return r;
 }
 
 static void dsi_packet_sent_handler_l4(void *data, u32 mask)
 {
+	struct platform_device *dsidev = dsi_get_dsi_device_module(0);
 	const int channel = dsi.update_channel;
 
-	if (REG_GET(DSI_VC_CTRL(channel), 5, 5) == 0)
+	if (REG_GET(dsidev, DSI_VC_CTRL(channel), 5, 5) == 0)
 		complete((struct completion *)data);
 }
 
-static int dsi_sync_vc_l4(int channel)
+static int dsi_sync_vc_l4(struct platform_device *dsidev, int channel)
 {
 	int r = 0;
 
 	DECLARE_COMPLETION_ONSTACK(completion);
 
-	r = dsi_register_isr_vc(channel, dsi_packet_sent_handler_l4,
+	r = dsi_register_isr_vc(dsidev, channel, dsi_packet_sent_handler_l4,
 		&completion, DSI_VC_IRQ_PACKET_SENT);
 	if (r)
 		goto err0;
 
 	/* Wait for completion only if TX_FIFO_NOT_EMPTY is still set */
-	if (REG_GET(DSI_VC_CTRL(channel), 5, 5)) {
+	if (REG_GET(dsidev, DSI_VC_CTRL(channel), 5, 5)) {
 		if (wait_for_completion_timeout(&completion,
 				msecs_to_jiffies(10)) == 0) {
 			DSSERR("Failed to complete previous l4 transfer\n");
@@ -2336,46 +2383,47 @@ static int dsi_sync_vc_l4(int channel)
 		}
 	}
 
-	dsi_unregister_isr_vc(channel, dsi_packet_sent_handler_l4,
+	dsi_unregister_isr_vc(dsidev, channel, dsi_packet_sent_handler_l4,
 		&completion, DSI_VC_IRQ_PACKET_SENT);
 
 	return 0;
 err1:
-	dsi_unregister_isr_vc(channel, dsi_packet_sent_handler_l4,
+	dsi_unregister_isr_vc(dsidev, channel, dsi_packet_sent_handler_l4,
 		&completion, DSI_VC_IRQ_PACKET_SENT);
 err0:
 	return r;
 }
 
-static int dsi_sync_vc(int channel)
+static int dsi_sync_vc(struct platform_device *dsidev, int channel)
 {
-	WARN_ON(!dsi_bus_is_locked());
+	WARN_ON(!dsi_bus_is_locked(dsidev));
 
 	WARN_ON(in_interrupt());
 
-	if (!dsi_vc_is_enabled(channel))
+	if (!dsi_vc_is_enabled(dsidev, channel))
 		return 0;
 
 	switch (dsi.vc[channel].mode) {
 	case DSI_VC_MODE_VP:
-		return dsi_sync_vc_vp(channel);
+		return dsi_sync_vc_vp(dsidev, channel);
 	case DSI_VC_MODE_L4:
-		return dsi_sync_vc_l4(channel);
+		return dsi_sync_vc_l4(dsidev, channel);
 	default:
 		BUG();
 	}
 }
 
-static int dsi_vc_enable(int channel, bool enable)
+static int dsi_vc_enable(struct platform_device *dsidev, int channel,
+		bool enable)
 {
 	DSSDBG("dsi_vc_enable channel %d, enable %d\n",
 			channel, enable);
 
 	enable = enable ? 1 : 0;
 
-	REG_FLD_MOD(DSI_VC_CTRL(channel), enable, 0, 0);
+	REG_FLD_MOD(dsidev, DSI_VC_CTRL(channel), enable, 0, 0);
 
-	if (wait_for_bit_change(DSI_VC_CTRL(channel), 0, enable) != enable) {
+	if (wait_for_bit_change(dsidev, DSI_VC_CTRL(channel), 0, enable) != enable) {
 			DSSERR("Failed to set dsi_vc_enable to %d\n", enable);
 			return -EIO;
 	}
@@ -2383,13 +2431,13 @@ static int dsi_vc_enable(int channel, bool enable)
 	return 0;
 }
 
-static void dsi_vc_initial_config(int channel)
+static void dsi_vc_initial_config(struct platform_device *dsidev, int channel)
 {
 	u32 r;
 
 	DSSDBGF("%d", channel);
 
-	r = dsi_read_reg(DSI_VC_CTRL(channel));
+	r = dsi_read_reg(dsidev, DSI_VC_CTRL(channel));
 
 	if (FLD_GET(r, 15, 15)) /* VC_BUSY */
 		DSSERR("VC(%d) busy when trying to configure it!\n",
@@ -2408,63 +2456,64 @@ static void dsi_vc_initial_config(int channel)
 	r = FLD_MOD(r, 4, 29, 27); /* DMA_RX_REQ_NB = no dma */
 	r = FLD_MOD(r, 4, 23, 21); /* DMA_TX_REQ_NB = no dma */
 
-	dsi_write_reg(DSI_VC_CTRL(channel), r);
+	dsi_write_reg(dsidev, DSI_VC_CTRL(channel), r);
 }
 
-static int dsi_vc_config_l4(int channel)
+static int dsi_vc_config_l4(struct platform_device *dsidev, int channel)
 {
 	if (dsi.vc[channel].mode == DSI_VC_MODE_L4)
 		return 0;
 
 	DSSDBGF("%d", channel);
 
-	dsi_sync_vc(channel);
+	dsi_sync_vc(dsidev, channel);
 
-	dsi_vc_enable(channel, 0);
+	dsi_vc_enable(dsidev, channel, 0);
 
 	/* VC_BUSY */
-	if (wait_for_bit_change(DSI_VC_CTRL(channel), 15, 0) != 0) {
+	if (wait_for_bit_change(dsidev, DSI_VC_CTRL(channel), 15, 0) != 0) {
 		DSSERR("vc(%d) busy when trying to config for L4\n", channel);
 		return -EIO;
 	}
 
-	REG_FLD_MOD(DSI_VC_CTRL(channel), 0, 1, 1); /* SOURCE, 0 = L4 */
+	REG_FLD_MOD(dsidev, DSI_VC_CTRL(channel), 0, 1, 1); /* SOURCE, 0 = L4 */
 
 	/* DCS_CMD_ENABLE */
 	if (dss_has_feature(FEAT_DSI_DCS_CMD_CONFIG_VC))
-		REG_FLD_MOD(DSI_VC_CTRL(channel), 0, 30, 30);
+		REG_FLD_MOD(dsidev, DSI_VC_CTRL(channel), 0, 30, 30);
 
-	dsi_vc_enable(channel, 1);
+	dsi_vc_enable(dsidev, channel, 1);
 
 	dsi.vc[channel].mode = DSI_VC_MODE_L4;
 
 	return 0;
 }
 
-static int dsi_vc_config_vp(int channel)
+static int dsi_vc_config_vp(struct platform_device *dsidev, int channel)
 {
 	if (dsi.vc[channel].mode == DSI_VC_MODE_VP)
 		return 0;
 
 	DSSDBGF("%d", channel);
 
-	dsi_sync_vc(channel);
+	dsi_sync_vc(dsidev, channel);
 
-	dsi_vc_enable(channel, 0);
+	dsi_vc_enable(dsidev, channel, 0);
 
 	/* VC_BUSY */
-	if (wait_for_bit_change(DSI_VC_CTRL(channel), 15, 0) != 0) {
+	if (wait_for_bit_change(dsidev, DSI_VC_CTRL(channel), 15, 0) != 0) {
 		DSSERR("vc(%d) busy when trying to config for VP\n", channel);
 		return -EIO;
 	}
 
-	REG_FLD_MOD(DSI_VC_CTRL(channel), 1, 1, 1); /* SOURCE, 1 = video port */
+	/* SOURCE, 1 = video port */
+	REG_FLD_MOD(dsidev, DSI_VC_CTRL(channel), 1, 1, 1);
 
 	/* DCS_CMD_ENABLE */
 	if (dss_has_feature(FEAT_DSI_DCS_CMD_CONFIG_VC))
-		REG_FLD_MOD(DSI_VC_CTRL(channel), 1, 30, 30);
+		REG_FLD_MOD(dsidev, DSI_VC_CTRL(channel), 1, 30, 30);
 
-	dsi_vc_enable(channel, 1);
+	dsi_vc_enable(dsidev, channel, 1);
 
 	dsi.vc[channel].mode = DSI_VC_MODE_VP;
 
@@ -2475,27 +2524,29 @@ static int dsi_vc_config_vp(int channel)
 void omapdss_dsi_vc_enable_hs(struct omap_dss_device *dssdev, int channel,
 		bool enable)
 {
+	struct platform_device *dsidev = dsi_get_dsi_device(dssdev);
+
 	DSSDBG("dsi_vc_enable_hs(%d, %d)\n", channel, enable);
 
-	WARN_ON(!dsi_bus_is_locked());
+	WARN_ON(!dsi_bus_is_locked(dsidev));
 
-	dsi_vc_enable(channel, 0);
-	dsi_if_enable(0);
+	dsi_vc_enable(dsidev, channel, 0);
+	dsi_if_enable(dsidev, 0);
 
-	REG_FLD_MOD(DSI_VC_CTRL(channel), enable, 9, 9);
+	REG_FLD_MOD(dsidev, DSI_VC_CTRL(channel), enable, 9, 9);
 
-	dsi_vc_enable(channel, 1);
-	dsi_if_enable(1);
+	dsi_vc_enable(dsidev, channel, 1);
+	dsi_if_enable(dsidev, 1);
 
-	dsi_force_tx_stop_mode_io();
+	dsi_force_tx_stop_mode_io(dsidev);
 }
 EXPORT_SYMBOL(omapdss_dsi_vc_enable_hs);
 
-static void dsi_vc_flush_long_data(int channel)
+static void dsi_vc_flush_long_data(struct platform_device *dsidev, int channel)
 {
-	while (REG_GET(DSI_VC_CTRL(channel), 20, 20)) {
+	while (REG_GET(dsidev, DSI_VC_CTRL(channel), 20, 20)) {
 		u32 val;
-		val = dsi_read_reg(DSI_VC_SHORT_PACKET_HEADER(channel));
+		val = dsi_read_reg(dsidev, DSI_VC_SHORT_PACKET_HEADER(channel));
 		DSSDBG("\t\tb1 %#02x b2 %#02x b3 %#02x b4 %#02x\n",
 				(val >> 0) & 0xff,
 				(val >> 8) & 0xff,
@@ -2541,13 +2592,14 @@ static void dsi_show_rx_ack_with_err(u16 err)
 		DSSERR("\t\tDSI Protocol Violation\n");
 }
 
-static u16 dsi_vc_flush_receive_data(int channel)
+static u16 dsi_vc_flush_receive_data(struct platform_device *dsidev,
+		int channel)
 {
 	/* RX_FIFO_NOT_EMPTY */
-	while (REG_GET(DSI_VC_CTRL(channel), 20, 20)) {
+	while (REG_GET(dsidev, DSI_VC_CTRL(channel), 20, 20)) {
 		u32 val;
 		u8 dt;
-		val = dsi_read_reg(DSI_VC_SHORT_PACKET_HEADER(channel));
+		val = dsi_read_reg(dsidev, DSI_VC_SHORT_PACKET_HEADER(channel));
 		DSSERR("\trawval %#08x\n", val);
 		dt = FLD_GET(val, 5, 0);
 		if (dt == DSI_DT_RX_ACK_WITH_ERR) {
@@ -2562,7 +2614,7 @@ static u16 dsi_vc_flush_receive_data(int channel)
 		} else if (dt == DSI_DT_RX_DCS_LONG_READ) {
 			DSSERR("\tDCS long response, len %d\n",
 					FLD_GET(val, 23, 8));
-			dsi_vc_flush_long_data(channel);
+			dsi_vc_flush_long_data(dsidev, channel);
 		} else {
 			DSSERR("\tunknown datatype 0x%02x\n", dt);
 		}
@@ -2570,40 +2622,42 @@ static u16 dsi_vc_flush_receive_data(int channel)
 	return 0;
 }
 
-static int dsi_vc_send_bta(int channel)
+static int dsi_vc_send_bta(struct platform_device *dsidev, int channel)
 {
 	if (dsi.debug_write || dsi.debug_read)
 		DSSDBG("dsi_vc_send_bta %d\n", channel);
 
-	WARN_ON(!dsi_bus_is_locked());
+	WARN_ON(!dsi_bus_is_locked(dsidev));
 
-	if (REG_GET(DSI_VC_CTRL(channel), 20, 20)) {	/* RX_FIFO_NOT_EMPTY */
+	/* RX_FIFO_NOT_EMPTY */
+	if (REG_GET(dsidev, DSI_VC_CTRL(channel), 20, 20)) {
 		DSSERR("rx fifo not empty when sending BTA, dumping data:\n");
-		dsi_vc_flush_receive_data(channel);
+		dsi_vc_flush_receive_data(dsidev, channel);
 	}
 
-	REG_FLD_MOD(DSI_VC_CTRL(channel), 1, 6, 6); /* BTA_EN */
+	REG_FLD_MOD(dsidev, DSI_VC_CTRL(channel), 1, 6, 6); /* BTA_EN */
 
 	return 0;
 }
 
 int dsi_vc_send_bta_sync(struct omap_dss_device *dssdev, int channel)
 {
+	struct platform_device *dsidev = dsi_get_dsi_device(dssdev);
 	DECLARE_COMPLETION_ONSTACK(completion);
 	int r = 0;
 	u32 err;
 
-	r = dsi_register_isr_vc(channel, dsi_completion_handler,
+	r = dsi_register_isr_vc(dsidev, channel, dsi_completion_handler,
 			&completion, DSI_VC_IRQ_BTA);
 	if (r)
 		goto err0;
 
-	r = dsi_register_isr(dsi_completion_handler, &completion,
+	r = dsi_register_isr(dsidev, dsi_completion_handler, &completion,
 			DSI_IRQ_ERROR_MASK);
 	if (r)
 		goto err1;
 
-	r = dsi_vc_send_bta(channel);
+	r = dsi_vc_send_bta(dsidev, channel);
 	if (r)
 		goto err2;
 
@@ -2614,41 +2668,41 @@ int dsi_vc_send_bta_sync(struct omap_dss_device *dssdev, int channel)
 		goto err2;
 	}
 
-	err = dsi_get_errors();
+	err = dsi_get_errors(dsidev);
 	if (err) {
 		DSSERR("Error while sending BTA: %x\n", err);
 		r = -EIO;
 		goto err2;
 	}
 err2:
-	dsi_unregister_isr(dsi_completion_handler, &completion,
+	dsi_unregister_isr(dsidev, dsi_completion_handler, &completion,
 			DSI_IRQ_ERROR_MASK);
 err1:
-	dsi_unregister_isr_vc(channel, dsi_completion_handler,
+	dsi_unregister_isr_vc(dsidev, channel, dsi_completion_handler,
 			&completion, DSI_VC_IRQ_BTA);
 err0:
 	return r;
 }
 EXPORT_SYMBOL(dsi_vc_send_bta_sync);
 
-static inline void dsi_vc_write_long_header(int channel, u8 data_type,
-		u16 len, u8 ecc)
+static inline void dsi_vc_write_long_header(struct platform_device *dsidev,
+		int channel, u8 data_type, u16 len, u8 ecc)
 {
 	u32 val;
 	u8 data_id;
 
-	WARN_ON(!dsi_bus_is_locked());
+	WARN_ON(!dsi_bus_is_locked(dsidev));
 
 	data_id = data_type | dsi.vc[channel].vc_id << 6;
 
 	val = FLD_VAL(data_id, 7, 0) | FLD_VAL(len, 23, 8) |
 		FLD_VAL(ecc, 31, 24);
 
-	dsi_write_reg(DSI_VC_LONG_PACKET_HEADER(channel), val);
+	dsi_write_reg(dsidev, DSI_VC_LONG_PACKET_HEADER(channel), val);
 }
 
-static inline void dsi_vc_write_long_payload(int channel,
-		u8 b1, u8 b2, u8 b3, u8 b4)
+static inline void dsi_vc_write_long_payload(struct platform_device *dsidev,
+		int channel, u8 b1, u8 b2, u8 b3, u8 b4)
 {
 	u32 val;
 
@@ -2657,11 +2711,11 @@ static inline void dsi_vc_write_long_payload(int channel,
 /*	DSSDBG("\twriting %02x, %02x, %02x, %02x (%#010x)\n",
 			b1, b2, b3, b4, val); */
 
-	dsi_write_reg(DSI_VC_LONG_PACKET_PAYLOAD(channel), val);
+	dsi_write_reg(dsidev, DSI_VC_LONG_PACKET_PAYLOAD(channel), val);
 }
 
-static int dsi_vc_send_long(int channel, u8 data_type, u8 *data, u16 len,
-		u8 ecc)
+static int dsi_vc_send_long(struct platform_device *dsidev, int channel,
+		u8 data_type, u8 *data, u16 len, u8 ecc)
 {
 	/*u32 val; */
 	int i;
@@ -2678,9 +2732,9 @@ static int dsi_vc_send_long(int channel, u8 data_type, u8 *data, u16 len,
 		return -EINVAL;
 	}
 
-	dsi_vc_config_l4(channel);
+	dsi_vc_config_l4(dsidev, channel);
 
-	dsi_vc_write_long_header(channel, data_type, len, ecc);
+	dsi_vc_write_long_header(dsidev, channel, data_type, len, ecc);
 
 	p = data;
 	for (i = 0; i < len >> 2; i++) {
@@ -2692,7 +2746,7 @@ static int dsi_vc_send_long(int channel, u8 data_type, u8 *data, u16 len,
 		b3 = *p++;
 		b4 = *p++;
 
-		dsi_vc_write_long_payload(channel, b1, b2, b3, b4);
+		dsi_vc_write_long_payload(dsidev, channel, b1, b2, b3, b4);
 	}
 
 	i = len % 4;
@@ -2717,27 +2771,28 @@ static int dsi_vc_send_long(int channel, u8 data_type, u8 *data, u16 len,
 			break;
 		}
 
-		dsi_vc_write_long_payload(channel, b1, b2, b3, 0);
+		dsi_vc_write_long_payload(dsidev, channel, b1, b2, b3, 0);
 	}
 
 	return r;
 }
 
-static int dsi_vc_send_short(int channel, u8 data_type, u16 data, u8 ecc)
+static int dsi_vc_send_short(struct platform_device *dsidev, int channel,
+		u8 data_type, u16 data, u8 ecc)
 {
 	u32 r;
 	u8 data_id;
 
-	WARN_ON(!dsi_bus_is_locked());
+	WARN_ON(!dsi_bus_is_locked(dsidev));
 
 	if (dsi.debug_write)
 		DSSDBG("dsi_vc_send_short(ch%d, dt %#x, b1 %#x, b2 %#x)\n",
 				channel,
 				data_type, data & 0xff, (data >> 8) & 0xff);
 
-	dsi_vc_config_l4(channel);
+	dsi_vc_config_l4(dsidev, channel);
 
-	if (FLD_GET(dsi_read_reg(DSI_VC_CTRL(channel)), 16, 16)) {
+	if (FLD_GET(dsi_read_reg(dsidev, DSI_VC_CTRL(channel)), 16, 16)) {
 		DSSERR("ERROR FIFO FULL, aborting transfer\n");
 		return -EINVAL;
 	}
@@ -2746,34 +2801,38 @@ static int dsi_vc_send_short(int channel, u8 data_type, u16 data, u8 ecc)
 
 	r = (data_id << 0) | (data << 8) | (ecc << 24);
 
-	dsi_write_reg(DSI_VC_SHORT_PACKET_HEADER(channel), r);
+	dsi_write_reg(dsidev, DSI_VC_SHORT_PACKET_HEADER(channel), r);
 
 	return 0;
 }
 
 int dsi_vc_send_null(struct omap_dss_device *dssdev, int channel)
 {
+	struct platform_device *dsidev = dsi_get_dsi_device(dssdev);
 	u8 nullpkg[] = {0, 0, 0, 0};
-	return dsi_vc_send_long(channel, DSI_DT_NULL_PACKET, nullpkg, 4, 0);
+
+	return dsi_vc_send_long(dsidev, channel, DSI_DT_NULL_PACKET, nullpkg,
+		4, 0);
 }
 EXPORT_SYMBOL(dsi_vc_send_null);
 
 int dsi_vc_dcs_write_nosync(struct omap_dss_device *dssdev, int channel,
 		u8 *data, int len)
 {
+	struct platform_device *dsidev = dsi_get_dsi_device(dssdev);
 	int r;
 
 	BUG_ON(len == 0);
 
 	if (len == 1) {
-		r = dsi_vc_send_short(channel, DSI_DT_DCS_SHORT_WRITE_0,
+		r = dsi_vc_send_short(dsidev, channel, DSI_DT_DCS_SHORT_WRITE_0,
 				data[0], 0);
 	} else if (len == 2) {
-		r = dsi_vc_send_short(channel, DSI_DT_DCS_SHORT_WRITE_1,
+		r = dsi_vc_send_short(dsidev, channel, DSI_DT_DCS_SHORT_WRITE_1,
 				data[0] | (data[1] << 8), 0);
 	} else {
 		/* 0x39 = DCS Long Write */
-		r = dsi_vc_send_long(channel, DSI_DT_DCS_LONG_WRITE,
+		r = dsi_vc_send_long(dsidev, channel, DSI_DT_DCS_LONG_WRITE,
 				data, len, 0);
 	}
 
@@ -2784,6 +2843,7 @@ EXPORT_SYMBOL(dsi_vc_dcs_write_nosync);
 int dsi_vc_dcs_write(struct omap_dss_device *dssdev, int channel, u8 *data,
 		int len)
 {
+	struct platform_device *dsidev = dsi_get_dsi_device(dssdev);
 	int r;
 
 	r = dsi_vc_dcs_write_nosync(dssdev, channel, data, len);
@@ -2794,9 +2854,10 @@ int dsi_vc_dcs_write(struct omap_dss_device *dssdev, int channel, u8 *data,
 	if (r)
 		goto err;
 
-	if (REG_GET(DSI_VC_CTRL(channel), 20, 20)) {	/* RX_FIFO_NOT_EMPTY */
+	/* RX_FIFO_NOT_EMPTY */
+	if (REG_GET(dsidev, DSI_VC_CTRL(channel), 20, 20)) {
 		DSSERR("rx fifo not empty after write, dumping data:\n");
-		dsi_vc_flush_receive_data(channel);
+		dsi_vc_flush_receive_data(dsidev, channel);
 		r = -EIO;
 		goto err;
 	}
@@ -2828,6 +2889,7 @@ EXPORT_SYMBOL(dsi_vc_dcs_write_1);
 int dsi_vc_dcs_read(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
 		u8 *buf, int buflen)
 {
+	struct platform_device *dsidev = dsi_get_dsi_device(dssdev);
 	u32 val;
 	u8 dt;
 	int r;
@@ -2835,7 +2897,7 @@ int dsi_vc_dcs_read(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
 	if (dsi.debug_read)
 		DSSDBG("dsi_vc_dcs_read(ch%d, dcs_cmd %x)\n", channel, dcs_cmd);
 
-	r = dsi_vc_send_short(channel, DSI_DT_DCS_READ, dcs_cmd, 0);
+	r = dsi_vc_send_short(dsidev, channel, DSI_DT_DCS_READ, dcs_cmd, 0);
 	if (r)
 		goto err;
 
@@ -2844,13 +2906,13 @@ int dsi_vc_dcs_read(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
 		goto err;
 
 	/* RX_FIFO_NOT_EMPTY */
-	if (REG_GET(DSI_VC_CTRL(channel), 20, 20) == 0) {
+	if (REG_GET(dsidev, DSI_VC_CTRL(channel), 20, 20) == 0) {
 		DSSERR("RX fifo empty when trying to read.\n");
 		r = -EIO;
 		goto err;
 	}
 
-	val = dsi_read_reg(DSI_VC_SHORT_PACKET_HEADER(channel));
+	val = dsi_read_reg(dsidev, DSI_VC_SHORT_PACKET_HEADER(channel));
 	if (dsi.debug_read)
 		DSSDBG("\theader: %08x\n", val);
 	dt = FLD_GET(val, 5, 0);
@@ -2901,7 +2963,8 @@ int dsi_vc_dcs_read(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
 		/* two byte checksum ends the packet, not included in len */
 		for (w = 0; w < len + 2;) {
 			int b;
-			val = dsi_read_reg(DSI_VC_SHORT_PACKET_HEADER(channel));
+			val = dsi_read_reg(dsidev,
+				DSI_VC_SHORT_PACKET_HEADER(channel));
 			if (dsi.debug_read)
 				DSSDBG("\t\t%02x %02x %02x %02x\n",
 						(val >> 0) & 0xff,
@@ -2974,60 +3037,63 @@ EXPORT_SYMBOL(dsi_vc_dcs_read_2);
 int dsi_vc_set_max_rx_packet_size(struct omap_dss_device *dssdev, int channel,
 		u16 len)
 {
-	return dsi_vc_send_short(channel, DSI_DT_SET_MAX_RET_PKG_SIZE,
+	struct platform_device *dsidev = dsi_get_dsi_device(dssdev);
+
+	return dsi_vc_send_short(dsidev, channel, DSI_DT_SET_MAX_RET_PKG_SIZE,
 			len, 0);
 }
 EXPORT_SYMBOL(dsi_vc_set_max_rx_packet_size);
 
-static int dsi_enter_ulps(void)
+static int dsi_enter_ulps(struct platform_device *dsidev)
 {
 	DECLARE_COMPLETION_ONSTACK(completion);
 	int r;
 
 	DSSDBGF();
 
-	WARN_ON(!dsi_bus_is_locked());
+	WARN_ON(!dsi_bus_is_locked(dsidev));
 
 	WARN_ON(dsi.ulps_enabled);
 
 	if (dsi.ulps_enabled)
 		return 0;
 
-	if (REG_GET(DSI_CLK_CTRL, 13, 13)) {
+	if (REG_GET(dsidev, DSI_CLK_CTRL, 13, 13)) {
 		DSSERR("DDR_CLK_ALWAYS_ON enabled when entering ULPS\n");
 		return -EIO;
 	}
 
-	dsi_sync_vc(0);
-	dsi_sync_vc(1);
-	dsi_sync_vc(2);
-	dsi_sync_vc(3);
+	dsi_sync_vc(dsidev, 0);
+	dsi_sync_vc(dsidev, 1);
+	dsi_sync_vc(dsidev, 2);
+	dsi_sync_vc(dsidev, 3);
 
-	dsi_force_tx_stop_mode_io();
+	dsi_force_tx_stop_mode_io(dsidev);
 
-	dsi_vc_enable(0, false);
-	dsi_vc_enable(1, false);
-	dsi_vc_enable(2, false);
-	dsi_vc_enable(3, false);
+	dsi_vc_enable(dsidev, 0, false);
+	dsi_vc_enable(dsidev, 1, false);
+	dsi_vc_enable(dsidev, 2, false);
+	dsi_vc_enable(dsidev, 3, false);
 
-	if (REG_GET(DSI_COMPLEXIO_CFG2, 16, 16)) {	/* HS_BUSY */
+	if (REG_GET(dsidev, DSI_COMPLEXIO_CFG2, 16, 16)) {	/* HS_BUSY */
 		DSSERR("HS busy when enabling ULPS\n");
 		return -EIO;
 	}
 
-	if (REG_GET(DSI_COMPLEXIO_CFG2, 17, 17)) {	/* LP_BUSY */
+	if (REG_GET(dsidev, DSI_COMPLEXIO_CFG2, 17, 17)) {	/* LP_BUSY */
 		DSSERR("LP busy when enabling ULPS\n");
 		return -EIO;
 	}
 
-	r = dsi_register_isr_cio(dsi_completion_handler, &completion,
+	r = dsi_register_isr_cio(dsidev, dsi_completion_handler, &completion,
 			DSI_CIO_IRQ_ULPSACTIVENOT_ALL0);
 	if (r)
 		return r;
 
 	/* Assert TxRequestEsc for data lanes and TxUlpsClk for clk lane */
 	/* LANEx_ULPS_SIG2 */
-	REG_FLD_MOD(DSI_COMPLEXIO_CFG2, (1 << 0) | (1 << 1) | (1 << 2), 7, 5);
+	REG_FLD_MOD(dsidev, DSI_COMPLEXIO_CFG2, (1 << 0) | (1 << 1) | (1 << 2),
+		7, 5);
 
 	if (wait_for_completion_timeout(&completion,
 				msecs_to_jiffies(1000)) == 0) {
@@ -3036,24 +3102,25 @@ static int dsi_enter_ulps(void)
 		goto err;
 	}
 
-	dsi_unregister_isr_cio(dsi_completion_handler, &completion,
+	dsi_unregister_isr_cio(dsidev, dsi_completion_handler, &completion,
 			DSI_CIO_IRQ_ULPSACTIVENOT_ALL0);
 
-	dsi_cio_power(DSI_COMPLEXIO_POWER_ULPS);
+	dsi_cio_power(dsidev, DSI_COMPLEXIO_POWER_ULPS);
 
-	dsi_if_enable(false);
+	dsi_if_enable(dsidev, false);
 
 	dsi.ulps_enabled = true;
 
 	return 0;
 
 err:
-	dsi_unregister_isr_cio(dsi_completion_handler, &completion,
+	dsi_unregister_isr_cio(dsidev, dsi_completion_handler, &completion,
 			DSI_CIO_IRQ_ULPSACTIVENOT_ALL0);
 	return r;
 }
 
-static void dsi_set_lp_rx_timeout(unsigned ticks, bool x4, bool x16)
+static void dsi_set_lp_rx_timeout(struct platform_device *dsidev,
+		unsigned ticks, bool x4, bool x16)
 {
 	unsigned long fck;
 	unsigned long total_ticks;
@@ -3062,14 +3129,14 @@ static void dsi_set_lp_rx_timeout(unsigned ticks, bool x4, bool x16)
 	BUG_ON(ticks > 0x1fff);
 
 	/* ticks in DSI_FCK */
-	fck = dsi_fclk_rate();
+	fck = dsi_fclk_rate(dsidev);
 
-	r = dsi_read_reg(DSI_TIMING2);
+	r = dsi_read_reg(dsidev, DSI_TIMING2);
 	r = FLD_MOD(r, 1, 15, 15);	/* LP_RX_TO */
 	r = FLD_MOD(r, x16 ? 1 : 0, 14, 14);	/* LP_RX_TO_X16 */
 	r = FLD_MOD(r, x4 ? 1 : 0, 13, 13);	/* LP_RX_TO_X4 */
 	r = FLD_MOD(r, ticks, 12, 0);	/* LP_RX_COUNTER */
-	dsi_write_reg(DSI_TIMING2, r);
+	dsi_write_reg(dsidev, DSI_TIMING2, r);
 
 	total_ticks = ticks * (x16 ? 16 : 1) * (x4 ? 4 : 1);
 
@@ -3079,7 +3146,8 @@ static void dsi_set_lp_rx_timeout(unsigned ticks, bool x4, bool x16)
 			(total_ticks * 1000) / (fck / 1000 / 1000));
 }
 
-static void dsi_set_ta_timeout(unsigned ticks, bool x8, bool x16)
+static void dsi_set_ta_timeout(struct platform_device *dsidev, unsigned ticks,
+		bool x8, bool x16)
 {
 	unsigned long fck;
 	unsigned long total_ticks;
@@ -3088,14 +3156,14 @@ static void dsi_set_ta_timeout(unsigned ticks, bool x8, bool x16)
 	BUG_ON(ticks > 0x1fff);
 
 	/* ticks in DSI_FCK */
-	fck = dsi_fclk_rate();
+	fck = dsi_fclk_rate(dsidev);
 
-	r = dsi_read_reg(DSI_TIMING1);
+	r = dsi_read_reg(dsidev, DSI_TIMING1);
 	r = FLD_MOD(r, 1, 31, 31);	/* TA_TO */
 	r = FLD_MOD(r, x16 ? 1 : 0, 30, 30);	/* TA_TO_X16 */
 	r = FLD_MOD(r, x8 ? 1 : 0, 29, 29);	/* TA_TO_X8 */
 	r = FLD_MOD(r, ticks, 28, 16);	/* TA_TO_COUNTER */
-	dsi_write_reg(DSI_TIMING1, r);
+	dsi_write_reg(dsidev, DSI_TIMING1, r);
 
 	total_ticks = ticks * (x16 ? 16 : 1) * (x8 ? 8 : 1);
 
@@ -3105,7 +3173,8 @@ static void dsi_set_ta_timeout(unsigned ticks, bool x8, bool x16)
 			(total_ticks * 1000) / (fck / 1000 / 1000));
 }
 
-static void dsi_set_stop_state_counter(unsigned ticks, bool x4, bool x16)
+static void dsi_set_stop_state_counter(struct platform_device *dsidev,
+		unsigned ticks, bool x4, bool x16)
 {
 	unsigned long fck;
 	unsigned long total_ticks;
@@ -3114,14 +3183,14 @@ static void dsi_set_stop_state_counter(unsigned ticks, bool x4, bool x16)
 	BUG_ON(ticks > 0x1fff);
 
 	/* ticks in DSI_FCK */
-	fck = dsi_fclk_rate();
+	fck = dsi_fclk_rate(dsidev);
 
-	r = dsi_read_reg(DSI_TIMING1);
+	r = dsi_read_reg(dsidev, DSI_TIMING1);
 	r = FLD_MOD(r, 1, 15, 15);	/* FORCE_TX_STOP_MODE_IO */
 	r = FLD_MOD(r, x16 ? 1 : 0, 14, 14);	/* STOP_STATE_X16_IO */
 	r = FLD_MOD(r, x4 ? 1 : 0, 13, 13);	/* STOP_STATE_X4_IO */
 	r = FLD_MOD(r, ticks, 12, 0);	/* STOP_STATE_COUNTER_IO */
-	dsi_write_reg(DSI_TIMING1, r);
+	dsi_write_reg(dsidev, DSI_TIMING1, r);
 
 	total_ticks = ticks * (x16 ? 16 : 1) * (x4 ? 4 : 1);
 
@@ -3131,7 +3200,8 @@ static void dsi_set_stop_state_counter(unsigned ticks, bool x4, bool x16)
 			(total_ticks * 1000) / (fck / 1000 / 1000));
 }
 
-static void dsi_set_hs_tx_timeout(unsigned ticks, bool x4, bool x16)
+static void dsi_set_hs_tx_timeout(struct platform_device *dsidev,
+		unsigned ticks, bool x4, bool x16)
 {
 	unsigned long fck;
 	unsigned long total_ticks;
@@ -3140,14 +3210,14 @@ static void dsi_set_hs_tx_timeout(unsigned ticks, bool x4, bool x16)
 	BUG_ON(ticks > 0x1fff);
 
 	/* ticks in TxByteClkHS */
-	fck = dsi_get_txbyteclkhs();
+	fck = dsi_get_txbyteclkhs(dsidev);
 
-	r = dsi_read_reg(DSI_TIMING2);
+	r = dsi_read_reg(dsidev, DSI_TIMING2);
 	r = FLD_MOD(r, 1, 31, 31);	/* HS_TX_TO */
 	r = FLD_MOD(r, x16 ? 1 : 0, 30, 30);	/* HS_TX_TO_X16 */
 	r = FLD_MOD(r, x4 ? 1 : 0, 29, 29);	/* HS_TX_TO_X8 (4 really) */
 	r = FLD_MOD(r, ticks, 28, 16);	/* HS_TX_TO_COUNTER */
-	dsi_write_reg(DSI_TIMING2, r);
+	dsi_write_reg(dsidev, DSI_TIMING2, r);
 
 	total_ticks = ticks * (x16 ? 16 : 1) * (x4 ? 4 : 1);
 
@@ -3158,24 +3228,25 @@ static void dsi_set_hs_tx_timeout(unsigned ticks, bool x4, bool x16)
 }
 static int dsi_proto_config(struct omap_dss_device *dssdev)
 {
+	struct platform_device *dsidev = dsi_get_dsi_device(dssdev);
 	u32 r;
 	int buswidth = 0;
 
-	dsi_config_tx_fifo(DSI_FIFO_SIZE_32,
+	dsi_config_tx_fifo(dsidev, DSI_FIFO_SIZE_32,
 			DSI_FIFO_SIZE_32,
 			DSI_FIFO_SIZE_32,
 			DSI_FIFO_SIZE_32);
 
-	dsi_config_rx_fifo(DSI_FIFO_SIZE_32,
+	dsi_config_rx_fifo(dsidev, DSI_FIFO_SIZE_32,
 			DSI_FIFO_SIZE_32,
 			DSI_FIFO_SIZE_32,
 			DSI_FIFO_SIZE_32);
 
 	/* XXX what values for the timeouts? */
-	dsi_set_stop_state_counter(0x1000, false, false);
-	dsi_set_ta_timeout(0x1fff, true, true);
-	dsi_set_lp_rx_timeout(0x1fff, true, true);
-	dsi_set_hs_tx_timeout(0x1fff, true, true);
+	dsi_set_stop_state_counter(dsidev, 0x1000, false, false);
+	dsi_set_ta_timeout(dsidev, 0x1fff, true, true);
+	dsi_set_lp_rx_timeout(dsidev, 0x1fff, true, true);
+	dsi_set_hs_tx_timeout(dsidev, 0x1fff, true, true);
 
 	switch (dssdev->ctrl.pixel_size) {
 	case 16:
@@ -3191,7 +3262,7 @@ static int dsi_proto_config(struct omap_dss_device *dssdev)
 		BUG();
 	}
 
-	r = dsi_read_reg(DSI_CTRL);
+	r = dsi_read_reg(dsidev, DSI_CTRL);
 	r = FLD_MOD(r, 1, 1, 1);	/* CS_RX_EN */
 	r = FLD_MOD(r, 1, 2, 2);	/* ECC_RX_EN */
 	r = FLD_MOD(r, 1, 3, 3);	/* TX_FIFO_ARBITRATION */
@@ -3207,18 +3278,19 @@ static int dsi_proto_config(struct omap_dss_device *dssdev)
 		r = FLD_MOD(r, 0, 25, 25);
 	}
 
-	dsi_write_reg(DSI_CTRL, r);
+	dsi_write_reg(dsidev, DSI_CTRL, r);
 
-	dsi_vc_initial_config(0);
-	dsi_vc_initial_config(1);
-	dsi_vc_initial_config(2);
-	dsi_vc_initial_config(3);
+	dsi_vc_initial_config(dsidev, 0);
+	dsi_vc_initial_config(dsidev, 1);
+	dsi_vc_initial_config(dsidev, 2);
+	dsi_vc_initial_config(dsidev, 3);
 
 	return 0;
 }
 
 static void dsi_proto_timings(struct omap_dss_device *dssdev)
 {
+	struct platform_device *dsidev = dsi_get_dsi_device(dssdev);
 	unsigned tlpx, tclk_zero, tclk_prepare, tclk_trail;
 	unsigned tclk_pre, tclk_post;
 	unsigned ths_prepare, ths_prepare_ths_zero, ths_zero;
@@ -3228,25 +3300,25 @@ static void dsi_proto_timings(struct omap_dss_device *dssdev)
 	unsigned ths_eot;
 	u32 r;
 
-	r = dsi_read_reg(DSI_DSIPHY_CFG0);
+	r = dsi_read_reg(dsidev, DSI_DSIPHY_CFG0);
 	ths_prepare = FLD_GET(r, 31, 24);
 	ths_prepare_ths_zero = FLD_GET(r, 23, 16);
 	ths_zero = ths_prepare_ths_zero - ths_prepare;
 	ths_trail = FLD_GET(r, 15, 8);
 	ths_exit = FLD_GET(r, 7, 0);
 
-	r = dsi_read_reg(DSI_DSIPHY_CFG1);
+	r = dsi_read_reg(dsidev, DSI_DSIPHY_CFG1);
 	tlpx = FLD_GET(r, 22, 16) * 2;
 	tclk_trail = FLD_GET(r, 15, 8);
 	tclk_zero = FLD_GET(r, 7, 0);
 
-	r = dsi_read_reg(DSI_DSIPHY_CFG2);
+	r = dsi_read_reg(dsidev, DSI_DSIPHY_CFG2);
 	tclk_prepare = FLD_GET(r, 7, 0);
 
 	/* min 8*UI */
 	tclk_pre = 20;
 	/* min 60ns + 52*UI */
-	tclk_post = ns2ddr(60) + 26;
+	tclk_post = ns2ddr(dsidev, 60) + 26;
 
 	/* ths_eot is 2 for 2 datalanes and 4 for 1 datalane */
 	if (dssdev->phy.dsi.data1_lane != 0 &&
@@ -3262,10 +3334,10 @@ static void dsi_proto_timings(struct omap_dss_device *dssdev)
 	BUG_ON(ddr_clk_pre == 0 || ddr_clk_pre > 255);
 	BUG_ON(ddr_clk_post == 0 || ddr_clk_post > 255);
 
-	r = dsi_read_reg(DSI_CLK_TIMING);
+	r = dsi_read_reg(dsidev, DSI_CLK_TIMING);
 	r = FLD_MOD(r, ddr_clk_pre, 15, 8);
 	r = FLD_MOD(r, ddr_clk_post, 7, 0);
-	dsi_write_reg(DSI_CLK_TIMING, r);
+	dsi_write_reg(dsidev, DSI_CLK_TIMING, r);
 
 	DSSDBG("ddr_clk_pre %u, ddr_clk_post %u\n",
 			ddr_clk_pre,
@@ -3279,7 +3351,7 @@ static void dsi_proto_timings(struct omap_dss_device *dssdev)
 
 	r = FLD_VAL(enter_hs_mode_lat, 31, 16) |
 		FLD_VAL(exit_hs_mode_lat, 15, 0);
-	dsi_write_reg(DSI_VM_TIMING7, r);
+	dsi_write_reg(dsidev, DSI_VM_TIMING7, r);
 
 	DSSDBG("enter_hs_mode_lat %u, exit_hs_mode_lat %u\n",
 			enter_hs_mode_lat, exit_hs_mode_lat);
@@ -3289,25 +3361,26 @@ static void dsi_proto_timings(struct omap_dss_device *dssdev)
 #define DSI_DECL_VARS \
 	int __dsi_cb = 0; u32 __dsi_cv = 0;
 
-#define DSI_FLUSH(ch) \
+#define DSI_FLUSH(dsidev, ch) \
 	if (__dsi_cb > 0) { \
 		/*DSSDBG("sending long packet %#010x\n", __dsi_cv);*/ \
-		dsi_write_reg(DSI_VC_LONG_PACKET_PAYLOAD(ch), __dsi_cv); \
+		dsi_write_reg(dsidev, DSI_VC_LONG_PACKET_PAYLOAD(ch), __dsi_cv); \
 		__dsi_cb = __dsi_cv = 0; \
 	}
 
-#define DSI_PUSH(ch, data) \
+#define DSI_PUSH(dsidev, ch, data) \
 	do { \
 		__dsi_cv |= (data) << (__dsi_cb * 8); \
 		/*DSSDBG("cv = %#010x, cb = %d\n", __dsi_cv, __dsi_cb);*/ \
 		if (++__dsi_cb > 3) \
-			DSI_FLUSH(ch); \
+			DSI_FLUSH(dsidev, ch); \
 	} while (0)
 
 static int dsi_update_screen_l4(struct omap_dss_device *dssdev,
 			int x, int y, int w, int h)
 {
 	/* Note: supports only 24bit colors in 32bit container */
+	struct platform_device *dsidev = dsi_get_dsi_device(dssdev);
 	int first = 1;
 	int fifo_stalls = 0;
 	int max_dsi_packet_size;
@@ -3375,35 +3448,35 @@ static int dsi_update_screen_l4(struct omap_dss_device *dssdev,
 #if 1
 		/* using fifo not empty */
 		/* TX_FIFO_NOT_EMPTY */
-		while (FLD_GET(dsi_read_reg(DSI_VC_CTRL(0)), 5, 5)) {
+		while (FLD_GET(dsi_read_reg(dsidev, DSI_VC_CTRL(0)), 5, 5)) {
 			fifo_stalls++;
 			if (fifo_stalls > 0xfffff) {
 				DSSERR("fifo stalls overflow, pixels left %d\n",
 						pixels_left);
-				dsi_if_enable(0);
+				dsi_if_enable(dsidev, 0);
 				return -EIO;
 			}
 			udelay(1);
 		}
 #elif 1
 		/* using fifo emptiness */
-		while ((REG_GET(DSI_TX_FIFO_VC_EMPTINESS, 7, 0)+1)*4 <
+		while ((REG_GET(dsidev, DSI_TX_FIFO_VC_EMPTINESS, 7, 0)+1)*4 <
 				max_dsi_packet_size) {
 			fifo_stalls++;
 			if (fifo_stalls > 0xfffff) {
 				DSSERR("fifo stalls overflow, pixels left %d\n",
 					       pixels_left);
-				dsi_if_enable(0);
+				dsi_if_enable(dsidev, 0);
 				return -EIO;
 			}
 		}
 #else
-		while ((REG_GET(DSI_TX_FIFO_VC_EMPTINESS, 7, 0)+1)*4 == 0) {
+		while ((REG_GET(dsidev, DSI_TX_FIFO_VC_EMPTINESS, 7, 0)+1)*4 == 0) {
 			fifo_stalls++;
 			if (fifo_stalls > 0xfffff) {
 				DSSERR("fifo stalls overflow, pixels left %d\n",
 					       pixels_left);
-				dsi_if_enable(0);
+				dsi_if_enable(dsidev, 0);
 				return -EIO;
 			}
 		}
@@ -3412,17 +3485,17 @@ static int dsi_update_screen_l4(struct omap_dss_device *dssdev,
 
 		pixels_left -= pixels;
 
-		dsi_vc_write_long_header(0, DSI_DT_DCS_LONG_WRITE,
+		dsi_vc_write_long_header(dsidev, 0, DSI_DT_DCS_LONG_WRITE,
 				1 + pixels * bytespp, 0);
 
-		DSI_PUSH(0, dcs_cmd);
+		DSI_PUSH(dsidev, 0, dcs_cmd);
 
 		while (pixels-- > 0) {
 			u32 pix = __raw_readl(data++);
 
-			DSI_PUSH(0, (pix >> 16) & 0xff);
-			DSI_PUSH(0, (pix >> 8) & 0xff);
-			DSI_PUSH(0, (pix >> 0) & 0xff);
+			DSI_PUSH(dsidev, 0, (pix >> 16) & 0xff);
+			DSI_PUSH(dsidev, 0, (pix >> 8) & 0xff);
+			DSI_PUSH(dsidev, 0, (pix >> 0) & 0xff);
 
 			current_x++;
 			if (current_x == x+w) {
@@ -3431,7 +3504,7 @@ static int dsi_update_screen_l4(struct omap_dss_device *dssdev,
 			}
 		}
 
-		DSI_FLUSH(0);
+		DSI_FLUSH(dsidev, 0);
 	}
 
 	return 0;
@@ -3440,6 +3513,7 @@ static int dsi_update_screen_l4(struct omap_dss_device *dssdev,
 static void dsi_update_screen_dispc(struct omap_dss_device *dssdev,
 		u16 x, u16 y, u16 w, u16 h)
 {
+	struct platform_device *dsidev = dsi_get_dsi_device(dssdev);
 	unsigned bytespp;
 	unsigned bytespl;
 	unsigned bytespf;
@@ -3457,7 +3531,7 @@ static void dsi_update_screen_dispc(struct omap_dss_device *dssdev,
 	DSSDBG("dsi_update_screen_dispc(%d,%d %dx%d)\n",
 			x, y, w, h);
 
-	dsi_vc_config_vp(channel);
+	dsi_vc_config_vp(dsidev, channel);
 
 	bytespp	= dssdev->ctrl.pixel_size / 8;
 	bytespl = w * bytespp;
@@ -3478,15 +3552,16 @@ static void dsi_update_screen_dispc(struct omap_dss_device *dssdev,
 		total_len += (bytespf % packet_payload) + 1;
 
 	l = FLD_VAL(total_len, 23, 0); /* TE_SIZE */
-	dsi_write_reg(DSI_VC_TE(channel), l);
+	dsi_write_reg(dsidev, DSI_VC_TE(channel), l);
 
-	dsi_vc_write_long_header(channel, DSI_DT_DCS_LONG_WRITE, packet_len, 0);
+	dsi_vc_write_long_header(dsidev, channel, DSI_DT_DCS_LONG_WRITE,
+		packet_len, 0);
 
 	if (dsi.te_enabled)
 		l = FLD_MOD(l, 1, 30, 30); /* TE_EN */
 	else
 		l = FLD_MOD(l, 1, 31, 31); /* TE_START */
-	dsi_write_reg(DSI_VC_TE(channel), l);
+	dsi_write_reg(dsidev, DSI_VC_TE(channel), l);
 
 	/* We put SIDLEMODE to no-idle for the duration of the transfer,
 	 * because DSS interrupts are not capable of waking up the CPU and the
@@ -3496,7 +3571,7 @@ static void dsi_update_screen_dispc(struct omap_dss_device *dssdev,
 	 */
 	dispc_disable_sidle();
 
-	dsi_perf_mark_start();
+	dsi_perf_mark_start(dsidev);
 
 	r = queue_delayed_work(dsi.workqueue, &dsi.framedone_timeout_work,
 			msecs_to_jiffies(250));
@@ -3507,9 +3582,9 @@ static void dsi_update_screen_dispc(struct omap_dss_device *dssdev,
 	if (dsi.te_enabled) {
 		/* disable LP_RX_TO, so that we can receive TE.  Time to wait
 		 * for TE is longer than the timer allows */
-		REG_FLD_MOD(DSI_TIMING2, 0, 15, 15); /* LP_RX_TO */
+		REG_FLD_MOD(dsidev, DSI_TIMING2, 0, 15, 15); /* LP_RX_TO */
 
-		dsi_vc_send_bta(channel);
+		dsi_vc_send_bta(dsidev, channel);
 
 #ifdef DSI_CATCH_MISSING_TE
 		mod_timer(&dsi.te_timer, jiffies + msecs_to_jiffies(250));
@@ -3524,20 +3599,20 @@ static void dsi_te_timeout(unsigned long arg)
 }
 #endif
 
-static void dsi_handle_framedone(int error)
+static void dsi_handle_framedone(struct platform_device *dsidev, int error)
 {
 	/* SIDLEMODE back to smart-idle */
 	dispc_enable_sidle();
 
 	if (dsi.te_enabled) {
 		/* enable LP_RX_TO again after the TE */
-		REG_FLD_MOD(DSI_TIMING2, 1, 15, 15); /* LP_RX_TO */
+		REG_FLD_MOD(dsidev, DSI_TIMING2, 1, 15, 15); /* LP_RX_TO */
 	}
 
 	dsi.framedone_callback(error, dsi.framedone_data);
 
 	if (!error)
-		dsi_perf_show("DISPC");
+		dsi_perf_show(dsidev, "DISPC");
 }
 
 static void dsi_framedone_timeout_work_callback(struct work_struct *work)
@@ -3551,11 +3626,13 @@ static void dsi_framedone_timeout_work_callback(struct work_struct *work)
 
 	DSSERR("Framedone not received for 250ms!\n");
 
-	dsi_handle_framedone(-ETIMEDOUT);
+	dsi_handle_framedone(dsi.pdev, -ETIMEDOUT);
 }
 
 static void dsi_framedone_irq_callback(void *data, u32 mask)
 {
+	struct omap_dss_device *dssdev = (struct omap_dss_device *) data;
+	struct platform_device *dsidev = dsi_get_dsi_device(dssdev);
 	/* Note: We get FRAMEDONE when DISPC has finished sending pixels and
 	 * turns itself off. However, DSI still has the pixels in its buffers,
 	 * and is sending the data.
@@ -3563,7 +3640,7 @@ static void dsi_framedone_irq_callback(void *data, u32 mask)
 
 	__cancel_delayed_work(&dsi.framedone_timeout_work);
 
-	dsi_handle_framedone(0);
+	dsi_handle_framedone(dsidev, 0);
 
 #ifdef CONFIG_OMAP2_DSS_FAKE_VSYNC
 	dispc_fake_vsync_irq();
@@ -3574,6 +3651,7 @@ int omap_dsi_prepare_update(struct omap_dss_device *dssdev,
 				    u16 *x, u16 *y, u16 *w, u16 *h,
 				    bool enlarge_update_area)
 {
+	struct platform_device *dsidev = dsi_get_dsi_device(dssdev);
 	u16 dw, dh;
 
 	dssdev->driver->get_resolution(dssdev, &dw, &dh);
@@ -3593,7 +3671,7 @@ int omap_dsi_prepare_update(struct omap_dss_device *dssdev,
 	if (*w == 0 || *h == 0)
 		return -EINVAL;
 
-	dsi_perf_mark_setup();
+	dsi_perf_mark_setup(dsidev);
 
 	if (dssdev->manager->caps & OMAP_DSS_OVL_MGR_CAP_DISPC) {
 		dss_setup_partial_planes(dssdev, x, y, w, h,
@@ -3610,6 +3688,8 @@ int omap_dsi_update(struct omap_dss_device *dssdev,
 		u16 x, u16 y, u16 w, u16 h,
 		void (*callback)(int, void *), void *data)
 {
+	struct platform_device *dsidev = dsi_get_dsi_device(dssdev);
+
 	dsi.update_channel = channel;
 
 	/* OMAP DSS cannot send updates of odd widths.
@@ -3636,7 +3716,7 @@ int omap_dsi_update(struct omap_dss_device *dssdev,
 		if (r)
 			return r;
 
-		dsi_perf_show("L4");
+		dsi_perf_show(dsidev, "L4");
 		callback(0, data);
 	}
 
@@ -3650,7 +3730,7 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 {
 	int r;
 
-	r = omap_dispc_register_isr(dsi_framedone_irq_callback, NULL,
+	r = omap_dispc_register_isr(dsi_framedone_irq_callback, (void *) dssdev,
 			DISPC_IRQ_FRAMEDONE);
 	if (r) {
 		DSSERR("can't get FRAMEDONE irq\n");
@@ -3684,12 +3764,13 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 
 static void dsi_display_uninit_dispc(struct omap_dss_device *dssdev)
 {
-	omap_dispc_unregister_isr(dsi_framedone_irq_callback, NULL,
+	omap_dispc_unregister_isr(dsi_framedone_irq_callback, (void *) dssdev,
 			DISPC_IRQ_FRAMEDONE);
 }
 
 static int dsi_configure_dsi_clocks(struct omap_dss_device *dssdev)
 {
+	struct platform_device *dsidev = dsi_get_dsi_device(dssdev);
 	struct dsi_clock_info cinfo;
 	int r;
 
@@ -3705,7 +3786,7 @@ static int dsi_configure_dsi_clocks(struct omap_dss_device *dssdev)
 		return r;
 	}
 
-	r = dsi_pll_set_clock_div(&cinfo);
+	r = dsi_pll_set_clock_div(dsidev, &cinfo);
 	if (r) {
 		DSSERR("Failed to set dsi clocks\n");
 		return r;
@@ -3716,11 +3797,12 @@ static int dsi_configure_dsi_clocks(struct omap_dss_device *dssdev)
 
 static int dsi_configure_dispc_clocks(struct omap_dss_device *dssdev)
 {
+	struct platform_device *dsidev = dsi_get_dsi_device(dssdev);
 	struct dispc_clock_info dispc_cinfo;
 	int r;
 	unsigned long long fck;
 
-	fck = dsi_get_pll_hsdiv_dispc_rate();
+	fck = dsi_get_pll_hsdiv_dispc_rate(dsidev);
 
 	dispc_cinfo.lck_div = dssdev->clocks.dispc.channel.lck_div;
 	dispc_cinfo.pck_div = dssdev->clocks.dispc.channel.pck_div;
@@ -3742,9 +3824,10 @@ static int dsi_configure_dispc_clocks(struct omap_dss_device *dssdev)
 
 static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
 {
+	struct platform_device *dsidev = dsi_get_dsi_device(dssdev);
 	int r;
 
-	r = dsi_pll_init(true, true);
+	r = dsi_pll_init(dsidev, true, true);
 	if (r)
 		goto err0;
 
@@ -3767,34 +3850,34 @@ static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
 	if (r)
 		goto err2;
 
-	_dsi_print_reset_status();
+	_dsi_print_reset_status(dsidev);
 
 	dsi_proto_timings(dssdev);
 	dsi_set_lp_clk_divisor(dssdev);
 
 	if (1)
-		_dsi_print_reset_status();
+		_dsi_print_reset_status(dsidev);
 
 	r = dsi_proto_config(dssdev);
 	if (r)
 		goto err3;
 
 	/* enable interface */
-	dsi_vc_enable(0, 1);
-	dsi_vc_enable(1, 1);
-	dsi_vc_enable(2, 1);
-	dsi_vc_enable(3, 1);
-	dsi_if_enable(1);
-	dsi_force_tx_stop_mode_io();
+	dsi_vc_enable(dsidev, 0, 1);
+	dsi_vc_enable(dsidev, 1, 1);
+	dsi_vc_enable(dsidev, 2, 1);
+	dsi_vc_enable(dsidev, 3, 1);
+	dsi_if_enable(dsidev, 1);
+	dsi_force_tx_stop_mode_io(dsidev);
 
 	return 0;
 err3:
-	dsi_cio_uninit();
+	dsi_cio_uninit(dsidev);
 err2:
 	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
 	dss_select_dsi_clk_source(OMAP_DSS_CLK_SRC_FCK);
 err1:
-	dsi_pll_uninit(true);
+	dsi_pll_uninit(dsidev, true);
 err0:
 	return r;
 }
@@ -3802,45 +3885,48 @@ err0:
 static void dsi_display_uninit_dsi(struct omap_dss_device *dssdev,
 		bool disconnect_lanes, bool enter_ulps)
 {
+	struct platform_device *dsidev = dsi_get_dsi_device(dssdev);
+
 	if (enter_ulps && !dsi.ulps_enabled)
-		dsi_enter_ulps();
+		dsi_enter_ulps(dsidev);
 
 	/* disable interface */
-	dsi_if_enable(0);
-	dsi_vc_enable(0, 0);
-	dsi_vc_enable(1, 0);
-	dsi_vc_enable(2, 0);
-	dsi_vc_enable(3, 0);
+	dsi_if_enable(dsidev, 0);
+	dsi_vc_enable(dsidev, 0, 0);
+	dsi_vc_enable(dsidev, 1, 0);
+	dsi_vc_enable(dsidev, 2, 0);
+	dsi_vc_enable(dsidev, 3, 0);
 
 	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
 	dss_select_dsi_clk_source(OMAP_DSS_CLK_SRC_FCK);
-	dsi_cio_uninit();
-	dsi_pll_uninit(disconnect_lanes);
+	dsi_cio_uninit(dsidev);
+	dsi_pll_uninit(dsidev, disconnect_lanes);
 }
 
-static int dsi_core_init(void)
+static int dsi_core_init(struct platform_device *dsidev)
 {
 	/* Autoidle */
-	REG_FLD_MOD(DSI_SYSCONFIG, 1, 0, 0);
+	REG_FLD_MOD(dsidev, DSI_SYSCONFIG, 1, 0, 0);
 
 	/* ENWAKEUP */
-	REG_FLD_MOD(DSI_SYSCONFIG, 1, 2, 2);
+	REG_FLD_MOD(dsidev, DSI_SYSCONFIG, 1, 2, 2);
 
 	/* SIDLEMODE smart-idle */
-	REG_FLD_MOD(DSI_SYSCONFIG, 2, 4, 3);
+	REG_FLD_MOD(dsidev, DSI_SYSCONFIG, 2, 4, 3);
 
-	_dsi_initialize_irq();
+	_dsi_initialize_irq(dsidev);
 
 	return 0;
 }
 
 int omapdss_dsi_display_enable(struct omap_dss_device *dssdev)
 {
+	struct platform_device *dsidev = dsi_get_dsi_device(dssdev);
 	int r = 0;
 
 	DSSDBG("dsi_display_enable\n");
 
-	WARN_ON(!dsi_bus_is_locked());
+	WARN_ON(!dsi_bus_is_locked(dsidev));
 
 	mutex_lock(&dsi.lock);
 
@@ -3851,13 +3937,13 @@ int omapdss_dsi_display_enable(struct omap_dss_device *dssdev)
 	}
 
 	enable_clocks(1);
-	dsi_enable_pll_clock(1);
+	dsi_enable_pll_clock(dsidev, 1);
 
-	r = _dsi_reset();
+	r = _dsi_reset(dsidev);
 	if (r)
 		goto err1;
 
-	dsi_core_init();
+	dsi_core_init(dsidev);
 
 	r = dsi_display_init_dispc(dssdev);
 	if (r)
@@ -3875,7 +3961,7 @@ err2:
 	dsi_display_uninit_dispc(dssdev);
 err1:
 	enable_clocks(0);
-	dsi_enable_pll_clock(0);
+	dsi_enable_pll_clock(dsidev, 0);
 	omap_dss_stop_device(dssdev);
 err0:
 	mutex_unlock(&dsi.lock);
@@ -3887,9 +3973,11 @@ EXPORT_SYMBOL(omapdss_dsi_display_enable);
 void omapdss_dsi_display_disable(struct omap_dss_device *dssdev,
 		bool disconnect_lanes, bool enter_ulps)
 {
+	struct platform_device *dsidev = dsi_get_dsi_device(dssdev);
+
 	DSSDBG("dsi_display_disable\n");
 
-	WARN_ON(!dsi_bus_is_locked());
+	WARN_ON(!dsi_bus_is_locked(dsidev));
 
 	mutex_lock(&dsi.lock);
 
@@ -3898,7 +3986,7 @@ void omapdss_dsi_display_disable(struct omap_dss_device *dssdev,
 	dsi_display_uninit_dsi(dssdev, disconnect_lanes, enter_ulps);
 
 	enable_clocks(0);
-	dsi_enable_pll_clock(0);
+	dsi_enable_pll_clock(dsidev, 0);
 
 	omap_dss_stop_device(dssdev);
 
@@ -4001,23 +4089,23 @@ void omap_dsi_release_vc(struct omap_dss_device *dssdev, int channel)
 }
 EXPORT_SYMBOL(omap_dsi_release_vc);
 
-void dsi_wait_pll_hsdiv_dispc_active(void)
+void dsi_wait_pll_hsdiv_dispc_active(struct platform_device *dsidev)
 {
-	if (wait_for_bit_change(DSI_PLL_STATUS, 7, 1) != 1)
+	if (wait_for_bit_change(dsidev, DSI_PLL_STATUS, 7, 1) != 1)
 		DSSERR("%s (%s) not active\n",
 			dss_get_generic_clk_source_name(OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC),
 			dss_feat_get_clk_source_name(OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC));
 }
 
-void dsi_wait_pll_hsdiv_dsi_active(void)
+void dsi_wait_pll_hsdiv_dsi_active(struct platform_device *dsidev)
 {
-	if (wait_for_bit_change(DSI_PLL_STATUS, 8, 1) != 1)
+	if (wait_for_bit_change(dsidev, DSI_PLL_STATUS, 8, 1) != 1)
 		DSSERR("%s (%s) not active\n",
 			dss_get_generic_clk_source_name(OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI),
 			dss_feat_get_clk_source_name(OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI));
 }
 
-static void dsi_calc_clock_param_ranges(void)
+static void dsi_calc_clock_param_ranges(struct platform_device *dsidev)
 {
 	dsi.regn_max = dss_feat_get_param_max(FEAT_PARAM_DSIPLL_REGN);
 	dsi.regm_max = dss_feat_get_param_max(FEAT_PARAM_DSIPLL_REGM);
@@ -4028,7 +4116,7 @@ static void dsi_calc_clock_param_ranges(void)
 	dsi.lpdiv_max = dss_feat_get_param_max(FEAT_PARAM_DSIPLL_LPDIV);
 }
 
-static int dsi_init(struct platform_device *pdev)
+static int dsi_init(struct platform_device *dsidev)
 {
 	struct omap_display_platform_data *dss_plat_data;
 	struct omap_dss_board_info *board_info;
@@ -4036,7 +4124,9 @@ static int dsi_init(struct platform_device *pdev)
 	int r, i;
 	struct resource *dsi_mem;
 
-	dss_plat_data = pdev->dev.platform_data;
+	dsi_pdev_map[dsidev->id] = dsidev;
+
+	dss_plat_data = dsidev->dev.platform_data;
 	board_info = dss_plat_data->board_data;
 	dsi.dsi_mux_pads = board_info->dsi_mux_pads;
 
@@ -4097,12 +4187,12 @@ static int dsi_init(struct platform_device *pdev)
 		dsi.vc[i].vc_id = 0;
 	}
 
-	dsi_calc_clock_param_ranges();
+	dsi_calc_clock_param_ranges(dsidev);
 
 	enable_clocks(1);
 
-	rev = dsi_read_reg(DSI_REVISION);
-	dev_dbg(&pdev->dev, "OMAP DSI rev %d.%d\n",
+	rev = dsi_read_reg(dsidev, DSI_REVISION);
+	dev_dbg(&dsidev->dev, "OMAP DSI rev %d.%d\n",
 	       FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
 
 	enable_clocks(0);
@@ -4115,7 +4205,7 @@ err1:
 	return r;
 }
 
-static void dsi_exit(void)
+static void dsi_exit(struct platform_device *dsidev)
 {
 	if (dsi.vdds_dsi_reg != NULL) {
 		if (dsi.vdds_dsi_enabled) {
@@ -4136,11 +4226,11 @@ static void dsi_exit(void)
 }
 
 /* DSI HW IP initialisation */
-static int omap_dsihw_probe(struct platform_device *pdev)
+static int omap_dsihw_probe(struct platform_device *dsidev)
 {
 	int r;
-	dsi.pdev = pdev;
-	r = dsi_init(pdev);
+	dsi.pdev = dsidev;
+	r = dsi_init(dsidev);
 	if (r) {
 		DSSERR("Failed to initialize DSI\n");
 		goto err_dsi;
@@ -4149,9 +4239,9 @@ err_dsi:
 	return r;
 }
 
-static int omap_dsihw_remove(struct platform_device *pdev)
+static int omap_dsihw_remove(struct platform_device *dsidev)
 {
-	dsi_exit();
+	dsi_exit(dsidev);
 	WARN_ON(dsi.scp_clk_refcount > 0);
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index c8cd83e..30f4c02 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -302,6 +302,7 @@ void dss_dump_regs(struct seq_file *s)
 
 void dss_select_dispc_clk_source(enum omap_dss_clk_source clk_src)
 {
+	struct platform_device *dsidev;
 	int b;
 	u8 start, end;
 
@@ -311,7 +312,8 @@ void dss_select_dispc_clk_source(enum omap_dss_clk_source clk_src)
 		break;
 	case OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC:
 		b = 1;
-		dsi_wait_pll_hsdiv_dispc_active();
+		dsidev = dsi_get_dsi_device_module(0);
+		dsi_wait_pll_hsdiv_dispc_active(dsidev);
 		break;
 	default:
 		BUG();
@@ -326,6 +328,7 @@ void dss_select_dispc_clk_source(enum omap_dss_clk_source clk_src)
 
 void dss_select_dsi_clk_source(enum omap_dss_clk_source clk_src)
 {
+	struct platform_device *dsidev;
 	int b;
 
 	switch (clk_src) {
@@ -334,7 +337,8 @@ void dss_select_dsi_clk_source(enum omap_dss_clk_source clk_src)
 		break;
 	case OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI:
 		b = 1;
-		dsi_wait_pll_hsdiv_dsi_active();
+		dsidev = dsi_get_dsi_device_module(0);
+		dsi_wait_pll_hsdiv_dsi_active(dsidev);
 		break;
 	default:
 		BUG();
@@ -348,6 +352,7 @@ void dss_select_dsi_clk_source(enum omap_dss_clk_source clk_src)
 void dss_select_lcd_clk_source(enum omap_channel channel,
 		enum omap_dss_clk_source clk_src)
 {
+	struct platform_device *dsidev;
 	int b, ix, pos;
 
 	if (!dss_has_feature(FEAT_LCD_CLK_SRC))
@@ -360,7 +365,8 @@ void dss_select_lcd_clk_source(enum omap_channel channel,
 	case OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC:
 		BUG_ON(channel != OMAP_DSS_CHANNEL_LCD);
 		b = 1;
-		dsi_wait_pll_hsdiv_dispc_active();
+		dsidev = dsi_get_dsi_device_module(0);
+		dsi_wait_pll_hsdiv_dispc_active(dsidev);
 		break;
 	default:
 		BUG();
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 40764e0..bca64f9 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -287,18 +287,21 @@ void dsi_restore_context(void);
 
 int dsi_init_display(struct omap_dss_device *display);
 void dsi_irq_handler(void);
-unsigned long dsi_get_pll_hsdiv_dispc_rate(void);
-int dsi_pll_set_clock_div(struct dsi_clock_info *cinfo);
-int dsi_pll_calc_clock_div_pck(bool is_tft, unsigned long req_pck,
-		struct dsi_clock_info *cinfo,
+unsigned long dsi_get_pll_hsdiv_dispc_rate(struct platform_device *dsidev);
+int dsi_pll_set_clock_div(struct platform_device *dsidev,
+		struct dsi_clock_info *cinfo);
+int dsi_pll_calc_clock_div_pck(struct platform_device *dsidev, bool is_tft,
+		unsigned long req_pck, struct dsi_clock_info *cinfo,
 		struct dispc_clock_info *dispc_cinfo);
-int dsi_pll_init(bool enable_hsclk, bool enable_hsdiv);
-void dsi_pll_uninit(bool disconnect_lanes);
+int dsi_pll_init(struct platform_device *dsidev, bool enable_hsclk,
+		bool enable_hsdiv);
+void dsi_pll_uninit(struct platform_device *dsidev, bool disconnect_lanes);
 void dsi_get_overlay_fifo_thresholds(enum omap_plane plane,
 		u32 fifo_size, enum omap_burst_size *burst_size,
 		u32 *fifo_low, u32 *fifo_high);
-void dsi_wait_pll_hsdiv_dispc_active(void);
-void dsi_wait_pll_hsdiv_dsi_active(void);
+void dsi_wait_pll_hsdiv_dispc_active(struct platform_device *dsidev);
+void dsi_wait_pll_hsdiv_dsi_active(struct platform_device *dsidev);
+struct platform_device *dsi_get_dsi_device_module(int  module);
 #else
 static inline int dsi_init_platform_driver(void)
 {
@@ -307,17 +310,23 @@ static inline int dsi_init_platform_driver(void)
 static inline void dsi_uninit_platform_driver(void)
 {
 }
-static inline unsigned long dsi_get_pll_hsdiv_dispc_rate(void)
+static inline unsigned long dsi_get_pll_hsdiv_dispc_rate(struct platform_device *dsidev)
 {
 	WARN("%s: DSI not compiled in, returning rate as 0\n", __func__);
 	return 0;
 }
-static inline void dsi_wait_pll_hsdiv_dispc_active(void)
+static inline void dsi_wait_pll_hsdiv_dispc_active(struct platform_device *dsidev)
 {
 }
-static inline void dsi_wait_pll_hsdiv_dsi_active(void)
+static inline void dsi_wait_pll_hsdiv_dsi_active(struct platform_device *dsidev)
 {
 }
+static inline struct platform_device *dsi_get_device_module(int module)
+{
+	WARN("%s: DSI not compiled in, returning platform device as NULL\n",
+			__func__);
+	return NULL;
+}
 #endif
 
 /* DPI */
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 5668fec..857162b 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -23,6 +23,7 @@
 #define MAX_DSS_MANAGERS	3
 #define MAX_DSS_OVERLAYS	3
 #define MAX_DSS_LCD_MANAGERS	2
+#define MAX_NUM_DSI		2
 
 /* DSS has feature id */
 enum dss_feat_id {
-- 
1.7.1

