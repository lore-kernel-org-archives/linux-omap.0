From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] usb: musb: Size 1 dma in transfers won't complete
 with cpp41
Date: Wed, 18 Jan 2017 21:41:30 -0600
Message-ID: <20170119034130.GA22265@uda0271908>
References: <20170119022959.30793-1-tony@atomide.com>
 <20170119022959.30793-3-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170119022959.30793-3-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 18, 2017 at 06:29:59PM -0800, Tony Lindgren wrote:
> At least with the cppi41 dma, size 1 in dma transfers will just wait

In which case do you see the size 1 transfer? using testusb?

> until the device is disconnected. This causes timeouts in cppi41 dma
> runtime PM.
> 
> Also the initial size 8 transfers take about 200ms to complete when
> plugging a USB mass storage device to a hub. But we probably want to
> keep those to avoid using PIO.
> 
> Fix the issue by adding a quirk for cppi41 and skip size 1 in dma if
> set.

It is fine to bypass dma for size 1 transfers, due to the dma setup
overhead. But I'd like to know the test case to understand why it hangs.

> 
> Note that additional cpp41 patches are needed to avoid error -115
> messages, but that can be applied separately.
> 
> Fixes: fdea2d09b997 ("dmaengine: cppi41: Add basic PM runtime support")
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/usb/musb/musb_cppi41.c |  1 +
>  drivers/usb/musb/musb_dma.h    |  3 +++
>  drivers/usb/musb/musb_host.c   | 16 +++++++++++++++-
>  3 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/musb/musb_cppi41.c b/drivers/usb/musb/musb_cppi41.c
> --- a/drivers/usb/musb/musb_cppi41.c
> +++ b/drivers/usb/musb/musb_cppi41.c
> @@ -695,6 +695,7 @@ cppi41_dma_controller_create(struct musb *musb, void __iomem *base)
>  	controller->controller.channel_program = cppi41_dma_channel_program;
>  	controller->controller.channel_abort = cppi41_dma_channel_abort;
>  	controller->controller.is_compatible = cppi41_is_compatible;
> +	controller->controller.quirks = MUSB_DMA_QUIRK_CPPI41_IN;
>  
>  	ret = cppi41_dma_controller_start(controller);
>  	if (ret)
> diff --git a/drivers/usb/musb/musb_dma.h b/drivers/usb/musb/musb_dma.h
> --- a/drivers/usb/musb/musb_dma.h
> +++ b/drivers/usb/musb/musb_dma.h
> @@ -171,6 +171,8 @@ dma_channel_status(struct dma_channel *c)
>  	return (is_dma_capable() && c) ? c->status : MUSB_DMA_STATUS_UNKNOWN;
>  }
>  
> +#define MUSB_DMA_QUIRK_CPPI41_IN	BIT(0)
> +
>  /**
>   * struct dma_controller - A DMA Controller.
>   * @start: call this to start a DMA controller;
> @@ -196,6 +198,7 @@ struct dma_controller {
>  	int			(*is_compatible)(struct dma_channel *channel,
>  							u16 maxpacket,
>  							void *buf, u32 length);
> +	unsigned int quirks;
>  };
>  
>  /* called after channel_program(), may indicate a fault */
> diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
> --- a/drivers/usb/musb/musb_host.c
> +++ b/drivers/usb/musb/musb_host.c
> @@ -743,6 +743,8 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
>  
>  	musb_ep_select(mbase, epnum);
>  
> +	dma_controller = musb->dma_controller;
> +
>  	if (is_out && !len) {
>  		use_dma = 0;
>  		csr = musb_readw(epio, MUSB_TXCSR);
> @@ -751,8 +753,20 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
>  		hw_ep->tx_channel = NULL;
>  	}
>  
> +	/*
> +	 * At least cppi41 in dma will just hang with size of 1 until the
> +	 * device is disconnected.
> +	 */
> +	if (!is_out && dma_controller &&
> +	    (dma_controller->quirks & MUSB_DMA_QUIRK_CPPI41_IN)) {

Forget to add size constraint here?

Regards,
-Bin.

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
