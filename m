From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 3/4] clk: ti: 43xx: add debugss clocks to DT_CLK() table
Date: Fri, 23 Jan 2015 20:25:57 -0600
Message-ID: <20150124022557.GA16649@saruman.tx.rr.com>
References: <1422054704-14915-1-git-send-email-balbi@ti.com>
 <1422054704-14915-4-git-send-email-balbi@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46634 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750836AbbAXC0Z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Jan 2015 21:26:25 -0500
Content-Disposition: inline
In-Reply-To: <1422054704-14915-4-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org

--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2015 at 05:11:43PM -0600, Felipe Balbi wrote:
> without these entries, omap_hwmod will not be
> able to find debugss clocks.
>=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/clk/ti/clk-43xx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/clk/ti/clk-43xx.c b/drivers/clk/ti/clk-43xx.c
> index 3795fce8a830..46a597c815c9 100644
> --- a/drivers/clk/ti/clk-43xx.c
> +++ b/drivers/clk/ti/clk-43xx.c
> @@ -83,6 +83,12 @@ static struct ti_dt_clk am43xx_clks[] =3D {
>  	DT_CLK(NULL, "gfx_fck_div_ck", "gfx_fck_div_ck"),
>  	DT_CLK(NULL, "timer_32k_ck", "clkdiv32k_ick"),
>  	DT_CLK(NULL, "timer_sys_ck", "sys_clkin_ck"),
> +	DT_CLK(NULL, "trace_clk_div_ck", "trace_clk_div_ck"),
> +	DT_CLK(NULL, "trace_pm_clk_mux_ck", "trace_pm_clk_mux_ck"),

hmmm, this should be trace_pmd_clk_mux_ck. How did this even work ? I'll
fix and retest.

Won't resend until tomorrow though.

--=20
balbi

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUwwK1AAoJEIaOsuA1yqREzVYP/3WPRP+rLBTPwwd4fAlWouXQ
+HzTlSsA2xuXONWs1t8hR75cEI9qGZsip9CMdDeahSPsY3IioFvC4RMHYYPxWG3a
pCHXfZbpaoPl9vMGpNojiWvhDbT+czZUaToRrgm0qAL4sibjqGCPrJqoOpqjVoj8
5aURdm55UO3beAECDELSH1OKm1EeImD3oIcZLAHUkTEnjKwIPFkLlTDQ2Vzufdvi
0G8fAzOyvkUgsG5kfFk3wax9/LzR76Fy00PVbEyjITvCBKHZJkkCcCJKH+EgCd6R
3T51KSTGSYP2gNp7ijpfgSsvOWTpxrX94XJLJvgCYXIwYU5Mb6es1HY8i9w5eEgF
yrKuxq3UVQBdsUV03U5ainqqeToabs/Q7BHsXq4nocJRvuHT5z/YS8E6GFyfkqAK
rV41slCPLdAZM74uWG5uyPll/3fnlT/B6Pc9j3FEt9RRJOI/JrmEJRfe49Xgm76F
7Cmt5ierAQNSImq/nXAPqkYgIrMgDwuEnOX95ehd+87FYhrkAfdylllW/B8fcYQz
E6d5bn/QmKuz/65Syl4+Rwioc8BNYU0IBpFsKmEOx0VJbZlB9OYHc4hRUHqz/wri
g6Ytm+pKtknS88BGWATGxJcQPkudizPUPn0COBiR8EvElBlteMlafImE302FDU5m
+beobOS+HYGNyBAJuRlH
=Yq4v
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
