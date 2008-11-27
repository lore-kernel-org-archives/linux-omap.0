From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 2/3] OMAP3: PM: UART: disable clocks when idle
Date: Wed, 26 Nov 2008 16:29:59 -0800
Message-ID: <1227745800-5894-3-git-send-email-khilman@deeprootsystems.com>
References: <1227745800-5894-1-git-send-email-khilman@deeprootsystems.com>
 <1227745800-5894-2-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:54056 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727AbYK0AaK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 19:30:10 -0500
Received: by qw-out-2122.google.com with SMTP id 3so200752qwe.37
        for <linux-omap@vger.kernel.org>; Wed, 26 Nov 2008 16:30:10 -0800 (PST)
In-Reply-To: <1227745800-5894-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch allows the chip to hit retention when the OMAP UARTs are
inactive.  After the timeout of an activity timer, each UART is
allowed to disable its clocks so the system can enter retention.  The
activity timer is (re)activated on any UART interrupt, UART wake event
or any IO pad wakeup.

While the activity timer is active, the smart-idle mode of the UART is
also disabled.  This is due to a "feature" of the UART module that
after a UART wakeup, the smart-idle mode may be entered before the
UART has communicated the interrupt, or upon TX, an idle mode
may be entered before the TX FIFOs are emptied.

Upon suspend, the PM hook ensures the UART block is ready for sleep
and explicitly disables the clocks.  Upon resume, the UART is
re-clocked and the activity timer restarted.

To enable the clock-disabling feature of this patch, do

  # echo 1 > /sys/power/clocks_off_while_idle

Special thanks to Tero Kristo for the initial ideas and first versions
of UART idle support, and to Jouni Hogander for extra testing and
bugfixes.

Tested on OMAP3 (Beagle, custom HW) and OMAP2 (n810)

Cc: Tero Kristo <tero.kristo@nokia.com>
Cc: Jouni Hogander <jouni.hogander@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm-debug.c           |  135 -------------
 arch/arm/mach-omap2/pm.h                 |    8 -
 arch/arm/mach-omap2/pm24xx.c             |   40 ++--
 arch/arm/mach-omap2/pm34xx.c             |   14 ++
 arch/arm/mach-omap2/serial.c             |  303 +++++++++++++++++++++++++++---
 arch/arm/plat-omap/include/mach/common.h |    2 -
 arch/arm/plat-omap/include/mach/serial.h |    8 +
 7 files changed, 322 insertions(+), 188 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 0b5c044..b00f5f4 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -37,141 +37,6 @@
 #ifdef CONFIG_PM_DEBUG
 int omap2_pm_debug = 0;
 
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
-u32 omap2_read_32k_sync_counter(void)
-{
-        return omap_readl(OMAP2_32KSYNCT_BASE + 0x0010);
-}
-
-void serial_console_fclk_mask(u32 *f1, u32 *f2)
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
-void serial_console_sleep(int enable)
-{
-	if (console_iclk == NULL || console_fclk == NULL)
-		return;
-
-	if (enable) {
-		BUG_ON(serial_console_clock_disabled);
-		if (clk_get_usecount(console_fclk) == 0)
-			return;
-		if ((int) serial_console_next_disable - (int) omap2_read_32k_sync_counter() >= 0)
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
-			if (l & OMAP24XX_ST_UART1_MASK)
-				serial_wakeup = 1;
-			break;
-		case 2:
-			l = prm_read_mod_reg(CORE_MOD, PM_WKST1);
-			if (l & OMAP24XX_ST_UART2_MASK)
-				serial_wakeup = 1;
-			break;
-		case 3:
-			l = prm_read_mod_reg(CORE_MOD, OMAP24XX_PM_WKST2);
-			if (l & OMAP24XX_ST_UART3_MASK)
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
-void pm_init_serial_console(void)
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
-		prm_set_mod_reg_bits(OMAP24XX_ST_UART1_MASK, CORE_MOD,
-				     PM_WKEN1);
-		break;
-	case 2:
-		prm_set_mod_reg_bits(OMAP24XX_ST_UART2_MASK, CORE_MOD,
-				     PM_WKEN1);
-		break;
-	case 3:
-		prm_set_mod_reg_bits(OMAP24XX_ST_UART3_MASK, CORE_MOD,
-				     OMAP24XX_PM_WKEN2);
-		break;
-	}
-}
-
 #define DUMP_PRM_MOD_REG(mod, reg)    \
 	regs[reg_count].name = #mod "." #reg; \
 	regs[reg_count++].val = prm_read_mod_reg(mod, reg)
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 68c9278..468f990 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -25,18 +25,10 @@ extern void omap2_allow_sleep(void);
 
 
 #ifdef CONFIG_PM_DEBUG
-extern u32 omap2_read_32k_sync_counter(void);
 extern void omap2_pm_dump(int mode, int resume, unsigned int us);
