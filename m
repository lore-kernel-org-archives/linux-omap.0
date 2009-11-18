From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 6/8] OMAP: omap_device: use read_persistent_clock()
 instead of getnstimeofday()
Date: Wed, 18 Nov 2009 04:00:27 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0911180400040.25515@utopia.booyaka.com>
References: <1258506313-17115-1-git-send-email-khilman@deeprootsystems.com> <1258506313-17115-2-git-send-email-khilman@deeprootsystems.com> <1258506313-17115-3-git-send-email-khilman@deeprootsystems.com> <1258506313-17115-4-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-5-git-send-email-khilman@deeprootsystems.com> <1258506313-17115-6-git-send-email-khilman@deeprootsystems.com> <1258506313-17115-7-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38417 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202AbZKRLAV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 06:00:21 -0500
In-Reply-To: <1258506313-17115-7-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

Hi, 

On Tue, 17 Nov 2009, Kevin Hilman wrote:

> During suspend and resume, when omap_device deactivation and
> activation is happening, the timekeeping subsystem has likely already
> been suspended.  Thus getnstimeofday() will fail and trigger a WARN().
> 
> Use read_persistent_clock() instead of getnstimeofday() to avoid this.

Thanks, will queue in fixes series.

- Paul

> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/plat-omap/omap_device.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index 6a8b0ce..f6cdf1a 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -134,12 +134,12 @@ static int _omap_device_activate(struct omap_device *od, u8 ignore_lat)
>  		    (od->dev_wakeup_lat <= od->_dev_wakeup_lat_limit))
>  			break;
>  
> -		getnstimeofday(&a);
> +		read_persistent_clock(&a);
>  
>  		/* XXX check return code */
>  		odpl->activate_func(od);
>  
> -		getnstimeofday(&b);
> +		read_persistent_clock(&b);
>  
>  		c = timespec_sub(b, a);
>  		act_lat = timespec_to_ns(&c) * NSEC_PER_USEC;
> @@ -190,12 +190,12 @@ static int _omap_device_deactivate(struct omap_device *od, u8 ignore_lat)
>  		     od->_dev_wakeup_lat_limit))
>  			break;
>  
> -		getnstimeofday(&a);
> +		read_persistent_clock(&a);
>  
>  		/* XXX check return code */
>  		odpl->deactivate_func(od);
>  
> -		getnstimeofday(&b);
> +		read_persistent_clock(&b);
>  
>  		c = timespec_sub(b, a);
>  		deact_lat = timespec_to_ns(&c) * NSEC_PER_USEC;
> -- 
> 1.6.5.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
