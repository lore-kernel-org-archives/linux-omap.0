From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RESUBMIT][PATCH 4/7 v2] OMAP4: Update common omap platform common sources.
Date: Tue, 19 May 2009 19:02:03 +0530
Message-ID: <1242739923-12514-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36606 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752866AbZESNcO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 May 2009 09:32:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

(patch is rebased on 2.6.30-rc6. The older version was based on 2.6.30-=
rc2)

This patch updates the common platform source  files for OMAP4430.
=46ew OMAP4 peripherals are common with OMAP3 architecture.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/common.c  |   23 +++++++-
 arch/arm/plat-omap/devices.c |    2 +
 arch/arm/plat-omap/dma.c     |   23 ++++++--
 arch/arm/plat-omap/dmtimer.c |   59 +++++++++++++++++-
 arch/arm/plat-omap/gpio.c    |  134 +++++++++++++++++++++++++++++++---=
--------
 arch/arm/plat-omap/io.c      |   29 +++++++++-
 arch/arm/plat-omap/mux.c     |    3 +
 arch/arm/plat-omap/sram.c    |   21 +++++++
 8 files changed, 250 insertions(+), 44 deletions(-)

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index cee12c6..63b7af8 100644
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
  * This program is free software; you can redistribute it and/or modif=
y
  * it under the terms of the GNU General Public License version 2 as
@@ -177,7 +181,8 @@ console_initcall(omap_add_serial_console);
=20
 #if defined(CONFIG_ARCH_OMAP16XX)
 #define TIMER_32K_SYNCHRONIZED		0xfffbc410
-#elif defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#elif defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) |=
| \
+		defined(CONFIG_ARCH_OMAP4)
 #define TIMER_32K_SYNCHRONIZED		(OMAP2_32KSYNCT_BASE + 0x10)
 #endif
=20
@@ -304,3 +309,19 @@ void __init omap2_set_globals_343x(void)
 }
 #endif
=20
+#if defined(CONFIG_ARCH_OMAP4)
+static struct omap_globals omap4_globals =3D {
+	.class	=3D OMAP443X_CLASS,
+	.tap	=3D OMAP2_IO_ADDRESS(0x4830a000),
+	.ctrl	=3D OMAP2_IO_ADDRESS(OMAP443X_CTRL_BASE),
+	.prm	=3D OMAP2_IO_ADDRESS(OMAP4430_PRM_BASE),
+	.cm	=3D OMAP2_IO_ADDRESS(OMAP4430_CM_BASE),
+};
+
+void __init omap2_set_globals_443x(void)
+{
+	omap2_set_globals_tap(&omap4_globals);
+	omap2_set_globals_control(&omap4_globals);
+}
+#endif
+
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.=
c
index 87fb7ff..a64b692 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -311,6 +311,8 @@ static void omap_init_wdt(void)
 		wdt_resources[0].start =3D 0x49016000; /* WDT2 */
 	else if (cpu_is_omap343x())
 		wdt_resources[0].start =3D 0x48314000; /* WDT2 */
+	else if (cpu_is_omap44xx())
+		wdt_resources[0].start =3D 0x4a314000;
 	else
 		return;
=20
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 7fc8c04..a1b88fb 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -10,6 +10,9 @@
  * Merged to support both OMAP1 and OMAP2 by Tony Lindgren <tony@atomi=
de.com>
  * Some functions based on earlier dma-omap.c Copyright (C) 2001 Ridge=
Run, Inc.
  *
+ * Copyright (C) 2009 Texas Instruments
+ * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
  * Support functions for the OMAP internal DMA channels.
  *
  * This program is free software; you can redistribute it and/or modif=
y
@@ -851,7 +854,7 @@ omap_dma_set_prio_lch(int lch, unsigned char read_p=
rio,
 	}
 	l =3D dma_read(CCR(lch));
 	l &=3D ~((1 << 6) | (1 << 26));
-	if (cpu_is_omap2430() || cpu_is_omap34xx())
+	if (cpu_is_omap2430() || cpu_is_omap34xx() ||  cpu_is_omap44xx())
 		l |=3D ((read_prio & 0x1) << 6) | ((write_prio & 0x1) << 26);
 	else
 		l |=3D ((read_prio & 0x1) << 6);
