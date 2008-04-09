From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/17] ARM: OMAP2: Clean-up mux code
Date: Wed,  9 Apr 2008 14:03:08 -0700
Message-ID: <1207775003-7429-3-git-send-email-tony@atomide.com>
References: omap2-upstream-2008-04-09-210318
 <1207775003-7429-1-git-send-email-tony@atomide.com>
 <1207775003-7429-2-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63487 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754328AbYDIVDa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Apr 2008 17:03:30 -0400
In-Reply-To: <1207775003-7429-2-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Misc clean-up for the mux code and remove some unnecessary
ifdefs. Patch changes debug function so it can be used on
both 24xx and 34xx.

Changes are mostly for omap2, but patch also cleans up some
omap1 and common mux code.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/mux.c       |   28 ++++++++-------
 arch/arm/mach-omap2/mux.c       |   69 ++++++++++++++++++++++++--------------
 arch/arm/plat-omap/mux.c        |    4 +-
 include/asm-arm/arch-omap/mux.h |   13 ++------
 4 files changed, 63 insertions(+), 51 deletions(-)

diff --git a/arch/arm/mach-omap1/mux.c b/arch/arm/mach-omap1/mux.c
index cf3bdc0..e207bf7 100644
--- a/arch/arm/mach-omap1/mux.c
+++ b/arch/arm/mach-omap1/mux.c
@@ -3,9 +3,9 @@
  *
  * OMAP1 pin multiplexing configurations
  *
- * Copyright (C) 2003 - 2005 Nokia Corporation
+ * Copyright (C) 2003 - 2008 Nokia Corporation
  *
- * Written by Tony Lindgren <tony.lindgren@nokia.com>
+ * Written by Tony Lindgren
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -35,7 +35,7 @@
 static struct omap_mux_cfg arch_mux_cfg;
 
 #ifdef CONFIG_ARCH_OMAP730
