From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] ARM: OMAP: Cocci spatch "ptr_ret.spatch"
Date: Mon, 03 Jun 2013 14:17:50 -0700
Message-ID: <878v2qlwqp.fsf@linaro.org>
References: <1370079884.29224.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:59316 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754261Ab3FCVRy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jun 2013 17:17:54 -0400
Received: by mail-pa0-f52.google.com with SMTP id bg2so1061841pad.11
        for <linux-omap@vger.kernel.org>; Mon, 03 Jun 2013 14:17:53 -0700 (PDT)
In-Reply-To: <1370079884.29224.16.camel@localhost.localdomain> (Thomas Meyer's
	message of "Sat, 01 Jun 2013 11:44:44 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Meyer <thomas@m3y3r.de>
Cc: tony@atomide.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

Thomas Meyer <thomas@m3y3r.de> writes:

> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>

Could use a changelog, but otherwise

Acked-by: Kevin Hilman <khilman@linaro.org>

> ---
>
> diff -u -p a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -66,7 +66,7 @@ static int __init omap3_l3_init(void)
>  
>  	WARN(IS_ERR(pdev), "could not build omap_device for %s\n", oh_name);
>  
> -	return IS_ERR(pdev) ? PTR_ERR(pdev) : 0;
> +	return PTR_RET(pdev);
>  }
>  omap_postcore_initcall(omap3_l3_init);
>  
> @@ -100,7 +100,7 @@ static int __init omap4_l3_init(void)
>  
>  	WARN(IS_ERR(pdev), "could not build omap_device for %s\n", oh_name);
>  
> -	return IS_ERR(pdev) ? PTR_ERR(pdev) : 0;
> +	return PTR_RET(pdev);
>  }
>  omap_postcore_initcall(omap4_l3_init);
>  
> diff -u -p a/arch/arm/mach-omap2/fb.c b/arch/arm/mach-omap2/fb.c
> --- a/arch/arm/mach-omap2/fb.c
> +++ b/arch/arm/mach-omap2/fb.c
> @@ -83,10 +83,7 @@ static int __init omap_init_vrfb(void)
>  	pdev = platform_device_register_resndata(NULL, "omapvrfb", -1,
>  			res, num_res, NULL, 0);
>  
> -	if (IS_ERR(pdev))
> -		return PTR_ERR(pdev);
> -	else
> -		return 0;
> +	return PTR_RET(pdev);
>  }
>  
>  omap_arch_initcall(omap_init_vrfb);
> diff -u -p a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -1678,7 +1678,7 @@ static int __init omap_gpmc_init(void)
>  	pdev = omap_device_build(DEVICE_NAME, -1, oh, NULL, 0);
>  	WARN(IS_ERR(pdev), "could not build omap_device for %s\n", oh_name);
>  
> -	return IS_ERR(pdev) ? PTR_ERR(pdev) : 0;
> +	return PTR_RET(pdev);
>  }
>  omap_postcore_initcall(omap_gpmc_init);
>  
> diff -u -p a/arch/arm/mach-omap2/pmu.c b/arch/arm/mach-omap2/pmu.c
> --- a/arch/arm/mach-omap2/pmu.c
> +++ b/arch/arm/mach-omap2/pmu.c
> @@ -54,10 +54,7 @@ static int __init omap2_init_pmu(unsigne
>  	WARN(IS_ERR(omap_pmu_dev), "Can't build omap_device for %s.\n",
>  	     dev_name);
>  
> -	if (IS_ERR(omap_pmu_dev))
> -		return PTR_ERR(omap_pmu_dev);
> -
> -	return 0;
> +	return PTR_RET(omap_pmu_dev);
>  }
>  
>  static int __init omap_init_pmu(void)
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
