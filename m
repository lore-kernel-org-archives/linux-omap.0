From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/3] ARM: OMAP4: use CLK_SET_RATE_PARENT for dss_dss_clk
Date: Thu, 24 Oct 2013 11:03:25 +0300
Message-ID: <5268D44D.5010205@ti.com>
References: <1381324359-28825-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="L4Kx0e1KsMdvFrA6M1o94kRUpqclfDi7I"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50645 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090Ab3JXIDw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Oct 2013 04:03:52 -0400
In-Reply-To: <1381324359-28825-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Kristo, Tero" <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Archit Taneja <archit@ti.com>

--L4Kx0e1KsMdvFrA6M1o94kRUpqclfDi7I
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Tony, Tero,

On 09/10/13 16:12, Tomi Valkeinen wrote:
> Set CLK_SET_RATE_PARENT flag for dss_dss_clk so that the DSS's fclk can=

> be configured without the need to get the parent of the fclk.
>=20
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  arch/arm/mach-omap2/cclock44xx_data.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap=
2/cclock44xx_data.c
> index b237950..ec0dc0b 100644
> --- a/arch/arm/mach-omap2/cclock44xx_data.c
> +++ b/arch/arm/mach-omap2/cclock44xx_data.c
> @@ -830,7 +830,8 @@ DEFINE_CLK_GATE(dss_tv_clk, "extalt_clkin_ck", &ext=
alt_clkin_ck, 0x0,
>  		OMAP4430_CM_DSS_DSS_CLKCTRL,
>  		OMAP4430_OPTFCLKEN_TV_CLK_SHIFT, 0x0, NULL);
> =20
> -DEFINE_CLK_GATE(dss_dss_clk, "dpll_per_m5x2_ck", &dpll_per_m5x2_ck, 0x=
0,
> +DEFINE_CLK_GATE(dss_dss_clk, "dpll_per_m5x2_ck", &dpll_per_m5x2_ck,
> +		CLK_SET_RATE_PARENT,
>  		OMAP4430_CM_DSS_DSS_CLKCTRL, OMAP4430_OPTFCLKEN_DSSCLK_SHIFT,
>  		0x0, NULL);

I was discussing with Tero about these three patches, and he was ok with
them being merged.

Tony, it'd be great to have these for 3.13, so that I can start cleaning
up the DSS driver's fclk management.

 Tomi



--L4Kx0e1KsMdvFrA6M1o94kRUpqclfDi7I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSaNRNAAoJEPo9qoy8lh71TPAQAJYGR2GbmLVK2SXeL83IJr1X
b066OPek+P6Z1DojtPALQoiAEME7tOs1/21luYZKrr46NL5StIi0Jh4KmRmE28pH
5QHndcTdkRJfmf5Zy6wmjh0pmxzuHWornCiq2LevS4uZ7OFdzfPSXATrAt5h2QNf
0t5z+7MpCePmAkXgeYjie9SOCWJr1tPjOuj+8gURNe/KJir6qm2MZSs6cunemUaw
pKuVjQ0x68piAXHo/qaQXSROzPHZ1pA/rGKkHSb+hRPtEq4gsw77YHMyr9k34YKo
6MpZsFV0vLDeCfd64cdFKfowS/Nq7j1kf7Zw6if3Eov02W0i87PEAfry6iQts0rn
UNU5dSYhm+so6abTFc9+Sk5Wyhu24YxzgHryJSLHFVj3AMVD2tYsZBYq9uTjr0hi
JAtCehqRHoZwQQYFUZxHSs1ru4Fhy4aYMEv8EDnRUoycPbeODsRLPesxFTAoxaIu
ke5IsK/BkU80mlp9Orv2/I/MRaNFV/v4WitY5mdlBRjVgWGjVcQIOIhrXdyJx1Y2
EcSyHoPmopXA5zU/pG/4wI6xpk6WoCH44JPNDpNoCWNbEUUW7B+4zGhIvJ4KeNf9
95mWdWvDxn+GibvDdCQuFoUlJRNkKpYnq+/uYXQw0NBSnZR1+O1S91NydUabuIBK
TENwsRrFSm9MuSEKaeO1
=4pBq
-----END PGP SIGNATURE-----

--L4Kx0e1KsMdvFrA6M1o94kRUpqclfDi7I--
