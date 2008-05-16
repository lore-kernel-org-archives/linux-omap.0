From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH 2/9] 24XX: PM: Move debugging related code to pm-debug.c
Date: Fri, 16 May 2008 13:57:08 +0300
Message-ID: <1210935428-27577-1-git-send-email-jouni.hogander@nokia.com>
References: <878wyav7ti.fsf@trdhcp146196.ntc.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:58290 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588AbYEPK5V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2008 06:57:21 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4GAvEEr028423
	for <linux-omap@vger.kernel.org>; Fri, 16 May 2008 13:57:18 +0300
In-Reply-To: <878wyav7ti.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: jouni.hogander@nokia.com

Move debugging and serial console handling to pm-debug.c.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/Makefile   |    2 +
 arch/arm/mach-omap2/pm-debug.c |  275 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.h       |   31 +++++
 arch/arm/mach-omap2/pm24xx.c   |  258 +-------------------------------------
 4 files changed, 309 insertions(+), 257 deletions(-)
 create mode 100644 arch/arm/mach-omap2/pm-debug.c
 create mode 100644 arch/arm/mach-omap2/pm.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 462f685..8f80382 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -16,6 +16,8 @@ ifeq ($(CONFIG_ARCH_OMAP2),y)
 obj-$(CONFIG_PM) += pm24xx.o sleep24xx.o
 endif
 
+obj-$(CONFIG_PM_DEBUG) += pm-debug.o
+
 # Clock framework
 obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
