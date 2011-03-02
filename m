From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC 3/3] omap3+: sr: Reuse sr_[start|stop]_vddautocomp functions
Date: Wed, 02 Mar 2011 22:29:09 +0530
Message-ID: <4D6E775D.7040107@ti.com>
References: <1299081445-27938-1-git-send-email-jhnikula@gmail.com> <1299081445-27938-4-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:48787 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753457Ab1CBRAA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 12:00:00 -0500
Received: by mail-fx0-f50.google.com with SMTP id 18so207427fxm.23
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 08:59:57 -0800 (PST)
In-Reply-To: <1299081445-27938-4-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>

Jarkko Nikula wrote, on 03/02/2011 09:27 PM:
> sr_start_vddautocomp and sr_stop_autocomp functions can be reused from
> omap_sr_enable, omap_sr_disable and omap_sr_disable_reset_volt and by
> adding one additional argument sr_stop_autocomp.
>
> Signed-off-by: Jarkko Nikula<jhnikula@gmail.com>
> ---
>   arch/arm/mach-omap2/smartreflex.c |   41 ++++++------------------------------
>   1 files changed, 7 insertions(+), 34 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index 11741d8..7e6002f 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -227,7 +227,7 @@ static void sr_start_vddautocomp(struct omap_sr *sr)
>   		sr->autocomp_active = true;
>   }
>
> -static void sr_stop_vddautocomp(struct omap_sr *sr)
> +static void sr_stop_vddautocomp(struct omap_sr *sr, int is_volt_reset)
>   {
>   	if (!sr->autocomp_active)
>   		return;
> @@ -239,7 +239,7 @@ static void sr_stop_vddautocomp(struct omap_sr *sr)
>   		return;
>   	}
>
> -	if (!sr_class->disable(sr->voltdm, 1))
> +	if (!sr_class->disable(sr->voltdm, is_volt_reset))
>   		sr->autocomp_active = false;
>   }
>
> @@ -681,16 +681,7 @@ void omap_sr_enable(struct voltagedomain *voltdm)
>   		return;
>   	}
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
> +	sr_start_vddautocomp(sr);
>   }
>
>   /**
> @@ -714,16 +705,7 @@ void omap_sr_disable(struct voltagedomain *voltdm)
>   		return;
>   	}
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
> +	sr_stop_vddautocomp(sr, 0);
>   }
>
>   /**
> @@ -747,16 +729,7 @@ void omap_sr_disable_reset_volt(struct voltagedomain *voltdm)
>   		return;
>   	}
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
> +	sr_stop_vddautocomp(sr, 1);
>   }
>
>   /**
> @@ -809,7 +782,7 @@ static int omap_sr_autocomp_store(void *data, u64 val)
>   	}
>
>   	if (!val)
> -		sr_stop_vddautocomp(sr_info);
> +		sr_stop_vddautocomp(sr_info, 1);
>   	else
>   		sr_start_vddautocomp(sr_info);
>
> @@ -976,7 +949,7 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
>   	}
>
>   	if (sr_info->autocomp_active)
> -		sr_stop_vddautocomp(sr_info);
> +		sr_stop_vddautocomp(sr_info, 1);
>
>   	list_del(&sr_info->node);
>   	iounmap(sr_info->base);

Looks like a nice cleanup to me.

if the motivation of patch 1/3 is to do this cleanup, I am altogether 
for it (lesser code == lesser bugs ;) ). btw, this should not impact 
class1.5 either - core sr.c sequencing has not been modified in sr1.5 :)

Depending on Kevin's views, either you or I or both of us can rebase 
depending on whose ever series gets pulled in first.. (either should be 
a very minimal effort).

-- 
Regards,
Nishanth Menon
