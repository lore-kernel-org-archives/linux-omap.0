From: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC/PATCH 24/32] usb: gadget: s3c-hsotg: let udc-core manage gadget->dev
Date: Thu, 24 Jan 2013 20:00:05 +0100
Message-ID: <5963888.Uco7z1jaqo@flatron>
References: <1359042370-4358-1-git-send-email-balbi@ti.com> <1359042370-4358-25-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1359042370-4358-25-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alexander.shishkin-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dahlmann.thomas-KvP5wT2u2U0@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, leoli-KZfg59tc24xl57MIdRCFDg@public.gmane.org, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-geode-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On Thursday 24 of January 2013 17:46:02 Felipe Balbi wrote:
> By simply setting a flag, we can drop some
> boilerplate code.
> 
> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/usb/gadget/s3c-hsotg.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/gadget/s3c-hsotg.c
> b/drivers/usb/gadget/s3c-hsotg.c index 833d85b..bd8292d 100644
> --- a/drivers/usb/gadget/s3c-hsotg.c
> +++ b/drivers/usb/gadget/s3c-hsotg.c
> @@ -3552,17 +3552,13 @@ static int s3c_hsotg_probe(struct
> platform_device *pdev)
> 
>  	dev_info(dev, "regs %p, irq %d\n", hsotg->regs, hsotg->irq);
> 
> -	device_initialize(&hsotg->gadget.dev);
> -
> -	dev_set_name(&hsotg->gadget.dev, "gadget");
> -
>  	hsotg->gadget.max_speed = USB_SPEED_HIGH;
>  	hsotg->gadget.ops = &s3c_hsotg_gadget_ops;
>  	hsotg->gadget.name = dev_name(dev);
> -
>  	hsotg->gadget.dev.parent = dev;
>  	hsotg->gadget.dev.dma_mask = dev->dma_mask;
>  	hsotg->gadget.dev.release = s3c_hsotg_release;
> +	hsotg->gadget.register_my_device = true;
> 
>  	/* reset the system */
> 
> @@ -3643,12 +3639,6 @@ static int s3c_hsotg_probe(struct platform_device
> *pdev)
> 
>  	s3c_hsotg_phy_disable(hsotg);
> 
> -	ret = device_add(&hsotg->gadget.dev);
> -	if (ret) {
> -		put_device(&hsotg->gadget.dev);
> -		goto err_ep_mem;
> -	}
> -
>  	ret = usb_add_gadget_udc(&pdev->dev, &hsotg->gadget);
>  	if (ret)
>  		goto err_ep_mem;
> @@ -3687,10 +3677,8 @@ static int s3c_hsotg_remove(struct
> platform_device *pdev) }
> 
>  	s3c_hsotg_phy_disable(hsotg);
> -
>  	clk_disable_unprepare(hsotg->clk);
> 
> -	device_unregister(&hsotg->gadget.dev);
>  	return 0;
>  }

Looks good.

Reviewed-by: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Best regards,
Tomasz Figa

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
