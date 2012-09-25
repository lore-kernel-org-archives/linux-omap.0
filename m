From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: Cleanup DSSDBG with dynamic pr_debug function
Date: Tue, 25 Sep 2012 09:24:51 +0300
Message-ID: <1348554291.2342.8.camel@deskari>
References: <1348552998-6596-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-e0ORYw3PFZgJrxufwiJI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:41147 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751565Ab2IYGZA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 02:25:00 -0400
Received: by lbbgj3 with SMTP id gj3so7844439lbb.19
        for <linux-omap@vger.kernel.org>; Mon, 24 Sep 2012 23:24:57 -0700 (PDT)
In-Reply-To: <1348552998-6596-1-git-send-email-cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-e0ORYw3PFZgJrxufwiJI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-09-25 at 11:33 +0530, Chandrabhanu Mahapatra wrote:
> The printk in DSSDBG function definition is replaced with dynamic debug e=
nabled
> pr_debug(). The use of dynamic debugging provides more flexiblity as each=
 debug
> statement can be enabled or disabled dynamically on basis of source filen=
ame,
> line number, module name etc. by writing to a control file in debugfs
> filesystem. For better undertsanding please refer to
> Documentation/dynamic-debug-howto.txt.
>=20
> The DSSDBGF() differs from DSSDBG() by providing function name. However,
> function name, line number, module name and thread ID can be printed thro=
ugh
> dynamic debug by setting appropiate flags 'f','l','m' and 't' in the debu=
gfs
> control file. So, DSSDBGF instances are replaced with DSSDBG.

Typos with: flexiblity, undertsanding, appropiate.

> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
> ---
>  drivers/video/omap2/dss/apply.c |    8 ++++----
>  drivers/video/omap2/dss/dsi.c   |   12 ++++--------
>  drivers/video/omap2/dss/dss.h   |   34 ++++++++-------------------------=
-
>  3 files changed, 16 insertions(+), 38 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/ap=
ply.c
> index 6354bb8..cb86d94 100644
> --- a/drivers/video/omap2/dss/apply.c
> +++ b/drivers/video/omap2/dss/apply.c
> @@ -559,7 +559,7 @@ static void dss_ovl_write_regs(struct omap_overlay *o=
vl)
>  	struct mgr_priv_data *mp;
>  	int r;
> =20
> -	DSSDBGF("%d", ovl->id);
> +	DSSDBG("%d", ovl->id);

I don't think this is good. It's true that dyn-debug can print the
function name, but that's optional. The debug message should be somehow
sensible independently, but in this case only a number is printed which
is totally meaningless.

Either the messages should be modified to give a hint what's going on,
or the DSSDBGF could be kept for now. In the above case the debug
message could be something like "writing ovl %d regs".

However, I think it'd be easier just to keep the DSSDBGF for now, and
remove it gradually.

