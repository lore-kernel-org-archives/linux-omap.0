From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH RESEND] i2c: omap: improve duty cycle on SCL
Date: Wed, 17 Jun 2015 13:57:14 -0500
Message-ID: <20150617185714.GH18421@saruman.tx.rr.com>
References: <1434482445-1818-1-git-send-email-balbi@ti.com>
 <55813BA0.3010001@nokia.com>
 <20150617180052.GF18421@saruman.tx.rr.com>
 <5581BEB2.6070007@gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqCDj3hiknadvR6t"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57657 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932078AbbFQTAR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Jun 2015 15:00:17 -0400
Content-Disposition: inline
In-Reply-To: <5581BEB2.6070007@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: balbi@ti.com, Alexander Sverdlin <alexander.sverdlin@nokia.com>, Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, wsa@the-dreams.de, linux-i2c@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--AqCDj3hiknadvR6t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 17, 2015 at 08:38:42PM +0200, Alexander Sverdlin wrote:
> Hello Felipe,
>=20
> On 17/06/15 20:00, Felipe Balbi wrote:
> >>> With this patch we try to be as close to 50%
> >>> > > duty cycle as possible. The reason for this
> >>> > > is that some devices present an erratic behavior
> >>> > > with certain duty cycles.
> >>> > >=20
> >>> > > One such example is TPS65218 PMIC which fails
> >>> > > to change voltages when running @ 400kHz and
> >>> > > duty cycle is lower than 34%.
> >>> > >=20
> >>> > > The idea of the patch is simple:
> >>> > >=20
> >>> > > calculate desired scl_period from requested scl
> >>> > > and use 50% for tLow and 50% for tHigh.
> >>> > >=20
> >>> > > tLow is calculated with a DIV_ROUND_UP() to make
> >>> > > sure it's slightly higher than tHigh and to make
> >>> > > sure that we end up within I2C specifications.
> >>> > >=20
> >>> > > Kudos to Nishanth Menon and Dave Gerlach for helping
> >>> > > debugging the TPS65218 problem found on AM437x SK.
> >>> > >=20
> >>> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> >> >=20
> >> > NAK.
> >> > This is a direct violation of PHILIPS I2C-bus Specification v.2.1,
> >> > section 15.
> >> > Namely, you will have LOW period of SCL clock shorter than required
> >> > 1.3uS.
> > how is this out of spec ?
> >=20
> > http://i.imgur.com/jEDlZT7.png
> >=20
> > -Width =3D 1.4us, frequency 373.1kHz, duty cycle of 47.76%
> >=20
> > In any case, I have to send v2 anyway (found a bug which would show up
> > on frequencies above 400kHz), so I'll resend this patch.
>=20
> If you really target 50% duty cycle and there will be no
> rounding/truncation error, you will end up with 1.25uS at 400kHz. I
> understand why you want to make HIGH phase longer, but 50% is a bad
> target at 400hHz. Probably more safe value?

We can't generate exactly 400kHz anyway, and we're not getting exactly
50% duty cycle, it just brings it *closer* to that. I even mention the
reason for the DIV_ROUND_UP() there. Let's just go through the math
using TRM equation:

@400kHz with 12MHz internal clock:

tLow =3D (SCLL + 7) * iclk_period

1250 =3D (SCLL + 7) * 1/12MHz

SCLL =3D DIV_ROUND_UP(1250, 83) - 7
SCLL =3D (1250 + 82)/83 - 7
SCLL =3D 9

Now if we do the reverse to find actual tLow:

tLow =3D (9 + 7) * 83
tLow =3D 1328ns

Likewise if we do it for tHigh:

tHigh =3D (SCLH + 5) iclk_period

SCLH =3D 1250 / 83 - 5
SCLH =3D 10

tHigh =3D 15 * 83
tHigh =3D 1245

tHigh + tLow (SCL period) =3D 2573ns. That gives us SCL of 388.65kHz. An
error of mere 3% of what we really wanted to achieve. I'd say this is
pretty darn good.

Now you tell me, how is this *ever* going to be out of spec ?

DIV_ROUND_UP() and the truncation at internal clock period calculation
makes sure that tLow will be within spec. Instead of blindly NAKing the
patch, you could've gone through this exercise yourself.

--=20
balbi

--AqCDj3hiknadvR6t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVgcMKAAoJEIaOsuA1yqREPSkP/2qIqrANSlkcfVa55w70wlIc
QfK1ZQP5exttcR/+kURu70dUfCloyc1X33StZ6snL/MlCMzl5lGiu3Ycrg5KdyQF
7+Wvog/lipdIDNV4i9AGNCsRtYhz4OOA7rqsPkzzeM26WOvz/0A8Ucw5VEA7VHJC
qamPqQOhLk2A039Vuerx0Gy/tK67h9MRDH7YPqBz5hzrcBbMaWvetR6fWidxs6dX
KNwlUQIEq13nIPupzqez+U+bAEIh9q2I4OMAIbvboeOJcCHVIWXIKv5655A81ali
Hndwtk9S84b/CHs6aJ+WV3U66AyWpgvBiPZWbhzdnMRXKRKz5KjbYiwdB+Hf1HB1
KOFHc6T4WBEVpe0duKrvr5wUcYc8v6nkvOu9u2Me/jleaX9gSWD9NCsttLiKn3Nc
9puBLvTc+RQMTwPdpPe+WfmpoBQU2z3kQZ0asTASo5/SPg2TBXREo7cUGO+wdYvm
NskWChUzuwXVrEOqt6WsqE0pG8h+y+ztW+bpYfz5104Br+XYjHu8gYpyijjgzBcp
CMat7r+hhufdGo0QYKOCKL0U1AVdEue8LLJeiKUTB0QhvFR0lzeDzVXfqLaYkUQi
MAQbzTMdMCR+8541bFj1kTeZJ7G3gagjnDhBWpKZrY2AWHqjxHsTrpDyzZJwFAbe
5Fc0BOf2WCe26aOwi5fC
=wP2S
-----END PGP SIGNATURE-----

--AqCDj3hiknadvR6t--
