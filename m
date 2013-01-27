From: Michael Grzeschik <mgr@pengutronix.de>
Subject: Re: [PATCH 1/3] usb: otg: nop: add dt support
Date: Sun, 27 Jan 2013 22:40:05 +0100
Message-ID: <20130127214005.GA18800@pengutronix.de>
References: <a1dd07e020850703ed5294db176ea1298d69a4ed.1348722156.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57817 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756328Ab3A0VkH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 27 Jan 2013 16:40:07 -0500
Content-Disposition: inline
In-Reply-To: <a1dd07e020850703ed5294db176ea1298d69a4ed.1348722156.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Ravi Babu <ravibabu@ti.com>

Hi,

On Thu, Sep 27, 2012 at 11:15:05AM +0530, Afzal Mohammed wrote:
> From: "B, Ravi" <ravibabu@ti.com>
> 
> Added device tree support for nop transceiver driver and updated the
> Documentation with device tree binding information for am33xx platform.
> 
> Signed-off-by: Ravi Babu <ravibabu@ti.com>
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
> 
> Hi,
> 
> This series is made over over Balbi's usb "master" branch.
> 
> It applies cleanly over "musb" branch too.
> 
> Regards
> Afzal
> 
>  Documentation/devicetree/bindings/usb/am33xx-usb.txt |  3 +++
>  drivers/usb/otg/nop-usb-xceiv.c                      | 10 ++++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/am33xx-usb.txt b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
> index ca8fa56..9782585 100644
> --- a/Documentation/devicetree/bindings/usb/am33xx-usb.txt
> +++ b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
> @@ -12,3 +12,6 @@ AM33XX MUSB GLUE
>     represents PERIPHERAL.
>   - power : Should be "250". This signifies the controller can supply upto
>     500mA when operating in host mode.
> +
> +NOP USB PHY
> + - compatible : Should be "nop-xceiv-usb"
> diff --git a/drivers/usb/otg/nop-usb-xceiv.c b/drivers/usb/otg/nop-usb-xceiv.c
> index e52e35e..64bfbe4 100644
> --- a/drivers/usb/otg/nop-usb-xceiv.c
> +++ b/drivers/usb/otg/nop-usb-xceiv.c
> @@ -27,6 +27,7 @@
>   */
>  
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/usb/otg.h>
> @@ -154,12 +155,21 @@ static int __devexit nop_usb_xceiv_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id nop_xceiv_id_table[] = {
> +	{ .compatible = "nop-xceiv-usb" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, nop_xceiv_id_table);
> +#endif
> +
>  static struct platform_driver nop_usb_xceiv_driver = {
>  	.probe		= nop_usb_xceiv_probe,
>  	.remove		= __devexit_p(nop_usb_xceiv_remove),
>  	.driver		= {
>  		.name	= "nop_usb_xceiv",
>  		.owner	= THIS_MODULE,
> +		.of_match_table = of_match_ptr(nop_xceiv_id_table),
>  	},
>  };
>  
> -- 
> 1.7.12
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

What happend to that patch? It did not show up in any new series. Is it
queued anywhere?

Regards,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
