From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/5] ARM: OMAP2+: Remove legacy emac code
Date: Tue,  3 Dec 2013 15:23:19 -0800
Message-ID: <1386112999-17271-6-git-send-email-tony@atomide.com>
References: <1386112999-17271-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51233 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755455Ab3LCXXZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Dec 2013 18:23:25 -0500
In-Reply-To: <1386112999-17271-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

This is no longer needed when booted with device tree.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile      |   3 -
 arch/arm/mach-omap2/am35xx-emac.c | 115 --------------------------------------
 arch/arm/mach-omap2/am35xx-emac.h |  15 -----
 3 files changed, 133 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/am35xx-emac.c
 delete mode 100644 arch/arm/mach-omap2/am35xx-emac.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 8e6b0a4..dea93e2 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -258,7 +258,4 @@ ifneq ($(CONFIG_HWSPINLOCK_OMAP),)
 obj-y					+= hwspinlock.o
 endif
 
-emac-$(CONFIG_TI_DAVINCI_EMAC)		:= am35xx-emac.o
-obj-y					+= $(emac-m) $(emac-y)
-
 obj-y					+= common-board-devices.o dss-common.o
diff --git a/arch/arm/mach-omap2/am35xx-emac.c b/arch/arm/mach-omap2/am35xx-emac.c
deleted file mode 100644
index 25b79a2..0000000
--- a/arch/arm/mach-omap2/am35xx-emac.c
+++ /dev/null
@@ -1,115 +0,0 @@
-/*
- * Copyright (C) 2011 Ilya Yanok, Emcraft Systems
- *
- * Based on mach-omap2/board-am3517evm.c
- * Copyright (C) 2009 Texas Instruments Incorporated
- * Author: Ranjith Lohithakshan <ranjithl@ti.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2
- * published by the Free Software Foundation.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any kind,
- * whether express or implied; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
-
-#include <linux/err.h>
-#include <linux/davinci_emac.h>
-#include <asm/system.h>
-#include "omap_device.h"
-#include "am35xx.h"
-#include "control.h"
-#include "am35xx-emac.h"
-
-static void am35xx_enable_emac_int(void)
-{
-	u32 v;
-
-	v = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
-	v |= (AM35XX_CPGMAC_C0_RX_PULSE_CLR | AM35XX_CPGMAC_C0_TX_PULSE_CLR |
-	      AM35XX_CPGMAC_C0_MISC_PULSE_CLR | AM35XX_CPGMAC_C0_RX_THRESH_CLR);
-	omap_ctrl_writel(v, AM35XX_CONTROL_LVL_INTR_CLEAR);
-	omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR); /* OCP barrier */
-}
-
-static void am35xx_disable_emac_int(void)
-{
-	u32 v;
-
-	v = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
-	v |= (AM35XX_CPGMAC_C0_RX_PULSE_CLR | AM35XX_CPGMAC_C0_TX_PULSE_CLR);
-	omap_ctrl_writel(v, AM35XX_CONTROL_LVL_INTR_CLEAR);
-	omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR); /* OCP barrier */
-}
-
-static struct emac_platform_data am35xx_emac_pdata = {
-	.ctrl_reg_offset	= AM35XX_EMAC_CNTRL_OFFSET,
-	.ctrl_mod_reg_offset	= AM35XX_EMAC_CNTRL_MOD_OFFSET,
-	.ctrl_ram_offset	= AM35XX_EMAC_CNTRL_RAM_OFFSET,
-	.ctrl_ram_size		= AM35XX_EMAC_CNTRL_RAM_SIZE,
-	.hw_ram_addr		= AM35XX_EMAC_HW_RAM_ADDR,
-	.version		= EMAC_VERSION_2,
-	.interrupt_enable	= am35xx_enable_emac_int,
-	.interrupt_disable	= am35xx_disable_emac_int,
-};
-
-static struct mdio_platform_data am35xx_mdio_pdata;
-
-static int __init omap_davinci_emac_dev_init(struct omap_hwmod *oh,
-		void *pdata, int pdata_len)
-{
-	struct platform_device *pdev;
-
-	pdev = omap_device_build(oh->class->name, 0, oh, pdata, pdata_len);
-	if (IS_ERR(pdev)) {
-		WARN(1, "Can't build omap_device for %s:%s.\n",
-		     oh->class->name, oh->name);
-		return PTR_ERR(pdev);
-	}
-
-	return 0;
-}
-
-void __init am35xx_emac_init(unsigned long mdio_bus_freq, u8 rmii_en)
-{
-	struct omap_hwmod *oh;
-	u32 v;
-	int ret;
-
-	oh = omap_hwmod_lookup("davinci_mdio");
-	if (!oh) {
-		pr_err("Could not find davinci_mdio hwmod\n");
-		return;
-	}
-
-	am35xx_mdio_pdata.bus_freq = mdio_bus_freq;
-
-	ret = omap_davinci_emac_dev_init(oh, &am35xx_mdio_pdata,
-					 sizeof(am35xx_mdio_pdata));
-	if (ret) {
-		pr_err("Could not build davinci_mdio hwmod device\n");
-		return;
-	}
-
-	oh = omap_hwmod_lookup("davinci_emac");
-	if (!oh) {
-		pr_err("Could not find davinci_emac hwmod\n");
-		return;
-	}
-
-	am35xx_emac_pdata.rmii_en = rmii_en;
-
-	ret = omap_davinci_emac_dev_init(oh, &am35xx_emac_pdata,
-					 sizeof(am35xx_emac_pdata));
-	if (ret) {
-		pr_err("Could not build davinci_emac hwmod device\n");
-		return;
-	}
-
-	v = omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
-	v &= ~AM35XX_CPGMACSS_SW_RST;
-	omap_ctrl_writel(v, AM35XX_CONTROL_IP_SW_RESET);
-	omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET); /* OCP barrier */
-}
diff --git a/arch/arm/mach-omap2/am35xx-emac.h b/arch/arm/mach-omap2/am35xx-emac.h
deleted file mode 100644
index 15c6f9c..0000000
--- a/arch/arm/mach-omap2/am35xx-emac.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/*
- * Copyright (C) 2011 Ilya Yanok, Emcraft Systems
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#define AM35XX_DEFAULT_MDIO_FREQUENCY	1000000
-
-#if defined(CONFIG_TI_DAVINCI_EMAC) || defined(CONFIG_TI_DAVINCI_EMAC_MODULE)
-void am35xx_emac_init(unsigned long mdio_bus_freq, u8 rmii_en);
-#else
-static inline void am35xx_emac_init(unsigned long mdio_bus_freq, u8 rmii_en) {}
-#endif
-- 
1.8.1.1

