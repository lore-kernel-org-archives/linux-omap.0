From: Pavel Machek <pavel@ucw.cz>
Subject: Droid 4: very confusing config around OHCI_OMAP3_HCD
Date: Thu, 3 May 2018 21:25:10 +0200
Message-ID: <20180503192510.GB32572@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

For power management experiments, I tried

CONFIG_USB_OHCI_HCD=3Dy
CONFIG_USB_OHCI_HCD_OMAP3=3Dm
CONFIG_USB_OHCI_HCD_PLATFORM=3Dy

and could not find resulting .ko.

Help text says:

CONFIG_USB_OHCI_HCD_OMAP3:

This option is deprecated now and the driver was removed, use
USB_OHCI_HCD_PLATFORM instead.

Enables support for the on-chip OHCI controller on
OMAP3 and later chips.

Which may partly explain it. But if the option no longer does
anything, why keep it? Certainly second part is confusing if option is
NOP...

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrrYhYACgkQMOfwapXb+vLI7ACffXJTWDCMGsMPHDCUB2ZfCjq8
94QAoJ3f9xNUIOPqmC69s/ekjFJIemx8
=rL2w
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
