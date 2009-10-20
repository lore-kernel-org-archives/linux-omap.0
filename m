From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 17/17] OMAP3: PM: Force disable OTG autoidle
Date: Tue, 20 Oct 2009 11:44:27 -0700
Message-ID: <87eioxsy5w.fsf@deeprootsystems.com>
References: <1255690150-16853-1-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-2-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-3-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-4-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-5-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-6-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-7-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-8-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-9-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-10-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-11-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-12-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-13-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-14-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-15-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-16-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-17-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-18-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.185]:16269 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbZJTSob (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Oct 2009 14:44:31 -0400
Received: by gv-out-0910.google.com with SMTP id r4so655708gve.37
        for <linux-omap@vger.kernel.org>; Tue, 20 Oct 2009 11:44:34 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> OMAP3 sleep can be prevented in some cases where OTG autoidle is enabled.
> This patch force disables autoidle during boot and after wakeup from off-mode.
> See omap erratas 1.164 and 1.165.

The init-at-boot step isn't needed as this is already done in 
PM branch (see usb-muxb.c:usb_musb_pm_init()).

> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index ae83121..5f351f2 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -94,6 +94,8 @@ u32 voltage_off_while_idle;
>  		OMAP3430_ST_GPT5_MASK|OMAP3430_ST_GPT4_MASK|\
>  		OMAP3430_ST_GPT3_MASK|OMAP3430_ST_GPT2_MASK)
>  
> +#define OTG_SYSCONFIG	(OMAP34XX_HSUSB_OTG_BASE + 0x404)
> +
>  struct power_state {
>  	struct powerdomain *pwrdm;
>  	u32 next_state;
> @@ -423,6 +425,16 @@ static void restore_table_entry(void)
>  	restore_control_register(control_reg_value);
>  }
>  
> +static inline void disable_otg_autoidle(void)
> +{
> +	/*
> +	 * OTG autoidle can prevent core domain sleep in some cases, thus
> +	 * disable it. See omap erratas 1.164 and 1.165.
> +	 */
> +	cm_set_mod_reg_bits(OMAP3430_EN_HSOTGUSB, CORE_MOD, CM_ICLKEN1);

Is the ICLK enable required as part of the fix too?  I don't see
mention of enabling the iclk as part of the workaround for either of
these errata.

If the iclk needs to be enabled, it should be done at init using
the clk API.

> +	omap_writel(0x0, OTG_SYSCONFIG);

omap_writel() deprecated.  

> +}
> +

For readability, this should be a function in the USB core code
(either usb-musb.c or a static inline in <mach/usb.h>)

Kevin

>  void omap_sram_idle(void)
>  {
>  	/* Variable to tell what needs to be saved and restored
> @@ -628,6 +640,7 @@ void omap_sram_idle(void)
>  			omap3_prcm_restore_context();
>  			omap3_sram_restore_context();
>  			omap2_sms_restore_context();
> +			disable_otg_autoidle();
>  		}
>  		omap_uart_resume_idle(0);
>  		omap_uart_resume_idle(1);
> @@ -1417,6 +1430,7 @@ static int __init omap3_pm_early_init(void)
>  				OMAP3_PRM_POLCTRL_OFFSET);
>  
>  	configure_vc();
> +	disable_otg_autoidle();
>  
>  	return 0;
>  }
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
