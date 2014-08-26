From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] ARM: dts: omap54xx-clocks: Fix the l3 and l4 clock rates
Date: Tue, 26 Aug 2014 12:47:22 +0300
Message-ID: <53FC57AA.5040906@ti.com>
References: <1409043098-12510-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="XetwPSgwVReXc9XvUKGq1AB05RcT32cpx"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52133 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755778AbaHZJrx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Aug 2014 05:47:53 -0400
In-Reply-To: <1409043098-12510-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

--XetwPSgwVReXc9XvUKGq1AB05RcT32cpx
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 26/08/14 11:51, Tero Kristo wrote:
> Similarly to DRA7, OMAP5 has l3 and l4 clock rates incorrectly calculat=
ed.
> Fixed by using proper divider clock types for the clock nodes.
>=20
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Reported-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  arch/arm/boot/dts/omap54xx-clocks.dtsi |   16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

Tested-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi



--XetwPSgwVReXc9XvUKGq1AB05RcT32cpx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT/FeqAAoJEPo9qoy8lh71ttAQAJRW1HBxu5braFqCZgPAufhC
WaHC/Yk4M/K/iA4a7dmeja0CFILJBrXUyjkJuUzo8vpnQe3yNvQz0vTs4xFdIerZ
S6A7mgK/OtAbESvkTZej5uIRza+ox27e7qtkLN7S513V60ZbmDP6w5RuBuftbr2p
LkA5+SxhnU+KNa3AKNgLKoKgg9jh6vsVj4B8eG2gg9ANg2cRGiCr6Rjimi2rlvTR
kae5PhS9/VbD8LUAGn+qCZvbf33QX0DivLDvLumva0W2cQva5tLN1Au4nWCOQFUZ
kNOmmTmaCP+7edctRxJcROM9Tf9pg1hCRFzlypOUCAmtdGbWOgPbGh+OcoCEmQSf
r06FlcNe+gxh8bUQO+25mf9sAjLT2VkvVAZ6AiDMmc2aujyw14O6n5qgqMWvjaN5
5vrb9WmFNHKZk5icjMCV7u/NEVAWBrPB1wOFnJXhzb5T0ny1wzoXe3RMLyiOjBFc
TKfKzr9rz1pQHF2SlnFkk0FqxRgYU+uOU+7uk4S/Z31HnrjlrPQPRmph0EG9r+xn
+zg5kVzxwlwxik1AdDFNuB0YGf4+bKeMrS4zTgzimRLNQrwOJzZxlxhYpT9nvVPv
rjt6WXriwUMrw6omn2Ll6RPqTDhkSeUWqhesf0r4vwkdjbTzLoJ/D1JWMjG5zZHL
MFPfntD+teUijE+/IrD3
=dg3o
-----END PGP SIGNATURE-----

--XetwPSgwVReXc9XvUKGq1AB05RcT32cpx--
