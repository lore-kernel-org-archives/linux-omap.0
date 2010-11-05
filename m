From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2: Devkit8000: Fix mmc regulator failure
Date: Fri, 5 Nov 2010 12:12:47 -0700
Message-ID: <20101105191247.GR9264@atomide.com>
References: <1288651691-14914-1-git-send-email-weber@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51003 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753403Ab0KETNP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 15:13:15 -0400
Content-Disposition: inline
In-Reply-To: <1288651691-14914-1-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Weber <weber@corscience.de>
Cc: Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

* Thomas Weber <weber@corscience.de> [101101 14:38]:
> This patch fixes the following error:
> 
> >regulator: VMMC1: 1850 <--> 3150 mV at 3000 mV normal
> standby
> >twl_reg twl_reg.6: can't register VMMC1, -22
> >twl_reg: probe of twl_reg.6 failed with error -22

Adding this into omap-fixes.

Tony
 
> Signed-off-by: Thomas Weber <weber@corscience.de>
> ---
>  arch/arm/mach-omap2/board-devkit8000.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
> index 067f437..53ac762 100644
> --- a/arch/arm/mach-omap2/board-devkit8000.c
> +++ b/arch/arm/mach-omap2/board-devkit8000.c
> @@ -242,9 +242,6 @@ static int devkit8000_twl_gpio_setup(struct device *dev,
>  	mmc[0].gpio_cd = gpio + 0;
>  	omap2_hsmmc_init(mmc);
>  
> -	/* link regulators to MMC adapters */
> -	devkit8000_vmmc1_supply.dev = mmc[0].dev;
> -
>  	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
>  	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
>  
> -- 
> 1.7.3.2
> 
