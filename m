From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 2/2] OMAPDSS: HDMI: Disable DDC internal pull up
Date: Mon, 19 Dec 2011 14:53:59 +0200
Message-ID: <1324299239.31482.37.camel@deskari>
References: <1324298206-19161-1-git-send-email-mythripk@ti.com>
	 <1324298206-19161-2-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-uYvo5RyIMyeiubFjJCMt"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:51765 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751568Ab1LSMyE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Dec 2011 07:54:04 -0500
Received: by mail-lpp01m010-f43.google.com with SMTP id w12so7467970lag.30
        for <linux-omap@vger.kernel.org>; Mon, 19 Dec 2011 04:54:02 -0800 (PST)
In-Reply-To: <1324298206-19161-2-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org, Ricardo Salveti de Araujo <ricardo.salveti@linaro.org>


--=-uYvo5RyIMyeiubFjJCMt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2011-12-19 at 18:06 +0530, mythripk@ti.com wrote:

> diff --git a/include/video/omapdss.h b/include/video/omapdss.h
> index 0cb0469..799470f 100644
> --- a/include/video/omapdss.h
> +++ b/include/video/omapdss.h
> @@ -200,6 +200,10 @@ enum omap_dss_clk_source {
>  	OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DSI,	/* OMAP4: PLL2_CLK2 */
>  };
> =20
> +enum omap_hdmi_flags {
> +	OMAP_HDMI_SDA_SCL_EXTERNAL_PULLUP =3D 1 << 0,
> +};
> +
>  /* RFBI */
> =20
>  struct rfbi_timings {
> @@ -310,7 +314,7 @@ struct omap_dss_board_info {
>  /* Init with the board info */
>  extern int omap_display_init(struct omap_dss_board_info *board_data);
>  /* HDMI mux init*/
> -extern int  omap_hdmi_init(void);
> +extern int omap_hdmi_init(int flags);

You have an enum for flags, so use the enum instead of int.

 Tomi


--=-uYvo5RyIMyeiubFjJCMt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJO7zPnAAoJEPo9qoy8lh71I2QQAIGskZJvDBiAKtWYgtssxIDl
Q9V5QaNDeV+TmneyKZ3rbgVN2rOAqsiJx7J6Ry+1cWZqCTxkGcuArfHZwb3kF4AR
0nJlmllYS2h92Ltqo65HU9UybPsir/rg2JS+X4n+I2/v2OdP6dvcGb+XRtGIdkxA
ja1BNUly4d8D+v01xcbIBS5nUDPchPjPEHlEE6dsUb1ADeBLPvboaf3hyThE2Izg
PuccoXCIQ5s2h8QdsTcB6QE8VO51wHuC09H7T7HkkrEiPojmCyA5fR/INKIHnGpp
yEh/pC78GBIaDfpttXBTsUWylZT9+Iv4rtUMaqtmFTcXdaGmZa+XpANIkpv98Xlc
9e8PHJMLW06iwM14xrcTFNB93omZWeqEfiNQqnhqyEdWcI1cYI5BSoDa/o7ujy4I
HIyFPStBGR50GsEy6GZLbxQgrHUk+1mbnI8MIgXV+fka8Zi9hdInOgSqd9+fHPo9
zpIEOeDavRrG8/TxvvNt2sTe9wzDBQ14BI2mWqp3qMmKTnyipaOfK/0MgUr1Iw+2
QMyfgvFqQ5ZiApK9roUoh1axeL84QX+B5Cj/HJ5HhcVIz37IVQlGBLh2u3Xjp05/
zU27fXaiQQSBHLUcftpB8xCLZsMY1iuKeeUlo1A0A+qWWuiluBWtS7YKk/VHKRzV
ebqnhtZg8gx5kvYh5zQi
=cOkQ
-----END PGP SIGNATURE-----

--=-uYvo5RyIMyeiubFjJCMt--

