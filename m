From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFT/RFC/PATCH 00/31] arm: omap: irq: cleanup INTC driver
Date: Mon, 23 Dec 2013 11:34:09 -0600
Message-ID: <20131223173409.GA10536@saruman.home>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
 <20131219184815.GU27438@atomide.com>
 <20131219232153.GE707@saruman.home>
 <20131221005309.GH26054@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35974 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757827Ab3LWRfS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Dec 2013 12:35:18 -0500
Content-Disposition: inline
In-Reply-To: <20131221005309.GH26054@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2013 at 04:53:09PM -0800, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [131219 15:23]:
> > On Thu, Dec 19, 2013 at 10:48:15AM -0800, Tony Lindgren wrote:
> > > * Felipe Balbi <balbi@ti.com> [131120 10:10]:
> > > > Afte these patches, we're very close to being able
> > > > to move arch/arm/mach-omap2/irq.c to drivers/irqchip/irq-intc.c
> > >=20
> > > That would be nice :)
> > > =20
> > > > All which would be missing is for Tony to drop all OMAP2/3 board
> > > > files so we remove the few pending bits and pieces left in
> > > > for legacy boot.
> > >=20
> > > That may still need to wait a while, but let's see.
> > > =20
> > > > Note that I have only boot tested these on AM335x Bone Black
> > > > (with a small fix for fixed regulator which should be in
> > > > the mailing list already), so I'd need help testing all
> > > > other impacted platforms, specially when it comes to PM.
> > >=20
> > > Sorry have not had much of a chance to test these with PM with
> > > all the fixes needed for omap3 DT mode. Tried testing these
> > > just now, but I get:
> > >=20
> > > arch/arm/mach-omap2/board-generic.c:134: error: =E2=80=98omap_intc_of=
_init=E2=80=99 undeclared here (not in a function)
> >=20
> > some of your other changes messed it up, I have not references of
> > omap_intc_of_init() in my branch, because that's one of the things I'm
> > dropping from DT-based boots.
> >=20
> > Can you see which patch added a new omap_intc_of_init() call ? Or maybe
> > tell me which branch I should rebase on top of ?
>=20
> OK I tried against v3.13-rc4, it's the 3517 changes that caused
> it. Looks like that can be just removed, and then there are some
> trivial n8x0 merge conflicts. And n8x0 boots too.
>=20
> But looks like omap3 off-idle hangs after hitting idle with these,

could it be we're racing between irq_chip.suspend() and hwmod's
_disable() calls ?

> so a bit more work is needed. Maybe also rebase these against
> omap-for-v3.14/dt too?

Will do.

--=20
balbi

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSuHQQAAoJEIaOsuA1yqRE2IwP/0595Dm+FdF9J55j1Qt2d2rR
8L268FSlzKdtJvZuH0s7epXCgs0tXmFmVUVuWLWpIDfWvW3VQQMaoiUsEe+wpRzs
wXuMOS+GsMqSHDNs4V3HMQKizRoFozgmYy2bbp9H0ljVeWIQVNnP0t/emPjfolPc
zUdpE48J0L3zzkpLxn+D996Vr5M/UY6NrAy6jjBXynAgPpy3lcLxWnblAsUUp+/g
R+pxHpYEDB3NemVUDRuNXOYWVSp5J29mHWjaCGByB6f0aVm6NLcCDf/yNTT4D2Ec
Qck+lA+BEoxT3S9Cs7txGTkZxj0dK96zb5UU2/nWWQ6J97SnsZw17NkQX/wiZ811
GBkumrkO1sjzmwViVgxXzGnmhvjP7q/kyVOB7nP4Iz5UXwcqHzyqMPd8gxJKJ7RX
mbcqIrkX30qCHdimVPm32Wppcz41Uo/b27/aNAgr/IqM4INhN5EFk/hIYw284Oyr
6wS/mvxduFuzvJUYO/pmYk+zaaf/IOzudU6HYbb3hYTxBqO1mTapY8vYhMQ7hmg7
aZ491z39nWTBXs6nxR2UI4mpHtc3N9SzoSOk3oFxgtVnoSYoSUtC4x6APQNoT6rE
3Yjyn2vc9huJwfGlcSEBWpKrSfzHKzblzs41YSV3OchZKm0lZCOh7kK6+jI/N0nq
idFxwpWL/Oq/W0O7qfA+
=bZxx
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
