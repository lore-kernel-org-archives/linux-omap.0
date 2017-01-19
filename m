From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 1/3] usb: musb: dma: Add a DMA completion platform
 callback
Date: Thu, 19 Jan 2017 13:38:17 +0300
Message-ID: <fb051107-b4cf-a14b-fc3b-447fd6644bc9@cogentembedded.com>
References: <20170119100659.11370-1-abailon@baylibre.com>
 <20170119100659.11370-2-abailon@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170119100659.11370-2-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, b-liu-l0cyMroinI0@public.gmane.org
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello!

On 1/19/2017 1:06 PM, Alexandre Bailon wrote:

> Currently, the CPPI 4.1 driver is not completely generic and
> only work on dsps. This is because of IRQ management.

    Works. DSPS.

> Add a callback to dma_controller that could be invoked on DMA completion
> to acknodlege the IRQ.

     Acknowledge.

> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
[...]
> diff --git a/drivers/usb/musb/musb_dma.h b/drivers/usb/musb/musb_dma.h
> index 46357e1..8bea0cd 100644
> --- a/drivers/usb/musb/musb_dma.h
> +++ b/drivers/usb/musb/musb_dma.h
> @@ -181,10 +181,13 @@ dma_channel_status(struct dma_channel *c)
>   * @channel_release: call this to release a DMA channel
>   * @channel_abort: call this to abort a pending DMA transaction,
>   *	returning it to FREE (but allocated) state
> + * @platform_dma_callback: invoked on DMA completion, useful to run platform

    It's called just dma_callback below.

> + *	code such IRQ acknowledgment.
>   *
>   * Controllers manage dma channels.
>   */
>  struct dma_controller {
> +	struct musb *musb;

    You forgot to document this above.

>  	struct dma_channel	*(*channel_alloc)(struct dma_controller *,
>  					struct musb_hw_ep *, u8 is_tx);
>  	void			(*channel_release)(struct dma_channel *);
> @@ -196,6 +199,7 @@ struct dma_controller {
>  	int			(*is_compatible)(struct dma_channel *channel,
>  							u16 maxpacket,
>  							void *buf, u32 length);
> +	void			(*dma_callback)(struct dma_controller *);
>  };
>
>  /* called after channel_program(), may indicate a fault */

MBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
