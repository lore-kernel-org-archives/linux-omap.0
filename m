From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/6] usb: gadget: omap_udc: remove useless print
Date: Fri, 1 Jun 2012 04:01:24 -0700
Message-ID: <20120601110123.GK12766@atomide.com>
References: <1338293761-9457-1-git-send-email-balbi@ti.com>
 <1338293761-9457-3-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1338293761-9457-3-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [120529 05:22]:
> that print isn't needed at all. Remove it
> and move the use_dma reinitialization to
> probe() function.
> 
> Note that ideally we would drop all
> cpu_is_* and machine_is_* checks from
> this driver instead. Later patches will
> come to get rid of those.
> 
> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/usb/gadget/omap_udc.c |   13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
> index aa2d174..5e7b891 100644
> --- a/drivers/usb/gadget/omap_udc.c
> +++ b/drivers/usb/gadget/omap_udc.c
> @@ -2800,6 +2800,9 @@ static int __init omap_udc_probe(struct platform_device *pdev)
>  	struct clk		*dc_clk = NULL;
>  	struct clk		*hhc_clk = NULL;
>  
> +	if (cpu_is_omap7xx())
> +		use_dma = 0;
> +
>  	/* NOTE:  "knows" the order of the resources! */
>  	if (!request_mem_region(pdev->resource[0].start,
>  			pdev->resource[0].end - pdev->resource[0].start + 1,

I think this would break omap_udc for 7xx as it then tries to use
DMA as USED_MA is set by default?

Setting use_dma = 0 twice is unncessary though :)

Regards,

Tony


> @@ -3096,16 +3099,6 @@ static struct platform_driver udc_driver = {
>  
>  static int __init udc_init(void)
>  {
> -	/* Disable DMA for omap7xx -- it doesn't work right. */
> -	if (cpu_is_omap7xx())
> -		use_dma = 0;
> -
> -	INFO("%s, version: " DRIVER_VERSION
> -#ifdef	USE_ISO
> -		" (iso)"
> -#endif
> -		"%s\n", driver_desc,
> -		use_dma ?  " (dma)" : "");
>  	return platform_driver_probe(&udc_driver, omap_udc_probe);
>  }
>  module_init(udc_init);
> -- 
> 1.7.10.2
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
