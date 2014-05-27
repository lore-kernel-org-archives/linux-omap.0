From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC v2 1/5] OMAPDSS: DSS: init dss ports cleanly
Date: Tue, 27 May 2014 11:24:41 +0300
Message-ID: <53844BC9.3060307@ti.com>
References: <1399540517-17883-1-git-send-email-archit@ti.com> <1401096492-1405-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="NOTud9qcQJP5OEJtAs2jQm1RuR9UEVD0s"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45830 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbaE0IYt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 May 2014 04:24:49 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id s4R8OnYj024036
	for <linux-omap@vger.kernel.org>; Tue, 27 May 2014 03:24:49 -0500
Received: from DLEE70.ent.ti.com (dlemailx.itg.ti.com [157.170.170.113])
	by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id s4R8OnCG023427
	for <linux-omap@vger.kernel.org>; Tue, 27 May 2014 03:24:49 -0500
In-Reply-To: <1401096492-1405-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org

--NOTud9qcQJP5OEJtAs2jQm1RuR9UEVD0s
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 26/05/14 12:28, Archit Taneja wrote:
> The init/uninit port functions are used to set up the DPI and SDI outpu=
ts under
> the dss platform device. A 'reg' property is used to determine whether =
the node
> is DPI or SDI for OMAP34xx DSS revision. For other DSS revisions, only =
DPI
> output exists.
>=20
> For multiple DPI output instances(introduced in DRA7xx DSS), we would u=
se the
> 'reg' property in dts to specify the DPI output instance.
>=20
> The current functions work fine if there is only one DPI output instanc=
e in
> DSS. For multiple DPI instances, it would get complicated to figure out=
 whether
> 'reg' is used to specify whether the output is SDI, or another DPI inst=
ance.
>=20
> We create a list of port types supported for each DSS rev, with the ind=
ex of the
> port in the list matching the reg id. This allows us to have a more gen=
eric way
> to init/uninit ports within DSS, and support multiple DPI ports.
>=20
> Also, make the uninit_port functions iterative since we will have multi=
ple DPI
> ports to uninit in the future.
>=20
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/video/fbdev/omap2/dss/dpi.c |  2 +-
>  drivers/video/fbdev/omap2/dss/dss.c | 84 +++++++++++++++++++++++++++++=
+-------
>  drivers/video/fbdev/omap2/dss/dss.h | 27 +++++++++++-
>  drivers/video/fbdev/omap2/dss/sdi.c |  2 +-
>  4 files changed, 97 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/omap2/dss/dpi.c b/drivers/video/fbdev/=
omap2/dss/dpi.c
> index 9368972..8593567 100644
> --- a/drivers/video/fbdev/omap2/dss/dpi.c
> +++ b/drivers/video/fbdev/omap2/dss/dpi.c
> @@ -769,7 +769,7 @@ err_datalines:
>  	return r;
>  }
> =20
> -void __exit dpi_uninit_port(void)
> +void __exit dpi_uninit_port(struct device_node *port)
>  {
>  	if (!dpi.port_initialized)
>  		return;
> diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/=
omap2/dss/dss.c
> index 6daeb7e..54a84f4 100644
> --- a/drivers/video/fbdev/omap2/dss/dss.c
> +++ b/drivers/video/fbdev/omap2/dss/dss.c
> @@ -70,6 +70,8 @@ struct dss_features {
>  	u8 fck_div_max;
>  	u8 dss_fck_multiplier;
>  	const char *parent_clk_name;
> +	enum omap_display_type *ports;
> +	int num_ports;
>  	int (*dpi_select_source)(enum omap_channel channel);
>  };
> =20
> @@ -689,6 +691,22 @@ void dss_debug_dump_clocks(struct seq_file *s)
>  }
>  #endif
> =20
> +
> +static enum omap_display_type omap2plus_ports[] =3D {
> +#ifdef CONFIG_OMAP2_DSS_DPI
> +	OMAP_DISPLAY_TYPE_DPI,
> +#endif
> +};
> +
> +static enum omap_display_type omap34xx_ports[] =3D {
> +#ifdef CONFIG_OMAP2_DSS_DPI
> +	OMAP_DISPLAY_TYPE_DPI,
> +#endif
> +#ifdef CONFIG_OMAP2_DSS_DSI
> +	OMAP_DISPLAY_TYPE_SDI,
> +#endif
> +};

If you do this, then if you disable DPI from kernel config, the port
indexes change. The above should reflect the hardware, not which drivers
the user has enabled in the kernel.

Also, you used DSI above, not SDI.

