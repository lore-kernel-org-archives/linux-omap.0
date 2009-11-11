From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 01/11] OMAP3: PM: Fixed padconf save done check
Date: Wed, 11 Nov 2009 15:16:03 -0800
Message-ID: <87ocn8zm8c.fsf@deeprootsystems.com>
References: <1256313835-2391-1-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-2-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:36308 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759619AbZKKXQF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 18:16:05 -0500
Received: by ywh6 with SMTP id 6so1437445ywh.4
        for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 15:16:09 -0800 (PST)
In-Reply-To: <1256313835-2391-2-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Fri\, 23 Oct 2009 19\:03\:45 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org, Carlos Chinea <carlos.chinea@nokia.com>

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Carlos Chinea <carlos.chinea@nokia.com>
>
> Previously the operator precedence dictated that the delay loop was exited
> immediately, potentially causing off-mode to be entered too soon.
>
> Signed-off-by: Carlos Chinea <carlos.chinea@nokia.com>
> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>

Looks good.  Applying to PM branch and will queue in my pm-fixes branch
for after 2.6.32 is released.

Kevin

> ---
>  arch/arm/mach-omap2/pm34xx.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 01260ec..8353764 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -146,8 +146,8 @@ static void omap3_core_save_context(void)
>  	control_padconf_off |= START_PADCONF_SAVE;
>  	omap_ctrl_writel(control_padconf_off, OMAP343X_CONTROL_PADCONF_OFF);
>  	/* wait for the save to complete */
> -	while (!omap_ctrl_readl(OMAP343X_CONTROL_GENERAL_PURPOSE_STATUS)
> -			& PADCONF_SAVE_DONE)
> +	while (!(omap_ctrl_readl(OMAP343X_CONTROL_GENERAL_PURPOSE_STATUS)
> +			& PADCONF_SAVE_DONE))
>  		;
>  	/* Save the Interrupt controller context */
>  	omap3_intc_save_context();
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