@@ -1823,7 +1826,8 @@ static irqreturn_t omap1_dma_irq_handler(int irq,=
 void *dev_id)
 #define omap1_dma_irq_handler	NULL
 #endif
=20
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
+			defined(CONFIG_ARCH_OMAP4)
=20
 static int omap2_dma_handle_ch(int ch)
 {
@@ -2318,6 +2322,9 @@ static int __init omap_init_dma(void)
 	} else if (cpu_is_omap34xx()) {
 		omap_dma_base =3D IO_ADDRESS(OMAP34XX_DMA4_BASE);
 		dma_lch_count =3D OMAP_DMA4_LOGICAL_DMA_CH_COUNT;
+	} else if (cpu_is_omap44xx()) {
+		omap_dma_base =3D IO_ADDRESS(OMAP44XX_DMA4_BASE);
+		dma_lch_count =3D OMAP_DMA4_LOGICAL_DMA_CH_COUNT;
 	} else {
 		pr_err("DMA init failed for unsupported omap\n");
 		return -ENODEV;
@@ -2416,12 +2423,18 @@ static int __init omap_init_dma(void)
 		}
 	}
=20
-	if (cpu_is_omap2430() || cpu_is_omap34xx())
+	if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx())
 		omap_dma_set_global_params(DMA_DEFAULT_ARB_RATE,
 				DMA_DEFAULT_FIFO_DEPTH, 0);
