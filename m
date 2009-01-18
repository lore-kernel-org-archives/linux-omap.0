From: Tony Lindgren <tony@atomide.com>
Subject: Re: Beagle defconfig broken in mainline
Date: Sun, 18 Jan 2009 14:11:46 +0200
Message-ID: <20090118121141.GE7976@atomide.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02E6815EF6@dbde02.ent.ti.com> <200901180357.19705.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54204 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763480AbZARMLu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 18 Jan 2009 07:11:50 -0500
Content-Disposition: inline
In-Reply-To: <200901180357.19705.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* David Brownell <david-b@pacbell.net> [090118 13:57]:
> From: David Brownell <dbrownell@users.sourceforge.net>
> Subject: arch/arm/mach-omap2/board-omap3beagle.c buildfix
> 
>   CC      arch/arm/mach-omap2/board-omap3beagle.o
> arch/arm/mach-omap2/board-omap3beagle.c: In function 'beagle_twl_gpio_setup':
> arch/arm/mach-omap2/board-omap3beagle.c:132: error: 'TWL4030_GPIO_MAX' undeclared (first use in this function)
> ... many errors ...
> arch/arm/mach-omap2/board-omap3beagle.c:308: error: 'gpio' undeclared (first use in this function)
> make[1]: *** [arch/arm/mach-omap2/board-omap3beagle.o] Error 1

Similar patch (and other compile fixes) is already queued up via
omap-fixes branch, should get into the mainline within next few days.

Tony

> Reported-by: Anand Gadiyar <gadiyar@ti.com>
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
> Against MAINLINE 2.6.29-rc2
> 
>  arch/arm/mach-omap2/board-omap3beagle.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -28,6 +28,8 @@
>  #include <linux/mtd/partitions.h>
>  #include <linux/mtd/nand.h>
>  
> +#include <linux/i2c/twl4030.h>
> +
>  #include <mach/hardware.h>
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> @@ -120,6 +122,9 @@ static int beagle_twl_gpio_setup(struct 
>  		unsigned gpio, unsigned ngpio)
>  {
>  	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
> +	omap_cfg_reg(AH8_34XX_GPIO29);
> +	mmc[0].gpio_cd = gpio + 0;
> +	twl4030_mmc_init(mmc);
>  
>  	/* REVISIT: need ehci-omap hooks for external VBUS
>  	 * power switch and overcurrent detect
> @@ -304,10 +309,6 @@ static void __init omap3_beagle_init(voi
>  	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
>  	omap_serial_init();
>  
> -	omap_cfg_reg(AH8_34XX_GPIO29);
> -	mmc[0].gpio_cd = gpio + 0;
> -	twl4030_mmc_init(mmc);
> -
>  	omap_cfg_reg(J25_34XX_GPIO170);
>  	gpio_request(170, "DVI_nPD");
>  	/* REVISIT leave DVI powered down until it's needed ... */
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
