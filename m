From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 4/8] OMAP: omap_device: deactivate latency typo
Date: Wed, 18 Nov 2009 03:54:10 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0911180353210.25515@utopia.booyaka.com>
References: <1258506313-17115-1-git-send-email-khilman@deeprootsystems.com> <1258506313-17115-2-git-send-email-khilman@deeprootsystems.com> <1258506313-17115-3-git-send-email-khilman@deeprootsystems.com> <1258506313-17115-4-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-5-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46601 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756181AbZKRKyE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 05:54:04 -0500
In-Reply-To: <1258506313-17115-5-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

Hello Kevin,

On Tue, 17 Nov 2009, Kevin Hilman wrote:

> The deactivate hook should use 'deactivate_lat' instead of
> 'activate_lat' when doing checking on expected latency values.

Why ?

- Paul

> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/plat-omap/omap_device.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index bb16e62..da649f2 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -186,7 +186,7 @@ static int _omap_device_deactivate(struct omap_device *od, u8 ignore_lat)
>  		odpl = od->pm_lats + od->pm_lat_level;
>  
>  		if (!ignore_lat &&
> -		    ((od->dev_wakeup_lat + odpl->activate_lat) >
> +		    ((od->dev_wakeup_lat + odpl->deactivate_lat) >
>  		     od->_dev_wakeup_lat_limit))
>  			break;
>  
> @@ -209,7 +209,7 @@ static int _omap_device_deactivate(struct omap_device *od, u8 ignore_lat)
>  		     "(%llu > %d)\n", od->pdev.name, od->pdev.id,
>  		     od->pm_lat_level, deact_lat, odpl->deactivate_lat);
>  
> -		od->dev_wakeup_lat += odpl->activate_lat;
> +		od->dev_wakeup_lat += odpl->deactivate_lat;
>  
>  		od->pm_lat_level++;
>  	}
> -- 
> 1.6.5.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


