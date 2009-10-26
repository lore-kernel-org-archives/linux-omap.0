From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] [OMAP] GPIO Module is reset during initialization
Date: Mon, 26 Oct 2009 13:29:03 -0700
Message-ID: <87hbtlc31s.fsf@deeprootsystems.com>
References: <1256313329-24996-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:35867 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbZJZU3A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Oct 2009 16:29:00 -0400
Received: by pxi10 with SMTP id 10so34774pxi.33
        for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 13:29:05 -0700 (PDT)
In-Reply-To: <1256313329-24996-1-git-send-email-charu@ti.com> (charu@ti.com's message of "Fri\, 23 Oct 2009 21\:25\:29 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: charu@ti.com
Cc: linux-omap@vger.kernel.org

charu@ti.com writes:

> From: Charulatha V <charu@ti.com>
>
> During initialization, GPIO module is reset using soft reset bit
> of SYSCONFIG register
>
> Signed-off-by: Charulatha V <charu@ti.com>
> ---
>  arch/arm/plat-omap/gpio.c |   12 +++++++++++-
>  1 files changed, 11 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 2304a5d..4579650 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -21,6 +21,7 @@
>  #include <linux/err.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
> +#include <linux/delay.h>
>  
>  #include <mach/hardware.h>
>  #include <asm/irq.h>
> @@ -1670,7 +1671,7 @@ static int __init _omap_gpio_init(void)
>  	}
>  #endif
>  	for (i = 0; i < gpio_bank_count; i++) {
> -		int j, gpio_count = 16;
> +		int j, gpio_count = 16, attempt = 0;
>  
>  		bank = &gpio_bank[i];
>  		spin_lock_init(&bank->lock);
> @@ -1698,6 +1699,15 @@ static int __init _omap_gpio_init(void)
>  			static const u32 non_wakeup_gpios[] = {
>  				0xe203ffc0, 0x08700040
>  			};
> +
> +		/* Software Reset of GPIO module */
> +		__raw_writel(0x0002, bank->base	+ OMAP24XX_GPIO_SYSCONFIG);
> +		while (((__raw_readl(bank->base + OMAP24XX_GPIO_SYSSTATUS)
> +					& 0x1) == 0) && attempt < 5) {
> +			udelay(1);
> +			attempt++;
> +		}
> +

NAK.  Would rather see an omap_hwmod added for GPIO, in which case we
get the reset for free.

Kevin
