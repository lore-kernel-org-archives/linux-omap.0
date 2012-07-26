From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH v5 04/11] usb: otg: nop: add support for multiple
 tranceiver
Date: Thu, 26 Jul 2012 08:29:06 +0000
Message-ID: <47CEF8C4B26E8C44B22B028A650E0EA93EAEF849@DBDE01.ent.ti.com>
References: <1343218049-29917-1-git-send-email-ajay.gupta@ti.com>
 <1343218049-29917-5-git-send-email-ajay.gupta@ti.com>
 <20120726073621.GG29029@arwen.pp.htv.fi>
 <47CEF8C4B26E8C44B22B028A650E0EA93EAEF6F7@DBDE01.ent.ti.com>
 <20120726082402.GO29029@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46197 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751053Ab2GZI3P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jul 2012 04:29:15 -0400
In-Reply-To: <20120726082402.GO29029@arwen.pp.htv.fi>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "tony@atomide.com" <tony@atomide.com>

Hi,
> On Thu, Jul 26, 2012 at 08:22:35AM +0000, Gupta, Ajay Kumar wrote:
> > > > @@ -408,7 +408,7 @@ static int am35x_musb_exit(struct musb *musb)
> > > >  		data->set_phy_power(0);
> > > >
> > > >  	usb_put_phy(musb->xceiv);
> > > > -	usb_nop_xceiv_unregister();
> > > > +	usb_nop_xceiv_unregister(musb->xceiv);
> > >
> > > Dude, this is so wrong... You don't know if there are other users of
> > > the nop xceiv in the system. If there are other users which already
> > > have claimed id 0, you will try to create duplicated directories under
> sysfs.
> > > MUSB's ID has nothing to do with NOP's ID.
> >
> > I could not understood this comment as I am not using id. Please clarify.
> 
> sorry, my bad. I put the comment on the wrong hunk:
> 
> > > > @@ -364,7 +364,7 @@ static int am35x_musb_init(struct musb *musb)
> > > >  	if (!rev)
> > > >  		return -ENODEV;
> > > >
> > > > -	usb_nop_xceiv_register();
> > > > +	usb_nop_xceiv_register(musb->id);
> > > >  	musb->xceiv = usb_get_phy(USB_PHY_TYPE_USB2);
> > > >  	if (IS_ERR_OR_NULL(musb->xceiv))
> > > >  		return -ENODEV;
> 
> here. You pass musb->id to become NOP's ID.

Got this, so something like musb_ida is needed even for NOP. Right?

Ajay
> 
> --
> balbi
