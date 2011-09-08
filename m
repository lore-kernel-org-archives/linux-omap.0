From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 25/25] OMAP3: CPUidle: Make use of CPU PM notifiers
Date: Thu, 08 Sep 2011 10:57:46 -0700
Message-ID: <87vct2hq79.fsf@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-26-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1315144466-9395-26-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Sun, 4 Sep 2011 19:24:26 +0530")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, rnayak@ti.com
List-Id: linux-omap@vger.kernel.org

Hi Santosh,

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> These notifiers can be used to isolate non-cpu specific PM
> code from CPU idle code.
>
> To start with, we can already leverage VFP handlers using notifier
> chain for low power idle code. So use them.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>

A comment below related to our other discussion in the CPU PM notifiers
thread...

> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index 4bf6e6e..1112519 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -24,6 +24,7 @@
>  
>  #include <linux/sched.h>
>  #include <linux/cpuidle.h>
> +#include <linux/cpu_pm.h>
>  
>  #include <plat/prcm.h>
>  #include <plat/irqs.h>
> @@ -118,9 +119,15 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
>  		pwrdm_for_each_clkdm(core_pd, _cpuidle_deny_idle);
>  	}
>  
> +	if (mpu_state == PWRDM_POWER_OFF)
> +		cpu_pm_enter();

Making all CPU PM notifiers conditional on the MPU power state is not
right since upon an MPU transition, other domains might also transition.

What if there are notifiers for other drivers in other power domains
whose states might be transitioning?  Notifiers for those devices should
be called no matter what the MPU's target state is.

Also triggering the notifiers here has the same problem that I mentioned
with the syscore PM ops.  Namely, that next power states are not yet
determined, so any device notifier decisions based on that will be wrong.

The way I envision this working is (at least on OMAP) is CPU PM
notifiers are triggered only *after* the next power states are
determined and programmed.  This allows the device-specific notifiers to
check their target power state and take appropriate action.

I've been testing the CPU PM notifiers with the patch below (after also
dropping [PATCH 2/5] from your the CPU PM notifiers series.)  This patch works
for both suspend and idle by using the code common to them, and
triggering the event only after the target states are programmed.

I'm testing this patch now along with the 2nd patch below which removes
all the UART calls from the idle/suspend path and just adds a notifier
in the UART driver.

Will post these officially after a bit more testing, but so far it's
working on OMAP2420/n810 and OMAP3430/n900.

Kevin


>From 8ad40f8c7f950105b25cc8d2cc35caa50871f86f Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Wed, 7 Sep 2011 12:04:44 -0700
Subject: [PATCH 1/2] OMAP2/3: PM: trigger CPU PM notifiers in idle and
 suspend path

Add calls to CPU PM notifier core in the idle and suspend paths
so any CPU PM notifiers are properly called.

[add more description about the need to trigger notifiers only after
 next power states are programmed.]

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/pm24xx.c |    5 +++++
 arch/arm/mach-omap2/pm34xx.c |    5 +++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index bf089e7..9f7e551 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -31,6 +31,7 @@
 #include <linux/time.h>
 #include <linux/gpio.h>
 #include <linux/console.h>
+#include <linux/cpu_pm.h>
 
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
@@ -142,11 +143,15 @@ static void omap2_enter_full_retention(void)
 	omap_uart_prepare_idle(1);
 	omap_uart_prepare_idle(2);
 
+	cpu_pm_enter();
+
 	/* Jump to SRAM suspend code */
 	omap2_sram_suspend(sdrc_read_reg(SDRC_DLLA_CTRL),
 			   OMAP_SDRC_REGADDR(SDRC_DLLA_CTRL),
 			   OMAP_SDRC_REGADDR(SDRC_POWER));
 
+	cpu_pm_exit();
+
 	omap_uart_resume_idle(2);
 	omap_uart_resume_idle(1);
 	omap_uart_resume_idle(0);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7255d9b..b167c7f 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -29,6 +29,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/console.h>
+#include <linux/cpu_pm.h>
 #include <trace/events/power.h>
 
 #include <asm/suspend.h>
@@ -386,6 +387,8 @@ void omap_sram_idle(void)
 			if (!console_trylock())
 				goto console_still_active;
 
+	cpu_pm_enter();
+
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
 		per_going_off = (per_next_state == PWRDM_POWER_OFF) ? 1 : 0;
@@ -465,6 +468,8 @@ void omap_sram_idle(void)
 		omap_uart_resume_idle(3);
 	}
 
+	cpu_pm_exit();
+
 	if (!is_suspending())
 		console_unlock();
 
-- 
1.7.6




>From 38800600dc72d96c74a3db5264ddd516e7e1a0c8 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Wed, 15 Jun 2011 16:23:29 -0700
Subject: [PATCH 2/2] KJH: use CPU PM for UART

---
 arch/arm/mach-omap2/pm24xx.c             |    8 -------
 arch/arm/mach-omap2/pm34xx.c             |    8 -------
 arch/arm/mach-omap2/serial.c             |   33 ++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/serial.h |    2 -
 4 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 9f7e551..e66c412 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -139,10 +139,6 @@ static void omap2_enter_full_retention(void)
 		if (!console_trylock())
 			goto no_sleep;
 
