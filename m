From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/2] OMAP2+: GPIO: move late PM out of interrupts-disabled idle path
Date: Wed, 22 Sep 2010 07:24:53 -0700
Message-ID: <87sk11etze.fsf@deeprootsystems.com>
References: <1284418958-5887-1-git-send-email-khilman@deeprootsystems.com>
	<1284418958-5887-3-git-send-email-khilman@deeprootsystems.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402785A38C5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42300 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754719Ab0IVOY5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Sep 2010 10:24:57 -0400
Received: by pvg2 with SMTP id 2so133967pvg.19
        for <linux-omap@vger.kernel.org>; Wed, 22 Sep 2010 07:24:56 -0700 (PDT)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402785A38C5@dbde02.ent.ti.com>
	(Hema Kalliguddi's message of "Wed, 22 Sep 2010 13:52:53 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kalliguddi, Hema" <hemahk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>, "Basak, Partha" <p-basak2@ti.com>, Tero Kristo <tero.kristo@nokia.com>

"Kalliguddi, Hema" <hemahk@ti.com> writes:

>>-----Original Message-----
>>From: linux-omap-owner@vger.kernel.org 
>>[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
>>Sent: Tuesday, September 14, 2010 4:33 AM
>>To: linux-omap@vger.kernel.org
>>Cc: Varadarajan, Charulatha; Basak, Partha; Tero Kristo
>>Subject: [PATCH 2/2] OMAP2+: GPIO: move late PM out of 
>>interrupts-disabled idle path
>>
>>From: Kevin Hilman <khilman@ti.com>
>>
>>Currently, we wait until late in the idle path where interrupts are
>>disabled to do runtime-PM-like management for certain special-case
>>devices like GPIO.
>>
>>As a prerequiste to moving GPIO to the new runtime PM framework, move
>>this runtime-PM-like code out of the late idle path into new device
>>idle and resume functions that can be called before interrupts are
>>disabled by CPUidle and/or suspend.
>>
>>In addition, move all the GPIO-specific logic into the GPIO core
>>instead of keeping GPIO-specific knowledge of power-states, context
>>saving etc. in the PM core.
>>
>>Also, call the new device-idle and -resume methods from CPUidle and
>>static suspend path.
>>
>>Signed-off-by: Kevin Hilman <khilman@ti.com>
>>---
>> arch/arm/mach-omap2/cpuidle34xx.c      |    4 ++
>> arch/arm/mach-omap2/pm.h               |    2 +
>> arch/arm/mach-omap2/pm24xx.c           |    2 +-
>> arch/arm/mach-omap2/pm34xx.c           |   38 +++++++++------------
>> arch/arm/plat-omap/gpio.c              |   57 
>>++++++++++++++++++++++++--------
>> arch/arm/plat-omap/include/plat/gpio.h |    4 +--
>> 6 files changed, 67 insertions(+), 40 deletions(-)
>>
>>diff --git a/arch/arm/mach-omap2/cpuidle34xx.c 
>>b/arch/arm/mach-omap2/cpuidle34xx.c
>>index 0923b82..681d823 100644
>>--- a/arch/arm/mach-omap2/cpuidle34xx.c
>>+++ b/arch/arm/mach-omap2/cpuidle34xx.c
>>@@ -274,9 +274,13 @@ static int omap3_enter_idle_bm(struct 
>>cpuidle_device *dev,
>> 		pwrdm_set_next_pwrst(per_pd, per_next_state);
>> 
>> select_state:
>>+	omap3_device_idle();
>>+
>> 	dev->last_state = new_state;
>> 	ret = omap3_enter_idle(dev, new_state);
>> 
>>+	omap3_device_resume();
>>+
>> 	/* Restore original PER state if it was modified */
>> 	if (per_next_state != per_saved_state)
>> 		pwrdm_set_next_pwrst(per_pd, per_saved_state);
>>diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
>>index 3de6ece..33cae4b 100644
>>--- a/arch/arm/mach-omap2/pm.h
>>+++ b/arch/arm/mach-omap2/pm.h
>>@@ -22,6 +22,8 @@ extern void omap_sram_idle(void);
>> extern int omap3_can_sleep(void);
>> extern int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
>> extern int omap3_idle_init(void);
>>+extern void omap3_device_idle(void);
>>+extern void omap3_device_resume(void);
>> 
>> struct cpuidle_params {
>> 	u8  valid;
>>diff --git a/arch/arm/mach-omap2/pm24xx.c 
>>b/arch/arm/mach-omap2/pm24xx.c
>>index 6aeedea..7bbf0db 100644
>>--- a/arch/arm/mach-omap2/pm24xx.c
>>+++ b/arch/arm/mach-omap2/pm24xx.c
>>@@ -106,7 +106,7 @@ static void omap2_enter_full_retention(void)
>> 	l = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0) | 
>>OMAP24XX_USBSTANDBYCTRL;
>> 	omap_ctrl_writel(l, OMAP2_CONTROL_DEVCONF0);
>> 
>>-	omap2_gpio_prepare_for_idle(PWRDM_POWER_RET);
>>+	omap2_gpio_prepare_for_idle();
>> 
>> 	if (omap2_pm_debug) {
>> 		omap2_pm_dump(0, 0, 0);
>>diff --git a/arch/arm/mach-omap2/pm34xx.c 
>>b/arch/arm/mach-omap2/pm34xx.c
>>index bb2ba1e..9e590d9 100644
>>--- a/arch/arm/mach-omap2/pm34xx.c
>>+++ b/arch/arm/mach-omap2/pm34xx.c
>>@@ -74,16 +74,6 @@ static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
>> static struct powerdomain *core_pwrdm, *per_pwrdm;
>> static struct powerdomain *cam_pwrdm;
>> 
>>-static inline void omap3_per_save_context(void)
>>-{
>>-	omap_gpio_save_context();
>>-}
>>-
>>-static inline void omap3_per_restore_context(void)
>>-{
>>-	omap_gpio_restore_context();
>>-}
>>-
>> static void omap3_enable_io_chain(void)
>> {
>> 	int timeout = 0;
>>@@ -332,6 +322,16 @@ static void restore_table_entry(void)
>> 	restore_control_register(control_reg_value);
>> }
>> 
>>+void omap3_device_idle(void)
>>+{
>>+	omap2_gpio_prepare_for_idle();
>>+}
>>+
>
> Is not it is a good idea to pass the new_state as the parameter for the driver calls?
> It will reduce each individual drivers reading the PRCM register to findout the next state.
> This might save some time in the idle loop. 

I chose not to pass the parameters on purpose.  All of the intelligence
for device idle (including which powerdomain state to check) should live
in the driver code.

If reading the PRCM registers is becoming a problem, it will be a simple
patch to patch the powerdomain core to cache the current value of it's
next state so at least reads of next_state will be fast.

Kevin

>>+void omap3_device_resume(void)
>>+{
>>+	omap2_gpio_resume_after_idle();
>>+}
>>+
>
> Here we will need to pass the next_state as well as previous_state as parameters. If we agree to
> pass the parameters.
>
> ~Hema
>
>> void omap_sram_idle(void)
>> {
>> 	/* Variable to tell what needs to be saved and restored
>>@@ -344,7 +344,7 @@ void omap_sram_idle(void)
>> 	int mpu_next_state = PWRDM_POWER_ON;
>> 	int per_next_state = PWRDM_POWER_ON;
>> 	int core_next_state = PWRDM_POWER_ON;
>>-	int core_prev_state, per_prev_state;
>>+	int core_prev_state;
>> 	u32 sdrc_pwr = 0;
>> 
>> 	if (!_omap_sram_idle)
>>@@ -387,12 +387,9 @@ void omap_sram_idle(void)
>> 	}
>> 
>> 	/* PER */
>>-	if (per_next_state < PWRDM_POWER_ON) {
>>+	if (per_next_state < PWRDM_POWER_ON)
>> 		omap_uart_prepare_idle(2);
>>-		omap2_gpio_prepare_for_idle(per_next_state);
>>-		if (per_next_state == PWRDM_POWER_OFF)
>>-				omap3_per_save_context();
>>-	}
>>+
>> 
>> 	/* CORE */
>> 	if (core_next_state < PWRDM_POWER_ON) {
>>@@ -454,13 +451,8 @@ void omap_sram_idle(void)
>> 	omap3_intc_resume_idle();
>> 
>> 	/* PER */
>>-	if (per_next_state < PWRDM_POWER_ON) {
>>-		per_prev_state = pwrdm_read_prev_pwrst(per_pwrdm);
>>-		omap2_gpio_resume_after_idle();
>>-		if (per_prev_state == PWRDM_POWER_OFF)
>>-			omap3_per_restore_context();
>>+	if (per_next_state < PWRDM_POWER_ON)
>> 		omap_uart_resume_idle(2);
>>-	}
>> 
>> 	/* Disable IO-PAD and IO-CHAIN wakeup */
>> 	if (omap3_has_io_wakeup() &&
>>@@ -570,6 +562,7 @@ static void omap2_pm_wakeup_on_timer(u32 
>>seconds, u32 milliseconds)
>> static int omap3_pm_prepare(void)
>> {
>> 	disable_hlt();
>>+	omap3_device_idle();
>> 	return 0;
>> }
>> 
>>@@ -637,6 +630,7 @@ static int omap3_pm_enter(suspend_state_t unused)
>> 
>> static void omap3_pm_finish(void)
>> {
>>+	omap3_device_resume();
>> 	enable_hlt();
>> }
>> 
>>diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
>>index 7951eef..b0467c1 100644
>>--- a/arch/arm/plat-omap/gpio.c
>>+++ b/arch/arm/plat-omap/gpio.c
>>@@ -29,6 +29,8 @@
>> #include <asm/mach/irq.h>
>> #include <plat/powerdomain.h>
>> 
>>+static struct powerdomain *per_pwrdm;
>>+
>> /*
>>  * OMAP1510 GPIO registers
>>  */
>>@@ -207,6 +209,9 @@ struct gpio_bank {
>> 	u32 dbck_enable_mask;
>> };
>> 
>>+static void omap3_gpio_restore_context(void);
>>+static void omap3_gpio_save_context(void);
>>+
>> #define METHOD_MPUIO		0
>> #define METHOD_GPIO_1510	1
>> #define METHOD_GPIO_1610	2
>>@@ -1778,6 +1783,8 @@ static int __init _omap_gpio_init(void)
>> 	}
>> #endif
>> 
>>+	if (cpu_class_is_omap2())
>>+		per_pwrdm = pwrdm_lookup("per_pwrdm");
>> 
>> #ifdef CONFIG_ARCH_OMAP15XX
>> 	if (cpu_is_omap15xx()) {
>>@@ -2074,14 +2081,22 @@ static struct sys_device omap_gpio_device = {
>> 
>> static int workaround_enabled;
>> 
>>-void omap2_gpio_prepare_for_idle(int power_state)
>>+void omap2_gpio_prepare_for_idle(void)
>> {
>>-	int i, c = 0;
>>-	int min = 0;
>>+	int i, c = 0, min = 0;
>>+	int per_next_state;
>>+
>>+	if (!per_pwrdm)
>>+		return;
>>+
>>+	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
>>+	if (per_next_state >= PWRDM_POWER_INACTIVE)
>>+		return;
>> 
>> 	if (cpu_is_omap34xx())
>> 		min = 1;
>> 
>>+	workaround_enabled = 0;
>> 	for (i = min; i < gpio_bank_count; i++) {
>> 		struct gpio_bank *bank = &gpio_bank[i];
>> 		u32 l1, l2;
>>@@ -2089,7 +2104,7 @@ void omap2_gpio_prepare_for_idle(int power_state)
>> 		if (bank->dbck_enable_mask)
>> 			clk_disable(bank->dbck);
>> 
>>-		if (power_state > PWRDM_POWER_OFF)
>>+		if (per_next_state > PWRDM_POWER_OFF)
>> 			continue;
>> 
>> 		/* If going to OFF, remove triggering for all
>>@@ -2135,20 +2150,35 @@ void omap2_gpio_prepare_for_idle(int 
>>power_state)
>> 
>> 		c++;
>> 	}
>>-	if (!c) {
>>-		workaround_enabled = 0;
>>-		return;
>>-	}
>>-	workaround_enabled = 1;
>>+	if (c)
>>+		workaround_enabled = 1;
>>+
>>+	if (cpu_is_omap34xx() && (per_next_state == PWRDM_POWER_OFF))
>>+		omap3_gpio_save_context();
>> }
>> 
>> void omap2_gpio_resume_after_idle(void)
>> {
>>-	int i;
>>-	int min = 0;
>>+	int i, min = 0;
>>+	int per_next_state;
>>+
>>+	if (!per_pwrdm)
>>+		return;
>>+
>>+	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
>>+	if (per_next_state >= PWRDM_POWER_INACTIVE)
>>+		return;
>>+
>>+	if (cpu_is_omap34xx() && (per_next_state == PWRDM_POWER_OFF)) {
>>+		int per_prev_state = pwrdm_read_prev_pwrst(per_pwrdm);
>>+
>>+		if (per_prev_state == PWRDM_POWER_OFF)
>>+			omap3_gpio_restore_context();
>>+	}
>> 
>> 	if (cpu_is_omap34xx())
>> 		min = 1;
>>+
>> 	for (i = min; i < gpio_bank_count; i++) {
>> 		struct gpio_bank *bank = &gpio_bank[i];
>> 		u32 l, gen, gen0, gen1;
>>@@ -2235,14 +2265,13 @@ void omap2_gpio_resume_after_idle(void)
>> 			}
>> 		}
>> 	}
>>-
>> }
>> 
>> #endif
>> 
>> #ifdef CONFIG_ARCH_OMAP3
>> /* save the registers of bank 2-6 */
>>-void omap_gpio_save_context(void)
>>+static void omap3_gpio_save_context(void)
>> {
>> 	int i;
>> 
>>@@ -2275,7 +2304,7 @@ void omap_gpio_save_context(void)
>> }
>> 
>> /* restore the required registers of bank 2-6 */
>>-void omap_gpio_restore_context(void)
>>+static void omap3_gpio_restore_context(void)
>> {
>> 	int i;
>> 
>>diff --git a/arch/arm/plat-omap/include/plat/gpio.h 
>>b/arch/arm/plat-omap/include/plat/gpio.h
>>index de1c604..c81ef94 100644
>>--- a/arch/arm/plat-omap/include/plat/gpio.h
>>+++ b/arch/arm/plat-omap/include/plat/gpio.h
>>@@ -72,12 +72,10 @@
>> 				 IH_GPIO_BASE + (nr))
>> 
>> extern int omap_gpio_init(void);	/* Call from board init only */
>>-extern void omap2_gpio_prepare_for_idle(int power_state);
>>+extern void omap2_gpio_prepare_for_idle(void);
>> extern void omap2_gpio_resume_after_idle(void);
>> extern void omap_set_gpio_debounce(int gpio, int enable);
>> extern void omap_set_gpio_debounce_time(int gpio, int enable);
>>-extern void omap_gpio_save_context(void);
>>-extern void omap_gpio_restore_context(void);
>> 
>>/*-------------------------------------------------------------
>>------------*/
>> 
>> /* Wrappers for "new style" GPIO calls, using the new infrastructure
>>-- 
>>1.7.2.1
>>
>>--
>>To unsubscribe from this list: send the line "unsubscribe 
>>linux-omap" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
