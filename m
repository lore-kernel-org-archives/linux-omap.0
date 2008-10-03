From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/07] ARM: OMAP2: Add pinmux support for omap34xx
Date: Fri,  3 Oct 2008 14:56:46 +0300
Message-ID: <1223035009-23866-5-git-send-email-tony@atomide.com>
References: <1223035009-23866-1-git-send-email-tony@atomide.com>
 <1223035009-23866-2-git-send-email-tony@atomide.com>
 <1223035009-23866-3-git-send-email-tony@atomide.com>
 <1223035009-23866-4-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62926 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754283AbYJCLyL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 07:54:11 -0400
In-Reply-To: <1223035009-23866-4-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Vikram Pandita <vikram.pandita@ti.com>, Jarkko Nikula <jarkko.nikula@nokia.com>, Tony Lindgren <tony@atomide.com>

From: Vikram Pandita <vikram.pandita@ti.com>

This patch adds pinmux support for OMAP3. Incorporated review comments
from Tony to make mux_value as bit mask. Tested on 3430SDP.

Also merge in adding of I2C pins from Jarkko Nikula.

Acked-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 6b7d672..4f44414 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -1,7 +1,7 @@
 /*
  * linux/arch/arm/mach-omap2/mux.c
  *
- * OMAP2 pin multiplexing configurations
+ * OMAP2 and OMAP3 pin multiplexing configurations
  *
  * Copyright (C) 2004 - 2008 Texas Instruments Inc.
  * Copyright (C) 2003 - 2008 Nokia Corporation
@@ -220,16 +220,179 @@ MUX_CFG_24XX("AD13_2430_MCBSP2_DR_OFF",	0x0131,	0,	0,	0,	1)
 #define OMAP24XX_PINS_SZ	0
 #endif	/* CONFIG_ARCH_OMAP24XX */
 
