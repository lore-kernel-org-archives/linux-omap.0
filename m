From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAPDSS: TFP410: use gpio_set_value_cansleep
Date: Wed, 9 May 2012 15:14:48 -0700
Message-ID: <20120509221447.GY5088@atomide.com>
References: <1336601288-27848-1-git-send-email-Russ.Dill@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62543 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932487Ab2EIWOu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 18:14:50 -0400
Content-Disposition: inline
In-Reply-To: <1336601288-27848-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

* Russ Dill <Russ.Dill@ti.com> [120509 15:12]:
> The Beagleboard xM gpio used for TFP410 powerdown is connected through
> an I2C attached chip which means setting the GPIO can sleep. Code that
> calls tfp410_power_on/off holds a mutex, so sleeping should be fine.

What's the error without this patch? Or just no display?

Just wondering if it's safe to merge Tomi's clean up series to
arm-soc tree..

Tony

 
> Signed-off-by: Russ Dill <Russ.Dill@ti.com>
> ---
>  drivers/video/omap2/displays/panel-tfp410.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/omap2/displays/panel-tfp410.c b/drivers/video/omap2/displays/panel-tfp410.c
> index 52637fa..1266520 100644
> --- a/drivers/video/omap2/displays/panel-tfp410.c
> +++ b/drivers/video/omap2/displays/panel-tfp410.c
> @@ -68,7 +68,7 @@ static int tfp410_power_on(struct omap_dss_device *dssdev)
>  		goto err0;
>  
>  	if (gpio_is_valid(ddata->pd_gpio))
> -		gpio_set_value(ddata->pd_gpio, 1);
> +		gpio_set_value_cansleep(ddata->pd_gpio, 1);
>  
>  	return 0;
>  err0:
> @@ -83,7 +83,7 @@ static void tfp410_power_off(struct omap_dss_device *dssdev)
>  		return;
>  
>  	if (gpio_is_valid(ddata->pd_gpio))
> -		gpio_set_value(ddata->pd_gpio, 0);
> +		gpio_set_value_cansleep(ddata->pd_gpio, 0);
>  
>  	omapdss_dpi_display_disable(dssdev);
>  }
> -- 
> 1.7.10
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
