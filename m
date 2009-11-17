From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] OMAP3: PM: Force write last pad config register into
 save area
Date: Tue, 17 Nov 2009 11:17:00 -0600
Message-ID: <4B02DA8C.3060801@ti.com>
References: <> <1258475693-22068-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53508 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752580AbZKQRQ7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Nov 2009 12:16:59 -0500
In-Reply-To: <1258475693-22068-1-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tero Kristo had written, on 11/17/2009 10:34 AM, the following:
> From: Tero Kristo <tero.kristo@nokia.com>
> 
> Due to OMAP3 errata XYZ, the save of the last pad register (ETK_D14 and
> ETK_D15) can fail sometimes when there is simultaneous OCP access to the
> SCM register area. Fixed by writing the last register to the save area.
> 
> Also, optimized the delay loop for the HW save to include an udelay(1),
> which limits the number of unnecessary HW accesses to SCM register area
> during the save.
Nitpicky minor comment: Should we split this out?

Also, this replaces the patch discussed under: 
http://marc.info/?t=125474192000004&r=1&w=2

> 
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Acked-by: Nishanth Menon <nm@ti.com>

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


-- 
Regards,
Nishanth Menon
