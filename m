From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFT/RFC/PATCH 00/31] arm: omap: irq: cleanup INTC driver
Date: Thu, 2 Jan 2014 16:01:01 -0600
Message-ID: <20140102220101.GA8652@saruman.home>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
 <20131219184815.GU27438@atomide.com>
 <20131219232153.GE707@saruman.home>
 <20131221005309.GH26054@atomide.com>
 <20131223173409.GA10536@saruman.home>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35003 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740AbaABWCT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Jan 2014 17:02:19 -0500
Content-Disposition: inline
In-Reply-To: <20131223173409.GA10536@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 23, 2013 at 11:34:09AM -0600, Felipe Balbi wrote:
> On Fri, Dec 20, 2013 at 04:53:09PM -0800, Tony Lindgren wrote:
> > * Felipe Balbi <balbi@ti.com> [131219 15:23]:
> > > On Thu, Dec 19, 2013 at 10:48:15AM -0800, Tony Lindgren wrote:
> > > > * Felipe Balbi <balbi@ti.com> [131120 10:10]:
> > > > > Afte these patches, we're very close to being able
> > > > > to move arch/arm/mach-omap2/irq.c to drivers/irqchip/irq-intc.c
> > > >=20
> > > > That would be nice :)

added a few patches on top of my branch removing all arch/arm/
dependencies and moving the driver to drivers/irqchip/irq-omap-intc.c

> > > > > Note that I have only boot tested these on AM335x Bone Black
> > > > > (with a small fix for fixed regulator which should be in
> > > > > the mailing list already), so I'd need help testing all
> > > > > other impacted platforms, specially when it comes to PM.
> > > >=20
> > > > Sorry have not had much of a chance to test these with PM with
> > > > all the fixes needed for omap3 DT mode. Tried testing these
> > > > just now, but I get:
> > > >=20
> > > > arch/arm/mach-omap2/board-generic.c:134: error: =E2=80=98omap_intc_=
of_init=E2=80=99 undeclared here (not in a function)
> > >=20
> > > some of your other changes messed it up, I have not references of
> > > omap_intc_of_init() in my branch, because that's one of the things I'm
> > > dropping from DT-based boots.
> > >=20
> > > Can you see which patch added a new omap_intc_of_init() call ? Or may=
be
> > > tell me which branch I should rebase on top of ?
> >=20
> > OK I tried against v3.13-rc4, it's the 3517 changes that caused
> > it. Looks like that can be just removed, and then there are some
> > trivial n8x0 merge conflicts. And n8x0 boots too.
> >=20
> > But looks like omap3 off-idle hangs after hitting idle with these,
>=20
> could it be we're racing between irq_chip.suspend() and hwmod's
> _disable() calls ?

So there are a few possibilities here (and having an OMAP3 platform at
home would help a lot):

a. We're either killing INTC inside hwmod before irq_chip suspend is
	called.

b. We could be calling irq_chip's resume before INTC is enabled again

c. We're loosing interrupts (??)

I might have a really old beagleboard somewhere around, if I do, I'll
try to to boot it up again and track down this regression. Would be
great to see these patches reaching mainline.

> > so a bit more work is needed. Maybe also rebase these against
> > omap-for-v3.14/dt too?
>=20
> Will do.

Rebased on top of omap-for-v3.14/omap3-board-removal. Patches are on my
k.org tree:

git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git wip/omap-fix-in=
tc

cheers

--=20
balbi

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSxeGdAAoJEIaOsuA1yqREej8P/22pH3TS1x+0AC2m57csOSsI
g0MvajSaJ64TS2nxPySUKke4GBrbMuMwD5rkvJaYUduGO5I1a0d4d17aexubLfY4
nB3Nl8FoDZ7j7XbOaOLPdulwC23223X7wPhhqYGGGEtOLz84/LpJZ2DFnFrsK1BN
c4AjSJgKfJJUFBx3PBBFwQt5d97e3gaqoWttY9eTeJd4/pE/XQVC1ffbPJ14IXuA
/izRXjJJ52P3UCACdGyooF2/vufFhfaLs8dU8ZqvHajUup2NLT0x8P7iRl2Oqf2j
x6qLo9f3GDajpQQe1N5/y/rEQxvmOe47z5t8NoVJacSuAv1L+NiYpKHyF6UFaYCe
935Nj/9nFWZRQsIHJDmGEq+ZiaM4XNNc1WP8cUAlwANgih57izEFfC6mw71ROlg5
YRm70HQ1fS1WJaXpYbSSuIrCI1QbFg6Set1qkFY4xNbB/StJC6Axh/cNEgyxlYlg
Wf8iU+vM3kht8Z9xc625EGcRkuvQGlfZ9D8ezESp60CjWbqpw30IgvtTtiIyAg0q
RwGC5W+HLrtGUcLIw63+7M7Zo7jRLjxZt5bQcYBzcDRP4SePD4bU/bM4xFXrYtGf
b86ruKcPGzjx0yOLvMwZmF1/gWm81i7w6XozXgSUF5afGm1QYlIx6eMeIbpvd/qF
R+/TxFAFR3a6InphOoyw
=yITV
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
