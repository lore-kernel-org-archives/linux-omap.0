From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/2] OMAPDSS: DISPC: Update Fir Coefficients
Date: Thu, 15 Dec 2011 10:55:31 +0200
Message-ID: <1323939331.2010.27.camel@deskari>
References: <1323838310-4439-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-tHWVpD68yUk1UX2Eac0E"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:44361 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751353Ab1LOIzh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Dec 2011 03:55:37 -0500
In-Reply-To: <1323838310-4439-1-git-send-email-cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-tHWVpD68yUk1UX2Eac0E
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2011-12-14 at 10:21 +0530, Chandrabhanu Mahapatra wrote:

> +const struct dispc_coef *dispc_ovl_get_scale_coef(int inc, int five_taps=
)
> +{
> +	int i;
> +	static const struct {
> +		int Mmin;
> +		int Mmax;
> +		const struct dispc_coef *coef_3;
> +		const struct dispc_coef *coef_5;
> +	} coefs[] =3D {
> +		{ 26, 32, coef3_M32, coef5_M32 },
> +		{ 22, 26, coef3_M26, coef5_M26 },
> +		{ 19, 22, coef3_M22, coef5_M22 },
> +		{ 16, 19, coef3_M19, coef5_M19 },
> +		{ 14, 16, coef3_M16, coef5_M16 },
> +		{ 13, 14, coef3_M14, coef5_M14 },
> +		{ 12, 13, coef3_M13, coef5_M13 },
> +		{ 11, 12, coef3_M12, coef5_M12 },
> +		{ 10, 11, coef3_M11, coef5_M11 },
> +		{  9, 10, coef3_M10, coef5_M10 },
> +		{  8,  9,  coef3_M9,  coef5_M9 },
> +		{  3,  8,  coef3_M8,  coef5_M8 },
> +		/*
> +		 * When upscaling more than two times, blockiness and outlines
> +		 * around the image are observed when M8 tables are used. M11,
> +		 * M16 and M19 tables are used to prevent this.
> +		 */
> +		{  2,  3, coef3_M11, coef5_M11 },
> +		{  1,  2, coef3_M16, coef5_M16 },
> +	};
> +
> +	inc /=3D 128;
> +	for (i =3D 0; i < ARRAY_LEN(coefs); ++i)
> +		if (inc > coefs[i].Mmin && inc <=3D coefs[i].Mmax)
> +			return five_taps ? coefs[i].coef_5 : coefs[i].coef_3;
> +	if (inc =3D=3D 1)
> +		return five_taps ? coef3_M19 : coef5_M19;
> +	return NULL;
> +}

Why don't you handle the inc =3D=3D 1 case the same as others? Just have an
entry in the table for Mmin=3D0, Mmax =3D 1.

Also, I think it's a bit confusing that Mmin is exclusive and Mmax is
inclusive in the comparison. It makes the table a bit hard to read, when
looking at which entry is used for which inc. I'd recommend using
inclusive comparison for both.

 Tomi


--=-tHWVpD68yUk1UX2Eac0E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJO6bYDAAoJEPo9qoy8lh71L3AQAJjx3pxMpSZyPZ0/zWbBlcTx
Xc0rRNeNHkg5YLzAkBaoK4ikJHsE7VRQHqnbJI1/esTiyWzbx8q+dufLVahlt+XQ
ABKVni4hoUYueWU0WH24Ioeq56HTM96GuSIYNjr/gVZVzo9Tz7Lw9KouSpCU8nB2
pY/jqO/foOTAjpYGFcfmShmg8StypOy0pyoCoozAXMGQtic6jT88KYP13grSzYaZ
GtAdZtJtpDjZLGEtgmgY0bsdiyahoaFqcFLxcidJt8awwzWyx97jD2DLLjPCHYD1
/46YkRhFZ7u82le451Wgpg3pJqYbsA1S+LzyP4ZKQ0l6J+nYcxKkHUIrgeHFks/m
GUuPybmaxCK+xOc1mX4ljtyPgAlYbjgAEWp69KecabjVHA4wl9O0JyWdRzQBZdO6
UwEg2isabY21ae/5oygqLRWpyjxF/SMMXT9vQexXfVpVVpVSDc0M9PFJ/Z0woT+T
fW8Sx8MpU5uaueDC3w6DjdjRXrOOXux3rX1MsHGRDwFuq2IqyLsblOpsBBIhxVMD
aekLBeBKU/1PppppYmy332QBU/aSmk3ooL0iwgD3bVdfa/VvrG8ZLW9QJ9RZjkbu
FBXs3HEEThlLJwBufAxgLiuWvcTczfxg2DvtG/vXsFwiyFAtgKijIHTasGSUj+a6
rO7cJrdlrheFLLMelxsp
=JKJe
-----END PGP SIGNATURE-----

--=-tHWVpD68yUk1UX2Eac0E--

