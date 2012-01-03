From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: add OrtusTech COM43H4M10XTC display support
Date: Tue, 03 Jan 2012 11:30:22 +0200
Message-ID: <1325583022.1973.9.camel@deskari>
References: <1324940201-16079-1-git-send-email-yanok@emcraft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-21tz4qj160QGJfEQmE+p"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:47584 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751185Ab2ACJa1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jan 2012 04:30:27 -0500
In-Reply-To: <1324940201-16079-1-git-send-email-yanok@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, sasha_d@emcraft.com


--=-21tz4qj160QGJfEQmE+p
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2011-12-26 at 23:56 +0100, Ilya Yanok wrote:
> dd data for the OrtusTech COM43H4M10XTC display to the
> generic_dpi_panel driver.
>=20
> CC: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> ---
>  drivers/video/omap2/displays/panel-generic-dpi.c |   20 ++++++++++++++++=
++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/v=
ideo/omap2/displays/panel-generic-dpi.c
> index 593f831..99669ae 100644
> --- a/drivers/video/omap2/displays/panel-generic-dpi.c
> +++ b/drivers/video/omap2/displays/panel-generic-dpi.c
> @@ -317,6 +317,26 @@ static struct panel_config generic_dpi_panels[] =3D =
{
>  					  OMAP_DSS_LCD_IHS,
>  		.name			=3D "focaltech_etm070003dh6",
>  	},
> +	/* OrtusTech COM43H4M10XTC */
> +	{
> +		{
> +			.x_res		=3D 480,
> +			.y_res		=3D 272,
> +
> +			.pixel_clock	=3D 8000,
> +
> +			.hsw		=3D 41,
> +			.hfp		=3D 8,
> +			.hbp		=3D 4,
> +
> +			.vsw		=3D 10,
> +			.vfp		=3D 4,
> +			.vbp		=3D 2,
> +		},
> +		.config			=3D OMAP_DSS_LCD_TFT,
> +
> +		.name			=3D "ortustech_com43h4m10xtc",
> +	},
>  };
> =20

Thanks, I'll apply to DSS tree.

 Tomi


--=-21tz4qj160QGJfEQmE+p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPAsquAAoJEPo9qoy8lh71T6MQAILIOhNIdXMbot3P6m2xR/hl
gjTT68HImSiTSxAcWQThVAy9E/0ICaXD9P7tXtyY1EnknDHEC0Waz+gB+cZcjhFL
PYwDFNJatdoE5PW0Bncr/PMrMk1KXkPb03DNp6GdH25lUFiDah4aqiFAkDTV2ohG
B1kLU7Yj+edMED81bgZJJMHUQMvn4MDb9qF8B9ZiK0lK5360LxxuYIHbLnTATtqK
smh+7UQGzoMla3CHmbK246UnixmIiUG4+9BAEl6oINz8No+2O8wpbM7ZnUjZarVB
zGLIym0VAZl6CoAYMUTf40jO2tSgjBNHXZozBXZyr1R5aXBuBLdqrqxVF8F9YEcU
CjmibBWTYt0NC0n6P92vzgHEbKDemW8MchO2LBz8cSfEOnQIbgQwe/oNOg+ZSvNC
f2HD087J/xVABhsX13irIavOuuQRPW0tB/Cod5uaKNRI3EQkxBeW5pleEhMdDuOI
yWvOgyZfnbP24MrgLINMS6MT/fIJhegdqUCgimiZ87N37N96C7Ah2yStMkHaYsmy
cDRGXJNALlw249iN3jtppvDcDXceyVd21+/q5Cv0P1SV9q7vjb+/4wsa55H0hvMq
RvaoApjaf/HMP4nUC4I5Qe3yRaHJKFvtHeKA7wABbgS3JQGg/uRt3N9Yp6vh1IAc
L40KEyxMWj6svUIamU6Q
=EonG
-----END PGP SIGNATURE-----

--=-21tz4qj160QGJfEQmE+p--

