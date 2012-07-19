From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH v3 04/11] usb: otg: nop: add support for multiple
 tranceiver
Date: Thu, 19 Jul 2012 10:15:47 +0000
Message-ID: <47CEF8C4B26E8C44B22B028A650E0EA93EADDADE@DBDE01.ent.ti.com>
References: <1342676499-32507-1-git-send-email-ajay.gupta@ti.com>
	<1342676499-32507-5-git-send-email-ajay.gupta@ti.com>
 <CAAe_U6+a_8hoJgdHfLGyMeg6EMmkfkP1Zow9avRTgG6EpV5p1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44859 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752386Ab2GSKP5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Jul 2012 06:15:57 -0400
In-Reply-To: <CAAe_U6+a_8hoJgdHfLGyMeg6EMmkfkP1Zow9avRTgG6EpV5p1Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "tony@atomide.com" <tony@atomide.com>

Hi,
> > Currently we have one single nop transceiver support as same is
> > defined as a global variable in drivers/usb/otg/nop-usb-xceiv.c.
> > This need to be changed to support multiple otg controller each
> > using nop transceiver on a platform such as am335x.
> >
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> > ---
> >  arch/arm/mach-omap2/board-omap3evm.c |    2 +-
> >  drivers/usb/musb/am35x.c             |    4 ++--
> >  drivers/usb/musb/blackfin.c          |    4 ++--
> >  drivers/usb/musb/da8xx.c             |    4 ++--
> >  drivers/usb/musb/davinci.c           |    6 +++---
> >  drivers/usb/musb/musb_dsps.c         |   10 +++++-----
> >  drivers/usb/musb/tusb6010.c          |    6 +++---
> >  drivers/usb/otg/nop-usb-xceiv.c      |   20 ++++++++++++--------
> >  include/linux/usb/otg.h              |    9 +++++----
> >  9 files changed, 35 insertions(+), 30 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-
> omap2/board-omap3evm.c
> > index ef230a0..a3393bc 100644
[...]
> > diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
> > index 4636d39..36cc791 100644
> > --- a/include/linux/usb/otg.h
> > +++ b/include/linux/usb/otg.h
> > @@ -95,6 +95,7 @@ struct usb_phy {
> >         struct device           *dev;
> >         const char              *label;
> >         unsigned int             flags;
> > +       u8                      id;
> 
> Do we really need to have *id* in phy??

I will update the patches dropping this.

> >
> >         enum usb_phy_type       type;
> >         enum usb_otg_state      state;
> > @@ -137,14 +138,14 @@ extern void usb_remove_phy(struct usb_phy *);
> >
> >  #if defined(CONFIG_NOP_USB_XCEIV) ||
> (defined(CONFIG_NOP_USB_XCEIV_MODULE) && defined(MODULE))
> >  /* sometimes transceivers are accessed only through e.g. ULPI */

> > -extern void usb_nop_xceiv_register(void);
> > -extern void usb_nop_xceiv_unregister(void);
> > +extern void usb_nop_xceiv_register(int id);
> > +extern void usb_nop_xceiv_unregister(struct usb_phy *);

> IMHO,  these declarations shouldn't be in usb/otg.h. It can be in a
> header file specific to usb_nop?

They were in otg.h and just definition getting changed so I think they
need to be in otg.h only as a logical change of this patch.

Location can be changed as a separate patch later.

Thanks,
Ajay
> 
> Thanks
> Kishon
