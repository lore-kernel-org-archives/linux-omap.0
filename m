From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/2] OMAP3: Implemented VFP restore/save context
Date: Mon, 23 Nov 2009 14:22:20 -0800
Message-ID: <87hbskzxsz.fsf@deeprootsystems.com>
References: <1258650375-9793-1-git-send-email-tero.kristo@nokia.com>
	<1258650375-9793-2-git-send-email-tero.kristo@nokia.com>
	<1258650375-9793-3-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:38054 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757110AbZKWWWV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Nov 2009 17:22:21 -0500
Received: by yxe17 with SMTP id 17so5148165yxe.33
        for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2009 14:22:27 -0800 (PST)
In-Reply-To: <1258650375-9793-3-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Thu\, 19 Nov 2009 19\:06\:15 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> VFP save context is called before MPU/NEON off. Restore is not needed as
> the next VFP trap will restore context automatically. Uses the support
> routine implemented in arch/arm/vfp/vfpmodule.c.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Richard Woodruff <r-woodruff2@ti.com>
> Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

Looks good.  I'll queue in PM branch when patch 1/2 is reviewed/accepted on LAKML.

Kevin

> ---
>  arch/arm/mach-omap2/pm.h     |    1 +
>  arch/arm/mach-omap2/pm34xx.c |   21 ++++++++++++++++++++-
>  2 files changed, 21 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 4f22107..dd5bbaf 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -18,6 +18,7 @@ extern u32 sleep_while_idle;
>  extern u32 voltage_off_while_idle;
>  
>  extern void *omap3_secure_ram_storage;
> +extern void vfp_pm_save_context(void);
>  extern void omap3_pm_off_mode_enable(int);
>  extern void omap_sram_idle(void);
>  extern int omap3_can_sleep(void);
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index b26ae5b..4b01303 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -321,6 +321,18 @@ static void restore_control_register(u32 val)
>  	__asm__ __volatile__ ("mcr p15, 0, %0, c1, c0, 0" : : "r" (val));
>  }
>  
> +static inline void omap3_save_neon_context(void)
> +{
> +#ifdef CONFIG_VFP
> +	vfp_pm_save_context();
> +#endif
> +}
> +
> +static inline void omap3_restore_neon_context(void)
> +{
> +	return;
> +}
> +
>  /* Function to restore the table entry that was modified for enabling MMU */
>  static void restore_table_entry(void)
>  {
> @@ -365,6 +377,7 @@ void omap_sram_idle(void)
>  	/* save_state = 3 => L1, L2 and logic lost */
>  	int save_state = 0;
>  	int mpu_next_state = PWRDM_POWER_ON;
> +	int neon_next_state = PWRDM_POWER_ON;
>  	int per_next_state = PWRDM_POWER_ON;
>  	int core_next_state = PWRDM_POWER_ON;
>  	int core_prev_state, per_prev_state;
> @@ -398,8 +411,12 @@ void omap_sram_idle(void)
>  	pwrdm_pre_transition();
>  
>  	/* NEON control */
> -	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
> +	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON) {
>  		pwrdm_set_next_pwrst(neon_pwrdm, mpu_next_state);
> +		neon_next_state = mpu_next_state;
> +		if (neon_next_state == PWRDM_POWER_OFF)
> +			omap3_save_neon_context();
> +	}
>  
>  	/* PER */
>  	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
> @@ -537,6 +554,8 @@ void omap_sram_idle(void)
>  		omap3_disable_io_chain();
>  	}
>  
> +	if (neon_next_state == PWRDM_POWER_OFF)
> +		omap3_restore_neon_context();
>  
>  	pwrdm_post_transition();
>  }
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
