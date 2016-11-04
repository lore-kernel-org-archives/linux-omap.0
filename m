From: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: Re: [PATCH 0/2] musb-fixes for v4.9-rc2
Date: Fri, 4 Nov 2016 19:02:12 +0100
Message-ID: <20161104180212.GB898@localhost.localdomain>
References: <20161020082318.GA2903@localhost.localdomain>
 <20161020123524.oepmqvlhzzu7elgj@atomide.com>
 <20161020193612.GA29736@localhost.localdomain>
 <20161021071722.2cetd2mt23t245ao@atomide.com>
 <20161024180708.kpx6s2jb7dpg6xfx@atomide.com>
 <20161101211358.GA2597@localhost.localdomain>
 <20161103205902.GB21430@atomide.com>
 <20161103225532.GD21430@atomide.com>
 <20161104104026.GA27621@localhost.localdomain>
 <20161104144813.GF21430@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161104144813.GF21430-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 04, 2016 at 07:48:13AM -0700, Tony Lindgren wrote:
> * Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org> [161104 03:41]:
> > All your patches on top of current Linus' git and revert of:
> > commit 87326e858448c40e32f142c0b8dcc59d7b27c641
> > Author: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > Date:   Tue May 31 10:05:20 2016 -0500
> > 
> >     usb: musb: Remove extra PM runtime calls from 2430 glue layer
> > 
> > does the trick for me (reverted patch which applies bellow). I also
> > alternatively tried to increase pm_runtime_set_autosuspend_delay up
> > to 1000 without luck.
> 
> OK thanks for narrowing it down. The patch does not seem to change
> anything for me with 2430 glue layer, things work for me with and
> without it. Care to check if all hunks of the patch are needed
> for you..
> 
> > diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> > index 451b372..a623e45 100644
> > --- a/drivers/usb/musb/omap2430.c
> > +++ b/drivers/usb/musb/omap2430.c
> > @@ -218,8 +218,13 @@ static void omap_musb_mailbox_work(struct work_struct *mailbox_work)
> >  {
> >  	struct omap2430_glue *glue = container_of(mailbox_work,
> >  				struct omap2430_glue, omap_musb_mailbox_work);
> > +	struct musb *musb = glue_to_musb(glue);
> > +	struct device *dev = musb->controller;
> >  
> > +	pm_runtime_get_sync(dev);
> >  	omap_musb_set_mailbox(glue);
> > +	pm_runtime_mark_last_busy(dev);
> > +	pm_runtime_put_autosuspend(dev);
> >  }
> >  
> >  static irqreturn_t omap2430_musb_interrupt(int irq, void *__hci)
> 
> ..is just the above enough..

No, does not work with only this hunk:
[   94.980102] udlfb: wait for urb interrupted: ffffffc2 available: 0
[  124.642456] musb_ep_program 921: broken !rx_reinit, ep2 csr 0003
[  124.648986] musb_host_rx 1912: RX2 dma busy, csr a203
[  124.654754] musb_host_rx 1970: Rx interrupt with no errors or packet!
[  124.661743] musb_host_rx 1970: Rx interrupt with no errors or packet!
[  124.668762] musb_host_rx 1970: Rx interrupt with no errors or packet!
[  124.675720] musb_host_rx 1970: Rx interrupt with no errors or packet!
[  124.682830] musb_ep_program 921: broken !rx_reinit, ep2 csr 0003
[  124.689178] musb_host_rx 1970: Rx interrupt with no errors or packet!
[  124.696105] musb_host_rx 1970: Rx interrupt with no errors or packet!
[  124.772552] udlfb: released /dev/fb0 user=1 count=0

> > @@ -289,6 +294,16 @@ static int omap2430_musb_init(struct musb *musb)
> >  	phy_init(musb->phy);
> >  	phy_power_on(musb->phy);
> >  
> > +	/*
> > +	 * Enable runtime PM for musb parent (this driver). We can't
> > +	 * do it earlier as struct musb is not yet allocated and we
> > +	 * need to touch the musb registers for runtime PM.
> > +	 */
> > +	pm_runtime_enable(glue->dev);
> > +	status = pm_runtime_get_sync(glue->dev);
> > +	if (status < 0)
> > +		goto err1;
> > +
> >  	l = musb_readl(musb->mregs, OTG_INTERFSEL);
> >  
> >  	if (data->interface_type == MUSB_INTERFACE_UTMI) {
> > @@ -312,7 +327,11 @@ static int omap2430_musb_init(struct musb *musb)
> >  	if (glue->status != MUSB_UNKNOWN)
> >  		omap_musb_set_mailbox(glue);
> >  
> > +	pm_runtime_put(glue->dev);
> >  	return 0;
> > +
> > +err1:
> > +	return status;
> >  }
> >  
> >  static void omap2430_musb_enable(struct musb *musb)
> > @@ -512,10 +531,6 @@ static int omap2430_probe(struct platform_device *pdev)
> >  		goto err2;
> >  	}
> >  
> > -	pm_runtime_enable(glue->dev);
> > -	pm_runtime_use_autosuspend(glue->dev);
> > -	pm_runtime_set_autosuspend_delay(glue->dev, 100);
> > -
> >  	ret = platform_device_add(musb);
> >  	if (ret) {
> >  		dev_err(&pdev->dev, "failed to register musb device\n");
> > @@ -538,7 +553,6 @@ static int omap2430_remove(struct platform_device *pdev)
> >  	pm_runtime_get_sync(glue->dev);
> >  	platform_device_unregister(glue->musb);
> >  	pm_runtime_put_sync(glue->dev);
> > -	pm_runtime_dont_use_autosuspend(glue->dev);
> >  	pm_runtime_disable(glue->dev);
> >  
> >  	return 0;
> 
> ..or are these init changes needed too?

Yes, also tried to move pm_runtime_use_autosuspend into omap2430_musb_init
and drop omap_musb_mailbox_work changes, but that does not work either.

	ladis
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
