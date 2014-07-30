From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: clock: allow omap2_dpll_round_rate() to
 round to next-lowest rate
Date: Wed, 30 Jul 2014 15:18:39 +0300
Message-ID: <53D8E29F.3010906@ti.com>
References: <alpine.DEB.2.02.1407231043230.32419@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="G3XkgAh8duGlV7EpHDGw6IxPP3tqJrtlu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34033 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752556AbaG3MTG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Jul 2014 08:19:06 -0400
In-Reply-To: <alpine.DEB.2.02.1407231043230.32419@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, mturquette@linaro.org

--G3XkgAh8duGlV7EpHDGw6IxPP3tqJrtlu
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 23/07/14 13:44, Paul Walmsley wrote:
>=20
> Change the behavior of omap2_dpll_round_rate() to round to either the
> exact rate requested, or the next lowest rate that the clock is able to=

> provide.
>=20
> This is not an ideal fix, but is intended to provide a relatively safe
> way for drivers to set PLL rates, until a better solution can be
> implemented.
>=20
> For the time being, omap3_noncore_dpll_set_rate() is still allowed to
> set its rate to something other than what the caller requested; but wil=
l
> warn when this occurs.
>=20
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

Tested on AM437x GP EVM with today's linux-next + this patch. Without
the patch I was only able to use certain pixel clocks, but with this
patch I can select the pixel clock freely (they end up rounded, of course=
).

So looks good to me. Thanks for working on this!

 Tomi



--G3XkgAh8duGlV7EpHDGw6IxPP3tqJrtlu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT2OKfAAoJEPo9qoy8lh71isYP/2MVGjL/F3ZrTSNl7oeQ8PA/
1MxQNxS0Zz4Nv4PnxoHl3bKQGv7sjsketdktNGM/UY/JLhYmR4ABiiRYsPqtxq4F
VbQyJKPrqx+S4r/97Sd+GeQ9Qrv5K6DhCC9CksJPqtwQVZ4JvUzMKp6i1TmKMUjU
Na6ufuZddrrHjiSW8KtSHWsWt0okJC/Ai4p8ALt4YjXVZT0MHo7S12MYC2g2UmPO
G3Ut16S3k1pXGUXmtTBINDRWVsJ5R/QSlSpxToSF1sMmal09E8JcTlKU6Gkrq2lA
2OfBDDOrjWEJ5ZpE0PniWJoHmWmbx8I7HPujHs2CIiFzHjUcAs9ugqyR4aG08TrK
c//1k48Q8oK+eBdI8Co7LJZs7q8U9ZGKCeMPVHLAtk6Z1B9h3AEzixw+gz7Qhy+m
hokGg0z7TPX33yHk5vv7amXMCucGcYyOkkm3QuGWqNu2/N5hLv7g32IMYLWuq2Sy
dbe4/ozUuc2jINKYJbZAC8QcFtGET1xzB6SA3jWuSXUVzR4OfSY61ElAbTPvHEBp
6tWsYYyJTIC6Xv2SThsv6B2mpFu0WDJjfyuOb09x1kyD5NtJbTKP7nBTEISnC/wv
s7dwV1aKSNzO3IVQI5vlqLEsl1vDJZSKP6XdZ41xxzPGvUQ9QDET0k/JaScKllLM
AF+0nT+c00pI4P9Niy27
=qpi2
-----END PGP SIGNATURE-----

--G3XkgAh8duGlV7EpHDGw6IxPP3tqJrtlu--
