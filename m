From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/6] OMAPDSS: DSS: Cleanup cpu_is_xxxx checks
Date: Tue, 14 Aug 2012 12:48:25 +0300
Message-ID: <1344937705.2345.17.camel@deskari>
References: <1344425899-28267-1-git-send-email-cmahapatra@ti.com>
	 <1344859176-4512-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-7hbJMxgILCX0yI1/hXUm"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:54195 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753519Ab2HNJsa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Aug 2012 05:48:30 -0400
Received: by lbol12 with SMTP id l12so169136lbo.30
        for <linux-omap@vger.kernel.org>; Tue, 14 Aug 2012 02:48:27 -0700 (PDT)
In-Reply-To: <1344859176-4512-1-git-send-email-cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-7hbJMxgILCX0yI1/hXUm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-08-13 at 17:29 +0530, Chandrabhanu Mahapatra wrote:
> All the cpu_is checks have been moved to dss_init_features function provi=
ding a
> much more generic and cleaner interface. The OMAP version and revision sp=
ecific
> initializations in various functions are cleaned and the necessary data a=
re
> moved to dss_features structure which is local to dss.c.

It'd be good to have some version information here. Even just [PATCH v3
3/6] in the subject is good, but of course the best is if there's a
short change log

> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
> ---
>  drivers/video/omap2/dss/dss.c |  115 ++++++++++++++++++++++++++---------=
------
>  1 file changed, 74 insertions(+), 41 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.=
c
> index 7b1c6ac..6ab236e 100644
> --- a/drivers/video/omap2/dss/dss.c
> +++ b/drivers/video/omap2/dss/dss.c
> @@ -31,6 +31,7 @@
>  #include <linux/clk.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/dma-mapping.h>

Hmm, what is this for?
=20
>  #include <video/omapdss.h>
> =20
> @@ -65,6 +66,13 @@ struct dss_reg {
>  static int dss_runtime_get(void);
>  static void dss_runtime_put(void);
> =20
> +struct dss_features {
> +	u16 fck_div_max;
> +	int factor;
> +	char *clk_name;
> +	bool (*check_cinfo_fck) (void);
> +};

Is the check_cinfo_fck a leftover from previous versions?

I think "factor" name is too vague. If I remember right, it's some kind
of implicit multiplier for the dss fck. So "dss_fck_multiplier"? You
could check the clock trees to verify what the multiplier exactly was,
and see if you can come up with a better name =3D).

