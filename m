From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/10] OPP layer and additional cleanups.
Date: Mon, 4 Jan 2010 16:04:59 -0600
Message-ID: <4B42660B.1020304@ti.com>
References: <1262266145.20175.177.camel@boson>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48039 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753011Ab0ADWFE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jan 2010 17:05:04 -0500
In-Reply-To: <1262266145.20175.177.camel@boson>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Dasgupta, Romit had written, on 12/31/2009 07:29 AM, the following:
> Cleaner way to take care of the precision loss during integer division.
> 
please sign-off your patch and fix subject.
> 
> diff --git a/arch/arm/plat-omap/opp_twl_tps.c b/arch/arm/plat-omap/opp_twl_tps.c
> index e0db39b..43dee2d 100644
> --- a/arch/arm/plat-omap/opp_twl_tps.c
> +++ b/arch/arm/plat-omap/opp_twl_tps.c
> @@ -36,14 +36,7 @@ unsigned long omap_twl_vsel_to_uv(const u8 vsel)
>   */
>  u8 omap_twl_uv_to_vsel(unsigned long uv)
>  {
> -	u8 vsel;
> +	/* Takes care of precision loss due to integer division */
> +	return (((uv + 99) / 100 - 6000) + 124) / 125;
>  
> -	vsel = ((uv / 100) - 6000) / 125;
> -
> -	/* round off to higher voltage */
> -	/* XXX Surely not the best way to handle this. */
> -	if (uv > omap_twl_vsel_to_uv(vsel))
> -		vsel++;
> -
> -	return vsel;
>  }
> 
> 
Nice, thanks.
Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
