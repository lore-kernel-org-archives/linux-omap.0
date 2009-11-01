From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH] OMAP1: PM: Fix omapfb/lcd on Amstrad Delta broken when PM set
Date: Sun, 1 Nov 2009 02:18:26 +0100
Message-ID: <200911010218.29347.jkrzyszt@tis.icnet.pl>
References: <200910292339.48610.jkrzyszt@tis.icnet.pl> <200910301542.27206.jkrzyszt@tis.icnet.pl> <20091030173317.GX7180@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:49337 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755556AbZKABVF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 Oct 2009 21:21:05 -0400
In-Reply-To: <20091030173317.GX7180@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Jonathan McDowell <noodles@earth.li>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Imre Deak <imre.deak@nokia.com>, linux-fbdev-devel@lists.sourceforge.net, Paul Walmsley <paul@pwsan.com>

=46riday 30 October 2009 18:33:18 Tony Lindgren napisa=C5=82(a):
> * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091030 07:43]:
> > Thursday 29 October 2009 23:39:44 Janusz Krzysztofik napisa=C5=82(a=
):
> > > With CONFIG_PM=3Dy, the omapfb/lcd device on Amstrad Delta, after
> > > initially starting correctly, breaks with the following error mes=
sages:
> > >
> > > omapfb omapfb: resetting (status 0xffffff96,reset count 1)
> > > ...
> > > omapfb omapfb: resetting (status 0xffffff96,reset count 100)
> > > omapfb omapfb: too many reset attempts, giving up.
> > >
> > > Looking closer at this I have found that it had been broken almos=
t 2
> > > years ago with commit 2418996e3b100114edb2ae110d5d4acb928909d2, P=
M
> > > fixes for OMAP1.
> > >
> > > The definite reason for broken omapfb/lcd_ams_delta in PM mode ap=
peared
> > > to be ARM_IDLECT1:IDLIF_ARM (bit 6) put into idle. The patch belo=
w
> > > fixes it.
> > >
> > > Since PM area is quite new to me, I am not sure if there may be a
> > > better solution. AFAICS, the standard way to prevent an ARM_CLKCT=
1 bit
> > > being switched to idle is to enable a clock that uses it (tipb_ck=
,
> > > dma_ck, or tc_ck or one of its children in this case, right?).
> > >
> > > I assume there is no bug in omapfb nor lcdc, as that would be alr=
eady
> > > detected. Maybe it would be better to fix
> > > drivers/video/omap/lcd_ams_delta.c (or
> > > arch/arm/mach-omap1/board-ams-delta), but I don't know what clock
> > > should I enable, if any.
> >
> > More looking at it, I found that might be omap_dma_running() from
> > arch/arm/plat-omap/dma.c that needs correction. It already checks f=
or LCD
> > dma running for OMAP1610, but does nothing similiar for 1510. I hav=
e
> > revisited http://focus.ti.com/lit/ug/spru674/spru674.pdf, but found=
 no
> > hint how to do that in a 1610 similiar way.
>
> Hmm to me it looks like the OMAP_DMA_CCR_EN should be set in one of t=
he
> channels if enabled. Maybe you need add a similar check somewhere in
> the *_lcd_dma_* functions too in dma.c?

Tony,
It sounds reasonable, but the problem is that in the OMAP5910 documenta=
tion I=20
can find no DMA_CCR equivalent in the LCD dedicated DMA channel registe=
r set,=20
nor EN equivalent in the DMA_LCD_CTRL register.

I have had a look at *_lcd_dma_*, as you suggested, and found this:

        /*
         * Set the Enable bit only if an external controller is
         * connected. Otherwise the OMAP internal controller will
         * start the transfer when it gets enabled.
         */
        if (enable_1510_mode || !lcd_dma.ext_ctrl)
                return;

That may suggest checking for LCD controller, not DMA channel, enable b=
it=20
could give an answer if LCD DMA is likely to be running or not. So mayb=
e=20
adding a function to drivers/video/omap/lcdc.c that would check for=20
OMAP_LCDC_CONTROL:OMAP_LCDC_CTRL_LCD_EN, then invoke that function from=
=20
omap_dma_running() in case of omap1510 could be a proper solution.

However, that would affect not only Amstrad Delta, but all 1510 based=20
machines. Since there were no reports about broken LCD DMA on 1510, I'd=
=20
rather get a confirmation from omap guys, more experienced than me, tha=
t the=20
solution proposed is correct and should work not only for my Amstrad De=
lta=20
before I get that way.

Thanks,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
