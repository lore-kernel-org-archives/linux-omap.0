From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] usb: musb: adding support for registering nop xceiv
Date: Tue, 13 Jan 2009 00:29:49 +0200
Message-ID: <20090112222946.GN25493@frodo>
References: <1231412036-7371-1-git-send-email-ajay.gupta@ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:55391 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759424AbZALW36 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2009 17:29:58 -0500
Content-Disposition: inline
In-Reply-To: <1231412036-7371-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-omap@vger.kernel.org, david-b@pacbell.net, felipe.balbi@nokia.com

On Thu, Jan 08, 2009 at 04:23:56PM +0530, Ajay Kumar Gupta wrote:
> Adding support for registering nop usb transceiver for musb
> platforms. Tested with OMAP35xx EVM having OTG phy ISP1504
> which is autonomous and doesn't require any phy programming.
> 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>

Tony, if Dave is ok with the nop-xceiv, we can apply this to l-o and
people who doesn't use twl4030/tlw5030 xceiv will have to select this
driver.

> ---
>  arch/arm/mach-omap2/usb-musb.c |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
> index 61c5709..c202256 100644
> --- a/arch/arm/mach-omap2/usb-musb.c
> +++ b/arch/arm/mach-omap2/usb-musb.c
> @@ -155,10 +155,29 @@ static struct platform_device musb_device = {
>  };
>  #endif
>  
> +#ifdef CONFIG_NOP_USB_XCEIV
> +static u64 nop_xceiv_dmamask = DMA_32BIT_MASK;
> +
> +static struct platform_device nop_xceiv_device = {
> +	.name		= "nop_usb_xceiv",
> +	.id		= -1,
> +	.dev = {
> +		.dma_mask		= &nop_xceiv_dmamask,
> +		.coherent_dma_mask	= DMA_32BIT_MASK,
> +		.platform_data		= NULL,
> +	},
> +};
> +#endif
>  
>  void __init usb_musb_init(void)
>  {
>  #ifdef CONFIG_USB_MUSB_SOC
> +#ifdef CONFIG_NOP_USB_XCEIV
> +	if (platform_device_register(&nop_xceiv_device) < 0) {
> +		printk(KERN_ERR "Unable to register NOP-XCEIV device\n");
> +		return;
> +	}
> +#endif
>  	if (platform_device_register(&musb_device) < 0) {
>  		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
>  		return;
> -- 
> 1.5.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
