From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v6 03/16] OMAP2+: UART: cleanup + remove uart pm specific API
Date: Fri, 30 Sep 2011 16:31:29 +0530
Message-ID: <1317380495-584-3-git-send-email-govindraj.raja@ti.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Govindraj R <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

In preparation to UART runtime conversion remove uart specific calls
from pm24xx/34xx files and their definition from serial.c
These func calls will no more be used with upcoming uart runtime design.

1.) omap_uart_prepare_suspend :- can be taken care with driver suspend hooks.
2.) omap_uart_enable_irqs :- Used to enable/disable uart irq's in suspend
    path from PM code, this is removed as same is handled by
    uart_suspend_port/uart_resume_port in omap-serial driver which will
    do an port_shutdown on suspend freeing irq and port_startup on resume
    enabling back irq.
3.) Remove prepare_idle/resume_idle calls used to gate uart clocks.
    UART clocks can be gated within driver using runtime funcs
    and be woken up using irq_chaining from omap_prm driver.
4.) Remove console_locking from idle path as clock gating is done withing
    driver itself with runtime API.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/pm24xx.c             |   18 --------
 arch/arm/mach-omap2/pm34xx.c             |   23 ----------
 arch/arm/mach-omap2/serial.c             |   65 ------------------------------
 arch/arm/plat-omap/include/plat/serial.h |    4 --
 4 files changed, 0 insertions(+), 110 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index bf089e7..a75f764 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -30,7 +30,6 @@
 #include <linux/irq.h>
 #include <linux/time.h>
 #include <linux/gpio.h>
-#include <linux/console.h>
 
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
@@ -133,27 +132,11 @@ static void omap2_enter_full_retention(void)
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
@@ -317,7 +300,6 @@ static int omap2_pm_suspend(void)
 	mir1 = omap_readl(0x480fe0a4);
 	omap_writel(1 << 5, 0x480fe0ac);
 
-	omap_uart_prepare_suspend();
 	omap2_enter_full_retention();
 
 	omap_writel(mir1, 0x480fe0a4);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7255d9b..344d412 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -28,7 +28,6 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
-#include <linux/console.h>
 #include <trace/events/power.h>
 
 #include <asm/suspend.h>
@@ -379,18 +378,9 @@ void omap_sram_idle(void)
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
@@ -398,8 +388,6 @@ void omap_sram_idle(void)
 
 	/* CORE */
 	if (core_next_state < PWRDM_POWER_ON) {
-		omap_uart_prepare_idle(0);
-		omap_uart_prepare_idle(1);
 		if (core_next_state == PWRDM_POWER_OFF) {
 			omap3_core_save_context();
 			omap3_cm_save_context();
@@ -446,8 +434,6 @@ void omap_sram_idle(void)
 			omap3_sram_restore_context();
 			omap2_sms_restore_context();
 		}
-		omap_uart_resume_idle(0);
-		omap_uart_resume_idle(1);
 		if (core_next_state == PWRDM_POWER_OFF)
 			omap2_prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF_MASK,
 					       OMAP3430_GR_MOD,
@@ -461,14 +447,8 @@ void omap_sram_idle(void)
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
@@ -531,7 +511,6 @@ static int omap3_pm_suspend(void)
 			goto restore;
 	}
 
-	omap_uart_prepare_suspend();
 	omap3_intc_suspend();
 
 	omap_sram_idle();
@@ -578,14 +557,12 @@ static int omap3_pm_begin(suspend_state_t state)
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
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 3d1c1d3..62d15ad 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -389,51 +389,6 @@ static void omap_uart_idle_timer(unsigned long data)
 	omap_uart_allow_sleep(uart);
 }
 
-void omap_uart_prepare_idle(int num)
-{
-	struct omap_uart_state *uart;
-
-	list_for_each_entry(uart, &uart_list, node) {
-		if (num == uart->num && uart->can_sleep) {
-			omap_uart_disable_clocks(uart);
-			return;
-		}
-	}
-}
-
-void omap_uart_resume_idle(int num)
-{
-	struct omap_uart_state *uart;
-
-	list_for_each_entry(uart, &uart_list, node) {
-		if (num == uart->num && uart->can_sleep) {
-			omap_uart_enable_clocks(uart);
-
-			/* Check for IO pad wakeup */
-			if (cpu_is_omap34xx() && uart->padconf) {
-				u16 p = omap_ctrl_readw(uart->padconf);
-
-				if (p & OMAP3_PADCONF_WAKEUPEVENT0)
-					omap_uart_block_sleep(uart);
-			}
-
-			/* Check for normal UART wakeup */
-			if (__raw_readl(uart->wk_st) & uart->wk_mask)
-				omap_uart_block_sleep(uart);
-			return;
-		}
-	}
-}
-
-void omap_uart_prepare_suspend(void)
-{
-	struct omap_uart_state *uart;
-
-	list_for_each_entry(uart, &uart_list, node) {
-		omap_uart_allow_sleep(uart);
-	}
-}
-
 int omap_uart_can_sleep(void)
 {
 	struct omap_uart_state *uart;
@@ -552,26 +507,6 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 	WARN_ON(ret);
 }
 
-void omap_uart_enable_irqs(int enable)
-{
-	int ret;
-	struct omap_uart_state *uart;
-
-	list_for_each_entry(uart, &uart_list, node) {
-		if (enable) {
-			pm_runtime_put_sync(&uart->pdev->dev);
-			ret = request_threaded_irq(uart->irq, NULL,
-						   omap_uart_interrupt,
-						   IRQF_SHARED,
-						   "serial idle",
-						   (void *)uart);
-		} else {
-			pm_runtime_get_noresume(&uart->pdev->dev);
-			free_irq(uart->irq, (void *)uart);
-		}
-	}
-}
-
 static ssize_t sleep_timeout_show(struct device *dev,
 				  struct device_attribute *attr,
 				  char *buf)
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index de3b10c..fc8b60c 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -111,10 +111,6 @@ extern void omap_serial_init(void);
 extern void omap_serial_init_port(struct omap_board_data *bdata);
 extern int omap_uart_can_sleep(void);
 extern void omap_uart_check_wakeup(void);
-extern void omap_uart_prepare_suspend(void);
-extern void omap_uart_prepare_idle(int num);
-extern void omap_uart_resume_idle(int num);
-extern void omap_uart_enable_irqs(int enable);
 #endif
 
 #endif
-- 
1.7.4.1

