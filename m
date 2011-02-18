From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2] OMAP: DSS2: Have separate irq handlers for DISPC and DSI
Date: Fri, 18 Feb 2011 16:51:48 +0530
Message-ID: <1298028108-20224-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40637 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752714Ab1BRLUf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 06:20:35 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1IBKZej007953
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 05:20:35 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, Archit Taneja <archit@ti.com>

Currently, the core DSS platform device requests for an irq line for OMAP2 and
OMAP3. Make DISPC and DSI platform devices request for a shared IRQ line.

On OMAP3, the logical OR of DSI and DISPC interrupt lines goes to the MPU. There
is a register DSS_IRQSTATUS which tells if the interrupt came from DISPC or DSI.

On OMAP2, there is no DSI, only DISPC interrupts goto the MPU. There is no
DSS_IRQSTATUS register.

Hence, it makes more sense to have separate irq handlers corresponding to the
DSS sub modules instead of having a common handler.

Since on OMAP3 the logical OR of the lines goes to MPU, the irq line is shared
among the IRQ handlers.

The hwmod irq info has been removed for DSS to DISPC and DSI for OMAP2 and OMAP3
hwmod databases. The Probes of DISPC and DSI now request for irq handlers.

Signed-off-by: Archit Taneja <archit@ti.com>
---
v2: Removed checking with DSS_IRQSTATUS.

Tested on 3430sdp with sharp ls panel and 3430sdp with a Taal panel.

 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   13 +++----
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   12 +++---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   21 ++++++-----
 drivers/video/omap2/dss/dispc.c            |   37 ++++++++++++++++++--
 drivers/video/omap2/dss/dsi.c              |   27 +++++++++++++--
 drivers/video/omap2/dss/dss.c              |   51 +---------------------------
 6 files changed, 82 insertions(+), 79 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 21014de..085d053 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -506,11 +506,6 @@ static struct omap_hwmod_class omap2420_dss_hwmod_class = {
 	.sysc = &omap2420_dss_sysc,
 };
 
-/* dss */
-static struct omap_hwmod_irq_info omap2420_dss_irqs[] = {
-	{ .irq = 25 },
-};
-
 static struct omap_hwmod_dma_info omap2420_dss_sdma_chs[] = {
 	{ .name = "dispc", .dma_req = 5 },
 };
