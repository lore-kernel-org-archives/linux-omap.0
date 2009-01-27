From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] Don't scale voltage in C1 state
Date: Tue, 27 Jan 2009 14:34:36 -0800
Message-ID: <87mydcs7ib.fsf@deeprootsystems.com>
References: <1231950755-8620-1-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:61027 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753887AbZA0Wej (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jan 2009 17:34:39 -0500
Received: by rv-out-0506.google.com with SMTP id k40so6624832rvb.1
        for <linux-omap@vger.kernel.org>; Tue, 27 Jan 2009 14:34:38 -0800 (PST)
In-Reply-To: <1231950755-8620-1-git-send-email-peter.de-schrijver@nokia.com> (Peter De Schrijver's message of "Wed\, 14 Jan 2009 18\:32\:35 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

"Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com> writes:

> This patch prevents VDD1 and VDD2 to go to the lowest OPP when entering C1.
> It improves wakeup latency from 600us to about 50us.
>
> Now with signoff :)
>
> Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

Thanks, pushed to PM branch.

Kevin

> ---
>  arch/arm/mach-omap2/pm34xx.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index b0b2188..87ef55e 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -1052,7 +1052,7 @@ static void __init configure_vc(void)
>  				OMAP3_PRM_VC_I2C_CFG_OFFSET);
>  
>  	/* Setup voltctrl and other setup times */
> -	prm_write_mod_reg(OMAP3430_AUTO_RET | OMAP3430_AUTO_SLEEP,
> +	prm_write_mod_reg(OMAP3430_AUTO_RET,
>  			  OMAP3430_GR_MOD, OMAP3_PRM_VOLTCTRL_OFFSET);
>  
>  	prm_write_mod_reg(OMAP3430_CLKSETUP_DURATION, OMAP3430_GR_MOD,
> -- 
> 1.5.6.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
