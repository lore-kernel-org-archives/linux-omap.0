From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: improve duty cycle on SCL
Date: Wed, 17 Jun 2015 10:38:12 -0500
Message-ID: <20150617153812.GB18421@saruman.tx.rr.com>
References: <1434482276-1210-1-git-send-email-balbi@ti.com>
 <55815581.80807@gmx.de>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55815581.80807-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 17, 2015 at 01:09:53PM +0200, Michael Lawnick wrote:
> Am 16.06.2015 um 21:17 schrieb Felipe Balbi:
> >With this patch we try to be as close to 50%
> >duty cycle as possible. The reason for this
> >is that some devices present an erratic behavior
> >with certain duty cycles.
> >
> >One such example is TPS65218 PMIC which fails
> >to change voltages when running @ 400kHz and
> >duty cycle is lower than 34%.
> >
> >The idea of the patch is simple:
> >
> >calculate desired scl_period from requested scl
> >and use 50% for tLow and 50% for tHigh.
> ...
> Hmm, and what's about  Philips I2C specification 2.1, Jan 2000, Table 5?
>=20
> >PARAMETER                       SYMBOL  STANDARD-MODE   FAST-MODE     UN=
IT
> >                                          MIN. MAX.     MIN. MAX.
> >LOW period of the SCL clock     tLOW      4.7   =E2=80=93       1.3   =
=E2=80=93       =C2=B5s
> >HIGH period of the SCL clock    tHIGH     4.0   =E2=80=93       0.6   =
=E2=80=93       =C2=B5s
>=20
> Your signal is in spec (0.85 =C2=B5s high, 1,65 low).
> Maybe your TPS65218 is just buggy or signals are bad?

yes, tps is buggy, it's written in the commit log itself.

--=20
balbi

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVgZRkAAoJEIaOsuA1yqREQUEQAKpukp0OlBbB++SGsgbYvU15
bU5OuxGASJqNI5O95Y61Tt3MEzSav6v3bTmmFfWrr571asnbfhT5cPuSdCKFdWQm
f1lk3rHiImqdtsXglrB5ElkU3pQ2s+RkZy52Awml/CC/23GyTNNjEUMbn+1NkmUJ
wTVbkkDRQiBSTcLZ2ffPBanTdKxaNIdxSJ55Y55YG4mvFMOtIIcjbPNTMgol1Gee
0XHf78SmzjLQUDt2EZC3AgHgWiVuDXdAJUjE6MkB+5cF0BYZJinNodFvIpnoSfbP
TTo3f24JKo2uIkeuZrs+X4qAPm+jV211YudhmTAeFxGZdl1RMDndTgGHr9xLsT5k
wt93GcesDe9/F+oFHKCD3NNBA94U+e+8oKG3Aeb7PMTsFD1KRa8syp11c04numQs
JesQwUVqPqqsOI2wnqsDKxJMEyHZwh9mZrfwcTSG6N6WLlpTC7y9NvxlpkoS2HlJ
CWIwj0y6xKRR3UEZuRV8Ik9scnCmrZ5wjTR7seRhwWkOfBY3hJumc25uTaai3PoH
CRaRUb/RfTKJOBwKlgHrlLw14PTxjDkedr/0VES8JWeh7+KVLkuylgZFHuaAls9z
HahlSx3UJP3J6ASeRYtiAMwNC1VuFlqSl04vQZMpalZAW4qTymlhPniH/tP02w90
T8qrKMXD1okB2b58rpoq
=tRkD
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
