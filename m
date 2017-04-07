From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: usb: musb: regression since 4.9 on omap4-panda-es (caused by
 d8e5f0eca1e8)
Date: Fri, 7 Apr 2017 07:00:38 -0700
Message-ID: <20170407140038.GH13234@atomide.com>
References: <2bf73b02-6e59-627a-c370-552ed94e7795@ti.com>
 <20170404122736.GA13673@uda0271908>
 <20170404140341.GO10760@atomide.com>
 <20170405003637.GB13234@atomide.com>
 <dda7b6b0-b533-dfd6-1b12-b320bd69b623@ti.com>
 <20170405134655.GD13234@atomide.com>
 <20170405152954.GF13234@atomide.com>
 <a86b6582-468f-04c8-cb22-0770f1e91e67@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <a86b6582-468f-04c8-cb22-0770f1e91e67-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [170406 10:07]:
> Tony,
> 
> On 04/05/2017 06:29 PM, Tony Lindgren wrote:
> > * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [170405 06:53]:
> > > * Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [170405 00:15]:
> > > > To be precise this is what I have tried:
> > > > - boot w/o cable connected
> > > > - boot w/ board connected to PC (device mode)
> > > > - boot w/ OTG-A cable with USB keyboard
> > > > - boot w/ OTG-A cable connected to powered USB hub and the same keyboard
> > > > 
> > > > w/ and w/o this patch I have the same flood of prints in all cases.
> > > 
> > > OK interesting that it also happens with nothing connected.
> > > 
> > > > Fwiw I have checked where the is_active is set - which causes the prints:
> > > > musb_core.c:musb_start()
> > > > 
> > > > if (musb->port_mode != MUSB_PORT_MODE_HOST &&
> > > > 		musb->xceiv->otg->state != OTG_STATE_A_WAIT_BCON &&
> > > > 		(devctl & MUSB_DEVCTL_VBUS) == MUSB_DEVCTL_VBUS) {
> > > > 	musb->is_active = 1;
> > > > } else {
> > > > 	devctl |= MUSB_DEVCTL_SESSION;
> > > > }
> > > > 
> > > > this was the only place where the is_active was set to 1.
> > > 
> > > That seems normal in musb_start(). Will try with your .config
> > > here.
> > 
> > If the the port is configured as OTG, we should not need to
> > try to force any states during init. The change below will stop
> > the warnings with your .config, needs to be tested more though
> > to make sure things still work in all cases.
> 
> With this change I can boot up without issues, thanks!

OK

> I can not get the kernel to react to anything I plug to the A/B connector.

Yeah it seems that we have only peripheral mode working with panda, so
there seems to be also a long time vbus related regression.

> Keyboard (directly or via powered hub), flash drive, connecting the board to
> PC. Nothing.
> Actually if I connect to a PC I got a print from twl6030 about an interrupt,
> but nothing happens in USB front.
>
> The same thing happens with 4.8, so it is not regression. Most likely it is
> an error in my setup...

For me peripheral mode works fine. You needs at least one gadget
configured, looks like your .config has CONFIG_USB_GADGET disabled.

The VBUS should be coming from twl6030 and it seems to have some vbus
code. Would be nice to get the host mode working on panda too for the
OTG port..

> Tested-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>

OK thanks,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
