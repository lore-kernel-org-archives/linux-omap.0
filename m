From: Felipe Balbi <balbi@ti.com>
Subject: Re: Panda: USB crash with today's linux-next
Date: Mon, 14 May 2012 22:35:36 +0300
Message-ID: <20120514193535.GA31886@arwen.pp.htv.fi>
References: <1336996151.2333.3.camel@deskari>
 <20120514121527.GF22242@arwen.pp.htv.fi>
 <1336998251.2333.17.camel@deskari>
 <20120514122920.GK22242@arwen.pp.htv.fi>
 <20120514124757.GL22242@arwen.pp.htv.fi>
 <4FB13B91.7020007@ti.com>
 <20120514175838.GA31200@arwen.pp.htv.fi>
 <20120514181413.GA17852@atomide.com>
 <20120514183742.GB17852@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:40755 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757691Ab2ENTh1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 May 2012 15:37:27 -0400
Received: by laap9 with SMTP id p9so4517757laa.36
        for <linux-omap@vger.kernel.org>; Mon, 14 May 2012 12:37:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120514183742.GB17852@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>, "Venkatraman S." <svenkatr@ti.com>


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2012 at 11:37:43AM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [120514 11:19]:
> > * Felipe Balbi <balbi@ti.com> [120514 11:04]:
> > >=20
> > > That whole MMC card detection is also pretty screwed up. Balaji/Venka=
t,
> > > can you guys look into that ? Probably making something generic using=
 a
> > > threaded IRQ handler ?
> > >=20
> > > I mean, all the MMC core should need is an IRQ number (through GPIOs =
or
> > > not doesn't/shouldn't matter) and it should be able to use a threaded
> > > IRQ handler to kick the card detection/initialization.
> >=20
> > That's mostly done.. Just need to update the patches for it.
>=20
> Mostly done meaning "all the MMC core should need is an IRQ number"
> part that is :)

but you've done it for omap_hsmmc.c, right ? What I meant is that the
whole card detection should be done at the MMC framework level.

I mean, if we tell MMC core what's the card detect IRQ number, it should
be able to implement a generic version of omap_hsmmc_detect(). All that
thing does is read the current gpio status number and call
mmc_detect_change().

mmc_detect_change() then kicks a delayed work, which shouldn't be needed
because omap_hsmmc_detect() (or the generic of it) is already using a
threaded IRQ.

--=20
balbi

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPsV6HAAoJEIaOsuA1yqRE9mQP/i/KESR3h8bHymLEweAIxIAI
dtOIn7+c2g0/hM7mPLF6k6pZyImGRK1BcK1IkgsMMV/DMCDxAhmzWzMNasKpuSBa
jWXKFb6dbHQUpUgTYrBG+31FdZZWATpA+4ALVp3jOKmLp1YJqXqpra5dg8BiPgcW
lD4ALGE8EStVsfPnkx+s2WTuucVAPIrPNNdC6IGVGQoaX5BgzFxZK66RPjpOLBZy
ZeJwY2VVlL13sL+abmZlQTzBXTOrEDq24A+TbDST3jF2mUPHvw97OxdktiCNsYa5
0ELQQomLaaDMM1u+disjBpIt6itzSu5v55vsS4rBtyDqx2HDS0vW283i/fzKXj/p
jqklK4notMba/H4o121ByNwWG/dCk70jeiKfsEE5dCIMeASrjgMZ8QyrUcKQqdg3
KkXwz0bq4flX6+NtvYhgeYhgR5OmL3FsdcyhVZDMhWzRFYovHOX057zN471eqeYV
AiQLhLe3ODsKNuD9UsJNQj99qGZbgvzgOxBqlqvdCJxIh6xqB+Dzv1baN5I4hKst
TsHB+hnx67XRys9JfIyRM7XDktjg25oo6IQlu2bk3Ji76oB+m+YpsQUIfWm02NQ6
R/42UBSAQ7uKXbcUilqlscNauJZWnj+q26D93NnkdCodf5nyGBGQ7/D2gMr/+5ev
dGFuWoc/U4tsm26+McA9
=4v/X
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
