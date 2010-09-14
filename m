From: "Basak, Partha" <p-basak2@ti.com>
Subject: RE: [PATCH 2/2] OMAP2+: GPIO: move late PM out of
 interrupts-disabled idle path
Date: Tue, 14 Sep 2010 21:39:35 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301F6DF51AF@dbde02.ent.ti.com>
References: <1284418958-5887-1-git-send-email-khilman@deeprootsystems.com>
 <1284418958-5887-3-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49790 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754389Ab0INQJr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Sep 2010 12:09:47 -0400
In-Reply-To: <1284418958-5887-3-git-send-email-khilman@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, Tero Kristo <tero.kristo@nokia.com>

 

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Tuesday, September 14, 2010 4:33 AM
> To: linux-omap@vger.kernel.org
> Cc: Varadarajan, Charulatha; Basak, Partha; Tero Kristo
> Subject: [PATCH 2/2] OMAP2+: GPIO: move late PM out of 
> interrupts-disabled idle path
> 
> From: Kevin Hilman <khilman@ti.com>
> 
> Currently, we wait until late in the idle path where interrupts are
> disabled to do runtime-PM-like management for certain special-case
> devices like GPIO.
> 
> As a prerequiste to moving GPIO to the new runtime PM framework, move
> this runtime-PM-like code out of the late idle path into new device
> idle and resume functions that can be called before interrupts are
> disabled by CPUidle and/or suspend.
> 
> In addition, move all the GPIO-specific logic into the GPIO core
> instead of keeping GPIO-specific knowledge of power-states, context
> saving etc. in the PM core.
> 
> Also, call the new device-idle and -resume methods from CPUidle and
> static suspend path.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap2/cpuidle34xx.c      |    4 ++
>  arch/arm/mach-omap2/pm.h               |    2 +
>  arch/arm/mach-omap2/pm24xx.c           |    2 +-
>  arch/arm/mach-omap2/pm34xx.c           |   38 +++++++++------------
>  arch/arm/plat-omap/gpio.c              |   57 
> ++++++++++++++++++++++++--------
>  arch/arm/plat-omap/include/plat/gpio.h |    4 +--
>  6 files changed, 67 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c 
> b/arch/arm/mach-omap2/cpuidle34xx.c
> index 0923b82..681d823 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -274,9 +274,13 @@ static int omap3_enter_idle_bm(struct 
> cpuidle_device *dev,
>  		pwrdm_set_next_pwrst(per_pd, per_next_state);
>  
>  select_state:
> +	omap3_device_idle();
> +
>  	dev->last_state = new_state;
>  	ret = omap3_enter_idle(dev, new_state);
>  
> +	omap3_device_resume();
> +
In the generic cpu_idle() in process.c, interrupts are already disabled
before control comes to cpuidle_idle_call() via pm_idle()
			local_irq_disable();
			if (hlt_counter) {
				local_irq_enable();
				cpu_relax();
			} else {
				stop_critical_timings();
				pm_idle();
				start_critical_timings();
				/*
				 * This will eventually be removed - pm_idle
				 * functions should always return with IRQs
				 * enabled.
				 */
				WARN_ON(irqs_disabled());
				local_irq_enable();
			}

omap3_enter_idle_bm() will be called from inside cpuidle_idle_call() 
via target_state->enter(dev, target_state).
So, interrupts are already disabled here.

Am I missing something?

>  	/* Restore original PER state if it was modified */
>  	if (per_next_state != per_saved_state)
>  		pwrdm_set_next_pwrst(per_pd, per_saved_state);
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 3de6ece..33cae4b 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -22,6 +22,8 @@ extern void omap_sram_idle(void);
>  extern int omap3_can_sleep(void);
>  extern int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
>  extern int omap3_idle_init(void);
> +extern void omap3_device_idle(void);
> +extern void omap3_device_resume(void);
>  
>  struct cpuidle_params {
>  	u8  valid;
> diff --git a/arch/arm/mach-omap2/pm24xx.c 
> b/arch/arm/mach-omap2/pm24xx.c
> index 6aeedea..7bbf0db 100644
> --- a/arch/arm/mach-omap2/pm24xx.c
> +++ b/arch/arm/mach-omap2/pm24xx.c
> @@ -106,7 +106,7 @@ static void omap2_enter_full_retention(void)
>  	l = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0) | 
> OMAP24XX_USBSTANDBYCTRL;
>  	omap_ctrl_writel(l, OMAP2_CONTROL_DEVCONF0);
>  
> -	omap2_gpio_prepare_for_idle(PWRDM_POWER_RET);
> +	omap2_gpio_prepare_for_idle();
>  
>  	if (omap2_pm_debug) {
>  		omap2_pm_dump(0, 0, 0);
> diff --git a/arch/arm/mach-omap2/pm34xx.c 
> b/arch/arm/mach-omap2/pm34xx.c
> index bb2ba1e..9e590d9 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -74,16 +74,6 @@ static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
>  static struct powerdomain *core_pwrdm, *per_pwrdm;
>  static struct powerdomain *cam_pwrdm;
>  
> -static inline void omap3_per_save_context(void)
> -{
> -	omap_gpio_save_context();
> -}
> -
> -static inline void omap3_per_restore_context(void)
> -{
> -	omap_gpio_restore_context();
> -}
> -
>  static void omap3_enable_io_chain(void)
>  {
>  	int timeout = 0;
> @@ -332,6 +322,16 @@ static void restore_table_entry(void)
>  	restore_control_register(control_reg_value);
>  }
>  
> +void omap3_device_idle(void)
> +{
> +	omap2_gpio_prepare_for_idle();
> +}
> +
> +void omap3_device_resume(void)
> +{
> +	omap2_gpio_resume_after_idle();
> +}
> +
>  void omap_sram_idle(void)
>  {
>  	/* Variable to tell what needs to be saved and restored
> @@ -344,7 +344,7 @@ void omap_sram_idle(void)
>  	int mpu_next_state = PWRDM_POWER_ON;
>  	int per_next_state = PWRDM_POWER_ON;
>  	int core_next_state = PWRDM_POWER_ON;
> -	int core_prev_state, per_prev_state;
> +	int core_prev_state;
>  	u32 sdrc_pwr = 0;
>  
>  	if (!_omap_sram_idle)
> @@ -387,12 +387,9 @@ void omap_sram_idle(void)
>  	}
>  
>  	/* PER */
> -	if (per_next_state < PWRDM_POWER_ON) {
> +	if (per_next_state < PWRDM_POWER_ON)
>  		omap_uart_prepare_idle(2);
> -		omap2_gpio_prepare_for_idle(per_next_state);
> -		if (per_next_state == PWRDM_POWER_OFF)
> -				omap3_per_save_context();
> -	}
> +
>  
>  	/* CORE */
>  	if (core_next_state < PWRDM_POWER_ON) {
> @@ -454,13 +451,8 @@ void omap_sram_idle(void)
>  	omap3_intc_resume_idle();
>  
>  	/* PER */
> -	if (per_next_state < PWRDM_POWER_ON) {
> -		per_prev_state = pwrdm_read_prev_pwrst(per_pwrdm);
> -		omap2_gpio_resume_after_idle();
> -		if (per_prev_state == PWRDM_POWER_OFF)
> -			omap3_per_restore_context();
> +	if (per_next_state < PWRDM_POWER_ON)
>  		omap_uart_resume_idle(2);
> -	}
>  
>  	/* Disable IO-PAD and IO-CHAIN wakeup */
>  	if (omap3_has_io_wakeup() &&
> @@ -570,6 +562,7 @@ static void omap2_pm_wakeup_on_timer(u32 
> seconds, u32 milliseconds)
>  static int omap3_pm_prepare(void)
>  {
>  	disable_hlt();
> +	omap3_device_idle();
>  	return 0;
>  }
>  
> @@ -637,6 +630,7 @@ static int omap3_pm_enter(suspend_state_t unused)
>  
>  static void omap3_pm_finish(void)
>  {
> +	omap3_device_resume();
>  	enable_hlt();
>  }
>  
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 7951eef..b0467c1 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -29,6 +29,8 @@
>  #include <asm/mach/irq.h>
>  #include <plat/powerdomain.h>
>  
> +static struct powerdomain *per_pwrdm;
> +
>  /*
>   * OMAP1510 GPIO registers
>   */
> @@ -207,6 +209,9 @@ struct gpio_bank {
>  	u32 dbck_enable_mask;
>  };
>  
> +static void omap3_gpio_restore_context(void);
> +static void omap3_gpio_save_context(void);
> +
>  #define METHOD_MPUIO		0
>  #define METHOD_GPIO_1510	1
>  #define METHOD_GPIO_1610	2
> @@ -1778,6 +1783,8 @@ static int __init _omap_gpio_init(void)
>  	}
>  #endif
>  
> +	if (cpu_class_is_omap2())
> +		per_pwrdm = pwrdm_lookup("per_pwrdm");
>  
>  #ifdef CONFIG_ARCH_OMAP15XX
>  	if (cpu_is_omap15xx()) {
> @@ -2074,14 +2081,22 @@ static struct sys_device omap_gpio_device = {
>  
>  static int workaround_enabled;
>  
> -void omap2_gpio_prepare_for_idle(int power_state)
> +void omap2_gpio_prepare_for_idle(void)
>  {
> -	int i, c = 0;
> -	int min = 0;
> +	int i, c = 0, min = 0;
> +	int per_next_state;
> +
> +	if (!per_pwrdm)
> +		return;
> +
> +	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
> +	if (per_next_state >= PWRDM_POWER_INACTIVE)
> +		return;
>  
>  	if (cpu_is_omap34xx())
>  		min = 1;
>  
> +	workaround_enabled = 0;
>  	for (i = min; i < gpio_bank_count; i++) {
>  		struct gpio_bank *bank = &gpio_bank[i];
>  		u32 l1, l2;
> @@ -2089,7 +2104,7 @@ void omap2_gpio_prepare_for_idle(int 
> power_state)
>  		if (bank->dbck_enable_mask)
>  			clk_disable(bank->dbck);
>  
> -		if (power_state > PWRDM_POWER_OFF)
> +		if (per_next_state > PWRDM_POWER_OFF)
>  			continue;
>  
>  		/* If going to OFF, remove triggering for all
> @@ -2135,20 +2150,35 @@ void omap2_gpio_prepare_for_idle(int 
> power_state)
>  
>  		c++;
>  	}
> -	if (!c) {
> -		workaround_enabled = 0;
> -		return;
> -	}
> -	workaround_enabled = 1;
> +	if (c)
> +		workaround_enabled = 1;
> +
> +	if (cpu_is_omap34xx() && (per_next_state == PWRDM_POWER_OFF))
> +		omap3_gpio_save_context();
>  }
>  
>  void omap2_gpio_resume_after_idle(void)
>  {
> -	int i;
> -	int min = 0;
> +	int i, min = 0;
> +	int per_next_state;
> +
> +	if (!per_pwrdm)
> +		return;
> +
> +	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
> +	if (per_next_state >= PWRDM_POWER_INACTIVE)
> +		return;
> +
> +	if (cpu_is_omap34xx() && (per_next_state == PWRDM_POWER_OFF)) {
> +		int per_prev_state = pwrdm_read_prev_pwrst(per_pwrdm);
> +
> +		if (per_prev_state == PWRDM_POWER_OFF)
> +			omap3_gpio_restore_context();
> +	}
>  
>  	if (cpu_is_omap34xx())
>  		min = 1;
> +
>  	for (i = min; i < gpio_bank_count; i++) {
>  		struct gpio_bank *bank = &gpio_bank[i];
>  		u32 l, gen, gen0, gen1;
> @@ -2235,14 +2265,13 @@ void omap2_gpio_resume_after_idle(void)
>  			}
>  		}
>  	}
> -
>  }
>  
>  #endif
>  
>  #ifdef CONFIG_ARCH_OMAP3
>  /* save the registers of bank 2-6 */
> -void omap_gpio_save_context(void)
> +static void omap3_gpio_save_context(void)
>  {
>  	int i;
>  
> @@ -2275,7 +2304,7 @@ void omap_gpio_save_context(void)
>  }
>  
>  /* restore the required registers of bank 2-6 */
> -void omap_gpio_restore_context(void)
> +static void omap3_gpio_restore_context(void)
>  {
>  	int i;
>  
> diff --git a/arch/arm/plat-omap/include/plat/gpio.h 
> b/arch/arm/plat-omap/include/plat/gpio.h
> index de1c604..c81ef94 100644
> --- a/arch/arm/plat-omap/include/plat/gpio.h
> +++ b/arch/arm/plat-omap/include/plat/gpio.h
> @@ -72,12 +72,10 @@
>  				 IH_GPIO_BASE + (nr))
>  
>  extern int omap_gpio_init(void);	/* Call from board init only */
> -extern void omap2_gpio_prepare_for_idle(int power_state);
> +extern void omap2_gpio_prepare_for_idle(void);
>  extern void omap2_gpio_resume_after_idle(void);
>  extern void omap_set_gpio_debounce(int gpio, int enable);
>  extern void omap_set_gpio_debounce_time(int gpio, int enable);
> -extern void omap_gpio_save_context(void);
> -extern void omap_gpio_restore_context(void);
>  
> /*------------------------------------------------------------
> -------------*/
>  
>  /* Wrappers for "new style" GPIO calls, using the new infrastructure
> -- 
> 1.7.2.1
> 
> 