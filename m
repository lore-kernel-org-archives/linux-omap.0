From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 5/6] usb: dwc3: core: don't access DMA bits directly
Date: Mon, 4 Apr 2016 16:53:07 +0300
Message-ID: <570271C3.9030707@ti.com>
References: <1459585739-21204-1-git-send-email-felipe.balbi@linux.intel.com>
 <1459585739-21204-6-git-send-email-felipe.balbi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459585739-21204-6-git-send-email-felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbif-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>, Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>, Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Ivan T . Ivanov" <ivan.ivanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 04/02/2016 11:28 AM, Felipe Balbi wrote:
> instead of manually copying DMA bits from parent
> device, we should let DMA API do its job.
> 
> Signed-off-by: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>   drivers/usb/dwc3/core.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 17fd81447c9f..d601de20e1cd 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -981,11 +981,7 @@ static int dwc3_probe(struct platform_device *pdev)
>   
>   	spin_lock_init(&dwc->lock);
>   
> -	if (!dev->dma_mask) {
> -		dev->dma_mask = dev->parent->dma_mask;
> -		dev->dma_parms = dev->parent->dma_parms;

Here, and in most of other patches you've dropped dma_parms copying -
Is it expected?


> -		dma_set_coherent_mask(dev, dev->parent->coherent_dma_mask);
> -	}
> +	dma_coerce_mask_and_coherent(dev, dma_get_mask(dev->parent));


No. Above if case should stay, otherwise, already valid, DMA configuration 
might be overwritten:

commit 19bacdc925055f020ad36da04bd72dc8b28637b8
Author: Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date:   Wed Sep 24 11:00:38 2014 +0300

    usb: dwc3: core: only setting the dma_mask when needed
    
    If the probe drivers have already set the dma_mask, not
    replacing the value.
    
    Signed-off-by: Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
    Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>


-- 
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
