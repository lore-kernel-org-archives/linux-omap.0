From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: HWMOD: Fix compilation error due to sr hwmod usage
Date: Tue, 22 Jun 2010 08:29:43 -0700
Message-ID: <87iq5bkrvc.fsf@deeprootsystems.com>
References: <1277218823-15133-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:33572 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371Ab0FVP3q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jun 2010 11:29:46 -0400
Received: by pvh11 with SMTP id 11so429141pvh.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Jun 2010 08:29:45 -0700 (PDT)
In-Reply-To: <1277218823-15133-1-git-send-email-charu@ti.com> (Charulatha V.'s message of "Tue\, 22 Jun 2010 20\:30\:23 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org

Charulatha V <charu@ti.com> writes:

> On 'origin/pm-wip/hwmods-omap4' branch, fix the following
> compilation error:
>
> arch/arm/mach-omap2/omap_hwmod_3xxx_data.c:218:
> 	error: 'omap34xx_sr1_hwmod' undeclared here (not in a function)
> arch/arm/mach-omap2/omap_hwmod_3xxx_data.c:219:
> 	error: 'omap34xx_sr2_hwmod' undeclared here (not in a function)
> arch/arm/mach-omap2/omap_hwmod_3xxx_data.c:220: error:
> 	'omap36xx_sr1_hwmod' undeclared here (not in a function)
> arch/arm/mach-omap2/omap_hwmod_3xxx_data.c:221:
> 	error: 'omap36xx_sr2_hwmod' undeclared here (not in a function)
> make[1]: *** [arch/arm/mach-omap2/omap_hwmod_3xxx_data.o] Error 1
>
> Signed-off-by: Charulatha V <charu@ti.com>

Oops, looks like a mis-merge on my part when adding the IVA hwmod data.

I fixed this and just pushed an updated version of the pm-wip/hwmods
branch and (rebased pm-wip/runtime and pm-wip/hwmods-omap4 on top.)

Note that it make take a little time to propagate to the kernel.org
mirrors.

Kevin

> ---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index f7e1ace..fe92b5d 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -215,10 +215,6 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
>  	&omap3xxx_l4_wkup_hwmod,
>  	&omap3xxx_mpu_hwmod,
>  	&omap3xxx_iva2_hwmod,
> -	&omap34xx_sr1_hwmod,
> -	&omap34xx_sr2_hwmod,
> -	&omap36xx_sr1_hwmod,
> -	&omap36xx_sr2_hwmod,
>  	NULL,
>  };
>  
> -- 
> 1.6.3.3
