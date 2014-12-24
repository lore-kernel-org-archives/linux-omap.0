From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: omap: reduce zImage size on omap2plus_defconfig
Date: Wed, 24 Dec 2014 09:49:48 -0600
Message-ID: <20141224154948.GA423@saruman>
References: <1419271535-4057-1-git-send-email-balbi@ti.com>
 <54991A25.2030804@compulab.co.il>
 <20141223161936.GA9147@saruman>
 <549AA94A.8030209@compulab.co.il>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49038 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891AbaLXPuf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Dec 2014 10:50:35 -0500
Content-Disposition: inline
In-Reply-To: <549AA94A.8030209@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: balbi@ti.com, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 24, 2014 at 01:53:46PM +0200, Igor Grinberg wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> On 12/23/14 18:19, Felipe Balbi wrote:
> > On Tue, Dec 23, 2014 at 09:30:45AM +0200, Igor Grinberg wrote:
> >> Hi Felipe,
> >>
> >> On 12/22/14 20:05, Felipe Balbi wrote:
> >>
> >> [...]
> >>
> >>>  CONFIG_SCSI_SCAN_ASYNC=3Dy
> >>> -CONFIG_ATA=3Dy
> >>> -CONFIG_SATA_AHCI_PLATFORM=3Dy
> >>> -CONFIG_MD=3Dy
> >>> +CONFIG_ATA=3Dm
> >>> +CONFIG_SATA_AHCI_PLATFORM=3Dm
> >>
> >> Isn't this needed for the rootfs on SATA devices?
> >=20
> > there's no known boards with rootfs on SATA. Until then, we can reduce
> > the size.
>=20
> What makes you say so?
> The decision for rootfs on SATA is taken dynamically.
> OMAP5 boards (specifically cm-t54) can have rootfs on SATA...

I'll leave the decision to Tony. Even though they _can_, they really
don't and IIRC, OMAP5's SATA has so many silicon errata that it'd be
annoying to find that special device which works (e.g it can't negotiate
lower speeds with SATA III devices and it won't support SATA I).

As of today, we don't know of anybody really shipping anything with
rootfs on SATA and distros would rather ship initiramfs than a giant
zImage anyway.

Tony, your call.

> >>> -CONFIG_USB=3Dy
> >>> +CONFIG_HID_GENERIC=3Dm
> >>> +CONFIG_USB_HIDDEV=3Dy
> >>> +CONFIG_USB_KBD=3Dm
> >>> +CONFIG_USB_MOUSE=3Dm
> >>> +CONFIG_USB=3Dm
> >>
> >> So, you don't consider USB a valid rootfs storage option?
> >=20
> > read the original defconfig. This is *only* for usbcore.ko, EHCI is
> > disabled, XHCI is a module, MUSB is disabled. What will you use for
> > rootfs ?
>=20
> Yes, thanks for pointing. Now I see indeed this is a sensible thing
> to do and probably should have been done a while ago.
>=20
> Might be worth addressing/explaining this in the commit message.

right, I'll look at it after holiday season.

--=20
balbi

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUmuCcAAoJEIaOsuA1yqREN1sP/jSy+37SEF3a3NslloDojs07
XkHqCxKlnbCq/tHNs93V4WyYfDpkU9iCPhiht3nMJ4VjJ9ibA12kba91s1wnJl3z
X5kqsEtWEqGt/PZGidA+xykr4y7rlNQgVNO9dtDQC3ch8EJTnHknRwflVUjT9sUc
MX0hBbZCpe+VpxoLlo9W0mu6jGOnCDyoSkaKpGNFecJcxidcTzTsKXA9d3Ebw6ty
n4aQoy6ViQf8DwTi0OWkqzaIqbojcfVOWAL/XoQEJVt8bC4t67+jkEyj6VdvoVL4
qyBjxdJiGooPKok1ndBG9GAEYI6VICBq7BQELK3VaXT6+5EMNCA+APiUA3eZoITy
Ws1am5B959myIxK0ujzXOmhf1DibIqiCJXY6m04QdyiflNO9AvumZTmS4l5T899P
VCcSdhOb9kpazmaajASSrt0iEh+EYBYVlrNsRYu/I4zsCUfAIKSR7XsRSHDpEdYz
X1zIsjNz46I19UEhX0G/FJLQSo9nk38a/7CZcQnAmOIXjHzaHUjTjqb9eFyrKXtE
xgR04kutat8f0bp2TtkOPZPL/BEDphPAP09p6/eIAsSfOCktj4YZmCDnOFX5tUKo
9Ln1RQEhRW1llwvvFxT5O9ttii6RxxmQ8osaFR932h9qxuBy1Jb1XoEaUkn+J7hH
gzeF7LZ99DlhtnI2W0CT
=6rYG
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
