From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: omap DSS fails with tft410 driver panel?
Date: Wed, 19 Dec 2012 10:24:37 +0200
Message-ID: <50D179C5.6000106@ti.com>
References: <CAFqH_50PVJdbX0CMwo9t3RuAhzi3q6jcBwzq2R3UFighkrF7iw@mail.gmail.com> <CAGDS+nmx8qFSx932TudMN6ikmZ=OGkbvrZuCV=Ump+HETkU-tw@mail.gmail.com> <50ADE6A5.3030001@ti.com> <CAGDS+nm2YVNyq+eAF-VSq785KAKWC2GM4v5U7N1vLGTNNDfa7Q@mail.gmail.com> <50AF37EA.3080400@ti.com> <CAGDS+nncx71OL7tiwEot6RcyFxipj_SVg=z5Sg-Qdv2n4iyL2A@mail.gmail.com> <50B4A4D7.2070203@ti.com> <CAGDS+nmaGK1igkYnz0EQEycUU=LsD5yz9wxmipSnWohKvAPTXA@mail.gmail.com> <50B74592.3020308@ti.com> <CAGDS+n=oQYr+24mX6bdgtW=fzvfvfX5rAvNXXpxM4YKPxHDodQ@mail.gmail.com> <50B771D3.8050907@ti.com> <CAGDS+n=dbuEQgdw9nJ_mYQpuJr5huSgX6e3sBDcvy0+C6T5hFQ@mail.gmail.com> <50B777A3.1080803@ti.com> <CAAwP0s3hYiovSqRfBFDGVQCDVUqYKZrY9QXp+G-R707szdmVqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDBBCFE1DE1D9C5E6E66FF773"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44337 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752247Ab2LSIYm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Dec 2012 03:24:42 -0500
In-Reply-To: <CAAwP0s3hYiovSqRfBFDGVQCDVUqYKZrY9QXp+G-R707szdmVqA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Steve Sakoman <sakoman@gmail.com>, Enric Balletbo Serra <eballetbo@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>

--------------enigDBBCFE1DE1D9C5E6E66FF773
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2012-12-18 10:31, Javier Martinez Canillas wrote:

> Did you find a solution for this?

Not that I know.

> Also I have this log about a locking dependency:
>=20
> [   24.690795]
> [   24.690826] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   24.690826] [ INFO: possible circular locking dependency detected ]
> [   24.690826] 3.7.0-00017-g6c2ecfb-dirty #144 Not tainted
> [   24.690826] -------------------------------------------------------

I've also seen these. But they don't seem to happen with linux-next (or
Linus' current tree). I haven't been able to figure out the reason for
the warning, but as they seem to have disappeared, they may be related
to something else than omapfb/omapdss.

 Tomi



--------------enigDBBCFE1DE1D9C5E6E66FF773
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQ0XnFAAoJEPo9qoy8lh71R/YP/15y+2sYlvIfsO9aRqy2RldD
kI8Kw6hEJxGn/y5JSRxKDVqNVgsyyP1BVZv1j4VYe+441hfAJ+wGlMnDTzP50kEo
b2rJRjaMDwxcNa2cgwfUfJGe+1mJuCOo2UJ3ww+bW/UtzK2noYLq7pdpuK42Mod1
01YVTa9N57AMDp2U2yFo2124bDm7TDrS7eql1f5xxsbJ9Y89uvx4ulUPKGNqmFbV
yXYw/+vaBtMo4RvsEGOaiipEj1Hwxtieghjp4bZ0t4T+/VoZQlr4Ump5KwlzyzK4
Dscn5FwVUJD0mfxIF2FWEh0zWTZgwOYHsiR0lzBw9n2W2chhkN6ebZ5+gqMgHlli
cXrLo/4JpWBBpwW5IN60vUzVvqwyKPEFRsP1fyj1zHnk5USIFde7na1FE2WUmi+W
JebFrP6f24Qab+FR3NPrK4jb251IW4Rh2XNmCAf9O4mpIl9XlSD+seZ9KO1nSLBT
eT3s4UzOz5g99+LrX4oH9Q3bxrLHJdskC0V4pUXh9NPGX3RZuixg2LLqae3Gqj8w
HmMbZixv8r6MJ7vvFY64nXkrYoPkqBDbQgTC7mQsAMOUoM4w3l6yVEh5NH0xaEDs
T0WiHPtfhgITEf8jsezykqxAN5vAWYFYZBBn47+ZeLW9a8n8TxZRZtjwv7tGrSgx
Z4OPVkgfsvinBXXsVBtx
=Kmw9
-----END PGP SIGNATURE-----

--------------enigDBBCFE1DE1D9C5E6E66FF773--
