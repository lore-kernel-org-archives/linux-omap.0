From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 3/3] omap3evm: musb: Update power capability for
 OMAP3EVM (Rev >= E)
Date: Thu, 29 Oct 2009 08:58:38 +0200
Message-ID: <20091029065838.GA27534@nokia.com>
References: <1256742758-32702-1-git-send-email-ajay.gupta@ti.com>
 <1256742758-32702-2-git-send-email-ajay.gupta@ti.com>
 <1256742758-32702-3-git-send-email-ajay.gupta@ti.com>
 <7A436F7769CA33409C6B44B358BFFF0C012AD6D86F@dlee02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0309C8627C@dbde02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E73940436EEAF1F@dbde02.ent.ti.com>
 <7A436F7769CA33409C6B44B358BFFF0C012AD6DBEA@dlee02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E73940436EEAF59@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:36277 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756493AbZJ2G64 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Oct 2009 02:58:56 -0400
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E73940436EEAF59@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>

Hi,

On Thu, Oct 29, 2009 at 06:56:03AM +0100, ext Gupta, Ajay Kumar wrote:
> Felipe,
> > -----Original Message-----
> > From: Menon, Nishanth
> > Sent: Thursday, October 29, 2009 11:06 AM
> > To: Gupta, Ajay Kumar; Gadiyar, Anand; linux-omap@vger.kernel.org
> > Cc: felipe.balbi@nokia.com; tony@atomide.com
> > Subject: RE: [PATCH 3/3] omap3evm: musb: Update power capability for
> > OMAP3EVM (Rev >= E)
> > 
> > > From: Gupta, Ajay Kumar
> > > Sent: Thursday, October 29, 2009 7:10 AM
> > > >
> > > > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > > > > owner@vger.kernel.org] On Behalf Of Gupta, Ajay Kumar
> > > > > > Sent: Wednesday, October 28, 2009 5:13 PM
> > > > > >
> > > > > [...]
> > > > > > diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-
> > > omap2/usb-
> > > > > > musb.c
> > > > > > index a80441d..529e2b1 100644
> > > > > > --- a/arch/arm/mach-omap2/usb-musb.c
> > > > > > +++ b/arch/arm/mach-omap2/usb-musb.c
> > > > > > @@ -148,10 +148,14 @@ static struct platform_device musb_device =
> > {
> > > > > >
> > > > > >  void __init usb_musb_init(void)
> > > > > >  {
> > > > > > -     if (cpu_is_omap243x())
> > > > > > +     if (cpu_is_omap243x()) {
> > > > > >               musb_resources[0].start = OMAP243X_HS_BASE;
> > > > > > -     else
> > > > > > +     } else {
> > > > > Do you need {} for a one liner? Checkpatch should have warned you I
> > > > think..
> > > > >
> > > >
> > > > Er, CodingStyle says you need to do this, if the else clause
> > > > has brackets.
> > >
> > > Correct and also checkpatch didn't give any warning for this.
> > Thanks..
> > 
> > >
> > > >
> > > > > >               musb_resources[0].start = OMAP34XX_HSUSB_OTG_BASE;
> > > > > > +             /* OMAP3EVM Rev >= E can source 500mA */
> > > > > > +             if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2)
> > > > > > +                     musb_plat.power = 250;
> > > > > > +     }
> 
> Felipe,
> 
> How about moving the platform specific data (musb_hdrc_platform_data) moved to board-x.c file from usb-musb.c (same as ehci). This would avoid using omap3evm specific check in usb-musb.c files.

I was thinking on adding a musb_hdrc_board_data which would group
board-specific data such as this one.

Musb's init phase is quite messy as of today so we would need to clean
that up. Anyways, the main idea is:

board will call usb_musb_init() with a musb_hdrc_board_data * as
parameter. usb-musb would still hold a static struct
musb_hdrc_platform_data for the (in our case) OMAP-specific init, those
would be passed down to driver and init phase would be done as
following:

musb_init()
	-> musb_platform_init()
		-> musb_board_init()

we could also have board_ops and platform_ops structures for the
function pointers to be passed to musb_core.c Then all init could be
done there.

What do you say ???

-- 
balbi
