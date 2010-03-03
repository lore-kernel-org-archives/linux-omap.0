From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 12/16] OMAP3: PM: Support for enabling smartreflex autocompensation by default.
Date: Tue, 02 Mar 2010 16:48:51 -0800
Message-ID: <87d3zmqlfw.fsf@deeprootsystems.com>
References: <1267003757-22456-1-git-send-email-thara@ti.com>
	<1267003757-22456-2-git-send-email-thara@ti.com>
	<1267003757-22456-3-git-send-email-thara@ti.com>
	<1267003757-22456-4-git-send-email-thara@ti.com>
	<1267003757-22456-5-git-send-email-thara@ti.com>
	<1267003757-22456-6-git-send-email-thara@ti.com>
	<1267003757-22456-7-git-send-email-thara@ti.com>
	<1267003757-22456-8-git-send-email-thara@ti.com>
	<1267003757-22456-9-git-send-email-thara@ti.com>
	<1267003757-22456-10-git-send-email-thara@ti.com>
	<1267003757-22456-11-git-send-email-thara@ti.com>
	<1267003757-22456-12-git-send-email-thara@ti.com>
	<1267003757-22456-13-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51404 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758460Ab0CCAsz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Mar 2010 19:48:55 -0500
Received: by gwb15 with SMTP id 15so462309gwb.19
        for <linux-omap@vger.kernel.org>; Tue, 02 Mar 2010 16:48:54 -0800 (PST)
In-Reply-To: <1267003757-22456-13-git-send-email-thara@ti.com> (Thara Gopinath's message of "Wed\, 24 Feb 2010 14\:59\:13 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch adds support to pdata enable smartreflex autocompenstion
> during init based on init_enable flag passed as pdata.
>
> This patch also adds enabling of autocompensation by
> default (setting init_enable flag to true) in case of ES3.1
> OMAP3430 chip. In the current implementation
> this step is kept in smartreflex.c itself.Later an API can be added
> so that the decision to enable autocompensation by default
> can be passed from the corresponding board files.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/mach-omap2/smartreflex.c |   32 ++++++++++++++++++++++++++++----
>  1 files changed, 28 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index 96dc76b..085dd05 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -477,9 +477,15 @@ void omap_sr_register_class(struct omap_smartreflex_class_data *class_data)
>  
>  	sr_class = class_data;
>  	/*
> -	 * Register the interrupt handler incase requested by the class driver
> +	 * Check if any SR module needs to be enabled as part of init.
> +	 * In case the probe for the SR module is not yet called the enable
> +	 * will not be done here but will be done in the probe whenever
> +	 * it gets called. Also register the interrupt handler incase
> +	 * requested by the class driver.
>  	 */
>  	list_for_each_entry(sr_info, &sr_list, node) {
> +		struct omap_smartreflex_data *pdata =
> +				sr_info->pdev->dev.platform_data;
>  		if (sr_class->class_type == SR_CLASS2 &&
>  				sr_class->notify_flags && sr_info->irq) {
>  			char name[SMARTREFLEX_NAME_LEN];
> @@ -496,6 +502,8 @@ void omap_sr_register_class(struct omap_smartreflex_class_data *class_data)
>  				return;
>  			}
>  		}
> +		if (pdata->init_enable)
> +			sr_start_vddautocomap(sr_info->srid);

I think this flag is better named enable_on_init.  

>  	}
>  }
>  
> @@ -562,11 +570,15 @@ static int __devinit omap_smartreflex_probe(struct platform_device *pdev)
>  	list_add(&sr_info->node, &sr_list);
>  
>  	/*
> -	 * Register interrrupt handler if smartreflex class driver is already
> -	 * registered and has requested for interrupts. This will be attempted
> +	 * Enable the smartreflex module if init_enable flag is set and
> +	 * if the class driver is registered. Also Register interrrupt handler
> +	 * if smartreflex class driver is already registered and has
> +	 * requested for interrupts. This will be attempted
>  	 * in the class driver register again if it does not happen here.
>  	 */
>  	if (sr_class) {
> +		struct omap_smartreflex_data *pdata = pdev->dev.platform_data;
> +
>  		if (sr_class->class_type == SR_CLASS2 &&
>  				sr_class->notify_flags && sr_info->irq) {
>  			sprintf(name, "sr%d", sr_info->srid);
> @@ -580,6 +592,8 @@ static int __devinit omap_smartreflex_probe(struct platform_device *pdev)
>  				return ret;
>  			}
>  		}
> +		if (pdata->init_enable)
> +			sr_start_vddautocomap(sr_info->srid);
>  	}

As with the duplicate request_irq() in previous patch, I don't follow
why it's the start is needed twice.  

Is it to handle the case where no class driver is installed?

>  
>  	pr_info("SmartReflex driver initialized\n");
> @@ -782,7 +796,17 @@ static int __init omap_devinit_smartreflex(void)
>  		if (WARN_ON(!sr_data))
>  			return -ENOMEM;
>  
> -		sr_data->init_enable = false;
> +		/*
> +		 * Enable the SR module by default if it is a OMAP3430
> +		 * ES3.1 chip

You should add a comment about why: starting with ES3.1, efuse values can be trusted?

> +		 */
> +		if (cpu_is_omap343x()) {
> +			if (omap_rev() == OMAP3430_REV_ES3_1)
> +				sr_data->init_enable = true;
> +			else
> +				sr_data->init_enable = false;
> +		} else
> +			sr_data->init_enable = false;
>  		sr_data->device_enable = omap_device_enable;
>  		sr_data->device_shutdown = omap_device_shutdown;
>  		sr_data->device_idle = omap_device_idle;

Kevin
