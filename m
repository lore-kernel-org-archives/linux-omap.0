From: Tony Lindgren <tony@atomide.com>
Subject: Re: ARM: OMAP3: Overo: Fix EHCI initialization
Date: Mon, 21 Sep 2009 18:29:39 -0700
Message-ID: <20090922012939.GK27699@atomide.com>
References: <5e088bd90908161430ka6c04f5m1cbf5e0df949f83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60510 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbZIVB3p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Sep 2009 21:29:45 -0400
Content-Disposition: inline
In-Reply-To: <5e088bd90908161430ka6c04f5m1cbf5e0df949f83@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* Steve Sakoman <sakoman@gmail.com> [090816 14:30]:
> Overo uses port 2, not port 1.  Use OVERO_GPIO_USBH_NRESET rather than
> hard coded value
> 
> Note: this alone will not give functional EHCI.  Also required is:
> 
> [PATCH 4/9] ehci: fix phy_reset init in ehci probe
> from Ajay Kumar Gupta

I've piled up all the ehci patches into ehci branch while waiting for
somebody to start sending these to the linux-usb list. That branch
is now merged into the master branch for testing.

The patch "ehci: portwise configurations" changed the usb_ehci_init()
interface, but looks like it did not include the overo config..

Care to update your pending overo and beagle ehci patches for that?

It might take a little while for the mirrors to get updated, as I
just pushed the updated branches. 

Regards,

Tony
 
> Signed-off-by: Steve Sakoman <steve@sakoman.com>
> ---
>  arch/arm/mach-omap2/board-overo.c |   11 ++---------
>  1 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-overo.c
> b/arch/arm/mach-omap2/board-overo.c
> index a9d7c2e..a220a54 100644
> --- a/arch/arm/mach-omap2/board-overo.c
> +++ b/arch/arm/mach-omap2/board-overo.c
> @@ -394,7 +394,8 @@ static void __init overo_init(void)
>  	omap_serial_init(&overo_uart_config);
>  	overo_flash_init();
>  	usb_musb_init();
> -	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, false, true, 183, -EINVAL);
> +	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, false, true,
> +			-EINVAL, OVERO_GPIO_USBH_NRESET);
>  	overo_ads7846_init();
>  	overo_init_smsc911x();
> 
> @@ -437,14 +438,6 @@ static void __init overo_init(void)
>  	else
>  		printk(KERN_ERR "could not obtain gpio for "
>  					"OVERO_GPIO_USBH_CPEN\n");
> -
> -	if ((gpio_request(OVERO_GPIO_USBH_NRESET,
> -			  "OVERO_GPIO_USBH_NRESET") == 0) &&
> -	    (gpio_direction_output(OVERO_GPIO_USBH_NRESET, 1) == 0))
> -		gpio_export(OVERO_GPIO_USBH_NRESET, 0);
> -	else
> -		printk(KERN_ERR "could not obtain gpio for "
> -					"OVERO_GPIO_USBH_NRESET\n");
>  }
> 
>  static void __init overo_map_io(void)
> -- 
> 1.6.0.4
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
