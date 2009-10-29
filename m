From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH 3/3] omap3evm: musb: Update power capability for
 OMAP3EVM (Rev >= E)
Date: Thu, 29 Oct 2009 00:35:32 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C012AD6DBEA@dlee02.ent.ti.com>
References: <1256742758-32702-1-git-send-email-ajay.gupta@ti.com>
 <1256742758-32702-2-git-send-email-ajay.gupta@ti.com>
 <1256742758-32702-3-git-send-email-ajay.gupta@ti.com>,<7A436F7769CA33409C6B44B358BFFF0C012AD6D86F@dlee02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0309C8627C@dbde02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E73940436EEAF1F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52697 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753323AbZJ2Ffd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Oct 2009 01:35:33 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E73940436EEAF1F@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "tony@atomide.com" <tony@atomide.com>

> From: Gupta, Ajay Kumar
> Sent: Thursday, October 29, 2009 7:10 AM
> >
> > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > > owner@vger.kernel.org] On Behalf Of Gupta, Ajay Kumar
> > > > Sent: Wednesday, October 28, 2009 5:13 PM
> > > >
> > > [...]
> > > > diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-
> omap2/usb-
> > > > musb.c
> > > > index a80441d..529e2b1 100644
> > > > --- a/arch/arm/mach-omap2/usb-musb.c
> > > > +++ b/arch/arm/mach-omap2/usb-musb.c
> > > > @@ -148,10 +148,14 @@ static struct platform_device musb_device = {
> > > >
> > > >  void __init usb_musb_init(void)
> > > >  {
> > > > -     if (cpu_is_omap243x())
> > > > +     if (cpu_is_omap243x()) {
> > > >               musb_resources[0].start = OMAP243X_HS_BASE;
> > > > -     else
> > > > +     } else {
> > > Do you need {} for a one liner? Checkpatch should have warned you I
> > think..
> > >
> >
> > Er, CodingStyle says you need to do this, if the else clause
> > has brackets.
> 
> Correct and also checkpatch didn't give any warning for this.
Thanks.. 

> 
> >
> > > >               musb_resources[0].start = OMAP34XX_HSUSB_OTG_BASE;
> > > > +             /* OMAP3EVM Rev >= E can source 500mA */
> > > > +             if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2)
> > > > +                     musb_plat.power = 250;
> > > > +     }
> > > >       musb_resources[0].end = musb_resources[0].start + SZ_8K - 1;
> > > >
> > > >       /*
> > > > diff --git a/drivers/usb/musb/musb_regs.h
> > b/drivers/usb/musb/musb_regs.h
> > > > index cc1d71b..a0314df 100644
> > > > --- a/drivers/usb/musb/musb_regs.h
> > > > +++ b/drivers/usb/musb/musb_regs.h
> > > > @@ -72,6 +72,10 @@
> > > >  #define MUSB_DEVCTL_HR               0x02
> > > >  #define MUSB_DEVCTL_SESSION  0x01
> > > >
> > > > +/* ULPI VBUSCONTROL */
> > > > +#define ULPI_USE_EXTVBUS     0x01
> > > > +#define ULPI_USE_EXTVBUSIND  0x02
> > > > +
> > > >  /* TESTMODE */
> > > >  #define MUSB_TEST_FORCE_HOST 0x80
> > > >  #define MUSB_TEST_FIFO_ACCESS        0x40
> > > > @@ -246,6 +250,7 @@
> > > >
> > > >  /* REVISIT: vctrl/vstatus: optional vendor utmi+phy register at
> 0x68
> > */
> > > >  #define MUSB_HWVERS          0x6C    /* 8 bit */
> > > > +#define MUSB_ULPI_BUSCONTROL 0x70    /* 8 bit */
> > > >
> > > >  #define MUSB_EPINFO          0x78    /* 8 bit */
> > > >  #define MUSB_RAMINFO         0x79    /* 8 bit */
> > > > diff --git a/drivers/usb/musb/omap2430.c
> b/drivers/usb/musb/omap2430.c
> > > > index 6761d20..c5fcc30 100644
> > > > --- a/drivers/usb/musb/omap2430.c
> > > > +++ b/drivers/usb/musb/omap2430.c
> > > > @@ -36,6 +36,7 @@
> > > >  #include <asm/mach-types.h>
> > > >  #include <mach/hardware.h>
> > > >  #include <plat/mux.h>
> > > > +#include <plat/board.h>
> > > >
> > > >  #include "musb_core.h"
> > > >  #include "omap2430.h"
> > > > @@ -203,6 +204,7 @@ int musb_platform_set_mode(struct musb *musb, u8
> > > > musb_mode)
> > > >  int __init musb_platform_init(struct musb *musb)
> > > >  {
> > > >       u32 l;
> > > > +     u8 val;
> > > >
> > > >  #if defined(CONFIG_ARCH_OMAP2430)
> > > >       omap_cfg_reg(AE5_2430_USB0HS_STP);
> > > > @@ -239,6 +241,13 @@ int __init musb_platform_init(struct musb
> *musb)
> > > >       l |= ULPI_12PIN;
> > > >       omap_writel(l, OTG_INTERFSEL);
> > > >
> > > > +     /* Program PHY to use external Vbus supply for OMAP3EVM Rev >=
> E
> > */
> > > > +     if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2) {
> > > > +             val = musb_readb(musb->mregs, MUSB_ULPI_BUSCONTROL);
> > > > +             val |= ULPI_USE_EXTVBUS;
> > > > +             musb_writeb(musb->mregs, MUSB_ULPI_BUSCONTROL, val);
> > > > +     }
> > > Do we want to do board specific logic inside a IP logic? Wont it be
> > better to do it some way else?
> 
> We need to access musb controller register to program this so It has to be
> In musb_platform_init() only but As Anand suggested we can use some flag
> From board file to avoid omap3_evm specific check here.
> 
> >
> > Maybe add a flag to pass down from the board files? I think other
> > boards might also end up using this.
> 
> Looks good. I will take this in next revision.
Thanks again.. that might be a good thing to have.

Regards,
Nishanth Menon

