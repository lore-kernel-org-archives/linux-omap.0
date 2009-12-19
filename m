From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH v2 2/4] OMAP SRF: adjust OPP array access
Date: Sat, 19 Dec 2009 17:30:42 +0530
Message-ID: <4B2CC06A.3080503@ti.com>
References: <1261177539-15429-1-git-send-email-khilman@deeprootsystems.com> <1261177539-15429-2-git-send-email-khilman@deeprootsystems.com> <1261177539-15429-3-git-send-email-khilman@deeprootsystems.com>
Reply-To: nm@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45554 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751578AbZLSMAp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Dec 2009 07:00:45 -0500
In-Reply-To: <1261177539-15429-3-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin Hilman said the following on 12/19/2009 04:35 AM:
> With the initial terminators removed from the OPP struct arrarys,
> the direct indexing of the array needs to be adjusted by one.
>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/resource34xx.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
> index 05e70b7..1fa8bb5 100644
> --- a/arch/arm/mach-omap2/resource34xx.c
> +++ b/arch/arm/mach-omap2/resource34xx.c
> @@ -337,8 +337,8 @@ static int program_opp(int res, struct omap_opp *opp, int target_level,
>  #ifdef CONFIG_OMAP_SMARTREFLEX
>  	unsigned long t_opp, c_opp;
>  
> -	t_opp = ID_VDD(res) | ID_OPP_NO(opp[target_level].opp_id);
> -	c_opp = ID_VDD(res) | ID_OPP_NO(opp[current_level].opp_id);
> +	t_opp = ID_VDD(res) | ID_OPP_NO(opp[target_level - 1].opp_id);
> +	c_opp = ID_VDD(res) | ID_OPP_NO(opp[current_level - 1].opp_id);
>  #endif
>   
Acked-by: Nishanth Menon <nm@ti.com>
>  
>  	/* See if have a freq associated, if not, invalid opp */
>   