-#define OMAP24XX_PULL_ENA	(1 << 3)
-#define OMAP24XX_PULL_UP	(1 << 4)
+#ifdef CONFIG_ARCH_OMAP34XX
+static struct pin_config __initdata_or_module omap34xx_pins[] = {
+/*
+ *		Name, reg-offset,
+ *		mux-mode | [active-mode | off-mode]
+ */
+
+/* 34xx I2C */
+MUX_CFG_34XX("K21_34XX_I2C1_SCL", 0x1ba,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("J21_34XX_I2C1_SDA", 0x1bc,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AF15_34XX_I2C2_SCL", 0x1be,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AE15_34XX_I2C2_SDA", 0x1c0,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AF14_34XX_I2C3_SCL", 0x1c2,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AG14_34XX_I2C3_SDA", 0x1c4,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AD26_34XX_I2C4_SCL", 0xa00,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AE26_34XX_I2C4_SDA", 0xa02,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+
+/* PHY - HSUSB: 12-pin ULPI PHY: Port 1*/
+MUX_CFG_34XX("Y8_3430_USB1HS_PHY_CLK", 0x5da,
+		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("Y9_3430_USB1HS_PHY_STP", 0x5d8,
+		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("AA14_3430_USB1HS_PHY_DIR", 0x5ec,
+		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("AA11_3430_USB1HS_PHY_NXT", 0x5ee,
+		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("W13_3430_USB1HS_PHY_D0", 0x5dc,
+		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("W12_3430_USB1HS_PHY_D1", 0x5de,
+		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("W11_3430_USB1HS_PHY_D2", 0x5e0,
+		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("Y11_3430_USB1HS_PHY_D3", 0x5ea,
+		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("W9_3430_USB1HS_PHY_D4", 0x5e4,
+		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("Y12_3430_USB1HS_PHY_D5", 0x5e6,
+		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("W8_3430_USB1HS_PHY_D6", 0x5e8,
+		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("Y13_3430_USB1HS_PHY_D7", 0x5e2,
+		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
+
+/* PHY - HSUSB: 12-pin ULPI PHY: Port 2*/
+MUX_CFG_34XX("AA8_3430_USB2HS_PHY_CLK", 0x5f0,
+		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("AA10_3430_USB2HS_PHY_STP", 0x5f2,
+		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("AA9_3430_USB2HS_PHY_DIR", 0x5f4,
+		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("AB11_3430_USB2HS_PHY_NXT", 0x5f6,
+		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("AB10_3430_USB2HS_PHY_D0", 0x5f8,
+		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("AB9_3430_USB2HS_PHY_D1", 0x5fa,
+		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("W3_3430_USB2HS_PHY_D2", 0x1d4,
+		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("T4_3430_USB2HS_PHY_D3", 0x1de,
+		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("T3_3430_USB2HS_PHY_D4", 0x1d8,
+		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("R3_3430_USB2HS_PHY_D5", 0x1da,
+		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("R4_3430_USB2HS_PHY_D6", 0x1dc,
+		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("T2_3430_USB2HS_PHY_D7", 0x1d6,
+		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLDOWN)
+
+/* TLL - HSUSB: 12-pin TLL Port 1*/
+MUX_CFG_34XX("Y8_3430_USB1HS_TLL_CLK", 0x5da,
+		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("Y9_3430_USB1HS_TLL_STP", 0x5d8,
+		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("AA14_3430_USB1HS_TLL_DIR", 0x5ec,
+		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("AA11_3430_USB1HS_TLL_NXT", 0x5ee,
+		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("W13_3430_USB1HS_TLL_D0", 0x5dc,
+		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("W12_3430_USB1HS_TLL_D1", 0x5de,
+		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("W11_3430_USB1HS_TLL_D2", 0x5e0,
+		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("Y11_3430_USB1HS_TLL_D3", 0x5ea,
+		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("W9_3430_USB1HS_TLL_D4", 0x5e4,
+		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("Y12_3430_USB1HS_TLL_D5", 0x5e6,
+		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("W8_3430_USB1HS_TLL_D6", 0x5e8,
+		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("Y13_3430_USB1HS_TLL_D7", 0x5e2,
+		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
+
+/* TLL - HSUSB: 12-pin TLL Port 2*/
+MUX_CFG_34XX("AA8_3430_USB2HS_TLL_CLK", 0x5f0,
+		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("AA10_3430_USB2HS_TLL_STP", 0x5f2,
+		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("AA9_3430_USB2HS_TLL_DIR", 0x5f4,
+		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("AB11_3430_USB2HS_TLL_NXT", 0x5f6,
+		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("AB10_3430_USB2HS_TLL_D0", 0x5f8,
+		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("AB9_3430_USB2HS_TLL_D1", 0x5fa,
+		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("W3_3430_USB2HS_TLL_D2", 0x1d4,
+		OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("T4_3430_USB2HS_TLL_D3", 0x1de,
+		OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("T3_3430_USB2HS_TLL_D4", 0x1d8,
+		OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("R3_3430_USB2HS_TLL_D5", 0x1da,
+		OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("R4_3430_USB2HS_TLL_D6", 0x1dc,
+		OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("T2_3430_USB2HS_TLL_D7", 0x1d6,
+		OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLDOWN)
+
+/* TLL - HSUSB: 12-pin TLL Port 3*/
+MUX_CFG_34XX("AA6_3430_USB3HS_TLL_CLK", 0x180,
+		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("AB3_3430_USB3HS_TLL_STP", 0x166,
+		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("AA3_3430_USB3HS_TLL_DIR", 0x168,
+		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("Y3_3430_USB3HS_TLL_NXT", 0x16a,
+		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("AA5_3430_USB3HS_TLL_D0", 0x186,
+		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("Y4_3430_USB3HS_TLL_D1", 0x184,
+		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("Y5_3430_USB3HS_TLL_D2", 0x188,
+		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("W5_3430_USB3HS_TLL_D3", 0x18a,
+		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("AB12_3430_USB3HS_TLL_D4", 0x16c,
+		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("AB13_3430_USB3HS_TLL_D5", 0x16e,
+		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("AA13_3430_USB3HS_TLL_D6", 0x170,
+		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("AA12_3430_USB3HS_TLL_D7", 0x172,
+		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
+};
+
+#define OMAP34XX_PINS_SZ	ARRAY_SIZE(omap34xx_pins)
+
+#else
+#define omap34xx_pins		NULL
+#define OMAP34XX_PINS_SZ	0
+#endif	/* CONFIG_ARCH_OMAP34XX */
 
 #if defined(CONFIG_OMAP_MUX_DEBUG) || defined(CONFIG_OMAP_MUX_WARNINGS)
-void __init_or_module omap2_cfg_debug(const struct pin_config *cfg, u8 reg)
+static void __init_or_module omap2_cfg_debug(const struct pin_config *cfg, u16 reg)
 {
 	u16 orig;
 	u8 warn = 0, debug = 0;
 
-	orig = omap_ctrl_readb(cfg->mux_reg);
+	if (cpu_is_omap24xx())
+		orig = omap_ctrl_readb(cfg->mux_reg);
+	else
+		orig = omap_ctrl_readw(cfg->mux_reg);
 
 #ifdef	CONFIG_OMAP_MUX_DEBUG
 	debug = cfg->debug;
@@ -255,9 +418,9 @@ int __init_or_module omap24xx_cfg_reg(const struct pin_config *cfg)
 	spin_lock_irqsave(&mux_spin_lock, flags);
 	reg |= cfg->mask & 0x7;
 	if (cfg->pull_val)
-		reg |= OMAP24XX_PULL_ENA;
+		reg |= OMAP2_PULL_ENA;
 	if (cfg->pu_pd_val)
-		reg |= OMAP24XX_PULL_UP;
+		reg |= OMAP2_PULL_UP;
 	omap2_cfg_debug(cfg, reg);
 	omap_ctrl_writeb(reg, cfg->mux_reg);
 	spin_unlock_irqrestore(&mux_spin_lock, flags);
@@ -265,7 +428,26 @@ int __init_or_module omap24xx_cfg_reg(const struct pin_config *cfg)
 	return 0;
 }
 #else
-#define omap24xx_cfg_reg	0
+#define omap24xx_cfg_reg	NULL
+#endif
+
+#ifdef CONFIG_ARCH_OMAP34XX
+static int __init_or_module omap34xx_cfg_reg(const struct pin_config *cfg)
+{
+	static DEFINE_SPINLOCK(mux_spin_lock);
+	unsigned long flags;
+	u16 reg = 0;
+
+	spin_lock_irqsave(&mux_spin_lock, flags);
+	reg |= cfg->mux_val;
+	omap2_cfg_debug(cfg, reg);
+	omap_ctrl_writew(reg, cfg->mux_reg);
+	spin_unlock_irqrestore(&mux_spin_lock, flags);
+
+	return 0;
+}
+#else
+#define omap34xx_cfg_reg	NULL
 #endif
 
 int __init omap2_mux_init(void)
@@ -274,6 +456,10 @@ int __init omap2_mux_init(void)
 		arch_mux_cfg.pins	= omap24xx_pins;
 		arch_mux_cfg.size	= OMAP24XX_PINS_SZ;
 		arch_mux_cfg.cfg_reg	= omap24xx_cfg_reg;
+	} else if (cpu_is_omap34xx()) {
+		arch_mux_cfg.pins	= omap34xx_pins;
+		arch_mux_cfg.size	= OMAP34XX_PINS_SZ;
+		arch_mux_cfg.cfg_reg	= omap34xx_cfg_reg;
 	}
 
 	return omap_mux_register(&arch_mux_cfg);
diff --git a/arch/arm/plat-omap/include/mach/mux.h b/arch/arm/plat-omap/include/mach/mux.h
index 614b2c1..5670d56 100644
--- a/arch/arm/plat-omap/include/mach/mux.h
+++ b/arch/arm/plat-omap/include/mach/mux.h
@@ -125,20 +125,64 @@
 	.pu_pd_val	= pull_mode,				\
 },
 
-
-#define PULL_DISABLED	0
-#define PULL_ENABLED	1
-
-#define PULL_DOWN	0
-#define PULL_UP		1
+/* 24xx/34xx mux bit defines */
+#define OMAP2_PULL_ENA		(1 << 3)
+#define OMAP2_PULL_UP		(1 << 4)
+#define OMAP2_ALTELECTRICALSEL	(1 << 5)
+
+/* 34xx specific mux bit defines */
+#define OMAP3_INPUT_EN		(1 << 8)
+#define OMAP3_OFF_EN		(1 << 9)
+#define OMAP3_OFFOUT_EN		(1 << 10)
+#define OMAP3_OFFOUT_VAL	(1 << 11)
+#define OMAP3_OFF_PULL_EN	(1 << 12)
+#define OMAP3_OFF_PULL_UP	(1 << 13)
+#define OMAP3_WAKEUP_EN		(1 << 14)
+
+/* 34xx mux mode options for each pin. See TRM for options */
+#define	OMAP34XX_MUX_MODE0	0
+#define	OMAP34XX_MUX_MODE1	1
+#define	OMAP34XX_MUX_MODE2	2
+#define	OMAP34XX_MUX_MODE3	3
+#define	OMAP34XX_MUX_MODE4	4
+#define	OMAP34XX_MUX_MODE5	5
+#define	OMAP34XX_MUX_MODE6	6
+#define	OMAP34XX_MUX_MODE7	7
+
+/* 34xx active pin states */
+#define OMAP34XX_PIN_OUTPUT		0
+#define OMAP34XX_PIN_INPUT		OMAP3_INPUT_EN
+#define OMAP34XX_PIN_INPUT_PULLUP	(OMAP2_PULL_ENA | OMAP3_INPUT_EN \
+						| OMAP2_PULL_UP)
+#define OMAP34XX_PIN_INPUT_PULLDOWN	(OMAP2_PULL_ENA | OMAP3_INPUT_EN)
+
+/* 34xx off mode states */
+#define OMAP34XX_PIN_OFF_NONE           0
+#define OMAP34XX_PIN_OFF_OUTPUT_HIGH	(OMAP3_OFF_EN | OMAP3_OFFOUT_EN \
+						| OMAP3_OFFOUT_VAL)
+#define OMAP34XX_PIN_OFF_OUTPUT_LOW	(OMAP3_OFF_EN | OMAP3_OFFOUT_EN)
+#define OMAP34XX_PIN_OFF_INPUT_PULLUP	(OMAP3_OFF_EN | OMAP3_OFF_PULL_EN \
+						| OMAP3_OFF_PULL_UP)
+#define OMAP34XX_PIN_OFF_INPUT_PULLDOWN	(OMAP3_OFF_EN | OMAP3_OFF_PULL_EN)
+#define OMAP34XX_PIN_OFF_WAKEUPENABLE	OMAP3_WAKEUP_EN
+
+#define MUX_CFG_34XX(desc, reg_offset, mux_value) {		\
+	.name		= desc,					\
+	.debug		= 0,					\
+	.mux_reg	= reg_offset,				\
+	.mux_val	= mux_value				\
+},
 
 struct pin_config {
-	char *name;
-	unsigned char busy;
-	unsigned char debug;
+	char 			*name;
+	const unsigned int 	mux_reg;
+	unsigned char		debug;
 
-	const char *mux_reg_name;
-	const unsigned int mux_reg;
+#if	defined(CONFIG_ARCH_OMAP34XX)
+	u16			mux_val; /* Wake-up, off mode, pull, mux mode */
+#endif
+
+#if	defined(CONFIG_ARCH_OMAP1) || defined(CONFIG_ARCH_OMAP24XX)
 	const unsigned char mask_offset;
 	const unsigned char mask;
 
@@ -150,6 +194,12 @@ struct pin_config {
 	const char *pu_pd_name;
 	const unsigned int pu_pd_reg;
 	const unsigned char pu_pd_val;
+#endif
+
+#if	defined(CONFIG_OMAP_MUX_DEBUG) || defined(CONFIG_OMAP_MUX_WARNINGS)
+	const char *mux_reg_name;
+#endif
+
 };
 
 enum omap730_index {
@@ -593,6 +643,90 @@ enum omap24xx_index {
 
 };
 
+enum omap34xx_index {
+	/* 34xx I2C */
+	K21_34XX_I2C1_SCL,
+	J21_34XX_I2C1_SDA,
+	AF15_34XX_I2C2_SCL,
+	AE15_34XX_I2C2_SDA,
+	AF14_34XX_I2C3_SCL,
+	AG14_34XX_I2C3_SDA,
+	AD26_34XX_I2C4_SCL,
+	AE26_34XX_I2C4_SDA,
+
+	/* PHY - HSUSB: 12-pin ULPI PHY: Port 1*/
+	Y8_3430_USB1HS_PHY_CLK,
+	Y9_3430_USB1HS_PHY_STP,
+	AA14_3430_USB1HS_PHY_DIR,
+	AA11_3430_USB1HS_PHY_NXT,
+	W13_3430_USB1HS_PHY_DATA0,
+	W12_3430_USB1HS_PHY_DATA1,
+	W11_3430_USB1HS_PHY_DATA2,
+	Y11_3430_USB1HS_PHY_DATA3,
+	W9_3430_USB1HS_PHY_DATA4,
+	Y12_3430_USB1HS_PHY_DATA5,
+	W8_3430_USB1HS_PHY_DATA6,
+	Y13_3430_USB1HS_PHY_DATA7,
+
+	/* PHY - HSUSB: 12-pin ULPI PHY: Port 2*/
+	AA8_3430_USB2HS_PHY_CLK,
+	AA10_3430_USB2HS_PHY_STP,
+	AA9_3430_USB2HS_PHY_DIR,
+	AB11_3430_USB2HS_PHY_NXT,
+	AB10_3430_USB2HS_PHY_DATA0,
+	AB9_3430_USB2HS_PHY_DATA1,
+	W3_3430_USB2HS_PHY_DATA2,
+	T4_3430_USB2HS_PHY_DATA3,
+	T3_3430_USB2HS_PHY_DATA4,
+	R3_3430_USB2HS_PHY_DATA5,
+	R4_3430_USB2HS_PHY_DATA6,
+	T2_3430_USB2HS_PHY_DATA7,
+
+
+	/* TLL - HSUSB: 12-pin TLL Port 1*/
+	Y8_3430_USB1HS_TLL_CLK,
+	Y9_3430_USB1HS_TLL_STP,
+	AA14_3430_USB1HS_TLL_DIR,
+	AA11_3430_USB1HS_TLL_NXT,
+	W13_3430_USB1HS_TLL_DATA0,
+	W12_3430_USB1HS_TLL_DATA1,
+	W11_3430_USB1HS_TLL_DATA2,
+	Y11_3430_USB1HS_TLL_DATA3,
+	W9_3430_USB1HS_TLL_DATA4,
+	Y12_3430_USB1HS_TLL_DATA5,
+	W8_3430_USB1HS_TLL_DATA6,
+	Y13_3430_USB1HS_TLL_DATA7,
+
+	/* TLL - HSUSB: 12-pin TLL Port 2*/
+	AA8_3430_USB2HS_TLL_CLK,
+	AA10_3430_USB2HS_TLL_STP,
+	AA9_3430_USB2HS_TLL_DIR,
+	AB11_3430_USB2HS_TLL_NXT,
+	AB10_3430_USB2HS_TLL_DATA0,
+	AB9_3430_USB2HS_TLL_DATA1,
+	W3_3430_USB2HS_TLL_DATA2,
+	T4_3430_USB2HS_TLL_DATA3,
+	T3_3430_USB2HS_TLL_DATA4,
+	R3_3430_USB2HS_TLL_DATA5,
+	R4_3430_USB2HS_TLL_DATA6,
+	T2_3430_USB2HS_TLL_DATA7,
+
+	/* TLL - HSUSB: 12-pin TLL Port 3*/
+	AA6_3430_USB3HS_TLL_CLK,
+	AB3_3430_USB3HS_TLL_STP,
+	AA3_3430_USB3HS_TLL_DIR,
+	Y3_3430_USB3HS_TLL_NXT,
+	AA5_3430_USB3HS_TLL_DATA0,
+	Y4_3430_USB3HS_TLL_DATA1,
+	Y5_3430_USB3HS_TLL_DATA2,
+	W5_3430_USB3HS_TLL_DATA3,
+	AB12_3430_USB3HS_TLL_DATA4,
+	AB13_3430_USB3HS_TLL_DATA5,
+	AA13_3430_USB3HS_TLL_DATA6,
+	AA12_3430_USB3HS_TLL_DATA7
+
+};
+
 struct omap_mux_cfg {
 	struct pin_config	*pins;
 	unsigned long		size;
