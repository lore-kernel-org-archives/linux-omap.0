From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3 CPUidle patches - fixes
Date: Mon, 4 Aug 2008 17:33:17 +0300
Message-ID: <20080804143316.GM8885@atomide.com>
References: <004901c8dce8$0b1a1040$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52999 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758515AbYHDOd1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Aug 2008 10:33:27 -0400
Content-Disposition: inline
In-Reply-To: <004901c8dce8$0b1a1040$68bf18ac@ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

* Rajendra Nayak <rnayak@ti.com> [080703 14:55]:
> This patch fixes few of the comments posted on the patch set till now. 
> 
> One major fix is the moving of uart clock enable/disable out of the context save path as pointed out by Jouni. 
> This would leave the UART clcoks disabled in case a CORE OFF was attempted and not achieved.

What kernel or patch series this is against? If it's for some patch
series that's not applied yet to linux-omap tree, let's merge the fix
to the original patch.

Tony

> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |   56 ++++++++++++++------------------------
>  1 files changed, 22 insertions(+), 34 deletions(-)
> 
> Index: linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/cpuidle34xx.c	2008-07-03 10:50:04.000000000 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c	2008-07-03 13:11:13.435048828 +0530
> @@ -405,9 +405,7 @@ void omap3_save_core_ctx(void)
>  	/* Save the system control module context, padconf already save above*/
>  	omap_save_control_ctx();
>  	omap_save_uart_ctx(0);
> -	omap_serial_enable_clocks(0, 0);
>  	omap_save_uart_ctx(1);
> -	omap_serial_enable_clocks(0, 1);
>  }
>  
>  void omap3_restore_core_ctx(void)
> @@ -418,9 +416,7 @@ void omap3_restore_core_ctx(void)
>  	omap_restore_gpmc_ctx();
>  	/* Restore the interrupt controller context */
>  	omap_restore_intc_ctx();
> -	omap_serial_enable_clocks(1, 0);
>  	omap_restore_uart_ctx(0);
> -	omap_serial_enable_clocks(1, 1);
>  	omap_restore_uart_ctx(1);
>  	padconf_saved = 0;
>  }
> @@ -472,28 +468,27 @@ static int omap3_enter_idle(struct cpuid
>  
>  	/* Program MPU to target state */
>  	if (cx->mpu_state < PWRDM_POWER_ON) {
> -		if (neon_pwrst == PWRDM_POWER_ON) {
> -			if (cx->mpu_state == PWRDM_POWER_RET)
> -				pwrdm_set_next_pwrst(neon_pd, PWRDM_POWER_RET);
> -			else if (cx->mpu_state == PWRDM_POWER_OFF)
> -				pwrdm_set_next_pwrst(neon_pd, PWRDM_POWER_OFF);
> -		}
> +		pwrdm_set_next_pwrst(neon_pd, cx->mpu_state);
>  		pwrdm_set_next_pwrst(mpu_pd, cx->mpu_state);
>  	}
>  
>  	/* Program CORE and PER to target state */
>  	if (cx->core_state < PWRDM_POWER_ON) {
> -		if (per_pwrst == PWRDM_POWER_ON) {
> -			omap2_gpio_prepare_for_retention();
> -			if (clocks_off_while_idle) {
> -				omap3_save_per_ctx();
> -				per_gpio_clk_disable();
> -				omap_save_uart_ctx(2);
> -				omap_serial_enable_clocks(0, 2);
> -			}
> +		omap2_gpio_prepare_for_retention();
> +		if (clocks_off_while_idle) {
> +			omap3_save_per_ctx();
> +			per_gpio_clk_disable();
> +			omap_save_uart_ctx(2);
> +			omap_serial_enable_clocks(0, 2);
>  		}
>  		if (cx->core_state == PWRDM_POWER_OFF)
>  			omap3_save_core_ctx();
> +		/* Disable UART1/UART2 clocks here. Done using direct register
> +		* writes as using clock f/w calls results in a hang in prcm_
> +		* interrupt_handler trying to clear WKST for CORE
> +		*/
> +		cm_clear_mod_reg_bits(0x6000, CORE_MOD, CM_ICLKEN1);
> +		cm_clear_mod_reg_bits(0x6000, CORE_MOD, CM_FCLKEN1);
>  		pwrdm_set_next_pwrst(core_pd, cx->core_state);
>  	}
>  
> @@ -507,14 +502,9 @@ static int omap3_enter_idle(struct cpuid
>  
>  	*(scratchpad_restore_addr) = 0x0;
>  
> -	/* Program MPU/NEON to ON */
> -	if (cx->mpu_state < PWRDM_POWER_ON) {
> -		if (neon_pwrst == PWRDM_POWER_ON)
> -			pwrdm_set_next_pwrst(neon_pd, PWRDM_POWER_ON);
> -		pwrdm_set_next_pwrst(mpu_pd, PWRDM_POWER_ON);
> -	}
> -
>  	if (cx->core_state < PWRDM_POWER_ON) {
> +		cm_set_mod_reg_bits(0x6000, CORE_MOD, CM_ICLKEN1);
> +		cm_set_mod_reg_bits(0x6000, CORE_MOD, CM_FCLKEN1);
>  		if ((cx->core_state == PWRDM_POWER_OFF)
>  		&& (pwrdm_read_prev_pwrst(core_pd) == PWRDM_POWER_OFF)) {
>  			omap3_restore_core_ctx();
> @@ -522,15 +512,13 @@ static int omap3_enter_idle(struct cpuid
>  			omap3_restore_sram_ctx();
>  		}
>  		pwrdm_set_next_pwrst(core_pd, PWRDM_POWER_ON);
> -		if (per_pwrst == PWRDM_POWER_ON) {
> -			if (clocks_off_while_idle) {
> -				omap_serial_enable_clocks(1, 2);
> -				omap_restore_uart_ctx(2);
> -				per_gpio_clk_enable();
> -				omap3_restore_per_ctx();
> -			}
> -			omap2_gpio_resume_after_retention();
> +		if (clocks_off_while_idle) {
> +			omap_serial_enable_clocks(1, 2);
> +			omap_restore_uart_ctx(2);
> +			per_gpio_clk_enable();
> +			omap3_restore_per_ctx();
>  		}
> +		omap2_gpio_resume_after_retention();
>  	}
>  
>  	pr_debug("MPU prev st:%x,NEON prev st:%x\n",
> @@ -548,7 +536,7 @@ return_sleep_time:
>  		sched_clock_idle_wakeup_event(timespec_to_ns(&ts_idle));
>  
>  	local_irq_enable();
> -	local_fiq_disable();
> +	local_fiq_enable();
>  
>  	return (u32)timespec_to_ns(&ts_idle)/1000;
>  }
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
