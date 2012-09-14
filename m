From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 21/21] OMAPDSS: DISPC: Configure color conversion
 coefficients for writeback
Date: Fri, 14 Sep 2012 12:07:29 +0300
Message-ID: <1347613649.2559.63.camel@deskari>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
	 <1347538505-25359-22-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-Z+d2E2s4sqrujWcWgC3+"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:38008 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753583Ab2INJHf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Sep 2012 05:07:35 -0400
Received: by lbbgj3 with SMTP id gj3so2596728lbb.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Sep 2012 02:07:32 -0700 (PDT)
In-Reply-To: <1347538505-25359-22-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-Z+d2E2s4sqrujWcWgC3+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-09-13 at 17:45 +0530, Archit Taneja wrote:
> Writeback pipeline receives RGB data from one of the overlays or one of t=
he
> overlay managers. If the target color mode is YUV422 or NV12, we need to =
convert
> the RGB pixels to YUV. The scalar in WB then converts it to the target co=
lor
> mode.
>=20
> Hence, the color conversion coefficients that need to be programmed are t=
he ones
> which convert a RGB24 pixel to YUV444. Program these coefficients for wri=
teback
> pipeline.
>=20
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c |   20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/di=
spc.c
> index 1623c9b..5811a18 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -681,20 +681,30 @@ static void dispc_plane_set_scale_coef(enum omap_pl=
ane plane, int fir_hinc,
>  static void _dispc_setup_color_conv_coef(void)
>  {
>  	int i;
> +	int num_ovl =3D dss_feat_get_num_ovls();
> +	int num_wb =3D dss_feat_get_num_wbs();
> +
>  	const struct color_conv_coef {
>  		int  ry,  rcr,  rcb,   gy,  gcr,  gcb,   by,  bcr,  bcb;
>  		int  full_range;
> -	}  ctbl_bt601_5 =3D {
> -		298,  409,    0,  298, -208, -100,  298,    0,  517, 0,
> +	}  ctbl_bt601_5[2] =3D {
> +		{ 298,  409, 0, 298, -208, -100, 298, 0, 517, 0, },
> +		{ 66, 112, -38, 129, -94, -74, 25, -18, 112, 0, },
>  	};
> =20
>  	const struct color_conv_coef *ct;
> =20
>  #define CVAL(x, y) (FLD_VAL(x, 26, 16) | FLD_VAL(y, 10, 0))
> +#define YUVTORGB 0
> +#define RGBTOYUV 1
> =20
> -	ct =3D &ctbl_bt601_5;
> +	ct =3D &ctbl_bt601_5[YUVTORGB];
> +
> +	for (i =3D 1; i < num_ovl + num_wb; i++) {
> +
> +		if (i >=3D num_ovl)
> +			ct =3D &ctbl_bt601_5[RGBTOYUV];
> =20
> -	for (i =3D 1; i < dss_feat_get_num_ovls(); i++) {
>  		dispc_write_reg(DISPC_OVL_CONV_COEF(i, 0),
>  			CVAL(ct->rcr, ct->ry));
>  		dispc_write_reg(DISPC_OVL_CONV_COEF(i, 1),

This looks a bit funny. I'd suggest to take the actual register writes
to a separate function, and have a separate tables for ovls and wb, and
have two for loops, first for ovls and then for wbs.

Btw, I wonder if we could consider WB as a single special entity, i.e.
no need for "num_wbs" or such. I know things may change in the future
HW, but I got the impression that adding overlays to DSS is costly, and
single WB is enough.

Then again, I'm not sure if handling only single WB would simplify much.
If you think it's no issue to have support for multiple WBs, perhaps we
can have it, just in case.

 Tomi


--=-Z+d2E2s4sqrujWcWgC3+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQUvPRAAoJEPo9qoy8lh712EwQAIl+IHo1OfFsjEjPd/0W32Wa
1ZeaZVcwM0wpCd6TB4Nmlhy27ZA21FIkUlj3kqqS8bAAvuLYralWUebxZNl403wa
QPww+jHf2KGcVZR1gFwbhVGODhV3TUMXl4p9rEO/zRitGWA79rg/nw+BGjPDUjfs
HAgSMaECoBYZTZhWHZ2/ddLjgRsltB64HJ2D+KLnA64gVA85ab6oj3al85DLZUXa
gj8+6eSnTUnjQ+yiYWhjyHqx5+AbTSpHK7AZe5KmGeH4sj7jtYf42c286djU5LRQ
O2+wv2pH03ZCDSlV6jbyVAHH7hDwPhGhzSsakVp1oPDdxk6lcDIWERWGyHqErfr1
noT7F3FbKjSC3hhEQWQRf16AHHPd0vdCMMW34CRWruHxV4f6o9PwVU6fsoMA5qED
XQE3mycvDigm8VxzCabzCEv6NOks0dMCKKVxMuW2l3Yq3rbw3Q2d9bewATj1T5Ka
pe+woI1QnRBIX5ns8p1O8oRpXuD3HnKgUxq3de/Idg9uWDfdYGH4jAAmpGL4gDwP
uC0HmNkBarcGx1e3wgYC4p4TFJqYjr1U0lLEgsUJeaiWLJ4qTv/b04jo7ngW3MRQ
MgTFJhs5HWAfhgsRrhBKWwmC/2IGQutfbAgJ2iSf7IM/Da4X7s/MwhOUenF5KeVC
7x+PezK4yVuWZsAp58Ki
=5RuS
-----END PGP SIGNATURE-----

--=-Z+d2E2s4sqrujWcWgC3+--

