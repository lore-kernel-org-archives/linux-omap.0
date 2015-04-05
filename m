From: Sebastian Reichel <sre@kernel.org>
Subject: Re: ARM errata 430973 on multi platform kernels (was: OMAP3-N900:
 Add microphone bias voltages)
Date: Sun, 5 Apr 2015 15:45:28 +0200
Message-ID: <20150405134528.GD9186@earth>
References: <1425236828-28349-1-git-send-email-jarkko.nikula@bitmer.com>
 <CAOCHtYjCtmJNrkD0x78bm9b7hNvTKsZD2C2m5N=nR7p73R4zcg@mail.gmail.com>
 <20150405130045.GB9186@earth>
 <201504051526.14575@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38214 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320AbbDENp7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 5 Apr 2015 09:45:59 -0400
Content-Disposition: inline
In-Reply-To: <201504051526.14575@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Robert Nelson <robertcnelson@gmail.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Apr 05, 2015 at 03:26:14PM +0200, Pali Roh=E1r wrote:
> > > > Yes so it seems, and the bootloaders should really set it.
> > > > It's also disabled for multiplatform builds.
> > >=20
> > > These are now done in u-boot as of: v2015.04-rc4
> > >=20
> > > http://git.denx.de/?p=3Du-boot.git;a=3Dcommit;h=3Dc6f90e1418a84fe5
> > > fa463b38403bd1845cb6a59c
> >=20
> > Seems like "include/configs/nokia_rx51.h" has been forgotten.
> > Note, that the kernel must still be able to enable the bit
> > itself (in case NOLO is used without u-boot).
>=20
> You must not expect that bootloader set something. Nokia N900 has=20
> closed and signed bootloader which cannot be easily replaced and=20
> or fixed.
>=20
> For N900 there is U-Boot but it does not support lot of things=20
> (load kernel via usb or serial) so for developers it is better to=20
> use original Nokia bootloader.

Yes, I'm aware of that. I think having the IBE bit set in u-boot has
advantages nevertheless. I think the kernel can't enable the bit
sufficiently early if its compiled in thumb-mode itself
(CONFIG_THUMB2_KERNEL).

So I suggest to enable the IBE bit in the kernel (that part is
already done) *and* in u-boot.

-- Sebastian

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVITx4AAoJENju1/PIO/qap7wP/32vyCSoRJ6VtmypxR2tUJzL
U2VEyFdDNed/O1TqB9mDzycCdhYuXIyQc+8dAXWaDiFDxeZ/9eKN7ECU4SlJNeTF
gW5NHF/NkkbMv2n3NFtamV0IqRxgci4hN05tOorwSAutZkjDY1L6ZVwooOarX3Fa
WP5wuPlFN0DcoONeSpLbH/rUxdZaaSeUXzf6YXFfD7PGVpumWyqvgySOU1ldqbi9
7HeZNX0FWf+cWpipwPDf7RHqeUFpeuuq1PTMV/N/7/h5wPdRwzsuJv45YmA1i4sd
9pTm3q1axE74c7fHOOx1jpr9Nx2fXSiMXKz7/0InORPbTWu9AgcgDi2VBTGySSAG
zJQ4Fyi+PZzeUMPQdIfMsR+i5T6CD8riE+X2mqyjGwEm93+AENPjzc9abMjOPb5L
gQvUp/Owe/L6tDiz1TmDIVNPjX28TJ1Wge687xi1/T6JTfahYhHSzpkQTROLWKtC
8XM3Sj9dBAe+wrkTrXPr4aws9mOK1DzW8W8enkaULZE6mWJU75EQZCqKm3caCdpi
u/8K/T/qtRdw9YOVJdccDvD8WnlDIeUezMYukHraWyWL5V3jKmbphIqa0Eet3Gdr
HYynQ1j6+JoPAswoxs8FF86kprP4qw9DpRqHWyFbsY4JKoNwA0ma9scg3l+Y1m+Q
JwVnR+mqk1BA//KfNYVL
=eMnt
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--
