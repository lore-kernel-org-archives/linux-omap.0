From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 12/21] ARM: OMAP: McBSP: Add support for mcbsp on mach-omap1
Date: Fri,  6 Jun 2008 18:30:44 -0700
Message-ID: <1212802253-17797-13-git-send-email-tony@atomide.com>
References: omap-upstream-2008-06-06-183049
 <1212802253-17797-1-git-send-email-tony@atomide.com>
 <1212802253-17797-2-git-send-email-tony@atomide.com>
 <1212802253-17797-3-git-send-email-tony@atomide.com>
 <1212802253-17797-4-git-send-email-tony@atomide.com>
 <1212802253-17797-5-git-send-email-tony@atomide.com>
 <1212802253-17797-6-git-send-email-tony@atomide.com>
 <1212802253-17797-7-git-send-email-tony@atomide.com>
 <1212802253-17797-8-git-send-email-tony@atomide.com>
 <1212802253-17797-9-git-send-email-tony@atomide.com>
 <1212802253-17797-10-git-send-email-tony@atomide.com>
 <1212802253-17797-11-git-send-email-tony@atomide.com>
 <1212802253-17797-12-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53360 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761753AbYFGBbW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jun 2008 21:31:22 -0400
In-Reply-To: <1212802253-17797-12-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@indt.org.br>, Tony Lindgren <tony@atomide.com>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

This patch adds support for mach-omap1 based on current
mcbsp platform driver.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index 5e9416e..1bda8f5 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -5,6 +5,8 @@
 # Common support
 obj-y := io.o id.o sram.o clock.o irq.o mux.o serial.o devices.o
 
+obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
+
 obj-$(CONFIG_OMAP_MPU_TIMER)	+= time.o
 obj-$(CONFIG_OMAP_32K_TIMER)	+= timer32k.o
 
diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
new file mode 100644
index 0000000..2d2c252
--- /dev/null
+++ b/arch/arm/mach-omap1/mcbsp.c
@@ -0,0 +1,280 @@
+/*
+ * linux/arch/arm/mach-omap1/mcbsp.c
+ *
+ * Copyright (C) 2008 Instituto Nokia de Tecnologia
+ * Contact: Eduardo Valentin <eduardo.valentin@indt.org.br>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Multichannel mode not supported.
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+
+#include <asm/arch/dma.h>
+#include <asm/arch/mux.h>
+#include <asm/arch/cpu.h>
+#include <asm/arch/mcbsp.h>
+#include <asm/arch/dsp_common.h>
+
+#define DPS_RSTCT2_PER_EN	(1 << 0)
+#define DSP_RSTCT2_WD_PER_EN	(1 << 1)
+
+struct mcbsp_internal_clk {
+	struct clk clk;
+	struct clk **childs;
+	int n_childs;
+};
+
+#if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX)
+static void omap_mcbsp_clk_init(struct mcbsp_internal_clk *mclk)
+{
+	const char *clk_names[] = { "dsp_ck", "api_ck", "dspxor_ck" };
+	int i;
+
+	mclk->n_childs = ARRAY_SIZE(clk_names);
+	mclk->childs = kzalloc(mclk->n_childs * sizeof(struct clk *),
+				GFP_KERNEL);
+
+	for (i = 0; i < mclk->n_childs; i++) {
+		/* We fake a platform device to get correct device id */
+		struct platform_device pdev;
+
+		pdev.dev.bus = &platform_bus_type;
+		pdev.id = mclk->clk.id;
+		mclk->childs[i] = clk_get(&pdev.dev, clk_names[i]);
+		if (IS_ERR(mclk->childs[i]))
+			printk(KERN_ERR "Could not get clock %s (%d).\n",
+				clk_names[i], mclk->clk.id);
+	}
+}
+
+static int omap_mcbsp_clk_enable(struct clk *clk)
+{
+	struct mcbsp_internal_clk *mclk = container_of(clk,
+					struct mcbsp_internal_clk, clk);
+	int i;
+
+	for (i = 0; i < mclk->n_childs; i++)
+		clk_enable(mclk->childs[i]);
+	return 0;
+}
+
+static void omap_mcbsp_clk_disable(struct clk *clk)
+{
+	struct mcbsp_internal_clk *mclk = container_of(clk,
+					struct mcbsp_internal_clk, clk);
+	int i;
+
+	for (i = 0; i < mclk->n_childs; i++)
+		clk_disable(mclk->childs[i]);
+}
+
+static struct mcbsp_internal_clk omap_mcbsp_clks[] = {
+	{
+		.clk = {
+			.name 		= "mcbsp_clk",
+			.id		= 1,
+			.enable		= omap_mcbsp_clk_enable,
+			.disable	= omap_mcbsp_clk_disable,
+		},
+	},
+	{
+		.clk = {
+			.name 		= "mcbsp_clk",
+			.id		= 3,
+			.enable		= omap_mcbsp_clk_enable,
+			.disable	= omap_mcbsp_clk_disable,
+		},
+	},
+};
+
+#define omap_mcbsp_clks_size	ARRAY_SIZE(omap_mcbsp_clks)
+#else
+#define omap_mcbsp_clks_size	0
+static struct mcbsp_internal_clk __initdata *omap_mcbsp_clks;
+static inline void omap_mcbsp_clk_init(struct mcbsp_internal_clk *mclk)
+{ }
+#endif
+
+static int omap1_mcbsp_check(unsigned int id)
+{
+	/* REVISIT: Check correctly for number of registered McBSPs */
+	if (cpu_is_omap730()) {
+		if (id > OMAP_MAX_MCBSP_COUNT - 2) {
+		       printk(KERN_ERR "OMAP-McBSP: McBSP%d doesn't exist\n",
+				id + 1);
+		       return -ENODEV;
+		}
+		return 0;
+	}
+
+	if (cpu_is_omap15xx() || cpu_is_omap16xx()) {
+		if (id > OMAP_MAX_MCBSP_COUNT - 1) {
+			printk(KERN_ERR "OMAP-McBSP: McBSP%d doesn't exist\n",
+				id + 1);
+			return -ENODEV;
+		}
+		return 0;
+	}
+
+	return -ENODEV;
+}
+
+static void omap1_mcbsp_request(unsigned int id)
+{
+	/*
+	 * On 1510, 1610 and 1710, McBSP1 and McBSP3
+	 * are DSP public peripherals.
+	 */
+	if (id == OMAP_MCBSP1 || id == OMAP_MCBSP3) {
+		omap_dsp_request_mem();
+		/*
+		 * DSP external peripheral reset
+		 * FIXME: This should be moved to dsp code
+		 */
+		__raw_writew(__raw_readw(DSP_RSTCT2) | DPS_RSTCT2_PER_EN |
+				DSP_RSTCT2_WD_PER_EN, DSP_RSTCT2);
+	}
+}
+
+static void omap1_mcbsp_free(unsigned int id)
+{
+	if (id == OMAP_MCBSP1 || id == OMAP_MCBSP3)
+		omap_dsp_release_mem();
+}
+
+static struct omap_mcbsp_ops omap1_mcbsp_ops = {
+	.check		= omap1_mcbsp_check,
+	.request	= omap1_mcbsp_request,
+	.free		= omap1_mcbsp_free,
+};
+
+#ifdef CONFIG_ARCH_OMAP730
+static struct omap_mcbsp_platform_data omap730_mcbsp_pdata[] = {
+	{
+		.virt_base	= io_p2v(OMAP730_MCBSP1_BASE),
+		.dma_rx_sync	= OMAP_DMA_MCBSP1_RX,
+		.dma_tx_sync	= OMAP_DMA_MCBSP1_TX,
+		.rx_irq		= INT_730_McBSP1RX,
+		.tx_irq		= INT_730_McBSP1TX,
+		.ops		= &omap1_mcbsp_ops,
+	},
+	{
+		.virt_base	= io_p2v(OMAP730_MCBSP2_BASE),
+		.dma_rx_sync	= OMAP_DMA_MCBSP3_RX,
+		.dma_tx_sync	= OMAP_DMA_MCBSP3_TX,
+		.rx_irq		= INT_730_McBSP2RX,
+		.tx_irq		= INT_730_McBSP2TX,
+		.ops		= &omap1_mcbsp_ops,
+	},
+};
+#define OMAP730_MCBSP_PDATA_SZ		ARRAY_SIZE(omap730_mcbsp_pdata)
+#else
+#define omap730_mcbsp_pdata		NULL
+#define OMAP730_MCBSP_PDATA_SZ		0
+#endif
+
+#ifdef CONFIG_ARCH_OMAP15XX
+static struct omap_mcbsp_platform_data omap15xx_mcbsp_pdata[] = {
+	{
+		.virt_base	= OMAP1510_MCBSP1_BASE,
+		.dma_rx_sync	= OMAP_DMA_MCBSP1_RX,
+		.dma_tx_sync	= OMAP_DMA_MCBSP1_TX,
+		.rx_irq		= INT_McBSP1RX,
+		.tx_irq		= INT_McBSP1TX,
+		.ops		= &omap1_mcbsp_ops,
+		.clk_name	= "mcbsp_clk",
+		},
+	{
+		.virt_base	= io_p2v(OMAP1510_MCBSP2_BASE),
+		.dma_rx_sync	= OMAP_DMA_MCBSP2_RX,
+		.dma_tx_sync	= OMAP_DMA_MCBSP2_TX,
+		.rx_irq		= INT_1510_SPI_RX,
+		.tx_irq		= INT_1510_SPI_TX,
+		.ops		= &omap1_mcbsp_ops,
+	},
+	{
+		.virt_base	= OMAP1510_MCBSP3_BASE,
+		.dma_rx_sync	= OMAP_DMA_MCBSP3_RX,
+		.dma_tx_sync	= OMAP_DMA_MCBSP3_TX,
+		.rx_irq		= INT_McBSP3RX,
+		.tx_irq		= INT_McBSP3TX,
+		.ops		= &omap1_mcbsp_ops,
+		.clk_name	= "mcbsp_clk",
+	},
+};
+#define OMAP15XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap15xx_mcbsp_pdata)
+#else
+#define omap15xx_mcbsp_pdata		NULL
+#define OMAP15XX_MCBSP_PDATA_SZ		0
+#endif
+
+#ifdef CONFIG_ARCH_OMAP16XX
+static struct omap_mcbsp_platform_data omap16xx_mcbsp_pdata[] = {
+	{
+		.virt_base	= OMAP1610_MCBSP1_BASE,
+		.dma_rx_sync	= OMAP_DMA_MCBSP1_RX,
+		.dma_tx_sync	= OMAP_DMA_MCBSP1_TX,
+		.rx_irq		= INT_McBSP1RX,
+		.tx_irq		= INT_McBSP1TX,
+		.ops		= &omap1_mcbsp_ops,
+		.clk_name	= "mcbsp_clk",
+	},
+	{
+		.virt_base	= io_p2v(OMAP1610_MCBSP2_BASE),
+		.dma_rx_sync	= OMAP_DMA_MCBSP2_RX,
+		.dma_tx_sync	= OMAP_DMA_MCBSP2_TX,
+		.rx_irq		= INT_1610_McBSP2_RX,
+		.tx_irq		= INT_1610_McBSP2_TX,
+		.ops		= &omap1_mcbsp_ops,
+	},
+	{
+		.virt_base	= OMAP1610_MCBSP3_BASE,
+		.dma_rx_sync	= OMAP_DMA_MCBSP3_RX,
+		.dma_tx_sync	= OMAP_DMA_MCBSP3_TX,
+		.rx_irq		= INT_McBSP3RX,
+		.tx_irq		= INT_McBSP3TX,
+		.ops		= &omap1_mcbsp_ops,
+		.clk_name	= "mcbsp_clk",
+	},
+};
+#define OMAP16XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap16xx_mcbsp_pdata)
+#else
+#define omap16xx_mcbsp_pdata		NULL
+#define OMAP16XX_MCBSP_PDATA_SZ		0
+#endif
+
+int __init omap1_mcbsp_init(void)
+{
+	int i;
+
+	for (i = 0; i < omap_mcbsp_clks_size; i++) {
+		if (cpu_is_omap15xx() || cpu_is_omap16xx()) {
+			omap_mcbsp_clk_init(&omap_mcbsp_clks[i]);
+			clk_register(&omap_mcbsp_clks[i].clk);
+		}
+	}
+
+	if (cpu_is_omap730())
+		omap_mcbsp_register_board_cfg(omap730_mcbsp_pdata,
+						OMAP730_MCBSP_PDATA_SZ);
+
+	if (cpu_is_omap15xx())
+		omap_mcbsp_register_board_cfg(omap15xx_mcbsp_pdata,
+						OMAP15XX_MCBSP_PDATA_SZ);
+
+	if (cpu_is_omap16xx())
+		omap_mcbsp_register_board_cfg(omap16xx_mcbsp_pdata,
+						OMAP16XX_MCBSP_PDATA_SZ);
+
+	return omap_mcbsp_init();
+}
+
+arch_initcall(omap1_mcbsp_init);
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index 88081ed..06e1118 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -1747,7 +1747,8 @@ static struct clk gpt12_fck = {
 };
 
 static struct clk mcbsp1_ick = {
-	.name		= "mcbsp1_ick",
+	.name		= "mcbsp_ick",
+	.id		= 1,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
@@ -1756,7 +1757,8 @@ static struct clk mcbsp1_ick = {
 };
 
 static struct clk mcbsp1_fck = {
-	.name		= "mcbsp1_fck",
+	.name		= "mcbsp_fck",
+	.id		= 1,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
@@ -1765,7 +1767,8 @@ static struct clk mcbsp1_fck = {
 };
 
 static struct clk mcbsp2_ick = {
-	.name		= "mcbsp2_ick",
+	.name		= "mcbsp_ick",
+	.id		= 2,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
@@ -1774,7 +1777,8 @@ static struct clk mcbsp2_ick = {
 };
 
 static struct clk mcbsp2_fck = {
-	.name		= "mcbsp2_fck",
+	.name		= "mcbsp_fck",
+	.id		= 2,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
@@ -1783,7 +1787,8 @@ static struct clk mcbsp2_fck = {
 };
 
 static struct clk mcbsp3_ick = {
-	.name		= "mcbsp3_ick",
+	.name		= "mcbsp_ick",
+	.id		= 3,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
@@ -1792,7 +1797,8 @@ static struct clk mcbsp3_ick = {
 };
 
 static struct clk mcbsp3_fck = {
-	.name		= "mcbsp3_fck",
+	.name		= "mcbsp_fck",
+	.id		= 3,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
@@ -1801,7 +1807,8 @@ static struct clk mcbsp3_fck = {
 };
 
 static struct clk mcbsp4_ick = {
-	.name		= "mcbsp4_ick",
+	.name		= "mcbsp_ick",
+	.id		= 4,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
@@ -1810,7 +1817,8 @@ static struct clk mcbsp4_ick = {
 };
 
 static struct clk mcbsp4_fck = {
-	.name		= "mcbsp4_fck",
+	.name		= "mcbsp_fck",
+	.id		= 4,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
@@ -1819,7 +1827,8 @@ static struct clk mcbsp4_fck = {
 };
 
 static struct clk mcbsp5_ick = {
-	.name		= "mcbsp5_ick",
+	.name		= "mcbsp_ick",
+	.id		= 5,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
@@ -1828,7 +1837,8 @@ static struct clk mcbsp5_ick = {
 };
 
 static struct clk mcbsp5_fck = {
-	.name		= "mcbsp5_fck",
+	.name		= "mcbsp_fck",
+	.id		= 5,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
