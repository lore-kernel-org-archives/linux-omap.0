From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: DISPC: Update Accumulator configuration for
 chroma plane
Date: Tue, 15 May 2012 15:51:32 +0300
Message-ID: <1337086292.23670.29.camel@deskari>
References: <1337069087-21121-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-t7AXWUFFpGACOQXpML3h"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:37520 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932620Ab2EOMvh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 May 2012 08:51:37 -0400
Received: by lahd3 with SMTP id d3so4101616lah.19
        for <linux-omap@vger.kernel.org>; Tue, 15 May 2012 05:51:35 -0700 (PDT)
In-Reply-To: <1337069087-21121-1-git-send-email-cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-t7AXWUFFpGACOQXpML3h
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-05-15 at 13:34 +0530, Chandrabhanu Mahapatra wrote:
> DISPC has two accumulator registers DISPC_VIDp_ACCU_0 and DISPC_VIDp_ACCU=
_1 each
> with horizontal and vertical bit fields. The bit fields can take values i=
n the
> range of -1024 to 1023. Based on bit field values DISPC decides on which =
one out
> of 8 phases the filtering starts. DISPC_VIDp_ACCU_0 is used for progressi=
ve
> output and for interlaced output both DISPC_VIDp_ACCU_0 and DISPC_VIDp_AC=
CU_1
> are used.
>=20
> The current accumulator values in DISPC scaling logic for chroma plane ta=
kes
> default values for all color modes and rotation types. So, the horizontal=
 and
> vertical up and downsampling accumulator bit field values have been updat=
ed for
> better performance.
>=20
> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>

> ---
> @@ -1249,6 +1335,9 @@ static void dispc_ovl_set_scaling_uv(enum omap_plan=
e plane,
>  	int scale_x =3D out_width !=3D orig_width;
>  	int scale_y =3D out_height !=3D orig_height;
> =20
> +	dispc_ovl_set_accu_uv(plane, orig_width, orig_height, out_width,
> +			out_height, ilace, color_mode, rotation);
> +
>  	if (!dss_has_feature(FEAT_HANDLE_UV_SEPARATE))
>  		return;
>  	if ((color_mode !=3D OMAP_DSS_COLOR_YUV2 &&

This crashes if color mode is not yuv or nv.

Should the set_accu_uv call be a bit later, after these lines:

	if (!dss_has_feature(FEAT_HANDLE_UV_SEPARATE))
		return;
	if ((color_mode !=3D OMAP_DSS_COLOR_YUV2 &&
			color_mode !=3D OMAP_DSS_COLOR_UYVY &&
			color_mode !=3D OMAP_DSS_COLOR_NV12)) {
		/* reset chroma resampling for RGB formats  */
		REG_FLD_MOD(DISPC_OVL_ATTRIBUTES2(plane), 0, 8, 8);
		return;
	}


 Tomi


--=-t7AXWUFFpGACOQXpML3h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPslFUAAoJEPo9qoy8lh71Td0P/jka+0rfWE/gxYO6TGUZZsXU
Q9wVFEGbqwarDhRfkcTGd0y8oIESqWyE/Ap7rHcBPBRPxBA7SjeVkZwg07SmeQNW
c3t5KyYG0zgJ+JoHpMIy6vzCx91OgJJebuhtHI/pud7JhSOjHg+IZ8TzoSUvXEsW
/h0koNVkiBNvqG2nwJv0pMEAZ5AXWC9aLEEzTdNnWwvqbs0MaQUza1PW0uKUCzdU
d8B0EbeKYihMbvjoL0eQ3nkg8VoTsh0GN/aa0WrUiv5cNdtZizm4GOfW+NNXnKDj
pJE+1nOdxEV0iYhE3aHtvtv0k8O8MtfsAnt4UPx93iXIkTmUjKCzMWHRu4KIG+fl
rXBHJ6AW73Hvqo9Ga+Bq7d06l3z+qglpALsRToxgJ4zqSmjKe4+NxGLk5La4S/hI
Fw0nohLb+bnGIIjtYFQFQiNvWoG9K8oskNfLVlNSKOAmfDdyAbBGSLOswYeWFIyc
Wxh7hV7DcI1oqs7ksFJUYNPxOHJbzXDONJDH5OE/uN8bZI9LMJiXXA3hKlvihyUV
3rudryy9oQ0HZMt6mxVuUSXdJFDcO1w6BFlN3AO2yt11IZnLKVHvyD+LcDfdifIj
WtIFRYx2DjCDUMRlgLirli9WsknWhfNNOjxiL11hQNa5j0XqllPt8MbVbjrzxFXo
JYeFmPtpolN2n38GKF+2
=QqPZ
-----END PGP SIGNATURE-----

--=-t7AXWUFFpGACOQXpML3h--

