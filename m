From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] initialize gpio debounce register
Date: Fri, 19 Jun 2009 11:05:39 -0700
Message-ID: <87r5xgw13g.fsf@deeprootsystems.com>
References: <af3ea28a0906190907q718f3ac7o122bf85db2f14322@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:54593 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbZFSSFj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Jun 2009 14:05:39 -0400
Received: by wf-out-1314.google.com with SMTP id 26so915482wfd.4
        for <linux-omap@vger.kernel.org>; Fri, 19 Jun 2009 11:05:42 -0700 (PDT)
In-Reply-To: <af3ea28a0906190907q718f3ac7o122bf85db2f14322@mail.gmail.com> (ye janboe's message of "Fri\, 19 Jun 2009 11\:07\:02 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ye janboe <janboe.ye@gmail.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

ye janboe <janboe.ye@gmail.com> writes:

> Hi,
> some bootloader may initialize debounce register and this will make
> dbclk not consist with the debounce register after linux kernel boot
> up.
>
> From 8f97e5b50e50627e9e4b40f5d4fba09d750aceb1 Mon Sep 17 00:00:00 2001
> From: janboe <janboe.ye@gmail.com>
> Date: Fri, 19 Jun 2009 10:56:02 -0500
> Subject: [PATCH] initialize gpio debounce register
>
> Signed-off-by: janboe <janboe.ye@gmail.com>

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

Tony, this should go into -fixes.

Kevin

> ---
>  arch/arm/plat-omap/gpio.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 7fd89ba..26b387c 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -1585,6 +1585,7 @@ static int __init _omap_gpio_init(void)
>  			__raw_writel(0x00000000, bank->base + OMAP24XX_GPIO_IRQENABLE1);
>  			__raw_writel(0xffffffff, bank->base + OMAP24XX_GPIO_IRQSTATUS1);
>  			__raw_writew(0x0015, bank->base + OMAP24XX_GPIO_SYSCONFIG);
> +			__raw_writel(0x00000000, bank->base + OMAP24XX_GPIO_DEBOUNCE_EN);
>
>  			/* Initialize interface clock ungated, module enabled */
>  			__raw_writel(0, bank->base + OMAP24XX_GPIO_CTRL);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
