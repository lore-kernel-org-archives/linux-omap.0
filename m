From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [patch] omap: usb: ehci: fix use of hcd->regs
Date: Fri, 12 Sep 2008 15:30:10 +0300
Message-ID: <20080912123010.GI759@gandalf.research.nokia.com>
References: <20080912121024.GG759@gandalf.research.nokia.com> <20080912.151404.108681717.Hiroshi.DOYU@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:26205 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754642AbYILMad (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2008 08:30:33 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8CCU4qh002733
	for <linux-omap@vger.kernel.org>; Fri, 12 Sep 2008 15:30:31 +0300
Content-Disposition: inline
In-Reply-To: <20080912.151404.108681717.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: felipe.balbi@nokia.com, linux-omap@vger.kernel.org

On Fri, Sep 12, 2008 at 03:14:04PM +0300, Hiroshi DOYU wrote:
> From: "ext Felipe Balbi" <felipe.balbi@nokia.com>
> Subject: [patch] omap: usb: ehci: fix use of hcd->regs
> Date: Fri, 12 Sep 2008 15:10:24 +0300
> 
> > hcd->regs should be initialized by ioremaping hcd->rsrc_start and
> > hcd->rsrc_len. Fix it for ehci-omap.c.
> > 
> > Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> > ---
> > 
> > diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> > index 8f122e5..a67533d 100644
> > --- a/drivers/usb/host/ehci-omap.c
> > +++ b/drivers/usb/host/ehci-omap.c
> > @@ -438,7 +438,7 @@ static int ehci_hcd_omap_drv_probe(struct platform_device *dev)
> >         hcd->rsrc_start = dev->resource[0].start;
> >         hcd->rsrc_len = dev->resource[0].end - dev->resource[0].start + 1;
> >  
> > -       hcd->regs = (void __iomem *) (int) IO_ADDRESS(hcd->rsrc_start);
> > +       hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
> 
> Return value check?

Good one. Here's a new version:

===== cut here ====

From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [patch] omap: usb: ehci: fix usb of hcd->regs

hcd->regs should be initialized by ioremaping hcd->rsrc_start and
hcd->rsrc_len. Fix it for ehci-omap.c.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 8f122e5..4cafa79 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -438,7 +438,11 @@ static int ehci_hcd_omap_drv_probe(struct platform_device *dev)
        hcd->rsrc_start = dev->resource[0].start;
        hcd->rsrc_len = dev->resource[0].end - dev->resource[0].start + 1;
 
-       hcd->regs = (void __iomem *) (int) IO_ADDRESS(hcd->rsrc_start);
+       hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
+       if (!hcd->regs) {
+               dev_err(&dev->dev, "ioremap failed\n");
+               return -ENOMEM;
+       }
 
        ehci = hcd_to_ehci(hcd);
        ehci->caps = hcd->regs;


-- 
balbi
