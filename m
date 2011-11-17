From: Ilya Yanok <yanok@emcraft.com>
Subject: [PATCH] am35xx-emac: move generic EMAC init to separate file
Date: Thu, 17 Nov 2011 01:36:39 +0100
Message-ID: <1321490199-24371-1-git-send-email-yanok@emcraft.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:52820 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754073Ab1KQAgo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Nov 2011 19:36:44 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: wd@denx.de, dzu@denx.de, sasha_d@emcraft.com, Ilya Yanok <yanok@emcraft.com>

AM35xx SoCs include DaVinci EMAC IP. Initialization code in
board-am3517evm.c is pretty board independent and will work for any
AM35xx based board so move this code to it's own file to be reused by
other boards.

Signed-off-by: Ilya Yanok <yanok@emcraft.com>
---
 arch/arm/mach-omap2/Makefile          |    3 +
 arch/arm/mach-omap2/am35xx-emac.c     |  136 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/am35xx-emac.h     |   17 ++++
 arch/arm/mach-omap2/board-am3517evm.c |  114 +---------------------------
 4 files changed, 158 insertions(+), 112 deletions(-)
 create mode 100644 arch/arm/mach-omap2/am35xx-emac.c
 create mode 100644 arch/arm/mach-omap2/am35xx-emac.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 69ab1c0..3256301 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -267,4 +267,7 @@ obj-$(CONFIG_ARCH_OMAP4)		+= hwspinlock.o
 disp-$(CONFIG_OMAP2_DSS)		:= display.o
 obj-y					+= $(disp-m) $(disp-y)
 
+emac-$(CONFIG_TI_DAVINCI_EMAC)		:= am35xx-emac.o
+obj-y					+= $(emac-m) $(emac-y)
+
 obj-y					+= common-board-devices.o twl-common.o
