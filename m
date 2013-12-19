From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFT/RFC/PATCH 00/31] arm: omap: irq: cleanup INTC driver
Date: Thu, 19 Dec 2013 17:21:53 -0600
Message-ID: <20131219232153.GE707@saruman.home>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
 <20131219184815.GU27438@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zaRBsRFn0XYhEU69"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41226 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755800Ab3LSXWz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Dec 2013 18:22:55 -0500
Content-Disposition: inline
In-Reply-To: <20131219184815.GU27438@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--zaRBsRFn0XYhEU69
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2013 at 10:48:15AM -0800, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [131120 10:10]:
> > Afte these patches, we're very close to being able
> > to move arch/arm/mach-omap2/irq.c to drivers/irqchip/irq-intc.c
>=20
> That would be nice :)
> =20
> > All which would be missing is for Tony to drop all OMAP2/3 board
> > files so we remove the few pending bits and pieces left in
> > for legacy boot.
>=20
> That may still need to wait a while, but let's see.
> =20
> > Note that I have only boot tested these on AM335x Bone Black
> > (with a small fix for fixed regulator which should be in
> > the mailing list already), so I'd need help testing all
> > other impacted platforms, specially when it comes to PM.
>=20
> Sorry have not had much of a chance to test these with PM with
> all the fixes needed for omap3 DT mode. Tried testing these
> just now, but I get:
>=20
> arch/arm/mach-omap2/board-generic.c:134: error: =E2=80=98omap_intc_of_ini=
t=E2=80=99 undeclared here (not in a function)

some of your other changes messed it up, I have not references of
omap_intc_of_init() in my branch, because that's one of the things I'm
dropping from DT-based boots.

Can you see which patch added a new omap_intc_of_init() call ? Or maybe
tell me which branch I should rebase on top of ?

cheers

--=20
balbi

--zaRBsRFn0XYhEU69
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSs3+RAAoJEIaOsuA1yqRERmQP/3NI6cnSby6yANkDMEQIjrUE
40+GvIHI+tJwRGBRW4+DLlJZ4fOy1zthpZYWMAvceynXnSibp5w8zeaI51N0GuIx
J7OIdwQ7zNj0M/EWjiWnGBfRpLo0cQ/T3nkw5qXn5gCNPaY096PlG5mMEGvWveKh
1TU15oPlDQtc2U+egJP2oPoAfatbPLkY0oDRkc7Lh6DrZlqzdM4XMpUsMF5ZWxhv
RKZLw58yL7M+irWhLvvb/N1TiLyzoU/XI95xgE7pHihc+L//qjp0izeY/hywo/Mh
wysc6k8geJljjgYSGby86rmsSIyfg//zLR1qB8hox8LmoxCeoqTuDE/Ki0FOllEF
ROcjn7D/elVfb6PYBQ4Qvbm3GleaognCTpKeccswTssjgJ1IgW96u9VULB61Rraf
O7IRFaqVabe51Vu5m/3jXFCkLjLOT9drrQFg5tIPFhssN8xHcG0aWr85ZbuJO1W6
K12wB6ZZT47pW1qOnwKx8ERxe4QIwUZJHVXM8atzwX/fzG43oFSqBRIowRqt2TCm
/x36J5anYlB8TNPywWRkv9GTr3xOCVSVA1wehPfTnHrBBSQ+tbLlli7podmH9IUv
n1+AIOlkUsNx6MOh8tsC15S9usruBv9DhVL99qeoaA6XNymkoMdfH+d8EOnF/MGO
ctAshwy3vx+4LeCs/hUe
=FpAM
-----END PGP SIGNATURE-----

--zaRBsRFn0XYhEU69--
