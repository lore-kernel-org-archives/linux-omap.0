From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 5/5] MACH-OMAP2: MCBSP: Add support for mcbsp on mach-omap2
Date: Thu, 24 Apr 2008 11:54:25 -0400
Message-ID: <1209052465-13210-6-git-send-email-edubezval@gmail.com>
References: <1209052465-13210-1-git-send-email-edubezval@gmail.com>
 <1209052465-13210-2-git-send-email-edubezval@gmail.com>
 <1209052465-13210-3-git-send-email-edubezval@gmail.com>
 <1209052465-13210-4-git-send-email-edubezval@gmail.com>
 <1209052465-13210-5-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:50872 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759369AbYDXPyx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2008 11:54:53 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3OFtTu3020476
	for <linux-omap@vger.kernel.org>; Thu, 24 Apr 2008 10:57:22 -0500
In-Reply-To: <1209052465-13210-5-git-send-email-edubezval@gmail.com>
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
 arch/arm/mach-omap2/mcbsp.c  |  108 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/mcbsp.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 06348d3..05f1612 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -7,6 +7,8 @@ obj-y := irq.o id.o io.o memory.o control.o prcm.o clock.o mux.o \
 		devices.o serial.o gpmc.o timer-gp.o powerdomain.o \
 		clockdomain.o
 
+obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
+
 # Functions loaded to SRAM
 obj-$(CONFIG_ARCH_OMAP2)		+= sram24xx.o
 
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
new file mode 100644
index 0000000..2a2462b
--- /dev/null
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -0,0 +1,108 @@
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
+
+#include <asm/arch/dma.h>
+#include <asm/arch/mux.h>
+#include <asm/arch/cpu.h>
+#include <asm/arch/mcbsp.h>
+
+static void omap2_mcbsp2_mux_setup(void)
+{
+	if (cpu_is_omap2420()) {
+		omap_cfg_reg(Y15_24XX_MCBSP2_CLKX);
+		omap_cfg_reg(R14_24XX_MCBSP2_FSX);
+		omap_cfg_reg(W15_24XX_MCBSP2_DR);
+		omap_cfg_reg(V15_24XX_MCBSP2_DX);
+		omap_cfg_reg(V14_24XX_GPIO117);
+	}
+	/*
+	 * TODO: Need to add MUX settings for OMAP 2430 SDP
+	 */
+}
+
+static void omap2_mcbsp_request(unsigned int id)
+{
+	if (id == OMAP_MCBSP2)
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
+		.clocks		= { "mcbsp_ick", "mcbsp_fck" },
+	},
+	{
+		.virt_base	= IO_ADDRESS(OMAP24XX_MCBSP2_BASE),
+		.dma_rx_sync	= OMAP24XX_DMA_MCBSP2_RX,
+		.dma_tx_sync	= OMAP24XX_DMA_MCBSP2_TX,
+		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
+		.tx_irq		= INT_24XX_MCBSP2_IRQ_TX,
+		.ops		= &omap2_mcbsp_ops,
+		.clocks		= { "mcbsp_ick", "mcbsp_fck" },
+	},
+#endif
+#ifdef CONFIG_ARCH_OMAP34XX
+	{
+		.virt_base	= IO_ADDRESS(OMAP34XX_MCBSP1_BASE),
+		.dma_rx_sync	= OMAP34XX_DMA_MCBSP1_RX,
+		.dma_tx_sync	= OMAP34XX_DMA_MCBSP1_TX,
+		.rx_irq		= INT_34XX_MCBSP1_IRQ_RX,
+		.tx_irq		= INT_34XX_MCBSP1_IRQ_TX,
+		.ops		= &omap2_mcbsp_ops,
+		.clocks		= { "mcbsp_ick", "mcbsp_fck" },
+	},
+	{
+		.virt_base	= IO_ADDRESS(OMAP34XX_MCBSP2_BASE),
+		.dma_rx_sync	= OMAP34XX_DMA_MCBSP2_RX,
+		.dma_tx_sync	= OMAP34XX_DMA_MCBSP2_TX,
+		.rx_irq		= INT_34XX_MCBSP2_IRQ_RX,
+		.tx_irq		= INT_34XX_MCBSP2_IRQ_TX,
+		.ops		= &omap2_mcbsp_ops,
+		.clocks		= { "mcbsp_ick", "mcbsp_fck" },
+	},
+#endif
+};
+#define mcbsp_count		ARRAY_SIZE(omap2_mcbsp_pdata)
+
+int __init omap2_mcbsp_init(void)
+{
+	if (mcbsp_count > 0)
+		omap_mcbsp_register_board_cfg(omap2_mcbsp_pdata, mcbsp_count);
+
+	return omap_mcbsp_init();
+}
+arch_initcall(omap2_mcbsp_init);
-- 
1.5.5.1.67.gbdb8.dirty

