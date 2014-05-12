From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/3] clk: ti: add 'ti,round-rate' flag
Date: Mon, 12 May 2014 15:13:51 +0300
Message-ID: <5370BAFF.9070501@ti.com>
References: <1399540009-6953-1-git-send-email-tomi.valkeinen@ti.com> <5370B839.3050108@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="0WRl7DKkafWghO0GmR0FHh4oDph8LhUBQ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47628 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753327AbaELMN5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 May 2014 08:13:57 -0400
In-Reply-To: <5370B839.3050108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

--0WRl7DKkafWghO0GmR0FHh4oDph8LhUBQ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/05/14 15:02, Tero Kristo wrote:
> On 05/08/2014 12:06 PM, Tomi Valkeinen wrote:
>> The current DPLL code does not try to round the clock rate, and instea=
d
>> returns an error if the requested clock rate cannot be produced exactl=
y
>> by the DPLL.
>>
>> It could be argued that this is a bug, but as the current drivers may
>> depend on that behavior, a new flag 'ti,round-rate' is added which
>> enables clock rate rounding.
>=20
> Someone could probably argue that this flag is not a hardware feature,

I fully agree.

> but instead is used to describe linux-kernel behavior, and would
> probably be frowned upon by the DT enthusiasts. Othen than that, I like=

> this approach better than a global setting, but would like second
> opinions here.

I think the dpll code should always do rounding. That's what
round_rate() is supposed to do, afaik. The current behavior of not
rounding and returning an error is a bug in my opinion.

So, if you ask me, the whole flag is just for the purpose of keeping the
current drivers working, which could depend on the broken behavior. But
I think we cannot have such drivers (functional, at least) in any case,
as the clk-divider driver is broken and doesn't handle the errors the
dpll code currently returns for non-exact rates.

 Tomi



--0WRl7DKkafWghO0GmR0FHh4oDph8LhUBQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTcLr/AAoJEPo9qoy8lh71pBQP/2xcO+TNKlvwkLHwD+C2o9DX
YgWQQieSEA9+tYzGKW8+A1vd3c5Zclhr/Nb0cxFwBNzyo9t3Iwz6Knjt2w6GGqec
cZtWOCLs9RiEoloByX+5oFL/s85Xh8TkChHs3+zQaR1qTbK+L1uGgLPQ/PPI1d2w
CiIlL8in5YYnnZNyVEiaMI82GS2WnEv+a+2Mo4sMQq0l7ebfvteJFFpkEGmjSMcC
VzRSKV9k8acZhbWoJwIDYdWm4CgR4FFoNVKeHUilFXn+Guyv2aouwLcTg39vRgG8
VMKo1a5aNDdBu8LSDLxj3I7R5PPkScNRDMz2JpENX/89nN8fqOiyp2iUK4mf4Jb7
7gaSJX8y+3nv790mcpK+Mi+L95++vtf9EqwlbaBkpXRai0RmPyNp1oIWxr4PjHg/
don9shm0icQb1OJ9dmqAOyTAmmaHSqhEcY2McwNnEFtato0iMpsvOojseULdJWJg
uOIediePGS6AnRBoHvuYOsl7GHde8gZfrXJ4KaQbYgRQ9dTlrob/PEiSt83Js+LV
4YAzSvk4wC4kz0+hLvQDru3mmnJSJbPoq3dXccidxqcaS4eqkV948/V0YzgEWTPi
FcuqerjYJcVYzmF+89qANYAUL6cptue0EHjtcQxTSR4/J54gEZaSzCL6ZKJ7HR+r
isnoBA1m2fNsOXK3QEtn
=FPTe
-----END PGP SIGNATURE-----

--0WRl7DKkafWghO0GmR0FHh4oDph8LhUBQ--
