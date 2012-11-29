From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/7] OMAPDSS: DISPC: Move DISPC specific dss_reg_fields
 to dispc_features
Date: Thu, 29 Nov 2012 14:05:44 +0200
Message-ID: <50B74F98.2030108@ti.com>
References: <cover.1354086150.git.cmahapatra@ti.com> <a5bbbc9af3ef5ca2636d3c4dea6cbbe9834e0f62.1354086150.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig47A97A57F3BFAD91E279D853"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57076 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751348Ab2K2MFq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Nov 2012 07:05:46 -0500
In-Reply-To: <a5bbbc9af3ef5ca2636d3c4dea6cbbe9834e0f62.1354086150.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enig47A97A57F3BFAD91E279D853
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-28 12:41, Chandrabhanu Mahapatra wrote:
> The register fields in dss_reg_fields specific to DISPC are moved from =
struct
> omap_dss_features to corresponding dispc_reg_fields, initialized in str=
uct
> dispc_features, thereby enabling local access.
>=20
> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c        |   87 ++++++++++++++++++++++++=
++++----
>  drivers/video/omap2/dss/dss.h          |    4 ++
>  drivers/video/omap2/dss/dss_features.c |   28 ----------
>  drivers/video/omap2/dss/dss_features.h |    7 ---
>  4 files changed, 80 insertions(+), 46 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/=
dispc.c
> index 9f259ba..21fc522 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -80,6 +80,16 @@ struct dispc_irq_stats {
>  	unsigned irqs[32];
>  };
> =20
> +enum dispc_feat_reg_field {
> +	FEAT_REG_FIRHINC,
> +	FEAT_REG_FIRVINC,
> +	FEAT_REG_FIFOLOWTHRESHOLD,
> +	FEAT_REG_FIFOHIGHTHRESHOLD,
> +	FEAT_REG_FIFOSIZE,
> +	FEAT_REG_HORIZONTALACCU,
> +	FEAT_REG_VERTICALACCU,
> +};
> +
>  struct dispc_features {
>  	u8 sw_start;
>  	u8 fp_start;
> @@ -107,6 +117,8 @@ struct dispc_features {
> =20
>  	u32 buffer_size_unit;
>  	u32 burst_size_unit;
> +
> +	struct register_field *reg_fields;
>  };
> =20
>  #define DISPC_MAX_NR_FIFOS 5
> @@ -1150,7 +1162,8 @@ static void dispc_init_fifos(void)
> =20
>  	unit =3D dispc.feat->buffer_size_unit;
> =20
> -	dss_feat_get_reg_field(FEAT_REG_FIFOSIZE, &start, &end);
> +	start =3D dispc.feat->reg_fields[FEAT_REG_FIFOSIZE].start;
> +	end =3D dispc.feat->reg_fields[FEAT_REG_FIFOSIZE].end;
> =20
>  	for (fifo =3D 0; fifo < dispc.feat->num_fifos; ++fifo) {
>  		size =3D REG_GET(DISPC_OVL_FIFO_SIZE_STATUS(fifo), start, end);
> @@ -1214,8 +1227,10 @@ void dispc_ovl_set_fifo_threshold(enum omap_plan=
e plane, u32 low, u32 high)
>  	low /=3D unit;
>  	high /=3D unit;
> =20
> -	dss_feat_get_reg_field(FEAT_REG_FIFOHIGHTHRESHOLD, &hi_start, &hi_end=
);
> -	dss_feat_get_reg_field(FEAT_REG_FIFOLOWTHRESHOLD, &lo_start, &lo_end)=
;
> +	hi_start =3D dispc.feat->reg_fields[FEAT_REG_FIFOHIGHTHRESHOLD].start=
;
> +	hi_end =3D dispc.feat->reg_fields[FEAT_REG_FIFOHIGHTHRESHOLD].end;
> +	lo_start =3D dispc.feat->reg_fields[FEAT_REG_FIFOLOWTHRESHOLD].start;=

> +	lo_end =3D dispc.feat->reg_fields[FEAT_REG_FIFOLOWTHRESHOLD].end;

I think these are quite verbose. Perhaps a helper function which does
the same as dss_feat_get_reg_field() would be better. Or alternatively,
maybe something like:

const struct dss_reg_field *hi_field =3D
&dispc.feat->reg_fields[FEAT_REG_FIFOHIGHTHRESHOLD];

and then use "hi_field.start" instead of hi_start.

Or something else that makes the above easier to read.

> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/ds=
s.h
> index 84a7f6a..aa273d8 100644
> --- a/drivers/video/omap2/dss/dss.h
> +++ b/drivers/video/omap2/dss/dss.h
> @@ -143,6 +143,10 @@ struct reg_field {
>  	u8 low;
>  };
> =20
> +struct register_field {
> +	u8 start, end;
> +};
> +

We already have the dss_reg_field struct. I think it's better to move
that to dss.h, and use it, instead of creating an exact duplicate.

 Tomi



--------------enig47A97A57F3BFAD91E279D853
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQt0+YAAoJEPo9qoy8lh71eU8P/AgxUPgQ20PjyROPmrtmu7g5
wsWyhVg+u5n/+Pym7pjZubuZ/hIWIZ6RtimYXHhgEOMDUMZ+iw53Z+S4QtusWwAq
GfAGfGQk4qrJmz1ApOOMw1i9ZnQV+LIIDV6AdINsiHV0S0S+QrdE2aTSCne/7OZf
+HHoz1UEhHz28sfZ2XoZ98zCp88Ka+cGtWxJpjoo18y3i/3qddH+XB4cInIC8BI/
6OaE5/drO4iVEnyRQlJD4bUB5q0K9ZjyMmRr4gdBThXsN0A/UAW2L46UwRJ++uJE
OpiRbHWhgWQ/McFwDolnGnNtIRK2xsFPVbZvgn6g4JnJQrT4US160RVu0a7SBYGR
prd+A7xyc2Lrp+D6NyAA6GmuO6JX81iveyCC683LNODAHOz5ovGGq4m51kE1w7Yw
qGhEf3FDKInK7UnmPP7yXcBivZ6KqO4Rhe0N8kE+5/m4vODkKkVfpFRChwCb33nV
7oorkJqyX1Kdz8qe65wD9C0t+GHuhn7AmsXnI4ICc17vEgYKgTSnOY7zUDdO87Eq
tfo5DDkfZkde2DW8Y0D/Io/J/wFLfHwG+ZBRrTJOQoe6T0BsdfozJoQDf6BODfkN
k2dlTGn4oCH06e/oS4cmFvkZuXoSX5azAAqS36B20Ax3FoiljA9IhyF+wdBnjpQD
awZ266sVwipBxGcVJ9KV
=pC0a
-----END PGP SIGNATURE-----

--------------enig47A97A57F3BFAD91E279D853--
