From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 1/2 v2] musb: Add context save and restore support
Date: Thu, 26 Nov 2009 15:33:57 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404370D7BF1@dbde02.ent.ti.com>
References: <1259217599-17793-1-git-send-email-ajay.gupta@ti.com>
 <4B0E4449.8030701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42246 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638AbZKZKEA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Nov 2009 05:04:00 -0500
In-Reply-To: <4B0E4449.8030701@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "Gadiyar, Anand" <gadiyar@ti.com>

Hi,
> -----Original Message-----
> From: Dasgupta, Romit
> Sent: Thursday, November 26, 2009 2:33 PM
> To: Gupta, Ajay Kumar
> Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org;
> felipe.balbi@nokia.com; Gadiyar, Anand
> Subject: Re: [PATCH 1/2 v2] musb: Add context save and restore support
> 
> > --- a/drivers/usb/musb/musb_core.c
> > +++ b/drivers/usb/musb/musb_core.c
> > @@ -2167,21 +2167,163 @@ static int __devexit musb_remove(struct
> platform_device *pdev)
> >
> >  #ifdef CONFIG_PM
> >
> > +static struct musb_context_registers musb_context;
> > +
> > +void musb_save_context(void __iomem *musb_base)
> > +{
> > +       int i;
> > +
> > +       musb_context.faddr = musb_readb(musb_base, MUSB_FADDR);
> > +       musb_context.power = musb_readb(musb_base, MUSB_POWER);
> > +       musb_context.intrtxe = musb_readw(musb_base, MUSB_INTRTXE);
> > +       musb_context.intrrxe = musb_readw(musb_base, MUSB_INTRRXE);
> > +       musb_context.intrusbe = musb_readb(musb_base, MUSB_INTRUSBE);

> > +       musb_context.frame = musb_readw(musb_base, MUSB_FRAME);
> Not necessary for gadget
> > +       musb_context.testmode = musb_readb(musb_base, MUSB_TESTMODE);
> Not sure if it is necessary for gadget.

Right!

..so we can all #ifdefs to save/restore gadget or host only registers.
 

> > +       musb_context.index = musb_readb(musb_base, MUSB_INDEX);
> 
> 
<snip>
> > +                               musb_read_txfifosz(musb_base);
> > +               musb_context.index_regs[i].rxfifosz =
> > +                               musb_read_rxfifosz(musb_base);
> 
> If MUSB_CONFIGDATA_DYNFIFO is not set then saving FIFO address and sizes
> are probably not necessary. Not sure if they are detrimental as well.

We can add it within DYNFIFO check.

> > +
> > +               musb_context.index_regs[i].txfunaddr =
> > +                       musb_read_txfunaddr(musb_base, i);
> > +               musb_context.index_regs[i].txhubaddr =

<snip.>

> >                  */
> > +               reg = musb_readb(musb->mregs, MUSB_POWER);
> > +               reg &= ~MUSB_POWER_SOFTCONN;
> > +               musb_writeb(musb->mregs, MUSB_POWER, reg);
> After this softdisconnect when we subsequently get reconnected followed by
> a reset we could have changed our speed (LS,FS, HS).

I didn't get it completely. I think as a peripheral USB speed will remain
same after resume for the gadget driver it was before suspend?

If we intend to change the gadget driver then we may have support for a
different speed but it would anyways happen after resume is completed.

Regards,
Ajay
> In your resume 
> routine we are writing back our previous speed. I am not sure here but is 
> it not possible that we have reset the controller and then restored back 
> the old speed overwriting the new speed?




