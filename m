From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v5 04/11] usb: otg: nop: add support for multiple
 tranceiver
Date: Thu, 26 Jul 2012 08:36:45 +0000
Message-ID: <47CEF8C4B26E8C44B22B028A650E0EA93EAEFFA3@DBDE01.ent.ti.com>
References: <1343218049-29917-1-git-send-email-ajay.gupta@ti.com>
 <1343218049-29917-5-git-send-email-ajay.gupta@ti.com>
 <20120726073621.GG29029@arwen.pp.htv.fi>
 <47CEF8C4B26E8C44B22B028A650E0EA93EAEF6F7@DBDE01.ent.ti.com>
 <20120726082402.GO29029@arwen.pp.htv.fi>
 <47CEF8C4B26E8C44B22B028A650E0EA93EAEF849@DBDE01.ent.ti.com>
 <20120726082911.GR29029@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120726082911.GR29029-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
> On Thu, Jul 26, 2012 at 08:29:06AM +0000, Gupta, Ajay Kumar wrote:
> > Hi,
> > > On Thu, Jul 26, 2012 at 08:22:35AM +0000, Gupta, Ajay Kumar wrote:
> > > > > > @@ -408,7 +408,7 @@ static int am35x_musb_exit(struct musb *musb)
> > > > > >  		data->set_phy_power(0);
> > > > > >
> > > > > >  	usb_put_phy(musb->xceiv);
> > > > > > -	usb_nop_xceiv_unregister();
> > > > > > +	usb_nop_xceiv_unregister(musb->xceiv);
> > > > >
> > > > > Dude, this is so wrong... You don't know if there are other
> > > > > users of the nop xceiv in the system. If there are other users
> > > > > which already have claimed id 0, you will try to create
> > > > > duplicated directories under
> > > sysfs.
> > > > > MUSB's ID has nothing to do with NOP's ID.
> > > >
> > > > I could not understood this comment as I am not using id. Please
> clarify.
> > >
> > > sorry, my bad. I put the comment on the wrong hunk:
> > >
> > > > > > @@ -364,7 +364,7 @@ static int am35x_musb_init(struct musb *musb)
> > > > > >  	if (!rev)
> > > > > >  		return -ENODEV;
> > > > > >
> > > > > > -	usb_nop_xceiv_register();
> > > > > > +	usb_nop_xceiv_register(musb->id);
> > > > > >  	musb->xceiv = usb_get_phy(USB_PHY_TYPE_USB2);
> > > > > >  	if (IS_ERR_OR_NULL(musb->xceiv))
> > > > > >  		return -ENODEV;
> > >
> > > here. You pass musb->id to become NOP's ID.
> >
> > Got this, so something like musb_ida is needed even for NOP. Right?
> 
> that's correct. But I guess you can avoid nop_get_id() and build that into
> nop_register and nop_unregister() calls, so that the changes are local to
> nop xceiv only.

Correct.

Ajay
> 
> --
> balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
