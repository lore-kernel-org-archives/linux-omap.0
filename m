From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] cbus-tahvo-usb: Fix tahvo_usb_device pointer
Date: Thu, 10 Mar 2011 11:03:58 +0200
Message-ID: <20110310090358.GC2279@legolas.emea.dhcp.ti.com>
References: <1299694025.1911.9.camel@marge>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:60595 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752004Ab1CJJEC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 04:04:02 -0500
Received: by mail-ew0-f48.google.com with SMTP id 22so507566ewy.35
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 01:04:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1299694025.1911.9.camel@marge>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Buesch <mb@bu3sch.de>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>

Hi,

On Wed, Mar 09, 2011 at 07:07:05PM +0100, Michael Buesch wrote:
> The static tahvo_usb_device is uninitialized, but used
> in the otg interrupt handler. This results in a NULL pointer
> dereference on interrupt.
> Fix this by storing a struct tahvo_usb pointer instead of
> a platform device.
> 
> Signed-off-by: Michael Buesch <mb@bu3sch.de>

Acked-by: Felipe Balbi <balbi@ti.com>

> The global tahvo_usb_device pointer should eventually be removed
> completely in a later patch. But let's get it working first.

For sure :-)

> Index: linux-2.6.38-rc7/drivers/cbus/tahvo-usb.c
> ===================================================================
> --- linux-2.6.38-rc7.orig/drivers/cbus/tahvo-usb.c	2011-03-09 18:47:41.147540155 +0100
> +++ linux-2.6.38-rc7/drivers/cbus/tahvo-usb.c	2011-03-09 18:50:59.658485748 +0100
> @@ -99,7 +99,7 @@ struct tahvo_usb {
>  	int tahvo_mode;
>  #endif
>  };
> -static struct platform_device tahvo_usb_device;
> +static struct tahvo_usb *tahvo_usb_device;
>  
>  /*
>   * ---------------------------------------------------------------------------
> @@ -114,8 +114,7 @@ static struct platform_device *tahvo_otg
>  
>  static irqreturn_t omap_otg_irq(int irq, void *arg)
>  {
> -	struct platform_device *otg_dev = arg;
> -	struct tahvo_usb *tu = platform_get_drvdata(otg_dev);
> +	struct tahvo_usb *tu = arg;
>  	u16 otg_irq;
>  
>  	otg_irq = omap_readw(OTG_IRQ_SRC);
> @@ -201,12 +200,12 @@ static int __init omap_otg_probe(struct
>  
>  	return request_irq(tahvo_otg_dev->resource[1].start,
>  			   omap_otg_irq, IRQF_DISABLED, DRIVER_NAME,
> -			   &tahvo_usb_device);
> +			   tahvo_usb_device);
>  }
>  
>  static int __exit omap_otg_remove(struct platform_device *pdev)
>  {
> -	free_irq(tahvo_otg_dev->resource[1].start, &tahvo_usb_device);
> +	free_irq(tahvo_otg_dev->resource[1].start, tahvo_usb_device);
>  	tahvo_otg_dev = NULL;
>  
>  	return 0;
> @@ -659,6 +658,7 @@ static int __init tahvo_usb_probe(struct
>  	tu = kzalloc(sizeof(*tu), GFP_KERNEL);
>  	if (!tu)
>  		return -ENOMEM;
> +	tahvo_usb_device = tu;
>  
>  	tu->pt_dev = container_of(dev, struct platform_device, dev);

I don't get why they save the entire platform_device structure inside
tahvo_usb structure. It's well enough to have a struct device *

-- 
balbi
