From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 3/8] musb: fix compilation warning in host only mode
Date: Thu, 17 Jun 2010 17:39:35 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E91B843@dbde02.ent.ti.com>
References: <1276771242-5201-1-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-2-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-3-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-4-git-send-email-ajay.gupta@ti.com>
 <4C1A0499.9020802@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59513 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164Ab0FQMJv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jun 2010 08:09:51 -0400
In-Reply-To: <4C1A0499.9020802@ru.mvista.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "gregkh@suse.de" <gregkh@suse.de>

> > Fixes below compilation warning when host only configuration is
> > selected.
> > drivers/usb/musb/musb_core.c: In function 'musb_stage0_irq':
> > drivers/usb/musb/musb_core.c:711: warning: unused variable 'mbase'
> 
> > Also removed definition of 'mbase' from multiple places to only
> > at function top.
> 
>     AFAIR, it was intentionally removed from the function top and declared
> in the multiple plcase instead by the former Felipe's patch [1] to fix
> exactly the same issue, if I don't mistake. So, it hasn't worked out?

Yes, it was removed by Felipe's below patch but it introduced
compilation warning issue as reported.

---------------
commit aa4714560b4ea359bb7830188ebd06bce71bcdea
usb: musb: core: declare mbase only where it's used

... and avoid a compilation if we disable host side
of musb.
--------------

> 
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> [...]
> > diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> > index f0ff893..7cc8398 100644
> > --- a/drivers/usb/musb/musb_core.c
> > +++ b/drivers/usb/musb/musb_core.c
> > @@ -455,6 +455,9 @@ static irqreturn_t musb_stage0_irq(struct musb
> *musb, u8 int_usb,
> >  				u8 devctl, u8 power)
> >  {
> >  	irqreturn_t handled = IRQ_NONE;
> > +#ifdef CONFIG_USB_MUSB_HDRC_HCD
> > +	void __iomem	*mbase = musb->mregs;
> > +#endif
> 
>     I'd rather see it declared multiple times...

I was thinking it's better to have it at one place and avoid multiple
#ifdefs.

-Ajay
> 
> > @@ -703,7 +700,6 @@ static irqreturn_t musb_stage0_irq(struct musb
> *musb, u8 int_usb,
> >
> >  	if (int_usb & MUSB_INTR_CONNECT) {
> >  		struct usb_hcd *hcd = musb_to_hcd(musb);
> > -		void __iomem *mbase = musb->mregs;
> 
>     We could also move this into the #ifdef CONFIG_USB_MUSB_OTG block.
> 
> >
> >  		handled = IRQ_HANDLED;
> >  		musb->is_active = 1;
> 
> [1]
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-
> 2.6.git;a=commitdiff;h=aa4714560b4ea359bb7830188ebd06bce71bcdea
> 
> WBR, Sergei
