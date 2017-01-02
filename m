From: joerg Reisenweber <joerg@openmoko.org>
Subject: Re: Nokia N900 sound driver and ECI GPIOs
Date: Mon, 02 Jan 2017 16:51:50 +0100
Message-ID: <4227364.xK0WtP2gcZ@saturn>
References: <201701012054.54505@pali> <20170102125840.GD6728@pali> <a132c193-5c00-14cb-91bf-abb86eac01d6@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3312331.zGOz7T5iSG"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a132c193-5c00-14cb-91bf-abb86eac01d6@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Eduardo Valentin <edubezval@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--nextPart3312331.zGOz7T5iSG
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Mon 02 January 2017 16:36:38 Peter Ujfalusi wrote:
> On 01/02/2017 02:58 PM, Pali Roh=E1r wrote:
> > On Monday 02 January 2017 14:53:44 Peter Ujfalusi wrote:
> >> On 01/02/2017 10:51 AM, Pali Roh=E1r wrote:
> >>> On Monday 02 January 2017 10:34:34 Peter Ujfalusi wrote:
> >>>> On 01/02/2017 12:36 AM, Pavel Machek wrote:
> >>>>> Are there multi-button headsets compatible with N900?
> >>>>=20
> >>>> Not sure if n900 is capable of handling ECI communication, n9 wa=
s. In
> >>>> n9
> >>>> the PMIC/Audio chip had an ECI core integrated afaik
> >>>=20
> >>> In N9 it is handled by twl5030 chip? Is there documentation for t=
hat
> >>> ECI/ACI part? N900 has twl4030 so we need some chip documentation=
 for
> >>> adding support for N900...
> >>=20
> >> n9 has twl5031 and the documentation is not public. But the kernel=

> >> source from Nokia have the driver under drivers/mfd/twl5031-aci.c =
It is
> >> using the ECI stack to report the changes.
> >> twl4030 and twl5030 does not have support for ECI, only twl5031.
> >=20
> > Ok, so Nokia N900's audio chip (twl4030) does not have support for =
ECI.
>=20
> TLV320AIC34 (two of them) on n900 to be precise, n9 uses twl5031 and
> tlv320dac33.
>=20
> > But still as Jarkko wrote there could be an option to supports ECI =
via
> > GPIO and ADC.
>=20
> Yes, there is the option, but w/o documentation on the ECI protocol i=
t
> is not going to be easy. And I'm sure there were a (good) reason the
> n900 does not support ECI. If it could be done in a stable way the
> product would have support for it.

Don't you think the missing docs and the missing support in N900 might =
have=20
the same reason: copyright issues that forbid both in FOSS?

maybe my little investigation you find at http://neo900.org/stuff/joerg=
/ECI/=20
might help re protocol low level.

>=20
> > And there is still mysterious gpio 178 (RX51_ECI_SWITCH_1_GPIO) whi=
ch
> > could help us?
>=20
> Yeah, that is something I have no idea what it is for. It could be th=
at
> the schema is using different pin mode for it? It might worth looking=
 at
> the TRM on which pin the gpio_178 can go out and look for the possibl=
e
> modes? Most likely waste of time...

We did this, the pin is mot listed in schematics under none of the poss=
ible=20
names or pin number (AA3)
Looks to me like a R&D change done late, similar to the USB PHY.

jOERG
=2D-=20
()  ascii ribbon campaign
/\ =20
against html e-mail - against proprietary attachments
http://www.georgedillon.com/web/html_email_is_evil.shtml         =20
http://www.nonhtmlmail.org/campaign.html
http://www.georgedillon.com/web/html_email_is_evil_still.shtml   =20
http://www.gerstbach.at/2004/ascii/ (German)

--nextPart3312331.zGOz7T5iSG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlhqdxYACgkQ7Xtwhpk1Ugx39QCdHJSFGLDwUOquuKl0Mlz6N1LQ
Ac0AnRqhFaU1qD/gkCWS3gqZhjQ0jaTM
=7YVN
-----END PGP SIGNATURE-----

--nextPart3312331.zGOz7T5iSG--
