From: joerg Reisenweber <joerg@openmoko.org>
Subject: Re: Nokia N900 sound driver and ECI GPIOs
Date: Mon, 02 Jan 2017 22:05:39 +0100
Message-ID: <2036063.jAbaHqGlp2@saturn>
References: <201701012054.54505@pali> <20170102184945.m6maflaoihumd7nt@raspberrypi-2.musicnaut.iki.fi> <201701022101.01341@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1832580.CVLtlCnN7x"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201701022101.01341@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Eduardo Valentin <edubezval@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Nishanth Menon <nm@ti.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--nextPart1832580.CVLtlCnN7x
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Mon 02 January 2017 21:01:01 Pali Roh=E1r wrote:
> On Monday 02 January 2017 19:49:45 Aaro Koskinen wrote:
> > The schematic shows ECI(5:0), but only 3 are connected/used. There
> > were 3 other GPIOs reserved but not used in the final product.
>=20
> Are you sure that this is truth (maybe you have some information)? Or=

> you just looked at schematic and deduced this observation (as other
> people too)?
>=20
> Joerg already told us that RX51 schematic does not 100% match product=
ion
> N900 and e.g. there is missing UART3 pins...

We found this, see https://irclog.whitequark.org/neo900/2017-01-01 (has=
 a lot=20
of possibly useful references/links)
The question is if pin AA3 aka GPIO_178 is actually NotConnected in N90=
0 or=20
it's just an omission in schematics and there's actually some more 'ste=
alth=20
hardware' in N900 that doesn't show up in docs, just like the testpoint=
 UART=20
console http://wiki.maemo.org/N900_Hardware_Hacking#Debug_ports which a=
lso are=20
missing in schematics.


> What we know that gpio 178 is *already* controlled and changed by
> production Nokia kernel running on production N900 devices (as I wrot=
e
> in first email).

I could use one of the unpopulated N900 PCB and solder a wire to the OM=
AP AA3=20
pad, then try to make sure it's not connected to anything, or if it is =
then=20
find out about the details of this.
But I'm reluctant to do this, since it's an error prone and (in case of=
 N/C)=20
not verifiable procedure, so I'd appreciate any further info, whether f=
rom=20
historical anecdote or from sourcecode review and conclusions, regardin=
g that.

cheers
jOERG
=2D-=20
()  ascii ribbon campaign
/\ =20
against html e-mail - against proprietary attachments
http://www.georgedillon.com/web/html_email_is_evil.shtml         =20
http://www.nonhtmlmail.org/campaign.html
http://www.georgedillon.com/web/html_email_is_evil_still.shtml   =20
http://www.gerstbach.at/2004/ascii/ (German)

--nextPart1832580.CVLtlCnN7x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlhqwKgACgkQ7Xtwhpk1UgxMSwCcCTk3YvYaVWQa9oIT8virHtN8
CncAn3xnbNJVhza3tjjfbM5a6vTh83hm
=rPJ8
-----END PGP SIGNATURE-----

--nextPart1832580.CVLtlCnN7x--
