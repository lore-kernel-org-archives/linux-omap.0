From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/6] 34XX: PM: Workaround to check wether any fck is
	active before entering sleep
Date: Thu, 3 Jul 2008 13:40:07 +0300
Message-ID: <20080703104004.GP14276@atomide.com>
References: <87tzfb9uhs.fsf@trdhcp146196.ntc.nokia.com> <1214815966-23136-1-git-send-email-jouni.hogander@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58964 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754900AbYGCMVl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jul 2008 08:21:41 -0400
Content-Disposition: inline
In-Reply-To: <1214815966-23136-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jouni Hogander <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

* Jouni Hogander <jouni.hogander@nokia.com> [080630 11:53]:
> This workaround shouldn't be needed when all drivers are configuring
> their sysconfig registers properly and using their clocks properly.

Can you please update this one more time to add the comments above
also to the code so we'll remember why it's there when reading the
code?

Thanks,

Tony

> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |   31 +++++++++++++++++++++++++++++++
>  1 files changed, 31 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 449e7b5..92e56cd 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -174,10 +174,41 @@ static void omap_sram_idle(void)
>  	omap2_gpio_resume_after_retention();
>  }
>  
> +static int omap3_fclks_active(void)
> +{
> +	u32 fck_core1 = 0, fck_core3 = 0, fck_sgx = 0, fck_dss = 0,
> +		fck_cam = 0, fck_per = 0, fck_usbhost = 0;
> +
> +	fck_core1 = cm_read_mod_reg(CORE_MOD,
> +				    CM_FCLKEN1);
> +	if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0)) {
> +		fck_core3 = cm_read_mod_reg(CORE_MOD,
> +					    OMAP3430ES2_CM_FCLKEN3);
> +		fck_sgx = cm_read_mod_reg(OMAP3430ES2_SGX_MOD,
> +					  CM_FCLKEN);
> +		fck_usbhost = cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
> +					      CM_FCLKEN);
> +	} else
> +		fck_sgx = cm_read_mod_reg(GFX_MOD,
> +					  OMAP3430ES2_CM_FCLKEN3);
> +	fck_dss = cm_read_mod_reg(OMAP3430_DSS_MOD,
> +				  CM_FCLKEN);
> +	fck_cam = cm_read_mod_reg(OMAP3430_CAM_MOD,
> +				  CM_FCLKEN);
> +	fck_per = cm_read_mod_reg(OMAP3430_PER_MOD,
> +				  CM_FCLKEN);
> +	if (fck_core1 | fck_core3 | fck_sgx | fck_dss |
> +	    fck_cam | fck_per | fck_usbhost)
> +		return 1;
> +	return 0;
> +}
> +
>  static int omap3_can_sleep(void)
>  {
>  	if (!enable_dyn_sleep)
>  		return 0;
> +	if (omap3_fclks_active())
> +		return 0;
>  	if (atomic_read(&sleep_block) > 0)
>  		return 0;
>  	return 1;
> -- 
> 1.5.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
