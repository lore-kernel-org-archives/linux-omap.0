From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [PATCH 09/12] CORE OFF support in omap_sram_idle
Date: Wed, 10 Sep 2008 09:39:39 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0809100938510.20446@utopia.booyaka.com>
References: <62493.192.168.10.89.1220276508.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34305 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654AbYIJPjl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 11:39:41 -0400
In-Reply-To: <62493.192.168.10.89.1220276508.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

On Mon, 1 Sep 2008, Rajendra Nayak wrote:

> This patch updates omap_sram_idle with CORE OFF support
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |   37 ++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/pm.h          |    2 +
>  arch/arm/mach-omap2/pm34xx.c      |   43 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 82 insertions(+)
> 
> Index: linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/cpuidle34xx.c	2008-09-01
> 18:12:35.000000000 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c	2008-09-01
> 18:25:25.000000000 +0530
> @@ -26,11 +26,48 @@
>  #include <mach/pm.h>
>  #include <mach/prcm.h>
>  #include <mach/powerdomain.h>
> +#include <mach/gpmc.h>
>  #include <mach/control.h>
> +#include <mach/irqs.h>
>  #include <linux/sched.h>
> 
>  #include "cpuidle34xx.h"
> 
> +static int padconf_saved;
> +void omap3_save_core_ctx(void)
> +{
> +	u32 control_padconf_off;
> +	if (!padconf_saved) {
> +	       /* Save the padconf registers */
> +	       control_padconf_off =
> +			omap_ctrl_readl(OMAP343X_CONTROL_PADCONF_OFF);
> +	       control_padconf_off |= START_PADCONF_SAVE;
> +	       omap_ctrl_writel(control_padconf_off,
> +			OMAP343X_CONTROL_PADCONF_OFF);
> +	       /* wait for the save to complete */
> +	       while (!omap_ctrl_readl(OMAP343X_CONTROL_GENERAL_PURPOSE_STATUS)
> +			& PADCONF_SAVE_DONE);

This while() should call cpu_relax().


> +	       padconf_saved = 1;
> +	}
> +	/* Save the Interrupt controller context */
> +	omap3_save_intc_ctx();
> +	/* Save the GPMC context */
> +	omap3_save_gpmc_ctx();
> +	/* Save the system control module context, padconf already save above*/
> +	omap3_save_control_ctx();
> +}
> +
> +void omap3_restore_core_ctx(void)
> +{
> +	/* Restore the control module context, padconf restored by h/w */
> +	omap3_restore_control_ctx();
> +	/* Restore the GPMC context */
> +	omap3_restore_gpmc_ctx();
> +	/* Restore the interrupt controller context */
> +	omap3_restore_intc_ctx();
> +	padconf_saved = 0;
> +}
> +
>  #ifdef CONFIG_CPU_IDLE
> 
>  struct omap3_processor_cx omap3_power_states[OMAP3_MAX_STATES];
> Index: linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/pm34xx.c	2008-09-01
> 18:23:19.000000000 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c	2008-09-01 18:24:02.000000000
> +0530
> @@ -27,10 +27,13 @@
>  #include <mach/gpio.h>
>  #include <mach/sram.h>
>  #include <mach/pm.h>
> +#include <mach/prcm.h>
>  #include <mach/clockdomain.h>
>  #include <mach/powerdomain.h>
>  #include <mach/common.h>
>  #include <mach/control.h>
> +#include <mach/serial.h>
> +#include <mach/gpio.h>
>  #include <asm/tlbflush.h>
> 
>  #include "cm.h"
> @@ -58,6 +61,7 @@ static struct powerdomain *mpu_pwrdm, *n
>  static struct powerdomain *core_pwrdm, *per_pwrdm;
> 
>  int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
> +void omap3_restore_sram_ctx(void);
> 
>  u32 context_mem[128];
> 
> @@ -91,6 +95,16 @@ static void gpio_fclk_mask(u32 *fclk)
>  	*fclk &= ~(0x1f << 13);
>  }
> 
> +void omap3_save_per_ctx(void)
> +{
> +	omap3_gpio_save();
> +}
> +
> +void omap3_restore_per_ctx(void)
> +{
> +	omap3_gpio_restore();
> +}
> +
>  /* PRCM Interrupt Handler for wakeups */
>  static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
>  {
> @@ -225,6 +239,7 @@ void omap_sram_idle(void)
>  	int mpu_next_state = PWRDM_POWER_ON;
>  	int per_next_state = PWRDM_POWER_ON;
>  	int core_next_state = PWRDM_POWER_ON;
> +	int core_prev_state, per_prev_state;
> 
>  	if (!_omap_sram_idle)
>  		return;
> @@ -261,15 +276,27 @@ void omap_sram_idle(void)
>  		/* PER changes only with core */
>  		per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
>  		if (per_next_state < PWRDM_POWER_ON) {
> +			if (per_next_state == PWRDM_POWER_OFF) {
> +				omap3_save_per_ctx();
> +				omap3_save_uart_ctx(2);
> +			}
>  			if (clocks_off_while_idle) {
>  				per_gpio_clk_disable();
>  				omap_serial_enable_clocks(0, 2);
>  			}
>  		}
> +		if (core_next_state == PWRDM_POWER_OFF) {
> +			omap3_save_core_ctx();
> +			omap3_save_prcm_ctx();
> +			omap3_save_uart_ctx(0);
> +			omap3_save_uart_ctx(1);
> +		}
>  		if (clocks_off_while_idle) {
>  			omap_serial_enable_clocks(0, 0);
>  			omap_serial_enable_clocks(0, 1);
>  		}
> +		if (core_next_state == PWRDM_POWER_OFF)
> +			omap3_save_prcm_ctx();
>  		/* Enable IO-PAD wakeup */
>  		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
>  	}
> @@ -284,16 +311,31 @@ void omap_sram_idle(void)
>  	if (core_next_state < PWRDM_POWER_ON) {
>  		/* Disable IO-PAD wakeup */
>  		prm_clear_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
> +		core_prev_state = pwrdm_read_prev_pwrst(core_pwrdm);
> +		if (core_prev_state == PWRDM_POWER_OFF)
> +			omap3_restore_prcm_ctx();
>  		if (clocks_off_while_idle) {
>  			omap_serial_enable_clocks(1, 0);
>  			omap_serial_enable_clocks(1, 1);
>  		}
> +		if (core_prev_state == PWRDM_POWER_OFF) {
> +			omap3_restore_core_ctx();
> +			omap3_restore_sram_ctx();
> +			omap3_restore_uart_ctx(0);
> +			omap3_restore_uart_ctx(1);
> +		}
>  		if (per_next_state < PWRDM_POWER_ON) {
>  			if (clocks_off_while_idle) {
>  				per_gpio_clk_enable();
>  				/* This would be actually more effective */
>  				omap_serial_enable_clocks(1, 2);
>  			}
> +			per_prev_state = pwrdm_read_prev_pwrst(per_pwrdm);
> +			if (per_prev_state == PWRDM_POWER_OFF) {
> +				omap3_restore_per_ctx();
> +				/* This would be actually more effective */
> +				omap3_restore_uart_ctx(2);
> +			}
>  		}
>  		omap2_gpio_resume_after_retention();
>  	}
> @@ -815,6 +857,7 @@ int __init omap3_pm_init(void)
>  	/* XXX prcm_setup_regs needs to be before enabling hw
>  	 * supervised mode for powerdomains */
>  	prcm_setup_regs();
> +	omap3_save_scratchpad_contents();
> 
>  	ret = request_irq(INT_34XX_PRCM_MPU_IRQ,
>  			  (irq_handler_t)prcm_interrupt_handler,
> Index: linux-omap-2.6/arch/arm/mach-omap2/pm.h
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/pm.h	2008-09-01 18:12:35.000000000
> +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/pm.h	2008-09-01 18:24:02.000000000 +0530
> @@ -22,6 +22,8 @@ extern atomic_t sleep_block;
> 
>  extern void omap2_block_sleep(void);
>  extern void omap2_allow_sleep(void);
> +extern void omap3_save_core_ctx(void);
> +extern void omap3_restore_core_ctx(void);
> 
>  #define OMAP343X_TABLE_ADDRESS_OFFSET	0x31
>  #define OMAP343X_TABLE_VALUE_OFFSET	0x30
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
