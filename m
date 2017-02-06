From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v5 5/6] usb: musb: cppi_dma: Clean up tusb_omap_dma
 structure
Date: Mon, 6 Feb 2017 10:13:47 +0200
Message-ID: <be359fa3-0754-ff68-5f60-564df168fc83@ti.com>
References: <20170125101709.15696-1-abailon@baylibre.com>
 <20170125101709.15696-6-abailon@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170125101709.15696-6-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On 01/25/2017 12:17 PM, Alexandre Bailon wrote:
> A pointer to musb is now present in the dma_controller structure.
> Remove the one present in tusb_omap_dma structure.

the subject line should be: usb: musb: tusb6010_omap: ...

> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/usb/musb/tusb6010_omap.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
> index e6959cc..8b43c4b 100644
> --- a/drivers/usb/musb/tusb6010_omap.c
> +++ b/drivers/usb/musb/tusb6010_omap.c
> @@ -56,7 +56,6 @@ struct tusb_omap_dma_ch {
>  
>  struct tusb_omap_dma {
>  	struct dma_controller		controller;
> -	struct musb			*musb;
>  	void __iomem			*tbase;
>  
>  	int				ch;
> @@ -497,7 +496,7 @@ tusb_omap_dma_allocate(struct dma_controller *c,
>  	u32			reg;
>  
>  	tusb_dma = container_of(c, struct tusb_omap_dma, controller);
> -	musb = tusb_dma->musb;
> +	musb = tusb_dma->controller.musb;
>  	tbase = musb->ctrl_base;
>  
>  	reg = musb_readl(tbase, TUSB_DMA_INT_MASK);
> @@ -534,7 +533,7 @@ tusb_omap_dma_allocate(struct dma_controller *c,
>  		dev_name = "TUSB receive";
>  	}
>  
> -	chdat->musb = tusb_dma->musb;
> +	chdat->musb = tusb_dma->controller.musb;
>  	chdat->tbase = tusb_dma->tbase;
>  	chdat->hw_ep = hw_ep;
>  	chdat->epnum = hw_ep->epnum;
> @@ -667,7 +666,7 @@ tusb_dma_controller_create(struct musb *musb, void __iomem *base)
>  	if (!tusb_dma)
>  		goto out;
>  
> -	tusb_dma->musb = musb;
> +	tusb_dma->controller.musb = musb;
>  	tusb_dma->tbase = musb->ctrl_base;
>  
>  	tusb_dma->ch = -1;
> 

- Péter
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
