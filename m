From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/3] DSS PM_WKEN to refill DMA
Date: Wed, 13 Jan 2010 15:47:15 -0800
Message-ID: <877hrlftz0.fsf@deeprootsystems.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94026AD401DB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f225.google.com ([209.85.220.225]:33942 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835Ab0AMXrW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 18:47:22 -0500
Received: by fxm25 with SMTP id 25so797681fxm.21
        for <linux-omap@vger.kernel.org>; Wed, 13 Jan 2010 15:47:20 -0800 (PST)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026AD401DB@dbde02.ent.ti.com> (Kishore Y.'s message of "Tue\, 22 Dec 2009 15\:07\:50 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Y, Kishore" <kishore.y@ti.com>
Cc: "Tomi Valkeinen (tomi.valkeinen@nokia.com)" <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Y, Kishore" <kishore.y@ti.com> writes:

> From: Subramani Venkatesh <x0108988@ti.com>
>
> Currently, DSS doesnot wakeup when there is a DMA request.
> DSS wake up event must be enabled so that the DMA request to refill
> the FIFO will wake up the CORE domain.
>
> Signed-off-by: Subramani Venkatesh <subramani.venkatesh@windriver.com>

Adding this one to pm-fixes queue for 2.6.33-rc.

The rest of this series needs to go upstream via Tomi's DSS2 tree.

Kevin

> ---
>  arch/arm/mach-omap2/pm34xx.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 81ed252..2d11b80 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -726,6 +726,11 @@ static void __init prcm_setup_regs(void)
>  	prm_write_mod_reg(0, OMAP3430_IVA2_MOD, PM_WKDEP);
>  	prm_write_mod_reg(0, MPU_MOD, PM_WKDEP);
>  	prm_write_mod_reg(0, OMAP3430_DSS_MOD, PM_WKDEP);
> +
> +	/* Enable PM_WKEN to support DSS LPR */
> +	prm_write_mod_reg(OMAP3430_PM_WKEN_DSS_EN_DSS,
> +				OMAP3430_DSS_MOD, PM_WKEN);
> +
>  	prm_write_mod_reg(0, OMAP3430_NEON_MOD, PM_WKDEP);
>  	prm_write_mod_reg(0, OMAP3430_CAM_MOD, PM_WKDEP);
>  	prm_write_mod_reg(0, OMAP3430_PER_MOD, PM_WKDEP);
> -- 
> 1.5.4.3
>
>
> Regards,
> Kishore Y
