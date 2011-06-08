From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v3 01/12] OMAP2+: UART: Remove certain uart calls from sram_idle
Date: Wed, 8 Jun 2011 16:53:03 +0530
Message-ID: <1307532194-13039-2-git-send-email-govindraj.raja@ti.com>
References: <1307532194-13039-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1307532194-13039-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

In preparation to UART runtime conversion. Remove certain uart specific calls
from sram_idle path in pm24xx/34xx files.
These func calls will no more be used with upcoming uart runtime design.

1.) Removing console lock holding :- Now can be handled with omap-serial file
    itself.
2.) omap_uart_can_sleep :- not needed driver can autosuspend based on usage_count
    and autosuspend delay.
3.) omap_uart_prepare_suspend :- omap-serial can be taken care with driver
    suspend/resume hooks.
4.) Also remove individual uart_prepare/resume calls.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/pm24xx.c             |   19 -------------------
 arch/arm/mach-omap2/pm34xx.c             |   24 ------------------------
 arch/arm/plat-omap/include/plat/serial.h |    6 ------
 3 files changed, 0 insertions(+), 49 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index df3ded6..c405bda 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -132,27 +132,11 @@ static void omap2_enter_full_retention(void)
 	if (omap_irq_pending())
 		goto no_sleep;
 
-	/* Block console output in case it is on one of the OMAP UARTs */
-	if (!is_suspending())
-		if (!console_trylock())
-			goto no_sleep;
-
-	omap_uart_prepare_idle(0);
-	omap_uart_prepare_idle(1);
-	omap_uart_prepare_idle(2);
-
 	/* Jump to SRAM suspend code */
 	omap2_sram_suspend(sdrc_read_reg(SDRC_DLLA_CTRL),
 			   OMAP_SDRC_REGADDR(SDRC_DLLA_CTRL),
 			   OMAP_SDRC_REGADDR(SDRC_POWER));
 
-	omap_uart_resume_idle(2);
-	omap_uart_resume_idle(1);
-	omap_uart_resume_idle(0);
-
-	if (!is_suspending())
-		console_unlock();
-
 no_sleep:
 	if (omap2_pm_debug) {
 		unsigned long long tmp;
@@ -267,8 +251,6 @@ static int omap2_can_sleep(void)
 {
 	if (omap2_fclks_active())
 		return 0;
-	if (!omap_uart_can_sleep())
-		return 0;
 	if (osc_ck->usecount > 1)
 		return 0;
 	if (omap_dma_running())
@@ -319,7 +301,6 @@ static int omap2_pm_suspend(void)
 	mir1 = omap_readl(0x480fe0a4);
 	omap_writel(1 << 5, 0x480fe0ac);
 
-	omap_uart_prepare_suspend();
 	omap2_enter_full_retention();
 
 	omap_writel(mir1, 0x480fe0a4);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index c155c9d..ac7b7f8 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -391,18 +391,9 @@ void omap_sram_idle(void)
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
-		omap_uart_prepare_idle(2);
-		omap_uart_prepare_idle(3);
 		omap2_gpio_prepare_for_idle(per_going_off);
 		if (per_next_state == PWRDM_POWER_OFF)
 				omap3_per_save_context();
@@ -410,8 +401,6 @@ void omap_sram_idle(void)
 
 	/* CORE */
 	if (core_next_state < PWRDM_POWER_ON) {
-		omap_uart_prepare_idle(0);
-		omap_uart_prepare_idle(1);
 		if (core_next_state == PWRDM_POWER_OFF) {
 			omap3_core_save_context();
 			omap3_cm_save_context();
@@ -458,8 +447,6 @@ void omap_sram_idle(void)
 			omap3_sram_restore_context();
 			omap2_sms_restore_context();
 		}
-		omap_uart_resume_idle(0);
-		omap_uart_resume_idle(1);
 		if (core_next_state == PWRDM_POWER_OFF)
 			omap2_prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF_MASK,
 					       OMAP3430_GR_MOD,
@@ -473,14 +460,8 @@ void omap_sram_idle(void)
 		omap2_gpio_resume_after_idle();
 		if (per_prev_state == PWRDM_POWER_OFF)
 			omap3_per_restore_context();
-		omap_uart_resume_idle(2);
-		omap_uart_resume_idle(3);
 	}
 
-	if (!is_suspending())
-		console_unlock();
-
-console_still_active:
 	/* Disable IO-PAD and IO-CHAIN wakeup */
 	if (omap3_has_io_wakeup() &&
 	    (per_next_state < PWRDM_POWER_ON ||
@@ -499,8 +480,6 @@ int omap3_can_sleep(void)
 {
 	if (!sleep_while_idle)
 		return 0;
-	if (!omap_uart_can_sleep())
-		return 0;
 	return 1;
 }
 
@@ -549,7 +528,6 @@ static int omap3_pm_suspend(void)
 			goto restore;
 	}
 
-	omap_uart_prepare_suspend();
 	omap3_intc_suspend();
 
 	omap_sram_idle();
@@ -596,14 +574,12 @@ static int omap3_pm_begin(suspend_state_t state)
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
index 2723f91..ab1761a 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -106,12 +106,6 @@ struct omap_board_data;
 
 extern void omap_serial_init(void);
 extern void omap_serial_init_port(struct omap_board_data *bdata);
-extern int omap_uart_can_sleep(void);
-extern void omap_uart_check_wakeup(void);
-extern void omap_uart_prepare_suspend(void);
-extern void omap_uart_prepare_idle(int num);
-extern void omap_uart_resume_idle(int num);
-extern void omap_uart_enable_irqs(int enable);
 #endif
 
 #endif
-- 
1.7.0.4