new file mode 100644
index 0000000..361e52b
--- /dev/null
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -0,0 +1,275 @@
+/*
+ * linux/arch/arm/mach-omap2/pm_debug.c
+ *
+ * OMAP Power Management debug routines
+ *
+ * Copyright (C) 2005 Texas Instruments, Inc.
+ * Copyright (C) 2006-2008 Nokia Corporation
+ *
+ * Written by:
+ * Richard Woodruff <r-woodruff2@ti.com>
+ * Tony Lindgren
+ * Juha Yrjola
+ * Amit Kucheria <amit.kucheria@nokia.com>
+ * Igor Stoppa <igor.stoppa@nokia.com>
+ * Jouni Hogander
+ *
+ * Based on pm.c for omap2
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+
+#include <asm/arch/clock.h>
+#include <asm/arch/board.h>
+
+#include "prm.h"
+#include "pm.h"
+
+#ifdef CONFIG_PM_DEBUG
+int omap2_pm_debug = 0;
+
+static int serial_console_clock_disabled;
+static int serial_console_uart;
+static unsigned int serial_console_next_disable;
+
+static struct clk *console_iclk, *console_fclk;
+
+static void serial_console_kick(void)
+{
+	serial_console_next_disable = omap2_read_32k_sync_counter();
+	/* Keep the clocks on for 4 secs */
+	serial_console_next_disable += 4 * 32768;
+}
+
+static void serial_wait_tx(void)
+{
+	static const unsigned long uart_bases[3] = {
+		0x4806a000, 0x4806c000, 0x4806e000
+	};
+	unsigned long lsr_reg;
+	int looped = 0;
+
+	/* Wait for TX FIFO and THR to get empty */
+	lsr_reg = IO_ADDRESS(uart_bases[serial_console_uart - 1] + (5 << 2));
+	while ((__raw_readb(lsr_reg) & 0x60) != 0x60)
+		looped = 1;
+	if (looped)
+		serial_console_kick();
+}
+
+u32 omap2_read_32k_sync_counter(void)
+{
+        return omap_readl(OMAP2_32KSYNCT_BASE + 0x0010);
+}
+
+void serial_console_fclk_mask(u32 *f1, u32 *f2)
+{
+	switch (serial_console_uart)  {
+	case 1:
+		*f1 &= ~(1 << 21);
+		break;
+	case 2:
+		*f1 &= ~(1 << 22);
+		break;
+	case 3:
+		*f2 &= ~(1 << 2);
+		break;
+	}
+}
+
+void serial_console_sleep(int enable)
+{
+	if (console_iclk == NULL || console_fclk == NULL)
+		return;
+
+	if (enable) {
+		BUG_ON(serial_console_clock_disabled);
+		if (clk_get_usecount(console_fclk) == 0)
+			return;
+		if ((int) serial_console_next_disable - (int) omap2_read_32k_sync_counter() >= 0)
+			return;
+		serial_wait_tx();
+		clk_disable(console_iclk);
+		clk_disable(console_fclk);
+		serial_console_clock_disabled = 1;
+	} else {
+		int serial_wakeup = 0;
+		u32 l;
+
+		switch (serial_console_uart)  {
+		case 1:
+			l = prm_read_mod_reg(CORE_MOD, PM_WKST1);
+			if (l & OMAP24XX_ST_UART1)
+				serial_wakeup = 1;
+			break;
+		case 2:
+			l = prm_read_mod_reg(CORE_MOD, PM_WKST1);
+			if (l & OMAP24XX_ST_UART2)
+				serial_wakeup = 1;
+			break;
+		case 3:
+			l = prm_read_mod_reg(CORE_MOD, OMAP24XX_PM_WKST2);
+			if (l & OMAP24XX_ST_UART3)
+				serial_wakeup = 1;
+			break;
+		}
+		if (serial_wakeup)
+			serial_console_kick();
+		if (!serial_console_clock_disabled)
+			return;
+		clk_enable(console_iclk);
+		clk_enable(console_fclk);
+		serial_console_clock_disabled = 0;
+	}
+}
+
+void pm_init_serial_console(void)
+{
+	const struct omap_serial_console_config *conf;
+	char name[16];
+
+	conf = omap_get_config(OMAP_TAG_SERIAL_CONSOLE,
+			       struct omap_serial_console_config);
+	if (conf == NULL)
+		return;
+	if (conf->console_uart > 3 || conf->console_uart < 1)
+		return;
+	serial_console_uart = conf->console_uart;
+	sprintf(name, "uart%d_fck", conf->console_uart);
+	console_fclk = clk_get(NULL, name);
+	if (IS_ERR(console_fclk))
+		console_fclk = NULL;
+	name[6] = 'i';
+	console_iclk = clk_get(NULL, name);
+	if (IS_ERR(console_fclk))
+		console_iclk = NULL;
+	if (console_fclk == NULL || console_iclk == NULL) {
+		serial_console_uart = 0;
+		return;
+	}
+	switch (serial_console_uart) {
+	case 1:
+		prm_set_mod_reg_bits(OMAP24XX_ST_UART1, CORE_MOD, PM_WKEN1);
+		break;
+	case 2:
+		prm_set_mod_reg_bits(OMAP24XX_ST_UART2, CORE_MOD, PM_WKEN1);
+		break;
+	case 3:
+		prm_set_mod_reg_bits(OMAP24XX_ST_UART3, CORE_MOD, OMAP24XX_PM_WKEN2);
+		break;
+	}
+}
+
+#define DUMP_PRM_MOD_REG(mod, reg)    \
+	regs[reg_count].name = #mod "." #reg; \
+	regs[reg_count++].val = prm_read_mod_reg(mod, reg)
+#define DUMP_CM_MOD_REG(mod, reg)     \
+	regs[reg_count].name = #mod "." #reg; \
+	regs[reg_count++].val = cm_read_mod_reg(mod, reg)
+#define DUMP_PRM_REG(reg) \
+	regs[reg_count].name = #reg; \
+	regs[reg_count++].val = __raw_readl(reg)
+#define DUMP_CM_REG(reg) \
+	regs[reg_count].name = #reg; \
+	regs[reg_count++].val = __raw_readl(reg)
+#define DUMP_INTC_REG(reg, off) \
+	regs[reg_count].name = #reg; \
+	regs[reg_count++].val = __raw_readl(IO_ADDRESS(0x480fe000 + (off)))
+
+void omap2_pm_dump(int mode, int resume, unsigned int us)
+{
+	struct reg {
+		const char *name;
+		u32 val;
+	} regs[32];
+	int reg_count = 0, i;
+	const char *s1 = NULL, *s2 = NULL;
+
+	if (!resume) {
+#if 0
+		/* MPU */
+		DUMP_PRM_REG(OMAP24XX_PRCM_IRQENABLE_MPU);
+		DUMP_CM_MOD_REG(MPU_MOD, CM_CLKSTCTRL);
+		DUMP_PRM_MOD_REG(MPU_MOD, PM_PWSTCTRL);
+		DUMP_PRM_MOD_REG(MPU_MOD, PM_PWSTST);
+		DUMP_PRM_MOD_REG(MPU_MOD, PM_WKDEP);
+#endif
+#if 0
+		/* INTC */
+		DUMP_INTC_REG(INTC_MIR0, 0x0084);
+		DUMP_INTC_REG(INTC_MIR1, 0x00a4);
+		DUMP_INTC_REG(INTC_MIR2, 0x00c4);
+#endif
+#if 0
+		DUMP_CM_MOD_REG(CORE_MOD, CM_FCLKEN1);
+		DUMP_CM_MOD_REG(CORE_MOD, OMAP24XX_CM_FCLKEN2);
+		DUMP_CM_MOD_REG(WKUP_MOD, CM_FCLKEN);
+		DUMP_CM_MOD_REG(CORE_MOD, CM_ICLKEN1);
+		DUMP_CM_MOD_REG(CORE_MOD, CM_ICLKEN2);
+		DUMP_CM_MOD_REG(WKUP_MOD, CM_ICLKEN);
+		DUMP_CM_MOD_REG(PLL_MOD, CM_CLKEN);
+		DUMP_PRM_REG(OMAP24XX_PRCM_CLKEMUL_CTRL);
+		DUMP_CM_MOD_REG(PLL_MOD, CM_AUTOIDLE);
+		DUMP_PRM_MOD_REG(CORE_MOD, PM_PWSTST);
+		DUMP_PRM_REG(OMAP24XX_PRCM_CLKSRC_CTRL);
+#endif
+#if 0
+		/* DSP */
+		DUMP_CM_MOD_REG(OMAP24XX_DSP_MOD, CM_FCLKEN);
+		DUMP_CM_MOD_REG(OMAP24XX_DSP_MOD, CM_ICLKEN);
+		DUMP_CM_MOD_REG(OMAP24XX_DSP_MOD, CM_IDLEST);
+		DUMP_CM_MOD_REG(OMAP24XX_DSP_MOD, CM_AUTOIDLE);
+		DUMP_CM_MOD_REG(OMAP24XX_DSP_MOD, CM_CLKSEL);
+		DUMP_CM_MOD_REG(OMAP24XX_DSP_MOD, CM_CLKSTCTRL);
+		DUMP_PRM_MOD_REG(OMAP24XX_DSP_MOD, RM_RSTCTRL);
+		DUMP_PRM_MOD_REG(OMAP24XX_DSP_MOD, RM_RSTST);
+		DUMP_PRM_MOD_REG(OMAP24XX_DSP_MOD, PM_PWSTCTRL);
+		DUMP_PRM_MOD_REG(OMAP24XX_DSP_MOD, PM_PWSTST);
+#endif
+	} else {
+		DUMP_PRM_MOD_REG(CORE_MOD, PM_WKST1);
+		DUMP_PRM_MOD_REG(CORE_MOD, OMAP24XX_PM_WKST2);
+		DUMP_PRM_MOD_REG(WKUP_MOD, PM_WKST);
+		DUMP_PRM_REG(OMAP24XX_PRCM_IRQSTATUS_MPU);
+#if 1
+		DUMP_INTC_REG(INTC_PENDING_IRQ0, 0x0098);
+		DUMP_INTC_REG(INTC_PENDING_IRQ1, 0x00b8);
+		DUMP_INTC_REG(INTC_PENDING_IRQ2, 0x00d8);
+#endif
+	}
+
+	switch (mode) {
+	case 0:
+		s1 = "full";
+		s2 = "retention";
+		break;
+	case 1:
+		s1 = "MPU";
+		s2 = "retention";
+		break;
+	case 2:
+		s1 = "MPU";
+		s2 = "idle";
+		break;
+	}
+
+	if (!resume)
+#if defined(CONFIG_NO_IDLE_HZ) || defined(CONFIG_NO_HZ)
+		printk("--- Going to %s %s (next timer after %u ms)\n", s1, s2,
+		       jiffies_to_msecs(get_next_timer_interrupt(jiffies) -
+					jiffies));
+#else
+		printk("--- Going to %s %s\n", s1, s2);
+#endif
+	else
+		printk("--- Woke up (slept for %u.%03u ms)\n", us / 1000, us % 1000);
+	for (i = 0; i < reg_count; i++)
+		printk("%-20s: 0x%08x\n", regs[i].name, regs[i].val);
+}
+
+#endif
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
new file mode 100644
index 0000000..541bf90
--- /dev/null
+++ b/arch/arm/mach-omap2/pm.h
@@ -0,0 +1,31 @@
+#ifndef __ARCH_ARM_MACH_OMAP2_PM_H
+#define __ARCH_ARM_MACH_OMAP2_PM_H
+/*
+ * linux/arch/arm/mach-omap2/pm.h
+ *
+ * OMAP Power Management Routines
+ *
+ * Copyright (C) 2008 Nokia Corporation
+ * Jouni Hogander
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifdef CONFIG_PM_DEBUG
+extern u32 omap2_read_32k_sync_counter(void);
+extern void omap2_pm_dump(int mode, int resume, unsigned int us);
+extern void serial_console_fclk_mask(u32 *f1, u32 *f2);
+extern void pm_init_serial_console(void);
+extern void serial_console_sleep(int enable);
+extern int omap2_pm_debug;
+#else
+#define omap2_read_32k_sync_counter() 0;
+#define serial_console_sleep(enable) do; while(0)
+#define pm_init_serial_console() do; while(0)
+#define omap2_pm_dump(mode,resume,us) do; while(0)
+#define serial_console_fclk_mask(f1,f2)  do; while(0)
+#define omap2_pm_debug 0
+#endif /* CONFIG_PM_DEBUG */
+#endif
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index b627fe5..593f629 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -51,6 +51,7 @@
 #include "cm.h"
 #include "cm-regbits-24xx.h"
 #include "sdrc.h"
