From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [patch-2.6.34-rc2+ 10/11] musb_core: don't call
 musb_platform_exit() twice
Date: Thu, 25 Mar 2010 18:04:25 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032221AF79@dbde02.ent.ti.com>
References: <1269515673-27980-1-git-send-email-felipe.balbi@nokia.com>
 <1269515673-27980-11-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48665 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752011Ab0CYMei convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 08:34:38 -0400
In-Reply-To: <1269515673-27980-11-git-send-email-felipe.balbi@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>, Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

Felipe Balbi wrote:
> 
> From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> musb_platform_exit() is called twice from musb_init_controller() iff controller
> initialization fails. Move the call (and the DevCtl register writes surrounding
> it) from musb_free() to musb_remove().
> 
> Fix mispalced and now incorrect 'goto's in musb_init_controller().
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>

This one doesn't apply for me. I'm on commit 01e7770 plus
gregkh-07-usb-2.6.34-rc1.patch. The first 9 patches apply correctly,
but this one fails on hunk 4 of 6.

Felipe - are we on the same base here?

Looking at gregkh-07-usb-2.6.34-rc1.patch, this hunk is already taken care
of there.

- Anand

> ---
>  drivers/usb/musb/musb_core.c |   17 +++++++----------
>  1 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 8b68f21..508fd58 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -1851,10 +1851,6 @@ static void musb_free(struct musb *musb)
>  	put_device(musb->xceiv->dev);
>  #endif
>  
> -	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
> -	musb_platform_exit(musb);
> -	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
> -
>  #ifdef CONFIG_USB_MUSB_HDRC_HCD
>  	usb_put_hcd(musb_to_hcd(musb));
>  #else
> @@ -2032,8 +2028,6 @@ bad_config:
>  		musb->xceiv->state = OTG_STATE_A_IDLE;
>  
>  		status = usb_add_hcd(musb_to_hcd(musb), -1, 0);
> -		if (status)
> -			goto fail;
>  
>  		DBG(1, "%s mode, status %d, devctl %02x %c\n",
>  			"HOST", status,
> @@ -2048,8 +2042,6 @@ bad_config:
>  		musb->xceiv->state = OTG_STATE_B_IDLE;
>  
>  		status = musb_gadget_setup(musb);
> -		if (status)
> -			goto fail;
>  
>  		DBG(1, "%s mode, status %d, dev%02x\n",
>  			is_otg_enabled(musb) ? "OTG" : "PERIPHERAL",
> @@ -2057,12 +2049,14 @@ bad_config:
>  			musb_readb(musb->mregs, MUSB_DEVCTL));
>  
>  	}
> +	if (status < 0)
> +		goto fail2;
>  
>  #ifdef CONFIG_SYSFS
>  	status = sysfs_create_group(&musb->controller->kobj, &musb_attr_group);
> -#endif
>  	if (status)
>  		goto fail2;
> +#endif
>  
>  	dev_info(dev, "USB %s mode controller at %p using %s, IRQ %d\n",
>  			({char *s;
> @@ -2125,7 +2119,6 @@ static int __init musb_probe(struct platform_device *pdev)
>  	/* clobbered by use_dma=n */
>  	orig_dma_mask = dev->dma_mask;
>  #endif
> -
>  	status = musb_init_controller(dev, irq, base);
>  	if (status < 0)
>  		iounmap(base);
> @@ -2148,6 +2141,10 @@ static int __exit musb_remove(struct platform_device *pdev)
>  	if (musb->board_mode == MUSB_HOST)
>  		usb_remove_hcd(musb_to_hcd(musb));
>  #endif
> +	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
> +	musb_platform_exit(musb);
> +	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
> +
>  	musb_free(musb);
>  	iounmap(ctrl_base);
>  	device_init_wakeup(&pdev->dev, 0);
> -- 
> 1.7.0.rc0.33.g7c3932
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 