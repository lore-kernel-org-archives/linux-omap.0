From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC PATCH v2 0/7] i2c: core: introduce atomic transfers
Date: Wed, 27 Mar 2019 14:53:08 +0100
Message-ID: <20190327135308.GG5345@kunai>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
 <71aaab62-2965-8ad8-61b9-02d02694919d@axentia.se>
 <20190304224856.w7egngqynl3hlabp@ninjato>
 <6d9a1d1e-a6b7-b3ae-f560-4f906934e795@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xs+9IvWevLaxKUtW"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6d9a1d1e-a6b7-b3ae-f560-4f906934e795@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Keerthy <j-keerthy@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Stefan Lengfeld <contact@stefanchrist.eu>, Phil Reid <preid@electromag.com.au>, Tero Kristo <t-kristo@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


--xs+9IvWevLaxKUtW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> the demux-pinctrl driver... BTW, that driver should forward ->smbus_xf=
er
> >> just like it does for ->master_xfer, no?
> >=20
> > Yes. The idea of having two seperate SMBus controllers in one SoC which
> > would need demuxing is amusing, but still, it exists for I2C and you are
> > right.
>=20
> Right, I didn't actually think all that far... :-)

On second thought, we can add smbus support when we need it.


--xs+9IvWevLaxKUtW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlybgEQACgkQFA3kzBSg
KbbCPA//QSEonhMDC7QwEFKO5Xh0XXUqNnENxmBvl4mJVvoblbTN9iT7NRBrSPo3
0XCckebbtKmF/Pykg0zz7f1S7TYdvC39j1gAyomeoUq26O0q1rVIGozgMcdc8l7C
yDm9fF3PUWUhOFOiW0py1A0V4yCPVTKiv2DoXCbajrYoydIV5DxzoK8uMyllRsfc
PyXiLNx60XowckbekCXmsmYl2UDX5WrpEHaOxsUTjWRqjITng6Mh+0f01KsfBAX3
VBVlIz1Yc1EKTTs6uOl8qAlJ2Hcp+NxgsImYqsvvvej9yOM8SZaxOBRFBJbdWKHf
DBMH4KlqyFGHsCR37F7MKt+QJFNJPYFN9plMsmlQWnyuVBcpAmSTqPj1gIy7cMgV
/FZTe4+IztH73mInq3pmPXg1D3UFLoPiiHGCS306RlLt5X/rCGIqapYOllMJVBym
s7cAFtrGQJIPC1S+XdvvHfkDA4hrjdQ65Xi63Q6AF+SRjsDbt3LeW7QWJ5pG2Iza
1HAkNEjY1JC78tmb++2dbHL1SIu/Nbwdxi0ENoj/XKNJueCEvMbtaMbG1Qy6ASZy
Rc31/PCA0wTkDiSDqiLts9XVlWFq87TuMcYSM5D/3UlVnfdXfV5AHe01pZURc+fh
uyDVwx5XDz2fbfCtqvpXfVwvsmj5SEnrn9RO421cKtrd/RJvH9c=
=6fph
-----END PGP SIGNATURE-----

--xs+9IvWevLaxKUtW--
