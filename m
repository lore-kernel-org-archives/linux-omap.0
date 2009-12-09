From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: Enable wake-up from McBSP2, 3 and 4 modules
Date: Wed, 09 Dec 2009 15:38:02 -0800
Message-ID: <87iqcfsopx.fsf@deeprootsystems.com>
References: <1259241530-26109-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f212.google.com ([209.85.217.212]:42599 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758670AbZLIXh6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Dec 2009 18:37:58 -0500
Received: by gxk4 with SMTP id 4so11717553gxk.8
        for <linux-omap@vger.kernel.org>; Wed, 09 Dec 2009 15:38:04 -0800 (PST)
In-Reply-To: <1259241530-26109-1-git-send-email-peter.ujfalusi@nokia.com> (Peter Ujfalusi's message of "Thu\, 26 Nov 2009 15\:18\:50 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com

Peter Ujfalusi <peter.ujfalusi@nokia.com> writes:

> Wake-up from McBSP ports are needed, especially when the THRESHOLD
> dma mode is in use for audio playback.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Looks good, adding to PM branch and will queue in pm-fxies for
2.6.33-rc series.

Kevin

> ---
>  arch/arm/mach-omap2/pm34xx.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 81ed252..6b17647 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -878,12 +878,16 @@ static void __init prcm_setup_regs(void)
>  	/* Enable wakeups in PER */
>  	prm_write_mod_reg(OMAP3430_EN_GPIO2 | OMAP3430_EN_GPIO3 |
>  			  OMAP3430_EN_GPIO4 | OMAP3430_EN_GPIO5 |
> -			  OMAP3430_EN_GPIO6 | OMAP3430_EN_UART3,
> +			  OMAP3430_EN_GPIO6 | OMAP3430_EN_UART3 |
> +			  OMAP3430_EN_MCBSP2 | OMAP3430_EN_MCBSP3 |
> +			  OMAP3430_EN_MCBSP4,
>  			  OMAP3430_PER_MOD, PM_WKEN);
>  	/* and allow them to wake up MPU */
>  	prm_write_mod_reg(OMAP3430_GRPSEL_GPIO2 | OMAP3430_EN_GPIO3 |
>  			  OMAP3430_GRPSEL_GPIO4 | OMAP3430_EN_GPIO5 |
> -			  OMAP3430_GRPSEL_GPIO6 | OMAP3430_EN_UART3,
> +			  OMAP3430_GRPSEL_GPIO6 | OMAP3430_EN_UART3 |
> +			  OMAP3430_EN_MCBSP2 | OMAP3430_EN_MCBSP3 |
> +			  OMAP3430_EN_MCBSP4,
>  			  OMAP3430_PER_MOD, OMAP3430_PM_MPUGRPSEL);
>  
>  	/* Don't attach IVA interrupts */
> -- 
> 1.6.5.3
