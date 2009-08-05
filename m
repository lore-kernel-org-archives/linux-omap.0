From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/2] OMAP3: PM: Add function omap_device_find_pdev to omap_device layer
Date: Wed, 05 Aug 2009 15:30:25 -0700
Message-ID: <87prb999mm.fsf@deeprootsystems.com>
References: <1248694087-7177-1-git-send-email-ranjithl@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:39448 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685AbZHEWa3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 18:30:29 -0400
Received: by wa-out-1112.google.com with SMTP id j5so66671wah.21
        for <linux-omap@vger.kernel.org>; Wed, 05 Aug 2009 15:30:28 -0700 (PDT)
In-Reply-To: <1248694087-7177-1-git-send-email-ranjithl@ti.com> (Ranjith Lohithakshan's message of "Mon\, 27 Jul 2009 16\:58\:07 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ranjith Lohithakshan <ranjithl@ti.com>
Cc: linux-omap@vger.kernel.org

Ranjith Lohithakshan <ranjithl@ti.com> writes:

> This patch adds a function, omap_device_find_pdev, which will get the
> omap_device associated with the platform_device provided. This is currently
> required by the SRF layer for setting max_dev_wakeup_lat and getting
> dev_context_loss_count.
>
> Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>

Thanks, appying this to PM branch for now to get SRF working again but
Paul will review/comment/merge into his omap_device branch for
upstream.

Kevin


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
