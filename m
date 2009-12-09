From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: hwmod: check for clkdomain pointer before accesing it to change the sleep dependencies.
Date: Wed, 09 Dec 2009 15:08:35 -0800
Message-ID: <873a3ju4ng.fsf@deeprootsystems.com>
References: <1260098323-26183-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:62105 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758616AbZLIXIc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Dec 2009 18:08:32 -0500
Received: by yxe17 with SMTP id 17so6429806yxe.33
        for <linux-omap@vger.kernel.org>; Wed, 09 Dec 2009 15:08:38 -0800 (PST)
In-Reply-To: <1260098323-26183-1-git-send-email-thara@ti.com> (Thara Gopinath's message of "Sun\,  6 Dec 2009 16\:48\:43 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

Thara Gopinath <thara@ti.com> writes:

> Some clock nodes like wdt1_fck, sr1_fck, sr2_fck etc do not have a
> clock domain associated . For such nodes accessing the clock domain pointers 
> in _add_initiator_dep and _del_initiator_dep, will lead to null pointer
> defreferencing crash. Adding support in these functions to check for
> existence of clkdm pointer before trying to acess it. Even if tomorrow
> we correct all the clock nodes to have an associated clock domain, checking
> for the existence of the pointer is a good programming practice.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
> This patch depends on http://patchwork.kernel.org/patch/63383/

I think clocks without associated clockdomains should be handled with
a flag instead of a check for a NULL pointer.

Your current approach will silently fail if someone forgets to add
a clockdomain to a clock that should have one.

Kevin


>  arch/arm/mach-omap2/omap_hwmod.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 18e6478..3edc387 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -314,8 +314,10 @@ static int _add_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod *init_oh)
>  	if (!oh->_clk)
>  		return -EINVAL;
>  
> -	return pwrdm_add_sleepdep(oh->_clk->clkdm->pwrdm.ptr,
> +	if (oh->_clk->clkdm)
> +		return pwrdm_add_sleepdep(oh->_clk->clkdm->pwrdm.ptr,
>  				  init_oh->_clk->clkdm->pwrdm.ptr);
> +	return 0;
>  }
>  
>  /**
> @@ -335,8 +337,10 @@ static int _del_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod *init_oh)
>  	if (!oh->_clk)
>  		return -EINVAL;
>  
> -	return pwrdm_del_sleepdep(oh->_clk->clkdm->pwrdm.ptr,
> +	if (oh->_clk->clkdm)
> +		return pwrdm_del_sleepdep(oh->_clk->clkdm->pwrdm.ptr,
>  				  init_oh->_clk->clkdm->pwrdm.ptr);
> +	return 0;
>  }
>  
>  /**
> -- 
> 1.5.4.7
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
