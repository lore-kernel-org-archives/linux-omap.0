From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 07/21] OMAP3: PM: UART: disable clocks when idle and off-mode support
Date: Wed,  4 Feb 2009 18:05:53 -0800
Message-ID: <1233799567-22250-8-git-send-email-khilman@deeprootsystems.com>
References: <1233799567-22250-1-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-2-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-3-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-4-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-5-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-6-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-7-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.185]:8129 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757235AbZBECGz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Feb 2009 21:06:55 -0500
Received: by rn-out-0910.google.com with SMTP id k40so2118065rnd.17
        for <linux-omap@vger.kernel.org>; Wed, 04 Feb 2009 18:06:54 -0800 (PST)
In-Reply-To: <1233799567-22250-7-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Tero Kristo <tero.kristo@nokia.com>, Jouni Hogander <jouni.hogander@nokia.com>

This patch allows the UART clocks to be disabled when the OMAP UARTs
are inactive, thus permitting the chip to hit retention in idle.
After the timeout of an activity timer, each UART is allowed to
disable its clocks so the system can enter retention.  The activity
timer is (re)activated on any UART interrupt, UART wake event or any
IO pad wakeup.  The actual disable of the UART clocks is done in the
'prepare_idle' hook called from the OMAP idle loop.

While the activity timer is active, the smart-idle mode of the UART is
also disabled.  This is due to a "feature" of the UART module that
after a UART wakeup, the smart-idle mode may be entered before the
UART has communicated the interrupt, or upon TX, an idle mode may be
entered before the TX FIFOs are emptied.

Upon suspend, the 'prepare_suspend' hook cancels any pending activity
timers and allows the clocks to be disabled.

To enable the clock-disabling feature of this patch, do

  # echo 1 > /sys/power/clocks_off_while_idle

In addition, upon disabling clocks the UART state is saved in case
of an off-mode transition while clocks are off.

Special thanks to Tero Kristo for the initial ideas and first versions
of UART idle support, and to Jouni Hogander for extra testing and
bugfixes.

Tested on OMAP3 (Beagle, custom HW) and OMAP2 (n810)

Cc: Tero Kristo <tero.kristo@nokia.com>
Cc: Jouni Hogander <jouni.hogander@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm24xx.c             |   16 ++-
 arch/arm/mach-omap2/pm34xx.c             |   15 ++
 arch/arm/mach-omap2/serial.c             |  391 ++++++++++++++++++++++++++++--
 arch/arm/plat-omap/include/mach/common.h |    2 -
 arch/arm/plat-omap/include/mach/serial.h |    9 +
 include/linux/serial_reg.h               |    1 +
 6 files changed, 407 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 3e9ed3f..64985f5 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -73,6 +73,11 @@ static int omap2_fclks_active(void)
 
 	f1 = cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
 	f2 = cm_read_mod_reg(CORE_MOD, OMAP24XX_CM_FCLKEN2);
+
+	/* Ignore UART clocks.  These are handled by UART core (serial.c) */
+	f1 &= ~(OMAP24XX_EN_UART1 | OMAP24XX_EN_UART2);
+	f2 &= ~OMAP24XX_EN_UART3;
+
 	if (f1 | f2)
 		return 1;
 	return 0;
@@ -119,12 +124,20 @@ static void omap2_enter_full_retention(void)
 	if (omap_irq_pending())
 		goto no_sleep;
 
+	omap_uart_prepare_idle(0);
+	omap_uart_prepare_idle(1);
+	omap_uart_prepare_idle(2);
+
 	/* Jump to SRAM suspend code */
 	omap2_sram_suspend(sdrc_read_reg(SDRC_DLLA_CTRL),
 			   OMAP_SDRC_REGADDR(SDRC_DLLA_CTRL),
 			   OMAP_SDRC_REGADDR(SDRC_POWER));
-no_sleep:
 
