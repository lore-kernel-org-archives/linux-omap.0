From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/7] OMAP4: Update common omap platform common sources,
	v3
Date: Tue, 19 May 2009 14:22:24 -0700
Message-ID: <20090519212223.GJ19742@atomide.com>
References: <1242739923-12514-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Tv3+oRj6D9L8lW+H"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57297 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbZESVWd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 17:22:33 -0400
Content-Disposition: inline
In-Reply-To: <1242739923-12514-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org


--Tv3+oRj6D9L8lW+H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Santosh Shilimkar <santosh.shilimkar@ti.com> [090519 06:32]:
> (patch is rebased on 2.6.30-rc6. The older version was based on 2.6.30-rc2)
> 
> This patch updates the common platform source  files for OMAP4430.
> Few OMAP4 peripherals are common with OMAP3 architecture.

Here's this one rebased on top of the omap for-next branch.

> --- a/arch/arm/plat-omap/common.c
> +++ b/arch/arm/plat-omap/common.c
> @@ -177,7 +181,8 @@ console_initcall(omap_add_serial_console);
>  
>  #if defined(CONFIG_ARCH_OMAP16XX)
>  #define TIMER_32K_SYNCHRONIZED		0xfffbc410
> -#elif defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> +#elif defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
> +		defined(CONFIG_ARCH_OMAP4)
>  #define TIMER_32K_SYNCHRONIZED		(OMAP2_32KSYNCT_BASE + 0x10)
>  #endif
>  

This part is no longer needed, so left out of the patch below.

Regards,

Tony

--Tv3+oRj6D9L8lW+H
Content-Type: text/x-diff; charset=iso-8859-1
Content-Disposition: inline; filename="common-sources.patch"
Content-Transfer-Encoding: 8bit

>From 6b08f71ce43cdf034eb72f03ad2621462e389e15 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Tue, 19 May 2009 13:51:46 -0700
Subject: [PATCH] ARM: OMAP4: Update common omap platform common sources, v3

This patch updates the common platform source  files for OMAP4430.
Few OMAP4 peripherals are common with OMAP3 architecture.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index febcacf..66738c3 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -2,6 +2,10 @@
  * linux/arch/arm/plat-omap/common.c
  *
  * Code common to all OMAP machines.
+ * The file is created by Tony Lindgren <tony@atomide.com>
+ *
+ * Copyright (C) 2009 Texas Instruments
+ * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -362,3 +366,19 @@ void __init omap2_set_globals_343x(void)
 }
 #endif
 
+#if defined(CONFIG_ARCH_OMAP4)
+static struct omap_globals omap4_globals = {
+	.class	= OMAP443X_CLASS,
+	.tap	= OMAP2_IO_ADDRESS(0x4830a000),
+	.ctrl	= OMAP2_IO_ADDRESS(OMAP443X_CTRL_BASE),
+	.prm	= OMAP2_IO_ADDRESS(OMAP4430_PRM_BASE),
+	.cm	= OMAP2_IO_ADDRESS(OMAP4430_CM_BASE),
+};
+
+void __init omap2_set_globals_443x(void)
+{
+	omap2_set_globals_tap(&omap4_globals);
+	omap2_set_globals_control(&omap4_globals);
+}
+#endif
+
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 87fb7ff..a64b692 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -311,6 +311,8 @@ static void omap_init_wdt(void)
 		wdt_resources[0].start = 0x49016000; /* WDT2 */
 	else if (cpu_is_omap343x())
 		wdt_resources[0].start = 0x48314000; /* WDT2 */
+	else if (cpu_is_omap44xx())
+		wdt_resources[0].start = 0x4a314000;
 	else
 		return;
 
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 06e9cbe..def14ec 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -10,6 +10,9 @@
  * Merged to support both OMAP1 and OMAP2 by Tony Lindgren <tony@atomide.com>
  * Some functions based on earlier dma-omap.c Copyright (C) 2001 RidgeRun, Inc.
  *
+ * Copyright (C) 2009 Texas Instruments
+ * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
  * Support functions for the OMAP internal DMA channels.
  *
  * This program is free software; you can redistribute it and/or modify
