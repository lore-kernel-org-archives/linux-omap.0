From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP1: PM: Fix omapfb/lcd on Amstrad Delta broken when
	PM set
Date: Fri, 30 Oct 2009 10:33:18 -0700
Message-ID: <20091030173317.GX7180@atomide.com>
References: <200910292339.48610.jkrzyszt@tis.icnet.pl> <200910301542.27206.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58767 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932712AbZJ3RdX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Oct 2009 13:33:23 -0400
Content-Disposition: inline
In-Reply-To: <200910301542.27206.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Jonathan McDowell <noodles@earth.li>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Imre Deak <imre.deak@nokia.com>, linux-fbdev-devel@lists.sourceforge.net, Paul Walmsley <paul@pwsan.com>

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091030 07:43]:
> Thursday 29 October 2009 23:39:44 Janusz Krzysztofik napisa=C5=82(a):
> > With CONFIG_PM=3Dy, the omapfb/lcd device on Amstrad Delta, after i=
nitially
> > starting correctly, breaks with the following error messages:
> >
> > omapfb omapfb: resetting (status 0xffffff96,reset count 1)
> > ...
> > omapfb omapfb: resetting (status 0xffffff96,reset count 100)
> > omapfb omapfb: too many reset attempts, giving up.
> >
> > Looking closer at this I have found that it had been broken almost =
2 years
> > ago with commit 2418996e3b100114edb2ae110d5d4acb928909d2, PM fixes =
for
> > OMAP1.
> >
> > The definite reason for broken omapfb/lcd_ams_delta in PM mode appe=
ared to
> > be ARM_IDLECT1:IDLIF_ARM (bit 6) put into idle. The patch below fix=
es it.
> >
> > Since PM area is quite new to me, I am not sure if there may be a b=
etter
> > solution. AFAICS, the standard way to prevent an ARM_CLKCT1 bit bei=
ng
> > switched to idle is to enable a clock that uses it (tipb_ck, dma_ck=
, or
> > tc_ck or one of its children in this case, right?).
> >
> > I assume there is no bug in omapfb nor lcdc, as that would be alrea=
dy
> > detected. Maybe it would be better to fix
> > drivers/video/omap/lcd_ams_delta.c (or
> > arch/arm/mach-omap1/board-ams-delta), but I don't know what clock s=
hould I
> > enable, if any.
>=20
> More looking at it, I found that might be omap_dma_running() from=20
> arch/arm/plat-omap/dma.c that needs correction. It already checks for=
 LCD dma=20
> running for OMAP1610, but does nothing similiar for 1510. I have revi=
sited=20
> http://focus.ti.com/lit/ug/spru674/spru674.pdf, but found no hint how=
 to do=20
> that in a 1610 similiar way.

Hmm to me it looks like the OMAP_DMA_CCR_EN should be set in one of the
channels if enabled. Maybe you need add a similar check somewhere in
the *_lcd_dma_* functions too in dma.c?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
