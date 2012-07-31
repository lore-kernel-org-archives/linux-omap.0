From: "B, Ravi" <ravibabu@ti.com>
Subject: RE: [PATCH v6 03/11] usb: musb: am335x: add support for dual
 instance
Date: Tue, 31 Jul 2012 14:01:49 +0000
Message-ID: <6C6B28D4DC342643927BEAFCE8707BF63E9D96C9@DBDE01.ent.ti.com>
References: <1343377927-7850-1-git-send-email-ravibabu@ti.com>
 <1343377927-7850-3-git-send-email-ravibabu@ti.com>
 <20120731134650.GA8804@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57405 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753890Ab2GaOCD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jul 2012 10:02:03 -0400
In-Reply-To: <20120731134650.GA8804@arwen.pp.htv.fi>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "tony@atomide.com" <tony@atomide.com>, "ajayguptaj@gmail.com" <ajayguptaj@gmail.com>

> Hi,
> 
> On Fri, Jul 27, 2012 at 02:01:59PM +0530, Ravi B wrote:
> > From: Ajay Kumar Gupta <ajay.gupta@ti.com>
> > 
> > AM335x and TI81xx platform has dual musb controller so updating the 
> > musb_dspc.c to support the same.
> > 
> > Changes:
> > 	- Moved otg_workaround timer to glue structure
> > 	- Moved static local variable last_timer to glue structure
> > 	- PHY on/off related cleanups
> > 
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> > Signed-off-by: Ravi B <ravibabu@ti.com>
> > ---
> >  drivers/usb/musb/musb_dsps.c |  118 
> > +++++++++++++++++++++++++----------------
> >  1 files changed, 72 insertions(+), 46 deletions(-)
> > 
> > diff --git a/drivers/usb/musb/musb_dsps.c 
> > b/drivers/usb/musb/musb_dsps.c index 2174699..2fd5dc8 100644
> > --- a/drivers/usb/musb/musb_dsps.c
> > +++ b/drivers/usb/musb/musb_dsps.c
> > @@ -105,6 +105,8 @@ struct dsps_musb_wrapper {
> >  	/* miscellaneous stuff */
> >  	u32		musb_core_offset;
> >  	u8		poll_seconds;
> > +	/* number of musb instances */
> > +	u8		instances;
> >  };
> >  
> >  /**
> > @@ -112,16 +114,18 @@ struct dsps_musb_wrapper {
> >   */
> >  struct dsps_glue {
> >  	struct device *dev;
> > -	struct platform_device *musb;	/* child musb pdev */
> > +	struct platform_device *musb[2];	/* child musb pdev */
> >  	const struct dsps_musb_wrapper *wrp; /* wrapper 
> register offsets */
> > -	struct timer_list timer;	/* otg_workaround timer */
> > -	u32 __iomem *usb_ctrl;
> > +	struct timer_list timer[2];	/* otg_workaround timer */
> > +	unsigned long last_timer[2];    /* last timer data for 
> each instance */
> > +	u32 __iomem *usb_ctrl[2];
> >  	u8      usbss_rev;
> >  };
> >  
> >  /**
> >   * musb_dsps_phy_control - phy on/off
> >   * @glue: struct dsps_glue *
> > + * @id: musb instance
> >   * @on: flag for phy to be switched on or off
> >   *
> >   * This is to enable the PHY using usb_ctrl register in system 
> > control @@ -130,11 +134,11 @@ struct dsps_glue {
> >   * XXX: This function will be removed once we have a 
> seperate driver for
> >   * control module
> >   */
> > -static void musb_dsps_phy_control(struct dsps_glue *glue, u8 on)
> > +static void musb_dsps_phy_control(struct dsps_glue *glue, 
> u8 id, u8 
> > +on)
> >  {
> >  	u32 usbphycfg;
> >  
> > -	usbphycfg = __raw_readl(glue->usb_ctrl);
> > +	usbphycfg = __raw_readl(glue->usb_ctrl[id]);
> >  
> >  	if (on) {
> >  		if (glue->usbss_rev == MUSB_USBSS_REV_816X) { 
> @@ -157,7 +161,7 @@ 
> > static void musb_dsps_phy_control(struct dsps_glue *glue, u8 on)
> >  				glue->usbss_rev == MUSB_USBSS_REV_33XX)
> >  			usbphycfg |= USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN;
> >  	}
> > -	__raw_writel(usbphycfg, glue->usb_ctrl);
> > +	__raw_writel(usbphycfg, glue->usb_ctrl[id]);
> >  }
> >  /**
> >   * dsps_musb_enable - enable interrupts @@ -207,8 +211,9 @@ static 
> > void otg_timer(unsigned long _musb)
> >  	struct musb *musb = (void *)_musb;
> >  	void __iomem *mregs = musb->mregs;
> >  	struct device *dev = musb->controller;
> > -	struct platform_device *pdev = to_platform_device(dev->parent);
> > -	struct dsps_glue *glue = platform_get_drvdata(pdev);
> > +	struct platform_device *pdev = to_platform_device(dev);
> > +	struct platform_device *parent_pdev = 
> to_platform_device(dev->parent);
> > +	struct dsps_glue *glue = platform_get_drvdata(parent_pdev);
> >  	const struct dsps_musb_wrapper *wrp = glue->wrp;
> >  	u8 devctl;
> >  	unsigned long flags;
> > @@ -247,7 +252,7 @@ static void otg_timer(unsigned long _musb)
> >  
> >  		devctl = dsps_readb(mregs, MUSB_DEVCTL);
> >  		if (devctl & MUSB_DEVCTL_BDEVICE)
> > -			mod_timer(&glue->timer,
> > +			mod_timer(&glue->timer[pdev->id],
> >  					jiffies + 
> wrp->poll_seconds * HZ);
> >  		else
> >  			musb->xceiv->state = OTG_STATE_A_IDLE; 
> @@ -261,9 +266,9 @@ static 
> > void otg_timer(unsigned long _musb)  static void 
> > dsps_musb_try_idle(struct musb *musb, unsigned long timeout)  {
> >  	struct device *dev = musb->controller;
> > -	struct platform_device *pdev = to_platform_device(dev->parent);
> > -	struct dsps_glue *glue = platform_get_drvdata(pdev);
> > -	static unsigned long last_timer;
> > +	struct platform_device *pdev = to_platform_device(dev);
> > +	struct platform_device *parent_pdev = 
> to_platform_device(dev->parent);
> > +	struct dsps_glue *glue = platform_get_drvdata(parent_pdev);
> 
> just one thing that could be cleaned on a later patch:
> 
> if parent_pdev is only used to get to struct dsps_glue, you 
> could just:
> 
> struct dsps_glue *glue = dev_get_drvdata(dev->parent);
> 
> with no need to do a container_of() to the platform_device ;-)

Yes Felipe, parent_pdev is only to get dsps_glue. I will include this change in later patch.

RaviBabu
> 
> --
> balbi
> 