+	omap_uart_resume_idle(2);
+	omap_uart_resume_idle(1);
+	omap_uart_resume_idle(0);
+
+no_sleep:
 	if (omap2_pm_debug) {
 		unsigned long long tmp;
 
@@ -298,6 +311,7 @@ static int omap2_pm_suspend(void)
 	mir1 = omap_readl(0x480fe0a4);
 	omap_writel(1 << 5, 0x480fe0ac);
 
+	omap_uart_prepare_suspend();
 	omap2_enter_full_retention();
 
 	omap_writel(mir1, 0x480fe0a4);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index bb39e12..1c6819e 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -28,6 +28,7 @@
 #include <mach/clockdomain.h>
 #include <mach/powerdomain.h>
 #include <mach/control.h>
+#include <mach/serial.h>
 
 #include "cm.h"
 #include "cm-regbits-34xx.h"
@@ -176,9 +177,15 @@ static void omap_sram_idle(void)
 	disable_smartreflex(SR2);
 
 	omap2_gpio_prepare_for_retention();
+	omap_uart_prepare_idle(0);
+	omap_uart_prepare_idle(1);
+	omap_uart_prepare_idle(2);
 
 	_omap_sram_idle(NULL, save_state);
 
+	omap_uart_resume_idle(2);
+	omap_uart_resume_idle(1);
+	omap_uart_resume_idle(0);
 	omap2_gpio_resume_after_retention();
 
 	/* Enable smartreflex after WFI */
@@ -215,6 +222,11 @@ static int omap3_fclks_active(void)
 				  CM_FCLKEN);
 	fck_per = cm_read_mod_reg(OMAP3430_PER_MOD,
 				  CM_FCLKEN);
+
+	/* Ignore UART clocks.  These are handled by UART core (serial.c) */
+	fck_core1 &= ~(OMAP3430_EN_UART1 | OMAP3430_EN_UART2);
+	fck_per &= ~OMAP3430_EN_UART3;
+
 	if (fck_core1 | fck_core3 | fck_sgx | fck_dss |
 	    fck_cam | fck_per | fck_usbhost)
 		return 1;
@@ -225,6 +237,8 @@ static int omap3_can_sleep(void)
 {
 	if (!enable_dyn_sleep)
 		return 0;
+	if (!omap_uart_can_sleep())
+		return 0;
 	if (omap3_fclks_active())
 		return 0;
 	if (atomic_read(&sleep_block) > 0)
@@ -317,6 +331,7 @@ static int omap3_pm_suspend(void)
 			goto restore;
 	}
 
+	omap_uart_prepare_suspend();
 	omap_sram_idle();
 
 restore:
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 4dcf39c..cb191d0 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -6,6 +6,8 @@
  * Copyright (C) 2005-2008 Nokia Corporation
  * Author: Paul Mundt <paul.mundt@nokia.com>
  *
+ * Major rework for PM support by Kevin Hilman
+ *
  * Based off of arch/arm/mach-omap/omap1/serial.c
  *
  * This file is subject to the terms and conditions of the GNU General Public
@@ -21,9 +23,48 @@
 
 #include <mach/common.h>
 #include <mach/board.h>
