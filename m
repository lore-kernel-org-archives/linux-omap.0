From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH 3/4] Added sleep support to UART
Date: Fri, 15 Aug 2008 10:47:20 +0300
Message-ID: <1218786440-28089-1-git-send-email-jouni.hogander@nokia.com>
References: <87iqu2rac0.fsf@trdhcp146196.ntc.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:44320 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351AbYHOHri (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Aug 2008 03:47:38 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7F7lQ9A027509
	for <linux-omap@vger.kernel.org>; Fri, 15 Aug 2008 10:47:35 +0300
In-Reply-To: <87iqu2rac0.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tero Kristo <tero.kristo@nokia.com>

From: Tero Kristo <tero.kristo@nokia.com>

UART usage (e.g. serial console) now denies sleep for 5 seconds. This
makes it possible to use serial console when dynamic idle is
enabled. Write 1 to /sys/power/clocks_off_while_sleep to enable uart
clock disable on idle. Without this omap won't enter retention.

Also moved code from pm-debug.c to serial.c, and made pm24xx.c use
this new implementation.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/pm-debug.c           |  132 --------------------------
 arch/arm/mach-omap2/pm.h                 |    7 --
 arch/arm/mach-omap2/pm24xx.c             |   57 +++++++-----
 arch/arm/mach-omap2/pm34xx.c             |   27 ++++--
 arch/arm/mach-omap2/serial.c             |  148 ++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/common.h |    3 +
 6 files changed, 204 insertions(+), 170 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 1b14bcf..b00f5f4 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -37,138 +37,6 @@
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
-		prm_set_mod_reg_bits(OMAP24XX_ST_UART1, CORE_MOD, PM_WKEN1);
-		break;
-	case 2:
-		prm_set_mod_reg_bits(OMAP24XX_ST_UART2, CORE_MOD, PM_WKEN1);
-		break;
-	case 3:
-		prm_set_mod_reg_bits(OMAP24XX_ST_UART3, CORE_MOD, OMAP24XX_PM_WKEN2);
-		break;
-	}
-}
-
 #define DUMP_PRM_MOD_REG(mod, reg)    \
 	regs[reg_count].name = #mod "." #reg; \
 	regs[reg_count++].val = prm_read_mod_reg(mod, reg)
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 68c9278..fe3f764 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -25,16 +25,9 @@ extern void omap2_allow_sleep(void);
 
 
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
 #define serial_console_fclk_mask(f1, f2)		do {} while (0);
 #define omap2_pm_debug				0
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 5c76120..d766a35 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -44,6 +44,7 @@
 #include <mach/mux.h>
 #include <mach/dma.h>
 #include <mach/board.h>
+#include <mach/common.h>
 
 #include "prm.h"
 #include "prm-regbits-24xx.h"
@@ -73,7 +74,10 @@ static int omap2_fclks_active(void)
 
 	f1 = cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
 	f2 = cm_read_mod_reg(CORE_MOD, OMAP24XX_CM_FCLKEN2);
-	serial_console_fclk_mask(&f1, &f2);
+
+	if (clocks_off_while_idle)
+		omap_serial_fclk_mask(&f1, &f2);
+
 	if (f1 | f2)
 		return 1;
 	return 0;
