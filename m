From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH V2 2/6] OMAPDSS: DISPC: Move DISPC specific dss_reg_fields
 to dispc_features
Date: Mon, 17 Dec 2012 14:37:22 +0200
Message-ID: <50CF1202.70507@ti.com>
References: <cover.1354086150.git.cmahapatra@ti.com> <cover.1354702077.git.cmahapatra@ti.com> <08d6240ab26427a9e437421c2cc76ade29036817.1354702077.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAA6FE91363F8C790DC5B2B19"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45281 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751703Ab2LQMhY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Dec 2012 07:37:24 -0500
In-Reply-To: <08d6240ab26427a9e437421c2cc76ade29036817.1354702077.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enigAA6FE91363F8C790DC5B2B19
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-12-05 12:16, Chandrabhanu Mahapatra wrote:
> The register fields in dss_reg_fields specific to DISPC are moved from =
struct
> omap_dss_features to corresponding dispc_reg_fields, initialized in str=
uct
> dispc_features, thereby enabling local access.
>=20
> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c        |  114 ++++++++++++++++++++++++=
--------
>  drivers/video/omap2/dss/dss.h          |    4 ++
>  drivers/video/omap2/dss/dss_features.c |   28 --------
>  drivers/video/omap2/dss/dss_features.h |    7 --
>  4 files changed, 89 insertions(+), 64 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/=
dispc.c
> index bbba83f..ee4b152 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -80,6 +80,16 @@ struct dispc_irq_stats {
>  	unsigned irqs[32];
>  };
> =20
> +struct dispc_reg_fields {
> +	struct omapdss_reg_field firhinc;
> +	struct omapdss_reg_field firvinc;
> +	struct omapdss_reg_field fifo_low_thresh;
> +	struct omapdss_reg_field fifo_high_thresh;
> +	struct omapdss_reg_field fifosize;
> +	struct omapdss_reg_field hori_accu;
> +	struct omapdss_reg_field vert_accu;
> +};
> +
>  struct dispc_features {
>  	u8 sw_start;
>  	u8 fp_start;
> @@ -110,6 +120,8 @@ struct dispc_features {
> =20
>  	u32 buffer_size_unit; /* in bytes */
>  	u32 burst_size_unit; /* in bytes */
> +
> +	struct dispc_reg_fields *reg_fields;

This can be pointer to const.

>  };
> =20
>  #define DISPC_MAX_NR_FIFOS 5
> @@ -1137,17 +1149,17 @@ static void dispc_mgr_set_size(enum omap_channe=
l channel, u16 width,
> =20
>  static void dispc_init_fifos(void)
>  {
> -	u32 size;
> +	u32 size, unit;
>  	int fifo;
> -	u8 start, end;
> -	u32 unit;
> +	const struct omapdss_reg_field *fifo_field;
> =20
>  	unit =3D dispc.feat->buffer_size_unit;
> =20
> -	dss_feat_get_reg_field(FEAT_REG_FIFOSIZE, &start, &end);
> +	fifo_field =3D &dispc.feat->reg_fields->fifosize;
> =20
>  	for (fifo =3D 0; fifo < dispc.feat->num_fifos; ++fifo) {
> -		size =3D REG_GET(DISPC_OVL_FIFO_SIZE_STATUS(fifo), start, end);
> +		size =3D REG_GET(DISPC_OVL_FIFO_SIZE_STATUS(fifo),
> +					fifo_field->start, fifo_field->end);
>  		size *=3D unit;
>  		dispc.fifo_size[fifo] =3D size;
> =20
> @@ -1197,8 +1209,8 @@ static u32 dispc_ovl_get_fifo_size(enum omap_plan=
e plane)
> =20
>  void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 =
high)
>  {
> -	u8 hi_start, hi_end, lo_start, lo_end;
>  	u32 unit;
> +	const struct omapdss_reg_field *hi_field, *lo_field;
> =20
>  	unit =3D dispc.feat->buffer_size_unit;
> =20
> @@ -1208,20 +1220,20 @@ void dispc_ovl_set_fifo_threshold(enum omap_pla=
ne plane, u32 low, u32 high)
>  	low /=3D unit;
>  	high /=3D unit;
> =20
> -	dss_feat_get_reg_field(FEAT_REG_FIFOHIGHTHRESHOLD, &hi_start, &hi_end=
);
> -	dss_feat_get_reg_field(FEAT_REG_FIFOLOWTHRESHOLD, &lo_start, &lo_end)=
;
> +	hi_field =3D &dispc.feat->reg_fields->fifo_high_thresh;
> +	lo_field =3D &dispc.feat->reg_fields->fifo_low_thresh;
> =20
>  	DSSDBG("fifo(%d) threshold (bytes), old %u/%u, new %u/%u\n",
>  			plane,
>  			REG_GET(DISPC_OVL_FIFO_THRESHOLD(plane),
> -				lo_start, lo_end) * unit,
> +				lo_field->start, lo_field->end) * unit,
>  			REG_GET(DISPC_OVL_FIFO_THRESHOLD(plane),
> -				hi_start, hi_end) * unit,
> +				hi_field->start, hi_field->end) * unit,
>  			low * unit, high * unit);
> =20
>  	dispc_write_reg(DISPC_OVL_FIFO_THRESHOLD(plane),
> -			FLD_VAL(high, hi_start, hi_end) |
> -			FLD_VAL(low, lo_start, lo_end));
> +			FLD_VAL(high, hi_field->start, hi_field->end) |
> +			FLD_VAL(low, lo_field->start, lo_field->end));
>  }
> =20
>  void dispc_enable_fifomerge(bool enable)
> @@ -1289,14 +1301,13 @@ static void dispc_ovl_set_fir(enum omap_plane p=
lane,
>  	u32 val;
> =20
>  	if (color_comp =3D=3D DISPC_COLOR_COMPONENT_RGB_Y) {
> -		u8 hinc_start, hinc_end, vinc_start, vinc_end;
> +		const struct omapdss_reg_field *hinc_field, *vinc_field;
> =20
> -		dss_feat_get_reg_field(FEAT_REG_FIRHINC,
> -					&hinc_start, &hinc_end);
> -		dss_feat_get_reg_field(FEAT_REG_FIRVINC,
> -					&vinc_start, &vinc_end);
> -		val =3D FLD_VAL(vinc, vinc_start, vinc_end) |
> -				FLD_VAL(hinc, hinc_start, hinc_end);
> +		hinc_field =3D &dispc.feat->reg_fields->firhinc;
> +		vinc_field =3D &dispc.feat->reg_fields->firvinc;
> +
> +		val =3D FLD_VAL(vinc, vinc_field->start, vinc_field->end) |
> +			FLD_VAL(hinc, hinc_field->start, hinc_field->end);
> =20
>  		dispc_write_reg(DISPC_OVL_FIR(plane), val);
>  	} else {
> @@ -1308,13 +1319,13 @@ static void dispc_ovl_set_fir(enum omap_plane p=
lane,
>  static void dispc_ovl_set_vid_accu0(enum omap_plane plane, int haccu, =
int vaccu)
>  {
>  	u32 val;
> -	u8 hor_start, hor_end, vert_start, vert_end;
> +	const struct omapdss_reg_field *haccu_field, *vaccu_field;
> =20
> -	dss_feat_get_reg_field(FEAT_REG_HORIZONTALACCU, &hor_start, &hor_end)=
;
> -	dss_feat_get_reg_field(FEAT_REG_VERTICALACCU, &vert_start, &vert_end)=
;
> +	haccu_field =3D &dispc.feat->reg_fields->hori_accu;
> +	vaccu_field =3D &dispc.feat->reg_fields->vert_accu;
> =20
> -	val =3D FLD_VAL(vaccu, vert_start, vert_end) |
> -			FLD_VAL(haccu, hor_start, hor_end);
> +	val =3D FLD_VAL(vaccu, vaccu_field->start, vaccu_field->end) |
> +		FLD_VAL(haccu, haccu_field->start, haccu_field->end);
> =20
>  	dispc_write_reg(DISPC_OVL_ACCU0(plane), val);
>  }
> @@ -1322,13 +1333,13 @@ static void dispc_ovl_set_vid_accu0(enum omap_p=
lane plane, int haccu, int vaccu)
>  static void dispc_ovl_set_vid_accu1(enum omap_plane plane, int haccu, =
int vaccu)
>  {
>  	u32 val;
> -	u8 hor_start, hor_end, vert_start, vert_end;
> +	const struct omapdss_reg_field *haccu_field, *vaccu_field;
> =20
> -	dss_feat_get_reg_field(FEAT_REG_HORIZONTALACCU, &hor_start, &hor_end)=
;
> -	dss_feat_get_reg_field(FEAT_REG_VERTICALACCU, &vert_start, &vert_end)=
;
> +	haccu_field =3D &dispc.feat->reg_fields->hori_accu;
> +	vaccu_field =3D &dispc.feat->reg_fields->vert_accu;
> =20
> -	val =3D FLD_VAL(vaccu, vert_start, vert_end) |
> -			FLD_VAL(haccu, hor_start, hor_end);
> +	val =3D FLD_VAL(vaccu, vaccu_field->start, vaccu_field->end) |
> +		FLD_VAL(haccu, haccu_field->start, haccu_field->end);
> =20
>  	dispc_write_reg(DISPC_OVL_ACCU1(plane), val);
>  }
> @@ -4048,6 +4059,46 @@ static void _omap_dispc_initial_config(void)
>  	dispc_ovl_enable_zorder_planes();
>  }
> =20
> +static struct dispc_reg_fields omap2_dispc_reg_fields =3D {
> +	.firhinc		=3D	{ 11,  0 },
> +	.firvinc		=3D	{ 27, 16 },
> +	.fifo_low_thresh	=3D	{  8,  0 },
> +	.fifo_high_thresh	=3D	{ 24, 16 },
> +	.fifosize		=3D	{  8,  0 },
> +	.hori_accu		=3D	{  9,  0 },
> +	.vert_accu		=3D	{ 25, 16 },
> +};

And these tables can be consts.

> +static struct dispc_reg_fields omap3_dispc_reg_fields =3D {
> +	.firhinc		=3D	{ 12,  0 },
> +	.firvinc		=3D	{ 28, 16 },
> +	.fifo_low_thresh	=3D	{ 11,  0 },
> +	.fifo_high_thresh	=3D	{ 27, 16 },
> +	.fifosize		=3D	{ 10,  0 },
> +	.hori_accu		=3D	{  9,  0 },
> +	.vert_accu		=3D	{ 25, 16 },
> +};
> +
> +static struct dispc_reg_fields omap4_dispc_reg_fields =3D {
> +	.firhinc		=3D	{ 12,  0 },
> +	.firvinc		=3D	{ 28, 16 },
> +	.fifo_low_thresh	=3D	{ 15,  0 },
> +	.fifo_high_thresh	=3D	{ 31, 16 },
> +	.fifosize		=3D	{ 15,  0 },
> +	.hori_accu		=3D	{ 10,  0 },
> +	.vert_accu		=3D	{ 26, 16 },
> +};
> +
> +static struct dispc_reg_fields omap5_dispc_reg_fields =3D {
> +	.firhinc		=3D	{ 12,  0 },
> +	.firvinc		=3D	{ 28, 16 },
> +	.fifo_low_thresh	=3D	{ 15,  0 },
> +	.fifo_high_thresh	=3D	{ 31, 16 },
> +	.fifosize		=3D	{ 15,  0 },
> +	.hori_accu		=3D	{ 10,  0 },
> +	.vert_accu		=3D	{ 26, 16 },
> +};
> +
>  static const struct dispc_features omap24xx_dispc_feats __initconst =3D=
 {
>  	.sw_start		=3D	5,
>  	.fp_start		=3D	15,
> @@ -4065,6 +4116,7 @@ static const struct dispc_features omap24xx_dispc=
_feats __initconst =3D {
>  	.no_framedone_tv	=3D	true,
>  	.buffer_size_unit	=3D	1,
>  	.burst_size_unit	=3D	8,
> +	.reg_fields		=3D	&omap2_dispc_reg_fields,
>  };
> =20
>  static const struct dispc_features omap34xx_rev1_0_dispc_feats __initc=
onst =3D {
> @@ -4084,6 +4136,7 @@ static const struct dispc_features omap34xx_rev1_=
0_dispc_feats __initconst =3D {
>  	.no_framedone_tv	=3D	true,
>  	.buffer_size_unit	=3D	1,
>  	.burst_size_unit	=3D	8,
> +	.reg_fields		=3D	&omap3_dispc_reg_fields,
>  };
> =20
>  static const struct dispc_features omap34xx_rev3_0_dispc_feats __initc=
onst =3D {
> @@ -4103,6 +4156,7 @@ static const struct dispc_features omap34xx_rev3_=
0_dispc_feats __initconst =3D {
>  	.no_framedone_tv	=3D	true,
>  	.buffer_size_unit	=3D	1,
>  	.burst_size_unit	=3D	8,
> +	.reg_fields		=3D	&omap3_dispc_reg_fields,
>  };
> =20
>  static const struct dispc_features omap44xx_dispc_feats __initconst =3D=
 {
> @@ -4122,6 +4176,7 @@ static const struct dispc_features omap44xx_dispc=
_feats __initconst =3D {
>  	.gfx_fifo_workaround	=3D	true,
>  	.buffer_size_unit	=3D	16,
>  	.burst_size_unit	=3D	16,
> +	.reg_fields		=3D	&omap4_dispc_reg_fields,
>  };
> =20
>  static const struct dispc_features omap54xx_dispc_feats __initconst =3D=
 {
> @@ -4141,6 +4196,7 @@ static const struct dispc_features omap54xx_dispc=
_feats __initconst =3D {
>  	.gfx_fifo_workaround	=3D	true,
>  	.buffer_size_unit	=3D	16,
>  	.burst_size_unit	=3D	16,
> +	.reg_fields		=3D	&omap5_dispc_reg_fields,
>  };

There's one thing to note here (and the same applies to DSI patches).
The *_dispc_feats tables above are __initconst, and we make a copy of
the needed table at probe time, so that the unneeded tables can be
discarded. Now you add new tables, but they are not handled the same
way. This is not a bug, but it's a bit inconsistent.

So I think we have three options:

- Make the new tables also __initconst, and create a copy of the needed
tables, and fix up the pointers to point to the copied tables.

- Embed the new tables into the *_dispc_feats table, as you suggested
previously. This would mean multiple copies of the same data in some case=
s.

- Remove the __initconst and the copy code.

I'm not sure which one to pick. The first one feels a bit complex, but
perhaps it should be tried first to see how the actual code would look
like. If it's just a few lines per table, I guess it's ok.

 Tomi



--------------enigAA6FE91363F8C790DC5B2B19
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQzxICAAoJEPo9qoy8lh71UugP+gJQexbrvBaLOtB6FJ/Nv0Vv
b7w3Kq3UQ4md5Zt6vcknv/2m3u14eWp//HIgZBmh9FqRK4ZME5tTTqYXCza8Q+4e
4s8qI2UxQf8R//qKVHg2NXYAj1tYPpbvpEdYD0/50TQCwlhgIpQpxhyB0nl71m/R
M9+GblrYZrow4ZyIZZ9ptslANBrKjGCUQwf6F2cYbblZ/oknx1WCPDt0gaQYy6nF
qd1w6+scopyDDvaIgqpzBoJOQlgYELkIn7c5TcDqNLlPN1vvYC1sFDC2QFpFL1JN
ENqfe5jfGVSx4rViHd8flBnf8TY/BHcZotmKcvOfMP3X8FVqkiAZ7M4f5UGEt0J9
sh6F0w8Y559LN/OmsEhPlguyRaAYRYyKhDEoi/gVe77Hi8RJZrYAD5YoapzTgjd5
PUibMJ3ANOvGXeRwuX4fTT2PURs+U5TuNt6Yg+W1kjB82bHhP2L3O+9h3qc87bSR
Blu4zkQIss9DyahDk5a9lXuM475v1UDIrOPWuTXInboMmwDA9Uhw6nrzcpAYP5We
jYhNyVRTxibvObNeSjhTjTr10/6uGvWHMaOKnv8GlOHL+irFHkKNPL92TDgqICHF
3n09iTwPAP9bc1+9oFeR1lGfHd8JgSeg7vnVcNBznxFTG2cxgU0U48/S8UCVhYNz
kqw754QeQjIZray4ADyX
=9g9C
-----END PGP SIGNATURE-----

--------------enigAA6FE91363F8C790DC5B2B19--
