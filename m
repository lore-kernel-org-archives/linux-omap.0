From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 2/4] ARM: AM43xx: fix dpll init in bypass mode
Date: Thu, 13 Mar 2014 12:24:17 +0200
Message-ID: <53218751.20900@ti.com>
References: <1394701109-6721-1-git-send-email-sathyap@ti.com> <1394701109-6721-3-git-send-email-sathyap@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="5r9jI2w2HRQm7tX8QucB5IAa9x49HNaqn"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57095 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752682AbaCMKYg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Mar 2014 06:24:36 -0400
In-Reply-To: <1394701109-6721-3-git-send-email-sathyap@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sathya Prakash M R <sathyap@ti.com>
Cc: tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, paul@pwsan.com

--5r9jI2w2HRQm7tX8QucB5IAa9x49HNaqn
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 13/03/14 10:58, Sathya Prakash M R wrote:
> From: Tomi Valkeinen <tomi.valkeinen@ti.com>
>=20
> On AM43xx, if a PLL is in bypass at kernel init, the code in
> omap2_get_dpll_rate() will not realize this and will try to calculate
> the clock rate using the multiplier and the divider, resulting in
> errors.
>=20
> omap2_init_dpll_parent() has similar issue.
>=20
> Add the missing soc_is_am43xx() check to make the code work on AM43xx.
>=20
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

I see you sent this already in December, and Paul asked for your
signed-off for it, but you never replied.

 Tomi



--5r9jI2w2HRQm7tX8QucB5IAa9x49HNaqn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTIYdRAAoJEPo9qoy8lh71WjgP/AqccCfSSe03Vr4gQKaShOKf
O5OidUFStF4QDjpf7L0vFp76G0gg69bPYbAJQ/MttqEMocs/MN/2kyunmVEzrqwe
lTto2N0jpIRvFcS/ONNMUfPDMWylcj3Ot9IBSrEcBfg/r0TKSDqRkh9NGEHsiXsf
WwlYNZxBTJtb4dR9fwJ15Va6cqI2abJdj/+Q7qId7NzHTq42X8orDwQHppzcoopW
l06E9KTUIfkWmFcZWzgqD7tYXQGisv2CKHRCLiS7NeOfPTII8cOXXy/iAJlMTTsW
5b/RiCyHIwuoFfmpwuZUPXL7Oiwe8OU9/m+aGRCPe5oz0k5esl+3KVs7LuzkLqLh
ikAJxpJVCCtOXFy2cu6XTYmMkL5uvWXhyf9XhYyHtOy+wFWvBUd0dG3T+WEYl0J0
Tf25WfsNB2nlLZckUBWIlxyyFQOuUhod3+LXq/LslXmX6NyoG2eyf3yoJQW/wTmS
rxL7T0OJqebYkHZ9a+Qd+BD2jURCE8tS5x1p/CK9uOIJxWZNxIHFpqbAf75m0ZB3
GQ6UHQfKNRz9YSzTi3e3sfBdh49P2aS7uNxebUHr4tEY2JoxOKa+jZioma1kb57r
whNyxolqITwbeNq0GoAhTZhjy7KUBZh17rV+BhRt2VfYc4dp00KYCDYPPRZJq77K
Dbn2qn1ZnocOWM2TsrGD
=ChcP
-----END PGP SIGNATURE-----

--5r9jI2w2HRQm7tX8QucB5IAa9x49HNaqn--
