From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP3630: PM: don't warn the user with a trace in case of PM34XX_ERRATUM
Date: Fri, 28 Jan 2011 14:10:40 -0800
Message-ID: <871v3wbrxb.fsf@ti.com>
References: <1296187053-22186-1-git-send-email-ricardo.salveti@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:51777 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751912Ab1A1WKx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Jan 2011 17:10:53 -0500
Received: by mail-gx0-f176.google.com with SMTP id 4so1481680gxk.7
        for <linux-omap@vger.kernel.org>; Fri, 28 Jan 2011 14:10:44 -0800 (PST)
In-Reply-To: <1296187053-22186-1-git-send-email-ricardo.salveti@canonical.com>
	(Ricardo Salveti de Araujo's message of "Fri, 28 Jan 2011 01:57:33
	-0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>
Cc: linux-omap@vger.kernel.org

Ricardo Salveti de Araujo <ricardo.salveti@canonical.com> writes:

> In case in user has a OMAP3630 < ES1.2 the kernel should warn the user
> about the ERRATUM, but using printk instead of WARN_ON is already
> enough, as there is nothing else the user can do besides changing the
> board.

I agree, it doesn't need a full backtrace.

Minor comment below...
> Signed-off-by: Ricar
do Salveti de Araujo <ricardo.salveti@canonical.com>
> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |    2 +-
>  arch/arm/mach-omap2/pm34xx.c      |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index f7b22a1..abb9be0 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -464,7 +464,7 @@ void omap_init_power_states(void)
>  	if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583)) {
>  		omap3_power_states[OMAP3_STATE_C7].valid = 0;
>  		cpuidle_params_table[OMAP3_STATE_C7].valid = 0;
> -		WARN_ONCE(1, "%s: core off state C7 disabled due to i583\n",
> +		printk(KERN_WARNING "%s: core off state C7 disabled due to i583\n",
>  				__func__);

Please use pr_warn() instead.

>  	}
>  }
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index a4aa192..983b543 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -927,7 +927,7 @@ void omap3_pm_off_mode_enable(int enable)
>  				pwrst->pwrdm == core_pwrdm &&
>  				state == PWRDM_POWER_OFF) {
>  			pwrst->next_state = PWRDM_POWER_RET;
> -			WARN_ONCE(1,
> +			printk(KERN_WARNING
>  				"%s: Core OFF disabled due to errata i583\n",
>  				__func__);

ditto

>  		} else {

Thanks,

Kevin
