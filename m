From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: Force write last pad config register into save area
Date: Tue, 17 Nov 2009 10:34:29 -0800
Message-ID: <87my2lf1ai.fsf@deeprootsystems.com>
References: <1258475693-22068-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:48800 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308AbZKQSec (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 13:34:32 -0500
Received: by yxe17 with SMTP id 17so285291yxe.33
        for <linux-omap@vger.kernel.org>; Tue, 17 Nov 2009 10:34:38 -0800 (PST)
In-Reply-To: <1258475693-22068-1-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Tue\, 17 Nov 2009 18\:34\:53 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> Due to OMAP3 errata XYZ, the save of the last pad register (ETK_D14 and
> ETK_D15) can fail sometimes when there is simultaneous OCP access to the
> SCM register area. Fixed by writing the last register to the save area.
>
> Also, optimized the delay loop for the HW save to include an udelay(1),
> which limits the number of unnecessary HW accesses to SCM register area
> during the save.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

I certainly like this fix much better than the original proposal:

  http://marc.info/?l=linux-omap&m=125474186609661&w=2

Pulling into PM branch after s/XYZ/1.157/

Kevin

> ---
>  arch/arm/mach-omap2/pm34xx.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 4b01303..4ead40e 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -155,7 +155,15 @@ static void omap3_core_save_context(void)
>  	/* wait for the save to complete */
>  	while (!(omap_ctrl_readl(OMAP343X_CONTROL_GENERAL_PURPOSE_STATUS)
>  			& PADCONF_SAVE_DONE))
> -		;
> +		udelay(1);
> +
> +	/*
> +	 * Force write last pad into memory, as this can fail in some
> +	 * cases according to errata XYZ
> +	 */
> +	omap_ctrl_writel(omap_ctrl_readl(OMAP343X_PADCONF_ETK_D14),
> +		OMAP343X_CONTROL_MEM_WKUP + 0x2a0);
> +
>  	/* Save the Interrupt controller context */
>  	omap_intc_save_context();
>  	/* Save the GPMC context */
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
