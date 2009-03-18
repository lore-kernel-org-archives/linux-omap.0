From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2: possible division by 0
Date: Wed, 18 Mar 2009 15:03:22 -0700
Message-ID: <20090318220321.GH29546@atomide.com>
References: <49BF8CEC.1000901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58779 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758000AbZCRWDT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Mar 2009 18:03:19 -0400
Content-Disposition: inline
In-Reply-To: <49BF8CEC.1000901@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: rmk+kernel@arm.linux.org.uk, linux-omap@vger.kernel.org, Linux-arm <linux-arm-kernel@lists.arm.linux.org.uk>

* Roel Kluin <roel.kluin@gmail.com> [090317 04:50]:
> In linus' git tree the functions can be found at:
> vi arch/arm/mach-omap2/usb-tusb6010.c +200	- tusb6010_platform_retime()
> vi arch/arm/mach-omap2/gpmc.c +94		- gpmc_get_fclk_period()
> vi arch/arm/mach-omap2/usb-tusb6010.c +53	- tusb_set_async_mode()
> vi arch/arm/mach-omap2/usb-tusb6010.c +111	- tusb_set_sync_mode()
> 
> is -ENODEV appropriate when sysclk_ps == 0?
> 
> This was found by code analysis, please review.
> ------------------------------>8-------------8<---------------------------------
> gpmc_get_fclk_period() may return 0 when gpmc_l3_clk is not enabled. This is
> not checked in tusb6010_platform_retime() nor in tusb_set_async_mode() it
> seems. In tusb_set_sync_mode() this may result in a division by zero.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>

Looks like a valid fix to me. I'll add it to omap-fixes queue.
To me it sounds like there's no urgent need to get this integrated
as we're missing most of the omap2 PM still.

Tony

> ---
> diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
> index 15e5090..8df55f4 100644
> --- a/arch/arm/mach-omap2/usb-tusb6010.c
> +++ b/arch/arm/mach-omap2/usb-tusb6010.c
> @@ -187,7 +187,7 @@ int tusb6010_platform_retime(unsigned is_refclk)
>  	unsigned	sysclk_ps;
>  	int		status;
>  
> -	if (!refclk_psec)
> +	if (!refclk_psec || sysclk_ps == 0)
>  		return -ENODEV;
>  
>  	sysclk_ps = is_refclk ? refclk_psec : TUSB6010_OSCCLK_60;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