diff --git a/arch/arm/mach-omap2/am35xx-emac.c b/arch/arm/mach-omap2/am35xx-emac.c
new file mode 100644
index 0000000..e5ad303
--- /dev/null
+++ b/arch/arm/mach-omap2/am35xx-emac.c
@@ -0,0 +1,136 @@
+/*
+ * Copyright (C) 2011 Ilya Yanok, Emcraft Systems
+ *
+ * Based on mach-omap2/board-am3517evm.c
+ * Copyright (C) 2009 Texas Instruments Incorporated
+ * Author: Ranjith Lohithakshan <ranjithl@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any kind,
+ * whether express or implied; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#include <linux/clk.h>
+#include <linux/davinci_emac.h>
+#include <linux/platform_device.h>
+#include <plat/irqs.h>
+#include <mach/am35xx.h>
+
+#include "control.h"
+
+static struct mdio_platform_data am35xx_mdio_pdata;
+
+static struct resource am35xx_mdio_resources[] = {
+	{
+		.start  = AM35XX_IPSS_EMAC_BASE + AM35XX_EMAC_MDIO_OFFSET,
+		.end    = AM35XX_IPSS_EMAC_BASE + AM35XX_EMAC_MDIO_OFFSET +
+			  SZ_4K - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device am35xx_mdio_device = {
+	.name		= "davinci_mdio",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(am35xx_mdio_resources),
+	.resource	= am35xx_mdio_resources,
+	.dev.platform_data = &am35xx_mdio_pdata,
+};
+
+static void am35xx_enable_ethernet_int(void)
+{
+	u32 regval;
+
+	regval = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
+	regval = (regval | AM35XX_CPGMAC_C0_RX_PULSE_CLR |
+		AM35XX_CPGMAC_C0_TX_PULSE_CLR |
+		AM35XX_CPGMAC_C0_MISC_PULSE_CLR |
+		AM35XX_CPGMAC_C0_RX_THRESH_CLR);
+	omap_ctrl_writel(regval, AM35XX_CONTROL_LVL_INTR_CLEAR);
+	regval = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
+}
+
+static void am35xx_disable_ethernet_int(void)
+{
+	u32 regval;
+
+	regval = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
+	regval = (regval | AM35XX_CPGMAC_C0_RX_PULSE_CLR |
+		AM35XX_CPGMAC_C0_TX_PULSE_CLR);
+	omap_ctrl_writel(regval, AM35XX_CONTROL_LVL_INTR_CLEAR);
+	regval = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
+}
+
+static struct emac_platform_data am35xx_emac_pdata = {
+	.ctrl_reg_offset	= AM35XX_EMAC_CNTRL_OFFSET,
+	.ctrl_mod_reg_offset	= AM35XX_EMAC_CNTRL_MOD_OFFSET,
+	.ctrl_ram_offset	= AM35XX_EMAC_CNTRL_RAM_OFFSET,
+	.ctrl_ram_size		= AM35XX_EMAC_CNTRL_RAM_SIZE,
+	.version		= EMAC_VERSION_2,
+	.hw_ram_addr		= AM35XX_EMAC_HW_RAM_ADDR,
+	.interrupt_enable	= am35xx_enable_ethernet_int,
+	.interrupt_disable	= am35xx_disable_ethernet_int,
+};
+
+static struct resource am35xx_emac_resources[] = {
+	{
+		.start  = AM35XX_IPSS_EMAC_BASE,
+		.end    = AM35XX_IPSS_EMAC_BASE + 0x2FFFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.start  = INT_35XX_EMAC_C0_RXTHRESH_IRQ,
+		.end    = INT_35XX_EMAC_C0_RXTHRESH_IRQ,
+		.flags  = IORESOURCE_IRQ,
+	},
+	{
+		.start  = INT_35XX_EMAC_C0_RX_PULSE_IRQ,
+		.end    = INT_35XX_EMAC_C0_RX_PULSE_IRQ,
+		.flags  = IORESOURCE_IRQ,
+	},
+	{
+		.start  = INT_35XX_EMAC_C0_TX_PULSE_IRQ,
+		.end    = INT_35XX_EMAC_C0_TX_PULSE_IRQ,
+		.flags  = IORESOURCE_IRQ,
+	},
+	{
+		.start  = INT_35XX_EMAC_C0_MISC_PULSE_IRQ,
+		.end    = INT_35XX_EMAC_C0_MISC_PULSE_IRQ,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device am35xx_emac_device = {
+	.name		= "davinci_emac",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(am35xx_emac_resources),
+	.resource	= am35xx_emac_resources,
+	.dev		= {
+		.platform_data	= &am35xx_emac_pdata,
+	},
+};
+
+void am35xx_ethernet_init(unsigned long mdio_bus_freq, int rmii_en)
+{
+	unsigned int regval;
+
+	am35xx_emac_pdata.rmii_en = rmii_en;
+	am35xx_mdio_pdata.bus_freq = mdio_bus_freq;
+	platform_device_register(&am35xx_emac_device);
+	platform_device_register(&am35xx_mdio_device);
+	clk_add_alias(NULL, dev_name(&am35xx_emac_device.dev),
+		      "emac_clk", &am35xx_emac_device.dev);
+	clk_add_alias(NULL, dev_name(&am35xx_mdio_device.dev),
+		      "phy_clk", &am35xx_emac_device.dev);
+
+	regval = omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
+	regval = regval & (~(AM35XX_CPGMACSS_SW_RST));
+	omap_ctrl_writel(regval, AM35XX_CONTROL_IP_SW_RESET);
+	regval = omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
+}
+
diff --git a/arch/arm/mach-omap2/am35xx-emac.h b/arch/arm/mach-omap2/am35xx-emac.h
new file mode 100644
index 0000000..44cb2b3
--- /dev/null
+++ b/arch/arm/mach-omap2/am35xx-emac.h
@@ -0,0 +1,17 @@
+/*
+ * Copyright (C) 2011 Ilya Yanok, Emcraft Systems
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifdef CONFIG_TI_DAVINCI_EMAC
+void am35xx_ethernet_init(unsigned long mdio_bus_freq, int rmii_en);
+#else
+static inline void am35xx_ethernet_init(unsigned long mdio_bus_freq,
+		int rmii_en)
+{
+}
+#endif
+
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index f7df8d3..de20040 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -39,123 +39,13 @@
 #include <video/omap-panel-generic-dpi.h>
 #include <video/omap-panel-dvi.h>
 
+#include "am35xx-emac.h"
 #include "mux.h"
 #include "control.h"
 #include "hsmmc.h"
 
 #define AM35XX_EVM_MDIO_FREQUENCY	(1000000)
 
-static struct mdio_platform_data am3517_evm_mdio_pdata = {
-	.bus_freq	= AM35XX_EVM_MDIO_FREQUENCY,
-};
-
-static struct resource am3517_mdio_resources[] = {
-	{
-		.start  = AM35XX_IPSS_EMAC_BASE + AM35XX_EMAC_MDIO_OFFSET,
-		.end    = AM35XX_IPSS_EMAC_BASE + AM35XX_EMAC_MDIO_OFFSET +
-			  SZ_4K - 1,
-		.flags  = IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device am3517_mdio_device = {
-	.name		= "davinci_mdio",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(am3517_mdio_resources),
-	.resource	= am3517_mdio_resources,
-	.dev.platform_data = &am3517_evm_mdio_pdata,
-};
-
-static struct emac_platform_data am3517_evm_emac_pdata = {
-	.rmii_en	= 1,
-};
-
-static struct resource am3517_emac_resources[] = {
-	{
-		.start  = AM35XX_IPSS_EMAC_BASE,
-		.end    = AM35XX_IPSS_EMAC_BASE + 0x2FFFF,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.start  = INT_35XX_EMAC_C0_RXTHRESH_IRQ,
-		.end    = INT_35XX_EMAC_C0_RXTHRESH_IRQ,
-		.flags  = IORESOURCE_IRQ,
-	},
-	{
-		.start  = INT_35XX_EMAC_C0_RX_PULSE_IRQ,
-		.end    = INT_35XX_EMAC_C0_RX_PULSE_IRQ,
-		.flags  = IORESOURCE_IRQ,
-	},
-	{
-		.start  = INT_35XX_EMAC_C0_TX_PULSE_IRQ,
-		.end    = INT_35XX_EMAC_C0_TX_PULSE_IRQ,
-		.flags  = IORESOURCE_IRQ,
-	},
-	{
-		.start  = INT_35XX_EMAC_C0_MISC_PULSE_IRQ,
-		.end    = INT_35XX_EMAC_C0_MISC_PULSE_IRQ,
-		.flags  = IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device am3517_emac_device = {
-	.name		= "davinci_emac",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(am3517_emac_resources),
-	.resource	= am3517_emac_resources,
-};
-
-static void am3517_enable_ethernet_int(void)
-{
-	u32 regval;
-
-	regval = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
-	regval = (regval | AM35XX_CPGMAC_C0_RX_PULSE_CLR |
-		AM35XX_CPGMAC_C0_TX_PULSE_CLR |
-		AM35XX_CPGMAC_C0_MISC_PULSE_CLR |
-		AM35XX_CPGMAC_C0_RX_THRESH_CLR);
-	omap_ctrl_writel(regval, AM35XX_CONTROL_LVL_INTR_CLEAR);
-	regval = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
-}
-
-static void am3517_disable_ethernet_int(void)
-{
-	u32 regval;
-
-	regval = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
-	regval = (regval | AM35XX_CPGMAC_C0_RX_PULSE_CLR |
-		AM35XX_CPGMAC_C0_TX_PULSE_CLR);
-	omap_ctrl_writel(regval, AM35XX_CONTROL_LVL_INTR_CLEAR);
-	regval = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
-}
-
-static void am3517_evm_ethernet_init(struct emac_platform_data *pdata)
-{
-	unsigned int regval;
-
-	pdata->ctrl_reg_offset		= AM35XX_EMAC_CNTRL_OFFSET;
-	pdata->ctrl_mod_reg_offset	= AM35XX_EMAC_CNTRL_MOD_OFFSET;
-	pdata->ctrl_ram_offset		= AM35XX_EMAC_CNTRL_RAM_OFFSET;
-	pdata->ctrl_ram_size		= AM35XX_EMAC_CNTRL_RAM_SIZE;
-	pdata->version			= EMAC_VERSION_2;
-	pdata->hw_ram_addr		= AM35XX_EMAC_HW_RAM_ADDR;
-	pdata->interrupt_enable		= am3517_enable_ethernet_int;
-	pdata->interrupt_disable	= am3517_disable_ethernet_int;
-	am3517_emac_device.dev.platform_data	= pdata;
-	platform_device_register(&am3517_emac_device);
-	platform_device_register(&am3517_mdio_device);
-	clk_add_alias(NULL, dev_name(&am3517_mdio_device.dev),
-		      NULL, &am3517_emac_device.dev);
-
-	regval = omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
-	regval = regval & (~(AM35XX_CPGMACSS_SW_RST));
-	omap_ctrl_writel(regval, AM35XX_CONTROL_IP_SW_RESET);
-	regval = omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
-
-	return ;
-}
-
-
 
 #define LCD_PANEL_PWR		176
 #define LCD_PANEL_BKLIGHT_PWR	182
@@ -498,7 +388,7 @@ static void __init am3517_evm_init(void)
 	i2c_register_board_info(1, am3517evm_i2c1_boardinfo,
 				ARRAY_SIZE(am3517evm_i2c1_boardinfo));
 	/*Ethernet*/
-	am3517_evm_ethernet_init(&am3517_evm_emac_pdata);
+	am35xx_ethernet_init(AM35XX_EVM_MDIO_FREQUENCY, 1);
 
 	/* MUSB */
 	am3517_evm_musb_init();
-- 
1.7.6.4

