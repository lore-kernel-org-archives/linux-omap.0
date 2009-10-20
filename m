From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 05/17] OMAP:PM: Precedence fix
Date: Tue, 20 Oct 2009 10:23:55 -0700
Message-ID: <877huqkmhg.fsf@deeprootsystems.com>
References: <1255690150-16853-1-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-2-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-3-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-4-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-5-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-6-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f171.google.com ([209.85.216.171]:35478 "EHLO
	mail-px0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634AbZJTRXx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Oct 2009 13:23:53 -0400
Received: by pxi1 with SMTP id 1so1543216pxi.33
        for <linux-omap@vger.kernel.org>; Tue, 20 Oct 2009 10:23:57 -0700 (PDT)
In-Reply-To: <1255690150-16853-6-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Fri\, 16 Oct 2009 13\:48\:58 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org, Carlos Chinea <carlos.chinea@nokia.com>

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Carlos Chinea <carlos.chinea@nokia.com>
>
> Signed-off-by: Carlos Chinea <carlos.chinea@nokia.com>
> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>

Patch looks good, but needs better subject and a changelog.

Kevin

> ---
>  arch/arm/mach-omap2/pm34xx.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 4addc41..588ab79 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -225,8 +225,8 @@ static void omap3_core_save_context(void)
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