-	omap_uart_prepare_idle(0);
-	omap_uart_prepare_idle(1);
-	omap_uart_prepare_idle(2);
-
 	cpu_pm_enter();
 
 	/* Jump to SRAM suspend code */
@@ -152,10 +148,6 @@ static void omap2_enter_full_retention(void)
 
 	cpu_pm_exit();
 
-	omap_uart_resume_idle(2);
-	omap_uart_resume_idle(1);
-	omap_uart_resume_idle(0);
-
 	if (!is_suspending())
 		console_unlock();
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index b167c7f..04f7075 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -392,8 +392,6 @@ void omap_sram_idle(void)
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
 		per_going_off = (per_next_state == PWRDM_POWER_OFF) ? 1 : 0;
-		omap_uart_prepare_idle(2);
-		omap_uart_prepare_idle(3);
 		omap2_gpio_prepare_for_idle(per_going_off);
 		if (per_next_state == PWRDM_POWER_OFF)
 				omap3_per_save_context();
@@ -401,8 +399,6 @@ void omap_sram_idle(void)
 
 	/* CORE */
 	if (core_next_state < PWRDM_POWER_ON) {
-		omap_uart_prepare_idle(0);
-		omap_uart_prepare_idle(1);
 		if (core_next_state == PWRDM_POWER_OFF) {
 			omap3_core_save_context();
 			omap3_cm_save_context();
@@ -449,8 +445,6 @@ void omap_sram_idle(void)
 			omap3_sram_restore_context();
 			omap2_sms_restore_context();
 		}
-		omap_uart_resume_idle(0);
-		omap_uart_resume_idle(1);
 		if (core_next_state == PWRDM_POWER_OFF)
 			omap2_prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF_MASK,
 					       OMAP3430_GR_MOD,
@@ -464,8 +458,6 @@ void omap_sram_idle(void)
 		omap2_gpio_resume_after_idle();
 		if (per_prev_state == PWRDM_POWER_OFF)
 			omap3_per_restore_context();
-		omap_uart_resume_idle(2);
-		omap_uart_resume_idle(3);
 	}
 
 	cpu_pm_exit();
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 466fc722..1961484 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -28,6 +28,7 @@
 #include <linux/serial_8250.h>
 #include <linux/pm_runtime.h>
 #include <linux/console.h>
+#include <linux/cpu_pm.h>
 
 #ifdef CONFIG_SERIAL_OMAP
 #include <plat/omap-serial.h>
@@ -102,6 +103,8 @@ struct omap_uart_state {
 	u16 wer;
 	u16 mcr;
 #endif
+
+	struct notifier_block nb;
 };
 
 static LIST_HEAD(uart_list);
@@ -389,7 +392,7 @@ static void omap_uart_idle_timer(unsigned long data)
 	omap_uart_allow_sleep(uart);
 }
 
-void omap_uart_prepare_idle(int num)
+static void omap_uart_prepare_idle(int num)
 {
 	struct omap_uart_state *uart;
 
@@ -401,7 +404,7 @@ void omap_uart_prepare_idle(int num)
 	}
 }
 
-void omap_uart_resume_idle(int num)
+static void omap_uart_resume_idle(int num)
 {
 	struct omap_uart_state *uart;
 
@@ -855,6 +858,30 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 		uart->errata |= UART_ERRATA_i202_MDR1_ACCESS;
 }
 
+    
+static int uart_notifier_call(struct notifier_block *nb, 
+			      unsigned long val, void *p)
+{
+	struct omap_uart_state *uart = 
+		container_of(nb, struct omap_uart_state, nb);
+
+	switch (val) {
+	case CPU_PM_ENTER:
+	case CPU_CLUSTER_PM_ENTER:
+		omap_uart_prepare_idle(uart->num);
+		break;
+	case CPU_PM_EXIT:
+	case CPU_CLUSTER_PM_EXIT:
+		omap_uart_resume_idle(uart->num);
+		break;
+	default:
+		WARN(1,"%s: un-handled notifier value: 0x%lx\n", __func__, val);
+		break;
+	}
+
+	return 0;
+}
+
 /**
  * omap_serial_init() - initialize all supported serial ports
  *
@@ -874,5 +901,7 @@ void __init omap_serial_init(void)
 		bdata.pads_cnt = 0;
 		omap_serial_init_port(&bdata);
 
+		uart->nb.notifier_call = uart_notifier_call;
+		cpu_pm_register_notifier(&uart->nb);
 	}
 }
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index de3b10c..0e78f6d 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -112,8 +112,6 @@ extern void omap_serial_init_port(struct omap_board_data *bdata);
 extern int omap_uart_can_sleep(void);
 extern void omap_uart_check_wakeup(void);
 extern void omap_uart_prepare_suspend(void);
-extern void omap_uart_prepare_idle(int num);
-extern void omap_uart_resume_idle(int num);
 extern void omap_uart_enable_irqs(int enable);
 #endif
 
-- 
1.7.6
