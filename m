From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 4/5] usb: musb: musb_cppi41: Workaround DMA stall
 issue during teardown
Date: Thu, 19 Jan 2017 08:56:46 -0800
Message-ID: <20170119165646.GV7403@atomide.com>
References: <20170119140835.18981-1-abailon@baylibre.com>
 <20170119140835.18981-5-abailon@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170119140835.18981-5-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: b-liu-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> [170119 06:09]:
> The DMA may hung up if a teardown is initiated while an endpoint is still
> active (Advisory 2.3.27 of DA8xx errata).
> To workaround this issue, add a delay before to initiate the teardown.
> 
> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/usb/musb/da8xx.c       | 2 +-
>  drivers/usb/musb/musb_core.h   | 1 +
>  drivers/usb/musb/musb_cppi41.c | 4 ++++
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
> index 5f50a78..8c9850c 100644
> --- a/drivers/usb/musb/da8xx.c
> +++ b/drivers/usb/musb/da8xx.c
> @@ -483,7 +483,7 @@ da8xx_dma_controller_create(struct musb *musb, void __iomem *base)
>  #endif
>  
>  static const struct musb_platform_ops da8xx_ops = {
> -	.quirks		= MUSB_INDEXED_EP | MUSB_DMA_CPPI41,
> +	.quirks		= MUSB_INDEXED_EP | MUSB_DMA_CPPI41 | MUSB_DA8XX,
>  	.init		= da8xx_musb_init,
>  	.exit		= da8xx_musb_exit,
>  
> diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
> index ade902e..d129278 100644
> --- a/drivers/usb/musb/musb_core.h
> +++ b/drivers/usb/musb/musb_core.h
> @@ -172,6 +172,7 @@ struct musb_io;
>   */
>  struct musb_platform_ops {
>  
> +#define MUSB_DA8XX		BIT(7)
>  #define MUSB_DMA_UX500		BIT(6)
>  #define MUSB_DMA_CPPI41		BIT(5)
>  #define MUSB_DMA_CPPI		BIT(4)
> diff --git a/drivers/usb/musb/musb_cppi41.c b/drivers/usb/musb/musb_cppi41.c
> index 1fe7eae..d371d05 100644
> --- a/drivers/usb/musb/musb_cppi41.c
> +++ b/drivers/usb/musb/musb_cppi41.c
> @@ -554,6 +554,10 @@ static int cppi41_dma_channel_abort(struct dma_channel *channel)
>  		}
>  	}
>  
> +	/* DA8xx Advisory 2.3.27: wait 250 ms before to start the teardown */
> +	if (musb->io.quirks & MUSB_DA8XX)
> +		mdelay(250);
> +
>  	tdbit = 1 << cppi41_channel->port_num;
>  	if (is_tx)
>  		tdbit <<= 16;

How about replace the do while loop calling  dmaengine_terminate_all() with
deferred work doing that?

That way it's more generic as it seems there's no hurry doing that
after the musb registers are cleared. That would also allow getting rid of
the two current udelay() calls there that also seems nasty.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
