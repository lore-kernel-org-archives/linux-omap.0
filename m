From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 8/8] OMAP: omap_device: use UINT_MAX for default wakeup
 latency limit
Date: Wed, 18 Nov 2009 03:57:27 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0911180355420.25515@utopia.booyaka.com>
References: <1258506313-17115-1-git-send-email-khilman@deeprootsystems.com> <1258506313-17115-2-git-send-email-khilman@deeprootsystems.com> <1258506313-17115-3-git-send-email-khilman@deeprootsystems.com> <1258506313-17115-4-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-5-git-send-email-khilman@deeprootsystems.com> <1258506313-17115-6-git-send-email-khilman@deeprootsystems.com> <1258506313-17115-7-git-send-email-khilman@deeprootsystems.com> <1258506313-17115-8-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-9-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46658 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753159AbZKRK5V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 05:57:21 -0500
In-Reply-To: <1258506313-17115-9-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

Hi Kevin,

On Tue, 17 Nov 2009, Kevin Hilman wrote:

> The _dev_wakeup_lat_limit field of struct omap_device is u32, so use
> UINT_MAX instead of INT_MAX for the default maximum.
> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

Indeed, thanks.  Will add this to the second version of the fixes series.


- Paul

> ---
>  arch/arm/plat-omap/omap_device.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index 83bee1c..9ec3735 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -468,7 +468,7 @@ int omap_device_enable(struct platform_device *pdev)
>  	ret = _omap_device_activate(od, IGNORE_WAKEUP_LAT);
>  
>  	od->dev_wakeup_lat = 0;
> -	od->_dev_wakeup_lat_limit = INT_MAX;
> +	od->_dev_wakeup_lat_limit = UINT_MAX;
>  	od->_state = OMAP_DEVICE_STATE_ENABLED;
>  
>  	return ret;
> -- 
> 1.6.5.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
