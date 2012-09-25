From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 10/18] OMAPDSS: DISPC: Configure input and output
 sizes for writeback
Date: Tue, 25 Sep 2012 17:33:15 +0300
Message-ID: <1348583595.21717.2.camel@lappyti>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
	 <1348553993-8083-1-git-send-email-archit@ti.com>
	 <1348553993-8083-11-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-T4Ixfv4Y/OrWFaoyKEMJ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:38330 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754429Ab2IYOdV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 10:33:21 -0400
Received: by lbon3 with SMTP id n3so213030lbo.19
        for <linux-omap@vger.kernel.org>; Tue, 25 Sep 2012 07:33:18 -0700 (PDT)
In-Reply-To: <1348553993-8083-11-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-T4Ixfv4Y/OrWFaoyKEMJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-09-25 at 11:49 +0530, Archit Taneja wrote:
> Writeback uses the WB_PICTURE_SIZE register to define the size of the con=
tent
> written to memory, this is the output of the scaler. It uses the WB_SIZE
> register to define the size of the content coming from the overlay/manage=
r to
> which it is connected, this is the input to the scaler. This naming is di=
fferent
> as compared to overlays.
>=20
> Add checks for writeback in dispc_ovl_set_input_size() and
> dispc_ovl_set_output_size() to write to the correct registers.
>=20
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/di=
spc.c
> index e42e902..04fdd33 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -719,7 +719,7 @@ static void dispc_ovl_set_input_size(enum omap_plane =
plane, int width,
>  {
>  	u32 val =3D FLD_VAL(height - 1, 26, 16) | FLD_VAL(width - 1, 10, 0);
> =20
> -	if (plane =3D=3D OMAP_DSS_GFX)
> +	if (plane =3D=3D OMAP_DSS_GFX || plane =3D=3D OMAP_DSS_WB)
>  		dispc_write_reg(DISPC_OVL_SIZE(plane), val);
>  	else
>  		dispc_write_reg(DISPC_OVL_PICTURE_SIZE(plane), val);
> @@ -734,7 +734,10 @@ static void dispc_ovl_set_output_size(enum omap_plan=
e plane, int width,
> =20
>  	val =3D FLD_VAL(height - 1, 26, 16) | FLD_VAL(width - 1, 10, 0);
> =20
> -	dispc_write_reg(DISPC_OVL_SIZE(plane), val);
> +	if (plane =3D=3D OMAP_DSS_WB)
> +		dispc_write_reg(DISPC_OVL_PICTURE_SIZE(plane), val);
> +	else
> +		dispc_write_reg(DISPC_OVL_SIZE(plane), val);
>  }

Should we just rename the dispc registers to DISPC_OVL_IN_SIZE and
DISPC_OVL_OUT_SIZE, and then we could do without the ifs? The registers
have always confused me a bit, I don't know why they are named so in the
TRM.

 Tomi


--=-T4Ixfv4Y/OrWFaoyKEMJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQYcCrAAoJEPo9qoy8lh719rsQAIgOijA4vatBbSm658kk6fUh
qoJV2wJIt1fmS16W04Jx6/ZuQayGMqz9Y5UmSSX7reBji7167aPl9OQ2+BUF5mVU
rq1Y6LdmMpCtvHulWUB3dCNe5VDxJ8cNm3cWsiEH9pwI8RMOAJOFB88f6ebAXA6n
loRxAQAfTaj2feTdpS/NAORROrsakBmP60NogXjrMTNDW9xmrkaTw2m8T2gcZ01B
WvgTANf8aAFy7ZtLnwTTup7nDxfsBYrrEzjWcVB7fbxVVoqPKx0i9mePCbtVZXHw
oG/fH7pRruadPwjpnBzp4N6Yzw5M4z92Z7Aj5mxGYAC0k2KobLuoFxVzBgMFTFcN
CWhz0xuq2SKkmigBkoGxcIlon6VRKFyRB15qGUjAcDzQSzUTMZ4NzMYMxpH8THu5
oyjBqh35ANIpgVEZng/CAOjXGtTlmN/9/w/8NPUtpe4vNqcXDSYICjXHBJZFmSwa
urgD+NU4FQpPvMDwqMcuwmRbgF1yUlNp1KAw91cYAMY+z2tVvt2ufjArHnQSy5If
sZpDpr/1/xx2IAEpk6Q2DPCa85yyNKI4BUe6PTAH2yFySqc79YH57LrMG6Ol1N3v
ykY7q+2nY8cVzeQ2nw2RkNDLi9ks2uABD5i4dH5XReDrDLXNkyT9yGWadPLm8pt0
CamFu39LdX1r+VIexsbA
=SZFc
-----END PGP SIGNATURE-----

--=-T4Ixfv4Y/OrWFaoyKEMJ--

