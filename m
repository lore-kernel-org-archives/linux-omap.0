From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: clock: allow omap2_dpll_round_rate() to
 round to next-lowest rate
Date: Wed, 17 Sep 2014 16:02:43 +0300
Message-ID: <54198673.3090002@ti.com>
References: <alpine.DEB.2.02.1407231043230.32419@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="ersOek0O0LeEwbKHgQS6jfNvattbgLnE9"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42716 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754786AbaIQNDO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Sep 2014 09:03:14 -0400
In-Reply-To: <alpine.DEB.2.02.1407231043230.32419@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>

--ersOek0O0LeEwbKHgQS6jfNvattbgLnE9
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

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
> ---
>  arch/arm/mach-omap2/clkt_dpll.c | 28 +++++++++++++++++++++-------
>  arch/arm/mach-omap2/dpll3xxx.c  | 12 ++++++++++--
>  2 files changed, 31 insertions(+), 9 deletions(-)

This patch improved things quite a bit, but we still have problems. I
noticed that on AM43xx:

clk_round_rate(dss_fclk, 199990846) =3D 199967213
clk_set_rate(dss_fclk, 199967213) -> 199966387

So similar to the issue that 7e50e7e176634e8cc0335778915be75df41043dc fix=
ed.

Above you say that "omap3_noncore_dpll_set_rate() is still allowed to
set its rate to something other than what the caller requested; but will
warn when this occurs.", but I see no warning printed.

I didn't find out where the error comes from, but I (again) noticed the
two issues we have:

- The omap dpll code has no maximum values, so omap2_dpll_round_rate()
goes on to return ~4GHz rates as valid, which I believe it can't do.

- clk-divider.c driver doesn't handle errors from __clk_round_rate(). At
least omap2_dpll_round_rate() returns ~0 on error.

Any ideas where that round/set issue might come from?

 Tomi



--ersOek0O0LeEwbKHgQS6jfNvattbgLnE9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUGYZ0AAoJEPo9qoy8lh71VLgP/Rbg7SbUnpFFUbMhsedWys+i
sIJPunN8Hov1ymDvrMXsp8kS80XkArwjG/o3tLMQ706WbaJTJLOM4NczIZVzqupo
KmSaqO20/N7r67eY6Svsc8+vD9F2ut8QWyoDSVVxCcquKIUwkwZgFsly2XuR6Kj1
1m4bZlmmuOY3k/whAlnbhgJfMSPahIcxMqoS4AFKqTLp0lSe6vGTN+YBiD4Za3es
zvZtW0yO73IJmntMBDgPtwDjGFSs4u0fdpHKG9OnB3ljP5QJFCOdA7HGKYDTE2hL
B6Aqs8IiyMahUVo9PtdYE3acv8Cbm+1SK52NxIveclSKXFMRucfMcC1eUbNQSvGG
4RmmnG75OCUSryZ0q+BsUn4zxzeNAyhtfmmukHEyw8u90JwU7eRbMNPK7IgJWnCj
RDXiUivBnifDp4acZvRQ56QPke5j0OgOtLZYZitf3u+4rx5HPXZdw1gafR4h6m33
WD5D4hJMHw9OQTgHjew5ehI2Jo/WC0U1NfILLhu8fs6BiaXMKxT7Etcja9EXxXQ3
nu63gC3VLxo79kw/gfj4yx2ge1Wf4Ldvf5q3fI8bcrh7w0+fR2rklTPXKxrJEziZ
7xz8CM3EMu4DIKFS02aV8KECzVxMREQi1VUUHHBAmV2c71mEkDTPZMOAIRjUyFAy
EGEiG6brEhA1/WlHXXCA
=5lKZ
-----END PGP SIGNATURE-----

--ersOek0O0LeEwbKHgQS6jfNvattbgLnE9--