>  	if (!op->enabled || !op->info_dirty)
>  		return;
> @@ -594,7 +594,7 @@ static void dss_ovl_write_regs_extra(struct omap_over=
lay *ovl)
>  	struct ovl_priv_data *op =3D get_ovl_priv(ovl);
>  	struct mgr_priv_data *mp;
> =20
> -	DSSDBGF("%d", ovl->id);
> +	DSSDBG("%d", ovl->id);
> =20
>  	if (!op->extra_info_dirty)
>  		return;
> @@ -618,7 +618,7 @@ static void dss_mgr_write_regs(struct omap_overlay_ma=
nager *mgr)
>  	struct mgr_priv_data *mp =3D get_mgr_priv(mgr);
>  	struct omap_overlay *ovl;
> =20
> -	DSSDBGF("%d", mgr->id);
> +	DSSDBG("%d", mgr->id);
> =20
>  	if (!mp->enabled)
>  		return;
> @@ -644,7 +644,7 @@ static void dss_mgr_write_regs_extra(struct omap_over=
lay_manager *mgr)
>  {
>  	struct mgr_priv_data *mp =3D get_mgr_priv(mgr);
> =20
> -	DSSDBGF("%d", mgr->id);
> +	DSSDBG("%d", mgr->id);
> =20
>  	if (!mp->extra_info_dirty)
>  		return;
> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.=
c
> index 8d815e3..8304cc6b 100644
> --- a/drivers/video/omap2/dss/dsi.c
> +++ b/drivers/video/omap2/dss/dsi.c
> @@ -1525,8 +1525,6 @@ int dsi_pll_set_clock_div(struct platform_device *d=
sidev,
>  	u8 regn_start, regn_end, regm_start, regm_end;
>  	u8 regm_dispc_start, regm_dispc_end, regm_dsi_start, regm_dsi_end;
> =20
> -	DSSDBGF();
> -
>  	dsi->current_cinfo.clkin =3D cinfo->clkin;
>  	dsi->current_cinfo.fint =3D cinfo->fint;
>  	dsi->current_cinfo.clkin4ddr =3D cinfo->clkin4ddr;
> @@ -2334,8 +2332,6 @@ static int dsi_cio_init(struct omap_dss_device *dss=
dev)
>  	int r;
>  	u32 l;
> =20
> -	DSSDBGF();
> -
>  	r =3D dss_dsi_enable_pads(dsi->module_id, dsi_get_lane_mask(dssdev));
>  	if (r)
>  		return r;
> @@ -2686,7 +2682,7 @@ static void dsi_vc_initial_config(struct platform_d=
evice *dsidev, int channel)
>  {
>  	u32 r;
> =20
> -	DSSDBGF("%d", channel);
> +	DSSDBG("%d", channel);
> =20
>  	r =3D dsi_read_reg(dsidev, DSI_VC_CTRL(channel));
> =20
> @@ -2718,7 +2714,7 @@ static int dsi_vc_config_source(struct platform_dev=
ice *dsidev, int channel,
>  	if (dsi->vc[channel].source =3D=3D source)
>  		return 0;
> =20
> -	DSSDBGF("%d", channel);
> +	DSSDBG("%d", channel);
> =20
>  	dsi_sync_vc(dsidev, channel);
> =20
> @@ -3475,7 +3471,7 @@ static int dsi_enter_ulps(struct platform_device *d=
sidev)
>  	int r, i;
>  	unsigned mask;
> =20
> -	DSSDBGF();
> +	DSSDBG("");

This debug message is even less meaningful than the overlay number =3D).
Again, I think either keep the DSSDBGF, or print something sensible,
like "entering ULPS".

> =20
>  	WARN_ON(!dsi_bus_is_locked(dsidev));
> =20
> @@ -4184,7 +4180,7 @@ int omapdss_dsi_set_clocks(struct omap_dss_device *=
dssdev,
>  	unsigned long pck;
>  	int r;
> =20
> -	DSSDBGF("ddr_clk %lu, lp_clk %lu", ddr_clk, lp_clk);
> +	DSSDBG("ddr_clk %lu, lp_clk %lu", ddr_clk, lp_clk);
> =20
>  	mutex_lock(&dsi->lock);
> =20
> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.=
h
> index 5e9fd769..3a2caab 100644
> --- a/drivers/video/omap2/dss/dss.h
> +++ b/drivers/video/omap2/dss/dss.h
> @@ -29,38 +29,20 @@
> =20
>  #ifdef DEBUG
>  extern bool dss_debug;

You still left the dss_debug option here, even if it's not used by the
DSSDBG anymore. What's your plan about this?

 Tomi


--=-e0ORYw3PFZgJrxufwiJI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQYU4zAAoJEPo9qoy8lh716nwP/1wdGKnhg7KlvA/BlVlYndTf
rjLa7uId0W35Za0u0UwfHuoJnACuC/JiMInSt0XN2uybN/s0EIAIHC+4E72GVZgc
UHhRLf42TUlAQxJujPTsPA5RMuwi7Dscwz3Rh3Kae0D9CEDcm83i7dLV9Ueh9bie
38b+XN8FRFuC9h+ku3RkKn8nq2CjY/sntTIHzPPLgvXQ64iCYOAL12Q/mYLkagRs
QjFmObqQv/BPa+Ml5pIzEWTQivBrZiQ84SFtJ+7H7ycleMnFsAE53mkxvor95MXj
SiVzdlvvHleL4nec+q49Q+OeHVMGopKIUk6PDXg2bKYvuowezhSd1MKrBjUo9+Nk
HgvhL76FHwBStwwz7oC/3sK9zGny8KzLB24ufoI3xJfRLVOj1qSfau3/ATKxnxFR
Vx5SO48923QXQmuWjRJTRsXYQdMdmbIsf+4UUF7Te9uVJoSH3StQhw0s81TN7to9
hNYNUczDt4snasfaCpwsFTfhdgTusRXJ+6qXVNCkWLZPXjexL3EC+P3xyyUh14LJ
7+WtexANihke5mqNk/tUPI8ro2XwD5MdXiiTa7qB69Lbf5MEyU9hfzJYuY+0HB06
d3GEYpDY4O9aIGX0QPPar7VylMUWacGrg4SF9/UI+YTtebmkBONJTGV23zENI70C
d0YeMLYzO26ErocSon6t
=Pl4S
-----END PGP SIGNATURE-----

--=-e0ORYw3PFZgJrxufwiJI--

