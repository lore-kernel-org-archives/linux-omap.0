From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] irqchip: omap-intc: fix legacy DMA regression
Date: Tue, 6 Jan 2015 10:30:22 -0800
Message-ID: <20150106183021.GV4081@atomide.com>
References: <20150106123830.GD30544@fuloong-minipc.musicnaut.iki.fi>
 <1420563093-26026-1-git-send-email-balbi@ti.com>
 <20150106180532.GO11502@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150106180532.GO11502@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Felipe Balbi <balbi@ti.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Aaro Koskinen <aaro.koskinen@iki.fi>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Santosh Shilimkar <ssantosh@kernel.org>, Peter =?utf-8?Q?K=C3=BCmmel?= <syntheticpp@gmx.net>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [150106 10:08]:
> On Tue, Jan 06, 2015 at 10:51:33AM -0600, Felipe Balbi wrote:
> > +	/*
> > +	 * FIXME legacy OMAP DMA driver sitting under arch/arm/plat-omap/dma.c
> > +	 * depends is still not ready for linear IRQ domains; because of that
> > +	 * we need to temporarily "blacklist" OMAP2 and OMAP3 devices from using
> > +	 * linear IRQ Domain until that driver is finally fixed.
> 
> "finally fixed" or finally killed off like it really needs to be, once
> all users of it are killed.
> 
> We've been trying to do this for, what, three years now... I finally
> pushed a WARN_ON() into that code to make it obvious to anyone who
> uses omap_request_dma() that they really need to update their code.
> 
> Here's the list of references to that symbol which *still* need to be
> fixed so that we can kill the legacy DMA driver:
> 
> drivers/media/platform/omap/omap_vout_vrfb.c:   ret = omap_request_dma(vout->vrfb_dma_tx.dev_id, "VRFB DMA TX",
> drivers/media/platform/omap3isp/isphist.c:              ret = omap_request_dma(OMAP24XX_DMA_NO_DEVICE, "DMA_ISP_HIST",
> drivers/media/platform/soc_camera/omap1_camera.c:       err = omap_request_dma(OMAP_DMA_CAMERA_IF_RX, DRIVER_NAME,
> drivers/mtd/onenand/omap2.c:            r = omap_request_dma(0, pdev->dev.driver->name,

AFAIK we should just remove DMA support from the drivers above.
Nobody seems to be interested in doing anything about them.

> drivers/usb/gadget/udc/omap_udc.c:              status = omap_request_dma(dma_channel,
> drivers/usb/gadget/udc/omap_udc.c:              status = omap_request_dma(dma_channel,

OK so Aaro picked this one.

> drivers/usb/musb/tusb6010_omap.c:               ret = omap_request_dma(chdat->sync_dev, dev_name,
> drivers/usb/musb/tusb6010_omap.c:               ret = omap_request_dma(tusb_dma->sync_dev, "TUSB shared",

I'll update this one. FYI, I already have some work-in-progress
MUSB DMA patches that allow building in all the MUSB DMA glue
layers. I just need to finish that series for v3.20:

https://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/log/?h=musb-dma-2014-11-25-v2

So converting tusb6010 over to the dmaengine API would be the
next logical step after that series. Probably not going to
happen before v3.21 though..

Regards,

Tony
