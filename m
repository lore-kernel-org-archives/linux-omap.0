From: Felipe Balbi <balbi@ti.com>
Subject: Re: 3.18.1->3.19-rc2: In-band Error seen by MPU
Date: Mon, 5 Jan 2015 20:02:22 -0600
Message-ID: <20150106020222.GB24980@saruman>
References: <20150102161911.GA3298@atomide.com>
 <54A6E408.1090908@gmx.net>
 <20150102201908.GK582@fuloong-minipc.musicnaut.iki.fi>
 <20150102204018.GF3298@atomide.com>
 <20150102223451.GL582@fuloong-minipc.musicnaut.iki.fi>
 <20150103000220.GE3279@atomide.com>
 <20150103121622.GN582@fuloong-minipc.musicnaut.iki.fi>
 <20150105154313.GA19336@saruman>
 <20150105231620.GC30544@fuloong-minipc.musicnaut.iki.fi>
 <20150106001251.GQ4081@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52886 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754538AbbAFCDW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Jan 2015 21:03:22 -0500
Content-Disposition: inline
In-Reply-To: <20150106001251.GQ4081@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Felipe Balbi <balbi@ti.com>, Peter =?iso-8859-1?Q?K=FCmmel?= <syntheticpp@gmx.net>, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Russell King <rmk+kernel@arm.linux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>

--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 05, 2015 at 04:12:51PM -0800, Tony Lindgren wrote:
> * Aaro Koskinen <aaro.koskinen@iki.fi> [150105 15:19]:
> > Hi,
> >=20
> > On Mon, Jan 05, 2015 at 09:43:13AM -0600, Felipe Balbi wrote:
> > > On Sat, Jan 03, 2015 at 02:16:22PM +0200, Aaro Koskinen wrote:
> > > > > > > > > >>>When updating (custom DM3730 board) from 3.18.1 ro 3.1=
9-rc2
> > > > > > > > > >>>I see a "In-band ERROR" warning which wasn't present i=
n 3.18.1.
> > > > > > > > > >>>Could it be that I missed some DT updates?
> > > > > > > > > >>
> > > > > > > > > >>>[    0.366882] In-band Error seen by MPU  at address 0
> > > > > > > > > >>>[    0.366912] ------------[ cut here ]------------
> > > > > > > > > >>>[    0.366943] WARNING: CPU: 0 PID: 1 at drivers/bus/o=
map_l3_smx.c:166 omap3_l3_app_irq+0x100/0x134()
> > > > > > > > > >>
> > > > > > > > > >>This appears also on N900/N950/N9...
> > > > > > > > > >
> > > > > > > > > >Do you have CONFIG_PREEMPT enabled? It seems there's some
> > > > > > > > > >regression related to CONFIG_PREEMPT that started happen=
ing
> > > > > > > > > >with the merge window?
> > > > > > > > >=20
> > > > > > > > > Indeed, when I disable CONFIG_PREEMPT the warning is gone.
> > > > > > > >=20
> > > > > > > > Yeah, disabling CONFIG_PREEMPT helps here too. Is there som=
e e-mail
> > > > > > > > thread / patch set for this already; or should we try to bi=
sect this?
> > > > > > >=20
> > > > > > > AFAIK I'm not aware of other threads, I noticied it with the
> > > > > > > "OMAP 4430 SDP: rather sick with recent kernels" thread, but
> > > > > > > never got anywhere with it.
> > > > > > >=20
> > > > > > > Yeah it seems it's somewhere between v3.18 and v3.19-rc1, but
> > > > > > > that too should be verified. Sounds like running git bisect on
> > > > > > > this one is needed.
> > > > > >=20
> > > > > > I tried to bisect this on N950, and it resulted in:
> > > > > >=20
> > > > > > aa25729cfd9709156661bea0f9293deb7729f57a is the first bad commit
> > > > > > commit aa25729cfd9709156661bea0f9293deb7729f57a
> > > > > > Author: Tony Lindgren <tony@atomide.com>
> > > > > > Date:   Wed Nov 5 09:21:23 2014 -0800
> > > > > >=20
> > > > > >     ARM: OMAP3: Fix errors for omap_l3_smx when booted with dev=
ice tree
> > > > > >=20
> > > > > > But when I tried to revert this from 3.19-rc2, my board won't b=
oot at
> > > > > > all...
> > > > >=20
> > > > > Hmm OK that commit just fixed the omap_l3_smx so we now see
> > > > > warnings about the unclocked register access.
> > > > >=20
> > > > > It seems that probably the CONFIG_PREEMPT issue has been lurking
> > > > > around for longer but we have not seen any errors because
> > > > > omap_l3_smx just recently started exposing them.
> > > > >=20
> > > > > Does v3.18 + commit aa25729cfd9 manually applied also produce
> > > > > the CONFIG_PREEMPT errors?
> > > >=20
> > > > Yes it does, so I made another bisection between 3.17 and 3.18
> > > > using the above patch to trigger the issue, and I got:
> > > >=20
> > > > 55601c9f24670ba926ebdd4d712ac3b177232330 is the first bad commit
> > > > commit 55601c9f24670ba926ebdd4d712ac3b177232330
> > > > Author: Felipe Balbi <balbi@ti.com>
> > > > Date:   Mon Sep 8 17:54:58 2014 -0700
> > > >=20
> > > >     arm: omap: intc: switch over to linear irq domain
> > >=20
> > > Just booted AM335x with CONFIG_PREEMPT and haven't seen any problem.
> > > Perhaps this is something related to another OMAP3-only driver ? Perh=
aps
> > > HSI/SSI ?
> >=20
> > I did some debugging and it seems the "In-band Error"
> > occurs when omap_system_dma_probe() is being run, specifically when
> > the interrupt is enabled. I believe the "DMA" interrupt it's trying
> > set up is completely wrong:
> >=20
> >  28:          0      GPIO   2  DMA
> >=20
> > GPIO 2?! Where is that coming from?
> >=20
> > With the commit before the "arm: omap: intc: switch over
> > to linear irq domain" it seems to be more reasonable:
> >=20
> >  28:          0      INTC  12  DMA
>=20
> Hmm stange. Felipe, chances are this wrong interrupt issue also
> exists on am33xx but it's not showing up as the legacy DMA is not
> being used.