-extern void serial_console_fclk_mask(u32 *f1, u32 *f2);
-extern void pm_init_serial_console(void);
-extern void serial_console_sleep(int enable);
 extern int omap2_pm_debug;
 #else
-#define omap2_read_32k_sync_counter()		0
-#define serial_console_sleep(enable)		do {} while (0);
-#define pm_init_serial_console()		do {} while (0);
 #define omap2_pm_dump(mode, resume, us)		do {} while (0);
-#define serial_console_fclk_mask(f1, f2)		do {} while (0);
 #define omap2_pm_debug				0
 #endif /* CONFIG_PM_DEBUG */
 #endif
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 60ff04f..87ef7c1 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -30,6 +30,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/time.h>
 
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
@@ -74,7 +75,6 @@ static int omap2_fclks_active(void)
 
 	f1 = cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
 	f2 = cm_read_mod_reg(CORE_MOD, OMAP24XX_CM_FCLKEN2);
-	serial_console_fclk_mask(&f1, &f2);
 	if (f1 | f2)
 		return 1;
 	return 0;
@@ -82,7 +82,8 @@ static int omap2_fclks_active(void)
 
 static void omap2_enter_full_retention(void)
 {
-	u32 l, sleep_time = 0;
+	u32 l;
+	struct timespec ts_preidle, ts_postidle, ts_idle;
 
 	/* There is 1 reference hold for all children of the oscillator
 	 * clock, the following will remove it. If no one else uses the
@@ -112,7 +113,7 @@ static void omap2_enter_full_retention(void)
 
 	if (omap2_pm_debug) {
 		omap2_pm_dump(0, 0, 0);
-		sleep_time = omap2_read_32k_sync_counter();
+		getnstimeofday(&ts_preidle);
 	}
 
 	/* One last check for pending IRQs to avoid extra latency due
@@ -120,22 +121,26 @@ static void omap2_enter_full_retention(void)
 	if (omap_irq_pending())
 		goto no_sleep;
 
-	serial_console_sleep(1);
+	omap_uart_prepare_idle(0);
+	omap_uart_prepare_idle(1);
+	omap_uart_prepare_idle(2);
+
 	/* Jump to SRAM suspend code */
 	omap2_sram_suspend(sdrc_read_reg(SDRC_DLLA_CTRL),
 				OMAP_SDRC_REGADDR(SDRC_DLLA_CTRL),
 				OMAP_SDRC_REGADDR(SDRC_POWER));
 no_sleep:
-	serial_console_sleep(0);
+	omap_uart_resume_idle(2);
+	omap_uart_resume_idle(1);
+	omap_uart_resume_idle(0);
 
 	if (omap2_pm_debug) {
 		unsigned long long tmp;
-		u32 resume_time;
 
-		resume_time = omap2_read_32k_sync_counter();
-		tmp = resume_time - sleep_time;
-		tmp *= 1000000;
-		omap2_pm_dump(0, 1, tmp / 32768);
+		getnstimeofday(&ts_postidle);
+		ts_idle = timespec_sub(ts_postidle, ts_preidle);
+		tmp = timespec_to_ns(&ts_idle) * NSEC_PER_USEC;
+		omap2_pm_dump(0, 1, tmp);
 	}
 	omap2_gpio_resume_after_retention();
 
@@ -196,8 +201,8 @@ static int omap2_allow_mpu_retention(void)
 
 static void omap2_enter_mpu_retention(void)
 {
-	u32 sleep_time = 0;
 	int only_idle = 0;
+	struct timespec ts_preidle, ts_postidle, ts_idle;
 
 	/* Putting MPU into the WFI state while a transfer is active
 	 * seems to cause the I2C block to timeout. Why? Good question. */
@@ -225,19 +230,18 @@ static void omap2_enter_mpu_retention(void)
 
 	if (omap2_pm_debug) {
 		omap2_pm_dump(only_idle ? 2 : 1, 0, 0);
-		sleep_time = omap2_read_32k_sync_counter();
+		getnstimeofday(&ts_preidle);
 	}
 
 	omap2_sram_idle();
 
 	if (omap2_pm_debug) {
 		unsigned long long tmp;
-		u32 resume_time;
 
-		resume_time = omap2_read_32k_sync_counter();
-		tmp = resume_time - sleep_time;
-		tmp *= 1000000;
-		omap2_pm_dump(only_idle ? 2 : 1, 1, tmp / 32768);
+		getnstimeofday(&ts_postidle);
+		ts_idle = timespec_sub(ts_postidle, ts_preidle);
+		tmp = timespec_to_ns(&ts_idle) * NSEC_PER_USEC;
+		omap2_pm_dump(only_idle ? 2 : 1, 1, tmp);
 	}
 }
 
@@ -520,8 +524,6 @@ int __init omap2_pm_init(void)
 
 	prcm_setup_regs();
 
-	pm_init_serial_console();
-
 	/* Hack to prevent MPU retention when STI console is enabled. */
 	{
 		const struct omap_sti_console_config *sti;
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index e22a11f..15fd912 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -30,6 +30,7 @@
 #include <mach/clockdomain.h>
 #include <mach/powerdomain.h>
 #include <mach/control.h>
+#include <mach/serial.h>
 
 #include "cm.h"
 #include "cm-regbits-34xx.h"
@@ -172,9 +173,15 @@ static void omap_sram_idle(void)
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
@@ -211,6 +218,11 @@ static int omap3_fclks_active(void)
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
@@ -221,6 +233,8 @@ static int omap3_can_sleep(void)
 {
 	if (!enable_dyn_sleep)
 		return 0;
+	if (!omap_uart_can_sleep())
+		return 0;
 	if (omap3_fclks_active())
 		return 0;
 	if (atomic_read(&sleep_block) > 0)
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 4dcf39c..f93dc52 100644
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
@@ -21,9 +23,37 @@
 
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
+	int force_sleep;  /* remove when 'clocks_off_while_idle' removed */
+	struct timer_list timer;
+	u32 timeout;
+
+	void __iomem *wk_st;
+	void __iomem *wk_en;
+	u32 wk_mask;
+	u32 padconf;
+
+	struct clk *ick;
+	struct clk *fck;
+	int clocked;
 
-static struct clk *uart_ick[OMAP_MAX_NR_PORTS];
-static struct clk *uart_fck[OMAP_MAX_NR_PORTS];
+	struct plat_serial8250_port *p;
+	struct list_head node;
+};
+
+static struct omap_uart_state omap_uart[OMAP_MAX_NR_PORTS];
+static LIST_HEAD(uart_list);
 
 static struct plat_serial8250_port serial_platform_data[] = {
 	{
@@ -74,27 +104,242 @@ static inline void serial_write_reg(struct plat_serial8250_port *p, int offset,
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
+static void omap_uart_smart_idle_enable(struct omap_uart_state *uart,
+					  int enable)
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
+static inline void omap_uart_enable_clocks(struct omap_uart_state *uart)
+{
+	if (uart->clocked)
+		return;
+
+	clk_enable(uart->ick);
+	clk_enable(uart->fck);
+	uart->clocked = 1;
+}
+
+static inline void omap_uart_disable_clocks(struct omap_uart_state *uart)
+{
+	if (!uart->clocked)
+		return;
+
+	uart->clocked = 0;
+	clk_disable(uart->ick);
+	clk_disable(uart->fck);
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
+		if (!clocks_off_while_idle && !uart->force_sleep)
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
+	}
+
+	return can_sleep;
+}
+
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
+	/* FIXME: finish 24xx support and testing */
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
+	} else if (cpu_is_omap2430()) {
+		uart->wk_en = OMAP2430_PRM_REGADDR(CORE_MOD, PM_WKEN1);
+		uart->wk_st = OMAP2430_PRM_REGADDR(CORE_MOD, PM_WKST1);
+	} else if (cpu_is_omap2420()) {
+		uart->wk_en = OMAP2420_PRM_REGADDR(CORE_MOD, PM_WKEN1);
+		uart->wk_st = OMAP2420_PRM_REGADDR(CORE_MOD, PM_WKST1);
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
+static void omap_uart_pm(struct uart_port *port,
+			 unsigned int state, unsigned int old_state)
+{
+	struct omap_uart_state *uart = port->private_data;
+
+	switch (state) {
+	case 0: /* D0 */
+		uart->force_sleep = 0;
+		omap_uart_block_sleep(uart);
+		break;
+	case 3: /* suspend */
+		omap_uart_allow_sleep(uart);
+		uart->force_sleep = 1;
+		break;
 	}
 }
 
@@ -117,6 +362,7 @@ void __init omap_serial_init(void)
 
 	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
 		struct plat_serial8250_port *p = serial_platform_data + i;
+		struct omap_uart_state *uart = &omap_uart[i];
 
 		if (!(info->enabled_uarts & (1 << i))) {
 			p->membase = NULL;
@@ -125,22 +371,31 @@ void __init omap_serial_init(void)
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
+		p->pm = omap_uart_pm;
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
index 8a676a0..254a775 100644
--- a/arch/arm/plat-omap/include/mach/serial.h
+++ b/arch/arm/plat-omap/include/mach/serial.h
@@ -40,4 +40,12 @@
 			__ret;						\
 			})
 
+#ifndef __ASSEMBLER__
+extern void omap_serial_init(void);
+extern int omap_uart_can_sleep(void);
+extern void omap_uart_check_wakeup(void);
+extern void omap_uart_prepare_idle(int num);
+extern void omap_uart_resume_idle(int num);
+#endif
+
 #endif
-- 
1.6.0.3

