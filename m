From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 13/21] ARM: OMAP: McBSP: Add support for mcbsp on mach-omap2
Date: Fri,  6 Jun 2008 18:30:45 -0700
Message-ID: <1212802253-17797-14-git-send-email-tony@atomide.com>
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
 <1212802253-17797-13-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:55445 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933606AbYFGBbZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jun 2008 21:31:25 -0400
In-Reply-To: <1212802253-17797-13-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@indt.org.br>, Tony Lindgren <tony@atomide.com>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

This patch adds support for mach-omap2 based on current
mcbsp platform driver.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index c247742..93ee990 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -6,6 +6,8 @@
 obj-y := irq.o id.o io.o memory.o control.o prcm.o clock.o mux.o \
 		devices.o serial.o gpmc.o timer-gp.o
 
+obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
+
 # Functions loaded to SRAM
 obj-$(CONFIG_ARCH_OMAP2420)		+= sram242x.o
 obj-$(CONFIG_ARCH_OMAP2430)		+= sram243x.o
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index c9c5972..73624dc 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -1365,7 +1365,8 @@ static const struct clksel mcbsp_15_clksel[] = {
 };
 
 static struct clk mcbsp5_fck = {
-	.name		= "mcbsp5_fck",
+	.name		= "mcbsp_fck",
+	.id		= 5,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCBSP5_SHIFT,
@@ -1377,7 +1378,8 @@ static struct clk mcbsp5_fck = {
 };
 
 static struct clk mcbsp1_fck = {
-	.name		= "mcbsp1_fck",
+	.name		= "mcbsp_fck",
+	.id		= 1,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCBSP1_SHIFT,
@@ -1789,7 +1791,8 @@ static struct clk gpt10_ick = {
 };
 
 static struct clk mcbsp5_ick = {
-	.name		= "mcbsp5_ick",
+	.name		= "mcbsp_ick",
+	.id		= 5,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MCBSP5_SHIFT,
@@ -1798,7 +1801,8 @@ static struct clk mcbsp5_ick = {
 };
 
 static struct clk mcbsp1_ick = {
-	.name		= "mcbsp1_ick",
+	.name		= "mcbsp_ick",
+	.id		= 1,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MCBSP1_SHIFT,
@@ -2541,7 +2545,8 @@ static struct clk gpt2_ick = {
 };
 
 static struct clk mcbsp2_ick = {
-	.name		= "mcbsp2_ick",
+	.name		= "mcbsp_ick",
+	.id		= 2,
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_MCBSP2_SHIFT,
@@ -2550,7 +2555,8 @@ static struct clk mcbsp2_ick = {
 };
 
 static struct clk mcbsp3_ick = {
-	.name		= "mcbsp3_ick",
+	.name		= "mcbsp_ick",
+	.id		= 3,
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_MCBSP3_SHIFT,
@@ -2559,7 +2565,8 @@ static struct clk mcbsp3_ick = {
 };
 
 static struct clk mcbsp4_ick = {
-	.name		= "mcbsp4_ick",
+	.name		= "mcbsp_ick",
+	.id		= 4,
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_MCBSP4_SHIFT,
@@ -2574,7 +2581,8 @@ static const struct clksel mcbsp_234_clksel[] = {
 };
 
 static struct clk mcbsp2_fck = {
-	.name		= "mcbsp2_fck",
+	.name		= "mcbsp_fck",
+	.id		= 2,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_MCBSP2_SHIFT,
@@ -2586,7 +2594,8 @@ static struct clk mcbsp2_fck = {
 };
 
 static struct clk mcbsp3_fck = {
-	.name		= "mcbsp3_fck",
+	.name		= "mcbsp_fck",
+	.id		= 3,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_MCBSP3_SHIFT,
@@ -2598,7 +2607,8 @@ static struct clk mcbsp3_fck = {
 };
 
 static struct clk mcbsp4_fck = {
-	.name		= "mcbsp4_fck",
+	.name		= "mcbsp_fck",
+	.id		= 4,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_MCBSP4_SHIFT,
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
new file mode 100644
index 0000000..17cf199
--- /dev/null
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -0,0 +1,208 @@
+/*
+ * linux/arch/arm/mach-omap2/mcbsp.c
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
+
+struct mcbsp_internal_clk {
+	struct clk clk;
+	struct clk **childs;
+	int n_childs;
+};
+
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+static void omap_mcbsp_clk_init(struct mcbsp_internal_clk *mclk)
+{
+	const char *clk_names[] = { "mcbsp_ick", "mcbsp_fck" };
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
+			.id		= 2,
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
+static inline void omap_mcbsp_clk_init(struct clk *clk)
+{ }
+#endif
+
+static void omap2_mcbsp2_mux_setup(void)
+{
+	omap_cfg_reg(Y15_24XX_MCBSP2_CLKX);
+	omap_cfg_reg(R14_24XX_MCBSP2_FSX);
+	omap_cfg_reg(W15_24XX_MCBSP2_DR);
+	omap_cfg_reg(V15_24XX_MCBSP2_DX);
+	omap_cfg_reg(V14_24XX_GPIO117);
+	/*
+	 * TODO: Need to add MUX settings for OMAP 2430 SDP
+	 */
+}
+
+static void omap2_mcbsp_request(unsigned int id)
+{
+	if (cpu_is_omap2420() && (id == OMAP_MCBSP2))
+		omap2_mcbsp2_mux_setup();
+}
+
+static int omap2_mcbsp_check(unsigned int id)
+{
+	if (id > OMAP_MAX_MCBSP_COUNT - 1) {
+		printk(KERN_ERR "OMAP-McBSP: McBSP%d doesn't exist\n", id + 1);
+		return -ENODEV;
+	}
+	return 0;
+}
+
+static struct omap_mcbsp_ops omap2_mcbsp_ops = {
+	.request	= omap2_mcbsp_request,
+	.check		= omap2_mcbsp_check,
+};
+
+#ifdef CONFIG_ARCH_OMAP24XX
+static struct omap_mcbsp_platform_data omap24xx_mcbsp_pdata[] = {
+	{
+		.virt_base	= IO_ADDRESS(OMAP24XX_MCBSP1_BASE),
+		.dma_rx_sync	= OMAP24XX_DMA_MCBSP1_RX,
+		.dma_tx_sync	= OMAP24XX_DMA_MCBSP1_TX,
+		.rx_irq		= INT_24XX_MCBSP1_IRQ_RX,
+		.tx_irq		= INT_24XX_MCBSP1_IRQ_TX,
+		.ops		= &omap2_mcbsp_ops,
+		.clk_name	= "mcbsp_clk",
+	},
+	{
+		.virt_base	= IO_ADDRESS(OMAP24XX_MCBSP2_BASE),
+		.dma_rx_sync	= OMAP24XX_DMA_MCBSP2_RX,
+		.dma_tx_sync	= OMAP24XX_DMA_MCBSP2_TX,
+		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
+		.tx_irq		= INT_24XX_MCBSP2_IRQ_TX,
+		.ops		= &omap2_mcbsp_ops,
+		.clk_name	= "mcbsp_clk",
+	},
+};
+#define OMAP24XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap24xx_mcbsp_pdata)
+#else
+#define omap24xx_mcbsp_pdata		NULL
+#define OMAP24XX_MCBSP_PDATA_SZ		0
+#endif
+
+#ifdef CONFIG_ARCH_OMAP34XX
+static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
+	{
+		.virt_base	= IO_ADDRESS(OMAP34XX_MCBSP1_BASE),
+		.dma_rx_sync	= OMAP24XX_DMA_MCBSP1_RX,
+		.dma_tx_sync	= OMAP24XX_DMA_MCBSP1_TX,
+		.rx_irq		= INT_24XX_MCBSP1_IRQ_RX,
+		.tx_irq		= INT_24XX_MCBSP1_IRQ_TX,
+		.ops		= &omap2_mcbsp_ops,
+		.clk_name	= "mcbsp_clk",
+	},
+	{
+		.virt_base	= IO_ADDRESS(OMAP34XX_MCBSP2_BASE),
+		.dma_rx_sync	= OMAP24XX_DMA_MCBSP2_RX,
+		.dma_tx_sync	= OMAP24XX_DMA_MCBSP2_TX,
+		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
+		.tx_irq		= INT_24XX_MCBSP2_IRQ_TX,
+		.ops		= &omap2_mcbsp_ops,
+		.clk_name	= "mcbsp_clk",
+	},
+};
+#define OMAP34XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap34xx_mcbsp_pdata)
+#else
+#define omap34xx_mcbsp_pdata		NULL
+#define OMAP34XX_MCBSP_PDATA_SZ		0
+#endif
+
+int __init omap2_mcbsp_init(void)
+{
+	int i;
+
+	for (i = 0; i < omap_mcbsp_clks_size; i++) {
+		/* Once we call clk_get inside init, we do not register it */
+		omap_mcbsp_clk_init(&omap_mcbsp_clks[i]);
+		clk_register(&omap_mcbsp_clks[i].clk);
+	}
+
+	if (cpu_is_omap24xx())
+		omap_mcbsp_register_board_cfg(omap24xx_mcbsp_pdata,
+						OMAP24XX_MCBSP_PDATA_SZ);
+
+	if (cpu_is_omap34xx())
+		omap_mcbsp_register_board_cfg(omap34xx_mcbsp_pdata,
+						OMAP34XX_MCBSP_PDATA_SZ);
+
+	return omap_mcbsp_init();
+}
+arch_initcall(omap2_mcbsp_init);
