From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 05/33] arm: omap: board-cm-t35: use generic dpi panel's
 gpio handling
Date: Thu, 14 Feb 2013 09:09:03 +0200
Message-ID: <511C8D8F.9060805@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com> <1360765345-19312-6-git-send-email-archit@ti.com> <511BAE50.2090507@compulab.co.il> <511BB113.3020108@ti.com> <511BB87E.60003@ti.com> <511C8A83.5070407@compulab.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig095A9DBF344356EEA8B2249A"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52920 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752037Ab3BNHJH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Feb 2013 02:09:07 -0500
In-Reply-To: <511C8A83.5070407@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>

--------------enig095A9DBF344356EEA8B2249A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-02-14 08:56, Igor Grinberg wrote:
> On 02/13/13 17:59, Tomi Valkeinen wrote:

>> Okay, so I just realized there's an spi backlight driver used here, an=
d
>> that backlight driver is actually handling the SPI transactions with t=
he
>> panel, instead of the panel driver. So this looks quite messed up.
>=20
> Yep, it always was.
> The whole DSS specific panel handling inside the
> drivers/video/omap2/displays is a mess.

Well, that's not mess itself, it's just omap specific panel framework.
But dividing single device handling into two separate places is a mess.

> Those panels can be (and are) used not only with OMAP based boards.

True, but as there's no generic panel framework, that's the best we can
do. But see CDF (common display framework) discussions if you're
interested in what's hopefully coming soon.

>> For a quick solution, can we just set the LCD_EN at boot time (with th=
e
>> msleep), and not touch it after that?
>=20
> That would be sensible for now, so this series can be merged.
> As a more appropriate (and long term) solution,
> I plan on moving the panel reset pin handling to the spi backlight
> driver itself.

Well, if you must. But I suggest moving the whole panel handling into a
(omap specific) panel driver, as it's done for other panels. That way
you'll have a proper panel driver for it, for omap, and when CDF comes,
you'll get a platform independent panel driver for it.

Of course, if you have multiple platforms already using that backlight
driver, the omap specific approach may not be enticing. So perhaps it's
easier to just do the quick fix and wait for CDF.

 Tomi


--------------enig095A9DBF344356EEA8B2249A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRHI2PAAoJEPo9qoy8lh71xeUP/RLKpWwHbk5XcSVChCc4NGbK
Xwywjh3iN598IYfpHDbfZs0r7ZVt72iUszz3RviVVkOyJfmVwaFUNaUKCqx8RtJ1
/5RaFOkaxA9TBSvVKLXRpWL0kfeoOsUB+daCZUt/ambVkLViPw7M+PEIzx2A/lGk
QuKbCDMaEPWKd54Se7Rr78lAVY8+4oFeOlCtwyn/37mASLFC1yl6oAos2oVl726K
XQbngMsPREd4/+UK5lA9NIKRyMsYDdUCARBVQV0kK0sSPx13DUZAxBRbgg/M9zZ2
4ZCPWAh8lioqnh3wXW+Rve/vOB630j6k7B4HH4CrIfkTYU6xZrYwA6EkkdkS3FR4
0dd5S1eJy2/5JLn2ArIBV3eSJ+rXAXD6O2ZjF0jLetS/dInYlA7IoQ7SI1DF4Aus
S6iA8HgQYcXlgPCgube5RBY5EhC30zJiQALq1ZifM03iWYsJLdYUiQeahDL/tPzn
aDU8lQYBnZtpmEd46BSDS1vtIITEqRkOGxsuWn2sKtoJfQCcYjjYjqQpMI4/K621
GghrDJqZLmrbQFxPcFPzUYP8WGZXEz0bfauDr0kQm1X5IWkw/OnG6rD6t5y6BCjZ
e5y56RJJxiXjB1+btMSnsGmyNp6Si5oiOh3CtnlrXfDS5SvHmNz0HixHhVBzZmWQ
aLx38OkDOh98ivmXYkAi
=bF7P
-----END PGP SIGNATURE-----

--------------enig095A9DBF344356EEA8B2249A--
