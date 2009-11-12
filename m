From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/5] OMAP3: PM: Disabled I2C4 repeated start operation mode
Date: Thu, 12 Nov 2009 07:32:01 -0800
Message-ID: <878webvjwu.fsf@deeprootsystems.com>
References: <1258020444-3809-1-git-send-email-tero.kristo@nokia.com>
	<1258020444-3809-2-git-send-email-tero.kristo@nokia.com>
	<1258020444-3809-3-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:61267 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092AbZKLPb5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 10:31:57 -0500
Received: by pwi3 with SMTP id 3so1399577pwi.21
        for <linux-omap@vger.kernel.org>; Thu, 12 Nov 2009 07:32:03 -0800 (PST)
In-Reply-To: <1258020444-3809-3-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Thu\, 12 Nov 2009 12\:07\:21 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> Repeated start forces I2C4 pads low during idle, which increases power
> consumption through external pull-ups. On the other hand, this change
> increases I2C4 command latencies somewhat due to additional master code
> sent in the beginning of each I2C4 command (8 bits data + start + ack bits
> in fast/standard mode => increases total command duration from 25us to 50us.)
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

Thanks, applying this version to PM branch.

Kevin

> ---
>  arch/arm/mach-omap2/pm34xx.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index b97f7d8..796d726 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -1221,7 +1221,7 @@ static void __init configure_vc(void)
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
