From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH v5 04/11] usb: otg: nop: add support for multiple
 tranceiver
Date: Thu, 26 Jul 2012 08:22:35 +0000
Message-ID: <47CEF8C4B26E8C44B22B028A650E0EA93EAEF6F7@DBDE01.ent.ti.com>
References: <1343218049-29917-1-git-send-email-ajay.gupta@ti.com>
 <1343218049-29917-5-git-send-email-ajay.gupta@ti.com>
 <20120726073621.GG29029@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60679 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750741Ab2GZIWt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jul 2012 04:22:49 -0400
In-Reply-To: <20120726073621.GG29029@arwen.pp.htv.fi>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "tony@atomide.com" <tony@atomide.com>

Hi
> On Wed, Jul 25, 2012 at 05:37:22PM +0530, Ajay Kumar Gupta wrote:
> > diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
> > index 01203eb..eb6220f 100644
> > --- a/drivers/usb/musb/am35x.c
> > +++ b/drivers/usb/musb/am35x.c
> > @@ -364,7 +364,7 @@ static int am35x_musb_init(struct musb *musb)
> >  	if (!rev)
> >  		return -ENODEV;
> >
> > -	usb_nop_xceiv_register();
> > +	usb_nop_xceiv_register(musb->id);
> >  	musb->xceiv = usb_get_phy(USB_PHY_TYPE_USB2);
> >  	if (IS_ERR_OR_NULL(musb->xceiv))
> >  		return -ENODEV;
> > @@ -408,7 +408,7 @@ static int am35x_musb_exit(struct musb *musb)
> >  		data->set_phy_power(0);
> >
> >  	usb_put_phy(musb->xceiv);
> > -	usb_nop_xceiv_unregister();
> > +	usb_nop_xceiv_unregister(musb->xceiv);
> 
> Dude, this is so wrong... You don't know if there are other users of the
> nop xceiv in the system. If there are other users which already have
> claimed id 0, you will try to create duplicated directories under sysfs.
> MUSB's ID has nothing to do with NOP's ID.

I could not understood this comment as I am not using id. Please clarify.

Ajay
> 
> --
> balbi
