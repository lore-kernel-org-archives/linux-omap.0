From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3 PM : Remove IVA state conflict between PM and DspBridge code
Date: Tue, 09 Mar 2010 11:36:23 -0800
Message-ID: <87d3zdnv7s.fsf@deeprootsystems.com>
References: <FCCFB4CDC6E5564B9182F639FC356087030435F185@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:25462 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719Ab0CITga (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Mar 2010 14:36:30 -0500
Received: by qw-out-2122.google.com with SMTP id 8so60876qwh.37
        for <linux-omap@vger.kernel.org>; Tue, 09 Mar 2010 11:36:29 -0800 (PST)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087030435F185@dbde02.ent.ti.com> (Vishwanath Sripathy's message of "Tue\, 9 Mar 2010 18\:53\:05 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Sripathy, Vishwanath" <vishwanath.bs@ti.com> writes:

> From: Shweta Gulati <shweta.gulati@ti.com>
>
> When the Dsp Bridge module is loaded, the state Of Iva Power domain 
> configured in suspend path (provided enable_off_mode is disabled) by
> DspBridge code and PM code are different so IVA does not 
> enter the target state .Per and Core domain have sleep dependency over IVA,
> so they also don't enter. 
>
> This Patch puts IVA to Off  and in suspend path the code 
> excludes IVA state transition through PM code ,thus only DspBridge 
> code handles IVA state.And all the powerdomains enter target state
> (RETENTION or OFF)in suspend path.
>
> Signed-off-by: Sripathy Vishwanath <vishwanath.bs@ti.com>
> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
> ---
>
> Index: kernel-omap3/arch/arm/mach-omap2/pm34xx.c
> ===================================================================
> --- kernel-omap3.orig/arch/arm/mach-omap2/pm34xx.c
> +++ kernel-omap3/arch/arm/mach-omap2/pm34xx.c
> @@ -764,16 +764,20 @@ static int omap3_pm_suspend(void)
>  		omap2_pm_wakeup_on_timer(wakeup_timer_seconds);
>  
>  	/* Read current next_pwrsts */
> -	list_for_each_entry(pwrst, &pwrst_list, node)
> -		pwrst->saved_state = pwrdm_read_next_pwrst(pwrst->pwrdm);
> -	/* Set ones wanted by suspend */
>  	list_for_each_entry(pwrst, &pwrst_list, node) {
> -		if (set_pwrdm_state(pwrst->pwrdm, pwrst->next_state))
> -			goto restore;
> -		if (pwrdm_clear_all_prev_pwrst(pwrst->pwrdm))
> -			goto restore;
> +		  if (strcmp("iva2_pwrdm", pwrst->pwrdm->name))
> +			pwrst->saved_state =
> +				pwrdm_read_next_pwrst(pwrst->pwrdm);
> +	}
> +		/* Set ones wanted by suspend */
> +	list_for_each_entry(pwrst, &pwrst_list, node) {
> +		if (strcmp("iva2_pwrdm", pwrst->pwrdm->name)) {
> +			if (set_pwrdm_state(pwrst->pwrdm, pwrst->next_state))
> +				goto restore;
> +			if (pwrdm_clear_all_prev_pwrst(pwrst->pwrdm))
> +				goto restore;
> +		}
>  	}

Rather than do the string matching every time, in multiple places,
simply remove iva2_pwrdm from pwrst_list.  See comment
on pwrdms_setup() changes below.

> -

stray whitespace change

>  	omap_uart_prepare_suspend();
>  	omap3_intc_suspend();
>  
> @@ -782,14 +786,16 @@ static int omap3_pm_suspend(void)
>  restore:
>  	/* Restore next_pwrsts */
>  	list_for_each_entry(pwrst, &pwrst_list, node) {
> -		state = pwrdm_read_prev_pwrst(pwrst->pwrdm);
> -		if (state > pwrst->next_state) {
> -			printk(KERN_INFO "Powerdomain (%s) didn't enter "
> -			       "target state %d\n",
> -			       pwrst->pwrdm->name, pwrst->next_state);
> -			ret = -1;
> +		if (strcmp("iva2_pwrdm", pwrst->pwrdm->name)) {
> +			state = pwrdm_read_prev_pwrst(pwrst->pwrdm);
> +			if (state > pwrst->next_state) {
> +				printk(KERN_INFO "Powerdomain (%s) didn't enter"
> +					"target state %d\n", pwrst->pwrdm->name,
> +					pwrst->next_state);
> +				ret = -1;
> +			}
> +			set_pwrdm_state(pwrst->pwrdm, pwrst->saved_state);
>  		}
> -		set_pwrdm_state(pwrst->pwrdm, pwrst->saved_state);
>  	}
>  	if (ret)
>  		printk(KERN_ERR "Could not enter target state in pm_suspend\n");
> @@ -1136,6 +1142,12 @@ static void __init prcm_setup_regs(void)
>  
>  	/* Clear any pending PRCM interrupts */
>  	prm_write_mod_reg(0, OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
> +	 /* Put the IVA2 In Idle */
> +	prm_rmw_mod_reg_bits(OMAP3430_LASTPOWERSTATEENTERED_MASK, 0,
> +			OMAP3430_IVA2_MOD, PM_PWSTCTRL);
> +	/* Make Clock transition Automatic */
> +	cm_rmw_mod_reg_bits(OMAP3430_CLKTRCTRL_IVA2_MASK, 0x3,
> +			OMAP3430_IVA2_MOD, CM_CLKSTCTRL);

What is done here that is not done by the reset in omap3_iva_idle()
called right after this?

If omap3_iva_idle() is not doing enough, then please add to that
function instead of adding it here.

>  
>  	omap3_iva_idle();
>  	omap3_d2d_idle();
> @@ -1160,8 +1172,10 @@ void omap3_pm_off_mode_enable(int disabl
>  	resource_unlock_opp(VDD2_OPP);
>  #endif
>  	list_for_each_entry(pwrst, &pwrst_list, node) {
> -		pwrst->next_state = state;
> -		set_pwrdm_state(pwrst->pwrdm, state);
> +		if (strcmp("iva2_pwrdm", pwrst->pwrdm->name)) {
> +			pwrst->next_state = state;
> +			set_pwrdm_state(pwrst->pwrdm, state);
> +		}
>  	}
>  }
>  
> @@ -1274,7 +1288,10 @@ static int __init pwrdms_setup(struct po
>  	if (!pwrst)
>  		return -ENOMEM;
>  	pwrst->pwrdm = pwrdm;
> -	pwrst->next_state = PWRDM_POWER_RET;
> +	if (strcmp("iva2_pwrdm", pwrdm->name))
> +		pwrst->next_state = PWRDM_POWER_RET;
> +	else
> +		 pwrst->next_state = PWRDM_POWER_OFF;
>  	list_add(&pwrst->node, &pwrst_list);
>  

if you also skip the list_add() here for IVA2, then you don't
have to add any of the string matching above, since all
those simply iterate over pwrst_list.

Kevin
