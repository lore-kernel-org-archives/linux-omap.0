From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/6] OMAPDSS: DSS: Remove cpu_is_xxxx checks
Date: Tue, 07 Aug 2012 16:14:21 +0300
Message-ID: <1344345261.7216.64.camel@lappyti>
References: <cover.1343912532.git.cmahapatra@ti.com>
	 <19a46cc15dc7add0671dd8c32f5398249c0420ab.1343912533.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-ay1L9GS0DbG7vYSCMEhz"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:37532 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753661Ab2HGNOo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 09:14:44 -0400
Received: by lboi15 with SMTP id i15so794930lbo.7
        for <linux-omap@vger.kernel.org>; Tue, 07 Aug 2012 06:14:24 -0700 (PDT)
In-Reply-To: <19a46cc15dc7add0671dd8c32f5398249c0420ab.1343912533.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-ay1L9GS0DbG7vYSCMEhz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-08-07 at 13:58 +0530, Chandrabhanu Mahapatra wrote:
> The cpu_is checks have been removed from dss.c providing it a much generi=
c and
> cleaner interface. The OMAP version and revision specific functions are
> initialized by dss_ops structure in dss features.
>=20
> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
> ---
>  drivers/video/omap2/dss/dss.c          |  114 ++++++++++++++++++++++----=
------
>  drivers/video/omap2/dss/dss.h          |   23 ++++++-
>  drivers/video/omap2/dss/dss_features.c |   40 +++++++++++
>  drivers/video/omap2/dss/dss_features.h |    1 +
>  4 files changed, 141 insertions(+), 37 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.=
c
> index 7b1c6ac..c263da7 100644
> --- a/drivers/video/omap2/dss/dss.c
> +++ b/drivers/video/omap2/dss/dss.c
> @@ -83,6 +83,8 @@ static struct {
> =20
>  	bool		ctx_valid;
>  	u32		ctx[DSS_SZ_REGS / sizeof(u32)];
> +
> +	const struct dss_ops *ops;
>  } dss;
> =20
>  static const char * const dss_generic_clk_source_names[] =3D {
> @@ -236,6 +238,15 @@ const char *dss_get_generic_clk_source_name(enum oma=
p_dss_clk_source clk_src)
>  	return dss_generic_clk_source_names[clk_src];
>  }
> =20
> +char *set_dump_clk_str_24_34(void)
> +{
> +	return "%s (%s) =3D %lu / %lu * 2  =3D %lu\n";
> +}
> +
> +char *set_dump_clk_str(void)
> +{
> +	return "%s (%s) =3D %lu / %lu  =3D %lu\n";
> +}

You don't need functions for these, or for the max fck div. Just add the
string or the number to the struct.

And I don't really like the format string being separately. It would
probably be better if you instead had just a flag for the x2 multiplier,
and the dump function would check the flag to see which format string it
uses.

> @@ -479,10 +511,7 @@ int dss_calc_clock_div(unsigned long req_pck, struct=
 dss_clock_info *dss_cinfo,
> =20
>  	max_dss_fck =3D dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
> =20
> -	fck =3D clk_get_rate(dss.dss_clk);
> -	if (req_pck =3D=3D dss.cache_req_pck &&
> -			((cpu_is_omap34xx() && prate =3D=3D dss.cache_prate) ||
> -			 dss.cache_dss_cinfo.fck =3D=3D fck)) {
> +	if (req_pck =3D=3D dss.cache_req_pck && dss.ops->set_dss_cinfo()) {
>  		DSSDBG("dispc clock info found from cache.\n");
>  		*dss_cinfo =3D dss.cache_dss_cinfo;
>  		*dispc_cinfo =3D dss.cache_dispc_cinfo;

This is quite confusing. "set" function should set something, normally
something that is given as a parameter. Your function seems to be
checking some values.

 Tomi


--=-ay1L9GS0DbG7vYSCMEhz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQIRStAAoJEPo9qoy8lh71LrkP/j8sOZGimgZfnEw0f58sQxC4
HsPhh77NwWq56D8GH75+CmnSMA+ntdKJXOAdEIctQPhnAfPuQ9CMOL/Y7CQaxKF7
oTU316/fH71gumnB0ZL8VMl42oKFQ5sPLeGf4Dt4OSnF9F5lpOIvt4OdnGQtNR08
nmq8niwz+EV/xAFMXviHavFmGHYywQ1NTH7YRobEtovky3DnEg0XFxIKXvGuU4u5
7qtYKVpeI1jdMywiZNlLRI1jurJvkrtRpkJxipkXrAT/Nqw3QYHATHHlfwZwEoNO
TNVPqDzUr31zElOBT4fFiB2u04y9cakhaWMl+9wKyDeVnSX0bbalp7YKJ0UbEj2/
1wQlZ5vG6RKZpZhKohsrAJYxAeMHNs31SD8W6AXkW9HincDDaeViLYmLQKAzDnuh
YYEvlo0G/zPFI518EmybYtWP24zv+rDq0YLH4iaUIBj42bE80y7b9JHQgEd/EQ9B
1sR6jUDhy5rDvL9kaYlhpqZeE0StJkV92xSeYrVQwUa9lCMH2sEVGB//c3APdNF9
jzXYfmGPgjgVlxu3zd4a5AGGl+XxxeJzKGVY+9LrGDFSokLKowGD8y1ZkZWiVRUa
83YKKh+78Mr9NzCodi1ndyYkekyGN34VMY9WP5vlGQ9c3dyUvNrW9GuAgKTdFp+c
AK4pm1elw4vXxKHhtRL6
=/ZTX
-----END PGP SIGNATURE-----

--=-ay1L9GS0DbG7vYSCMEhz--