>  static const struct dss_features omap24xx_dss_feats __initconst =3D {
>  	/*
>  	 * fck div max is really 16, but the divider range has gaps. The rang=
e
> @@ -698,6 +716,8 @@ static const struct dss_features omap24xx_dss_feats=
 __initconst =3D {
>  	.dss_fck_multiplier	=3D	2,
>  	.parent_clk_name	=3D	"core_ck",
>  	.dpi_select_source	=3D	&dss_dpi_select_source_omap2_omap3,
> +	.ports			=3D	omap2plus_ports,
> +	.num_ports		=3D	ARRAY_SIZE(omap2plus_ports),
>  };
> =20
>  static const struct dss_features omap34xx_dss_feats __initconst =3D {
> @@ -705,6 +725,8 @@ static const struct dss_features omap34xx_dss_feats=
 __initconst =3D {
>  	.dss_fck_multiplier	=3D	2,
>  	.parent_clk_name	=3D	"dpll4_ck",
>  	.dpi_select_source	=3D	&dss_dpi_select_source_omap2_omap3,
> +	.ports			=3D	omap34xx_ports,
> +	.num_ports		=3D	ARRAY_SIZE(omap34xx_ports),
>  };
> =20
>  static const struct dss_features omap3630_dss_feats __initconst =3D {
> @@ -712,6 +734,8 @@ static const struct dss_features omap3630_dss_feats=
 __initconst =3D {
>  	.dss_fck_multiplier	=3D	1,
>  	.parent_clk_name	=3D	"dpll4_ck",
>  	.dpi_select_source	=3D	&dss_dpi_select_source_omap2_omap3,
> +	.ports			=3D	omap2plus_ports,
> +	.num_ports		=3D	ARRAY_SIZE(omap2plus_ports),
>  };
> =20
>  static const struct dss_features omap44xx_dss_feats __initconst =3D {
> @@ -719,6 +743,8 @@ static const struct dss_features omap44xx_dss_feats=
 __initconst =3D {
>  	.dss_fck_multiplier	=3D	1,
>  	.parent_clk_name	=3D	"dpll_per_x2_ck",
>  	.dpi_select_source	=3D	&dss_dpi_select_source_omap4,
> +	.ports			=3D	omap2plus_ports,
> +	.num_ports		=3D	ARRAY_SIZE(omap2plus_ports),
>  };
> =20
>  static const struct dss_features omap54xx_dss_feats __initconst =3D {
> @@ -726,6 +752,8 @@ static const struct dss_features omap54xx_dss_feats=
 __initconst =3D {
>  	.dss_fck_multiplier	=3D	1,
>  	.parent_clk_name	=3D	"dpll_per_x2_ck",
>  	.dpi_select_source	=3D	&dss_dpi_select_source_omap5,
> +	.ports			=3D	omap2plus_ports,
> +	.num_ports		=3D	ARRAY_SIZE(omap2plus_ports),
>  };
> =20
>  static const struct dss_features am43xx_dss_feats __initconst =3D {
> @@ -733,6 +761,8 @@ static const struct dss_features am43xx_dss_feats _=
_initconst =3D {
>  	.dss_fck_multiplier	=3D	0,
>  	.parent_clk_name	=3D	NULL,
>  	.dpi_select_source	=3D	&dss_dpi_select_source_omap2_omap3,
> +	.ports			=3D	omap2plus_ports,
> +	.num_ports		=3D	ARRAY_SIZE(omap2plus_ports),
>  };
> =20
>  static int __init dss_init_features(struct platform_device *pdev)
> @@ -798,6 +828,9 @@ static int __init dss_init_ports(struct platform_de=
vice *pdev)
>  	if (!port)
>  		return 0;
> =20
> +	if (dss.feat->num_ports =3D=3D 0)
> +		return 0;
> +
>  	do {
>  		u32 reg;
> =20
> @@ -805,30 +838,53 @@ static int __init dss_init_ports(struct platform_=
device *pdev)
>  		if (r)
>  			reg =3D 0;
> =20
> -#ifdef CONFIG_OMAP2_DSS_DPI
> -		if (reg =3D=3D 0)
> +		if (reg > dss.feat->num_ports - 1)
> +			continue;

Maybe matter of taste, but I like (reg >=3D dss.feat_num_ports) more.

> +
> +		if (dss.feat->ports[reg] =3D=3D OMAP_DISPLAY_TYPE_DPI)
>  			dpi_init_port(pdev, port);
> -#endif
> =20
> -#ifdef CONFIG_OMAP2_DSS_SDI
> -		if (reg =3D=3D 1)
> +		if (dss.feat->ports[reg] =3D=3D OMAP_DISPLAY_TYPE_SDI)
>  			sdi_init_port(pdev, port);
> -#endif

Maybe the above could be something like this in pseudo code:

port_type =3D dss.feat->ports[reg];

switch (port_type) {
case OMAP_DISPLAY_TYPE_DPI:
	dpi_init_port(pdev, port);
	break;
=2E..
}

 Tomi



--NOTud9qcQJP5OEJtAs2jQm1RuR9UEVD0s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJThEvOAAoJEPo9qoy8lh71lrAP/3spM5435yVLYV8KZzDCVjYL
asJHCiIf4JCQk3wBfqB3QxQuH3H6TKRIYvFW6kjfvIXT+LWsTS4bj8yHttk5EW3T
1fj9p65G6sTTVQk1E9DH+oT/ufB9FSFvhdSfzMTwz6o5ULfcnarzsF4PCzAysBhV
pESV/x/SBT7hqSjL1mpPTP/qUOnZzvx7hQs+hPLQKVMbiQFzfdu7z54+NqokSE8W
7woiiB+D5S+ZjGQ1H2FUJpBn1B55C2PBcTvU1NrN3qnYIACQBIbIRzrgDEuOKVMW
ZCb8lQSaUBnIUzZT/Aa5bHVWesckwAlATMQaWioefdTbwGQMH1MeyeMyAskJ8YMr
UKxzQHlt3DpQP3pZN6DponsXsKSBdtEPcaSaByv/oS3CYSwFkHImAvbFYJQXiHQC
6Fp+5vBNEmO7E9WezztHeg31AAOlKqdCMPb3hBAlpXJm2AD+CUTBuFAea5CrrlMa
GYDxPzF9nV+qRhK11fMv2hjOKGyPXQt58wlTRhKbU0Zm/vEsnN8KyMXK81Jl1keC
gGiMTesIbF3sZSqnGxC6xa/nL21n/5ZdaEPHxQvLuEtiKc0XWAbXEJJR6K4d6+KD
sjSYR88v0XfiC5LFlAgZPy2AGMswl6MtW0B9kymb2vqMmBB0k/oiWILFApe0/d7F
fKUA//h4UYUlYEycIEFQ
=aSnu
-----END PGP SIGNATURE-----

--NOTud9qcQJP5OEJtAs2jQm1RuR9UEVD0s--
