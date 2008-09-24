From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/5] ARM: OMAP: Allocate McBSP devices dynamically
Date: Wed, 24 Sep 2008 16:29:12 +0300
Message-ID: <1222262955-13599-3-git-send-email-tony@atomide.com>
References: <1222262955-13599-1-git-send-email-tony@atomide.com>
 <1222262955-13599-2-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61791 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435AbYIXN3i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 09:29:38 -0400
In-Reply-To: <1222262955-13599-2-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Chandra Shekhar <x0044955@ti.com>, Tony Lindgren <tony@atomide.com>

From: Chandra Shekhar <x0044955@ti.com>

Based on Chandra's earlier patches in linux-omap tree.

Note that omap1_mcbsp_check and omap2_mcbsp_check are no longer
needed as there's now omap_mcbsp_check_valid_id() defined.

Also some functions can now be marked __init.

Signed-off-by: Chandra Shekhar <x0044955@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/mcbsp.c             |   37 +--
 arch/arm/mach-omap2/mcbsp.c             |   28 +--
 arch/arm/plat-omap/include/mach/mcbsp.h |   33 ++-
 arch/arm/plat-omap/mcbsp.c              |  388 ++++++++++++++++++-------------
 4 files changed, 270 insertions(+), 216 deletions(-)

diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
index afb5789..7de7c69 100644
--- a/arch/arm/mach-omap1/mcbsp.c
+++ b/arch/arm/mach-omap1/mcbsp.c
@@ -103,30 +103,6 @@ static inline void omap_mcbsp_clk_init(struct mcbsp_internal_clk *mclk)
 { }
 #endif
 
