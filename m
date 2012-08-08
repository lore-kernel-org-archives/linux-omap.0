From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/6] OMAPDSS: DSS: Cleanup cpu_is_xxxx checks
Date: Wed, 08 Aug 2012 16:16:12 +0300
Message-ID: <1344431772.4932.89.camel@deskari>
References: <19a46cc15dc7add0671dd8c32f5398249c0420ab.1343912533.git.cmahapatra@ti.com>
	 <1344425899-28267-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-PF5IdLTmDDH7TdWVvSZx"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:53923 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758142Ab2HHNQi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 09:16:38 -0400
Received: by lbon10 with SMTP id n10so427901lbo.11
        for <linux-omap@vger.kernel.org>; Wed, 08 Aug 2012 06:16:15 -0700 (PDT)
In-Reply-To: <1344425899-28267-1-git-send-email-cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-PF5IdLTmDDH7TdWVvSZx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-08-08 at 17:08 +0530, Chandrabhanu Mahapatra wrote:
> All the cpu_is checks have been moved to dss_init_features function provi=
ding a
> much more generic and cleaner interface. The OMAP version and revision sp=
ecific
> functions are initialized by dss_features structure local to dss.c.

Most of the comments for the dispc patch apply also to this patch.

> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
> ---
>  drivers/video/omap2/dss/dss.c |  154 ++++++++++++++++++++++++++++++-----=
------
>  1 file changed, 114 insertions(+), 40 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.=
c
> index 7b1c6ac..f5971ac 100644
> --- a/drivers/video/omap2/dss/dss.c
> +++ b/drivers/video/omap2/dss/dss.c
> @@ -65,6 +65,20 @@ struct dss_reg {
>  static int dss_runtime_get(void);
>  static void dss_runtime_put(void);
> =20
> +static bool check_dss_cinfo_fck(void);
> +static bool check_dss_cinfo_fck_34xx(void);
> +
> +static int dss_get_clk_24xx(struct clk *clk);
> +static int dss_get_clk_3xxx(struct clk *clk);
> +static int dss_get_clk_44xx(struct clk *clk);
> +
> +struct dss_features {
> +	u16 fck_div_max;
> +	int factor;
> +	bool (*check_cinfo_fck) (void);
> +	int (*get_clk) (struct clk *clk);
> +};
> +
>  static struct {
>  	struct platform_device *pdev;
>  	void __iomem    *base;
> @@ -83,6 +97,8 @@ static struct {
> =20
>  	bool		ctx_valid;
>  	u32		ctx[DSS_SZ_REGS / sizeof(u32)];
> +
> +	const struct dss_features *feat;
>  } dss;
> =20
>  static const char * const dss_generic_clk_source_names[] =3D {
> @@ -91,6 +107,34 @@ static const char * const dss_generic_clk_source_name=
s[] =3D {
>  	[OMAP_DSS_CLK_SRC_FCK]			=3D "DSS_FCK",
>  };
> =20
> +static const struct dss_features omap2_dss_features =3D {
> +	.fck_div_max		=3D	16,
> +	.factor			=3D	2,
> +	.check_cinfo_fck	=3D	check_dss_cinfo_fck,
> +	.get_clk		=3D	dss_get_clk_24xx,
> +};
> +
> +static const struct dss_features omap34_dss_features =3D {
> +	.fck_div_max		=3D	16,
> +	.factor			=3D	2,
> +	.check_cinfo_fck	=3D	check_dss_cinfo_fck_34xx,
> +	.get_clk		=3D	dss_get_clk_3xxx,
> +};
> +
> +static const struct dss_features omap36_dss_features =3D {
> +	.fck_div_max		=3D	32,
> +	.factor			=3D	1,
> +	.check_cinfo_fck	=3D	check_dss_cinfo_fck,
> +	.get_clk		=3D	dss_get_clk_3xxx,
> +};
> +
> +static const struct dss_features omap4_dss_features =3D {
> +	.fck_div_max		=3D	32,
> +	.factor			=3D	1,
> +	.check_cinfo_fck	=3D	check_dss_cinfo_fck,
> +	.get_clk		=3D	dss_get_clk_44xx,
> +};
> +
>  static inline void dss_write_reg(const struct dss_reg idx, u32 val)
>  {
>  	__raw_writel(val, dss.base + idx.idx);
> @@ -236,7 +280,6 @@ const char *dss_get_generic_clk_source_name(enum omap=
_dss_clk_source clk_src)
>  	return dss_generic_clk_source_names[clk_src];
>  }
> =20
> -
>  void dss_dump_clocks(struct seq_file *s)
>  {
>  	unsigned long dpll4_ck_rate;
> @@ -259,18 +302,10 @@ void dss_dump_clocks(struct seq_file *s)
> =20
>  		seq_printf(s, "dpll4_ck %lu\n", dpll4_ck_rate);
> =20
> -		if (cpu_is_omap3630() || cpu_is_omap44xx())
> -			seq_printf(s, "%s (%s) =3D %lu / %lu  =3D %lu\n",
> -					fclk_name, fclk_real_name,
> -					dpll4_ck_rate,
> -					dpll4_ck_rate / dpll4_m4_ck_rate,
> -					fclk_rate);
> -		else
> -			seq_printf(s, "%s (%s) =3D %lu / %lu * 2 =3D %lu\n",
> -					fclk_name, fclk_real_name,
> -					dpll4_ck_rate,
> -					dpll4_ck_rate / dpll4_m4_ck_rate,
> -					fclk_rate);
> +		seq_printf(s, "%s (%s) =3D %lu / %lu * %d  =3D %lu\n",
> +				fclk_name, fclk_real_name, dpll4_ck_rate,
> +				dpll4_ck_rate / dpll4_m4_ck_rate,
> +				dss.feat->factor, fclk_rate);
>  	} else {
>  		seq_printf(s, "%s (%s) =3D %lu\n",
>  				fclk_name, fclk_real_name,
> @@ -461,6 +496,25 @@ unsigned long dss_get_dpll4_rate(void)
>  		return 0;
>  }
> =20
> +static bool check_dss_cinfo_fck_34xx(void)
> +{
> +	unsigned long prate =3D dss_get_dpll4_rate();
> +	unsigned long fck =3D clk_get_rate(dss.dss_clk);
> +
> +	if (prate =3D=3D dss.cache_prate || dss.cache_dss_cinfo.fck =3D=3D fck)
> +		return true;
> +	return false;
> +}
> +
> +static bool check_dss_cinfo_fck(void)
> +{
> +	unsigned long fck =3D clk_get_rate(dss.dss_clk);
> +
> +	if (dss.cache_dss_cinfo.fck =3D=3D fck)
> +		return true;
> +	return false;

Often code like this is cleaner written as:

	return dss.cache_dss_cinfo.fck =3D=3D fck;

> +}
> +
>  int dss_calc_clock_div(unsigned long req_pck, struct dss_clock_info *dss=
_cinfo,
>  		struct dispc_clock_info *dispc_cinfo)
>  {
> @@ -470,7 +524,7 @@ int dss_calc_clock_div(unsigned long req_pck, struct =
dss_clock_info *dss_cinfo,
> =20
>  	unsigned long fck, max_dss_fck;
> =20
> -	u16 fck_div, fck_div_max =3D 16;
> +	u16 fck_div;
> =20
>  	int match =3D 0;
>  	int min_fck_per_pck;
> @@ -479,10 +533,7 @@ int dss_calc_clock_div(unsigned long req_pck, struct=
 dss_clock_info *dss_cinfo,
> =20
>  	max_dss_fck =3D dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
> =20
> -	fck =3D clk_get_rate(dss.dss_clk);
> -	if (req_pck =3D=3D dss.cache_req_pck &&
> -			((cpu_is_omap34xx() && prate =3D=3D dss.cache_prate) ||
> -			 dss.cache_dss_cinfo.fck =3D=3D fck)) {
> +	if (req_pck =3D=3D dss.cache_req_pck && dss.feat->check_cinfo_fck()) {

This change, and the check_cinfo_fck() doesn't look correct. I mean,
looking at the code, I think it does the same thing as the old code, but
the line above does look very confusing =3D). Okay, the original code also
looks confusing.

I don't think the original code is even correct. I think it should
include omap4 also in the prate check... And why does it have || instead
of &&? Shouldn't we check both the prate _and_ the fck, instead of just
either one of those... Who writes this stuff without any clarifying
comments! (I think I wrote the code)

If I'm not mistaken, the whole cpu check could be just discarded. On
OMAP2, where prate does not exist/matter, prate should be always 0. If
it's always 0 in the dss.cache_prate also, we can compare them without
any cpu checks.

Can you verify this, and if I'm right, just get rid of the cpu check
there, and we don't even need the feat thing here.

>  		DSSDBG("dispc clock info found from cache.\n");
>  		*dss_cinfo =3D dss.cache_dss_cinfo;
>  		*dispc_cinfo =3D dss.cache_dispc_cinfo;
> @@ -519,13 +570,10 @@ retry:
> =20
>  		goto found;
>  	} else {
> -		if (cpu_is_omap3630() || cpu_is_omap44xx())
> -			fck_div_max =3D 32;
> -
> -		for (fck_div =3D fck_div_max; fck_div > 0; --fck_div) {
> +		for (fck_div =3D dss.feat->fck_div_max; fck_div > 0; --fck_div) {
>  			struct dispc_clock_info cur_dispc;
> =20
> -			if (fck_div_max =3D=3D 32)
> +			if (dss.feat->fck_div_max =3D=3D 32)
>  				fck =3D prate / fck_div;
>  			else
>  				fck =3D prate / fck_div * 2;

Hmm, I think this one should use the "factor" field for the multiply.

> @@ -619,6 +667,32 @@ enum dss_hdmi_venc_clk_source_select dss_get_hdmi_ve=
nc_clk_source(void)
>  	return REG_GET(DSS_CONTROL, 15, 15);
>  }
> =20
> +static int dss_get_clk_24xx(struct clk *clk)
> +{
> +	clk =3D NULL;
> +	return true;
> +}
> +
> +static int dss_get_clk_3xxx(struct clk *clk)
> +{
> +	clk =3D clk_get(NULL, "dpll4_m4_ck");
> +	if (IS_ERR(clk)) {
> +		DSSERR("Failed to get dpll4_m4_ck\n");
> +		return PTR_ERR(clk);
> +	}
> +	return true;
> +}
> +
> +static int dss_get_clk_44xx(struct clk *clk)
> +{
> +	clk =3D clk_get(NULL, "dpll_per_m5x2_ck");
> +	if (IS_ERR(clk)) {
> +		DSSERR("Failed to get dpll_per_m5x2_ck\n");
> +		return PTR_ERR(clk);
> +	}
> +	return true;
> +}

These are almost the same functions. Rather than having separate
functions, perhaps add the clock name into the feat struct. And NULL for
omap2.

The clock name shouldn't really even be in dss, it should come as
parameter, or even better, we wouldn't need it an we could use the clk
framework without this clock. But that was not possible the last time I
looked at it, so let's have it in dss feat struct for now.=20

 Tomi


--=-PF5IdLTmDDH7TdWVvSZx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQImacAAoJEPo9qoy8lh71NrQP/RyNHn27OAzFNuQiWy36zJDN
9Rgqcg02JiN4Bx1UL2IWBrGhjKz6mZ7ItdTJTqdDTqlCAxLYgZ2IGuq/trcs+TVh
b5ZPbjZhx40CSeIK9Sasr4YDwNXJXqAUVCpVy3pE9ezThOZhuv/WI0SvLKJPDuxl
OGUpWDpWs5QK13HmTP+lwrvwzVHXaZw0i0LyTHDOevS7zZoW3S+6Uq9Wz66MgTpl
7rbENG1npSjiqI8kZMRuGSjKVyPbw/27Hgb0T2VRpdoR1Tbpn+s7KdpVBQWxjfmg
vJ2lilI10kI3H6N/vELn7HKeVHYKx0AJOSmFAUQaa2H9U3wsSu5ebFZYqgXhjH9T
Bv175Ee1qPbmD/XKCclLC1qc3NkZh6Izjdz8INBNbgYIWlaw1emfSTt0DZQfXbi5
tfOCctkCakAz22aKJRO/S9pvi4GXGYlBuNR6TCgjHyNH5HIoSC/3eXkQE1sq/Z/H
5DgOjxttz7I4Y0xxcGrKrznipk/5oK3mkZtiUVqY5THghjxm2UvtPdLwE8IK/W09
Xdm79BMD7+7008SnTTWgQJ8V3Vz0ob1FvyOKKpH8F077dfA72Oc8UlfLBOS8bApW
M/YX7kbz6kLQyWBn9TxOoTzE0YYclNd89zrrGHXwEngvk+44blgpovIHRKk73FMA
AdFt41XP+Oq13wC0NjcG
=bqlK
-----END PGP SIGNATURE-----

--=-PF5IdLTmDDH7TdWVvSZx--