-struct pin_config __initdata_or_module omap730_pins[] = {
+static struct pin_config __initdata_or_module omap730_pins[] = {
 MUX_CFG_730("E2_730_KBR0",        12,   21,    0,   20,   1, 0)
 MUX_CFG_730("J7_730_KBR1",        12,   25,    0,   24,   1, 0)
 MUX_CFG_730("E1_730_KBR2",        12,   29,    0,   28,   1, 0)
@@ -51,10 +51,14 @@ MUX_CFG_730("AA17_730_USB_DM",     2,   21,    0,   20,   0, 0)
 MUX_CFG_730("W16_730_USB_PU_EN",   2,   25,    0,   24,   0, 0)
 MUX_CFG_730("W17_730_USB_VBUSI",   2,   29,    0,   28,   0, 0)
 };
-#endif
+#define OMAP730_PINS_SZ		ARRAY_SIZE(omap730_pins)
+#else
+#define omap730_pins		NULL
+#define OMAP730_PINS_SZ		0
+#endif	/* CONFIG_ARCH_OMAP730 */
 
 #if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX)
-struct pin_config __initdata_or_module omap1xxx_pins[] = {
+static struct pin_config __initdata_or_module omap1xxx_pins[] = {
 /*
  *	 description		mux  mode   mux	 pull pull  pull  pu_pd	 pu  dbg
  *				reg  offset mode reg  bit   ena	  reg
@@ -308,8 +312,11 @@ MUX_CFG("Y12_1610_CCP_CLKP",	 8,   18,    6,   1,  24,   1,    1,     0,  0)
 MUX_CFG("W13_1610_CCP_CLKM",	 9,    0,    6,   1,  28,   1,    1,     0,  0)
 MUX_CFG("W14_1610_CCP_DATAP",	 9,   24,    6,   2,   4,   1,    2,     0,  0)
 MUX_CFG("Y14_1610_CCP_DATAM",	 9,   21,    6,   2,   3,   1,    2,     0,  0)
-
 };
+#define OMAP1XXX_PINS_SZ	ARRAY_SIZE(omap1xxx_pins)
+#else
+#define omap1xxx_pins		NULL
+#define OMAP1XXX_PINS_SZ	0
 #endif	/* CONFIG_ARCH_OMAP15XX || CONFIG_ARCH_OMAP16XX */
 
 int __init_or_module omap1_cfg_reg(const struct pin_config *cfg)
@@ -422,22 +429,17 @@ int __init_or_module omap1_cfg_reg(const struct pin_config *cfg)
 
 int __init omap1_mux_init(void)
 {
-
-#ifdef CONFIG_ARCH_OMAP730
 	if (cpu_is_omap730()) {
 		arch_mux_cfg.pins	= omap730_pins;
-		arch_mux_cfg.size	= ARRAY_SIZE(omap730_pins);
+		arch_mux_cfg.size	= OMAP730_PINS_SZ;
 		arch_mux_cfg.cfg_reg	= omap1_cfg_reg;
 	}
-#endif
 
-#if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX)
 	if (cpu_is_omap15xx() || cpu_is_omap16xx()) {
 		arch_mux_cfg.pins	= omap1xxx_pins;
-		arch_mux_cfg.size	= ARRAY_SIZE(omap1xxx_pins);
+		arch_mux_cfg.size	= OMAP1XXX_PINS_SZ;
 		arch_mux_cfg.cfg_reg	= omap1_cfg_reg;
 	}
-#endif
 
 	return omap_mux_register(&arch_mux_cfg);
 }
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 5cba3a2..0cf7562 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -1,11 +1,12 @@
 /*
  * linux/arch/arm/mach-omap2/mux.c
  *
- * OMAP1 pin multiplexing configurations
+ * OMAP2 pin multiplexing configurations
  *
- * Copyright (C) 2003 - 2005 Nokia Corporation
+ * Copyright (C) 2004 - 2008 Texas Instruments Inc.
+ * Copyright (C) 2003 - 2008 Nokia Corporation
  *
- * Written by Tony Lindgren <tony.lindgren@nokia.com>
+ * Written by Tony Lindgren
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -36,7 +37,8 @@ static struct omap_mux_cfg arch_mux_cfg;
 
 /* NOTE: See mux.h for the enumeration */
 
-struct pin_config __initdata_or_module omap24xx_pins[] = {
+#ifdef CONFIG_ARCH_OMAP24XX
+static struct pin_config __initdata_or_module omap24xx_pins[] = {
 /*
  *	description			mux	mux	pull	pull	debug
  *					offset	mode	ena	type
@@ -209,54 +211,69 @@ MUX_CFG_24XX("AE13_2430_MCBSP2_DX_OFF",	0x0130,	0,	0,	0,	1)
 MUX_CFG_24XX("AD13_2430_MCBSP2_DR_OFF",	0x0131,	0,	0,	0,	1)
 };
 
-#ifdef CONFIG_ARCH_OMAP24XX
+#define OMAP24XX_PINS_SZ	ARRAY_SIZE(omap24xx_pins)
+
+#else
+#define omap24xx_pins		NULL
+#define OMAP24XX_PINS_SZ	0
+#endif	/* CONFIG_ARCH_OMAP24XX */
 
 #define OMAP24XX_L4_BASE	0x48000000
 #define OMAP24XX_PULL_ENA	(1 << 3)
 #define OMAP24XX_PULL_UP	(1 << 4)
 
 /* REVISIT: Convert this code to use ctrl_{read,write}_reg */
+#if defined(CONFIG_OMAP_MUX_DEBUG) || defined(CONFIG_OMAP_MUX_WARNINGS)
+void __init_or_module omap2_cfg_debug(const struct pin_config *cfg, u8 reg)
+{
+	u16 orig;
+	u8 warn = 0, debug = 0;
+
+	orig = omap_readb(OMAP24XX_L4_BASE + cfg->mux_reg);
+
+#ifdef	CONFIG_OMAP_MUX_DEBUG
+	debug = cfg->debug;
+#endif
+	warn = (orig != reg);
+	if (debug || warn)
+		printk(KERN_WARNING
+			"MUX: setup %s (0x%08x): 0x%02x -> 0x%02x\n",
+			cfg->name, omap_readb(OMAP24XX_L4_BASE + cfg->mux_reg));
+}
+#else
+#define omap2_cfg_debug(x, y)	do {} while (0)
+#endif
+
+#ifdef CONFIG_ARCH_OMAP24XX
 int __init_or_module omap24xx_cfg_reg(const struct pin_config *cfg)
 {
+	static DEFINE_SPINLOCK(mux_spin_lock);
+	unsigned long flags;
 	u8 reg = 0;
-	unsigned int warn = 0;
 
+	spin_lock_irqsave(&mux_spin_lock, flags);
 	reg |= cfg->mask & 0x7;
 	if (cfg->pull_val)
 		reg |= OMAP24XX_PULL_ENA;
-	if(cfg->pu_pd_val)
+	if (cfg->pu_pd_val)
 		reg |= OMAP24XX_PULL_UP;
-#if defined(CONFIG_OMAP_MUX_DEBUG) || defined(CONFIG_OMAP_MUX_WARNINGS)
-	{
-		u8 orig = omap_readb(OMAP24XX_L4_BASE + cfg->mux_reg);
-		u8 debug = 0;
-
-#ifdef	CONFIG_OMAP_MUX_DEBUG
-		debug = cfg->debug;
-#endif
-		warn = (orig != reg);
-		if (debug || warn)
-			printk("MUX: setup %s (0x%08x): 0x%02x -> 0x%02x\n",
-				cfg->name, OMAP24XX_L4_BASE + cfg->mux_reg,
-				orig, reg);
-	}
-#endif
+	omap2_cfg_debug(cfg, reg);
 	omap_writeb(reg, OMAP24XX_L4_BASE + cfg->mux_reg);
+	spin_unlock_irqrestore(&mux_spin_lock, flags);
 
 	return 0;
 }
+#else
+#define omap24xx_cfg_reg	0
 #endif
 
 int __init omap2_mux_init(void)
 {
-
-#ifdef CONFIG_ARCH_OMAP24XX
 	if (cpu_is_omap24xx()) {
 		arch_mux_cfg.pins	= omap24xx_pins;
-		arch_mux_cfg.size	= ARRAY_SIZE(omap24xx_pins);
+		arch_mux_cfg.size	= OMAP24XX_PINS_SZ;
 		arch_mux_cfg.cfg_reg	= omap24xx_cfg_reg;
 	}
-#endif
 
 	return omap_mux_register(&arch_mux_cfg);
 }
diff --git a/arch/arm/plat-omap/mux.c b/arch/arm/plat-omap/mux.c
index 4de18b9..6f3f459 100644
--- a/arch/arm/plat-omap/mux.c
+++ b/arch/arm/plat-omap/mux.c
@@ -3,9 +3,9 @@
  *
  * Utility to set the Omap MUX and PULL_DWN registers from a table in mux.h
  *
- * Copyright (C) 2003 - 2005 Nokia Corporation
+ * Copyright (C) 2003 - 2008 Nokia Corporation
  *
- * Written by Tony Lindgren <tony.lindgren@nokia.com>
+ * Written by Tony Lindgren
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
diff --git a/include/asm-arm/arch-omap/mux.h b/include/asm-arm/arch-omap/mux.h
index 68dd936..ff9a5b5 100644
--- a/include/asm-arm/arch-omap/mux.h
+++ b/include/asm-arm/arch-omap/mux.h
@@ -4,9 +4,10 @@
  * Table of the Omap register configurations for the FUNC_MUX and
  * PULL_DWN combinations.
  *
- * Copyright (C) 2003 - 2005 Nokia Corporation
+ * Copyright (C) 2004 - 2008 Texas Instruments Inc.
+ * Copyright (C) 2003 - 2008 Nokia Corporation
  *
- * Written by Tony Lindgren <tony.lindgren@nokia.com>
+ * Written by Tony Lindgren
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -27,14 +28,6 @@
  *	 - W8	     = ball
  *	 - 1610	     = 1510 or 1610, none if common for both 1510 and 1610
  *	 - MMC2_DAT0 = function
- *
- * Change log:
- *   Added entry for the I2C interface. (02Feb 2004)
- *   Copyright (C) 2004 Texas Instruments
- *
- *   Added entry for the keypad and uwire CS1. (09Mar 2004)
- *   Copyright (C) 2004 Texas Instruments
- *
  */
 
 #ifndef __ASM_ARCH_MUX_H
-- 
1.5.3.6

