From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH V3 2/6] ARM: AM43xx: fix dpll init in bypass mode
Date: Tue, 8 Apr 2014 13:07:37 +0300
Message-ID: <5343CA69.1070209@ti.com>
References: <1395658916-9032-1-git-send-email-sathyap@ti.com> <1395658916-9032-3-git-send-email-sathyap@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="5xbo4VmuoGKd4OX58uMOTvHItA1lpQpO9"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39991 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755169AbaDHKHk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Apr 2014 06:07:40 -0400
In-Reply-To: <1395658916-9032-3-git-send-email-sathyap@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sathya Prakash M R <sathyap@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

--5xbo4VmuoGKd4OX58uMOTvHItA1lpQpO9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On 24/03/14 13:01, Sathya Prakash M R wrote:
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
> Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
> ---
>  arch/arm/mach-omap2/clkt_dpll.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Can you queue this for 3.15 fixes?

 Tomi



--5xbo4VmuoGKd4OX58uMOTvHItA1lpQpO9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTQ8ppAAoJEPo9qoy8lh71vIkP/1Q6NmEuQKCPf8FRC20hcus2
cL8XohXP1kI0o46f4G8+4/ICSN5aGkPBva0Hd5tLsWfm8acShImK3h6JX0UG4gUG
N+JlW42OEn0jss3V3R/6cV6fU7WDSmSntVB/wdTdsvmprIOHG5Cy771CPbeutZjd
o65xPKOZLnpKwFK7a2rCiDSTpRVH/MACEd/mC84tzmrTBmKt7ZshtJuJGUswf/rQ
z3Q/RlfUYtOyqNRbqm3kPPP+u1qLAWJV4we4qjl/5/i2fbhikCyLzNkBmb2nkYpc
GDAvcfdbPtyNq3zGxHVNadJz9OG5OmWhb73PO721AvCa1uFH2HraHCPYrjYhMVGv
3yAh0sxbZTM+pk/dCe+Tbgn+ApmMvbg/kDHBYKK9ET+SG7Z62kiv+pGjxZhACXEr
In0ri3huV4WgTo9td/WvqW6Ku62jH5q6FWPdYRBTuZWS/fda6zpzHyJ0tDidjUu/
NNBoCg3p0ZbKaSFHR1rHvGJk9jMfkcldzP6tVcr9HxB/q96oJ4szRgnmH+nn5HvD
7iorEm973mSdPu3VQzVsLKiVzy3WxlTfN9IJfFZFH7fQWV9o6abUmv0AiLjzcxM3
SdIvbQkPXv5iiRVorgiPjuFLwZ07xMUR51GwV4ufXUqwm2CQK+BRHs+eHOF/CI0R
bIsbN42x6tzpb+j2RH9W
=J3sc
-----END PGP SIGNATURE-----

--5xbo4VmuoGKd4OX58uMOTvHItA1lpQpO9--
