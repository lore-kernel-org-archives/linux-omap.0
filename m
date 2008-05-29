From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 5/5] MACH-OMAP2: MCBSP: Add support for mcbsp on mach-omap2
Date: Thu, 29 May 2008 11:31:38 -0400
Message-ID: <1212075098-29819-4-git-send-email-edubezval@gmail.com>
References: <1212075098-29819-1-git-send-email-edubezval@gmail.com>
 <1212075098-29819-2-git-send-email-edubezval@gmail.com>
 <1212075098-29819-3-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:41211 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754219AbYE2Pbx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 May 2008 11:31:53 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4TFVgfk004195
	for <linux-omap@vger.kernel.org>; Thu, 29 May 2008 18:31:51 +0300
In-Reply-To: <1212075098-29819-3-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

This patch adds support for mach-omap2 based on current
mcbsp platform driver.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 arch/arm/mach-omap2/Makefile |    2 +
 arch/arm/mach-omap2/mcbsp.c  |  190 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 192 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/mcbsp.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index b617b66..28fa823 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -7,6 +7,8 @@ obj-y := irq.o id.o io.o memory.o control.o prcm.o clock.o mux.o \
 		devices.o serial.o gpmc.o timer-gp.o powerdomain.o \
 		clockdomain.o
 
+obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
+
 # Functions loaded to SRAM
 obj-$(CONFIG_ARCH_OMAP2)		+= sram24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= sram34xx.o
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
new file mode 100644
index 0000000..6281b53
--- /dev/null
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -0,0 +1,190 @@
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
+#define omap_mcbsp_clks_size	ARRAY_SIZE(omap_mcbsp_clks)
+#else
+#define omap_mcbsp_clks		NULL
+#define omap_mcbsp_clks_size	0
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
+static struct omap_mcbsp_platform_data omap2_mcbsp_pdata[] = {
+#ifdef CONFIG_ARCH_OMAP24XX
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
+#endif
+#ifdef CONFIG_ARCH_OMAP34XX
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
+#endif
+};
+#define mcbsp_count		ARRAY_SIZE(omap2_mcbsp_pdata)
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
+	omap_mcbsp_register_board_cfg(omap2_mcbsp_pdata, mcbsp_count);
+
+	return omap_mcbsp_init();
+}
+arch_initcall(omap2_mcbsp_init);
-- 
1.5.5.GIT

