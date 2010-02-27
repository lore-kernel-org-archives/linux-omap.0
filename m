From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP4: clockdomain: Use logical OR instead of bitwise
 OR
Date: Fri, 26 Feb 2010 16:41:31 -0800
Message-ID: <20100227004130.GH17041@atomide.com>
References: <1267188445-25652-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58487 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966718Ab0B0Ak3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Feb 2010 19:40:29 -0500
Content-Disposition: inline
In-Reply-To: <1267188445-25652-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, Abhijit Pagare <abhijitpagare@ti.com>

* Rajendra Nayak <rnayak@ti.com> [100226 04:44]:
> This patch fixes usage of bitwise OR in if conditions, and instead
> uses logical OR.

Great, can you please check and update this for other similar errors:

$ grep -r ") | cpu" .
./mach-omap2/prcm.c:    if (cpu_is_omap24xx() | cpu_is_omap34xx())
./mach-omap2/prcm.c:    if (cpu_is_omap24xx() | cpu_is_omap34xx())
./mach-omap2/clockdomain.c:     } else if (cpu_is_omap34xx() | cpu_is_omap44xx()) {
./mach-omap2/clockdomain.c:     } else if (cpu_is_omap34xx() | cpu_is_omap44xx()) {
./mach-omap2/clockdomain.c:     } else if (cpu_is_omap34xx() | cpu_is_omap44xx()) {
./mach-omap2/powerdomain.c:     if (cpu_is_omap24xx() | cpu_is_omap34xx()) {

Regards,

Tony

 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Abhijit Pagare <abhijitpagare@ti.com>
> ---
> 
> Patch generated on top of for_2.6.34_b branch from
> git://git.pwsan.com/linux-2.6 tree.
> 
>  arch/arm/mach-omap2/clockdomain.c |    4 ++--
>  arch/arm/mach-omap2/powerdomain.c |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
> index b87ad66..be846e6 100644
> --- a/arch/arm/mach-omap2/clockdomain.c
> +++ b/arch/arm/mach-omap2/clockdomain.c
> @@ -812,7 +812,7 @@ int omap2_clkdm_sleep(struct clockdomain *clkdm)
>  		cm_set_mod_reg_bits(OMAP24XX_FORCESTATE,
>  			    clkdm->pwrdm.ptr->prcm_offs, OMAP2_PM_PWSTCTRL);
>  
> -	} else if (cpu_is_omap34xx() | cpu_is_omap44xx()) {
> +	} else if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
>  
>  		u32 bits = (OMAP34XX_CLKSTCTRL_FORCE_SLEEP <<
>  			 __ffs(clkdm->clktrctrl_mask));
> @@ -856,7 +856,7 @@ int omap2_clkdm_wakeup(struct clockdomain *clkdm)
>  		cm_clear_mod_reg_bits(OMAP24XX_FORCESTATE,
>  			      clkdm->pwrdm.ptr->prcm_offs, OMAP2_PM_PWSTCTRL);
>  
> -	} else if (cpu_is_omap34xx() | cpu_is_omap44xx()) {
> +	} else if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
>  
>  		u32 bits = (OMAP34XX_CLKSTCTRL_FORCE_WAKEUP <<
>  			 __ffs(clkdm->clktrctrl_mask));
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index 9a0fb38..ebfce7d 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -222,7 +222,7 @@ void pwrdm_init(struct powerdomain **pwrdm_list)
>  {
>  	struct powerdomain **p = NULL;
>  
> -	if (cpu_is_omap24xx() | cpu_is_omap34xx()) {
> +	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
>  		pwrstctrl_reg_offs = OMAP2_PM_PWSTCTRL;
>  		pwrstst_reg_offs = OMAP2_PM_PWSTST;
>  	} else if (cpu_is_omap44xx()) {
> -- 
> 1.5.4.7
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
