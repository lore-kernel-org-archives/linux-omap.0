From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [patch] OMAPDSS: pll: NULL dereference in error handling
Date: Wed, 17 Dec 2014 08:28:56 +0200
Message-ID: <549122A8.6000705@ti.com>
References: <20141216235442.GE31467@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="99H8wCCNjq9iBn2hHVW9pf8WpThmsJCLB"
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20141216235442.GE31467@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--99H8wCCNjq9iBn2hHVW9pf8WpThmsJCLB
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 17/12/14 01:54, Dan Carpenter wrote:
> The regulator_disable() doesn't accept NULL pointers.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> diff --git a/drivers/video/fbdev/omap2/dss/pll.c b/drivers/video/fbdev/=
omap2/dss/pll.c
> index 50bc62c5..335ffac 100644
> --- a/drivers/video/fbdev/omap2/dss/pll.c
> +++ b/drivers/video/fbdev/omap2/dss/pll.c
> @@ -97,7 +97,8 @@ int dss_pll_enable(struct dss_pll *pll)
>  	return 0;
> =20
>  err_enable:
> -	regulator_disable(pll->regulator);
> +	if (pll->regulator)
> +		regulator_disable(pll->regulator);
>  err_reg:
>  	clk_disable_unprepare(pll->clkin);
>  	return r;
>=20

Thanks! Queuing for 3.19 fbdev fixes.

 Tomi



--99H8wCCNjq9iBn2hHVW9pf8WpThmsJCLB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUkSKoAAoJEPo9qoy8lh71vzwP/2bFiGnsOzfsMV5q+Xlgeqxd
RGy537gusefWKLZWcMbAowl+0pQm9AGIxDvTIBFP6iDnMARGSxagLiI9ywHAKzm9
RHvYxcnKG/iJ12JhK1ASah1ni/va1TGr/NiuxvDMgmPMNYN7VQGn2XMyAwHwEDIC
KhrsXV6c+56zwpukuDMLGYRVZARpk1R5YBqGuNrTBFzw92v4O4ZSr7puoojnHhV+
esSXw9R95S6QHjn4zhxtfeGiYJTiuXx67fjXF/eFJ/7weJ3Ojc7R7AXfAQtliKWo
6rOtYevaUHNlOI0cJeHi+zrONbG2kb0gs8IEACZQaLnOiq2tHo75rpup7+SjqEpn
JGWDysL3ek+CvEguEQfxOvznpqqVkkImpP8e12JH8ANT4Ppbq+tCFuekzgEsYiKk
qlAcho6QHwF0b+KBGkqi3/ZnEtre/29MByBPs/KJC1HEdPotw263ycolpeysujFe
n+sm8RfPV0YOaujaNbN5xhAsLU/RVJHHOa5NW+qaPUXYTa6rsPusE/sGNu0qKwmO
RNS0hNYeyMteuLWU5jZoY57adDd+bnpR1hLfsmGZgdO513XHrBMrmhKsb22KPWut
mHDTiL5kjogbel07oGwD2ZE9zNBCKRZIieYSx6VUmdjvr6H8Ly+Y48HH/pevpALZ
0ipNL98WeYwoBSuLxt3B
=Q9fi
-----END PGP SIGNATURE-----

--99H8wCCNjq9iBn2hHVW9pf8WpThmsJCLB--
