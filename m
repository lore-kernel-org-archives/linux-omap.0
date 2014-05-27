From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 01/11] ARM: AM43xx: hwmod: add DSS hwmod data
Date: Tue, 27 May 2014 09:29:56 +0300
Message-ID: <538430E4.8030900@ti.com>
References: <1399636579-8062-1-git-send-email-tomi.valkeinen@ti.com> <1399636579-8062-2-git-send-email-tomi.valkeinen@ti.com> <5379CDD2.6080807@ti.com> <5379D8F5.9030008@ti.com> <5379DCCE.3050400@ti.com> <5379E6B1.5000409@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="QSLPAiL1LiNtsaee8WptemjOWPd5QHIFK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41440 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881AbaE0Gaa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 May 2014 02:30:30 -0400
In-Reply-To: <5379E6B1.5000409@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Archit Taneja <archit@ti.com>, Sathya Prakash M R <sathyap@ti.com>

--QSLPAiL1LiNtsaee8WptemjOWPd5QHIFK
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On 19/05/14 14:10, Tomi Valkeinen wrote:
> On 19/05/14 13:28, Rajendra Nayak wrote:
>=20
>> Yeah, thats what it looks like to me. l3_gclk is the 200Mhz clock deri=
ved from=20
>> core-m4 post divider and l3s_gclk/l4ls_gclk are half of that at 100Mhz=
, derived
>> using a fixed divider of 2.
>=20
> Here's an updated patch, with the sdma entry removed and the ocp clock
> changed to l3_gclk.

Can we get this to 3.16?

 Tomi