+#include <mach/clock.h>
+#include <mach/control.h>
+
+#include "prm.h"
+#include "pm.h"
+#include "prm-regbits-34xx.h"
+
+#define DEFAULT_TIMEOUT (2 * HZ)
+
+struct omap_uart_state {
+	int num;
+	int can_sleep;
+	struct timer_list timer;
+	u32 timeout;
 
-static struct clk *uart_ick[OMAP_MAX_NR_PORTS];
-static struct clk *uart_fck[OMAP_MAX_NR_PORTS];
+	void __iomem *wk_st;
+	void __iomem *wk_en;
+	u32 wk_mask;
+	u32 padconf;
+
+	struct clk *ick;
+	struct clk *fck;
+	int clocked;
+
+	struct plat_serial8250_port *p;
+	struct list_head node;
+
+#if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
+	int context_valid;
+
+	/* Registers to be saved/restored for OFF-mode */
+	u16 dll;
+	u16 dlh;
+	u16 ier;
+	u16 sysc;
+	u16 scr;
+	u16 wer;
+#endif
+};
+
+static struct omap_uart_state omap_uart[OMAP_MAX_NR_PORTS];
+static LIST_HEAD(uart_list);
 
 static struct plat_serial8250_port serial_platform_data[] = {
 	{
@@ -74,30 +115,323 @@ static inline void serial_write_reg(struct plat_serial8250_port *p, int offset,
  * properly. Note that the TX watermark initialization may not be needed
  * once the 8250.c watermark handling code is merged.
  */
-static inline void __init omap_serial_reset(struct plat_serial8250_port *p)
+static inline void __init omap_uart_reset(struct omap_uart_state *uart)
 {
+	struct plat_serial8250_port *p = uart->p;
+
 	serial_write_reg(p, UART_OMAP_MDR1, 0x07);
 	serial_write_reg(p, UART_OMAP_SCR, 0x08);
 	serial_write_reg(p, UART_OMAP_MDR1, 0x00);
 	serial_write_reg(p, UART_OMAP_SYSC, (0x02 << 3) | (1 << 2) | (1 << 0));
 }
 
-void omap_serial_enable_clocks(int enable)
+#if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3)
+
+static int enable_off_mode; /* to be removed by full off-mode patches */
+
+static void omap_uart_save_context(struct omap_uart_state *uart)
 {
-	int i;
-	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
-		if (uart_ick[i] && uart_fck[i]) {
-			if (enable) {
-				clk_enable(uart_ick[i]);
-				clk_enable(uart_fck[i]);
-			} else {
-				clk_disable(uart_ick[i]);
-				clk_disable(uart_fck[i]);
+	u16 lcr = 0;
+	struct plat_serial8250_port *p = uart->p;
+
+	if (!enable_off_mode)
+		return;
+
+	lcr = serial_read_reg(p, UART_LCR);
+	serial_write_reg(p, UART_LCR, 0xBF);
+	uart->dll = serial_read_reg(p, UART_DLL);
+	uart->dlh = serial_read_reg(p, UART_DLM);
+	serial_write_reg(p, UART_LCR, lcr);
+	uart->ier = serial_read_reg(p, UART_IER);
+	uart->sysc = serial_read_reg(p, UART_OMAP_SYSC);
+	uart->scr = serial_read_reg(p, UART_OMAP_SCR);
+	uart->wer = serial_read_reg(p, UART_OMAP_WER);
+
+	uart->context_valid = 1;
+}
+
+static void omap_uart_restore_context(struct omap_uart_state *uart)
+{
+	u16 efr = 0;
+	struct plat_serial8250_port *p = uart->p;
+
+	if (!enable_off_mode)
+		return;
+
+	if (!uart->context_valid)
+		return;
+
+	uart->context_valid = 0;
+
+	serial_write_reg(p, UART_OMAP_MDR1, 0x7);
+	serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
+	efr = serial_read_reg(p, UART_EFR);
+	serial_write_reg(p, UART_EFR, UART_EFR_ECB);
+	serial_write_reg(p, UART_LCR, 0x0); /* Operational mode */
+	serial_write_reg(p, UART_IER, 0x0);
+	serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
+	serial_write_reg(p, UART_DLL, uart->dll);
+	serial_write_reg(p, UART_DLM, uart->dlh);
+	serial_write_reg(p, UART_LCR, 0x0); /* Operational mode */
+	serial_write_reg(p, UART_IER, uart->ier);
+	serial_write_reg(p, UART_FCR, 0xA1);
+	serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
+	serial_write_reg(p, UART_EFR, efr);
+	serial_write_reg(p, UART_LCR, UART_LCR_WLEN8);
+	serial_write_reg(p, UART_OMAP_SCR, uart->scr);
+	serial_write_reg(p, UART_OMAP_WER, uart->wer);
+	serial_write_reg(p, UART_OMAP_SYSC, uart->sysc);
+	serial_write_reg(p, UART_OMAP_MDR1, 0x00); /* UART 16x mode */
+}
+#else
+static inline void omap_uart_save_context(struct omap_uart_state *uart) {}
+static inline void omap_uart_restore_context(struct omap_uart_state *uart) {}
+#endif /* CONFIG_PM && CONFIG_ARCH_OMAP3 */
+
+static inline void omap_uart_enable_clocks(struct omap_uart_state *uart)
+{
+	if (uart->clocked)
+		return;
+
+	clk_enable(uart->ick);
+	clk_enable(uart->fck);
+	uart->clocked = 1;
+	omap_uart_restore_context(uart);
+}
+
+#ifdef CONFIG_PM
+
+static inline void omap_uart_disable_clocks(struct omap_uart_state *uart)
+{
+	if (!uart->clocked)
+		return;
+
+	omap_uart_save_context(uart);
+	uart->clocked = 0;
+	clk_disable(uart->ick);
+	clk_disable(uart->fck);
+}
+
+static void omap_uart_smart_idle_enable(struct omap_uart_state *uart,
+					  int enable)
+{
+	struct plat_serial8250_port *p = uart->p;
+	u16 sysc;
+
+	sysc = serial_read_reg(p, UART_OMAP_SYSC) & 0x7;
+	if (enable)
+		sysc |= 0x2 << 3;
+	else
+		sysc |= 0x1 << 3;
+
+	serial_write_reg(p, UART_OMAP_SYSC, sysc);
+}
+
+static void omap_uart_block_sleep(struct omap_uart_state *uart)
+{
+	omap_uart_enable_clocks(uart);
+
+	omap_uart_smart_idle_enable(uart, 0);
+	uart->can_sleep = 0;
+	mod_timer(&uart->timer, jiffies + uart->timeout);
+}
+
+static void omap_uart_allow_sleep(struct omap_uart_state *uart)
+{
+	if (!uart->clocked)
+		return;
+
+	omap_uart_smart_idle_enable(uart, 1);
+	uart->can_sleep = 1;
+	del_timer(&uart->timer);
+}
+
+static void omap_uart_idle_timer(unsigned long data)
+{
+	struct omap_uart_state *uart = (struct omap_uart_state *)data;
+
+	omap_uart_allow_sleep(uart);
+}
+
+void omap_uart_prepare_idle(int num)
+{
+	struct omap_uart_state *uart;
+
+	list_for_each_entry(uart, &uart_list, node) {
+		if (!clocks_off_while_idle)
+			continue;
+
+		if (num == uart->num && uart->can_sleep) {
+			omap_uart_disable_clocks(uart);
+			return;
+		}
+	}
+}
+
+void omap_uart_resume_idle(int num)
+{
+	struct omap_uart_state *uart;
+
+	list_for_each_entry(uart, &uart_list, node) {
+		if (num == uart->num) {
+			omap_uart_enable_clocks(uart);
+
+			/* Check for IO pad wakeup */
+			if (cpu_is_omap34xx() && uart->padconf) {
+				u16 p = omap_ctrl_readw(uart->padconf);
+
+				if (p & OMAP3_PADCONF_WAKEUPEVENT0)
+					omap_uart_block_sleep(uart);
 			}
+
+			/* Check for normal UART wakeup */
+			if (__raw_readl(uart->wk_st) & uart->wk_mask)
+				omap_uart_block_sleep(uart);
+
+			return;
+		}
+	}
+}
+
+void omap_uart_prepare_suspend(void)
+{
+	struct omap_uart_state *uart;
+
+	list_for_each_entry(uart, &uart_list, node) {
+		omap_uart_allow_sleep(uart);
+	}
+}
+
+int omap_uart_can_sleep(void)
+{
+	struct omap_uart_state *uart;
+	int can_sleep = 1;
+
+	list_for_each_entry(uart, &uart_list, node) {
+		if (!uart->clocked)
+			continue;
+
+		if (!uart->can_sleep) {
+			can_sleep = 0;
+			continue;
 		}
+
+		/* This UART can now safely sleep. */
+		omap_uart_allow_sleep(uart);
 	}
+
+	return can_sleep;
 }
 
+/**
+ * omap_uart_interrupt()
+ *
+ * This handler is used only to detect that *any* UART interrupt has
+ * occurred.  It does _nothing_ to handle the interrupt.  Rather,
+ * any UART interrupt will trigger the inactivity timer so the
+ * UART will not idle or sleep for its timeout period.
+ *
+ **/
+static irqreturn_t omap_uart_interrupt(int irq, void *dev_id)
+{
+	struct omap_uart_state *uart = dev_id;
+
+	omap_uart_block_sleep(uart);
+
+	return IRQ_NONE;
+}
+
+static void omap_uart_idle_init(struct omap_uart_state *uart)
+{
+	u32 v;
+	struct plat_serial8250_port *p = uart->p;
+	int ret;
+
+	uart->can_sleep = 0;
+	uart->timeout = DEFAULT_TIMEOUT;
+	setup_timer(&uart->timer, omap_uart_idle_timer,
+		    (unsigned long) uart);
+	mod_timer(&uart->timer, jiffies + uart->timeout);
+	omap_uart_smart_idle_enable(uart, 0);
+
+	if (cpu_is_omap34xx()) {
+		u32 mod = (uart->num == 2) ? OMAP3430_PER_MOD : CORE_MOD;
+		u32 wk_mask = 0;
+		u32 padconf = 0;
+
+		uart->wk_en = OMAP34XX_PRM_REGADDR(mod, PM_WKEN1);
+		uart->wk_st = OMAP34XX_PRM_REGADDR(mod, PM_WKST1);
+		switch (uart->num) {
+		case 0:
+			wk_mask = OMAP3430_ST_UART1_MASK;
+			padconf = 0x182;
+			break;
+		case 1:
+			wk_mask = OMAP3430_ST_UART2_MASK;
+			padconf = 0x17a;
+			break;
+		case 2:
+			wk_mask = OMAP3430_ST_UART3_MASK;
+			padconf = 0x19e;
+			break;
+		}
+		uart->wk_mask = wk_mask;
+		uart->padconf = padconf;
+	} else if (cpu_is_omap24xx()) {
+		u32 wk_mask = 0;
+
+		if (cpu_is_omap2430()) {
+			uart->wk_en = OMAP2430_PRM_REGADDR(CORE_MOD, PM_WKEN1);
+			uart->wk_st = OMAP2430_PRM_REGADDR(CORE_MOD, PM_WKST1);
+		} else if (cpu_is_omap2420()) {
+			uart->wk_en = OMAP2420_PRM_REGADDR(CORE_MOD, PM_WKEN1);
+			uart->wk_st = OMAP2420_PRM_REGADDR(CORE_MOD, PM_WKST1);
+		}
+		switch (uart->num) {
+		case 0:
+			wk_mask = OMAP24XX_ST_UART1_MASK;
+			break;
+		case 1:
+			wk_mask = OMAP24XX_ST_UART2_MASK;
+			break;
+		case 2:
+			wk_mask = OMAP24XX_ST_UART3_MASK;
+			break;
+		}
+		uart->wk_mask = wk_mask;
+	} else {
+		uart->wk_en = 0;
+		uart->wk_st = 0;
+		uart->wk_mask = 0;
+		uart->padconf = 0;
+	}
+
+	/* Set wake-enable bit */
+	if (uart->wk_en && uart->wk_mask) {
+		v = __raw_readl(uart->wk_en);
+		v |= uart->wk_mask;
+		__raw_writel(v, uart->wk_en);
+	}
+
+	/* Ensure IOPAD wake-enables are set */
+	if (cpu_is_omap34xx() && uart->padconf) {
+		u16 v;
+
+		v = omap_ctrl_readw(uart->padconf);
+		v |= OMAP3_PADCONF_WAKEUPENABLE0;
+		omap_ctrl_writew(v, uart->padconf);
+	}
+
+	p->flags |= UPF_SHARE_IRQ;
+	ret = request_irq(p->irq, omap_uart_interrupt, IRQF_SHARED,
+			  "serial idle", (void *)uart);
+	WARN_ON(ret);
+}
+
+#else
+static inline void omap_uart_idle_init(struct omap_uart_state *uart) {}
+#endif /* CONFIG_PM */
+
 void __init omap_serial_init(void)
 {
 	int i;
@@ -117,6 +451,7 @@ void __init omap_serial_init(void)
 
 	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
 		struct plat_serial8250_port *p = serial_platform_data + i;
+		struct omap_uart_state *uart = &omap_uart[i];
 
 		if (!(info->enabled_uarts & (1 << i))) {
 			p->membase = NULL;
@@ -125,22 +460,30 @@ void __init omap_serial_init(void)
 		}
 
 		sprintf(name, "uart%d_ick", i+1);
-		uart_ick[i] = clk_get(NULL, name);
-		if (IS_ERR(uart_ick[i])) {
+		uart->ick = clk_get(NULL, name);
+		if (IS_ERR(uart->ick)) {
 			printk(KERN_ERR "Could not get uart%d_ick\n", i+1);
-			uart_ick[i] = NULL;
-		} else
-			clk_enable(uart_ick[i]);
+			uart->ick = NULL;
+		}
 
 		sprintf(name, "uart%d_fck", i+1);
-		uart_fck[i] = clk_get(NULL, name);
-		if (IS_ERR(uart_fck[i])) {
+		uart->fck = clk_get(NULL, name);
+		if (IS_ERR(uart->fck)) {
 			printk(KERN_ERR "Could not get uart%d_fck\n", i+1);
-			uart_fck[i] = NULL;
-		} else
-			clk_enable(uart_fck[i]);
+			uart->fck = NULL;
+		}
+
+		if (!uart->ick || !uart->fck)
+			continue;
+
+		uart->num = i;
+		p->private_data = uart;
+		uart->p = p;
+		list_add(&uart->node, &uart_list);
 
-		omap_serial_reset(p);
+		omap_uart_enable_clocks(uart);
+		omap_uart_reset(uart);
+		omap_uart_idle_init(uart);
 	}
 }
 
diff --git a/arch/arm/plat-omap/include/mach/common.h b/arch/arm/plat-omap/include/mach/common.h
index 5f46249..af4105f 100644
--- a/arch/arm/plat-omap/include/mach/common.h
+++ b/arch/arm/plat-omap/include/mach/common.h
@@ -33,8 +33,6 @@ struct sys_timer;
 
 extern void omap_map_common_io(void);
 extern struct sys_timer omap_timer;
-extern void omap_serial_init(void);
-extern void omap_serial_enable_clocks(int enable);
 #ifdef CONFIG_I2C_OMAP
 extern int omap_register_i2c_bus(int bus_id, u32 clkrate,
 				 struct i2c_board_info const *info,
diff --git a/arch/arm/plat-omap/include/mach/serial.h b/arch/arm/plat-omap/include/mach/serial.h
index 8a676a0..8e89585 100644
--- a/arch/arm/plat-omap/include/mach/serial.h
+++ b/arch/arm/plat-omap/include/mach/serial.h
@@ -40,4 +40,13 @@
 			__ret;						\
 			})
 
+#ifndef __ASSEMBLER__
+extern void omap_serial_init(void);
+extern int omap_uart_can_sleep(void);
+extern void omap_uart_check_wakeup(void);
+extern void omap_uart_prepare_suspend(void);
+extern void omap_uart_prepare_idle(int num);
+extern void omap_uart_resume_idle(int num);
+#endif
+
 #endif
diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
index 96c0d93..850db2e 100644
--- a/include/linux/serial_reg.h
+++ b/include/linux/serial_reg.h
@@ -323,6 +323,7 @@
 #define UART_OMAP_MVER		0x14	/* Module version register */
 #define UART_OMAP_SYSC		0x15	/* System configuration register */
 #define UART_OMAP_SYSS		0x16	/* System status register */
+#define UART_OMAP_WER		0x17	/* Wake-up enable register */
 
 #endif /* _LINUX_SERIAL_REG_H */
 
-- 
1.6.1

