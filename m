From: Michael =?ISO-8859-1?Q?B=FCsch?= <mb@bu3sch.de>
Subject: Re: [PATCH RFC] n810 USB: Initialize USB-FS
Date: Wed, 16 Mar 2011 22:55:47 +0100
Message-ID: <1300312547.9635.2.camel@maggie>
References: <1299694841.1911.23.camel@marge>
	 (sfid-20110309_192052_106509_14C74848)
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:52518 "EHLO
	bu3sch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751143Ab1CPVzy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Mar 2011 17:55:54 -0400
In-Reply-To: <1299694841.1911.23.camel@marge> (sfid-20110309_192052_106509_14C74848)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Wed, 2011-03-09 at 19:20 +0100, Michael Buesch wrote: 
> The "omap_otg" platform device has to be registered in order
> to get USB working on the n810.
> I currently do this by calling the USB-FS init, which in turn
> registers the omap_otg platform device.
> 
> The omap_usb_config structure values were copied from n770 code, so
> I have no idea whether this is correct or not.
> 
> However, with all the patches I just sent (including this one),
> I get USB working properly on the n810.
> 
> Not-yet-signed-off-by: Michael Buesch <mb@bu3sch.de>
> 
> ---
> 
> Index: linux-2.6.38-rc7/arch/arm/mach-omap2/board-n8x0.c
> ===================================================================
> --- linux-2.6.38-rc7.orig/arch/arm/mach-omap2/board-n8x0.c	2011-03-09 18:47:07.749508720 +0100
> +++ linux-2.6.38-rc7/arch/arm/mach-omap2/board-n8x0.c	2011-03-09 18:59:14.355835051 +0100
> @@ -40,6 +40,7 @@
>  #include <plat/serial.h>
>  #include <plat/cbus.h>
>  #include <plat/gpio-switch.h>
> +#include <plat/usb.h>
>  
>  #include "mux.h"
>  
> @@ -395,6 +396,14 @@ static struct musb_hdrc_platform_data tu
>  	.config		= &musb_config,
>  };
>  
> +static struct omap_usb_config n8x0_omap_usb_config __initdata = {
> +	.otg		= 1,
> +	.register_host	= 1,
> +	.register_dev	= 1,
> +	.hmc_mode	= 16,
> +	.pins[0]	= 6,
> +};
> +
>  static void __init n8x0_usb_init(void)
>  {
>  	int ret = 0;
> @@ -417,6 +426,8 @@ static void __init n8x0_usb_init(void)
>  	if (ret != 0)
>  		goto err;
>  
> +	omap2_usbfs_init(&n8x0_omap_usb_config);
> +
>  	printk(announce);
>  
>  	return;
> 

Is there any news on this one?
If not, I'd suggest merging this in its current form, even if
we're unsure whether it's 100% correct, because it actually
makes the USB work on the n810.

If you merge this, you can add a
Signed-off-by: Michael Buesch <mb@bu3sch.de>

-- 
Greetings Michael.