@@ -872,7 +875,7 @@ omap_dma_set_prio_lch(int lch, unsigned char read_prio,
 	}
 	l = dma_read(CCR(lch));
 	l &= ~((1 << 6) | (1 << 26));
-	if (cpu_is_omap2430() || cpu_is_omap34xx())
+	if (cpu_is_omap2430() || cpu_is_omap34xx() ||  cpu_is_omap44xx())
 		l |= ((read_prio & 0x1) << 6) | ((write_prio & 0x1) << 26);
 	else
 		l |= ((read_prio & 0x1) << 6);
@@ -1844,7 +1847,8 @@ static irqreturn_t omap1_dma_irq_handler(int irq, void *dev_id)
 #define omap1_dma_irq_handler	NULL
 #endif
 
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
+			defined(CONFIG_ARCH_OMAP4)
 
 static int omap2_dma_handle_ch(int ch)
 {
@@ -2339,6 +2343,9 @@ static int __init omap_init_dma(void)
 	} else if (cpu_is_omap34xx()) {
 		omap_dma_base = IO_ADDRESS(OMAP34XX_DMA4_BASE);
 		dma_lch_count = OMAP_DMA4_LOGICAL_DMA_CH_COUNT;
+	} else if (cpu_is_omap44xx()) {
+		omap_dma_base = IO_ADDRESS(OMAP44XX_DMA4_BASE);
+		dma_lch_count = OMAP_DMA4_LOGICAL_DMA_CH_COUNT;
 	} else {
 		pr_err("DMA init failed for unsupported omap\n");
 		return -ENODEV;
@@ -2437,12 +2444,18 @@ static int __init omap_init_dma(void)
 		}
 	}
 
-	if (cpu_is_omap2430() || cpu_is_omap34xx())
+	if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx())
 		omap_dma_set_global_params(DMA_DEFAULT_ARB_RATE,
 				DMA_DEFAULT_FIFO_DEPTH, 0);
 
