From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 09/10] crypto: omap-aes: gcm: Add support for PIO mode
Date: Thu, 2 Jul 2015 03:06:36 -0500
Message-ID: <20150702080636.GH4033@saruman.tx.rr.com>
References: <1435814320-30347-1-git-send-email-lokeshvutla@ti.com>
 <1435814320-30347-10-git-send-email-lokeshvutla@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nOM8ykUjac0mNN89"
Return-path: <linux-crypto-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1435814320-30347-10-git-send-email-lokeshvutla@ti.com>
Sender: linux-crypto-owner@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org, davem@davemloft.net, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

--nOM8ykUjac0mNN89
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 02, 2015 at 10:48:39AM +0530, Lokesh Vutla wrote:
> Add support for PIO mode for GCM mode.
>=20
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>

why do you require PIO ? Is there any situation where DMA can't be
used? What would that case be ?

--=20
balbi

--nOM8ykUjac0mNN89
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVlPEMAAoJEIaOsuA1yqREPKEP/RA2r0b8X0PuX4fKsLm3f8b+
P/bTT0/3X88zBoX/8uWOFEwapmquX7GIM5FNv28JK15E3HIB15XqrOnNxfNEQTPd
baFFioKUNZBsmXgximP9xeX3DHP7AbIgeSHYDspCwSZiW1sSVRObDehZnt0asbsG
OYtbOIIl9jCrocdYAygdUNe7zLCycK+KT2v4BQpQbJeui8AcY0UgUUAVrxreLJyC
6IVwML9OzckWqkMYCDUFchlVyrkTNtmILUNM8OKqilJvLL3cyMA8NyOB7GHOQTmK
M/K+FzHwJqPlRgObT8lwiJdOF7M6OA6s6j/PLjDhbe5pquCDj74P8xbS8wuB7xiG
kX1daJJ0eOHV1y51DMnAatIcZEf2HpMHqEEDJOicbDTe0+eLg5SjnRWK+qwEAOl6
LwPV8oIEsoVvLLf2WhTdMe4kIqi+swLW3HVc5Mv6KOnYmBsyY4x45OLkU++wVqRQ
damJGIJr9RmZlZES/TMrvVhHZtFhsTa6WgYk0CH7S+VRfU1N7Ndh9IwdGgvJPON2
ZXJONoR1a4zntmmnbyVV+/fT4sg7QPqJOZbeWzaKQqd30DqJKDhFlnBlymbCuYeh
cc5NKdkHN4nsG/Ue8XUpT3bPWq1yKMyOKhrMwyWm0opHoMTc00ZUHxllIaz7WX/j
7O6TiOsdAvROWB76dpxg
=KDhV
-----END PGP SIGNATURE-----

--nOM8ykUjac0mNN89--
