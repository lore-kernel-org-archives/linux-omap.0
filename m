From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: busses: constify dev_pm_ops structures
Date: Wed, 25 Jan 2017 22:03:49 +0100
Message-ID: <20170125210348.ebwozos3puo6c4if@ninjato>
References: <1484474381-1064-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bazjjmtkiv4nr3il"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484474381-1064-1-git-send-email-bhumirks@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, tony@atomide.com, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--bazjjmtkiv4nr3il
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 15, 2017 at 03:29:41PM +0530, Bhumika Goyal wrote:
> Declare dev_pm_ops structures as const as they are only stored in the pm
> field of a device_driver structure. This field is of type const, so
> dev_pm_ops structures having similar properties can be declared const
> too.
>=20
> File size before: drivers/i2c/busses/i2c-omap.o
>    text	   data	    bss	    dec	    hex	filename
>    6814	    584	      0	   7398	   1ce6	drivers/i2c/busses/i2c-omap.o
>=20
> File size after: drivers/i2c/busses/i2c-omap.o
>    text	   data	    bss	    dec	    hex	filename
>    7006	    392	      0	   7398	   1ce6	drivers/i2c/busses/i2c-omap.o
>=20
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Applied to for-next, thanks! I dropped the file size table from the
commit message, though. For me, it is clear enough without it.


--bazjjmtkiv4nr3il
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAliJErQACgkQFA3kzBSg
Kba7cQ/+PCEphAlBWZFNWUQiIy9cb0PyHPt1FQ0z+aTRVfMYqimeSuQEM9yrx6sE
GMzteUphey2wWrvbKbFierdarz6Y+Ey3rRRmhFSnJa+U/chrdg2gSgHCDxUJy5vO
pvCW1I4vr2YELc4DpmUhIdh2/RYij4wPY4P1ONbnwVH2cQFUSYx+f1OXSDeVY7Ay
gFv+2pZz8wOhp2y0lsBtpjNFUAUpoptoFVCK8udlAXDBKM+Ir/5kgvKX7F5g4Kil
2sh55zk/caWHCnUS6XzGdwF+eo7rGtrRFHeJ8i16w4LrBQUCZTPlKR8y36I3vKqq
2hLXbftlikyRoQaXRk21lEMg7JhD5kloXiDVXS98kCH9L/rpC6IHWgtsg39uWrqd
yEaxwZ+6vm+fKG1wkqA3tu8VtM7nNFQq+CMPr9/tYqiZfiG8Fd+sVvJud1KAWspo
WVs1YlZVn/1KjyySXA95+vdHJJr76DfwlsRaAAo6d7TtI8U5ummOpCMqmBoP0G7J
uQ7FuGwmiMTUeqEyGA+zKR/KijeP0NCP4gmQJ0scTCwmQ5xE0si7KaxYiEUiDvlz
o2WQchhNvKQcrBz7e+yYyP33RsWUNweyyjzpJUtu251ZphyfgCpz8e9BiK3oHw6A
rcxtHNTsO9R3wawAWC2mOpg+Ms8VJiG/Eijn47hHxWzmNtJ/rlw=
=vvs8
-----END PGP SIGNATURE-----

--bazjjmtkiv4nr3il--
