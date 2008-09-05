From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix TWL4030 BCI compilation break
Date: Fri, 5 Sep 2008 11:21:25 -0700
Message-ID: <20080905182124.GR24202@atomide.com>
References: <FCCFB4CDC6E5564B9182F639FC3560870229E813AB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60408 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbYIESV1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 14:21:27 -0400
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870229E813AB@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>

* Pandita, Vikram <vikram.pandita@ti.com> [080821 08:53]:
> From: Vikram Pandita <vikram.pandita@ti.com>
> 
> Fix following compilation error when enabling CONFIG_TWL4030_BCI_BATTERY
> 
> drivers/power/twl4030_bci_battery.c: In function 'twl4030_bci_battery_probe':
> drivers/power/twl4030_bci_battery.c:911: error: dereferencing pointer to incomplete type

Pushing today.

Tony

> 
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> ---
>  drivers/power/twl4030_bci_battery.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: base-tony/drivers/power/twl4030_bci_battery.c
> ===================================================================
> --- base-tony.orig/drivers/power/twl4030_bci_battery.c	2008-08-21 15:06:47.000000000 +0530
> +++ base-tony/drivers/power/twl4030_bci_battery.c	2008-08-21 20:37:18.000000000 +0530
> @@ -23,7 +23,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/i2c/twl4030.h>
>  #include <linux/power_supply.h>
> -#include <asm/arch/bci.h>
> +#include <mach/bci.h>
>  #include <linux/i2c/twl4030-madc.h>
>  
>  #define T2_BATTERY_VOLT		0x04
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
