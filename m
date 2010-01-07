From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [pm-wip-opp][PATCH] omap3: pm: fix opp initialization
Date: Wed, 06 Jan 2010 16:30:20 -0800
Message-ID: <87wrzu7o4j.fsf@deeprootsystems.com>
References: <1262817757-21937-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:33125 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755309Ab0AGAaX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 19:30:23 -0500
Received: by pwj9 with SMTP id 9so11607045pwj.21
        for <linux-omap@vger.kernel.org>; Wed, 06 Jan 2010 16:30:22 -0800 (PST)
In-Reply-To: <1262817757-21937-1-git-send-email-nm@ti.com> (Nishanth Menon's message of "Wed\,  6 Jan 2010 16\:42\:37 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> dsp_opp and l3_opps are reversed as part of commit 6e1276ff
> this is wrong as the correct order needs to be l3, dsp
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>

Thanks.

I folded this into the original patch and pushed an updated
pm-wip-opp.

Kevin

> ---
> This was identified as part of investigation into Kevin's initial
> report here:
> http://marc.info/?l=linux-omap&m=126150035411486&w=2
>
>  arch/arm/mach-omap2/pm34xx.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 9744a35..7d12a3f 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -1361,8 +1361,8 @@ void __init omap3_pm_init_opp_table(void)
>  	};
>  	struct omap_opp **omap3_rate_tables[] = {
>  		&mpu_opps,
> -		&dsp_opps,
> -		&l3_opps
> +		&l3_opps,
> +		&dsp_opps
>  	};
>  
>  	omap3_opp_def_list = cpu_is_omap3630() ? omap36xx_opp_def_list :
> -- 
> 1.6.3.3
