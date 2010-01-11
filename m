From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PM-WIP-OPP] [PATCH] cleaner ceil function for uv to vsel conversion
Date: Mon, 11 Jan 2010 14:29:01 -0800
Message-ID: <876378mg2a.fsf@deeprootsystems.com>
References: <1263189218.16324.3.camel@boson>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.216.174]:49727 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab0AKW3F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 17:29:05 -0500
Received: by pxi4 with SMTP id 4so4021180pxi.33
        for <linux-omap@vger.kernel.org>; Mon, 11 Jan 2010 14:29:04 -0800 (PST)
In-Reply-To: <1263189218.16324.3.camel@boson> (Romit Dasgupta's message of "Mon\, 11 Jan 2010 11\:23\:38 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: romit@ti.com
Cc: nm@ti.com, linux-omap@vger.kernel.org

Romit Dasgupta <romit@ti.com> writes:

> Cleaner ceil function.

Needs better subject and better changelog.

Subject should probably be something like: OMAP: 

  [PATCH] OPP: TWL/TPS: optimize uv to vsel function

And changelog should describe the motiviation for the patch or a
description of the problem you're trying to solve.  IOW, is this a
correctness fix, or an optimization, etc.  Looks to me like it's tring
to compensate for some rounding issues, but please describe in detail
in the changelog.

Thanks,

Kevin


> Signed-off-by: Romit Dasgupta <romit@ti.com>
> ---
> diff --git a/arch/arm/plat-omap/opp_twl_tps.c b/arch/arm/plat-omap/opp_twl_tps.c
> index e0db39b..1caa414 100644
> --- a/arch/arm/plat-omap/opp_twl_tps.c
> +++ b/arch/arm/plat-omap/opp_twl_tps.c
> @@ -36,14 +36,7 @@ unsigned long omap_twl_vsel_to_uv(const u8 vsel)
>   */
>  u8 omap_twl_uv_to_vsel(unsigned long uv)
>  {
> -	u8 vsel;
>  
> -	vsel = ((uv / 100) - 6000) / 125;
> +	return (((uv + 99) / 100 - 6000) + 124) / 125;
>  
> -	/* round off to higher voltage */
> -	/* XXX Surely not the best way to handle this. */
> -	if (uv > omap_twl_vsel_to_uv(vsel))
> -		vsel++;
> -
> -	return vsel;
>  }
