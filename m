From: Archit Taneja <archit@ti.com>
Subject: [PATCH] OMAP: DSS2: Have separate irq handlers for DISPC and DSI
Date: Thu, 17 Feb 2011 19:55:02 +0530
Message-ID: <1297952702-13419-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59671 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751728Ab1BQOX4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 09:23:56 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1HENtU3025112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 08:23:55 -0600
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
hwmod databases. The Probes of DISPC and DSI now request for irq handlers. A dss
feature is also added to tell whether the irq lines is shared between DISPC and
DSI or not.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   13 +++----
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   12 +++---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   21 +++++++-----
 drivers/video/omap2/dss/dispc.c            |   39 ++++++++++++++++++++--
 drivers/video/omap2/dss/dsi.c              |   30 ++++++++++++++++-
 drivers/video/omap2/dss/dss.c              |   50 ++++-----------------------
 drivers/video/omap2/dss/dss.h              |    6 +++
 drivers/video/omap2/dss/dss_features.c     |    5 ++-
 drivers/video/omap2/dss/dss_features.h     |   17 +++++----
 9 files changed, 115 insertions(+), 78 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 21014de..028bcab 100644
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
index 1ef3f3f..777b1ca 100644
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
index cb0c624..a9b4857 100644
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
index cc58208..52a3c18 100644
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
 
@@ -2930,6 +2932,18 @@ void dispc_irq_handler(void)
 	spin_unlock(&dispc.irq_lock);
 }
 
