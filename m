From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 6/8] omapdss: Features: Fix some parameter ranges
Date: Wed, 27 Mar 2013 09:33:58 +0200
Message-ID: <5152A0E6.3010300@ti.com>
References: <1362493070-17706-1-git-send-email-archit@ti.com> <1364305525-28496-1-git-send-email-archit@ti.com> <1364305525-28496-7-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0B68C973EEFD153AD449E2E0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59998 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753240Ab3C0HeC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Mar 2013 03:34:02 -0400
In-Reply-To: <1364305525-28496-7-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: robdclark@gmail.com, andy.gross@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

--------------enig0B68C973EEFD153AD449E2E0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-26 15:45, Archit Taneja wrote:
> Increase the DSS_FCLK and DSI_FCLK max supported frequencies, these com=
e because
> some frequencies were increased from OMAP5 ES1 to OMAP5 ES2. We support=
 only
> OMAP5 ES2 in the kernel, so replace the ES1 values with ES2 values. Inc=
rease the
> DSI PLL Fint range, this was previously just copied from the OMAP4 para=
m range
> struct.
>=20
> Fix the maximum DSS_FCLK on OMAP2, it's 133 Mhz according to the TRM.
>=20
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/video/omap2/dss/dss_features.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/oma=
p2/dss/dss_features.c
> index 7f791ae..77dbe0c 100644
> --- a/drivers/video/omap2/dss/dss_features.c
> +++ b/drivers/video/omap2/dss/dss_features.c
> @@ -414,7 +414,7 @@ static const char * const omap5_dss_clk_source_name=
s[] =3D {
>  };
> =20
>  static const struct dss_param_range omap2_dss_param_range[] =3D {
> -	[FEAT_PARAM_DSS_FCK]			=3D { 0, 173000000 },
> +	[FEAT_PARAM_DSS_FCK]			=3D { 0, 133000000 },
>  	[FEAT_PARAM_DSS_PCD]			=3D { 2, 255 },
>  	[FEAT_PARAM_DSIPLL_REGN]		=3D { 0, 0 },
>  	[FEAT_PARAM_DSIPLL_REGM]		=3D { 0, 0 },
> @@ -459,15 +459,15 @@ static const struct dss_param_range omap4_dss_par=
am_range[] =3D {
>  };
> =20
>  static const struct dss_param_range omap5_dss_param_range[] =3D {
> -	[FEAT_PARAM_DSS_FCK]			=3D { 0, 200000000 },
> +	[FEAT_PARAM_DSS_FCK]			=3D { 0, 209250000 },
>  	[FEAT_PARAM_DSS_PCD]			=3D { 1, 255 },
>  	[FEAT_PARAM_DSIPLL_REGN]		=3D { 0, (1 << 8) - 1 },
>  	[FEAT_PARAM_DSIPLL_REGM]		=3D { 0, (1 << 12) - 1 },
>  	[FEAT_PARAM_DSIPLL_REGM_DISPC]		=3D { 0, (1 << 5) - 1 },
>  	[FEAT_PARAM_DSIPLL_REGM_DSI]		=3D { 0, (1 << 5) - 1 },
> -	[FEAT_PARAM_DSIPLL_FINT]		=3D { 500000, 2500000 },
> +	[FEAT_PARAM_DSIPLL_FINT]		=3D { 150000, 52000000 },

Just a note, I think the PLL FINT range for OMAP3/4 may be wrong also.
Some TRMs mention the FINT range being up to 52MHz or so. I don't think
it's ever very clearly stated, though...

 Tomi



--------------enig0B68C973EEFD153AD449E2E0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRUqDmAAoJEPo9qoy8lh71M2EP/2HaYGvsCRliaK4QvbW3gkEX
kflXKwRDJB3tGAKzkFaaaKn3tL30vPrWysLcznmnHDYE6oGJLkmfo/zbD9j/6dwc
TrlHzJpCUi5JN67p+xSyv9Mz5I6wbxatty7AO2DoxtXoVqx7iBcjV0MJ3lQCfDNW
Jy6dHcXj0OD/BOc6Gd/Ky8jqmmm9tRY7kkzX3fvAL1Tc0zeAj0GmFg4vtcoy2gu0
yhWIxnAgUzMeTCBDNFapFNn/Q5KDEyWAoTrnddIBpfZbEKt0ZH8Ky9wp6Ek3dz19
JvJI3RZHB0f4/viHfAAssOgXflLwcWqwqd10lOrmFuJKs87h9wu3p87UluB2uC5+
cUSVm5ikykGJMLr1WgONmu00YuXPe/vPjOH185V26EMXQGCPkyNFikE/Raxa938R
e67a06SgBR60/6ZLul77oa81XVX8tIiYPUj8COiI/ZIdIyOeqs7HmqIxb/EgCu/L
ntipdyF5qp3dem8e6LBMXkBmT/tjXGk6CMHyKgzZe+oi4Ps4bxTLpyJLbCXvxxA+
J2ekFN/o5fyVi/3Y4TQFAL0bUfdaDyyrNxlz//tDyYoSI0FNbFHyPDdhMGhPeFq6
TZYqxhjs6vTqFLnwQt6Ei4MDf1H045a4+vrkGHtRY3iDfg9PzFsQhrYpB2RV0XHD
VXeLhi6ICH6FaQ0TYd2g
=uHsE
-----END PGP SIGNATURE-----

--------------enig0B68C973EEFD153AD449E2E0--
