From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH v4 02/11] usb: musb: kill global and static for multi
 instance
Date: Wed, 25 Jul 2012 10:34:49 +0000
Message-ID: <47CEF8C4B26E8C44B22B028A650E0EA93EAE56BD@DBDE01.ent.ti.com>
References: <1342698367-12978-1-git-send-email-ajay.gupta@ti.com>
 <1342698367-12978-3-git-send-email-ajay.gupta@ti.com>
 <20120725075014.GR3630@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33050 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754465Ab2GYKfH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jul 2012 06:35:07 -0400
In-Reply-To: <20120725075014.GR3630@arwen.pp.htv.fi>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "tony@atomide.com" <tony@atomide.com>

Hi,
> 
> On Thu, Jul 19, 2012 at 05:15:58PM +0530, Ajay Kumar Gupta wrote:
> > Moved global variable "musb_debugfs_root" and static variable
> > "old_state" to 'struct musb' to help support multi instance of musb
> > controller as present on AM335x platform.
> >
> > Also removed the global variable "orig_dma_mask" and filled the
> > dev->dma_mask with parent device's dma_mask.
> >
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> > ---
> >  drivers/usb/musb/musb_core.c    |   16 +++-------------
> >  drivers/usb/musb/musb_core.h    |    4 ++++
> >  drivers/usb/musb/musb_debugfs.c |   14 ++++++++------
> >  3 files changed, 15 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/usb/musb/musb_core.c
> > b/drivers/usb/musb/musb_core.c index 3e09984..a5db4dd 100644
> > --- a/drivers/usb/musb/musb_core.c
> > +++ b/drivers/usb/musb/musb_core.c
> > @@ -1802,10 +1802,9 @@ static const struct attribute_group
> > musb_attr_group = {  static void musb_irq_work(struct work_struct
> > *data)  {
> >  	struct musb *musb = container_of(data, struct musb, irq_work);
> > -	static int old_state;
> >
> > -	if (musb->xceiv->state != old_state) {
> > -		old_state = musb->xceiv->state;
> > +	if (musb->xceiv->state != musb->xceiv_old_state) {
> > +		musb->xceiv_old_state = musb->xceiv->state;
> >  		sysfs_notify(&musb->controller->kobj, NULL, "mode");
> >  	}
> >  }
> > @@ -2115,11 +2114,6 @@ fail0:
> >  /* all implementations (PCI bridge to FPGA, VLYNQ, etc) should just
> >   * bridge to a platform device; this driver then suffices.
> >   */
> > -
> > -#ifndef CONFIG_MUSB_PIO_ONLY
> > -static u64	*orig_dma_mask;
> > -#endif
> > -
> >  static int __devinit musb_probe(struct platform_device *pdev)  {
> >  	struct device	*dev = &pdev->dev;
> > @@ -2138,10 +2132,6 @@ static int __devinit musb_probe(struct
> platform_device *pdev)
> >  		return -ENOMEM;
> >  	}
> >
> > -#ifndef CONFIG_MUSB_PIO_ONLY
> > -	/* clobbered by use_dma=n */
> > -	orig_dma_mask = dev->dma_mask;
> > -#endif
> >  	status = musb_init_controller(dev, irq, base);
> >  	if (status < 0)
> >  		iounmap(base);
> > @@ -2166,7 +2156,7 @@ static int __devexit musb_remove(struct
> platform_device *pdev)
> >  	iounmap(ctrl_base);
> >  	device_init_wakeup(&pdev->dev, 0);
> >  #ifndef CONFIG_MUSB_PIO_ONLY
> > -	pdev->dev.dma_mask = orig_dma_mask;
> > +	pdev->dev.dma_mask = (&dev->dev.parent)->dma_mask;
> 
> are you sure ?? This should be:
> 
> dev->parent.dma_mask;

Actually both are fine and I used parent based on your recommendation
in my earlier version of patch at
http://marc.info/?l=linux-usb&m=134121391908734&w=2

anyways I will change to :
pdev->dev.dma_mask = dma_set_mask((&pdev->dev, DMA_BIT_MASK(64));

Ajay
> 
> In fact, while doing that you could use dma_set_mask() instead ;-)
> 
> --
> balbi
