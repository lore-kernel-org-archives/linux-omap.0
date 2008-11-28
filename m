From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 3/3] musb: Remvoing twl4030 dependency for OMAP3EVM MUSB
Date: Fri, 28 Nov 2008 08:46:15 +0200
Message-ID: <20081128064615.GK23308@gandalf.research.nokia.com>
References: <1227850104-16166-1-git-send-email-mani.pillai@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:61042 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbYK1Gqp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2008 01:46:45 -0500
Content-Disposition: inline
In-Reply-To: <1227850104-16166-1-git-send-email-mani.pillai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Manikandan Pillai <mani.pillai@ti.com>
Cc: linux-omap@vger.kernel.org

On Fri, Nov 28, 2008 at 10:58:24AM +0530, ext Manikandan Pillai wrote:
> MUSB on OMAP3EVM uses ISP1504 phy and doesn't need twl4030.
> OMAP35xx Beagle board MUSB uses twl4030 phy thus uses it and
> it also sets xceiv global field using otg_set_transceiver().
> As OMAP3EVM MUSB doesn't require twl4030 so otg_set_transceiver()
> part is being done in this patch.
> 
> This is a temporary patch and the updated patch will come soon.

musb patches should go to linux-usb mailing list.

> Signed-off-by: Manikandan Pillai <mani.pillai@ti.com>
> ---
>  drivers/usb/musb/omap2430.c |   53 +++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index 03fc864..9aa4518 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -215,13 +215,60 @@ void musb_platform_set_mode(struct musb *musb, u8 musb_mode)
>  	}
>  }
>  
> +#ifdef CONFIG_MACH_OMAP3EVM
> +static int omap3_evm_otg_set_host(struct otg_transceiver *xceiv,
> +			 struct usb_bus *host)
> +{
> +	if (!xceiv)
> +		return -ENODEV;
> +
> +	if (!host) {
> +		xceiv->host = NULL;
> +		return -ENODEV;
> +	}
> +	DBG(2, "xceiv in host\n");
> +	xceiv->host = host;
> +	return 0;
> +}
> +static int omap3_evm_otg_set_peripheral(struct otg_transceiver *xceiv,
> +		struct usb_gadget *gadget)
> +{
> +	if (!xceiv)
> +		return -ENODEV;
> +
> +	if (!gadget) {
> +		xceiv->gadget = NULL;
> +		return -ENODEV;
> +	}
> +	DBG(2, "xceiv in peripheral\n");
> +	xceiv->gadget = gadget;
> +	xceiv->state = OTG_STATE_B_IDLE;
> +	return 0;
> +
> +}
> +static int omap3_evm_otg_set_suspend(struct otg_transceiver *x, int suspend)
> +{
> +	DBG(2, "xceiv suspend\n");
> +	return 0;
> +}
> +#endif

sorry, no. I won't add ifdefs to any of those files since it breaks
multiomap support.

> +
>  int __init musb_platform_init(struct musb *musb)
>  {
> -	struct otg_transceiver *x = otg_get_transceiver();
> +	struct otg_transceiver *x;
>  	u32 l;
>  
>  #if defined(CONFIG_ARCH_OMAP2430)

what about 3430 ?

>  	omap_cfg_reg(AE5_2430_USB0HS_STP);
> +	x = otg_get_transceiver();
> +#elif defined(CONFIG_MACH_OMAP3EVM)
> +	x = kzalloc(sizeof *x, GFP_KERNEL);
> +	if (!x)
> +		return 0;
> +	x->set_host = omap3_evm_otg_set_host;
> +	x->set_peripheral = omap3_evm_otg_set_peripheral;
> +	x->set_suspend = omap3_evm_otg_set_suspend;
> +	otg_set_transceiver(x);
>  #endif
>  
>  	musb->xceiv = *x;
> @@ -323,6 +370,8 @@ int musb_platform_exit(struct musb *musb)
>  
>  	clk_put(musb->clock);
>  	musb->clock = 0;
> -
> +#if defined(CONFIG_MACH_OMAP3EVM)
> +	kfree(&musb->xceiv);
> +#endif

no.

I could even live with if (machine_is_xxx()) code, although I don't want
to. But ifdefs are an automatic NAK.

-- 
balbi
