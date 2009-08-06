From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] OMAP3: PM: Add function omap_device_find_pdev to
 omap_device layer
Date: Thu, 6 Aug 2009 07:39:07 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908060738249.22103@utopia.booyaka.com>
References: <1248694087-7177-1-git-send-email-ranjithl@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57551 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755372AbZHFNjI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 09:39:08 -0400
In-Reply-To: <1248694087-7177-1-git-send-email-ranjithl@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ranjith Lohithakshan <ranjithl@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com

Hi Ranjith,

On Mon, 27 Jul 2009, Ranjith Lohithakshan wrote:

> This patch adds a function, omap_device_find_pdev, which will get the
> omap_device associated with the platform_device provided. This is currently
> required by the SRF layer for setting max_dev_wakeup_lat and getting
> dev_context_loss_count.
> 
> Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>

Looks good to me, I will pull this into omap_device.


- Paul

> ---
>  arch/arm/plat-omap/include/mach/omap_device.h |    2 +-
>  arch/arm/plat-omap/omap_device.c              |   22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/mach/omap_device.h b/arch/arm/plat-omap/include/mach/omap_device.h
> index bd0e136..5874af2 100644
> --- a/arch/arm/plat-omap/include/mach/omap_device.h
> +++ b/arch/arm/plat-omap/include/mach/omap_device.h
> @@ -136,6 +136,6 @@ struct omap_device_pm_latency {
>  	int (*activate_func)(struct omap_device *od);
>  };
>  
> -
> +struct omap_device *omap_device_find_pdev(struct platform_device *pdev);
>  #endif
>  
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index 2c409fc..b947faf 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -685,3 +685,25 @@ int omap_device_enable_clocks(struct omap_device *od)
>  	/* XXX pass along return value here? */
>  	return 0;
>  }
> +
> +/**
> + * omap_device_find_pdev - look up an OMAP module by platform_device
> + * @pdev: platform_device to find
> + *
> + * Finds a registered OMAP module by the platform_device associated
> + * with it in the omap_device structure. Returns a pointer to the
> + * struct omap_device if found, or NULL otherwise.
> + */
> +
> +struct omap_device *omap_device_find_pdev(struct platform_device *pdev)
> +{
> +	struct omap_device *od;
> +
> +	if (!pdev)
> +		return NULL;
> +
> +	od = _find_by_pdev(pdev);
> +
> +	return od;
> +}
> +
> -- 
> 1.6.2.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
