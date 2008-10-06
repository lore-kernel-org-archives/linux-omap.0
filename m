From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM:OMAP2: Add OVERO_GPIO_BT_XGATE to Overo board init
Date: Mon, 6 Oct 2008 11:45:04 +0300
Message-ID: <20081006084503.GJ14042@atomide.com>
References: <5e088bd90809132218g79bb0da8uf1a7befee988263e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49771 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbYJFImI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 04:42:08 -0400
Content-Disposition: inline
In-Reply-To: <5e088bd90809132218g79bb0da8uf1a7befee988263e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Steve Sakoman <sakoman@gmail.com> [080914 08:18]:
> Drive OVERO_GPIO_BT_XGATE low rather than relying on the pin mux pull
> down set by U-boot

Pushing today. Will also merge into the minimal board support patch
for mainline kernel.

Tony

> 
> Signed-off-by: Steve Sakoman <steve@sakoman.com>
> ---
>  arch/arm/mach-omap2/board-overo.c             |    6 ++++++
>  arch/arm/plat-omap/include/mach/board-overo.h |    1 +
>  2 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-overo.c
> b/arch/arm/mach-omap2/board-overo.c
> index 396ec33..5c23b4d 100644
> --- a/arch/arm/mach-omap2/board-overo.c
> +++ b/arch/arm/mach-omap2/board-overo.c
> @@ -207,6 +207,12 @@ static void __init overo_init(void)
>  		printk(KERN_ERR "could not obtain gpio for OVERO_GPIO_W2W_NRESET\n");
>  	}
> 
> +	if ((gpio_request(OVERO_GPIO_BT_XGATE, "OVERO_GPIO_BT_XGATE") == 0) &&
> +	    (gpio_direction_output(OVERO_GPIO_BT_XGATE, 0) == 0))
> +		gpio_export(OVERO_GPIO_BT_XGATE, 0);
> +	else
> +		printk(KERN_ERR "could not obtain gpio for OVERO_GPIO_BT_XGATE\n");
> +
>  	if ((gpio_request(OVERO_GPIO_BT_NRESET, "OVERO_GPIO_BT_NRESET") == 0) &&
>  	    (gpio_direction_output(OVERO_GPIO_BT_NRESET, 1) == 0)) {
>  		gpio_export(OVERO_GPIO_BT_NRESET, 0);
> diff --git a/arch/arm/plat-omap/include/mach/board-overo.h
> b/arch/arm/plat-omap/include/mach/board-overo.h
> index b70f22a..7ecae66 100644
> --- a/arch/arm/plat-omap/include/mach/board-overo.h
> +++ b/arch/arm/plat-omap/include/mach/board-overo.h
> @@ -16,6 +16,7 @@
>  #ifndef __ASM_ARCH_OVERO_H
>  #define __ASM_ARCH_OVERO_H
> 
> +#define OVERO_GPIO_BT_XGATE	15
>  #define OVERO_GPIO_W2W_NRESET	16
>  #define OVERO_GPIO_BT_NRESET	164
>  #define OVERO_GPIO_USBH_CPEN	168
> -- 
> 1.5.4.5
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
