From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: fix AM35x musb issue with AUTOIDLE bit in CONTROL_SYSCONFIG
Date: Wed, 05 May 2010 11:01:18 -0700
Message-ID: <87vdb28byp.fsf@deeprootsystems.com>
References: <1272965585-21836-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:33815 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705Ab0EESBW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 14:01:22 -0400
Received: by pva18 with SMTP id 18so602199pva.19
        for <linux-omap@vger.kernel.org>; Wed, 05 May 2010 11:01:21 -0700 (PDT)
In-Reply-To: <1272965585-21836-1-git-send-email-ajay.gupta@ti.com> (Ajay Kumar Gupta's message of "Tue\,  4 May 2010 15\:03\:05 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-omap@vger.kernel.org

Ajay Kumar Gupta <ajay.gupta@ti.com> writes:

> MUSB interface on AM35x stops working when we set AUTOIDLE bit (D0) in
> CONTROL_SYSCONFIG(0x48002010) register.

why?

stops working in what way?

I think you need to investigate more into why this is happening.

This suggest to me that something in the MUSB device/driver init
is not quite right for these boards.  

Kevin


> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
>
> ---
>  arch/arm/mach-omap2/pm34xx.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index ea0000b..cc9d566 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -849,7 +849,12 @@ static void __init prcm_setup_regs(void)
>  			CM_AUTOIDLE);
>  	}
>  
> -	omap_ctrl_writel(OMAP3430_AUTOIDLE, OMAP2_CONTROL_SYSCONFIG);
> +	/*
> +	 * MUSB interface on AM35x stops working when we enable AUTOIDLE,
> +	 * so avoid this for AM3517 and AM3505 device.
> +	 */
> +	if (!cpu_is_omap3517() && !cpu_is_omap3505())
> +		omap_ctrl_writel(OMAP3430_AUTOIDLE, OMAP2_CONTROL_SYSCONFIG);
>  
>  	/*
>  	 * Set all plls to autoidle. This is needed until autoidle is
> -- 
> 1.6.2.4
