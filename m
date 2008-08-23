From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2: Fix SPI driver failure on 2420 when
	running multi-omap config
Date: Sat, 23 Aug 2008 16:17:57 -0700
Message-ID: <20080823231756.GJ4713@atomide.com>
References: <1219306810-12232-1-git-send-email-jarkko.nikula@nokia.com> <1219306810-12232-2-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56030 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562AbYHWXR7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 Aug 2008 19:17:59 -0400
Content-Disposition: inline
In-Reply-To: <1219306810-12232-2-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@nokia.com> [080821 01:21]:
> SPI driver will do unhandled fault on OMAP2420 if trying to probe
> non-existing SPI busses. Register those additional busses runtime only
> for cpus having them.

Pushing today.

Tony

> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> ---
>  arch/arm/mach-omap2/devices.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index cc5c294..bd49a0f 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -255,10 +255,12 @@ static void omap_init_mcspi(void)
>  	platform_device_register(&omap2_mcspi1);
>  	platform_device_register(&omap2_mcspi2);
>  #if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
> -	platform_device_register(&omap2_mcspi3);
> +	if (cpu_is_omap2430() || cpu_is_omap343x())
> +		platform_device_register(&omap2_mcspi3);
>  #endif
>  #ifdef CONFIG_ARCH_OMAP3
> -	platform_device_register(&omap2_mcspi4);
> +	if (cpu_is_omap343x())
> +		platform_device_register(&omap2_mcspi4);
>  #endif
>  }
>  
> -- 
> 1.5.6.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
