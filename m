From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 3/6] OMAPDSS: DSS: Remove cpu_is_xxxx checks
Date: Tue, 7 Aug 2012 11:49:48 +0300
Message-ID: <20120807084947.GL8468@arwen.pp.htv.fi>
References: <cover.1343912532.git.cmahapatra@ti.com>
 <19a46cc15dc7add0671dd8c32f5398249c0420ab.1343912533.git.cmahapatra@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RNGrj7vazCqBHNw7"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:52099 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750973Ab2HGIxZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 04:53:25 -0400
Received: by lahd3 with SMTP id d3so907147lah.28
        for <linux-omap@vger.kernel.org>; Tue, 07 Aug 2012 01:53:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <19a46cc15dc7add0671dd8c32f5398249c0420ab.1343912533.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--RNGrj7vazCqBHNw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 07, 2012 at 01:58:04PM +0530, Chandrabhanu Mahapatra wrote:
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
> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
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
> =20
>  void dss_dump_clocks(struct seq_file *s)
>  {
> @@ -254,23 +265,15 @@ void dss_dump_clocks(struct seq_file *s)
>  	fclk_rate =3D clk_get_rate(dss.dss_clk);
> =20
>  	if (dss.dpll4_m4_ck) {
> +		char *str =3D dss.ops->set_str();
> +
>  		dpll4_ck_rate =3D clk_get_rate(clk_get_parent(dss.dpll4_m4_ck));
>  		dpll4_m4_ck_rate =3D clk_get_rate(dss.dpll4_m4_ck);
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
> +		seq_printf(s, str, fclk_name, fclk_real_name, dpll4_ck_rate,
> +				dpll4_ck_rate / dpll4_m4_ck_rate, fclk_rate);
>  	} else {
>  		seq_printf(s, "%s (%s) =3D %lu\n",
>  				fclk_name, fclk_real_name,
> @@ -461,6 +464,35 @@ unsigned long dss_get_dpll4_rate(void)
>  		return 0;
>  }
> =20
> +u16 get_dss_fck_div_max_24_34(void)
> +{
> +	return 16;
> +}
> +
> +u16 get_dss_fck_div_max(void)
> +{
> +	return 32;
> +}
> +
> +bool set_dss_clock_info_34xx(void)
> +{
> +	unsigned long prate =3D dss_get_dpll4_rate();
> +	unsigned long fck =3D clk_get_rate(dss.dss_clk);
> +
> +	if (prate =3D=3D dss.cache_prate || dss.cache_dss_cinfo.fck =3D=3D fck)
> +		return true;
> +	return false;
> +}
> +
> +bool set_dss_clock_info(void)
> +{
> +	unsigned long fck =3D clk_get_rate(dss.dss_clk);
> +
> +	if (dss.cache_dss_cinfo.fck =3D=3D fck)
> +		return true;
> +	return false;
> +}
> +
>  int dss_calc_clock_div(unsigned long req_pck, struct dss_clock_info *dss=
_cinfo,
>  		struct dispc_clock_info *dispc_cinfo)
>  {
> @@ -470,7 +502,7 @@ int dss_calc_clock_div(unsigned long req_pck, struct =
dss_clock_info *dss_cinfo,
> =20
>  	unsigned long fck, max_dss_fck;
> =20
> -	u16 fck_div, fck_div_max =3D 16;
> +	u16 fck_div, fck_div_max;
> =20
>  	int match =3D 0;
>  	int min_fck_per_pck;
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
> @@ -519,8 +548,7 @@ retry:
> =20
>  		goto found;
>  	} else {
> -		if (cpu_is_omap3630() || cpu_is_omap44xx())
> -			fck_div_max =3D 32;
> +		fck_div_max =3D dss.ops->get_fck_div_max();
> =20
>  		for (fck_div =3D fck_div_max; fck_div > 0; --fck_div) {
>  			struct dispc_clock_info cur_dispc;
> @@ -619,6 +647,32 @@ enum dss_hdmi_venc_clk_source_select dss_get_hdmi_ve=
nc_clk_source(void)
>  	return REG_GET(DSS_CONTROL, 15, 15);
>  }
> =20
> +int dss_get_clk_24xx(struct clk *clk)
> +{
> +	clk =3D NULL;
> +	return true;
> +}
> +
> +int dss_get_clk_3xxx(struct clk *clk)
> +{
> +	clk =3D clk_get(NULL, "dpll4_m4_ck");
> +	if (IS_ERR(clk)) {
> +		DSSERR("Failed to get dpll4_m4_ck\n");
> +		return PTR_ERR(clk);
> +	}
> +	return true;
> +}
> +
> +int dss_get_clk_44xx(struct clk *clk)
> +{
> +	clk =3D clk_get(NULL, "dpll_per_m5x2_ck");
> +	if (IS_ERR(clk)) {
> +		DSSERR("Failed to get dpll_per_m5x2_ck\n");
> +		return PTR_ERR(clk);
> +	}
> +	return true;
> +}
> +
>  static int dss_get_clocks(void)
>  {
>  	struct clk *clk;
> @@ -633,23 +687,9 @@ static int dss_get_clocks(void)
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
> -	}
> +	r =3D dss.ops->get_clk(clk);
> +	if (r !=3D true)
> +		goto err;
> =20
>  	dss.dpll4_m4_ck =3D clk;
> =20
> @@ -750,6 +790,8 @@ static int __init omap_dsshw_probe(struct platform_de=
vice *pdev)
>  	dss.lcd_clk_source[0] =3D OMAP_DSS_CLK_SRC_FCK;
>  	dss.lcd_clk_source[1] =3D OMAP_DSS_CLK_SRC_FCK;
> =20
> +	dss_init_ops(dss.ops);
> +
>  	rev =3D dss_read_reg(DSS_REVISION);
>  	printk(KERN_INFO "OMAP DSS rev %d.%d\n",
>  			FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
> index 5773c86..b756ae1 100644
> --- a/drivers/video/omap2/dss/dss.h
> +++ b/drivers/video/omap2/dss/dss.h
> @@ -19,7 +19,6 @@
>   * You should have received a copy of the GNU General Public License alo=
ng with
>   * this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
> -
>  #ifndef __OMAP2_DSS_H
>  #define __OMAP2_DSS_H
> =20
> @@ -186,6 +185,15 @@ struct dispc_ops {
>  			int hbp, int vsw, int vfp, int vbp);
>  };
> =20
> +struct clk;
> +
> +struct dss_ops {
> +	u16 (*get_fck_div_max) (void);
> +	bool (*set_dss_cinfo) (void);
> +	int (*get_clk) (struct clk *clk);
> +	char *(*set_str) (void);
> +};
> +
>  struct seq_file;
>  struct platform_device;
> =20
> @@ -315,6 +323,19 @@ int dss_set_clock_div(struct dss_clock_info *cinfo);
>  int dss_calc_clock_div(unsigned long req_pck, struct dss_clock_info *dss=
_cinfo,
>  		struct dispc_clock_info *dispc_cinfo);
> =20
> +u16 get_dss_fck_div_max_24_34(void);
> +u16 get_dss_fck_div_max(void);
> +
> +bool set_dss_clock_info(void);
> +bool set_dss_clock_info_34xx(void);
> +
> +int dss_get_clk_24xx(struct clk *clk);
> +int dss_get_clk_3xxx(struct clk *clk);
> +int dss_get_clk_44xx(struct clk *clk);
> +
> +char *set_dump_clk_str_24_34(void);
> +char *set_dump_clk_str(void);
> +
>  /* SDI */
>  int sdi_init_platform_driver(void) __init;
>  void sdi_uninit_platform_driver(void) __exit;
> diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2=
/dss/dss_features.c
> index b8d5095..6b35200 100644
> --- a/drivers/video/omap2/dss/dss_features.c
> +++ b/drivers/video/omap2/dss/dss_features.c
> @@ -609,6 +609,46 @@ void dispc_init_ops(const struct dispc_ops *ops)
>  	}
>  }
> =20
> +static const struct dss_ops omap2_dss_ops =3D {
> +	.get_fck_div_max	=3D	get_dss_fck_div_max_24_34,
> +	.set_dss_cinfo		=3D	set_dss_clock_info,
> +	.get_clk		=3D	dss_get_clk_24xx,
> +	.set_str		=3D	set_dump_clk_str_24_34,
> +};
> +
> +static const struct dss_ops omap34_dss_ops =3D {
> +	.get_fck_div_max	=3D	get_dss_fck_div_max_24_34,
> +	.set_dss_cinfo		=3D	set_dss_clock_info_34xx,
> +	.get_clk		=3D	dss_get_clk_3xxx,
> +	.set_str		=3D	set_dump_clk_str_24_34,
> +};
> +
> +static const struct dss_ops omap36_dss_ops =3D {
> +	.get_fck_div_max	=3D	get_dss_fck_div_max,
> +	.set_dss_cinfo		=3D	set_dss_clock_info,
> +	.get_clk		=3D	dss_get_clk_3xxx,
> +	.set_str		=3D	set_dump_clk_str,
> +};
> +
> +static const struct dss_ops omap4_dss_ops =3D {
> +	.get_fck_div_max	=3D	get_dss_fck_div_max,
> +	.set_dss_cinfo		=3D	set_dss_clock_info,
> +	.get_clk		=3D	dss_get_clk_44xx,
> +	.set_str		=3D	set_dump_clk_str,
> +};
> +
> +void dss_init_ops(const struct dss_ops *ops)
> +{
> +	if (cpu_is_omap24xx())
> +		ops =3D &omap2_dss_ops;
> +	else if (cpu_is_omap34xx())
> +		ops =3D &omap34_dss_ops;
> +	else if (cpu_is_omap3630())
> +		ops =3D &omap36_dss_ops;
> +	else
> +		ops =3D &omap4_dss_ops;
> +}

same comment as previous patch. Just moving the checks somewhere else
and creating even more indirection through function pointers, when you
could just do the runtime DSS IP revision check.

--=20
balbi

--RNGrj7vazCqBHNw7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQINarAAoJEIaOsuA1yqREfRIQAK4vNT8gskE3kHwUzY2xZyP0
pD7SQM8asnT/MKb5FgRNM/GyxaERiKEn/i0bSEn4RHajdNwq3yCe/1zhH8eT3BpV
/U7rMxtTE/iK5Lyu9ReytWlThgzoIOEiU+OML2o5qMki4v7+wCFjEtTwo8NX9h2I
YXBbjsHYosH8hMizmQctAaWx30ANYePd2ptdVsWodxQK/m9VVcQAMjV1Ng5tav1p
oGRwqWWmUQbNF/U95XXNVa9cdIaoIFk9LP06+SItt3vRUfSuE8NWfpp9LmxxVshf
Xy7LNVj9Qzzzuej+lvTxKZ55e7iGfC8iOyHnH29fxg0F/a4U2mq6YHdGz3htzsgh
9yfglI78J2rgZVYTH+OzgsqL02qQlIyG4U1c4bloSMTaApOrEuMRQpP6kiuxbxJT
b0Qbe1JF+WemRMDf6BoFtpzgg3XB/yMxuW4ApVBQb5W/LopTAL2uEKv6D2Zm2Sxl
krPTZG8+oDew1vVc7wt4AG52oBzmvoYqg1DLy64xorqsbPuFYFxQe4FgziCwcN5V
wZ1GMevKvNhrzk2XoNg+4WkpvaCWx0Z4O90/hjuUh5vNZrJTBKxgMYdi++4DdQ2o
lKX+Fan9u8HXLNw01Kr/R3efRuvvwqNdtTHLe7+wVKcuESg6mIHDn0hBQwx7kxCc
5kG2kzpoDpRGaZSRbVfp
=seK8
-----END PGP SIGNATURE-----

--RNGrj7vazCqBHNw7--
