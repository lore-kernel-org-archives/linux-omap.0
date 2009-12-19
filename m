From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 05/12] OMAP TWL/TPS OPP: vsel rounding belongs in opp_twl_tps.c
Date: Sat, 19 Dec 2009 17:46:41 +0530
Message-ID: <4B2CC429.2030809@ti.com>
References: <20091218004617.7694.84525.stgit@localhost.localdomain> <20091218004735.7694.13673.stgit@localhost.localdomain>
Reply-To: nm@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45901 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164AbZLSMQp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Dec 2009 07:16:45 -0500
In-Reply-To: <20091218004735.7694.13673.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Paul Walmsley said the following on 12/18/2009 06:17 AM:
> The vsel roundoff code belongs in omap_twl_uv_to_vsel(), not
> omap_opp_populate(), since other code may use omap_twl_uv_to_vsel().
> ---
>  arch/arm/plat-omap/opp.c         |    3 ---
>  arch/arm/plat-omap/opp_twl_tps.c |   15 +++++++++++++--
>  2 files changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
> index 9586e3b..2543932 100644
> --- a/arch/arm/plat-omap/opp.c
> +++ b/arch/arm/plat-omap/opp.c
> @@ -144,9 +144,6 @@ static void omap_opp_populate(struct omap_opp *opp,
>  	opp->rate = opp_def->freq;
>  	opp->enabled = opp_def->enabled;
>  	opp->vsel = omap_twl_uv_to_vsel(opp_def->u_volt);
> -	/* round off to higher voltage */
> -	if (opp_def->u_volt > omap_twl_vsel_to_uv(opp->vsel))
> -		opp->vsel++;
>  }
>  
>  struct omap_opp *opp_add(struct omap_opp *oppl,
> diff --git a/arch/arm/plat-omap/opp_twl_tps.c b/arch/arm/plat-omap/opp_twl_tps.c
> index edcb719..e0db39b 100644
> --- a/arch/arm/plat-omap/opp_twl_tps.c
> +++ b/arch/arm/plat-omap/opp_twl_tps.c
> @@ -2,7 +2,9 @@
>   * opp_twl_tps.c - TWL/TPS-specific functions for the OPP code
>   *
>   * Copyright (C) 2009 Texas Instruments Incorporated.
> - *	Nishanth Menon
> + * Nishanth Menon
> + * Copyright (C) 2009 Nokia Corporation
> + * Paul Walmsley
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -34,5 +36,14 @@ unsigned long omap_twl_vsel_to_uv(const u8 vsel)
>   */
>  u8 omap_twl_uv_to_vsel(unsigned long uv)
>  {
> -	return ((uv / 100) - 6000) / 125;
> +	u8 vsel;
> +
> +	vsel = ((uv / 100) - 6000) / 125;
> +
> +	/* round off to higher voltage */
> +	/* XXX Surely not the best way to handle this. */
> +	if (uv > omap_twl_vsel_to_uv(vsel))
> +		vsel++;
> +
> +	return vsel;
>  }
>
>
>   

ouch I missed this patch - this looks fine now.. thanks
Regards,
NM
