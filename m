From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH v2 1/4] OMAP OPP: Add accessor function for getting OPP
 ID.
Date: Sat, 19 Dec 2009 17:26:46 +0530
Message-ID: <4B2CBF7E.9020504@ti.com>
References: <1261177539-15429-1-git-send-email-khilman@deeprootsystems.com> <1261177539-15429-2-git-send-email-khilman@deeprootsystems.com>
Reply-To: nm@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43993 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751421AbZLSL4u (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Dec 2009 06:56:50 -0500
In-Reply-To: <1261177539-15429-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin Hilman said the following on 12/19/2009 04:35 AM:
> Add new function opp_get_opp_id() for finding the OPP ID of a given
> OPP.  This allows us to further hide OPP layer details.
>
> NOTE: OPP IDs are deprecated, and this function will eventually
>       be removed after all users of OPP IDs are removed.
>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/plat-omap/include/plat/opp.h |    1 +
>  arch/arm/plat-omap/opp.c              |    5 +++++
>  2 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
> index cdadf67..6fe574c 100644
> --- a/arch/arm/plat-omap/include/plat/opp.h
> +++ b/arch/arm/plat-omap/include/plat/opp.h
> @@ -243,6 +243,7 @@ int opp_disable(struct omap_opp *opp);
>  
>  struct omap_opp * __deprecated opp_find_by_opp_id(struct omap_opp *opps,
>  						  u8 opp_id);
> +u8 __deprecated opp_get_opp_id(struct omap_opp *opp);
>   
Sigh.. ok... been trying to avoid this precisely :(
Acked-by: Nishanth Menon <nm@ti.com>
>  
>  void opp_init_cpufreq_table(struct omap_opp *opps,
>  			    struct cpufreq_frequency_table **table);
> diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
> index e7b6f2a..4f7fa22 100644
> --- a/arch/arm/plat-omap/opp.c
> +++ b/arch/arm/plat-omap/opp.c
> @@ -69,6 +69,11 @@ struct omap_opp * __deprecated opp_find_by_opp_id(struct omap_opp *opps,
>  	return NULL;
>  }
>  
> +u8 __deprecated opp_get_opp_id(struct omap_opp *opp)
> +{
> +	return opp->opp_id;
> +}
> +
>  int opp_get_opp_count(struct omap_opp *oppl)
>  {
>  	u8 n = 0;
>   

