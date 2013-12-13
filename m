From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 3/7] usb: dwc3: pci: add pm_runtime support
Date: Thu, 12 Dec 2013 22:17:19 -0600
Message-ID: <20131213041719.GB867@saruman.home>
References: <1386884325-11440-1-git-send-email-balbi@ti.com>
 <1386884325-11440-4-git-send-email-balbi@ti.com>
 <20131213015605.GC29964@psi-dev26.jf.intel.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131213015605.GC29964@psi-dev26.jf.intel.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: David Cohen <david.a.cohen@linux.intel.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, kgene.kim@samsung.com, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, w-kwok2@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2013 at 05:56:05PM -0800, David Cohen wrote:
> On Thu, Dec 12, 2013 at 03:38:41PM -0600, Felipe Balbi wrote:
> > teach the PCI glue about pm_runtime so that
> > it's easier to teach dwc3 core about it
> > later.
> >=20
> > No functional changes otherwise.
> >=20
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
>=20
> I was able to test this one with Intel Merrifield:
> Acked-by: David Cohen <david.a.cohen@linux.intel.com>

cool, thanks. Although that'd be a Tested-by. Is it ok to add your name
as Tested-by instead ?

--=20
balbi

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSqopPAAoJEIaOsuA1yqREfMkP/jaJkuIoUMW1dlhN6waE6i3K
KNCan+rOwnGPD/T3YNjpeW6mxBW4wbIzsyWwfdNc13xyEQ56hAvPtNphqqvQjGeF
Qlqr/c0KyRQQ+fXM1mxCNM7WPMNBJoFWMbuQnmxSd974yOVHMo5/mygN7VN8Lgme
zatCQVcZCYFb0mOqy84fBti4sX8AEZ8g86wiDIgouTaI12kdVdvW1luZe6kxB2y2
3LAWwUv4RkKklYDYkkGJyXBZwa/OxZHwFc0qkOZqN2mneN3cxulj65TOYDCeKid2
3ut45maSQax8EJrZ3qLmyhfnTvEpwxs5S1qqG3i5Z0abQObW04hW1h7cucvERH9X
GJ0rod6+bBRgga3KNEEcBjWoSAPfGtT6McneiI55YZxeCmwdn0Y8GgjHo5HRA3EN
xXFaolPI1jz7Q2rPxG4M2pnSKW+rkXe9bY9rIZBXXhQskCwZIBlVowrKAT6xqx2L
9lHMZySZg2UO0ndRJHyHq3gSiHTwaJYTycIiHks9uR8oaA35oI/6SvRawb/YiJMm
GD8STev8CM70aZWup9Bkgbep8zQAyR87N5DCJ5ISduMGYtEYZGFmN4SutL5E6G9a
DoiObppDIqkbjTxNHObQ8GmfcR+zi/kkY86KGt670v5xvanNaqP/VFkb+aJuUkfx
FeIhsU640qXdauyXrSKP
=k6+C
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
