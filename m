From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] usb: dwc3: omap: get rid of dma_status
Date: Wed, 27 Apr 2016 14:34:28 +0300
Message-ID: <5720A3C4.6030506@ti.com>
References: <1460384305-21256-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460384305-21256-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Felipe,

On 11/04/16 17:18, Roger Quadros wrote:
> dma_status bit flag is set but never really used
> so get rid of it.
> 
> Reported-by: Felipe Balbi <balbi@kernel.org>
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Gentle ping on this one for -next. Thanks.

cheers,
-roger

> ---
>  drivers/usb/dwc3/dwc3-omap.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
> index 55da2c7..890b8a6 100644
> --- a/drivers/usb/dwc3/dwc3-omap.c
> +++ b/drivers/usb/dwc3/dwc3-omap.c
> @@ -126,8 +126,6 @@ struct dwc3_omap {
>  	u32			debug_offset;
>  	u32			irq0_offset;
>  
> -	u32			dma_status:1;
> -
>  	struct extcon_dev	*edev;
>  	struct notifier_block	vbus_nb;
>  	struct notifier_block	id_nb;
> @@ -277,9 +275,6 @@ static irqreturn_t dwc3_omap_interrupt(int irq, void *_omap)
>  
>  	reg = dwc3_omap_read_irqmisc_status(omap);
>  
> -	if (reg & USBOTGSS_IRQMISC_DMADISABLECLR)
> -		omap->dma_status = false;
> -
>  	dwc3_omap_write_irqmisc_status(omap, reg);
>  
>  	reg = dwc3_omap_read_irq0_status(omap);
> @@ -504,7 +499,6 @@ static int dwc3_omap_probe(struct platform_device *pdev)
>  
>  	/* check the DMA Status */
>  	reg = dwc3_omap_readl(omap->base, USBOTGSS_SYSCONFIG);
> -	omap->dma_status = !!(reg & USBOTGSS_SYSCONFIG_DMADISABLE);
>  
>  	ret = devm_request_irq(dev, omap->irq, dwc3_omap_interrupt, 0,
>  			"dwc3-omap", omap);
> 
