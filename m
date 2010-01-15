From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PM-WIP-OPP] [PATCH 2/2]: Change return value from ERR_PTR(..) to NULL in opp layer
Date: Fri, 15 Jan 2010 10:12:17 -0800
Message-ID: <878wbz44qm.fsf@deeprootsystems.com>
References: <1263553383.3490.44.camel@boson>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:51480 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192Ab0AOSMU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 13:12:20 -0500
Received: by pxi12 with SMTP id 12so982798pxi.33
        for <linux-omap@vger.kernel.org>; Fri, 15 Jan 2010 10:12:19 -0800 (PST)
In-Reply-To: <1263553383.3490.44.camel@boson> (Romit Dasgupta's message of "Fri\, 15 Jan 2010 16\:33\:03 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: romit@ti.com
Cc: nm@ti.com, linux-omap@vger.kernel.org

Romit Dasgupta <romit@ti.com> writes:

> Returning NULL pointer from the OPP APIs instead of ERR_PTR where
> return struct omap_opp *. This is because there is no inherent value in
> returning ERR_PTR from the opp layer. Returning NULL serves the purpose.

NAK.

Using ERR_PTR allows returning different types of error conditions,
and is common practice across the kernel.

Kevin

> Signed-off-by: Romit Dasgupta <romit@ti.com>
> ---
>
> diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
> index 5ec072e..9572062 100644
> --- a/arch/arm/mach-omap2/resource34xx.c
> +++ b/arch/arm/mach-omap2/resource34xx.c
> @@ -202,7 +202,7 @@ static int __deprecated freq_to_opp(u8 *opp_id, enum opp_t opp_t,
>  
>  	BUG_ON(opp_t >= OPP_TYPES_MAX);
>  	opp = opp_find_freq_ceil(opp_t, &freq);
> -	if (IS_ERR(opp))
> +	if (!opp)
>  		return -EINVAL;
>  	*opp_id = opp_get_opp_id(opp);
>  	return 0;
> diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
> index 8fd9366..7835b5d 100644
> --- a/arch/arm/plat-omap/opp.c
> +++ b/arch/arm/plat-omap/opp.c
> @@ -129,7 +129,7 @@ struct omap_opp *opp_find_freq_exact(enum opp_t opp_t,
>  
>  	if (unlikely(opp_t >= OPP_TYPES_MAX)) {
>  		pr_err("%s: Invalid parameters being passed\n", __func__);
> -		return ERR_PTR(-EINVAL);
> +		return NULL;
>  	}
>  
>  	oppl = _opp_list[opp_t];
> @@ -143,7 +143,7 @@ struct omap_opp *opp_find_freq_exact(enum opp_t opp_t,
>  		oppl++;
>  	}
>  
> -	return OPP_TERM(oppl) ? ERR_PTR(-ENOENT) : oppl;
> +	return OPP_TERM(oppl) ? NULL : oppl;
>  }
>  
>  struct omap_opp *opp_find_freq_ceil(enum opp_t opp_t, unsigned long *freq)
> @@ -153,7 +153,7 @@ struct omap_opp *opp_find_freq_ceil(enum opp_t opp_t, unsigned long *freq)
>  	if (unlikely(opp_t >= OPP_TYPES_MAX || !freq ||
>  		 IS_ERR(freq))) {
>  		pr_err("%s: Invalid parameters being passed\n", __func__);
> -		return ERR_PTR(-EINVAL);
> +		return NULL;
>  	}
>  
>  	oppl = _opp_list[opp_t];
> @@ -169,7 +169,7 @@ struct omap_opp *opp_find_freq_ceil(enum opp_t opp_t, unsigned long *freq)
>  	}
>  
>  	if (OPP_TERM(oppl))
> -		return ERR_PTR(-ENOENT);
> +		return NULL;
>  
>  	*freq = oppl->rate;
>  
> @@ -183,7 +183,7 @@ struct omap_opp *opp_find_freq_floor(enum opp_t opp_t, unsigned long *freq)
>  	if (unlikely(opp_t >= OPP_TYPES_MAX || !freq ||
>  		 IS_ERR(freq))) {
>  		pr_err("%s: Invalid parameters being passed\n", __func__);
> -		return ERR_PTR(-EINVAL);
> +		return NULL;
>  	}
>  	oppl = prev_opp = _opp_list[opp_t];
>  
> @@ -202,7 +202,7 @@ struct omap_opp *opp_find_freq_floor(enum opp_t opp_t, unsigned long *freq)
>  	}
>  
>  	if (prev_opp->rate > *freq)
> -		return ERR_PTR(-ENOENT);
> +		return NULL;
>  
>  	*freq = prev_opp->rate;
>  
