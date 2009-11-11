From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 08/11] OMAP3: PM: Disabled I2C4 repeated start operation mode
Date: Wed, 11 Nov 2009 15:30:01 -0800
Message-ID: <87skcky70m.fsf@deeprootsystems.com>
References: <1256313835-2391-1-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-2-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-3-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-4-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-5-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-6-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-7-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-8-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-9-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f194.google.com ([209.85.221.194]:46760 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759559AbZKKX37 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 18:29:59 -0500
Received: by qyk32 with SMTP id 32so780612qyk.4
        for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 15:30:04 -0800 (PST)
In-Reply-To: <1256313835-2391-9-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Fri\, 23 Oct 2009 19\:03\:52 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> Repeated start forces I2C4 pads low during idle, which increases power
> consumption through external pull-ups. On the other hand, this change
> increases I2C4 command latencies a bit.

Could you give an idea about how much the latencies increased?

I'll apply this one but would like to update the changelog with some
more details if available.

Kevin

> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index fec9c38..154cd31 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -1219,7 +1219,7 @@ static void __init configure_vc(void)
>  	prm_write_mod_reg(OMAP3430_CMD1 | OMAP3430_RAV1, OMAP3430_GR_MOD,
>  			  OMAP3_PRM_VC_CH_CONF_OFFSET);
>  
> -	prm_write_mod_reg(OMAP3430_MCODE_SHIFT | OMAP3430_HSEN | OMAP3430_SREN,
> +	prm_write_mod_reg(OMAP3430_MCODE_SHIFT | OMAP3430_HSEN,
>  			  OMAP3430_GR_MOD,
>  			  OMAP3_PRM_VC_I2C_CFG_OFFSET);
>  
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
