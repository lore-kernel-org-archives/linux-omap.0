From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 04/17] OMAP3: PM: Do not enable IO wake-up on boot
Date: Tue, 20 Oct 2009 10:21:13 -0700
Message-ID: <87d44ikmly.fsf@deeprootsystems.com>
References: <1255690150-16853-1-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-2-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-3-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-4-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-5-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:36183 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518AbZJTRVM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Oct 2009 13:21:12 -0400
Received: by pzk26 with SMTP id 26so4240244pzk.4
        for <linux-omap@vger.kernel.org>; Tue, 20 Oct 2009 10:21:16 -0700 (PDT)
In-Reply-To: <1255690150-16853-5-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Fri\, 16 Oct 2009 13\:48\:57 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org, Jouni Hogander <jouni.hogander@nokia.com>

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Jouni Hogander <jouni.hogander@nokia.com>
>
> IO wake-ups are enabled/disabled in idle loop. No need to enable them on boot.
>
> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>

Thanks, pulling into PM branch.

Kevin

> ---
>  arch/arm/mach-omap2/pm34xx.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 52a3f2b..4addc41 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -1027,9 +1027,8 @@ static void __init prcm_setup_regs(void)
>  			     OMAP3_PRM_CLKSRC_CTRL_OFFSET);
>  
>  	/* setup wakup source */
> -	prm_write_mod_reg(OMAP3430_EN_IO | OMAP3430_EN_GPIO1 |
> -			  OMAP3430_EN_GPT1 | OMAP3430_EN_GPT12,
> -			  WKUP_MOD, PM_WKEN);
> +	prm_write_mod_reg(OMAP3430_EN_GPIO1 | OMAP3430_EN_GPT1 |
> +			  OMAP3430_EN_GPT12, WKUP_MOD, PM_WKEN);
>  	/* No need to write EN_IO, that is always enabled */
>  	prm_write_mod_reg(OMAP3430_EN_GPIO1 | OMAP3430_EN_GPT1 |
>  			  OMAP3430_EN_GPT12,
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