=20
-	if (cpu_class_is_omap2())
-		setup_irq(INT_24XX_SDMA_IRQ0, &omap24xx_dma_irq);
+	if (cpu_class_is_omap2()) {
+		int irq;
+		if (cpu_is_omap44xx())
+			irq =3D INT_44XX_SDMA_IRQ0;
+		else
+			irq =3D INT_24XX_SDMA_IRQ0;
+		setup_irq(irq, &omap24xx_dma_irq);
+	}
=20
 	/* FIXME: Update LCD DMA to work on 24xx */
 	if (cpu_class_is_omap1()) {
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.=
c
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
  * This program is free software; you can redistribute it and/or modif=
y it
  * under the terms of the GNU General Public License as published by t=
he
  * Free Software Foundation; either version 2 of the License, or (at y=
our
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
=20
 static struct omap_dm_timer omap1_dm_timers[] =3D {
 	{ .phys_base =3D 0xfffb1400, .irq =3D INT_1610_GPTIMER1 },
@@ -191,6 +198,9 @@ static const int dm_timer_count =3D ARRAY_SIZE(omap=
1_dm_timers);
 #define omap3_dm_timers			NULL
 #define omap3_dm_source_names		NULL
 #define omap3_dm_source_clocks		NULL
+#define omap4_dm_timers			NULL
+#define omap4_dm_source_names		NULL
+#define omap4_dm_source_clocks		NULL
=20
 static struct omap_dm_timer omap2_dm_timers[] =3D {
 	{ .phys_base =3D 0x48028000, .irq =3D INT_24XX_GPTIMER1 },
@@ -225,6 +235,9 @@ static const int dm_timer_count =3D ARRAY_SIZE(omap=
2_dm_timers);
 #define omap2_dm_timers			NULL
 #define omap2_dm_source_names		NULL
 #define omap2_dm_source_clocks		NULL
+#define omap4_dm_timers			NULL
+#define omap4_dm_source_names		NULL
+#define omap4_dm_source_clocks		NULL
=20
 static struct omap_dm_timer omap3_dm_timers[] =3D {
 	{ .phys_base =3D 0x48318000, .irq =3D INT_24XX_GPTIMER1 },
@@ -250,6 +263,40 @@ static const char *omap3_dm_source_names[] __initd=
ata =3D {
 static struct clk *omap3_dm_source_clocks[2];
 static const int dm_timer_count =3D ARRAY_SIZE(omap3_dm_timers);
=20
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
+static struct omap_dm_timer omap4_dm_timers[] =3D {
+	{ .phys_base =3D 0x4a318000, .irq =3D INT_44XX_GPTIMER1 },
+	{ .phys_base =3D 0x48032000, .irq =3D INT_44XX_GPTIMER2 },
+	{ .phys_base =3D 0x48034000, .irq =3D INT_44XX_GPTIMER3 },
+	{ .phys_base =3D 0x48036000, .irq =3D INT_44XX_GPTIMER4 },
+	{ .phys_base =3D 0x40138000, .irq =3D INT_44XX_GPTIMER5 },
+	{ .phys_base =3D 0x4013a000, .irq =3D INT_44XX_GPTIMER6 },
+	{ .phys_base =3D 0x4013a000, .irq =3D INT_44XX_GPTIMER7 },
+	{ .phys_base =3D 0x4013e000, .irq =3D INT_44XX_GPTIMER8 },
+	{ .phys_base =3D 0x4803e000, .irq =3D INT_44XX_GPTIMER9 },
+	{ .phys_base =3D 0x48086000, .irq =3D INT_44XX_GPTIMER10 },
+	{ .phys_base =3D 0x48088000, .irq =3D INT_44XX_GPTIMER11 },
+	{ .phys_base =3D 0x4a320000, .irq =3D INT_44XX_GPTIMER12 },
+};
+static const char *omap4_dm_source_names[] __initdata =3D {
+	"sys_ck",
+	"omap_32k_fck",
+	NULL
+};
+static struct clk *omap4_dm_source_clocks[2];
+static const int dm_timer_count =3D ARRAY_SIZE(omap4_dm_timers);
+
 #else
=20
 #error OMAP architecture not supported!
@@ -459,7 +506,8 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputm=
ask)
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_modify_idlect_mask);
=20
-#elif defined(CONFIG_ARCH_OMAP2) || defined (CONFIG_ARCH_OMAP3)
+#elif defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
+				defined(CONFIG_ARCH_OMAP4)
=20
 struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
 {
@@ -711,6 +759,10 @@ int __init omap_dm_timer_init(void)
 		dm_timers =3D omap3_dm_timers;
 		dm_source_names =3D omap3_dm_source_names;
 		dm_source_clocks =3D omap3_dm_source_clocks;
+	} else if (cpu_is_omap44xx()) {
+		dm_timers =3D omap4_dm_timers;
+		dm_source_names =3D omap4_dm_source_names;
+		dm_source_clocks =3D omap4_dm_source_clocks;
 	}
=20
 	if (cpu_class_is_omap2())
@@ -723,7 +775,8 @@ int __init omap_dm_timer_init(void)
 	for (i =3D 0; i < dm_timer_count; i++) {
 		timer =3D &dm_timers[i];
 		timer->io_base =3D IO_ADDRESS(timer->phys_base);
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
+					defined(CONFIG_ARCH_OMAP4)
 		if (cpu_class_is_omap2()) {
 			char clk_name[16];
 			sprintf(clk_name, "gpt%d_ick", i + 1);
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 17d7afe..19c2488 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -6,6 +6,9 @@
  * Copyright (C) 2003-2005 Nokia Corporation
  * Written by Juha Yrj=C3=83=C2=B6l=C3=83=C2=A4 <juha.yrjola@nokia.com=
>
  *
+ * Copyright (C) 2009 Texas Instruments
+ * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
  * This program is free software; you can redistribute it and/or modif=
y
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -146,6 +149,16 @@
 #define OMAP34XX_GPIO5_BASE		IO_ADDRESS(0x49056000)
 #define OMAP34XX_GPIO6_BASE		IO_ADDRESS(0x49058000)
=20
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
=20
 struct gpio_bank {
@@ -153,11 +166,13 @@ struct gpio_bank {
 	u16 irq;
 	u16 virtual_irq_start;
 	int method;
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) || =
defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) || =
 \
+		defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP4)
 	u32 suspend_wakeup;
 	u32 saved_wakeup;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || =
\
+			defined(CONFIG_ARCH_OMAP4)
 	u32 non_wakeup_gpios;
 	u32 enabled_non_wakeup_gpios;
=20
@@ -251,6 +266,24 @@ static struct gpio_bank gpio_bank_34xx[6] =3D {
=20
 #endif
=20
+#ifdef CONFIG_ARCH_OMAP4
+static struct gpio_bank gpio_bank_44xx[6] =3D {
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
=20
@@ -273,7 +306,7 @@ static inline struct gpio_bank *get_gpio_bank(int g=
pio)
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
-	if (cpu_is_omap34xx() && gpio < 160)
+	if ((cpu_is_omap34xx() || cpu_is_omap44xx()) && gpio < 160)
 		return 0;
 	return -1;
 }
@@ -353,7 +386,8 @@ static void _set_gpio_direction(struct gpio_bank *b=
ank, int gpio, int is_input)
 		reg +=3D OMAP850_GPIO_DIR_CONTROL;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || =
\
+			defined(CONFIG_ARCH_OMAP4)
 	case METHOD_GPIO_24XX:
 		reg +=3D OMAP24XX_GPIO_OE;
 		break;
@@ -425,7 +459,8 @@ static void _set_gpio_dataout(struct gpio_bank *ban=
k, int gpio, int enable)
 			l &=3D ~(1 << gpio);
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || =
\
+			defined(CONFIG_ARCH_OMAP4)
 	case METHOD_GPIO_24XX:
 		if (enable)
 			reg +=3D OMAP24XX_GPIO_SETDATAOUT;
@@ -476,7 +511,8 @@ static int __omap_get_gpio_datain(int gpio)
 		reg +=3D OMAP850_GPIO_DATA_INPUT;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || =
\
+			defined(CONFIG_ARCH_OMAP4)
 	case METHOD_GPIO_24XX:
 		reg +=3D OMAP24XX_GPIO_DATAIN;
 		break;
@@ -520,7 +556,7 @@ void omap_set_gpio_debounce(int gpio, int enable)
 	else
 		goto done;
=20
-	if (cpu_is_omap34xx()) {
+	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
 		if (enable)
 			clk_enable(bank->dbck);
 		else
@@ -550,7 +586,8 @@ void omap_set_gpio_debounce_time(int gpio, int enc_=
time)
 }
 EXPORT_SYMBOL(omap_set_gpio_debounce_time);
=20
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || =
\
+				defined(CONFIG_ARCH_OMAP4)
 static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, in=
t gpio,
 						int trigger)
 {
@@ -660,7 +697,8 @@ static int _set_gpio_triggering(struct gpio_bank *b=
ank, int gpio, int trigger)
 			goto bad;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || =
\
+				defined(CONFIG_ARCH_OMAP4)
 	case METHOD_GPIO_24XX:
 		set_24xx_gpio_triggering(bank, gpio, trigger);
 		break;
@@ -745,7 +783,8 @@ static void _clear_gpio_irqbank(struct gpio_bank *b=
ank, int gpio_mask)
 		reg +=3D OMAP850_GPIO_INT_STATUS;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || =
\
+				defined(CONFIG_ARCH_OMAP4)
 	case METHOD_GPIO_24XX:
 		reg +=3D OMAP24XX_GPIO_IRQSTATUS1;
 		break;
@@ -814,7 +853,8 @@ static u32 _get_gpio_irqbank_mask(struct gpio_bank =
*bank)
 		inv =3D 1;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || =
\
+				defined(CONFIG_ARCH_OMAP4)
 	case METHOD_GPIO_24XX:
 		reg +=3D OMAP24XX_GPIO_IRQENABLE1;
 		mask =3D 0xffffffff;
@@ -887,7 +927,8 @@ static void _enable_gpio_irqbank(struct gpio_bank *=
bank, int gpio_mask, int enab
 			l |=3D gpio_mask;
 		break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || =
\
+		defined(CONFIG_ARCH_OMAP4)
 	case METHOD_GPIO_24XX:
 		if (enable)
 			reg +=3D OMAP24XX_GPIO_SETIRQENABLE1;
@@ -932,7 +973,8 @@ static int _set_gpio_wakeup(struct gpio_bank *bank,=
 int gpio, int enable)
 		spin_unlock_irqrestore(&bank->lock, flags);
 		return 0;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || =
\
+				defined(CONFIG_ARCH_OMAP4)
 	case METHOD_GPIO_24XX:
 		if (bank->non_wakeup_gpios & (1 << gpio)) {
 			printk(KERN_ERR "Unable to modify wakeup on "
@@ -1017,7 +1059,8 @@ static void omap_gpio_free(struct gpio_chip *chip=
, unsigned offset)
 		__raw_writel(1 << offset, reg);
 	}
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || =
\
+				defined(CONFIG_ARCH_OMAP4)
 	if (bank->method =3D=3D METHOD_GPIO_24XX) {
 		/* Disable wake-up during idle for dynamic tick */
 		void __iomem *reg =3D bank->base + OMAP24XX_GPIO_CLEARWKUENA;
@@ -1069,7 +1112,8 @@ static void gpio_irq_handler(unsigned int irq, st=
ruct irq_desc *desc)
 	if (bank->method =3D=3D METHOD_GPIO_850)
 		isr_reg =3D bank->base + OMAP850_GPIO_INT_STATUS;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || =
\
+				defined(CONFIG_ARCH_OMAP4)
 	if (bank->method =3D=3D METHOD_GPIO_24XX)
 		isr_reg =3D bank->base + OMAP24XX_GPIO_IRQSTATUS1;
 #endif
@@ -1346,7 +1390,7 @@ static int gpio_2irq(struct gpio_chip *chip, unsi=
gned offset)
 /*--------------------------------------------------------------------=
-*/
=20
 static int initialized;
-#if !defined(CONFIG_ARCH_OMAP3)
+#if !(defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4))
 static struct clk * gpio_ick;
 #endif
=20
@@ -1359,7 +1403,7 @@ static struct clk * gpio5_ick;
 static struct clk * gpio5_fck;
 #endif
=20
-#if defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 static struct clk *gpio_iclks[OMAP34XX_NR_GPIOS];
 #endif
=20
@@ -1419,8 +1463,8 @@ static int __init _omap_gpio_init(void)
 	}
 #endif
=20
-#if defined(CONFIG_ARCH_OMAP3)
-	if (cpu_is_omap34xx()) {
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
+	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
 		for (i =3D 0; i < OMAP34XX_NR_GPIOS; i++) {
 			sprintf(clk_name, "gpio%d_ick", i + 1);
 			gpio_iclks[i] =3D clk_get(NULL, clk_name);
@@ -1497,6 +1541,17 @@ static int __init _omap_gpio_init(void)
 			(rev >> 4) & 0x0f, rev & 0x0f);
 	}
 #endif
+#ifdef CONFIG_ARCH_OMAP4
+	if (cpu_is_omap44xx()) {
+		int rev;
+
+		gpio_bank_count =3D OMAP34XX_NR_GPIOS;
+		gpio_bank =3D gpio_bank_44xx;
+		rev =3D __raw_readl(gpio_bank[0].base + OMAP24XX_GPIO_REVISION);
+		printk(KERN_INFO "OMAP44xx GPIO hardware version %d.%d\n",
+			(rev >> 4) & 0x0f, rev & 0x0f);
+	}
+#endif
 	for (i =3D 0; i < gpio_bank_count; i++) {
 		int j, gpio_count =3D 16;
=20
@@ -1520,7 +1575,8 @@ static int __init _omap_gpio_init(void)
 			gpio_count =3D 32; /* 730 has 32-bit GPIOs */
 		}
=20
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || =
\
+				defined(CONFIG_ARCH_OMAP4)
 		if (bank->method =3D=3D METHOD_GPIO_24XX) {
 			static const u32 non_wakeup_gpios[] =3D {
 				0xe203ffc0, 0x08700040
@@ -1577,7 +1633,7 @@ static int __init _omap_gpio_init(void)
 		set_irq_chained_handler(bank->irq, gpio_irq_handler);
 		set_irq_data(bank->irq, bank);
=20
-		if (cpu_is_omap34xx()) {
+		if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
 			sprintf(clk_name, "gpio%d_dbck", i + 1);
 			bank->dbck =3D clk_get(NULL, clk_name);
 			if (IS_ERR(bank->dbck))
@@ -1599,7 +1655,8 @@ static int __init _omap_gpio_init(void)
 	return 0;
 }
=20
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) || =
defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) || =
\
+		defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP4)
 static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg=
)
 {
 	int i;
@@ -1622,7 +1679,8 @@ static int omap_gpio_suspend(struct sys_device *d=
ev, pm_message_t mesg)
 			wake_set =3D bank->base + OMAP1610_GPIO_SET_WAKEUPENA;
 			break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || =
\
+				defined(CONFIG_ARCH_OMAP4)
 		case METHOD_GPIO_24XX:
 			wake_status =3D bank->base + OMAP24XX_GPIO_WAKE_EN;
 			wake_clear =3D bank->base + OMAP24XX_GPIO_CLEARWKUENA;
@@ -1663,7 +1721,8 @@ static int omap_gpio_resume(struct sys_device *de=
v)
 			wake_set =3D bank->base + OMAP1610_GPIO_SET_WAKEUPENA;
 			break;
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || =
\
+			defined(CONFIG_ARCH_OMAP4)
 		case METHOD_GPIO_24XX:
 			wake_clear =3D bank->base + OMAP24XX_GPIO_CLEARWKUENA;
 			wake_set =3D bank->base + OMAP24XX_GPIO_SETWKUENA;
@@ -1695,7 +1754,8 @@ static struct sys_device omap_gpio_device =3D {
=20
 #endif
=20
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || =
\
+				defined(CONFIG_ARCH_OMAP4)
=20
 static int workaround_enabled;
=20
@@ -1711,7 +1771,8 @@ void omap2_gpio_prepare_for_retention(void)
=20
 		if (!(bank->enabled_non_wakeup_gpios))
 			continue;
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || =
\
+				defined(CONFIG_ARCH_OMAP4)
 		bank->saved_datain =3D __raw_readl(bank->base + OMAP24XX_GPIO_DATAIN=
);
 		l1 =3D __raw_readl(bank->base + OMAP24XX_GPIO_FALLINGDETECT);
 		l2 =3D __raw_readl(bank->base + OMAP24XX_GPIO_RISINGDETECT);
@@ -1720,7 +1781,8 @@ void omap2_gpio_prepare_for_retention(void)
 		bank->saved_risingdetect =3D l2;
 		l1 &=3D ~bank->enabled_non_wakeup_gpios;
 		l2 &=3D ~bank->enabled_non_wakeup_gpios;
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || =
\
+			defined(CONFIG_ARCH_OMAP4)
 		__raw_writel(l1, bank->base + OMAP24XX_GPIO_FALLINGDETECT);
 		__raw_writel(l2, bank->base + OMAP24XX_GPIO_RISINGDETECT);
 #endif
@@ -1745,7 +1807,8 @@ void omap2_gpio_resume_after_retention(void)
=20
 		if (!(bank->enabled_non_wakeup_gpios))
 			continue;
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || =
\
+			defined(CONFIG_ARCH_OMAP4)
 		__raw_writel(bank->saved_fallingdetect,
 				 bank->base + OMAP24XX_GPIO_FALLINGDETECT);
 		__raw_writel(bank->saved_risingdetect,
@@ -1755,14 +1818,16 @@ void omap2_gpio_resume_after_retention(void)
 		 * state.  If so, generate an IRQ by software.  This is
 		 * horribly racy, but it's the best we can do to work around
 		 * this silicon bug. */
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || =
\
+			defined(CONFIG_ARCH_OMAP4)
 		l =3D __raw_readl(bank->base + OMAP24XX_GPIO_DATAIN);
 #endif
 		l ^=3D bank->saved_datain;
 		l &=3D bank->non_wakeup_gpios;
 		if (l) {
 			u32 old0, old1;
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || =
\
+			defined(CONFIG_ARCH_OMAP4)
 			old0 =3D __raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0);
 			old1 =3D __raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
 			__raw_writel(old0 | l, bank->base + OMAP24XX_GPIO_LEVELDETECT0);
@@ -1798,7 +1863,8 @@ static int __init omap_gpio_sysinit(void)
=20
 	mpuio_init();
=20
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) || =
defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) || =
\
+		defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP4)
 	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
 		if (ret =3D=3D 0) {
 			ret =3D sysdev_class_register(&omap_gpio_sysclass);
@@ -1887,7 +1953,7 @@ static int dbg_gpio_show(struct seq_file *s, void=
 *unused)
=20
 			irqstat =3D irq_desc[irq].status;
 #if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) ||	=
\
-		defined(CONFIG_ARCH_OMAP34XX)
+		defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP4)
 			if (is_in && ((bank->suspend_wakeup & mask)
 					|| irqstat & IRQ_TYPE_SENSE_MASK)) {
 				char	*trigger =3D NULL;
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
+ * This program is free software; you can redistribute it and/or modif=
y
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
=20
 #define BETWEEN(p,st,sz)	((p) >=3D (st) && (p) < ((st) + (sz)))
 #define XLATE(p,pst,vst)	((void __iomem *)((p) - (pst) + (vst)))
@@ -92,7 +104,22 @@ void __iomem *omap_ioremap(unsigned long p, size_t =
size, unsigned int type)
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
@@ -54,6 +54,9 @@ int __init_or_module omap_cfg_reg(const unsigned long=
 index)
 {
 	struct pin_config *reg;
=20
+	if (cpu_is_omap44xx())
+		return 0;
+
 	if (mux_cfg =3D=3D NULL) {
 		printk(KERN_ERR "Pin mux table not initialized\n");
 		return -ENODEV;
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index e1493d8..902f16c 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -6,6 +6,9 @@
  * Copyright (C) 2005 Nokia Corporation
  * Written by Tony Lindgren <tony@atomide.com>
  *
+ * Copyright (C) 2009 Texas Instruments
+ * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
  * This program is free software; you can redistribute it and/or modif=
y
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -44,6 +47,8 @@
 #define OMAP3_SRAM_VA           0xd7000000
 #define OMAP3_SRAM_PUB_PA       0x40208000
 #define OMAP3_SRAM_PUB_VA       0xd7008000
+#define OMAP4_SRAM_PA		0x40200000		/*0x402f0000*/
+#define OMAP4_SRAM_VA		0xd7000000		/*0xd70f0000*/
=20
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 #define SRAM_BOOTLOADER_SZ	0x00
@@ -87,6 +92,10 @@ static int is_sram_locked(void)
 {
 	int type =3D 0;
=20
+	if (cpu_is_omap44xx())
+		/* Not yet supported */
+		return 0;
+
 	if (cpu_is_omap242x())
 		type =3D omap_rev() & OMAP2_DEVICETYPE_MASK;
=20
@@ -135,6 +144,10 @@ void __init omap_detect_sram(void)
 				omap_sram_base =3D OMAP3_SRAM_VA;
 				omap_sram_start =3D OMAP3_SRAM_PA;
 				omap_sram_size =3D 0x10000; /* 64K */
+			} else if (cpu_is_omap44xx()) {
+				omap_sram_base =3D OMAP4_SRAM_VA;
+				omap_sram_start =3D OMAP4_SRAM_PA;
+				omap_sram_size =3D 0x8000; /* 32K */
 			} else {
 				omap_sram_base =3D OMAP2_SRAM_VA;
 				omap_sram_start =3D OMAP2_SRAM_PA;
@@ -203,6 +216,12 @@ void __init omap_map_sram(void)
 		omap_sram_io_desc[0].pfn =3D __phys_to_pfn(base);
 	}
=20
+	if (cpu_is_omap44xx()) {
+		omap_sram_io_desc[0].virtual =3D OMAP4_SRAM_VA;
+		base =3D OMAP4_SRAM_PA;
+		base =3D ROUND_DOWN(base, PAGE_SIZE);
+		omap_sram_io_desc[0].pfn =3D __phys_to_pfn(base);
+	}
 	omap_sram_io_desc[0].length =3D 1024 * 1024;	/* Use section desc */
 	iotable_init(omap_sram_io_desc, ARRAY_SIZE(omap_sram_io_desc));
=20
@@ -391,6 +410,8 @@ int __init omap_sram_init(void)
 		omap243x_sram_init();
 	else if (cpu_is_omap34xx())
 		omap34xx_sram_init();
+	else if (cpu_is_omap44xx())
+		omap34xx_sram_init(); /* FIXME: */
=20
 	return 0;
 }
--=20
1.5.4.7

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