+#include "pm.h"
 
 /* These addrs are in assembly language code to be patched at runtime */
 extern void *omap2_ocs_sdrc_power;
@@ -60,263 +61,6 @@ static void (*omap2_sram_idle)(void);
 static void (*omap2_sram_suspend)(void __iomem *dllctrl);
 static void (*saved_idle)(void);
 
-static u32 omap2_read_32k_sync_counter(void)
-{
-	return omap_readl(OMAP2_32KSYNCT_BASE + 0x0010);
-}
-
-#ifdef CONFIG_PM_DEBUG
-int omap2_pm_debug = 0;
-
-static int serial_console_clock_disabled;
-static int serial_console_uart;
-static unsigned int serial_console_next_disable;
-
-static struct clk *console_iclk, *console_fclk;
-
-static void serial_console_kick(void)
-{
-	serial_console_next_disable = omap2_read_32k_sync_counter();
-	/* Keep the clocks on for 4 secs */
-	serial_console_next_disable += 4 * 32768;
-}
-
-static void serial_wait_tx(void)
-{
-	static const unsigned long uart_bases[3] = {
-		0x4806a000, 0x4806c000, 0x4806e000
-	};
-	unsigned long lsr_reg;
-	int looped = 0;
-
-	/* Wait for TX FIFO and THR to get empty */
-	lsr_reg = IO_ADDRESS(uart_bases[serial_console_uart - 1] + (5 << 2));
-	while ((__raw_readb(lsr_reg) & 0x60) != 0x60)
-		looped = 1;
-	if (looped)
-		serial_console_kick();
-}
-
-static void serial_console_fclk_mask(u32 *f1, u32 *f2)
-{
-	switch (serial_console_uart)  {
-	case 1:
-		*f1 &= ~(1 << 21);
-		break;
-	case 2:
-		*f1 &= ~(1 << 22);
-		break;
-	case 3:
-		*f2 &= ~(1 << 2);
-		break;
-	}
-}
-
-static void serial_console_sleep(int enable)
-{
-	if (console_iclk == NULL || console_fclk == NULL)
-		return;
-
-	if (enable) {
-		BUG_ON(serial_console_clock_disabled);
-		if (clk_get_usecount(console_fclk) == 0)
-			return;
-		if ((int) serial_console_next_disable -
-		    (int) omap2_read_32k_sync_counter() >= 0)
-			return;
-		serial_wait_tx();
-		clk_disable(console_iclk);
-		clk_disable(console_fclk);
-		serial_console_clock_disabled = 1;
-	} else {
-		int serial_wakeup = 0;
-		u32 l;
-
-		switch (serial_console_uart)  {
-		case 1:
-			l = prm_read_mod_reg(CORE_MOD, PM_WKST1);
-			if (l & OMAP24XX_ST_UART1)
-				serial_wakeup = 1;
-			break;
-		case 2:
-			l = prm_read_mod_reg(CORE_MOD, PM_WKST1);
-			if (l & OMAP24XX_ST_UART2)
-				serial_wakeup = 1;
-			break;
-		case 3:
-			l = prm_read_mod_reg(CORE_MOD, OMAP24XX_PM_WKST2);
-			if (l & OMAP24XX_ST_UART3)
-				serial_wakeup = 1;
-			break;
-		}
-		if (serial_wakeup)
-			serial_console_kick();
-		if (!serial_console_clock_disabled)
-			return;
-		clk_enable(console_iclk);
-		clk_enable(console_fclk);
-		serial_console_clock_disabled = 0;
-	}
-}
-
-static void pm_init_serial_console(void)
-{
-	const struct omap_serial_console_config *conf;
-	char name[16];
-
-	conf = omap_get_config(OMAP_TAG_SERIAL_CONSOLE,
-			       struct omap_serial_console_config);
-	if (conf == NULL)
-		return;
-	if (conf->console_uart > 3 || conf->console_uart < 1)
-		return;
-	serial_console_uart = conf->console_uart;
-	sprintf(name, "uart%d_fck", conf->console_uart);
-	console_fclk = clk_get(NULL, name);
-	if (IS_ERR(console_fclk))
-		console_fclk = NULL;
-	name[6] = 'i';
-	console_iclk = clk_get(NULL, name);
-	if (IS_ERR(console_fclk))
-		console_iclk = NULL;
-	if (console_fclk == NULL || console_iclk == NULL) {
-		serial_console_uart = 0;
-		return;
-	}
-	switch (serial_console_uart) {
-	case 1:
-		prm_set_mod_reg_bits(OMAP24XX_ST_UART1, CORE_MOD, PM_WKEN1);
-		break;
-	case 2:
-		prm_set_mod_reg_bits(OMAP24XX_ST_UART2, CORE_MOD, PM_WKEN1);
-		break;
-	case 3:
-		prm_set_mod_reg_bits(OMAP24XX_ST_UART3, CORE_MOD,
-				     OMAP24XX_PM_WKEN2);
-		break;
-	}
-}
-
-#define DUMP_PRM_MOD_REG(mod, reg)    \
-	regs[reg_count].name = #mod "." #reg; \
-	regs[reg_count++].val = prm_read_mod_reg(mod, reg)
-#define DUMP_CM_MOD_REG(mod, reg)     \
-	regs[reg_count].name = #mod "." #reg; \
-	regs[reg_count++].val = cm_read_mod_reg(mod, reg)
-#define DUMP_PRM_REG(reg) \
-	regs[reg_count].name = #reg; \
-	regs[reg_count++].val = __raw_readl(reg)
-#define DUMP_CM_REG(reg) \
-	regs[reg_count].name = #reg; \
-	regs[reg_count++].val = __raw_readl(reg)
-#define DUMP_INTC_REG(reg, off) \
-	regs[reg_count].name = #reg; \
-	regs[reg_count++].val = __raw_readl(IO_ADDRESS(0x480fe000 + (off)))
-
-static void omap2_pm_dump(int mode, int resume, unsigned int us)
-{
-	struct reg {
-		const char *name;
-		u32 val;
-	} regs[32];
-	int reg_count = 0, i;
-	const char *s1 = NULL, *s2 = NULL;
-
-	if (!resume) {
-#if 0
-		/* MPU */
-		DUMP_PRM_REG(OMAP24XX_PRCM_IRQENABLE_MPU);
-		DUMP_CM_MOD_REG(MPU_MOD, CM_CLKSTCTRL);
-		DUMP_PRM_MOD_REG(MPU_MOD, PM_PWSTCTRL);
-		DUMP_PRM_MOD_REG(MPU_MOD, PM_PWSTST);
-		DUMP_PRM_MOD_REG(MPU_MOD, PM_WKDEP);
-#endif
-#if 0
-		/* INTC */
-		DUMP_INTC_REG(INTC_MIR0, 0x0084);
-		DUMP_INTC_REG(INTC_MIR1, 0x00a4);
-		DUMP_INTC_REG(INTC_MIR2, 0x00c4);
-#endif
-#if 0
-		DUMP_CM_MOD_REG(CORE_MOD, CM_FCLKEN1);
-		DUMP_CM_MOD_REG(CORE_MOD, OMAP24XX_CM_FCLKEN2);
-		DUMP_CM_MOD_REG(WKUP_MOD, CM_FCLKEN);
-		DUMP_CM_MOD_REG(CORE_MOD, CM_ICLKEN1);
-		DUMP_CM_MOD_REG(CORE_MOD, CM_ICLKEN2);
-		DUMP_CM_MOD_REG(WKUP_MOD, CM_ICLKEN);
-		DUMP_CM_MOD_REG(PLL_MOD, CM_CLKEN);
-		DUMP_PRM_REG(OMAP24XX_PRCM_CLKEMUL_CTRL);
-		DUMP_CM_MOD_REG(PLL_MOD, CM_AUTOIDLE);
-		DUMP_PRM_MOD_REG(CORE_MOD, PM_PWSTST);
-		DUMP_PRM_REG(OMAP24XX_PRCM_CLKSRC_CTRL);
-#endif
-#if 0
-		/* DSP */
-		DUMP_CM_MOD_REG(OMAP24XX_DSP_MOD, CM_FCLKEN);
-		DUMP_CM_MOD_REG(OMAP24XX_DSP_MOD, CM_ICLKEN);
-		DUMP_CM_MOD_REG(OMAP24XX_DSP_MOD, CM_IDLEST);
-		DUMP_CM_MOD_REG(OMAP24XX_DSP_MOD, CM_AUTOIDLE);
-		DUMP_CM_MOD_REG(OMAP24XX_DSP_MOD, CM_CLKSEL);
-		DUMP_CM_MOD_REG(OMAP24XX_DSP_MOD, CM_CLKSTCTRL);
-		DUMP_PRM_MOD_REG(OMAP24XX_DSP_MOD, RM_RSTCTRL);
-		DUMP_PRM_MOD_REG(OMAP24XX_DSP_MOD, RM_RSTST);
-		DUMP_PRM_MOD_REG(OMAP24XX_DSP_MOD, PM_PWSTCTRL);
-		DUMP_PRM_MOD_REG(OMAP24XX_DSP_MOD, PM_PWSTST);
-#endif
-	} else {
-		DUMP_PRM_MOD_REG(CORE_MOD, PM_WKST1);
-		DUMP_PRM_MOD_REG(CORE_MOD, OMAP24XX_PM_WKST2);
-		DUMP_PRM_MOD_REG(WKUP_MOD, PM_WKST);
-		DUMP_PRM_REG(OMAP24XX_PRCM_IRQSTATUS_MPU);
-#if 1
-		DUMP_INTC_REG(INTC_PENDING_IRQ0, 0x0098);
-		DUMP_INTC_REG(INTC_PENDING_IRQ1, 0x00b8);
-		DUMP_INTC_REG(INTC_PENDING_IRQ2, 0x00d8);
-#endif
-	}
-
-	switch (mode) {
-	case 0:
-		s1 = "full";
-		s2 = "retention";
-		break;
-	case 1:
-		s1 = "MPU";
-		s2 = "retention";
-		break;
-	case 2:
-		s1 = "MPU";
-		s2 = "idle";
-		break;
-	}
-
-	if (!resume)
-#if defined(CONFIG_NO_IDLE_HZ) || defined(CONFIG_NO_HZ)
-		pr_debug("--- Going to %s %s (next timer after %u ms)\n", s1,
-			 s2,
-			 jiffies_to_msecs(get_next_timer_interrupt(jiffies) -
-					  jiffies));
-#else
-		pr_debug("--- Going to %s %s\n", s1, s2);
-#endif
-	else
-		pr_debug("--- Woke up (slept for %u.%03u ms)\n", us / 1000,
-			 us % 1000);
-
-	for (i = 0; i < reg_count; i++)
-		pr_debug("%-20s: 0x%08x\n", regs[i].name, regs[i].val);
-}
-
-#else
-static inline void serial_console_sleep(int enable) {}
-static inline void pm_init_serial_console(void) {}
-static inline void omap2_pm_dump(int mode, int resume, unsigned int us) {}
-static inline void serial_console_fclk_mask(u32 *f1, u32 *f2) {}
-
-#define omap2_pm_debug 0
-
-#endif
-
 static unsigned short enable_dyn_sleep = 0; /* disabled till drivers are fixed */
 
 static ssize_t idle_show(struct kobject *kobj, struct kobj_attribute *attr,
-- 
1.5.5

