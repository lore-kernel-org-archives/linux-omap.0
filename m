From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH V3 13/19] OMAP3+: SR: Reuse sr_[start|stop]_vddautocomp functions
Date: Thu, 17 Mar 2011 10:25:30 -0700
Message-ID: <87r5a57j79.fsf@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
	<1299338962-5602-14-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:49695 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751566Ab1CQRZe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 13:25:34 -0400
Received: by mail-iw0-f174.google.com with SMTP id 34so3834796iwn.33
        for <linux-omap@vger.kernel.org>; Thu, 17 Mar 2011 10:25:33 -0700 (PDT)
In-Reply-To: <1299338962-5602-14-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Sat, 5 Mar 2011 20:59:16 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>, Jarkko Nikula <jhnikula@gmail.com>

Nishanth Menon <nm@ti.com> writes:

> From: Jarkko Nikula <jhnikula@gmail.com>
>
> sr_start_vddautocomp and sr_stop_autocomp functions can be reused from
> omap_sr_enable, omap_sr_disable and omap_sr_disable_reset_volt and by
> adding one additional argument sr_stop_autocomp. This allows us to have
> a single point where SR enable and disable operations are controlled from.
>
> [nm@ti.com: synced it up with class start/stop as well. autocomp flag
>  should only be disabled when SR is disabled for that domain]
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> ---
> Side note: Jarkko has'nt seen this rev as I just finished the rebase and tested
> but adding his signed-off anyways as he is primary contributor to the idea
> and the patch.

This one looks fine, but will wait to apply it since it depends on the
previous one which needs some minor fixups.

Kevin

>  arch/arm/mach-omap2/smartreflex.c |   66 +++++++++++++------------------------
>  1 files changed, 23 insertions(+), 43 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index 592e9a0..d839fa6 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -211,8 +211,12 @@ static void sr_set_regfields(struct omap_sr *sr)
>  	}
>  }
>  
> -static void sr_start_vddautocomp(struct omap_sr *sr)
> +static void sr_start_vddautocomp(struct omap_sr *sr, bool class_start)
>  {
> +	int r;
> +	if (sr->autocomp_active)
> +		return;
> +
>  	if (!sr_class || !(sr_class->enable) || !(sr_class->configure)) {
>  		dev_warn(&sr->pdev->dev,
>  			"%s: smartreflex class driver not registered\n",
> @@ -220,19 +224,24 @@ static void sr_start_vddautocomp(struct omap_sr *sr)
>  		return;
>  	}
>  
> -	if (sr_class->start &&
> +	if (class_start && sr_class->start &&
>  	    sr_class->start(sr->voltdm, sr_class->class_priv_data)) {
>  		dev_err(&sr->pdev->dev,
>  			"%s: SRClass initialization failed\n", __func__);
>  		return;
>  	}
>  
> -	if (!sr_class->enable(sr->voltdm))
> +	r = sr_class->enable(sr->voltdm);
> +	if (!r && class_start)
>  		sr->autocomp_active = true;
>  }
>  
> -static void sr_stop_vddautocomp(struct omap_sr *sr)
> +static void sr_stop_vddautocomp(struct omap_sr *sr, bool class_stop,
> +		int is_volt_reset)
>  {
> +	if (!sr->autocomp_active)
> +		return;
> +
>  	if (!sr_class || !(sr_class->disable)) {
>  		dev_warn(&sr->pdev->dev,
>  			"%s: smartreflex class driver not registered\n",
> @@ -240,15 +249,13 @@ static void sr_stop_vddautocomp(struct omap_sr *sr)
>  		return;
>  	}
>  
> -	if (sr->autocomp_active) {
> -		sr_class->disable(sr->voltdm, 1);
> +	sr_class->disable(sr->voltdm, is_volt_reset);
> +	if (class_stop) {
>  		if (sr_class->stop &&
> -		    sr_class->stop(sr->voltdm,
> -			    sr_class->class_priv_data)) {
> +		    sr_class->stop(sr->voltdm, sr_class->class_priv_data))
>  			dev_err(&sr->pdev->dev,
>  				"%s: SR[%d]Class deinitialization failed\n",
>  				__func__, sr->srid);
> -		}
>  		sr->autocomp_active = false;
>  	}
>  }
> @@ -285,7 +292,7 @@ static int sr_late_init(struct omap_sr *sr_info)
>  	}
>  
>  	if (pdata && pdata->enable_on_init)
> -		sr_start_vddautocomp(sr_info);
> +		sr_start_vddautocomp(sr_info, true);
>  
>  	return ret;
>  
> @@ -693,16 +700,7 @@ void omap_sr_enable(struct voltagedomain *voltdm)
>  		return;
>  	}
>  
> -	if (!sr->autocomp_active)
> -		return;
> -
> -	if (!sr_class || !(sr_class->enable) || !(sr_class->configure)) {
> -		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not"
> -			"registered\n", __func__);
> -		return;
> -	}
> -
> -	sr_class->enable(voltdm);
> +	sr_start_vddautocomp(sr, false);
>  }
>  
>  /**
> @@ -726,16 +724,7 @@ void omap_sr_disable(struct voltagedomain *voltdm)
>  		return;
>  	}
>  
> -	if (!sr->autocomp_active)
> -		return;
> -
> -	if (!sr_class || !(sr_class->disable)) {
> -		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not"
> -			"registered\n", __func__);
> -		return;
> -	}
> -
> -	sr_class->disable(voltdm, 0);
> +	sr_stop_vddautocomp(sr, false, 0);
>  }
>  
>  /**
> @@ -759,16 +748,7 @@ void omap_sr_disable_reset_volt(struct voltagedomain *voltdm)
>  		return;
>  	}
>  
> -	if (!sr->autocomp_active)
> -		return;
> -
> -	if (!sr_class || !(sr_class->disable)) {
> -		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not"
> -			"registered\n", __func__);
> -		return;
> -	}
> -
> -	sr_class->disable(voltdm, 1);
> +	sr_stop_vddautocomp(sr, false, 1);
>  }
>  
>  /**
> @@ -823,9 +803,9 @@ static int omap_sr_autocomp_store(void *data, u64 val)
>  	/* control enable/disable only if there is a delta in value */
>  	if (sr_info->autocomp_active != val) {
>  		if (!val)
> -			sr_stop_vddautocomp(sr_info);
> +			sr_stop_vddautocomp(sr_info, true, 1);
>  		else
> -			sr_start_vddautocomp(sr_info);
> +			sr_start_vddautocomp(sr_info, true);
>  	}
>  
>  	return 0;
> @@ -987,7 +967,7 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
>  	}
>  
>  	if (sr_info->autocomp_active)
> -		sr_stop_vddautocomp(sr_info);
> +		sr_stop_vddautocomp(sr_info, true, 1);
>  
>  	list_del(&sr_info->node);
>  	iounmap(sr_info->base);
