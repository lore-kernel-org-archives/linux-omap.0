From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 09/13] OMAP3: PM: Apply errata i540 before save secure ram
Date: Fri, 19 Nov 2010 09:15:10 -0800
Message-ID: <87sjyxb5gh.fsf@deeprootsystems.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>
	<1290131698-6194-10-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62461 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754194Ab0KSRPO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Nov 2010 12:15:14 -0500
Received: by yxf34 with SMTP id 34so2830490yxf.19
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 09:15:13 -0800 (PST)
In-Reply-To: <1290131698-6194-10-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Thu, 18 Nov 2010 19:54:54 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Jean Pihet <jean.pihet@newoldbits.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

Nishanth Menon <nm@ti.com> writes:

> From: Eduardo Valentin <eduardo.valentin@nokia.com>
>
> We need to disable the autoidle bit from MPU INTC,
> otherwise INTC would get stall, and we would never
> come out of WFI. This must be done before save secure ram
> as well because save secure ram also does WFI.
>
> This patch is just a addition to the current W/A we have for i540,
> in order to cover the WFI inside the save secure ram.

This 'in addition' doesn't really make sense to me.  This doesn't add
anything to the current workaround, it just changes the order of
operations.

Kevin

> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index f520b38..c7e2db0 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -422,6 +422,14 @@ void omap_sram_idle(void)
>  				omap3_per_save_context();
>  	}
>  
> +	/*
> +	 * We need to disable the autoidle bit from MPU INTC,
> +	 * otherwise INTC would get stall, and we would never
> +	 * come out of WFI. This is done here because
> +	 * save secure ram also does WFI.
> +	 */
> +	omap3_intc_prepare_idle();
> +
>  	/* CORE */
>  	if (core_next_state < PWRDM_POWER_ON) {
>  		omap_uart_prepare_idle(0);
> @@ -433,8 +441,6 @@ void omap_sram_idle(void)
>  		}
>  	}
>  
> -	omap3_intc_prepare_idle();
> -
>  	/*
>  	* On EMU/HS devices ROM code restores a SRDC value
>  	* from scratchpad which has automatic self refresh on timeout