not really, AM335x doesn't use sDMA, only EDMA.

> Note that currently legacy DMA and drivers/dma/omap-dma.c are
> using separate interrupts as they are mappable. It seems this
> issue is affecting legacy DMA.

makes sense now after readin plat-omap/dma.c (that thing needs to go :-)

cheers

--=20
balbi

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUq0IuAAoJEIaOsuA1yqREfTMP/2VPomsQ3eDYqf86F/LIQWVt
KCak5OQhYUGHQ3Kn/Iuz92AaUPaEn+rKXgpxCqfMoPQ41H+WXMBMRSJxfWFNHXG4
VfzH9OJ8H4uvtQINArwUfxwbPcZnK3acO8CMgPPc7MvZgUBeY++LGd0tLZh79GVj
VxzzLSrhEeNd1XU678HjwpLX+AAEIsi+X2OzJF2DhJnPymVvaHL/0PuX9hVWz/Lm
+Dha9ZS0SO6vPMa28/SYWuNP1T6202pUk8sCY/EbwdkCG3SEKXwkzCq+Ka9+bLi2
desWT64gcxYO7ypWeVbtq6mm0BLGKthF/5BnghBMYtAHTrxdQQ5gGHbvAgSsYGsj
9RrIeZBLeek+yQICgC4nHfZZh7qRhJ/tF/ADWI6prYeycoMnDOlicNX7oGhIJlkH
XJK3Yn4ehodvD9jI5vcl7FgD5nMZVr1mMjaaN/xMGFdj3wSa+rfUbrWx4Zwwtugf
T8Okih9hHKeGRgBE8OgI6MOIrlbHyVKVFehMECgurY6uEbaZTaG+xrbVUfAKBtoE
08156tIekpqY0yvlCVHr15at/imTxrdE4yv9Zzm2IiXLYIVuNHycj6yq955R9N+f
fcFc2IutVO+uROdCnNOuUZ/0V2biuOWMqmr3FUntLaca5022e4kQqJEy6vMxlXYx
v6MiNd1uNqLG9I+OwprE
=7QK1
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
