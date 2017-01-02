From: joerg Reisenweber <joerg@openmoko.org>
Subject: Re: Nokia N900 sound driver and ECI GPIOs
Date: Mon, 02 Jan 2017 16:45:15 +0100
Message-ID: <2962055.pY3hWGpcok@saturn>
References: <201701012054.54505@pali> <b80636f3-add3-9edf-009d-a938f1e9ebf9@ti.com> <20170102085150.GB6728@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart16483143.Q7pk7PD0Ht"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170102085150.GB6728@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Pavel Machek <pavel@ucw.cz>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Eduardo Valentin <edubezval@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--nextPart16483143.Q7pk7PD0Ht
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Mon 02 January 2017 09:51:50 Pali Roh=E1r wrote:
> On Monday 02 January 2017 10:34:34 Peter Ujfalusi wrote:
> > On 01/02/2017 12:36 AM, Pavel Machek wrote:
> > > Are there multi-button headsets compatible with N900?
> >=20
> > Not sure if n900 is capable of handling ECI communication, n9 was. =
In n9
> > the PMIC/Audio chip had an ECI core integrated afaik
>=20
> In N9 it is handled by twl5030 chip? Is there documentation for that
> ECI/ACI part? N900 has twl4030 so we need some chip documentation for=

> adding support for N900...

No, N9 has TPS65951, not TPS65950 aka TWL4030 as in N900, the ECI is on=
e of=20
the differences between the two chips afaik

jOERG
=2D-=20
()  ascii ribbon campaign
/\ =20
against html e-mail - against proprietary attachments
http://www.georgedillon.com/web/html_email_is_evil.shtml         =20
http://www.nonhtmlmail.org/campaign.html
http://www.georgedillon.com/web/html_email_is_evil_still.shtml   =20
http://www.gerstbach.at/2004/ascii/ (German)

--nextPart16483143.Q7pk7PD0Ht
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlhqdZEACgkQ7Xtwhpk1Ugz6pACfS4fa++tT21AI2cTEC0xcthLF
irUAoJMANtps3cOnAMY+Ipm1UwYo4egl
=UP/2
-----END PGP SIGNATURE-----

--nextPart16483143.Q7pk7PD0Ht--
