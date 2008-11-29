From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 11/11] ARM: OMAP: Switch ohci-omap to gpio_request/free calls
Date: Fri, 28 Nov 2008 17:35:36 -0800
Message-ID: <200811281735.37174.david-b@pacbell.net>
References: <20081129010728.12337.8217.stgit@localhost> <20081129011104.12337.37890.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:48592 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753214AbYK2Bfj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Nov 2008 20:35:39 -0500
In-Reply-To: <20081129011104.12337.37890.stgit@localhost>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@nokia.com>, linux-usb@vger.kernel.org

On Friday 28 November 2008, Tony Lindgren wrote:
> From: Jarkko Nikula <jarkko.nikula@nokia.com>
> 
> Switch to gpio_request/free calls
> 
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: David Brownell <dbrownell@users.sourceforge.net>

Best if this merges through the ARM tree, with other similar
changes, since ISTR this won't apply as-is through the USB tree.


> ---
>  drivers/usb/host/ohci-omap.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
> index 22f6d19..4bbddb7 100644
> --- a/drivers/usb/host/ohci-omap.c
> +++ b/drivers/usb/host/ohci-omap.c
> @@ -18,6 +18,7 @@
>  #include <linux/jiffies.h>
>  #include <linux/platform_device.h>
>  #include <linux/clk.h>
> +#include <linux/gpio.h>
>  
>  #include <mach/hardware.h>
>  #include <asm/io.h>
> @@ -25,7 +26,6 @@
>  
>  #include <mach/mux.h>
>  #include <mach/irqs.h>
> -#include <mach/gpio.h>
>  #include <mach/fpga.h>
>  #include <mach/usb.h>
>  
> @@ -254,7 +254,7 @@ static int ohci_omap_init(struct usb_hcd *hcd)
>  
>  			/* gpio9 for overcurrent detction */
>  			omap_cfg_reg(W8_1610_GPIO9);
> -			omap_request_gpio(9);
> +			gpio_request(9, "OHCI overcurrent");
>  			gpio_direction_input(9);
>  
>  			/* for paranoia's sake:  disable USB.PUEN */
> @@ -407,7 +407,7 @@ usb_hcd_omap_remove (struct usb_hcd *hcd, struct platform_device *pdev)
>  		put_device(ohci->transceiver->dev);
>  	}
>  	if (machine_is_omap_osk())
> -		omap_free_gpio(9);
> +		gpio_free(9);
>  	iounmap(hcd->regs);
>  	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
>  	usb_put_hcd(hcd);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