@@ -559,8 +554,6 @@ static struct omap_hwmod omap2420_dss_core_hwmod = {
 	.name		= "dss_core",
 	.class		= &omap2420_dss_hwmod_class,
 	.main_clk	= "dss1_fck", /* instead of dss_fck */
-	.mpu_irqs	= omap2420_dss_irqs,
-	.mpu_irqs_cnt	= ARRAY_SIZE(omap2420_dss_irqs),
 	.sdma_reqs	= omap2420_dss_sdma_chs,
 	.sdma_reqs_cnt	= ARRAY_SIZE(omap2420_dss_sdma_chs),
 	.prcm		= {
@@ -603,6 +596,10 @@ static struct omap_hwmod_class omap2420_dispc_hwmod_class = {
 	.sysc = &omap2420_dispc_sysc,
 };
 
+static struct omap_hwmod_irq_info omap2420_dispc_irqs[] = {
+	{ .irq = 25 },
+};
+
 static struct omap_hwmod_addr_space omap2420_dss_dispc_addrs[] = {
 	{
 		.pa_start	= 0x48050400,
@@ -635,6 +632,8 @@ static struct omap_hwmod_ocp_if *omap2420_dss_dispc_slaves[] = {
 static struct omap_hwmod omap2420_dss_dispc_hwmod = {
 	.name		= "dss_dispc",
 	.class		= &omap2420_dispc_hwmod_class,
+	.mpu_irqs	= omap2420_dispc_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2420_dispc_irqs),
 	.main_clk	= "dss1_fck",
 	.prcm		= {
 		.omap2 = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 1ef3f3f..f486df8 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -505,10 +505,6 @@ static struct omap_hwmod_class omap2430_dss_hwmod_class = {
 	.sysc = &omap2430_dss_sysc,
 };
 
-/* dss */
-static struct omap_hwmod_irq_info omap2430_dss_irqs[] = {
-	{ .irq = 25 },
-};
 static struct omap_hwmod_dma_info omap2430_dss_sdma_chs[] = {
 	{ .name = "dispc", .dma_req = 5 },
 };
@@ -551,8 +547,6 @@ static struct omap_hwmod omap2430_dss_core_hwmod = {
 	.name		= "dss_core",
 	.class		= &omap2430_dss_hwmod_class,
 	.main_clk	= "dss1_fck", /* instead of dss_fck */
-	.mpu_irqs	= omap2430_dss_irqs,
-	.mpu_irqs_cnt	= ARRAY_SIZE(omap2430_dss_irqs),
 	.sdma_reqs	= omap2430_dss_sdma_chs,
 	.sdma_reqs_cnt	= ARRAY_SIZE(omap2430_dss_sdma_chs),
 	.prcm		= {
@@ -595,6 +589,10 @@ static struct omap_hwmod_class omap2430_dispc_hwmod_class = {
 	.sysc = &omap2430_dispc_sysc,
 };
 
+static struct omap_hwmod_irq_info omap2430_dispc_irqs[] = {
+	{ .irq = 25 },
+};
+
 static struct omap_hwmod_addr_space omap2430_dss_dispc_addrs[] = {
 	{
 		.pa_start	= 0x48050400,
@@ -621,6 +619,8 @@ static struct omap_hwmod_ocp_if *omap2430_dss_dispc_slaves[] = {
 static struct omap_hwmod omap2430_dss_dispc_hwmod = {
 	.name		= "dss_dispc",
 	.class		= &omap2430_dispc_hwmod_class,
+	.mpu_irqs	= omap2430_dispc_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2430_dispc_irqs),
 	.main_clk	= "dss1_fck",
 	.prcm		= {
 		.omap2 = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index cb0c624..3d8238d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -702,11 +702,6 @@ static struct omap_hwmod_class omap3xxx_dss_hwmod_class = {
 	.sysc = &omap3xxx_dss_sysc,
 };
 
-/* dss */
-static struct omap_hwmod_irq_info omap3xxx_dss_irqs[] = {
-	{ .irq = 25 },
-};
-
 static struct omap_hwmod_dma_info omap3xxx_dss_sdma_chs[] = {
 	{ .name = "dispc", .dma_req = 5 },
 	{ .name = "dsi1", .dma_req = 74 },
@@ -778,8 +773,6 @@ static struct omap_hwmod omap3430es1_dss_core_hwmod = {
 	.name		= "dss_core",
 	.class		= &omap3xxx_dss_hwmod_class,
 	.main_clk	= "dss1_alwon_fck", /* instead of dss_fck */
-	.mpu_irqs	= omap3xxx_dss_irqs,
-	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_dss_irqs),
 	.sdma_reqs	= omap3xxx_dss_sdma_chs,
 	.sdma_reqs_cnt	= ARRAY_SIZE(omap3xxx_dss_sdma_chs),
 
@@ -806,8 +799,6 @@ static struct omap_hwmod omap3xxx_dss_core_hwmod = {
 	.name		= "dss_core",
 	.class		= &omap3xxx_dss_hwmod_class,
 	.main_clk	= "dss1_alwon_fck", /* instead of dss_fck */
-	.mpu_irqs	= omap3xxx_dss_irqs,
-	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_dss_irqs),
 	.sdma_reqs	= omap3xxx_dss_sdma_chs,
 	.sdma_reqs_cnt	= ARRAY_SIZE(omap3xxx_dss_sdma_chs),
 
@@ -853,6 +844,10 @@ static struct omap_hwmod_class omap3xxx_dispc_hwmod_class = {
 	.sysc = &omap3xxx_dispc_sysc,
 };
 
+static struct omap_hwmod_irq_info omap3xxx_dispc_irqs[] = {
+	{ .irq = 25 },
+};
+
 static struct omap_hwmod_addr_space omap3xxx_dss_dispc_addrs[] = {
 	{
 		.pa_start	= 0x48050400,
@@ -886,6 +881,8 @@ static struct omap_hwmod_ocp_if *omap3xxx_dss_dispc_slaves[] = {
 static struct omap_hwmod omap3xxx_dss_dispc_hwmod = {
 	.name		= "dss_dispc",
 	.class		= &omap3xxx_dispc_hwmod_class,
+	.mpu_irqs	= omap3xxx_dispc_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_dispc_irqs),
 	.main_clk	= "dss1_alwon_fck",
 	.prcm		= {
 		.omap2 = {
@@ -911,6 +908,10 @@ static struct omap_hwmod_class omap3xxx_dsi_hwmod_class = {
 	.name = "dsi",
 };
 
+static struct omap_hwmod_irq_info omap3xxx_dsi1_irqs[] = {
+	{ .irq = 25 },
+};
+
 /* dss_dsi1 */
 static struct omap_hwmod_addr_space omap3xxx_dss_dsi1_addrs[] = {
 	{
@@ -944,6 +945,8 @@ static struct omap_hwmod_ocp_if *omap3xxx_dss_dsi1_slaves[] = {
 static struct omap_hwmod omap3xxx_dss_dsi1_hwmod = {
 	.name		= "dss_dsi1",
 	.class		= &omap3xxx_dsi_hwmod_class,
+	.mpu_irqs	= omap3xxx_dsi1_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_dsi1_irqs),
 	.main_clk	= "dss1_alwon_fck",
 	.prcm		= {
 		.omap2 = {
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index cc58208..8e308ab 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -32,6 +32,7 @@
 #include <linux/delay.h>
 #include <linux/workqueue.h>
 #include <linux/hardirq.h>
+#include <linux/interrupt.h>
 
 #include <plat/sram.h>
 #include <plat/clock.h>
@@ -178,6 +179,7 @@ struct dispc_irq_stats {
 static struct {
 	struct platform_device *pdev;
 	void __iomem    *base;
+	int irq;
 
 	u32	fifo_size[3];
 
@@ -2865,7 +2867,7 @@ static void print_irq_status(u32 status)
  * but we presume they are on because we got an IRQ. However,
  * an irq handler may turn the clocks off, so we may not have
  * clock later in the function. */
-void dispc_irq_handler(void)
+static irqreturn_t omap_dispc_irq_handler(int irq, void *arg)
 {
 	int i;
 	u32 irqstatus;
@@ -2878,6 +2880,12 @@ void dispc_irq_handler(void)
 
 	irqstatus = dispc_read_reg(DISPC_IRQSTATUS);
 
+	/* IRQ is not for us */
+	if (!irqstatus) {
+		spin_unlock(&dispc.irq_lock);
+		return IRQ_HANDLED;
+	}
+
 #ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
 	spin_lock(&dispc.irq_stats_lock);
 	dispc.irq_stats.irq_count++;
@@ -2928,6 +2936,8 @@ void dispc_irq_handler(void)
 	}
 
 	spin_unlock(&dispc.irq_lock);
+
+	return IRQ_HANDLED;
 }
 
 static void dispc_error_worker(struct work_struct *work)
@@ -3322,6 +3332,7 @@ int dispc_setup_plane(enum omap_plane plane,
 static int omap_dispchw_probe(struct platform_device *pdev)
 {
 	u32 rev;
+	int r = 0;
 	struct resource *dispc_mem;
 
 	dispc.pdev = pdev;
@@ -3338,12 +3349,27 @@ static int omap_dispchw_probe(struct platform_device *pdev)
 	dispc_mem = platform_get_resource(dispc.pdev, IORESOURCE_MEM, 0);
 	if (!dispc_mem) {
 		DSSERR("can't get IORESOURCE_MEM DISPC\n");
-		return -EINVAL;
+		r = -EINVAL;
+		goto fail0;
 	}
 	dispc.base = ioremap(dispc_mem->start, resource_size(dispc_mem));
 	if (!dispc.base) {
 		DSSERR("can't ioremap DISPC\n");
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto fail0;
+	}
+	dispc.irq = platform_get_irq(dispc.pdev, 0);
+	if (dispc.irq < 0) {
+		DSSERR("omap2 dispc: platform_get_irq failed\n");
+		r = -ENODEV;
+		goto fail1;
+	}
+
+	r = request_irq(dispc.irq, omap_dispc_irq_handler, IRQF_SHARED,
+		"OMAP DISPC", dispc.pdev);
+	if (r < 0) {
+		DSSERR("omap2 dispc: request_irq failed\n");
+		goto fail1;
 	}
 
 	enable_clocks(1);
@@ -3359,12 +3385,15 @@ static int omap_dispchw_probe(struct platform_device *pdev)
 	       FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
 
 	enable_clocks(0);
-
+fail1:
+	iounmap(dispc.base);
+fail0:
 	return 0;
 }
 
 static int omap_dispchw_remove(struct platform_device *pdev)
 {
+	free_irq(dispc.irq, NULL);
 	iounmap(dispc.base);
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 1802057..a68f4ea 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -222,6 +222,7 @@ static struct
 {
 	struct platform_device *pdev;
 	void __iomem	*base;
+	int irq;
 
 	struct dsi_clock_info current_cinfo;
 
@@ -494,13 +495,17 @@ static void print_irq_status_cio(u32 status)
 static int debug_irq;
 
 /* called from dss */
-void dsi_irq_handler(void)
+static irqreturn_t omap_dsi_irq_handler(int irq, void *arg)
 {
 	u32 irqstatus, vcstatus, ciostatus;
 	int i;
 
 	irqstatus = dsi_read_reg(DSI_IRQSTATUS);
 
+	/* IRQ is not for us */
+	if (!irqstatus)
+		return IRQ_HANDLED;
+
 #ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
 	spin_lock(&dsi.irq_stats_lock);
 	dsi.irq_stats.irq_count++;
@@ -578,9 +583,9 @@ void dsi_irq_handler(void)
 #ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
 	spin_unlock(&dsi.irq_stats_lock);
 #endif
+	return IRQ_HANDLED;
 }
 
-
 static void _dsi_initialize_irq(void)
 {
 	u32 l;
@@ -3294,12 +3299,25 @@ static int dsi_init(struct platform_device *pdev)
 		r = -ENOMEM;
 		goto err1;
 	}
+	dsi.irq	= platform_get_irq(dsi.pdev, 0);
+	if (dsi.irq < 0) {
+		DSSERR("omap2 dsi: platform_get_irq failed\n");
+		r = -ENODEV;
+		goto err2;
+	}
+
+	r = request_irq(dsi.irq, omap_dsi_irq_handler, IRQF_SHARED,
+		"OMAP DSI1", dsi.pdev);
+	if (r < 0) {
+		DSSERR("omap2 dsi: request_irq failed\n");
+		goto err2;
+	}
 
 	dsi.vdds_dsi_reg = dsi_get_vdds_dsi();
 	if (IS_ERR(dsi.vdds_dsi_reg)) {
 		DSSERR("can't get VDDS_DSI regulator\n");
 		r = PTR_ERR(dsi.vdds_dsi_reg);
-		goto err2;
+		goto err3;
 	}
 
 	enable_clocks(1);
@@ -3311,6 +3329,8 @@ static int dsi_init(struct platform_device *pdev)
 	enable_clocks(0);
 
 	return 0;
+err3:
+	free_irq(dsi.irq, NULL);
 err2:
 	iounmap(dsi.base);
 err1:
@@ -3326,6 +3346,7 @@ static void dsi_exit(void)
 		dsi.vdds_dsi_reg = NULL;
 	}
 
+	free_irq(dsi.irq, NULL);
 	iounmap(dsi.base);
 
 	destroy_workqueue(dsi.workqueue);
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index bf3c2ff..5a93e66 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -26,7 +26,6 @@
 #include <linux/io.h>
 #include <linux/err.h>
 #include <linux/delay.h>
-#include <linux/interrupt.h>
 #include <linux/seq_file.h>
 #include <linux/clk.h>
 
@@ -79,7 +78,6 @@ static struct {
 	enum dss_clk_source dispc_clk_source;
 
 	u32		ctx[DSS_SZ_REGS / sizeof(u32)];
-	int		dss_irq;
 } dss;
 
 static void dss_clk_enable_all_no_ctx(void);
@@ -495,31 +493,6 @@ found:
 	return 0;
 }
 
-
-
-static irqreturn_t dss_irq_handler_omap2(int irq, void *arg)
-{
-	dispc_irq_handler();
-
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t dss_irq_handler_omap3(int irq, void *arg)
-{
-	u32 irqstatus;
-
-	irqstatus = dss_read_reg(DSS_IRQSTATUS);
-
-	if (irqstatus & (1<<0))	/* DISPC_IRQ */
-		dispc_irq_handler();
-#ifdef CONFIG_OMAP2_DSS_DSI
-	if (irqstatus & (1<<1))	/* DSI_IRQ */
-		dsi_irq_handler();
-#endif
-
-	return IRQ_HANDLED;
-}
-
 static int _omap_dss_wait_reset(void)
 {
 	int t = 0;
@@ -610,30 +583,12 @@ static int dss_init(bool skip_init)
 	REG_FLD_MOD(DSS_CONTROL, 0, 2, 2);	/* venc clock mode = normal */
 #endif
 
-	dss.dss_irq = platform_get_irq(dss.pdev, 0);
-	if (dss.dss_irq < 0) {
-		DSSERR("omap2 dss: platform_get_irq failed\n");
-		r = -ENODEV;
-		goto fail1;
-	}
-
-	r = request_irq(dss.dss_irq,
-		cpu_is_omap24xx()
-		? dss_irq_handler_omap2
-		: dss_irq_handler_omap3,
-		0, "OMAP DSS", NULL);
-
-	if (r < 0) {
-		DSSERR("omap2 dss: request_irq failed\n");
-		goto fail1;
-	}
-
 	if (cpu_is_omap34xx()) {
 		dss.dpll4_m4_ck = clk_get(NULL, "dpll4_m4_ck");
 		if (IS_ERR(dss.dpll4_m4_ck)) {
 			DSSERR("Failed to get dpll4_m4_ck\n");
 			r = PTR_ERR(dss.dpll4_m4_ck);
-			goto fail2;
+			goto fail1;
 		}
 	}
 
@@ -648,8 +603,6 @@ static int dss_init(bool skip_init)
 
 	return 0;
 
-fail2:
-	free_irq(dss.dss_irq, NULL);
 fail1:
 	iounmap(dss.base);
 fail0:
@@ -661,8 +614,6 @@ static void dss_exit(void)
 	if (cpu_is_omap34xx())
 		clk_put(dss.dpll4_m4_ck);
 
-	free_irq(dss.dss_irq, NULL);
-
 	iounmap(dss.base);
 }
 
-- 
1.7.1

