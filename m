From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP1: PM: Fix omapfb/lcd on Amstrad Delta broken when
 PM set
Date: Tue, 3 Nov 2009 09:11:34 -0800
Message-ID: <20091103171133.GJ8981@atomide.com>
References: <200910292339.48610.jkrzyszt@tis.icnet.pl>
 <200910301542.27206.jkrzyszt@tis.icnet.pl>
 <20091030173317.GX7180@atomide.com>
 <200911010218.29347.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58931 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbZKCRLj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 12:11:39 -0500
Content-Disposition: inline
In-Reply-To: <200911010218.29347.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Jonathan McDowell <noodles@earth.li>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Imre Deak <imre.deak@nokia.com>, linux-fbdev-devel@lists.sourceforge.net, Paul Walmsley <paul@pwsan.com>

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091031 18:20]:
> Friday 30 October 2009 18:33:18 Tony Lindgren napisa=C5=82(a):
> > * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091030 07:43]:
> > > Thursday 29 October 2009 23:39:44 Janusz Krzysztofik napisa=C5=82=
(a):
> > > > With CONFIG_PM=3Dy, the omapfb/lcd device on Amstrad Delta, aft=
er
> > > > initially starting correctly, breaks with the following error m=
essages:
> > > >
> > > > omapfb omapfb: resetting (status 0xffffff96,reset count 1)
> > > > ...
> > > > omapfb omapfb: resetting (status 0xffffff96,reset count 100)
> > > > omapfb omapfb: too many reset attempts, giving up.
> > > >
> > > > Looking closer at this I have found that it had been broken alm=
ost 2
> > > > years ago with commit 2418996e3b100114edb2ae110d5d4acb928909d2,=
 PM
> > > > fixes for OMAP1.
> > > >
> > > > The definite reason for broken omapfb/lcd_ams_delta in PM mode =
appeared
> > > > to be ARM_IDLECT1:IDLIF_ARM (bit 6) put into idle. The patch be=
low
> > > > fixes it.
> > > >
> > > > Since PM area is quite new to me, I am not sure if there may be=
 a
> > > > better solution. AFAICS, the standard way to prevent an ARM_CLK=
CT1 bit
> > > > being switched to idle is to enable a clock that uses it (tipb_=
ck,
> > > > dma_ck, or tc_ck or one of its children in this case, right?).
> > > >
> > > > I assume there is no bug in omapfb nor lcdc, as that would be a=
lready
> > > > detected. Maybe it would be better to fix
> > > > drivers/video/omap/lcd_ams_delta.c (or
> > > > arch/arm/mach-omap1/board-ams-delta), but I don't know what clo=
ck
> > > > should I enable, if any.
> > >
> > > More looking at it, I found that might be omap_dma_running() from
> > > arch/arm/plat-omap/dma.c that needs correction. It already checks=
 for LCD
> > > dma running for OMAP1610, but does nothing similiar for 1510. I h=
ave
> > > revisited http://focus.ti.com/lit/ug/spru674/spru674.pdf, but fou=
nd no
> > > hint how to do that in a 1610 similiar way.
> >
> > Hmm to me it looks like the OMAP_DMA_CCR_EN should be set in one of=
 the
> > channels if enabled. Maybe you need add a similar check somewhere i=
n
> > the *_lcd_dma_* functions too in dma.c?
>=20
> Tony,
> It sounds reasonable, but the problem is that in the OMAP5910 documen=
tation I=20
> can find no DMA_CCR equivalent in the LCD dedicated DMA channel regis=
ter set,=20
> nor EN equivalent in the DMA_LCD_CTRL register.
>=20
> I have had a look at *_lcd_dma_*, as you suggested, and found this:
>=20
>         /*
>          * Set the Enable bit only if an external controller is
>          * connected. Otherwise the OMAP internal controller will
>          * start the transfer when it gets enabled.
>          */
>         if (enable_1510_mode || !lcd_dma.ext_ctrl)
>                 return;
>=20
> That may suggest checking for LCD controller, not DMA channel, enable=
 bit=20
> could give an answer if LCD DMA is likely to be running or not. So ma=
ybe=20
> adding a function to drivers/video/omap/lcdc.c that would check for=20
> OMAP_LCDC_CONTROL:OMAP_LCDC_CTRL_LCD_EN, then invoke that function fr=
om=20
> omap_dma_running() in case of omap1510 could be a proper solution.
>=20
> However, that would affect not only Amstrad Delta, but all 1510 based=
=20
> machines. Since there were no reports about broken LCD DMA on 1510, I=
'd=20
> rather get a confirmation from omap guys, more experienced than me, t=
hat the=20
> solution proposed is correct and should work not only for my Amstrad =
Delta=20
> before I get that way.

That sounds like a reasonable way to fix it to me.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
