From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] phy: mapphone-mdm6600: Fix wrong enum used for status
 lines
Date: Fri, 8 Jun 2018 16:50:55 +0200
Message-ID: <20180608145055.GA11958@amd>
References: <20180531170538.32264-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180531170538.32264-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-05-31 10:05:38, Tony Lindgren wrote:
> Kbuilt test robot reported:
>=20
> drivers/phy/motorola/phy-mapphone-mdm6600.c:188:16: warning:  is used
> uninitialized in this function [-Wuninitialized]
>         val |=3D values[i] << i;
>                ~~~~~~^~~
>=20
> Looking at the phy_mdm6600_status() values does get initialized by
> gpiod_get_array_value_cansleep(), but we are using wrong enum
> in that function. Let's fix the use, both end up being three though
> so urgent rush on this one AFAIK.
>=20
> Fixes: 5d1ebbda0318 ("phy: mapphone-mdm6600: Add USB PHY driver for
> MDM6600 on Droid 4")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Reviewed-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsal88ACgkQMOfwapXb+vLzEgCgvqK8LCcStxYo3zTSqe09oCIz
aV8An1r3vfthMGVK/1RhUuy7byaJ2pKb
=uf1Q
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
