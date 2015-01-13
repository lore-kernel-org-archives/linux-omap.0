From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/4] ARM: OMAP3: Remove legacy support for am35xx-emac
Date: Tue, 13 Jan 2015 09:57:45 -0800
Message-ID: <1421171865-5209-5-git-send-email-tony@atomide.com>
References: <1421171865-5209-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:51568 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752594AbbAMSCI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2015 13:02:08 -0500
In-Reply-To: <1421171865-5209-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

This is no longer needed now that 3517 is booting in device tree
only mode.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile               |   3 -
 arch/arm/mach-omap2/am35xx-emac.c          | 114 -----------------------------
 arch/arm/mach-omap2/am35xx-emac.h          |  15 ----
 arch/arm/mach-omap2/am35xx.h               |  46 ------------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  33 +--------
 arch/arm/mach-omap2/pdata-quirks.c         |   1 -
 6 files changed, 2 insertions(+), 210 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/am35xx-emac.c
 delete mode 100644 arch/arm/mach-omap2/am35xx-emac.h
 delete mode 100644 arch/arm/mach-omap2/am35xx.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 29da3f4..bc1a056 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -281,7 +281,4 @@ ifneq ($(CONFIG_HWSPINLOCK_OMAP),)
 obj-y					+= hwspinlock.o
 endif
 
-emac-$(CONFIG_TI_DAVINCI_EMAC)		:= am35xx-emac.o
-obj-y					+= $(emac-m) $(emac-y)
-
 obj-y					+= common-board-devices.o twl-common.o dss-common.o
diff --git a/arch/arm/mach-omap2/am35xx-emac.c b/arch/arm/mach-omap2/am35xx-emac.c
deleted file mode 100644
index 6a6935c..0000000
--- a/arch/arm/mach-omap2/am35xx-emac.c
+++ /dev/null
@@ -1,114 +0,0 @@
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
diff --git a/arch/arm/mach-omap2/am35xx.h b/arch/arm/mach-omap2/am35xx.h
deleted file mode 100644
index 9559449..0000000
--- a/arch/arm/mach-omap2/am35xx.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/*:
- * Address mappings and base address for AM35XX specific interconnects
- * and peripherals.
- *
- * Copyright (C) 2009 Texas Instruments
- *
- * Author: Sriramakrishnan <srk@ti.com>
- *	   Vaibhav Hiremath <hvaibhav@ti.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#ifndef __ASM_ARCH_AM35XX_H
-#define __ASM_ARCH_AM35XX_H
-
-/*
- * Base addresses
- *	Note: OMAP3430 IVA2 memory space is being used for AM35xx IPSS modules
- */
-#define AM35XX_IPSS_EMAC_BASE		0x5C000000
-#define AM35XX_IPSS_USBOTGSS_BASE	0x5C040000
-#define AM35XX_IPSS_HECC_BASE		0x5C050000
-#define AM35XX_IPSS_VPFE_BASE		0x5C060000
-
-
-/* HECC module specifc offset definitions */
-#define AM35XX_HECC_SCC_HECC_OFFSET	(0x0)
-#define AM35XX_HECC_SCC_RAM_OFFSET	(0x3000)
-#define AM35XX_HECC_RAM_OFFSET		(0x3000)
-#define AM35XX_HECC_MBOX_OFFSET		(0x2000)
-#define AM35XX_HECC_INT_LINE		(0x0)
-#define AM35XX_HECC_VERSION		(0x1)
-
-#define AM35XX_EMAC_CNTRL_OFFSET	(0x10000)
-#define AM35XX_EMAC_CNTRL_MOD_OFFSET	(0x0)
-#define AM35XX_EMAC_CNTRL_RAM_OFFSET	(0x20000)
-#define AM35XX_EMAC_MDIO_OFFSET		(0x30000)
-#define AM35XX_IPSS_MDIO_BASE		(AM35XX_IPSS_EMAC_BASE + \
-						AM35XX_EMAC_MDIO_OFFSET)
-#define AM35XX_EMAC_CNTRL_RAM_SIZE	(0x2000)
-#define AM35XX_EMAC_RAM_ADDR		(AM3517_EMAC_BASE + \
-						AM3517_EMAC_CNTRL_RAM_OFFSET)
-#define AM35XX_EMAC_HW_RAM_ADDR		(0x01E20000)
-
-#endif  /*  __ASM_ARCH_AM35XX_H */
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 11468ee..4e8e93c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -29,8 +29,6 @@
 #include <linux/platform_data/mailbox-omap.h>
 #include <plat/dmtimer.h>
 
-#include "am35xx.h"
-
 #include "soc.h"
 #include "omap_hwmod.h"
 #include "omap_hwmod_common_data.h"
@@ -50,6 +48,8 @@
  * elsewhere.
  */
 
+#define AM35XX_IPSS_USBOTGSS_BASE      0x5C040000
+
 /*
  * IP blocks
  */
@@ -3459,15 +3459,6 @@ static struct omap_hwmod_ocp_if am35xx_mdio__l3 = {
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space am35xx_mdio_addrs[] = {
-	{
-		.pa_start	= AM35XX_IPSS_MDIO_BASE,
-		.pa_end		= AM35XX_IPSS_MDIO_BASE + SZ_4K - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 /* l4_core -> davinci mdio  */
 /*
  * XXX Should be connected to an IPSS hwmod, not the L4_CORE directly;
@@ -3478,25 +3469,15 @@ static struct omap_hwmod_ocp_if am35xx_l4_core__mdio = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &am35xx_mdio_hwmod,
 	.clk		= "emac_fck",
-	.addr		= am35xx_mdio_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_irq_info am35xx_emac_mpu_irqs[] = {
-	{ .name = "rxthresh",	.irq = 67 + OMAP_INTC_START, },
-	{ .name = "rx_pulse",	.irq = 68 + OMAP_INTC_START, },
-	{ .name = "tx_pulse",	.irq = 69 + OMAP_INTC_START },
-	{ .name = "misc_pulse",	.irq = 70 + OMAP_INTC_START },
-	{ .irq = -1 },
-};
-
 static struct omap_hwmod_class am35xx_emac_class = {
 	.name = "davinci_emac",
 };
 
 static struct omap_hwmod am35xx_emac_hwmod = {
 	.name		= "davinci_emac",
-	.mpu_irqs	= am35xx_emac_mpu_irqs,
 	.class		= &am35xx_emac_class,
 	/*
 	 * According to Mark Greer, the MPU will not return from WFI
@@ -3519,15 +3500,6 @@ static struct omap_hwmod_ocp_if am35xx_emac__l3 = {
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space am35xx_emac_addrs[] = {
-	{
-		.pa_start	= AM35XX_IPSS_EMAC_BASE,
-		.pa_end		= AM35XX_IPSS_EMAC_BASE + 0x30000 - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 /* l4_core -> davinci emac  */
 /*
  * XXX Should be connected to an IPSS hwmod, not the L4_CORE directly;
@@ -3538,7 +3510,6 @@ static struct omap_hwmod_ocp_if am35xx_l4_core__emac = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &am35xx_emac_hwmod,
 	.clk		= "emac_ick",
-	.addr		= am35xx_emac_addrs,
 	.user		= OCP_USER_MPU,
 };
 
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 3d7eee1..190fa43 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -19,7 +19,6 @@
 #include <linux/platform_data/pinctrl-single.h>
 #include <linux/platform_data/iommu-omap.h>
 
-#include "am35xx.h"
 #include "common.h"
 #include "common-board-devices.h"
 #include "dss-common.h"
-- 
2.1.4