-static int omap1_mcbsp_check(unsigned int id)
-{
-	/* REVISIT: Check correctly for number of registered McBSPs */
-	if (cpu_is_omap730()) {
-		if (id > OMAP_MAX_MCBSP_COUNT - 2) {
-		       printk(KERN_ERR "OMAP-McBSP: McBSP%d doesn't exist\n",
-				id + 1);
-		       return -ENODEV;
-		}
-		return 0;
-	}
-
-	if (cpu_is_omap15xx() || cpu_is_omap16xx()) {
-		if (id > OMAP_MAX_MCBSP_COUNT - 1) {
-			printk(KERN_ERR "OMAP-McBSP: McBSP%d doesn't exist\n",
-				id + 1);
-			return -ENODEV;
-		}
-		return 0;
-	}
-
-	return -ENODEV;
-}
-
 static void omap1_mcbsp_request(unsigned int id)
 {
 	/*
@@ -151,7 +127,6 @@ static void omap1_mcbsp_free(unsigned int id)
 }
 
 static struct omap_mcbsp_ops omap1_mcbsp_ops = {
-	.check		= omap1_mcbsp_check,
 	.request	= omap1_mcbsp_request,
 	.free		= omap1_mcbsp_free,
 };
@@ -263,6 +238,18 @@ int __init omap1_mcbsp_init(void)
 	}
 
 	if (cpu_is_omap730())
+		omap_mcbsp_count = OMAP730_MCBSP_PDATA_SZ;
+	if (cpu_is_omap15xx())
+		omap_mcbsp_count = OMAP15XX_MCBSP_PDATA_SZ;
+	if (cpu_is_omap16xx())
+		omap_mcbsp_count = OMAP16XX_MCBSP_PDATA_SZ;
+
+	mcbsp_ptr = kzalloc(omap_mcbsp_count * sizeof(struct omap_mcbsp *),
+								GFP_KERNEL);
+	if (!mcbsp_ptr)
+		return -ENOMEM;
+
+	if (cpu_is_omap730())
 		omap_mcbsp_register_board_cfg(omap730_mcbsp_pdata,
 						OMAP730_MCBSP_PDATA_SZ);
 
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 709db03..73f2279 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -28,7 +28,7 @@ struct mcbsp_internal_clk {
 	int n_childs;
 };
 
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX)
 static void omap_mcbsp_clk_init(struct mcbsp_internal_clk *mclk)
 {
 	const char *clk_names[] = { "mcbsp_ick", "mcbsp_fck" };
@@ -117,18 +117,8 @@ static void omap2_mcbsp_request(unsigned int id)
 		omap2_mcbsp2_mux_setup();
 }
 
-static int omap2_mcbsp_check(unsigned int id)
-{
-	if (id > OMAP_MAX_MCBSP_COUNT - 1) {
-		printk(KERN_ERR "OMAP-McBSP: McBSP%d doesn't exist\n", id + 1);
-		return -ENODEV;
-	}
-	return 0;
-}
-
 static struct omap_mcbsp_ops omap2_mcbsp_ops = {
 	.request	= omap2_mcbsp_request,
-	.check		= omap2_mcbsp_check,
 };
 
 #ifdef CONFIG_ARCH_OMAP24XX
@@ -185,7 +175,7 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 #define OMAP34XX_MCBSP_PDATA_SZ		0
 #endif
 
-int __init omap2_mcbsp_init(void)
+static int __init omap2_mcbsp_init(void)
 {
 	int i;
 
@@ -196,13 +186,19 @@ int __init omap2_mcbsp_init(void)
 	}
 
 	if (cpu_is_omap24xx())
+		omap_mcbsp_count = OMAP24XX_MCBSP_PDATA_SZ;
+	if (cpu_is_omap34xx())
+		omap_mcbsp_count = OMAP34XX_MCBSP_PDATA_SZ;
+
+	mcbsp_ptr = kzalloc(omap_mcbsp_count * sizeof(struct omap_mcbsp *),
+								GFP_KERNEL);
+	if (!mcbsp_ptr)
+		return -ENOMEM;
+
+	if (cpu_is_omap24xx())
 		omap_mcbsp_register_board_cfg(omap24xx_mcbsp_pdata,
 						OMAP24XX_MCBSP_PDATA_SZ);
 
-	if (cpu_is_omap34xx())
-		omap_mcbsp_register_board_cfg(omap34xx_mcbsp_pdata,
-						OMAP34XX_MCBSP_PDATA_SZ);
-
 	return omap_mcbsp_init();
 }
 arch_initcall(omap2_mcbsp_init);
diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index a3074f2..46898fa 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -81,9 +81,6 @@
 #define OMAP_MCBSP_REG_XCERG	0x3A
 #define OMAP_MCBSP_REG_XCERH	0x3C
 
-#define OMAP_MAX_MCBSP_COUNT	3
-#define MAX_MCBSP_CLOCKS	3
-
 #define AUDIO_MCBSP_DATAWRITE	(OMAP1510_MCBSP1_BASE + OMAP_MCBSP_REG_DXR1)
 #define AUDIO_MCBSP_DATAREAD	(OMAP1510_MCBSP1_BASE + OMAP_MCBSP_REG_DRR1)
 
@@ -91,12 +88,14 @@
 #define AUDIO_DMA_TX		OMAP_DMA_MCBSP1_TX
 #define AUDIO_DMA_RX		OMAP_DMA_MCBSP1_RX
 
-#elif defined(CONFIG_ARCH_OMAP24XX)
+#elif defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 
 #define OMAP_MCBSP_REG_DRR2	0x00
 #define OMAP_MCBSP_REG_DRR1	0x04
 #define OMAP_MCBSP_REG_DXR2	0x08
 #define OMAP_MCBSP_REG_DXR1	0x0C
+#define OMAP_MCBSP_REG_DRR	0x00
+#define OMAP_MCBSP_REG_DXR	0x08
 #define OMAP_MCBSP_REG_SPCR2	0x10
 #define OMAP_MCBSP_REG_SPCR1	0x14
 #define OMAP_MCBSP_REG_RCR2	0x18
@@ -124,9 +123,9 @@
 #define OMAP_MCBSP_REG_RCERH	0x70
 #define OMAP_MCBSP_REG_XCERG	0x74
 #define OMAP_MCBSP_REG_XCERH	0x78
-
-#define OMAP_MAX_MCBSP_COUNT	2
-#define MAX_MCBSP_CLOCKS	2
+#define OMAP_MCBSP_REG_SYSCON	0x8C
+#define OMAP_MCBSP_REG_XCCR	0xAC
+#define OMAP_MCBSP_REG_RCCR	0xB0
 
 #define AUDIO_MCBSP_DATAWRITE	(OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DXR1)
 #define AUDIO_MCBSP_DATAREAD	(OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DRR1)
@@ -137,10 +136,6 @@
 
 #endif
 
-#define OMAP_MCBSP_READ(base, reg)		__raw_readw((base) + OMAP_MCBSP_REG_##reg)
-#define OMAP_MCBSP_WRITE(base, reg, val)	__raw_writew((val), (base) + OMAP_MCBSP_REG_##reg)
-
-
 /************************** McBSP SPCR1 bit definitions ***********************/
 #define RRST			0x0001
 #define RRDY			0x0002
@@ -151,6 +146,7 @@
 #define DXENA			0x0080
 #define CLKSTP(value)		((value)<<11)	/* bits 11:12 */
 #define RJUST(value)		((value)<<13)	/* bits 13:14 */
+#define ALB			0x8000
 #define DLB			0x8000
 
 /************************** McBSP SPCR2 bit definitions ***********************/
@@ -228,6 +224,17 @@
 #define XPABLK(value)		((value)<<5)	/* Bits 5:6 */
 #define XPBBLK(value)		((value)<<7)	/* Bits 7:8 */
 
+/*********************** McBSP XCCR bit definitions *************************/
+#define DILB			0x0020
+#define XDMAEN			0x0008
+#define XDISABLE		0x0001
+
+/********************** McBSP RCCR bit definitions *************************/
+#define RDMAEN			0x0008
+#define RDISABLE		0x0001
+
+/********************** McBSP SYSCONFIG bit definitions ********************/
+#define SOFTRST			0x0002
 
 /* we don't do multichannel for now */
 struct omap_mcbsp_reg_cfg {
@@ -311,7 +318,6 @@ struct omap_mcbsp_spi_cfg {
 struct omap_mcbsp_ops {
 	void (*request)(unsigned int);
 	void (*free)(unsigned int);
-	int (*check)(unsigned int);
 };
 
 struct omap_mcbsp_platform_data {
@@ -353,6 +359,8 @@ struct omap_mcbsp {
 	struct omap_mcbsp_platform_data *pdata;
 	struct clk *clk;
 };
+extern struct omap_mcbsp **mcbsp_ptr;
+extern int omap_mcbsp_count;
 
 int omap_mcbsp_init(void);
 void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data *config,
@@ -377,5 +385,6 @@ void omap_mcbsp_set_spi_mode(unsigned int id, const struct omap_mcbsp_spi_cfg *
 /* Polled read/write functions */
 int omap_mcbsp_pollread(unsigned int id, u16 * buf);
 int omap_mcbsp_pollwrite(unsigned int id, u16 buf);
+int omap_mcbsp_set_io_type(unsigned int id, omap_mcbsp_io_type_t io_type);
 
 #endif
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index e0803a8..f27e641 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -27,43 +27,65 @@
 #include <mach/dma.h>
 #include <mach/mcbsp.h>
 
-static struct omap_mcbsp mcbsp[OMAP_MAX_MCBSP_COUNT];
+struct omap_mcbsp **mcbsp_ptr;
+int omap_mcbsp_count;
 
-#define omap_mcbsp_check_valid_id(id)	(mcbsp[id].pdata && \
-					mcbsp[id].pdata->ops && \
-					mcbsp[id].pdata->ops->check && \
-					(mcbsp[id].pdata->ops->check(id) == 0))
+void omap_mcbsp_write(void __iomem *io_base, u16 reg, u32 val)
+{
+	if (cpu_class_is_omap1() || cpu_is_omap2420())
+		__raw_writew((u16)val, io_base + reg);
+	else
+		__raw_writel(val, io_base + reg);
+}
+
+int omap_mcbsp_read(void __iomem *io_base, u16 reg)
+{
+	if (cpu_class_is_omap1() || cpu_is_omap2420())
+		return __raw_readw(io_base + reg);
+	else
+		return __raw_readl(io_base + reg);
+}
+
+#define OMAP_MCBSP_READ(base, reg) \
+			omap_mcbsp_read(base, OMAP_MCBSP_REG_##reg)
+#define OMAP_MCBSP_WRITE(base, reg, val) \
+			omap_mcbsp_write(base, OMAP_MCBSP_REG_##reg, val)
+
+#define omap_mcbsp_check_valid_id(id)	(id < omap_mcbsp_count)
+#define id_to_mcbsp_ptr(id)		mcbsp_ptr[id];
 
 static void omap_mcbsp_dump_reg(u8 id)
 {
-	dev_dbg(mcbsp[id].dev, "**** McBSP%d regs ****\n", mcbsp[id].id);
-	dev_dbg(mcbsp[id].dev, "DRR2:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp[id].io_base, DRR2));
-	dev_dbg(mcbsp[id].dev, "DRR1:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp[id].io_base, DRR1));
-	dev_dbg(mcbsp[id].dev, "DXR2:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp[id].io_base, DXR2));
-	dev_dbg(mcbsp[id].dev, "DXR1:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp[id].io_base, DXR1));
-	dev_dbg(mcbsp[id].dev, "SPCR2: 0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp[id].io_base, SPCR2));
-	dev_dbg(mcbsp[id].dev, "SPCR1: 0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp[id].io_base, SPCR1));
-	dev_dbg(mcbsp[id].dev, "RCR2:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp[id].io_base, RCR2));
-	dev_dbg(mcbsp[id].dev, "RCR1:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp[id].io_base, RCR1));
-	dev_dbg(mcbsp[id].dev, "XCR2:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp[id].io_base, XCR2));
-	dev_dbg(mcbsp[id].dev, "XCR1:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp[id].io_base, XCR1));
-	dev_dbg(mcbsp[id].dev, "SRGR2: 0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp[id].io_base, SRGR2));
-	dev_dbg(mcbsp[id].dev, "SRGR1: 0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp[id].io_base, SRGR1));
-	dev_dbg(mcbsp[id].dev, "PCR0:  0x%04x\n",
-			OMAP_MCBSP_READ(mcbsp[id].io_base, PCR0));
-	dev_dbg(mcbsp[id].dev, "***********************\n");
+	struct omap_mcbsp *mcbsp = id_to_mcbsp_ptr(id);
+
+	dev_dbg(mcbsp->dev, "**** McBSP%d regs ****\n", mcbsp->id);
+	dev_dbg(mcbsp->dev, "DRR2:  0x%04x\n",
+			OMAP_MCBSP_READ(mcbsp->io_base, DRR2));
+	dev_dbg(mcbsp->dev, "DRR1:  0x%04x\n",
+			OMAP_MCBSP_READ(mcbsp->io_base, DRR1));
+	dev_dbg(mcbsp->dev, "DXR2:  0x%04x\n",
+			OMAP_MCBSP_READ(mcbsp->io_base, DXR2));
+	dev_dbg(mcbsp->dev, "DXR1:  0x%04x\n",
+			OMAP_MCBSP_READ(mcbsp->io_base, DXR1));
+	dev_dbg(mcbsp->dev, "SPCR2: 0x%04x\n",
+			OMAP_MCBSP_READ(mcbsp->io_base, SPCR2));
+	dev_dbg(mcbsp->dev, "SPCR1: 0x%04x\n",
+			OMAP_MCBSP_READ(mcbsp->io_base, SPCR1));
+	dev_dbg(mcbsp->dev, "RCR2:  0x%04x\n",
+			OMAP_MCBSP_READ(mcbsp->io_base, RCR2));
+	dev_dbg(mcbsp->dev, "RCR1:  0x%04x\n",
+			OMAP_MCBSP_READ(mcbsp->io_base, RCR1));
+	dev_dbg(mcbsp->dev, "XCR2:  0x%04x\n",
+			OMAP_MCBSP_READ(mcbsp->io_base, XCR2));
+	dev_dbg(mcbsp->dev, "XCR1:  0x%04x\n",
+			OMAP_MCBSP_READ(mcbsp->io_base, XCR1));
+	dev_dbg(mcbsp->dev, "SRGR2: 0x%04x\n",
+			OMAP_MCBSP_READ(mcbsp->io_base, SRGR2));
+	dev_dbg(mcbsp->dev, "SRGR1: 0x%04x\n",
+			OMAP_MCBSP_READ(mcbsp->io_base, SRGR1));
+	dev_dbg(mcbsp->dev, "PCR0:  0x%04x\n",
+			OMAP_MCBSP_READ(mcbsp->io_base, PCR0));
+	dev_dbg(mcbsp->dev, "***********************\n");
 }
 
 static irqreturn_t omap_mcbsp_tx_irq_handler(int irq, void *dev_id)
@@ -126,16 +148,18 @@ static void omap_mcbsp_rx_dma_callback(int lch, u16 ch_status, void *data)
  */
 void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg *config)
 {
+	struct omap_mcbsp *mcbsp;
 	void __iomem *io_base;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
 		return;
 	}
+	mcbsp = id_to_mcbsp_ptr(id);
 
-	io_base = mcbsp[id].io_base;
-	dev_dbg(mcbsp[id].dev, "Configuring McBSP%d  phys_base: 0x%08lx\n",
-			mcbsp[id].id, mcbsp[id].phys_base);
+	io_base = mcbsp->io_base;
+	dev_dbg(mcbsp->dev, "Configuring McBSP%d  phys_base: 0x%08lx\n",
+			mcbsp->id, mcbsp->phys_base);
 
 	/* We write the given config */
 	OMAP_MCBSP_WRITE(io_base, SPCR2, config->spcr2);
@@ -158,23 +182,26 @@ EXPORT_SYMBOL(omap_mcbsp_config);
  */
 int omap_mcbsp_set_io_type(unsigned int id, omap_mcbsp_io_type_t io_type)
 {
+	struct omap_mcbsp *mcbsp;
+
 	if (!omap_mcbsp_check_valid_id(id)) {
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
 		return -ENODEV;
 	}
+	mcbsp = id_to_mcbsp_ptr(id);
 
-	spin_lock(&mcbsp[id].lock);
+	spin_lock(&mcbsp->lock);
 
-	if (!mcbsp[id].free) {
-		dev_err(mcbsp[id].dev, "McBSP%d is currently in use\n",
-			mcbsp[id].id);
-		spin_unlock(&mcbsp[id].lock);
+	if (!mcbsp->free) {
+		dev_err(mcbsp->dev, "McBSP%d is currently in use\n",
+			mcbsp->id);
+		spin_unlock(&mcbsp->lock);
 		return -EINVAL;
 	}
 
-	mcbsp[id].io_type = io_type;
+	mcbsp->io_type = io_type;
 
-	spin_unlock(&mcbsp[id].lock);
+	spin_unlock(&mcbsp->lock);
 
 	return 0;
 }
@@ -182,53 +209,55 @@ EXPORT_SYMBOL(omap_mcbsp_set_io_type);
 
 int omap_mcbsp_request(unsigned int id)
 {
+	struct omap_mcbsp *mcbsp;
 	int err;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
 		return -ENODEV;
 	}
+	mcbsp = id_to_mcbsp_ptr(id);
 
-	if (mcbsp[id].pdata->ops->request)
-		mcbsp[id].pdata->ops->request(id);
+	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->request)
+		mcbsp->pdata->ops->request(id);
 
-	clk_enable(mcbsp[id].clk);
+	clk_enable(mcbsp->clk);
 
-	spin_lock(&mcbsp[id].lock);
-	if (!mcbsp[id].free) {
-		dev_err(mcbsp[id].dev, "McBSP%d is currently in use\n",
-			mcbsp[id].id);
-		spin_unlock(&mcbsp[id].lock);
+	spin_lock(&mcbsp->lock);
+	if (!mcbsp->free) {
+		dev_err(mcbsp->dev, "McBSP%d is currently in use\n",
+			mcbsp->id);
+		spin_unlock(&mcbsp->lock);
 		return -1;
 	}
 
-	mcbsp[id].free = 0;
-	spin_unlock(&mcbsp[id].lock);
+	mcbsp->free = 0;
+	spin_unlock(&mcbsp->lock);
 
-	if (mcbsp[id].io_type == OMAP_MCBSP_IRQ_IO) {
+	if (mcbsp->io_type == OMAP_MCBSP_IRQ_IO) {
 		/* We need to get IRQs here */
-		err = request_irq(mcbsp[id].tx_irq, omap_mcbsp_tx_irq_handler,
-					0, "McBSP", (void *) (&mcbsp[id]));
+		err = request_irq(mcbsp->tx_irq, omap_mcbsp_tx_irq_handler,
+					0, "McBSP", (void *)mcbsp);
 		if (err != 0) {
-			dev_err(mcbsp[id].dev, "Unable to request TX IRQ %d "
-					"for McBSP%d\n", mcbsp[id].tx_irq,
-					mcbsp[id].id);
+			dev_err(mcbsp->dev, "Unable to request TX IRQ %d "
+					"for McBSP%d\n", mcbsp->tx_irq,
+					mcbsp->id);
 			return err;
 		}
 
-		init_completion(&(mcbsp[id].tx_irq_completion));
+		init_completion(&mcbsp->tx_irq_completion);
 
-		err = request_irq(mcbsp[id].rx_irq, omap_mcbsp_rx_irq_handler,
-					0, "McBSP", (void *) (&mcbsp[id]));
+		err = request_irq(mcbsp->rx_irq, omap_mcbsp_rx_irq_handler,
+					0, "McBSP", (void *)mcbsp);
 		if (err != 0) {
-			dev_err(mcbsp[id].dev, "Unable to request RX IRQ %d "
-					"for McBSP%d\n", mcbsp[id].rx_irq,
-					mcbsp[id].id);
-			free_irq(mcbsp[id].tx_irq, (void *) (&mcbsp[id]));
+			dev_err(mcbsp->dev, "Unable to request RX IRQ %d "
+					"for McBSP%d\n", mcbsp->rx_irq,
+					mcbsp->id);
+			free_irq(mcbsp->tx_irq, (void *)mcbsp);
 			return err;
 		}
 
-		init_completion(&(mcbsp[id].rx_irq_completion));
+		init_completion(&mcbsp->rx_irq_completion);
 	}
 
 	return 0;
@@ -237,31 +266,34 @@ EXPORT_SYMBOL(omap_mcbsp_request);
 
 void omap_mcbsp_free(unsigned int id)
 {
+	struct omap_mcbsp *mcbsp;
+
 	if (!omap_mcbsp_check_valid_id(id)) {
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
 		return;
 	}
+	mcbsp = id_to_mcbsp_ptr(id);
 
-	if (mcbsp[id].pdata->ops->free)
-		mcbsp[id].pdata->ops->free(id);
+	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->free)
+		mcbsp->pdata->ops->free(id);
 
-	clk_disable(mcbsp[id].clk);
+	clk_disable(mcbsp->clk);
 
-	spin_lock(&mcbsp[id].lock);
-	if (mcbsp[id].free) {
-		dev_err(mcbsp[id].dev, "McBSP%d was not reserved\n",
-			mcbsp[id].id);
-		spin_unlock(&mcbsp[id].lock);
+	spin_lock(&mcbsp->lock);
+	if (mcbsp->free) {
+		dev_err(mcbsp->dev, "McBSP%d was not reserved\n",
+			mcbsp->id);
+		spin_unlock(&mcbsp->lock);
 		return;
 	}
 
-	mcbsp[id].free = 1;
-	spin_unlock(&mcbsp[id].lock);
+	mcbsp->free = 1;
+	spin_unlock(&mcbsp->lock);
 
-	if (mcbsp[id].io_type == OMAP_MCBSP_IRQ_IO) {
+	if (mcbsp->io_type == OMAP_MCBSP_IRQ_IO) {
 		/* Free IRQs */
-		free_irq(mcbsp[id].rx_irq, (void *) (&mcbsp[id]));
-		free_irq(mcbsp[id].tx_irq, (void *) (&mcbsp[id]));
+		free_irq(mcbsp->rx_irq, (void *)mcbsp);
+		free_irq(mcbsp->tx_irq, (void *)mcbsp);
 	}
 }
 EXPORT_SYMBOL(omap_mcbsp_free);
@@ -273,6 +305,7 @@ EXPORT_SYMBOL(omap_mcbsp_free);
  */
 void omap_mcbsp_start(unsigned int id)
 {
+	struct omap_mcbsp *mcbsp;
 	void __iomem *io_base;
 	u16 w;
 
@@ -280,11 +313,11 @@ void omap_mcbsp_start(unsigned int id)
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
 		return;
 	}
+	mcbsp = id_to_mcbsp_ptr(id);
+	io_base = mcbsp->io_base;
 
-	io_base = mcbsp[id].io_base;
-
-	mcbsp[id].rx_word_length = (OMAP_MCBSP_READ(io_base, RCR1) >> 5) & 0x7;
-	mcbsp[id].tx_word_length = (OMAP_MCBSP_READ(io_base, XCR1) >> 5) & 0x7;
+	mcbsp->rx_word_length = (OMAP_MCBSP_READ(io_base, RCR1) >> 5) & 0x7;
+	mcbsp->tx_word_length = (OMAP_MCBSP_READ(io_base, XCR1) >> 5) & 0x7;
 
 	/* Start the sample generator */
 	w = OMAP_MCBSP_READ(io_base, SPCR2);
@@ -310,6 +343,7 @@ EXPORT_SYMBOL(omap_mcbsp_start);
 
 void omap_mcbsp_stop(unsigned int id)
 {
+	struct omap_mcbsp *mcbsp;
 	void __iomem *io_base;
 	u16 w;
 
@@ -318,7 +352,8 @@ void omap_mcbsp_stop(unsigned int id)
 		return;
 	}
 
-	io_base = mcbsp[id].io_base;
+	mcbsp = id_to_mcbsp_ptr(id);
+	io_base = mcbsp->io_base;
 
 	/* Reset transmitter */
 	w = OMAP_MCBSP_READ(io_base, SPCR2);
@@ -337,6 +372,7 @@ EXPORT_SYMBOL(omap_mcbsp_stop);
 /* polled mcbsp i/o operations */
 int omap_mcbsp_pollwrite(unsigned int id, u16 buf)
 {
+	struct omap_mcbsp *mcbsp;
 	void __iomem *base;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
@@ -344,7 +380,9 @@ int omap_mcbsp_pollwrite(unsigned int id, u16 buf)
 		return -ENODEV;
 	}
 
-	base = mcbsp[id].io_base;
+	mcbsp = id_to_mcbsp_ptr(id);
+	base = mcbsp->io_base;
+
 	writew(buf, base + OMAP_MCBSP_REG_DXR1);
 	/* if frame sync error - clear the error */
 	if (readw(base + OMAP_MCBSP_REG_SPCR2) & XSYNC_ERR) {
@@ -366,8 +404,8 @@ int omap_mcbsp_pollwrite(unsigned int id, u16 buf)
 				       (XRST),
 				       base + OMAP_MCBSP_REG_SPCR2);
 				udelay(10);
-				dev_err(mcbsp[id].dev, "Could not write to"
-					" McBSP%d Register\n", mcbsp[id].id);
+				dev_err(mcbsp->dev, "Could not write to"
+					" McBSP%d Register\n", mcbsp->id);
 				return -2;
 			}
 		}
@@ -379,14 +417,16 @@ EXPORT_SYMBOL(omap_mcbsp_pollwrite);
 
 int omap_mcbsp_pollread(unsigned int id, u16 *buf)
 {
+	struct omap_mcbsp *mcbsp;
 	void __iomem *base;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
 		return -ENODEV;
 	}
+	mcbsp = id_to_mcbsp_ptr(id);
 
-	base = mcbsp[id].io_base;
+	base = mcbsp->io_base;
 	/* if frame sync error - clear the error */
 	if (readw(base + OMAP_MCBSP_REG_SPCR1) & RSYNC_ERR) {
 		/* clear error */
@@ -407,8 +447,8 @@ int omap_mcbsp_pollread(unsigned int id, u16 *buf)
 				       (RRST),
 				       base + OMAP_MCBSP_REG_SPCR1);
 				udelay(10);
-				dev_err(mcbsp[id].dev, "Could not read from"
-					" McBSP%d Register\n", mcbsp[id].id);
+				dev_err(mcbsp->dev, "Could not read from"
+					" McBSP%d Register\n", mcbsp->id);
 				return -2;
 			}
 		}
@@ -424,6 +464,7 @@ EXPORT_SYMBOL(omap_mcbsp_pollread);
  */
 void omap_mcbsp_xmit_word(unsigned int id, u32 word)
 {
+	struct omap_mcbsp *mcbsp;
 	void __iomem *io_base;
 	omap_mcbsp_word_length word_length;
 
@@ -432,10 +473,11 @@ void omap_mcbsp_xmit_word(unsigned int id, u32 word)
 		return;
 	}
 
-	io_base = mcbsp[id].io_base;
-	word_length = mcbsp[id].tx_word_length;
+	mcbsp = id_to_mcbsp_ptr(id);
+	io_base = mcbsp->io_base;
+	word_length = mcbsp->tx_word_length;
 
-	wait_for_completion(&(mcbsp[id].tx_irq_completion));
+	wait_for_completion(&mcbsp->tx_irq_completion);
 
 	if (word_length > OMAP_MCBSP_WORD_16)
 		OMAP_MCBSP_WRITE(io_base, DXR2, word >> 16);
@@ -445,6 +487,7 @@ EXPORT_SYMBOL(omap_mcbsp_xmit_word);
 
 u32 omap_mcbsp_recv_word(unsigned int id)
 {
+	struct omap_mcbsp *mcbsp;
 	void __iomem *io_base;
 	u16 word_lsb, word_msb = 0;
 	omap_mcbsp_word_length word_length;
@@ -453,11 +496,12 @@ u32 omap_mcbsp_recv_word(unsigned int id)
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
 		return -ENODEV;
 	}
+	mcbsp = id_to_mcbsp_ptr(id);
 
-	word_length = mcbsp[id].rx_word_length;
-	io_base = mcbsp[id].io_base;
+	word_length = mcbsp->rx_word_length;
+	io_base = mcbsp->io_base;
 
-	wait_for_completion(&(mcbsp[id].rx_irq_completion));
+	wait_for_completion(&mcbsp->rx_irq_completion);
 
 	if (word_length > OMAP_MCBSP_WORD_16)
 		word_msb = OMAP_MCBSP_READ(io_base, DRR2);
@@ -469,6 +513,7 @@ EXPORT_SYMBOL(omap_mcbsp_recv_word);
 
 int omap_mcbsp_spi_master_xmit_word_poll(unsigned int id, u32 word)
 {
+	struct omap_mcbsp *mcbsp;
 	void __iomem *io_base;
 	omap_mcbsp_word_length tx_word_length;
 	omap_mcbsp_word_length rx_word_length;
@@ -478,10 +523,10 @@ int omap_mcbsp_spi_master_xmit_word_poll(unsigned int id, u32 word)
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
 		return -ENODEV;
 	}
-
-	io_base = mcbsp[id].io_base;
-	tx_word_length = mcbsp[id].tx_word_length;
-	rx_word_length = mcbsp[id].rx_word_length;
+	mcbsp = id_to_mcbsp_ptr(id);
+	io_base = mcbsp->io_base;
+	tx_word_length = mcbsp->tx_word_length;
+	rx_word_length = mcbsp->rx_word_length;
 
 	if (tx_word_length != rx_word_length)
 		return -EINVAL;
@@ -496,8 +541,8 @@ int omap_mcbsp_spi_master_xmit_word_poll(unsigned int id, u32 word)
 			udelay(10);
 			OMAP_MCBSP_WRITE(io_base, SPCR2, spcr2 | XRST);
 			udelay(10);
-			dev_err(mcbsp[id].dev, "McBSP%d transmitter not "
-				"ready\n", mcbsp[id].id);
+			dev_err(mcbsp->dev, "McBSP%d transmitter not "
+				"ready\n", mcbsp->id);
 			return -EAGAIN;
 		}
 	}
@@ -517,8 +562,8 @@ int omap_mcbsp_spi_master_xmit_word_poll(unsigned int id, u32 word)
 			udelay(10);
 			OMAP_MCBSP_WRITE(io_base, SPCR1, spcr1 | RRST);
 			udelay(10);
-			dev_err(mcbsp[id].dev, "McBSP%d receiver not "
-				"ready\n", mcbsp[id].id);
+			dev_err(mcbsp->dev, "McBSP%d receiver not "
+				"ready\n", mcbsp->id);
 			return -EAGAIN;
 		}
 	}
@@ -534,6 +579,7 @@ EXPORT_SYMBOL(omap_mcbsp_spi_master_xmit_word_poll);
 
 int omap_mcbsp_spi_master_recv_word_poll(unsigned int id, u32 *word)
 {
+	struct omap_mcbsp *mcbsp;
 	u32 clock_word = 0;
 	void __iomem *io_base;
 	omap_mcbsp_word_length tx_word_length;
@@ -545,9 +591,11 @@ int omap_mcbsp_spi_master_recv_word_poll(unsigned int id, u32 *word)
 		return -ENODEV;
 	}
 
-	io_base = mcbsp[id].io_base;
-	tx_word_length = mcbsp[id].tx_word_length;
-	rx_word_length = mcbsp[id].rx_word_length;
+	mcbsp = id_to_mcbsp_ptr(id);
+	io_base = mcbsp->io_base;
+
+	tx_word_length = mcbsp->tx_word_length;
+	rx_word_length = mcbsp->rx_word_length;
 
 	if (tx_word_length != rx_word_length)
 		return -EINVAL;
@@ -562,8 +610,8 @@ int omap_mcbsp_spi_master_recv_word_poll(unsigned int id, u32 *word)
 			udelay(10);
 			OMAP_MCBSP_WRITE(io_base, SPCR2, spcr2 | XRST);
 			udelay(10);
-			dev_err(mcbsp[id].dev, "McBSP%d transmitter not "
-				"ready\n", mcbsp[id].id);
+			dev_err(mcbsp->dev, "McBSP%d transmitter not "
+				"ready\n", mcbsp->id);
 			return -EAGAIN;
 		}
 	}
@@ -583,8 +631,8 @@ int omap_mcbsp_spi_master_recv_word_poll(unsigned int id, u32 *word)
 			udelay(10);
 			OMAP_MCBSP_WRITE(io_base, SPCR1, spcr1 | RRST);
 			udelay(10);
-			dev_err(mcbsp[id].dev, "McBSP%d receiver not "
-				"ready\n", mcbsp[id].id);
+			dev_err(mcbsp->dev, "McBSP%d receiver not "
+				"ready\n", mcbsp->id);
 			return -EAGAIN;
 		}
 	}
@@ -610,6 +658,7 @@ EXPORT_SYMBOL(omap_mcbsp_spi_master_recv_word_poll);
 int omap_mcbsp_xmit_buffer(unsigned int id, dma_addr_t buffer,
 				unsigned int length)
 {
+	struct omap_mcbsp *mcbsp;
 	int dma_tx_ch;
 	int src_port = 0;
 	int dest_port = 0;
@@ -619,50 +668,51 @@ int omap_mcbsp_xmit_buffer(unsigned int id, dma_addr_t buffer,
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
 		return -ENODEV;
 	}
+	mcbsp = id_to_mcbsp_ptr(id);
 
-	if (omap_request_dma(mcbsp[id].dma_tx_sync, "McBSP TX",
+	if (omap_request_dma(mcbsp->dma_tx_sync, "McBSP TX",
 				omap_mcbsp_tx_dma_callback,
-				&mcbsp[id],
+				mcbsp,
 				&dma_tx_ch)) {
-		dev_err(mcbsp[id].dev, " Unable to request DMA channel for "
+		dev_err(mcbsp->dev, " Unable to request DMA channel for "
 				"McBSP%d TX. Trying IRQ based TX\n",
-				mcbsp[id].id);
+				mcbsp->id);
 		return -EAGAIN;
 	}
-	mcbsp[id].dma_tx_lch = dma_tx_ch;
+	mcbsp->dma_tx_lch = dma_tx_ch;
 
-	dev_err(mcbsp[id].dev, "McBSP%d TX DMA on channel %d\n", mcbsp[id].id,
+	dev_err(mcbsp->dev, "McBSP%d TX DMA on channel %d\n", mcbsp->id,
 		dma_tx_ch);
 
-	init_completion(&(mcbsp[id].tx_dma_completion));
+	init_completion(&mcbsp->tx_dma_completion);
 
 	if (cpu_class_is_omap1()) {
 		src_port = OMAP_DMA_PORT_TIPB;
 		dest_port = OMAP_DMA_PORT_EMIFF;
 	}
 	if (cpu_class_is_omap2())
-		sync_dev = mcbsp[id].dma_tx_sync;
+		sync_dev = mcbsp->dma_tx_sync;
 
-	omap_set_dma_transfer_params(mcbsp[id].dma_tx_lch,
+	omap_set_dma_transfer_params(mcbsp->dma_tx_lch,
 				     OMAP_DMA_DATA_TYPE_S16,
 				     length >> 1, 1,
 				     OMAP_DMA_SYNC_ELEMENT,
 	 sync_dev, 0);
 
-	omap_set_dma_dest_params(mcbsp[id].dma_tx_lch,
+	omap_set_dma_dest_params(mcbsp->dma_tx_lch,
 				 src_port,
 				 OMAP_DMA_AMODE_CONSTANT,
-				 mcbsp[id].phys_base + OMAP_MCBSP_REG_DXR1,
+				 mcbsp->phys_base + OMAP_MCBSP_REG_DXR1,
 				 0, 0);
 
-	omap_set_dma_src_params(mcbsp[id].dma_tx_lch,
+	omap_set_dma_src_params(mcbsp->dma_tx_lch,
 				dest_port,
 				OMAP_DMA_AMODE_POST_INC,
 				buffer,
 				0, 0);
 
-	omap_start_dma(mcbsp[id].dma_tx_lch);
-	wait_for_completion(&(mcbsp[id].tx_dma_completion));
+	omap_start_dma(mcbsp->dma_tx_lch);
+	wait_for_completion(&mcbsp->tx_dma_completion);
 
 	return 0;
 }
@@ -671,6 +721,7 @@ EXPORT_SYMBOL(omap_mcbsp_xmit_buffer);
 int omap_mcbsp_recv_buffer(unsigned int id, dma_addr_t buffer,
 				unsigned int length)
 {
+	struct omap_mcbsp *mcbsp;
 	int dma_rx_ch;
 	int src_port = 0;
 	int dest_port = 0;
@@ -680,50 +731,51 @@ int omap_mcbsp_recv_buffer(unsigned int id, dma_addr_t buffer,
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
 		return -ENODEV;
 	}
+	mcbsp = id_to_mcbsp_ptr(id);
 
-	if (omap_request_dma(mcbsp[id].dma_rx_sync, "McBSP RX",
+	if (omap_request_dma(mcbsp->dma_rx_sync, "McBSP RX",
 				omap_mcbsp_rx_dma_callback,
-				&mcbsp[id],
+				mcbsp,
 				&dma_rx_ch)) {
-		dev_err(mcbsp[id].dev, "Unable to request DMA channel for "
+		dev_err(mcbsp->dev, "Unable to request DMA channel for "
 				"McBSP%d RX. Trying IRQ based RX\n",
-				mcbsp[id].id);
+				mcbsp->id);
 		return -EAGAIN;
 	}
-	mcbsp[id].dma_rx_lch = dma_rx_ch;
+	mcbsp->dma_rx_lch = dma_rx_ch;
 
-	dev_err(mcbsp[id].dev, "McBSP%d RX DMA on channel %d\n", mcbsp[id].id,
+	dev_err(mcbsp->dev, "McBSP%d RX DMA on channel %d\n", mcbsp->id,
 		dma_rx_ch);
 
-	init_completion(&(mcbsp[id].rx_dma_completion));
+	init_completion(&mcbsp->rx_dma_completion);
 
 	if (cpu_class_is_omap1()) {
 		src_port = OMAP_DMA_PORT_TIPB;
 		dest_port = OMAP_DMA_PORT_EMIFF;
 	}
 	if (cpu_class_is_omap2())
-		sync_dev = mcbsp[id].dma_rx_sync;
+		sync_dev = mcbsp->dma_rx_sync;
 
-	omap_set_dma_transfer_params(mcbsp[id].dma_rx_lch,
+	omap_set_dma_transfer_params(mcbsp->dma_rx_lch,
 					OMAP_DMA_DATA_TYPE_S16,
 					length >> 1, 1,
 					OMAP_DMA_SYNC_ELEMENT,
 					sync_dev, 0);
 
-	omap_set_dma_src_params(mcbsp[id].dma_rx_lch,
+	omap_set_dma_src_params(mcbsp->dma_rx_lch,
 				src_port,
 				OMAP_DMA_AMODE_CONSTANT,
-				mcbsp[id].phys_base + OMAP_MCBSP_REG_DRR1,
+				mcbsp->phys_base + OMAP_MCBSP_REG_DRR1,
 				0, 0);
 
-	omap_set_dma_dest_params(mcbsp[id].dma_rx_lch,
+	omap_set_dma_dest_params(mcbsp->dma_rx_lch,
 					dest_port,
 					OMAP_DMA_AMODE_POST_INC,
 					buffer,
 					0, 0);
 
-	omap_start_dma(mcbsp[id].dma_rx_lch);
-	wait_for_completion(&(mcbsp[id].rx_dma_completion));
+	omap_start_dma(mcbsp->dma_rx_lch);
+	wait_for_completion(&mcbsp->rx_dma_completion);
 
 	return 0;
 }
@@ -738,12 +790,14 @@ EXPORT_SYMBOL(omap_mcbsp_recv_buffer);
 void omap_mcbsp_set_spi_mode(unsigned int id,
 				const struct omap_mcbsp_spi_cfg *spi_cfg)
 {
+	struct omap_mcbsp *mcbsp;
 	struct omap_mcbsp_reg_cfg mcbsp_cfg;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
 		return;
 	}
+	mcbsp = id_to_mcbsp_ptr(id);
 
 	memset(&mcbsp_cfg, 0, sizeof(struct omap_mcbsp_reg_cfg));
 
@@ -807,6 +861,7 @@ EXPORT_SYMBOL(omap_mcbsp_set_spi_mode);
 static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 {
 	struct omap_mcbsp_platform_data *pdata = pdev->dev.platform_data;
+	struct omap_mcbsp *mcbsp;
 	int id = pdev->id - 1;
 	int ret = 0;
 
@@ -819,51 +874,58 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "Initializing OMAP McBSP (%d).\n", pdev->id);
 
-	if (id >= OMAP_MAX_MCBSP_COUNT) {
+	if (id >= omap_mcbsp_count) {
 		dev_err(&pdev->dev, "Invalid McBSP device id (%d)\n", id);
 		ret = -EINVAL;
 		goto exit;
 	}
 
-	spin_lock_init(&mcbsp[id].lock);
-	mcbsp[id].id = id + 1;
-	mcbsp[id].free = 1;
-	mcbsp[id].dma_tx_lch = -1;
-	mcbsp[id].dma_rx_lch = -1;
+	mcbsp = kzalloc(sizeof(struct omap_mcbsp), GFP_KERNEL);
+	if (!mcbsp) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+	mcbsp_ptr[id] = mcbsp;
+
+	spin_lock_init(&mcbsp->lock);
+	mcbsp->id = id + 1;
+	mcbsp->free = 1;
+	mcbsp->dma_tx_lch = -1;
+	mcbsp->dma_rx_lch = -1;
 
-	mcbsp[id].phys_base = pdata->phys_base;
-	mcbsp[id].io_base = ioremap(pdata->phys_base, SZ_4K);
-	if (!mcbsp[id].io_base) {
+	mcbsp->phys_base = pdata->phys_base;
+	mcbsp->io_base = ioremap(pdata->phys_base, SZ_4K);
+	if (!mcbsp->io_base) {
 		ret = -ENOMEM;
 		goto err_ioremap;
 	}
 
 	/* Default I/O is IRQ based */
-	mcbsp[id].io_type = OMAP_MCBSP_IRQ_IO;
-	mcbsp[id].tx_irq = pdata->tx_irq;
-	mcbsp[id].rx_irq = pdata->rx_irq;
-	mcbsp[id].dma_rx_sync = pdata->dma_rx_sync;
-	mcbsp[id].dma_tx_sync = pdata->dma_tx_sync;
+	mcbsp->io_type = OMAP_MCBSP_IRQ_IO;
+	mcbsp->tx_irq = pdata->tx_irq;
+	mcbsp->rx_irq = pdata->rx_irq;
+	mcbsp->dma_rx_sync = pdata->dma_rx_sync;
+	mcbsp->dma_tx_sync = pdata->dma_tx_sync;
 
 	if (pdata->clk_name)
-		mcbsp[id].clk = clk_get(&pdev->dev, pdata->clk_name);
-	if (IS_ERR(mcbsp[id].clk)) {
+		mcbsp->clk = clk_get(&pdev->dev, pdata->clk_name);
+	if (IS_ERR(mcbsp->clk)) {
 		dev_err(&pdev->dev,
 			"Invalid clock configuration for McBSP%d.\n",
-			mcbsp[id].id);
-		ret = PTR_ERR(mcbsp[id].clk);
+			mcbsp->id);
+		ret = PTR_ERR(mcbsp->clk);
 		goto err_clk;
 	}
 
-	mcbsp[id].pdata = pdata;
-	mcbsp[id].dev = &pdev->dev;
-	platform_set_drvdata(pdev, &mcbsp[id]);
+	mcbsp->pdata = pdata;
+	mcbsp->dev = &pdev->dev;
+	platform_set_drvdata(pdev, mcbsp);
 	return 0;
 
 err_clk:
-	iounmap(mcbsp[id].io_base);
+	iounmap(mcbsp->io_base);
 err_ioremap:
-	mcbsp[id].free = 0;
+	mcbsp->free = 0;
 exit:
 	return ret;
 }
-- 
1.5.6.rc3.21.g8c6b5