> From bfaf0fafb21c698c86640764c1aa62d6fc73992a Mon Sep 17 00:00:00 2001
> From: Sathya Prakash M R <sathyap@ti.com>
> Date: Mon, 24 Mar 2014 16:31:53 +0530
> Subject: [PATCH] ARM: AM43xx: hwmod: add DSS hwmod data
>=20
> Add DSS hwmod data for AM43xx.
>=20
> Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 98 ++++++++++++++++++++++=
++++++++
>  arch/arm/mach-omap2/prcm43xx.h             |  1 +
>  2 files changed, 99 insertions(+)
>=20
> diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_43xx_data.c
> index 5c2cc8083fdd..d2a7b6dc36f2 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
> @@ -19,6 +19,8 @@
>  #include "omap_hwmod.h"
>  #include "omap_hwmod_33xx_43xx_common_data.h"
>  #include "prcm43xx.h"
> +#include "omap_hwmod_common_data.h"
> +
> =20
>  /* IP blocks */
>  static struct omap_hwmod am43xx_l4_hs_hwmod =3D {
> @@ -415,6 +417,70 @@ static struct omap_hwmod am43xx_qspi_hwmod =3D {
>  	},
>  };
> =20
> +/* Display sub system - DSS */
> +
> +struct omap_dss_dispc_dev_attr am43xx_dss_dispc_dev_attr =3D {
> +	.manager_count		=3D 1,
> +	.has_framedonetv_irq	=3D 0
> +};
> +
> +
> +static struct omap_hwmod_class_sysconfig am43xx_dispc_sysc =3D {
> +	.rev_offs	=3D 0x0000,
> +	.sysc_offs	=3D 0x0010,
> +	.syss_offs	=3D 0x0014,
> +	.sysc_flags	=3D (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE),
> +	.idlemodes	=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> +	.sysc_fields	=3D &omap_hwmod_sysc_type1,
> +};
> +
> +static struct omap_hwmod_class am43xx_dispc_hwmod_class =3D {
> +	.name	=3D "dispc",
> +	.sysc	=3D &am43xx_dispc_sysc,
> +};
> +
> +static struct omap_hwmod am43xx_dss_core_hwmod =3D {
> +	.name		=3D "dss_core",
> +	.class		=3D &omap2_dss_hwmod_class,
> +	.clkdm_name	=3D "dss_clkdm",
> +	.main_clk	=3D "disp_clk",
> +	.prcm =3D {
> +		.omap4 =3D {
> +			.clkctrl_offs =3D AM43XX_CM_PER_DSS_CLKCTRL_OFFSET,
> +			.modulemode   =3D MODULEMODE_SWCTRL,
> +		},
> +	},
> +};
> +
> +/* display controller -dispc*/
> +
> +static struct omap_hwmod am43xx_dss_dispc_hwmod =3D {
> +	.name		=3D "dss_dispc",
> +	.class		=3D &am43xx_dispc_hwmod_class,
> +	.clkdm_name	=3D "dss_clkdm",
> +	.main_clk	=3D "disp_clk",
> +	.prcm =3D {
> +		.omap4 =3D {
> +			.clkctrl_offs =3D AM43XX_CM_PER_DSS_CLKCTRL_OFFSET,
> +		},
> +	},
> +	.dev_attr	=3D &am43xx_dss_dispc_dev_attr,
> +};
> +
> +/*RFBI*/
> +
> +static struct omap_hwmod am43xx_dss_rfbi_hwmod =3D {
> +	.name		=3D "dss_rfbi",
> +	.class		=3D &omap2_rfbi_hwmod_class,
> +	.clkdm_name	=3D "dss_clkdm",
> +	.main_clk	=3D "disp_clk",
> +	.prcm =3D {
> +		.omap4 =3D {
> +			.clkctrl_offs =3D AM43XX_CM_PER_DSS_CLKCTRL_OFFSET,
> +		},
> +	},
> +};
> +
>  /* Interfaces */
>  static struct omap_hwmod_ocp_if am43xx_l3_main__l4_hs =3D {
>  	.master		=3D &am33xx_l3_main_hwmod,
> @@ -654,6 +720,34 @@ static struct omap_hwmod_ocp_if am43xx_l3_s__qspi =
=3D {
>  	.user           =3D OCP_USER_MPU | OCP_USER_SDMA,
>  };
> =20
> +static struct omap_hwmod_ocp_if am43xx_dss__l3_main =3D {
> +	.master		=3D &am43xx_dss_core_hwmod,
> +	.slave		=3D &am33xx_l3_main_hwmod,
> +	.clk		=3D "l3_gclk",
> +	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +static struct omap_hwmod_ocp_if am43xx_l4_ls__dss =3D {
> +	.master		=3D &am33xx_l4_ls_hwmod,
> +	.slave		=3D &am43xx_dss_core_hwmod,
> +	.clk		=3D "l4ls_gclk",
> +	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +static struct omap_hwmod_ocp_if am43xx_l4_ls__dss_dispc =3D {
> +	.master		=3D &am33xx_l4_ls_hwmod,
> +	.slave		=3D &am43xx_dss_dispc_hwmod,
> +	.clk		=3D "l4ls_gclk",
> +	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +static struct omap_hwmod_ocp_if am43xx_l4_ls__dss_rfbi =3D {
> +	.master		=3D &am33xx_l4_ls_hwmod,
> +	.slave		=3D &am43xx_dss_rfbi_hwmod,
> +	.clk		=3D "l4ls_gclk",
> +	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
>  static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata =3D=
 {
>  	&am33xx_l4_wkup__synctimer,
>  	&am43xx_l4_ls__timer8,
> @@ -748,6 +842,10 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_=
ifs[] __initdata =3D {
>  	&am43xx_l4_ls__ocp2scp1,
>  	&am43xx_l3_s__usbotgss0,
>  	&am43xx_l3_s__usbotgss1,
> +	&am43xx_dss__l3_main,
> +	&am43xx_l4_ls__dss,
> +	&am43xx_l4_ls__dss_dispc,
> +	&am43xx_l4_ls__dss_rfbi,
>  	NULL,
>  };
> =20
> diff --git a/arch/arm/mach-omap2/prcm43xx.h b/arch/arm/mach-omap2/prcm4=
3xx.h
> index 7785be984edd..ad7b3e9977f8 100644
> --- a/arch/arm/mach-omap2/prcm43xx.h
> +++ b/arch/arm/mach-omap2/prcm43xx.h
> @@ -142,5 +142,6 @@
>  #define AM43XX_CM_PER_USBPHYOCP2SCP0_CLKCTRL_OFFSET	0x05B8
>  #define AM43XX_CM_PER_USB_OTG_SS1_CLKCTRL_OFFSET        0x0268
>  #define AM43XX_CM_PER_USBPHYOCP2SCP1_CLKCTRL_OFFSET	0x05C0
> +#define AM43XX_CM_PER_DSS_CLKCTRL_OFFSET		0x0a20
> =20
>  #endif
>=20



--QSLPAiL1LiNtsaee8WptemjOWPd5QHIFK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJThDDkAAoJEPo9qoy8lh716vwP/2QiUJzkFSCA1JdjlMpq6BRu
ymqvVhB37mJXkt+Tq8yFGc0m1Ohix2x2gyH+J+nfIYeejaDMb6W8S7jC2gz9kvbM
6hxnaZtdM6FyUz3iQ35kKvg9JXVBnSQbB9vk+ZsQvsIC3aGxLUllm3uojv9J4aKs
YfMG8GB7DHWmebN7uP8PVnJmhodpIPIDpFAvasy02dI9boFodnmF7SfuY5q8j/6G
vzQl03lTJidj68pvj0lRNwoPuF38m7IhFtahSygaIjFsntw3dSN05VnrR5idx6KF
yQa22cwmGIRb2yBTv/M1n5b9MTSbExy1mRvw/xkBobqurWeWT0mKjTX+MGddr5iP
OYD3IK6zaWHYjZIlAJ97pv2K9d8xVAhAXj3sRR0sQ3obsJ7Lpgh2GXvVcLbolH6L
IrkOE0LxSivf3dQTZrb9+6Rm2hHGv/AS0NAjOq2AJt4r2pSh4pH6ONbITnxwnodj
5UI/yEPjPMTGiqqmt75Iv7aDnRbeCPqqDx1DIsNwdWo0d0Nx8uvRS8KCjbgwp9rs
ZIauwlIzhAzt6QKw0APzjCbMVhg8XeApS/ngcYL3Zpg1WY7ifDa+1CDczYlIzMa1
TXowx2a92HHwRZxr2FwtEU3vi6sduxq93q3tif0mYX0uxzL2y13eIPpsm+kogZr/
Cel03nGl6/ZYhJLKtK/o
=uyav
-----END PGP SIGNATURE-----

--QSLPAiL1LiNtsaee8WptemjOWPd5QHIFK--
