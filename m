From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v5 03/11] usb: musb: am335x: add support for dual
 instance
Date: Thu, 26 Jul 2012 08:23:31 +0000
Message-ID: <47CEF8C4B26E8C44B22B028A650E0EA93EAEF728@DBDE01.ent.ti.com>
References: <1343218049-29917-1-git-send-email-ajay.gupta@ti.com>
 <1343218049-29917-4-git-send-email-ajay.gupta@ti.com>
 <20120726073437.GF29029@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120726073437.GF29029-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
> On Wed, Jul 25, 2012 at 05:37:21PM +0530, Ajay Kumar Gupta wrote:
> > AM335x and TI81xx platform has dual musb controller so updating the
> > musb_dspc.c to support the same.
> >
> > Changes:
> > 	- Moved otg_workaround timer to glue structure
> > 	- Moved static local variable last_timer to glue structure
> > 	- PHY on/off related cleanups
> >
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> > ---
> >  drivers/usb/musb/musb_dsps.c |   93 +++++++++++++++++++++++++------------
> ----
> >  1 files changed, 57 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
> > index 2174699..a2c8a06 100644
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
> >  	const struct dsps_musb_wrapper *wrp; /* wrapper register offsets */
> > -	struct timer_list timer;	/* otg_workaround timer */
> > -	u32 __iomem *usb_ctrl;
> > +	struct timer_list timer[2];	/* otg_workaround timer */
> > +	unsigned long last_timer[2];    /* last timer data for each instance
> */
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
> >   * This is to enable the PHY using usb_ctrl register in system control
> > @@ -130,11 +134,11 @@ struct dsps_glue {
> >   * XXX: This function will be removed once we have a seperate driver for
> >   * control module
> >   */
> > -static void musb_dsps_phy_control(struct dsps_glue *glue, u8 on)
> > +static void musb_dsps_phy_control(struct dsps_glue *glue, u8 id, u8 on)
> >  {
> >  	u32 usbphycfg;
> >
> > -	usbphycfg = __raw_readl(glue->usb_ctrl);
> > +	usbphycfg = __raw_readl(glue->usb_ctrl[id]);
> >
> >  	if (on) {
> >  		if (glue->usbss_rev == MUSB_USBSS_REV_816X) {
> > @@ -157,7 +161,7 @@ static void musb_dsps_phy_control(struct dsps_glue
> *glue, u8 on)
> >  				glue->usbss_rev == MUSB_USBSS_REV_33XX)
> >  			usbphycfg |= USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN;
> >  	}
> > -	__raw_writel(usbphycfg, glue->usb_ctrl);
> > +	__raw_writel(usbphycfg, glue->usb_ctrl[id]);
> >  }
> >  /**
> >   * dsps_musb_enable - enable interrupts
> > @@ -247,7 +251,7 @@ static void otg_timer(unsigned long _musb)
> >
> >  		devctl = dsps_readb(mregs, MUSB_DEVCTL);
> >  		if (devctl & MUSB_DEVCTL_BDEVICE)
> > -			mod_timer(&glue->timer,
> > +			mod_timer(&glue->timer[musb->id],
> 
> I believe this "musb" is a struct musb pointer, right ?
Yes.

> Why would you
> use that ID ? You can find the correct musb by grabbing its
> platform_device with to_platform_device(musb->controller) and use that
> pdev to get to the correct ID.
Let me cook something with this and update.

Ajay
> 
> ditto to all others.
> 
> --
> balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
