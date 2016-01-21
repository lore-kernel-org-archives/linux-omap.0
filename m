From: joerg Reisenweber <joerg@openmoko.org>
Subject: Re: Nokia N900: musb is in wrong state after boot
Date: Thu, 21 Jan 2016 20:34:14 +0100
Message-ID: <8629381.KDSn8v3DtH@saturn>
References: <201601091616.04193@pali> <3690314.8jDXSUDcRZ@saturn> <20160121192113.GM19432@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1982854.3KfHYrZ3qO"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160121192113.GM19432@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org


--nextPart1982854.3KfHYrZ3qO
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thu 21 January 2016 11:21:13 Tony Lindgren wrote:
> Do you have some pointer
> to the "certain resistor value on ID to GND" spec? Is it maybe part o=
f
> the carkit related parts of the USB spec?

""Three additional ID pin states are defined[4] at the nominal resistan=
ce=20
values of 124 k=CE=A9, 68 k=CE=A9, and 36.5 k=CE=A9, with respect to th=
e ground pin. These=20
permit the device to work with USB Accessory Charger Adapters that allo=
ws the=20
OTG device to be attached to both a charger and another device simultan=
eously.
[6]""
https://en.wikipedia.org/wiki/USB_On-The-Go#OTG_micro_plugs

/j

=2D-=20
()  ascii ribbon campaign
/\ =20
against html e-mail - against proprietary attachments
http://www.georgedillon.com/web/html_email_is_evil.shtml         =20
http://www.nonhtmlmail.org/campaign.html
http://www.georgedillon.com/web/html_email_is_evil_still.shtml   =20
http://www.gerstbach.at/2004/ascii/ (German)

--nextPart1982854.3KfHYrZ3qO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlahMroACgkQ7Xtwhpk1UgxTsQCgr18gPh4D10VCw60Y21SX0mlO
bPkAn1+OMc3EzgkEOlJTtpIDu7nendjk
=gy0K
-----END PGP SIGNATURE-----

--nextPart1982854.3KfHYrZ3qO--
