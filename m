From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] musb: Kill board specific pinmux from driver file
Date: Fri, 9 Jul 2010 11:15:33 +0300
Message-ID: <20100709081532.GH24913@atomide.com>
References: <1278587095-16978-1-git-send-email-ajay.gupta@ti.com>
 <1278587095-16978-2-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63027 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754638Ab0GIIPk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jul 2010 04:15:40 -0400
Content-Disposition: inline
In-Reply-To: <1278587095-16978-2-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, felipe.balbi@nokia.com, gregkh@suse.de, Anand Gadiyar <gadiyar@ti.com>

* Ajay Kumar Gupta <ajay.gupta@ti.com> [100708 13:59]:
> From: Anand Gadiyar <gadiyar@ti.com>
> 
> This pin-muxing is best done in the board files. The driver should
> not do this explicitly.
> 
> Also, this code causes a warning to be thrown when OMAP2430 and OMAP3/4
> support are enabled in the same kernel.
> 
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  drivers/usb/musb/omap2430.c |    6 ------
>  1 files changed, 0 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index e06d65e..2111a24 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -32,8 +32,6 @@
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  
> -#include <plat/mux.h>
> -
>  #include "musb_core.h"
>  #include "omap2430.h"
>  
> @@ -194,10 +192,6 @@ int __init musb_platform_init(struct musb *musb, void *board_data)
>  	u32 l;
>  	struct omap_musb_board_data *data = board_data;
>  
> -#if defined(CONFIG_ARCH_OMAP2430)
> -	omap_cfg_reg(AE5_2430_USB0HS_STP);
> -#endif
> -
>  	/* We require some kind of external transceiver, hooked
>  	 * up through ULPI.  TWL4030-family PMICs include one,
>  	 * which needs a driver, drivers aren't always needed.
> -- 
> 1.6.2.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
