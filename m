From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] ARM: OMAP2+: enable LEDS class support
Date: Wed, 14 May 2014 08:10:05 -0700
Message-ID: <20140514151004.GA18463@atomide.com>
References: <1400067905-20786-1-git-send-email-javier@dowhile0.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58323 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbaENPKL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 May 2014 11:10:11 -0400
Content-Disposition: inline
In-Reply-To: <1400067905-20786-1-git-send-email-javier@dowhile0.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: AnilKumar Ch <anilkumar@ti.com>, linux-omap@vger.kernel.org

* Javier Martinez Canillas <javier@dowhile0.org> [140514 04:46]:
> Commit 5610b8ede ("ARM: OMAP2+: AM33XX: omap2plus_defconfig:
> Add support for few drivers") added support for different
> drivers including GPIO based leds.
> 
> But LEDS_GPIO config option depends on LEDS_CLASS which was
> not included so GPIO leds option is not selected. Adding as
> built-in option since the related options are built-in too.

Yeah this is already enabled with the PM related patches as
we can use the n900 debug LEDs to monitor for PM related
regressions. So patch "ARM: dts: Enable N900 keyboard sleep
leds by default" enables CONFIG_LEDS_CLASS, I've sent a pull
request for that few days ago for v3.16.

Regards,

Tony
 
> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
> ---
>  arch/arm/configs/omap2plus_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index a4e8d01..0a70170 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -239,6 +239,7 @@ CONFIG_SDIO_UART=y
>  CONFIG_MMC_OMAP=y
>  CONFIG_MMC_OMAP_HS=y
>  CONFIG_NEW_LEDS=y
> +CONFIG_LEDS_CLASS=y
>  CONFIG_LEDS_GPIO=y
>  CONFIG_LEDS_TRIGGERS=y
>  CONFIG_LEDS_TRIGGER_TIMER=y
> -- 
> 2.0.0.rc0
> 
