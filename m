From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 3/7] OMAP2+: UART: Remove certain uart calls from sram_idle
Date: Mon, 28 Feb 2011 20:09:14 +0530
Message-ID: <1298903958-6496-4-git-send-email-govindraj.raja@ti.com>
References: <1298903958-6496-1-git-send-email-govindraj.raja@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35769 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754267Ab1B1OP6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Feb 2011 09:15:58 -0500
In-Reply-To: <1298903958-6496-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: "Govindraj.R" <govindraj.raja@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>

In preparation to UART runtime conversion. Remove certain uart specific calls
from sram_idle path in pm24xx/34xx files.
These func calls will no more be used with upcoming uart runtime design.

1.) Removing console lock holding :- Now can be handled with omap-serial file
    itself with appropraite console_enable/disable calls for clk_enable/disable
    cases.
2.) omap_uart_can_sleep :- not needed driver can decide based on inactivity.
3.) omap_uart_prepare_suspend :- omap-serial can take care with driver
    suspend/resume hooks.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/pm24xx.c             |   11 -----------
 arch/arm/mach-omap2/pm34xx.c             |   16 ----------------
 arch/arm/plat-omap/include/plat/serial.h |    4 ----
 3 files changed, 0 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 97feb3a..5af9881 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -132,11 +132,6 @@ static void omap2_enter_full_retention(void)
 	if (omap_irq_pending())
 		goto no_sleep;
 
-	/* Block console output in case it is on one of the OMAP UARTs */
-	if (!is_suspending())
-		if (!console_trylock())
-			goto no_sleep;
-
 	omap_uart_prepare_idle(0);
 	omap_uart_prepare_idle(1);
 	omap_uart_prepare_idle(2);
@@ -150,9 +145,6 @@ static void omap2_enter_full_retention(void)
 	omap_uart_resume_idle(1);
 	omap_uart_resume_idle(0);
 
-	if (!is_suspending())
-		console_unlock();
-
 no_sleep:
 	if (omap2_pm_debug) {
 		unsigned long long tmp;
@@ -267,8 +259,6 @@ static int omap2_can_sleep(void)
 {
 	if (omap2_fclks_active())
 		return 0;
-	if (!omap_uart_can_sleep())
-		return 0;
 	if (osc_ck->usecount > 1)
 		return 0;
 	if (omap_dma_running())
@@ -319,7 +309,6 @@ static int omap2_pm_suspend(void)
 	mir1 = omap_readl(0x480fe0a4);
 	omap_writel(1 << 5, 0x480fe0ac);
 
-	omap_uart_prepare_suspend();
 	omap2_enter_full_retention();
 
 	omap_writel(mir1, 0x480fe0a4);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 2f864e4..850bb0a 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -395,13 +395,6 @@ void omap_sram_idle(void)
 		omap3_enable_io_chain();
 	}
 
-	/* Block console output in case it is on one of the OMAP UARTs */
-	if (!is_suspending())
-		if (per_next_state < PWRDM_POWER_ON ||
-		    core_next_state < PWRDM_POWER_ON)
-			if (!console_trylock())
-				goto console_still_active;
-
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
 		per_going_off = (per_next_state == PWRDM_POWER_OFF) ? 1 : 0;
@@ -481,10 +474,6 @@ void omap_sram_idle(void)
 		omap_uart_resume_idle(3);
 	}
 
-	if (!is_suspending())
-		console_unlock();
-
-console_still_active:
 	/* Disable IO-PAD and IO-CHAIN wakeup */
 	if (omap3_has_io_wakeup() &&
 	    (per_next_state < PWRDM_POWER_ON ||
@@ -503,8 +492,6 @@ int omap3_can_sleep(void)
 {
 	if (!sleep_while_idle)
 		return 0;
-	if (!omap_uart_can_sleep())
-		return 0;
 	return 1;
 }
 
@@ -547,7 +534,6 @@ static int omap3_pm_suspend(void)
 			goto restore;
 	}
 
-	omap_uart_prepare_suspend();
 	omap3_intc_suspend();
 
 	omap_sram_idle();
@@ -594,14 +580,12 @@ static int omap3_pm_begin(suspend_state_t state)
 {
 	disable_hlt();
 	suspend_state = state;
-	omap_uart_enable_irqs(0);
 	return 0;
 }
 
 static void omap3_pm_end(void)
 {
 	suspend_state = PM_SUSPEND_ON;
-	omap_uart_enable_irqs(1);
 	enable_hlt();
 	return;
 }
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index 8061695..6339848 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -106,12 +106,8 @@ struct omap_board_data;
 
 extern void omap_serial_init(void);
 extern void omap_serial_init_port(struct omap_board_data *bdata);
-extern int omap_uart_can_sleep(void);
-extern void omap_uart_check_wakeup(void);
-extern void omap_uart_prepare_suspend(void);
 extern void omap_uart_prepare_idle(int num);
 extern void omap_uart_resume_idle(int num);
-extern void omap_uart_enable_irqs(int enable);
 #endif
 
 #endif
-- 
1.7.1

