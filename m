From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [patch] omap: usb: ehci: fix use of hcd->regs
Date: Mon, 15 Sep 2008 00:23:41 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087022A25316C@dbde02.ent.ti.com>
References: <20080912121024.GG759@gandalf.research.nokia.com>
	<20080912.151404.108681717.Hiroshi.DOYU@nokia.com>
	<20080912123010.GI759@gandalf.research.nokia.com>
 <20080912.163713.80279054.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43349 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753791AbYINSxx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 14 Sep 2008 14:53:53 -0400
In-Reply-To: <20080912.163713.80279054.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Felipe
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Hiroshi
> > > >
> > > > diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> > > > index 8f122e5..a67533d 100644
> > > > --- a/drivers/usb/host/ehci-omap.c
> > > > +++ b/drivers/usb/host/ehci-omap.c
> > > > @@ -438,7 +438,7 @@ static int ehci_hcd_omap_drv_probe(struct platform_device *dev)
> > > >         hcd->rsrc_start = dev->resource[0].start;
> > > >         hcd->rsrc_len = dev->resource[0].end - dev->resource[0].start + 1;
> > > >
> > > > -       hcd->regs = (void __iomem *) (int) IO_ADDRESS(hcd->rsrc_start);
> > > > +       hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);

I have seen this ioremap() call causes problems on OMAP34xx/24xx as the reg memory is already mapped.
Will have to check on the board once.

> > >
> > > Return value check?
> >
> > Good one. Here's a new version:
> >
> > ===== cut here ====
> >
> > From: Felipe Balbi <felipe.balbi@nokia.com>
> > Subject: [patch] omap: usb: ehci: fix usb of hcd->regs
> >
> > hcd->regs should be initialized by ioremaping hcd->rsrc_start and
> > hcd->rsrc_len. Fix it for ehci-omap.c.
> 
> Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> 
> > Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