> +
>  static struct {
>  	struct platform_device *pdev;
>  	void __iomem    *base;
> @@ -83,6 +91,8 @@ static struct {
> =20
>  	bool		ctx_valid;
>  	u32		ctx[DSS_SZ_REGS / sizeof(u32)];
> +
> +	const struct dss_features *feat;
>  } dss;
> =20
>  static const char * const dss_generic_clk_source_names[] =3D {
> @@ -91,6 +101,30 @@ static const char * const dss_generic_clk_source_name=
s[] =3D {
>  	[OMAP_DSS_CLK_SRC_FCK]			=3D "DSS_FCK",
>  };
> =20
> +static const struct __initdata dss_features omap2_dss_features =3D {
> +	.fck_div_max		=3D	16,
> +	.factor			=3D	2,
> +	.clk_name		=3D	NULL,
> +};

include/linux/init.h says says __initdata should be used like:

static int init_variable __initdata =3D 0;

And there actually seems to be __initconst also, which I think is the
correct one to use here. Didn't know about that =3D):

static const char linux_logo[] __initconst =3D { 0x32, 0x36, ... };

> +static const struct __initdata dss_features omap34_dss_features =3D {

Perhaps the names could be more consistent. "omap34" doesn't sound like
any omap we have ;). So maybe just omap2xxx, omap34xx, etc, the same way
we have in the cpu_is calls.

> +	.fck_div_max		=3D	16,
> +	.factor			=3D	2,
> +	.clk_name		=3D	"dpll4_m4_ck",
> +};
> +
> +static const struct __initdata dss_features omap36_dss_features =3D {
> +	.fck_div_max		=3D	32,
> +	.factor			=3D	1,
> +	.clk_name		=3D	"dpll4_m4_ck",
> +};
> +
> +static const struct __initdata dss_features omap4_dss_features =3D {
> +	.fck_div_max		=3D	32,
> +	.factor			=3D	1,
> +	.clk_name		=3D	"dpll_per_m5x2_ck",
> +};
> +
>  static inline void dss_write_reg(const struct dss_reg idx, u32 val)
>  {
>  	__raw_writel(val, dss.base + idx.idx);
> @@ -236,7 +270,6 @@ const char *dss_get_generic_clk_source_name(enum omap=
_dss_clk_source clk_src)
>  	return dss_generic_clk_source_names[clk_src];
>  }
> =20
> -
>  void dss_dump_clocks(struct seq_file *s)
>  {
>  	unsigned long dpll4_ck_rate;
> @@ -259,18 +292,10 @@ void dss_dump_clocks(struct seq_file *s)
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
> @@ -470,7 +495,7 @@ int dss_calc_clock_div(unsigned long req_pck, struct =
dss_clock_info *dss_cinfo,
> =20
>  	unsigned long fck, max_dss_fck;
> =20
> -	u16 fck_div, fck_div_max =3D 16;
> +	u16 fck_div;
> =20
>  	int match =3D 0;
>  	int min_fck_per_pck;
> @@ -480,9 +505,8 @@ int dss_calc_clock_div(unsigned long req_pck, struct =
dss_clock_info *dss_cinfo,
>  	max_dss_fck =3D dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
> =20
>  	fck =3D clk_get_rate(dss.dss_clk);
> -	if (req_pck =3D=3D dss.cache_req_pck &&
> -			((cpu_is_omap34xx() && prate =3D=3D dss.cache_prate) ||
> -			 dss.cache_dss_cinfo.fck =3D=3D fck)) {
> +	if (req_pck =3D=3D dss.cache_req_pck && prate =3D=3D dss.cache_prate &&
> +		dss.cache_dss_cinfo.fck =3D=3D fck) {
>  		DSSDBG("dispc clock info found from cache.\n");
>  		*dss_cinfo =3D dss.cache_dss_cinfo;
>  		*dispc_cinfo =3D dss.cache_dispc_cinfo;
> @@ -519,16 +543,10 @@ retry:
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
> -				fck =3D prate / fck_div;
> -			else
> -				fck =3D prate / fck_div * 2;
> +			fck =3D prate / fck_div * dss.feat->factor;
> =20
>  			if (fck > max_dss_fck)
>  				continue;
> @@ -633,22 +651,11 @@ static int dss_get_clocks(void)
> =20
>  	dss.dss_clk =3D clk;
> =20
> -	if (cpu_is_omap34xx()) {
> -		clk =3D clk_get(NULL, "dpll4_m4_ck");
> -		if (IS_ERR(clk)) {
> -			DSSERR("Failed to get dpll4_m4_ck\n");
> -			r =3D PTR_ERR(clk);
> -			goto err;
> -		}
> -	} else if (cpu_is_omap44xx()) {
> -		clk =3D clk_get(NULL, "dpll_per_m5x2_ck");
> -		if (IS_ERR(clk)) {
> -			DSSERR("Failed to get dpll_per_m5x2_ck\n");
> -			r =3D PTR_ERR(clk);
> -			goto err;
> -		}
> -	} else { /* omap24xx */
> -		clk =3D NULL;
> +	clk =3D clk_get(NULL, dss.feat->clk_name);
> +	if (IS_ERR(clk)) {
> +		DSSERR("Failed to get %s\n", dss.feat->clk_name);
> +		r =3D PTR_ERR(clk);
> +		goto err;
>  	}
> =20
>  	dss.dpll4_m4_ck =3D clk;
> @@ -704,6 +711,26 @@ void dss_debug_dump_clocks(struct seq_file *s)
>  }
>  #endif
> =20
> +static int __init dss_init_features(struct device *dev)
> +{
> +	dss.feat =3D devm_kzalloc(dev, sizeof(*dss.feat), GFP_KERNEL);
> +	if (!dss.feat) {
> +		dev_err(dev, "Failed to allocate local DSS Features\n");
> +		return -ENOMEM;
> +	}
> +
> +	if (cpu_is_omap24xx())
> +		dss.feat =3D &omap2_dss_features;
> +	else if (cpu_is_omap34xx())
> +		dss.feat =3D &omap34_dss_features;
> +	else if (cpu_is_omap3630())
> +		dss.feat =3D &omap36_dss_features;
> +	else
> +		dss.feat =3D &omap4_dss_features;

Check for omap4 also, and if the cpu is none of the above, return error.

> +
> +	return 0;
> +}
> +
>  /* DSS HW IP initialisation */
>  static int __init omap_dsshw_probe(struct platform_device *pdev)
>  {
> @@ -750,6 +777,10 @@ static int __init omap_dsshw_probe(struct platform_d=
evice *pdev)
>  	dss.lcd_clk_source[0] =3D OMAP_DSS_CLK_SRC_FCK;
>  	dss.lcd_clk_source[1] =3D OMAP_DSS_CLK_SRC_FCK;
> =20
> +	r =3D dss_init_features(&dss.pdev->dev);
> +	if (r)
> +		return r;
> +
>  	rev =3D dss_read_reg(DSS_REVISION);
>  	printk(KERN_INFO "OMAP DSS rev %d.%d\n",
>  			FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
> @@ -772,6 +803,8 @@ static int __exit omap_dsshw_remove(struct platform_d=
evice *pdev)
> =20
>  	dss_put_clocks();
> =20
> +	devm_kfree(&dss.pdev->dev, (void *)dss.feat);

You don't need to free the memory allocated with devm_kzalloc. The
framework will free it automatically on unload (that's the idea of
devm_* functions).

Otherwise looks good, cleans up nicely the cpu_is_* mess.

 Tomi


--=-7hbJMxgILCX0yI1/hXUm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQKh7pAAoJEPo9qoy8lh71AYYP/jR5YHzflHg5IjA/IMN0OG9Z
0z/W+RAt2TwolDWUNWEZn7xxVYKyE98XNGBB6+wWMXaf3D1bsokRgGGZ4TjDkChb
53ci3vpZwyB3WPQu8G2yOu0WCF9AWEsL1TIinTf8/dY10VzEs7PrrupACMGKbrC+
W+n6MZcs2YRRi3UT9xf/4i9cFdlLHrX4VGgoFAJHAzJgxXXPzjvT4m5SMvOJAZP2
2AeliNXd9LQmDqRJuiROclBWJObtxLBVrCOZ5HCZZP+tTYvGvLTcQYtOVR03xvt/
nFaina3t2sNNNc2GeQ4qNONXN33yj+UqSB52Bc3SPJ5xN2ss9YT55fhUHfuL6urd
8duw8fhrwhA/FQjpzeTRmsITrXiWNkUnPBgNxZqgQy4C6C9Xu3xBt/FBPrsfhyFJ
vRmcdJM0AsmhstqaAqxqjcV7xKy3YNSjJR2ytD8gjBSm4SjaeYU6y0l1BIJOoLS6
k3INXiHv4a93GcnqocYIMCG8krU6tS4xBf51ZOD8iX7n4q3BtdqEsflw1bykKZD6
ZjH+WVuP4dfoKiwa9b1jy+ZXqf5OsI0GFC57X9pa3M3+TH3ZiwgN5KiNKUNckK4L
CL9h8461gH03B5BZD5RMG0vEs9o3BBF3zPoF9d6XCG/ftzxVOJwJrHeRkThD6YRT
ZIpcfF6TUeGwqqud4B6n
=9/eX
-----END PGP SIGNATURE-----

--=-7hbJMxgILCX0yI1/hXUm--