+static irqreturn_t omap_dispc_irq_handler(int irq, void *arg)
+{
+	if (dss_has_feature(FEAT_COMMON_IRQ_DISPC_DSI)) {
+		if (!(dss_get_irq_source() & DSS_IRQ_SRC_DISPC))
+			return IRQ_HANDLED;
+	}
+
+	dispc_irq_handler();
+
+	return IRQ_HANDLED;
+}
+
 static void dispc_error_worker(struct work_struct *work)
 {
 	int i;
@@ -3322,6 +3336,7 @@ int dispc_setup_plane(enum omap_plane plane,
 static int omap_dispchw_probe(struct platform_device *pdev)
 {
 	u32 rev;
+	int r = 0;
 	struct resource *dispc_mem;
 
 	dispc.pdev = pdev;
@@ -3338,12 +3353,27 @@ static int omap_dispchw_probe(struct platform_device *pdev)
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
@@ -3359,12 +3389,15 @@ static int omap_dispchw_probe(struct platform_device *pdev)
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
index 1802057..3298169 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -38,6 +38,7 @@
 #include <plat/clock.h>
 
 #include "dss.h"
+#include "dss_features.h"
 
 /*#define VERBOSE_IRQ*/
 #define DSI_CATCH_MISSING_TE
@@ -222,6 +223,7 @@ static struct
 {
 	struct platform_device *pdev;
 	void __iomem	*base;
+	int irq;
 
 	struct dsi_clock_info current_cinfo;
 
@@ -580,7 +582,17 @@ void dsi_irq_handler(void)
 #endif
 }
 
+static irqreturn_t omap_dsi_irq_handler(int irq, void *arg)
+{
+	if (dss_has_feature(FEAT_COMMON_IRQ_DISPC_DSI)) {
+		if (!(dss_get_irq_source() & DSS_IRQ_SRC_DSI))
+			return IRQ_HANDLED;
+	}
 
+	dsi_irq_handler();
+
+	return IRQ_HANDLED;
+}
 static void _dsi_initialize_irq(void)
 {
 	u32 l;
@@ -3294,12 +3306,25 @@ static int dsi_init(struct platform_device *pdev)
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
@@ -3311,6 +3336,8 @@ static int dsi_init(struct platform_device *pdev)
 	enable_clocks(0);
 
 	return 0;
+err3:
+	free_irq(dsi.irq, NULL);
 err2:
 	iounmap(dsi.base);
 err1:
@@ -3326,6 +3353,7 @@ static void dsi_exit(void)
 		dsi.vdds_dsi_reg = NULL;
 	}
 
+	free_irq(dsi.irq, NULL);
 	iounmap(dsi.base);
 
 	destroy_workqueue(dsi.workqueue);
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index bf3c2ff..761fffb 100644
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
@@ -495,29 +493,19 @@ found:
 	return 0;
 }
 
-
-
-static irqreturn_t dss_irq_handler_omap2(int irq, void *arg)
+enum dss_irq_source dss_get_irq_source(void)
 {
-	dispc_irq_handler();
-
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t dss_irq_handler_omap3(int irq, void *arg)
-{
-	u32 irqstatus;
+	u32 irqstatus, irq_source = 0;
 
 	irqstatus = dss_read_reg(DSS_IRQSTATUS);
 
-	if (irqstatus & (1<<0))	/* DISPC_IRQ */
-		dispc_irq_handler();
+	if (irqstatus & (1 << 0))	/* DISPC_IRQ */
+		irq_source |= DSS_IRQ_SRC_DISPC;
 #ifdef CONFIG_OMAP2_DSS_DSI
-	if (irqstatus & (1<<1))	/* DSI_IRQ */
-		dsi_irq_handler();
+	if (irqstatus & (1 << 1))	/* DSI_IRQ */
+		irq_source |= DSS_IRQ_SRC_DSI;
 #endif
-
-	return IRQ_HANDLED;
+	return irq_source;
 }
 
 static int _omap_dss_wait_reset(void)
@@ -610,30 +598,12 @@ static int dss_init(bool skip_init)
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
 
@@ -648,8 +618,6 @@ static int dss_init(bool skip_init)
 
 	return 0;
 
-fail2:
-	free_irq(dss.dss_irq, NULL);
 fail1:
 	iounmap(dss.base);
 fail0:
@@ -661,8 +629,6 @@ static void dss_exit(void)
 	if (cpu_is_omap34xx())
 		clk_put(dss.dpll4_m4_ck);
 
-	free_irq(dss.dss_irq, NULL);
-
 	iounmap(dss.base);
 }
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 4b02e07..ecf9ebf 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -125,6 +125,11 @@ enum dss_clk_source {
 	DSS_SRC_DSS1_ALWON_FCLK,
 };
 
+enum dss_irq_source {
+	DSS_IRQ_SRC_DISPC	= 1 << 0,
+	DSS_IRQ_SRC_DSI		= 1 << 1,
+};
+
 struct dss_clock_info {
 	/* rates that we get with dividers below */
 	unsigned long fck;
@@ -243,6 +248,7 @@ int dss_get_clock_div(struct dss_clock_info *cinfo);
 int dss_calc_clock_div(bool is_tft, unsigned long req_pck,
 		struct dss_clock_info *dss_cinfo,
 		struct dispc_clock_info *dispc_cinfo);
+enum dss_irq_source dss_get_irq_source(void);
 
 /* SDI */
 #ifdef CONFIG_OMAP2_DSS_SDI
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index cf3ef69..f3ef929 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -157,7 +157,7 @@ static struct omap_dss_features omap3430_dss_features = {
 	.has_feature	=
 		FEAT_GLOBAL_ALPHA | FEAT_LCDENABLEPOL |
 		FEAT_LCDENABLESIGNAL | FEAT_PCKFREEENABLE |
-		FEAT_FUNCGATED,
+		FEAT_FUNCGATED | FEAT_COMMON_IRQ_DISPC_DSI,
 
 	.num_mgrs = 2,
 	.num_ovls = 3,
@@ -172,7 +172,8 @@ static struct omap_dss_features omap3630_dss_features = {
 	.has_feature    =
 		FEAT_GLOBAL_ALPHA | FEAT_LCDENABLEPOL |
 		FEAT_LCDENABLESIGNAL | FEAT_PCKFREEENABLE |
-		FEAT_PRE_MULT_ALPHA | FEAT_FUNCGATED,
+		FEAT_PRE_MULT_ALPHA | FEAT_FUNCGATED |
+		FEAT_COMMON_IRQ_DISPC_DSI,
 
 	.num_mgrs = 2,
 	.num_ovls = 3,
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index b9c70be..1c93a49 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -25,14 +25,15 @@
 
 /* DSS has feature id */
 enum dss_feat_id {
-	FEAT_GLOBAL_ALPHA	= 1 << 0,
-	FEAT_GLOBAL_ALPHA_VID1	= 1 << 1,
-	FEAT_PRE_MULT_ALPHA	= 1 << 2,
-	FEAT_LCDENABLEPOL	= 1 << 3,
-	FEAT_LCDENABLESIGNAL	= 1 << 4,
-	FEAT_PCKFREEENABLE	= 1 << 5,
-	FEAT_FUNCGATED		= 1 << 6,
-	FEAT_MGR_LCD2		= 1 << 7,
+	FEAT_GLOBAL_ALPHA		= 1 << 0,
+	FEAT_GLOBAL_ALPHA_VID1		= 1 << 1,
+	FEAT_PRE_MULT_ALPHA		= 1 << 2,
+	FEAT_LCDENABLEPOL		= 1 << 3,
+	FEAT_LCDENABLESIGNAL		= 1 << 4,
+	FEAT_PCKFREEENABLE		= 1 << 5,
+	FEAT_FUNCGATED			= 1 << 6,
+	FEAT_MGR_LCD2			= 1 << 7,
+	FEAT_COMMON_IRQ_DISPC_DSI	= 1 << 8,
 };
 
 /* DSS register field id */
-- 
1.7.1

