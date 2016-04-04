From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/6] usb: dwc3: omap: don't access DMA bits directly
Date: Mon, 4 Apr 2016 16:53:03 +0300
Message-ID: <570271BF.9040902@ti.com>
References: <1459585739-21204-1-git-send-email-felipe.balbi@linux.intel.com>
 <1459585739-21204-3-git-send-email-felipe.balbi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459585739-21204-3-git-send-email-felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbif-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>, Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>, Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Ivan T . Ivanov" <ivan.ivanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 04/02/2016 11:28 AM, Felipe Balbi wrote:
> Instead of having a static global just for
> initializing dma_mask directly, let's use
> dma_coerce_mask_and_coherent() for that.
> 
> Signed-off-by: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>   drivers/usb/dwc3/dwc3-omap.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
> index 22e9606d8e08..c219118bfda0 100644
> --- a/drivers/usb/dwc3/dwc3-omap.c
> +++ b/drivers/usb/dwc3/dwc3-omap.c
> @@ -331,8 +331,6 @@ static void dwc3_omap_disable_irqs(struct dwc3_omap *omap)
>   	dwc3_omap_write_irqmisc_clr(omap, reg);
>   }
>   
> -static u64 dwc3_omap_dma_mask = DMA_BIT_MASK(32);
> -
>   static int dwc3_omap_id_notifier(struct notifier_block *nb,
>   	unsigned long event, void *ptr)
>   {
> @@ -490,7 +488,7 @@ static int dwc3_omap_probe(struct platform_device *pdev)
>   	omap->irq	= irq;
>   	omap->base	= base;
>   	omap->vbus_reg	= vbus_reg;
> -	dev->dma_mask	= &dwc3_omap_dma_mask;
> +	dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));

I think, It'll be better to just remove DMA configuration code
from this driver and other drivers which support DT-boot mode only.



-- 
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
