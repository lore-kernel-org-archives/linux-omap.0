From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+ Add Primview displays to panel-generic
Date: Fri, 20 Apr 2012 11:30:21 +0300
Message-ID: <1334910621.2058.2.camel@deskari>
References: <1332506912-10313-1-git-send-email-j.weitzel@phytec.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-nldwcMN/RgNIn3iU5a97"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:45686 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756615Ab2DTIa1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Apr 2012 04:30:27 -0400
Received: by lbon10 with SMTP id n10so6800338lbo.2
        for <linux-omap@vger.kernel.org>; Fri, 20 Apr 2012 01:30:24 -0700 (PDT)
In-Reply-To: <1332506912-10313-1-git-send-email-j.weitzel@phytec.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jan Weitzel <j.weitzel@phytec.de>
Cc: linux-omap@vger.kernel.org


--=-nldwcMN/RgNIn3iU5a97
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 2012-03-23 at 13:48 +0100, Jan Weitzel wrote:
> Add displays to panel-generic-dpi.c
> Prime View PD050VL1 (640 x 480)
> Prime View PD104SLF (800 x 600)
> Prime View PM070WL4 (800 x 480)
>=20
> Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
> ---
>  drivers/video/omap2/displays/panel-generic-dpi.c |   63 ++++++++++++++++=
++++++
>  1 files changed, 63 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/v=
ideo/omap2/displays/panel-generic-dpi.c
> index 28b9a6d..85ee8d3 100644
> --- a/drivers/video/omap2/displays/panel-generic-dpi.c
> +++ b/drivers/video/omap2/displays/panel-generic-dpi.c
> @@ -363,6 +363,69 @@ static struct panel_config generic_dpi_panels[] =3D =
{
> =20
>  		.name			=3D "ortustech_com43h4m10xtc",
>  	},
> +
> +	/* Prime-View PD050VL1 */
> +	{
> +		{
> +			.x_res		=3D 640,
> +			.y_res		=3D 480,
> +
> +			.pixel_clock	=3D 25000,
> +
> +			.hsw		=3D 96,
> +			.hfp		=3D 18,
> +			.hbp		=3D 46,
> +
> +			.vsw		=3D 2,
> +			.vfp		=3D 10,
> +			.vbp		=3D 33,
> +		},
> +		.config			=3D OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
> +					  OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IPC,
> +		.name			=3D "pd050vl1",
> +	},

Please use a company name prefix in the name field like the other panels
do, so we avoid any possible name conflicts.

 Tomi



--=-nldwcMN/RgNIn3iU5a97
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPkR6KAAoJEPo9qoy8lh71gGkP/0XYSERAu7NCNd/aZi7RIlGa
B5jhlxzsOoM/PoxcwpMxWIit0/SfRDjJB2dIP/onftFVE9Gdg97ZB9LcQ629MNpB
Whz5i28qAmNbwjhXOx7IoYUhQtxm6Evv/zeGYoHLBnsRRW56qTcl8LfjJpzq/rKj
62zCBcfm26XiDxznF10qkMbnAVmxWhPkn+aS5l3T5zQtvmDQCXU5sQbZxmgJ/95A
KKExGWOHUGML0zZvJKaDMSE9trswoqBJkquMdFSW2TQgjUEfpH32QG/Yj299eeHS
CAH9gR28wDt0SeQIhiUAPezlcKPBfIDpSQnrLPLfpnzRP3HZxxaTzGmnRTYREy4E
9MD6mKq9s3HbKowO0OuEH9IoqSg+HNJgMKTFQTbbVty+DNyMbP53570kfPR7T3Rm
6+I6gux23y/0s7s3veuleigOCI+M/oV0BBtlrrb23axZN3C4uA4zj2LEY7H9oS0Q
scqiSHZzste910jxq7ILmzv5VEhU7IyHgomzlZ2yZRms/PWJDEnIPqUlDkteSujz
87E+3o8m+Ioanfj2i+IkS+0mLFXHCYDAQQU5lkkW40cwcCVWqybQlDXsMaELJqLO
t+sHkKxcYPlQteTKpYueXoKad7fxciB7vJcW4XOGHL5STwUYPWSz/zdknevbKMr2
nx7g5Je9mBXJASMntkS7
=CYS6
-----END PGP SIGNATURE-----

--=-nldwcMN/RgNIn3iU5a97--