@@ -81,7 +85,8 @@ static int omap2_fclks_active(void)
 
 static void omap2_enter_full_retention(void)
 {
-	u32 l, sleep_time = 0;
+	u32 l = 0;
+	struct timespec sleep_time;
 
 	/* There is 1 reference hold for all children of the oscillator
 	 * clock, the following will remove it. If no one else uses the
@@ -111,28 +116,33 @@ static void omap2_enter_full_retention(void)
 
 	if (omap2_pm_debug) {
 		omap2_pm_dump(0, 0, 0);
-		sleep_time = omap2_read_32k_sync_counter();
+		getnstimeofday(&sleep_time);
 	}
 
+	if (clocks_off_while_idle)
+		omap_serial_enable_clocks(0);
+
 	/* One last check for pending IRQs to avoid extra latency due
 	 * to sleeping unnecessarily. */
 	if (omap_irq_pending())
 		goto no_sleep;
 
-	serial_console_sleep(1);
 	/* Jump to SRAM suspend code */
 	omap2_sram_suspend(OMAP_SDRC_REGADDR(SDRC_DLLA_CTRL));
 no_sleep:
-	serial_console_sleep(0);
+	omap_serial_check_wakeup();
+	if (clocks_off_while_idle)
+		omap_serial_enable_clocks(1);
 
 	if (omap2_pm_debug) {
-		unsigned long long tmp;
-		u32 resume_time;
-
-		resume_time = omap2_read_32k_sync_counter();
-		tmp = resume_time - sleep_time;
-		tmp *= 1000000;
-		omap2_pm_dump(0, 1, tmp / 32768);
+		struct timespec t;
+		struct timespec ts_delta;
+
+		getnstimeofday(&t);
+		ts_delta = timespec_sub(t, sleep_time);
+		omap2_pm_dump(0, 1,
+			      div_s64(timespec_to_ns(&ts_delta),
+				      NSEC_PER_USEC));
 	}
 	omap2_gpio_resume_after_retention();
 
@@ -193,7 +203,7 @@ static int omap2_allow_mpu_retention(void)
 
 static void omap2_enter_mpu_retention(void)
 {
-	u32 sleep_time = 0;
+	struct timespec sleep_time;
 	int only_idle = 0;
 
 	/* Putting MPU into the WFI state while a transfer is active
@@ -222,19 +232,20 @@ static void omap2_enter_mpu_retention(void)
 
 	if (omap2_pm_debug) {
 		omap2_pm_dump(only_idle ? 2 : 1, 0, 0);
-		sleep_time = omap2_read_32k_sync_counter();
+		getnstimeofday(&sleep_time);
 	}
 
 	omap2_sram_idle();
 
 	if (omap2_pm_debug) {
-		unsigned long long tmp;
-		u32 resume_time;
-
-		resume_time = omap2_read_32k_sync_counter();
-		tmp = resume_time - sleep_time;
-		tmp *= 1000000;
-		omap2_pm_dump(only_idle ? 2 : 1, 1, tmp / 32768);
+		struct timespec t;
+		struct timespec ts_delta;
+
+		getnstimeofday(&t);
+		ts_delta = timespec_sub(t, sleep_time);
+		omap2_pm_dump(only_idle ? 2 : 1, 1,
+			      div_s64(timespec_to_ns(&ts_delta),
+				      NSEC_PER_USEC));
 	}
 }
 
@@ -250,6 +261,8 @@ static int omap2_can_sleep(void)
 		return 0;
 	if (omap_dma_running())
 		return 0;
+	if (!omap_serial_can_sleep())
+		return 0;
 
 	return 1;
 }
@@ -517,8 +530,6 @@ int __init omap2_pm_init(void)
 
 	prcm_setup_regs();
 
-	pm_init_serial_console();
-
 	/* Hack to prevent MPU retention when STI console is enabled. */
 	{
 		const struct omap_sti_console_config *sti;
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7d5d461..29b4eee 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -29,6 +29,7 @@
 #include <mach/pm.h>
 #include <mach/clockdomain.h>
 #include <mach/powerdomain.h>
+#include <mach/common.h>
 
 #include "cm.h"
 #include "cm-regbits-34xx.h"
@@ -89,6 +90,9 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 	u32 wkst, irqstatus_mpu;
 	u32 fclk, iclk;
 
+	/* Check if we woke up to serial console activity */
+	omap_serial_check_wakeup();
+
 	/* WKUP */
 	wkst = prm_read_mod_reg(WKUP_MOD, PM_WKST);
 	if (wkst) {
@@ -198,18 +202,21 @@ static void omap_sram_idle(void)
 	}
 
 	omap2_gpio_prepare_for_retention();
-
-	/* XXX This is for gpio fclk hack. Will be removed as gpio driver
-	 * handles fcks correctly */
-	if (clocks_off_while_idle)
+	if (clocks_off_while_idle) {
+		omap_serial_enable_clocks(0);
+		/* XXX This is for gpio fclk hack. Will be removed as
+		 * gpio driver * handles fcks correctly */
 		per_gpio_clk_disable();
+	}
 
 	_omap_sram_idle(NULL, save_state);
 
-	/* XXX This is for gpio fclk hack. Will be removed as gpio driver
-	 * handles fcks correctly */
-	if (clocks_off_while_idle)
+	if (clocks_off_while_idle) {
+		omap_serial_enable_clocks(1);
+		/* XXX This is for gpio fclk hack. Will be removed as
+		 * gpio driver * handles fcks correctly */
 		per_gpio_clk_enable();
+	}
 
 	omap2_gpio_resume_after_retention();
 }
@@ -241,8 +248,10 @@ static int omap3_fclks_active(void)
 	fck_per = cm_read_mod_reg(OMAP3430_PER_MOD,
 				  CM_FCLKEN);
 
-	if (clocks_off_while_idle)
+	if (clocks_off_while_idle) {
 		gpio_fclk_mask(&fck_per);
+		omap_serial_fclk_mask(&fck_core1, &fck_per);
+	}
 
 	if (fck_core1 | fck_core3 | fck_sgx | fck_dss |
 	    fck_cam | fck_per | fck_usbhost)
@@ -261,6 +270,8 @@ static int omap3_can_sleep(void)
 		return 0;
 	if (atomic_read(&sleep_block) > 0)
 		return 0;
+	if (!omap_serial_can_sleep())
+		return 0;
 	return 1;
 }
 
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index d9fca6f..f55ab25 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -22,9 +22,66 @@
 
 #include <mach/common.h>
 #include <mach/board.h>
+#include <mach/clock.h>
+#include <mach/control.h>
+
+#include "prm.h"
+#include "pm.h"
+
+#define SERIAL_AWAKE_TIME 5
 
 static struct clk *uart_ick[OMAP_MAX_NR_PORTS];
 static struct clk *uart_fck[OMAP_MAX_NR_PORTS];
+static struct timespec omap_serial_next_sleep;
+
+#ifdef CONFIG_ARCH_OMAP24XX
+static const u32 omap2_uart_wk_st[OMAP_MAX_NR_PORTS] = {
+	OMAP2420_PRM_REGADDR(CORE_MOD, PM_WKST1),
+	OMAP2420_PRM_REGADDR(CORE_MOD, PM_WKST1),
+	OMAP2420_PRM_REGADDR(CORE_MOD, OMAP24XX_PM_WKST2)
+};
+static const u32 omap2_uart_wk_en[OMAP_MAX_NR_PORTS] = {
+	OMAP2420_PRM_REGADDR(CORE_MOD, PM_WKEN1),
+	OMAP2420_PRM_REGADDR(CORE_MOD, PM_WKEN1),
+	OMAP2420_PRM_REGADDR(CORE_MOD, OMAP24XX_PM_WKEN2),
+};
+static const u32 omap2_uart_wk_bit[OMAP_MAX_NR_PORTS] = {
+	OMAP24XX_ST_UART1, OMAP24XX_ST_UART2, OMAP24XX_ST_UART3
+};
+#endif
+
+#ifdef CONFIG_ARCH_OMAP34XX
+static const u32 omap3_uart_wk_st[OMAP_MAX_NR_PORTS] = {
+	OMAP34XX_PRM_REGADDR(CORE_MOD, PM_WKST1),
+	OMAP34XX_PRM_REGADDR(CORE_MOD, PM_WKST1),
+	OMAP34XX_PRM_REGADDR(OMAP3430_PER_MOD, PM_WKST1)
+};
+static const u32 omap3_uart_wk_en[OMAP_MAX_NR_PORTS] = {
+	OMAP34XX_PRM_REGADDR(CORE_MOD, PM_WKEN1),
+	OMAP34XX_PRM_REGADDR(CORE_MOD, PM_WKEN1),
+	OMAP34XX_PRM_REGADDR(OMAP3430_PER_MOD, PM_WKEN1)
+};
+static const u32 omap3_uart_wk_bit[OMAP_MAX_NR_PORTS] = {
+	OMAP3430_ST_UART1, OMAP3430_ST_UART2, OMAP3430_ST_UART3
+};
+#endif
+
+static const u32 *omap_uart_wk_st;
+static const u32 *omap_uart_wk_en;
+static const u32 *omap_uart_wk_bit;
+
+/* UART padconfig registers, these may differ if non-default padconfig
+   is used */
+#define CONTROL_PADCONF_UART1_RX 0x182
+#define CONTROL_PADCONF_UART2_RX 0x17A
+#define CONTROL_PADCONF_UART3_RX 0x19E
+#define PADCONF_WAKEUP_ST 0x8000
+
+static const u32 omap34xx_uart_padconf[OMAP_MAX_NR_PORTS] = {
+	CONTROL_PADCONF_UART1_RX,
+	CONTROL_PADCONF_UART2_RX,
+	CONTROL_PADCONF_UART3_RX
+};
 
 static struct plat_serial8250_port serial_platform_data[] = {
 	{
@@ -83,6 +140,13 @@ static inline void __init omap_serial_reset(struct plat_serial8250_port *p)
 	serial_write_reg(p, UART_OMAP_SYSC, (0x02 << 3) | (1 << 2) | (1 << 0));
 }
 
+static void omap_serial_kick(void)
+{
+	getnstimeofday(&omap_serial_next_sleep);
+	timespec_add_ns(&omap_serial_next_sleep, (s64)SERIAL_AWAKE_TIME *
+		NSEC_PER_SEC);
+}
+
 void omap_serial_enable_clocks(int enable)
 {
 	int i;
@@ -99,6 +163,67 @@ void omap_serial_enable_clocks(int enable)
 	}
 }
 
+void omap_serial_fclk_mask(u32 *f1, u32 *f2)
+{
+	if (uart_ick[0])
+		*f1 &= ~(1 << uart_fck[0]->enable_bit);
+	if (uart_ick[1])
+		*f1 &= ~(1 << uart_fck[1]->enable_bit);
+	if (uart_ick[2])
+		*f2 &= ~(1 << uart_fck[2]->enable_bit);
+}
+
+void omap_serial_check_wakeup(void)
+{
+	int i;
+
+
+	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
+		if (!uart_ick[i])
+			continue;
+
+		if (cpu_is_omap34xx())
+			if (omap_ctrl_readw(omap34xx_uart_padconf[i]) &
+			    PADCONF_WAKEUP_ST) {
+				omap_serial_kick();
+				return;
+			}
+
+		if (__raw_readl(omap_uart_wk_st[i]) &
+		    omap_uart_wk_bit[i]) {
+			omap_serial_kick();
+			return;
+		}
+	}
+}
+
+int omap_serial_can_sleep(void)
+{
+	int i;
+	struct timespec t;
+
+	struct plat_serial8250_port *p = serial_platform_data;
+
+	getnstimeofday(&t);
+
+	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
+		if (!uart_ick[i])
+			continue;
+		/* Check if we have data in the transmit buffer */
+		if ((serial_read_reg(p + i, UART_LSR) &
+			(UART_LSR_TEMT|UART_LSR_THRE))
+			!= (UART_LSR_TEMT|UART_LSR_THRE)) {
+				omap_serial_kick();
+				return 0;
+		}
+	}
+
+	if (timespec_compare(&t, &omap_serial_next_sleep) < 0)
+		return 0;
+
+	return 1;
+}
+
 void __init omap_serial_init(void)
 {
 	int i;
@@ -116,8 +241,25 @@ void __init omap_serial_init(void)
 	if (info == NULL)
 		return;
 
+#ifdef CONFIG_ARCH_OMAP24XX
+	if (cpu_is_omap242x()) {
+		omap_uart_wk_st = omap2_uart_wk_st;
+		omap_uart_wk_en = omap2_uart_wk_en;
+		omap_uart_wk_bit = omap2_uart_wk_bit;
+	}
+#endif
+
+#ifdef CONFIG_ARCH_OMAP34XX
+	if (cpu_is_omap34xx()) {
+		omap_uart_wk_st = omap3_uart_wk_st;
+		omap_uart_wk_en = omap3_uart_wk_en;
+		omap_uart_wk_bit = omap3_uart_wk_bit;
+	}
+#endif
+
 	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
 		struct plat_serial8250_port *p = serial_platform_data + i;
+		u32 v;
 
 		if (!(info->enabled_uarts & (1 << i))) {
 			p->membase = NULL;
@@ -142,7 +284,13 @@ void __init omap_serial_init(void)
 			clk_enable(uart_fck[i]);
 
 		omap_serial_reset(p);
+
+		v = __raw_readl(omap_uart_wk_en[i]);
+		v |= omap_uart_wk_bit[i];
+		__raw_writel(v, omap_uart_wk_en[i]);
 	}
+
+	omap_serial_kick();
 }
 
 static struct platform_device serial_device = {
diff --git a/arch/arm/plat-omap/include/mach/common.h b/arch/arm/plat-omap/include/mach/common.h
index 5f46249..003c08e 100644
--- a/arch/arm/plat-omap/include/mach/common.h
+++ b/arch/arm/plat-omap/include/mach/common.h
@@ -35,6 +35,9 @@ extern void omap_map_common_io(void);
 extern struct sys_timer omap_timer;
 extern void omap_serial_init(void);
 extern void omap_serial_enable_clocks(int enable);
+extern int omap_serial_can_sleep(void);
+extern void omap_serial_fclk_mask(u32 *f1, u32 *f2);
+void omap_serial_check_wakeup(void);
 #ifdef CONFIG_I2C_OMAP
 extern int omap_register_i2c_bus(int bus_id, u32 clkrate,
 				 struct i2c_board_info const *info,
-- 
1.5.5