-	if (cpu_class_is_omap2())
-		setup_irq(INT_24XX_SDMA_IRQ0, &omap24xx_dma_irq);
+	if (cpu_class_is_omap2()) {
+		int irq;
+		if (cpu_is_omap44xx())
+			irq = INT_44XX_SDMA_IRQ0;
+		else
+			irq = INT_24XX_SDMA_IRQ0;
+		setup_irq(irq, &omap24xx_dma_irq);
+	}
 
 	/* FIXME: Update LCD DMA to work on 24xx */
 	if (cpu_class_is_omap1()) {
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index ee20612..7f50b61 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -7,6 +7,9 @@
  * OMAP2 support by Juha Yrjola
  * API improvements and OMAP2 clock framework support by Timo Teras
  *
+ * Copyright (C) 2009 Texas Instruments
+ * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
  * Free Software Foundation; either version 2 of the License, or (at your
@@ -150,7 +153,8 @@
 struct omap_dm_timer {
 	unsigned long phys_base;
 	int irq;
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
+			defined(CONFIG_ARCH_OMAP4)
 	struct clk *iclk, *fclk;
 #endif
 	void __iomem *io_base;
@@ -169,6 +173,9 @@ struct omap_dm_timer {
 #define omap3_dm_timers			NULL
 #define omap3_dm_source_names		NULL
 #define omap3_dm_source_clocks		NULL
+#define omap4_dm_timers			NULL
+#define omap4_dm_source_names		NULL
+#define omap4_dm_source_clocks		NULL
 
 static struct omap_dm_timer omap1_dm_timers[] = {
 	{ .phys_base = 0xfffb1400, .irq = INT_1610_GPTIMER1 },
@@ -191,6 +198,9 @@ static const int dm_timer_count = ARRAY_SIZE(omap1_dm_timers);
 #define omap3_dm_timers			NULL
 #define omap3_dm_source_names		NULL
 #define omap3_dm_source_clocks		NULL
+#define omap4_dm_timers			NULL
+#define omap4_dm_source_names		NULL
+#define omap4_dm_source_clocks		NULL
 
 static struct omap_dm_timer omap2_dm_timers[] = {
 	{ .phys_base = 0x48028000, .irq = INT_24XX_GPTIMER1 },
@@ -225,6 +235,9 @@ static const int dm_timer_count = ARRAY_SIZE(omap2_dm_timers);
 #define omap2_dm_timers			NULL
 #define omap2_dm_source_names		NULL
 #define omap2_dm_source_clocks		NULL
+#define omap4_dm_timers			NULL
+#define omap4_dm_source_names		NULL
+#define omap4_dm_source_clocks		NULL
 
 static struct omap_dm_timer omap3_dm_timers[] = {
 	{ .phys_base = 0x48318000, .irq = INT_24XX_GPTIMER1 },
@@ -250,6 +263,40 @@ static const char *omap3_dm_source_names[] __initdata = {
 static struct clk *omap3_dm_source_clocks[2];
 static const int dm_timer_count = ARRAY_SIZE(omap3_dm_timers);
 
+#elif defined(CONFIG_ARCH_OMAP4)
+
+#define omap_dm_clk_enable(x)		clk_enable(x)
+#define omap_dm_clk_disable(x)		clk_disable(x)
+#define omap1_dm_timers			NULL
+#define omap2_dm_timers			NULL
+#define omap2_dm_source_names		NULL
+#define omap2_dm_source_clocks		NULL
+#define omap3_dm_timers			NULL
+#define omap3_dm_source_names		NULL
+#define omap3_dm_source_clocks		NULL
+
+static struct omap_dm_timer omap4_dm_timers[] = {
+	{ .phys_base = 0x4a318000, .irq = INT_44XX_GPTIMER1 },
+	{ .phys_base = 0x48032000, .irq = INT_44XX_GPTIMER2 },
+	{ .phys_base = 0x48034000, .irq = INT_44XX_GPTIMER3 },
+	{ .phys_base = 0x48036000, .irq = INT_44XX_GPTIMER4 },
+	{ .phys_base = 0x40138000, .irq = INT_44XX_GPTIMER5 },
+	{ .phys_base = 0x4013a000, .irq = INT_44XX_GPTIMER6 },
+	{ .phys_base = 0x4013a000, .irq = INT_44XX_GPTIMER7 },
+	{ .phys_base = 0x4013e000, .irq = INT_44XX_GPTIMER8 },
+	{ .phys_base = 0x4803e000, .irq = INT_44XX_GPTIMER9 },
+	{ .phys_base = 0x48086000, .irq = INT_44XX_GPTIMER10 },
+	{ .phys_base = 0x48088000, .irq = INT_44XX_GPTIMER11 },
+	{ .phys_base = 0x4a320000, .irq = INT_44XX_GPTIMER12 },
+};
+static const char *omap4_dm_source_names[] __initdata = {
+	"sys_ck",
+	"omap_32k_fck",
+	NULL
+};
+static struct clk *omap4_dm_source_clocks[2];
+static const int dm_timer_count = ARRAY_SIZE(omap4_dm_timers);
+
 #else
 
 #error OMAP architecture not supported!
@@ -459,7 +506,8 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_modify_idlect_mask);
 
-#elif defined(CONFIG_ARCH_OMAP2) || defined (CONFIG_ARCH_OMAP3)
+#elif defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
+				defined(CONFIG_ARCH_OMAP4)
 
 struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
 {
@@ -711,6 +759,10 @@ int __init omap_dm_timer_init(void)
 		dm_timers = omap3_dm_timers;
 		dm_source_names = omap3_dm_source_names;
 		dm_source_clocks = omap3_dm_source_clocks;
+	} else if (cpu_is_omap44xx()) {
+		dm_timers = omap4_dm_timers;
+		dm_source_names = omap4_dm_source_names;
+		dm_source_clocks = omap4_dm_source_clocks;
 	}
 
 	if (cpu_class_is_omap2())
@@ -723,7 +775,8 @@ int __init omap_dm_timer_init(void)
 	for (i = 0; i < dm_timer_count; i++) {
 		timer = &dm_timers[i];
 		timer->io_base = IO_ADDRESS(timer->phys_base);
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
+					defined(CONFIG_ARCH_OMAP4)
 		if (cpu_class_is_omap2()) {
 			char clk_name[16];
 			sprintf(clk_name, "gpt%d_ick", i + 1);
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index ee0b21f..7fd89ba 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -6,6 +6,9 @@
  * Copyright (C) 2003-2005 Nokia Corporation
  * Written by Juha Yrjölä <juha.yrjola@nokia.com>
  *
+ * Copyright (C) 2009 Texas Instruments
+ * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -146,6 +149,16 @@
 #define OMAP34XX_GPIO5_BASE		IO_ADDRESS(0x49056000)
 #define OMAP34XX_GPIO6_BASE		IO_ADDRESS(0x49058000)
 
+/*
+ * OMAP44XX  specific GPIO registers
+ */
+#define OMAP44XX_GPIO1_BASE             IO_ADDRESS(0x4a310000)
+#define OMAP44XX_GPIO2_BASE             IO_ADDRESS(0x48055000)
+#define OMAP44XX_GPIO3_BASE             IO_ADDRESS(0x48057000)
+#define OMAP44XX_GPIO4_BASE             IO_ADDRESS(0x48059000)
+#define OMAP44XX_GPIO5_BASE             IO_ADDRESS(0x4805B000)
+#define OMAP44XX_GPIO6_BASE             IO_ADDRESS(0x4805D000)
+
 #define OMAP_MPUIO_VBASE		IO_ADDRESS(OMAP_MPUIO_BASE)
 
 struct gpio_bank {
@@ -153,11 +166,13 @@ struct gpio_bank {
 	u16 irq;
 	u16 virtual_irq_start;
 	int method;
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) ||  \
+		defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP4)
 	u32 suspend_wakeup;
 	u32 saved_wakeup;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+			defined(CONFIG_ARCH_OMAP4)
 	u32 non_wakeup_gpios;
 	u32 enabled_non_wakeup_gpios;
 
@@ -251,6 +266,24 @@ static struct gpio_bank gpio_bank_34xx[6] = {
 
 #endif
 
+#ifdef CONFIG_ARCH_OMAP4
+static struct gpio_bank gpio_bank_44xx[6] = {
+	{ OMAP44XX_GPIO1_BASE, INT_44XX_GPIO_BANK1, IH_GPIO_BASE,	\
+		METHOD_GPIO_24XX },
+	{ OMAP44XX_GPIO2_BASE, INT_44XX_GPIO_BANK2, IH_GPIO_BASE + 32,	\
+		METHOD_GPIO_24XX },
+	{ OMAP44XX_GPIO3_BASE, INT_44XX_GPIO_BANK3, IH_GPIO_BASE + 64,	\
+		METHOD_GPIO_24XX },
+	{ OMAP44XX_GPIO4_BASE, INT_44XX_GPIO_BANK4, IH_GPIO_BASE + 96,	\
+		METHOD_GPIO_24XX },
+	{ OMAP44XX_GPIO5_BASE, INT_44XX_GPIO_BANK5, IH_GPIO_BASE + 128, \
+		METHOD_GPIO_24XX },
+	{ OMAP44XX_GPIO6_BASE, INT_44XX_GPIO_BANK6, IH_GPIO_BASE + 160, \
+		METHOD_GPIO_24XX },
+};
+
+#endif
+
 static struct gpio_bank *gpio_bank;
 static int gpio_bank_count;
 
@@ -273,7 +306,7 @@ static inline struct gpio_bank *get_gpio_bank(int gpio)
 	}
 	if (cpu_is_omap24xx())
 		return &gpio_bank[gpio >> 5];
-	if (cpu_is_omap34xx())
+	if (cpu_is_omap34xx() || cpu_is_omap44xx())
 		return &gpio_bank[gpio >> 5];
 	BUG();
 	return NULL;
@@ -285,7 +318,7 @@ static inline int get_gpio_index(int gpio)
 		return gpio & 0x1f;
 	if (cpu_is_omap24xx())
 		return gpio & 0x1f;
-	if (cpu_is_omap34xx())
+	if (cpu_is_omap34xx() || cpu_is_omap44xx())
 		return gpio & 0x1f;
 	return gpio & 0x0f;
 }
@@ -307,7 +340,7 @@ static inline int gpio_valid(int gpio)
 		return 0;
 	if (cpu_is_omap24xx() && gpio < 128)
 		return 0;
-	if (cpu_is_omap34xx() && gpio < 192)
+	if ((cpu_is_omap34xx() || cpu_is_omap44xx()) && gpio < 192)
 		return 0;
 	return -1;
 }
@@ -353,7 +386,8 @@ static void _set_gpio_direction(struct gpio_bank *bank, int gpio, int is_input)
 		reg += OMAP850_GPIO_DIR_CONTROL;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+			defined(CONFIG_ARCH_OMAP4)
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_OE;
 		break;
@@ -425,7 +459,8 @@ static void _set_gpio_dataout(struct gpio_bank *bank, int gpio, int enable)
 			l &= ~(1 << gpio);
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+			defined(CONFIG_ARCH_OMAP4)
 	case METHOD_GPIO_24XX:
 		if (enable)
 			reg += OMAP24XX_GPIO_SETDATAOUT;
@@ -476,7 +511,8 @@ static int __omap_get_gpio_datain(int gpio)
 		reg += OMAP850_GPIO_DATA_INPUT;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+			defined(CONFIG_ARCH_OMAP4)
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_DATAIN;
 		break;
@@ -520,7 +556,7 @@ void omap_set_gpio_debounce(int gpio, int enable)
 	else
 		goto done;
 
-	if (cpu_is_omap34xx()) {
+	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
 		if (enable)
 			clk_enable(bank->dbck);
 		else
@@ -550,7 +586,8 @@ void omap_set_gpio_debounce_time(int gpio, int enc_time)
 }
 EXPORT_SYMBOL(omap_set_gpio_debounce_time);
 
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+				defined(CONFIG_ARCH_OMAP4)
 static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
 						int trigger)
 {
@@ -660,7 +697,8 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
 			goto bad;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+				defined(CONFIG_ARCH_OMAP4)
 	case METHOD_GPIO_24XX:
 		set_24xx_gpio_triggering(bank, gpio, trigger);
 		break;
@@ -745,7 +783,8 @@ static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 		reg += OMAP850_GPIO_INT_STATUS;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+				defined(CONFIG_ARCH_OMAP4)
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_IRQSTATUS1;
 		break;
@@ -814,7 +853,8 @@ static u32 _get_gpio_irqbank_mask(struct gpio_bank *bank)
 		inv = 1;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+				defined(CONFIG_ARCH_OMAP4)
 	case METHOD_GPIO_24XX:
 		reg += OMAP24XX_GPIO_IRQENABLE1;
 		mask = 0xffffffff;
@@ -887,7 +927,8 @@ static void _enable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask, int enab
 			l |= gpio_mask;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+		defined(CONFIG_ARCH_OMAP4)
 	case METHOD_GPIO_24XX:
 		if (enable)
 			reg += OMAP24XX_GPIO_SETIRQENABLE1;
@@ -932,7 +973,8 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 		spin_unlock_irqrestore(&bank->lock, flags);
 		return 0;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+				defined(CONFIG_ARCH_OMAP4)
 	case METHOD_GPIO_24XX:
 		if (bank->non_wakeup_gpios & (1 << gpio)) {
 			printk(KERN_ERR "Unable to modify wakeup on "
@@ -1017,7 +1059,8 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 		__raw_writel(1 << offset, reg);
 	}
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+				defined(CONFIG_ARCH_OMAP4)
 	if (bank->method == METHOD_GPIO_24XX) {
 		/* Disable wake-up during idle for dynamic tick */
 		void __iomem *reg = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
@@ -1069,7 +1112,8 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	if (bank->method == METHOD_GPIO_850)
 		isr_reg = bank->base + OMAP850_GPIO_INT_STATUS;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+				defined(CONFIG_ARCH_OMAP4)
 	if (bank->method == METHOD_GPIO_24XX)
 		isr_reg = bank->base + OMAP24XX_GPIO_IRQSTATUS1;
 #endif
@@ -1346,7 +1390,7 @@ static int gpio_2irq(struct gpio_chip *chip, unsigned offset)
 /*---------------------------------------------------------------------*/
 
 static int initialized;
-#if !defined(CONFIG_ARCH_OMAP3)
+#if !(defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4))
 static struct clk * gpio_ick;
 #endif
 
@@ -1359,7 +1403,7 @@ static struct clk * gpio5_ick;
 static struct clk * gpio5_fck;
 #endif
 
-#if defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 static struct clk *gpio_iclks[OMAP34XX_NR_GPIOS];
 #endif
 
@@ -1419,8 +1463,8 @@ static int __init _omap_gpio_init(void)
 	}
 #endif
 
-#if defined(CONFIG_ARCH_OMAP3)
-	if (cpu_is_omap34xx()) {
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
+	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
 		for (i = 0; i < OMAP34XX_NR_GPIOS; i++) {
 			sprintf(clk_name, "gpio%d_ick", i + 1);
 			gpio_iclks[i] = clk_get(NULL, clk_name);
@@ -1497,6 +1541,17 @@ static int __init _omap_gpio_init(void)
 			(rev >> 4) & 0x0f, rev & 0x0f);
 	}
 #endif
+#ifdef CONFIG_ARCH_OMAP4
+	if (cpu_is_omap44xx()) {
+		int rev;
+
+		gpio_bank_count = OMAP34XX_NR_GPIOS;
+		gpio_bank = gpio_bank_44xx;
+		rev = __raw_readl(gpio_bank[0].base + OMAP24XX_GPIO_REVISION);
+		printk(KERN_INFO "OMAP44xx GPIO hardware version %d.%d\n",
+			(rev >> 4) & 0x0f, rev & 0x0f);
+	}
+#endif
 	for (i = 0; i < gpio_bank_count; i++) {
 		int j, gpio_count = 16;
 
@@ -1520,7 +1575,8 @@ static int __init _omap_gpio_init(void)
 			gpio_count = 32; /* 730 has 32-bit GPIOs */
 		}
 
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+				defined(CONFIG_ARCH_OMAP4)
 		if (bank->method == METHOD_GPIO_24XX) {
 			static const u32 non_wakeup_gpios[] = {
 				0xe203ffc0, 0x08700040
@@ -1577,7 +1633,7 @@ static int __init _omap_gpio_init(void)
 		set_irq_chained_handler(bank->irq, gpio_irq_handler);
 		set_irq_data(bank->irq, bank);
 
-		if (cpu_is_omap34xx()) {
+		if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
 			sprintf(clk_name, "gpio%d_dbck", i + 1);
 			bank->dbck = clk_get(NULL, clk_name);
 			if (IS_ERR(bank->dbck))
@@ -1599,7 +1655,8 @@ static int __init _omap_gpio_init(void)
 	return 0;
 }
 
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) || \
+		defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP4)
 static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
 {
 	int i;
@@ -1622,7 +1679,8 @@ static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
 			wake_set = bank->base + OMAP1610_GPIO_SET_WAKEUPENA;
 			break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+				defined(CONFIG_ARCH_OMAP4)
 		case METHOD_GPIO_24XX:
 			wake_status = bank->base + OMAP24XX_GPIO_WAKE_EN;
 			wake_clear = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
@@ -1663,7 +1721,8 @@ static int omap_gpio_resume(struct sys_device *dev)
 			wake_set = bank->base + OMAP1610_GPIO_SET_WAKEUPENA;
 			break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+			defined(CONFIG_ARCH_OMAP4)
 		case METHOD_GPIO_24XX:
 			wake_clear = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
 			wake_set = bank->base + OMAP24XX_GPIO_SETWKUENA;
@@ -1695,7 +1754,8 @@ static struct sys_device omap_gpio_device = {
 
 #endif
 
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+				defined(CONFIG_ARCH_OMAP4)
 
 static int workaround_enabled;
 
@@ -1711,7 +1771,8 @@ void omap2_gpio_prepare_for_retention(void)
 
 		if (!(bank->enabled_non_wakeup_gpios))
 			continue;
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+				defined(CONFIG_ARCH_OMAP4)
 		bank->saved_datain = __raw_readl(bank->base + OMAP24XX_GPIO_DATAIN);
 		l1 = __raw_readl(bank->base + OMAP24XX_GPIO_FALLINGDETECT);
 		l2 = __raw_readl(bank->base + OMAP24XX_GPIO_RISINGDETECT);
@@ -1720,7 +1781,8 @@ void omap2_gpio_prepare_for_retention(void)
 		bank->saved_risingdetect = l2;
 		l1 &= ~bank->enabled_non_wakeup_gpios;
 		l2 &= ~bank->enabled_non_wakeup_gpios;
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+			defined(CONFIG_ARCH_OMAP4)
 		__raw_writel(l1, bank->base + OMAP24XX_GPIO_FALLINGDETECT);
 		__raw_writel(l2, bank->base + OMAP24XX_GPIO_RISINGDETECT);
 #endif
@@ -1745,7 +1807,8 @@ void omap2_gpio_resume_after_retention(void)
 
 		if (!(bank->enabled_non_wakeup_gpios))
 			continue;
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+			defined(CONFIG_ARCH_OMAP4)
 		__raw_writel(bank->saved_fallingdetect,
 				 bank->base + OMAP24XX_GPIO_FALLINGDETECT);
 		__raw_writel(bank->saved_risingdetect,
@@ -1755,14 +1818,16 @@ void omap2_gpio_resume_after_retention(void)
 		 * state.  If so, generate an IRQ by software.  This is
 		 * horribly racy, but it's the best we can do to work around
 		 * this silicon bug. */
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+			defined(CONFIG_ARCH_OMAP4)
 		l = __raw_readl(bank->base + OMAP24XX_GPIO_DATAIN);
 #endif
 		l ^= bank->saved_datain;
 		l &= bank->non_wakeup_gpios;
 		if (l) {
 			u32 old0, old1;
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+			defined(CONFIG_ARCH_OMAP4)
 			old0 = __raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0);
 			old1 = __raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
 			__raw_writel(old0 | l, bank->base + OMAP24XX_GPIO_LEVELDETECT0);
@@ -1798,7 +1863,8 @@ static int __init omap_gpio_sysinit(void)
 
 	mpuio_init();
 
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) || \
+		defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP4)
 	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
 		if (ret == 0) {
 			ret = sysdev_class_register(&omap_gpio_sysclass);
@@ -1887,7 +1953,7 @@ static int dbg_gpio_show(struct seq_file *s, void *unused)
 
 			irqstat = irq_desc[irq].status;
 #if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) ||	\
-		defined(CONFIG_ARCH_OMAP34XX)
+		defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP4)
 			if (is_in && ((bank->suspend_wakeup & mask)
 					|| irqstat & IRQ_TYPE_SENSE_MASK)) {
 				char	*trigger = NULL;
diff --git a/arch/arm/plat-omap/io.c b/arch/arm/plat-omap/io.c
index af326ef..9b42d72 100644
--- a/arch/arm/plat-omap/io.c
+++ b/arch/arm/plat-omap/io.c
@@ -1,3 +1,14 @@
+/*
+ * Common io.c file
+ * This file is created by Russell King <rmk+kernel@arm.linux.org.uk>
+ *
+ * Copyright (C) 2009 Texas Instruments
+ * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/mm.h>
@@ -7,6 +18,7 @@
 #include <mach/omap16xx.h>
 #include <mach/omap24xx.h>
 #include <mach/omap34xx.h>
+#include <mach/omap44xx.h>
 
 #define BETWEEN(p,st,sz)	((p) >= (st) && (p) < ((st) + (sz)))
 #define XLATE(p,pst,vst)	((void __iomem *)((p) - (pst) + (vst)))
@@ -92,7 +104,22 @@ void __iomem *omap_ioremap(unsigned long p, size_t size, unsigned int type)
 			return XLATE(p, L4_EMU_34XX_PHYS, L4_EMU_34XX_VIRT);
 	}
 #endif
-
+#ifdef CONFIG_ARCH_OMAP4
+	if (cpu_is_omap44xx()) {
+		if (BETWEEN(p, L3_44XX_PHYS, L3_44XX_SIZE))
+			return XLATE(p, L3_44XX_PHYS, L3_44XX_VIRT);
+		if (BETWEEN(p, L4_44XX_PHYS, L4_44XX_SIZE))
+			return XLATE(p, L4_44XX_PHYS, L4_44XX_VIRT);
+		if (BETWEEN(p, L4_WK_44XX_PHYS, L4_WK_44XX_SIZE))
+			return XLATE(p, L4_WK_44XX_PHYS, L4_WK_44XX_VIRT);
+		if (BETWEEN(p, OMAP44XX_GPMC_PHYS, OMAP44XX_GPMC_SIZE))
+			return XLATE(p, OMAP44XX_GPMC_PHYS, OMAP44XX_GPMC_VIRT);
+		if (BETWEEN(p, L4_PER_44XX_PHYS, L4_PER_44XX_SIZE))
+			return XLATE(p, L4_PER_44XX_PHYS, L4_PER_44XX_VIRT);
+		if (BETWEEN(p, L4_EMU_44XX_PHYS, L4_EMU_44XX_SIZE))
+			return XLATE(p, L4_EMU_44XX_PHYS, L4_EMU_44XX_VIRT);
+	}
+#endif
 	return __arm_ioremap(p, size, type);
 }
 EXPORT_SYMBOL(omap_ioremap);
diff --git a/arch/arm/plat-omap/mux.c b/arch/arm/plat-omap/mux.c
index 80b040f..8d329fb 100644
--- a/arch/arm/plat-omap/mux.c
+++ b/arch/arm/plat-omap/mux.c
@@ -54,6 +54,9 @@ int __init_or_module omap_cfg_reg(const unsigned long index)
 {
 	struct pin_config *reg;
 
+	if (cpu_is_omap44xx())
+		return 0;
+
 	if (mux_cfg == NULL) {
 		printk(KERN_ERR "Pin mux table not initialized\n");
 		return -ENODEV;
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 102c9f7..67a9070 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -6,6 +6,9 @@
  * Copyright (C) 2005 Nokia Corporation
  * Written by Tony Lindgren <tony@atomide.com>
  *
+ * Copyright (C) 2009 Texas Instruments
+ * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -44,6 +47,8 @@
 #define OMAP3_SRAM_VA           0xd7000000
 #define OMAP3_SRAM_PUB_PA       0x40208000
 #define OMAP3_SRAM_PUB_VA       0xd7008000
+#define OMAP4_SRAM_PA		0x40200000		/*0x402f0000*/
+#define OMAP4_SRAM_VA		0xd7000000		/*0xd70f0000*/
 
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 #define SRAM_BOOTLOADER_SZ	0x00
@@ -87,6 +92,10 @@ static int is_sram_locked(void)
 {
 	int type = 0;
 
+	if (cpu_is_omap44xx())
+		/* Not yet supported */
+		return 0;
+
 	if (cpu_is_omap242x())
 		type = omap_rev() & OMAP2_DEVICETYPE_MASK;
 
@@ -135,6 +144,10 @@ void __init omap_detect_sram(void)
 				omap_sram_base = OMAP3_SRAM_VA;
 				omap_sram_start = OMAP3_SRAM_PA;
 				omap_sram_size = 0x10000; /* 64K */
+			} else if (cpu_is_omap44xx()) {
+				omap_sram_base = OMAP4_SRAM_VA;
+				omap_sram_start = OMAP4_SRAM_PA;
+				omap_sram_size = 0x8000; /* 32K */
 			} else {
 				omap_sram_base = OMAP2_SRAM_VA;
 				omap_sram_start = OMAP2_SRAM_PA;
@@ -203,6 +216,12 @@ void __init omap_map_sram(void)
 		omap_sram_io_desc[0].pfn = __phys_to_pfn(base);
 	}
 
+	if (cpu_is_omap44xx()) {
+		omap_sram_io_desc[0].virtual = OMAP4_SRAM_VA;
+		base = OMAP4_SRAM_PA;
+		base = ROUND_DOWN(base, PAGE_SIZE);
+		omap_sram_io_desc[0].pfn = __phys_to_pfn(base);
+	}
 	omap_sram_io_desc[0].length = 1024 * 1024;	/* Use section desc */
 	iotable_init(omap_sram_io_desc, ARRAY_SIZE(omap_sram_io_desc));
 
@@ -391,6 +410,8 @@ int __init omap_sram_init(void)
 		omap243x_sram_init();
 	else if (cpu_is_omap34xx())
 		omap34xx_sram_init();
+	else if (cpu_is_omap44xx())
+		omap34xx_sram_init(); /* FIXME: */
 
 	return 0;
 }

--Tv3+oRj6D9L8lW+H--
