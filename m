From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] omap: device: improve errors handling
Date: Mon, 12 Jul 2010 10:30:01 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1007121028410.19255@utopia.booyaka.com>
References: <1278941887.16634.85.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58518 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755913Ab0GLQaC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jul 2010 12:30:02 -0400
In-Reply-To: <1278941887.16634.85.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Tony Lindgen <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, "ext Menon, Nishanth" <nm@ti.com>, Thara Gopinath <thara@ti.com>

On Mon, 12 Jul 2010, Artem Bityutskiy wrote:

> From: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
> 
> Do not forget to check the 'platform_device_add_data()' error code
> in 'omap_device_build_ss()'.

Looks fine to me, platform_device_add_data() can return -ENOMEM in the 
unlikely event that its kmemdup() fails.

Acked-by: Paul Walmsley <paul@pwsan.com>

> 
> Signed-off-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
> Acked-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/plat-omap/omap_device.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index ea0d659..d2b1609 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -407,7 +407,9 @@ struct omap_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
>  	od->pdev.num_resources = res_count;
>  	od->pdev.resource = res;
>  
> -	platform_device_add_data(&od->pdev, pdata, pdata_len);
> +	ret = platform_device_add_data(&od->pdev, pdata, pdata_len);
> +	if (ret)
> +		goto odbs_exit4;
>  
>  	od->pm_lats = pm_lats;
>  	od->pm_lats_cnt = pm_lats_cnt;
> -- 
> 1.7.1.1
> 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
