From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/2] ARM: omap5: hwmod_data: Add AESS related data
Date: Fri, 9 May 2014 11:00:18 +0300
Message-ID: <536C8B12.9030007@ti.com>
References: <1398858208-1346-1-git-send-email-peter.ujfalusi@ti.com> <1398858208-1346-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41679 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbaEIIAq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 May 2014 04:00:46 -0400
In-Reply-To: <1398858208-1346-2-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, Paul Walmsley <paul@pwsan.com>

Paul,

On 04/30/2014 02:43 PM, Peter Ujfalusi wrote:
> Add the needed hwmod entries which is needed for AESS (Audio Engine
> SubSystem) and ABE.

please ignore this patch to add AESS to hwmod data. W/o addresses defin=
ed we
will see warnings printed. So either I add the addresses to hwmod data =
or need
to have aess also in DT.

--=20
P=E9ter

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 64 ++++++++++++++++++++=
++++++++++
>  1 file changed, 64 insertions(+)
>=20
> diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/ma=
ch-omap2/omap_hwmod_54xx_data.c
> index e829664e6a6c..3e20c025b5a4 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
> @@ -146,6 +146,7 @@ static struct omap_hwmod omap54xx_l4_abe_hwmod =3D=
 {
>  	.prcm =3D {
>  		.omap4 =3D {
>  			.clkctrl_offs =3D OMAP54XX_CM_ABE_L4_ABE_CLKCTRL_OFFSET,
> +			.context_offs =3D OMAP54XX_RM_ABE_AESS_CONTEXT_OFFSET,
>  			.flags =3D HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
>  		},
>  	},
> @@ -211,6 +212,42 @@ static struct omap_hwmod omap54xx_mpu_private_hw=
mod =3D {
>  };
> =20
>  /*
> + * 'aess' class
> + * audio engine sub system
> + */
> +
> +static struct omap_hwmod_class_sysconfig omap54xx_aess_sysc =3D {
> +	.rev_offs	=3D 0x0000,
> +	.sysc_offs	=3D 0x0010,
> +	.sysc_flags	=3D (SYSC_HAS_MIDLEMODE | SYSC_HAS_SIDLEMODE),
> +	.idlemodes	=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
> +			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART |
> +			   MSTANDBY_SMART_WKUP),
> +	.sysc_fields	=3D &omap_hwmod_sysc_type2,
> +};
> +
> +static struct omap_hwmod_class omap54xx_aess_hwmod_class =3D {
> +	.name	=3D "aess",
> +	.sysc	=3D &omap54xx_aess_sysc,
> +	.enable_preprogram =3D omap_hwmod_aess_preprogram,
> +};
> +
> +/* aess */
> +static struct omap_hwmod omap54xx_aess_hwmod =3D {
> +	.name		=3D "aess",
> +	.class		=3D &omap54xx_aess_hwmod_class,
> +	.clkdm_name	=3D "abe_clkdm",
> +	.main_clk	=3D "aess_fclk",
> +	.prcm =3D {
> +		.omap4 =3D {
> +			.clkctrl_offs =3D OMAP54XX_CM_ABE_AESS_CLKCTRL_OFFSET,
> +			.context_offs =3D OMAP54XX_RM_ABE_AESS_CONTEXT_OFFSET,
> +			.modulemode   =3D MODULEMODE_SWCTRL,
> +		},
> +	},
> +};
> +
> +/*
>   * 'counter' class
>   * 32-bit ordinary counter, clocked by the falling edge of the 32 kh=
z clock
>   */
> @@ -1892,6 +1929,14 @@ static struct omap_hwmod_ocp_if omap54xx_l4_cf=
g__l3_main_3 =3D {
>  	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
>  };
> =20
> +/* aess -> l4_abe */
> +static struct omap_hwmod_ocp_if __maybe_unused omap54xx_aess__l4_abe=
 =3D {
> +	.master		=3D &omap54xx_aess_hwmod,
> +	.slave		=3D &omap54xx_l4_abe_hwmod,
> +	.clk		=3D "abe_iclk",
> +	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
>  /* l3_main_1 -> l4_abe */
>  static struct omap_hwmod_ocp_if omap54xx_l3_main_1__l4_abe =3D {
>  	.master		=3D &omap54xx_l3_main_1_hwmod,
> @@ -1966,6 +2011,22 @@ static struct omap_hwmod_ocp_if omap54xx_l4_cf=
g__dma_system =3D {
>  	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
>  };
> =20
> +/* l4_abe -> aess */
> +static struct omap_hwmod_ocp_if __maybe_unused omap54xx_l4_abe__aess=
 =3D {
> +	.master		=3D &omap54xx_l4_abe_hwmod,
> +	.slave		=3D &omap54xx_aess_hwmod,
> +	.clk		=3D "abe_iclk",
> +	.user		=3D OCP_USER_MPU,
> +};
> +
> +/* l4_abe -> aess (dma) */
> +static struct omap_hwmod_ocp_if __maybe_unused omap54xx_l4_abe__aess=
_dma =3D {
> +	.master		=3D &omap54xx_l4_abe_hwmod,
> +	.slave		=3D &omap54xx_aess_hwmod,
> +	.clk		=3D "abe_iclk",
> +	.user		=3D OCP_USER_SDMA,
> +};
> +
>  /* l4_abe -> dmic */
>  static struct omap_hwmod_ocp_if omap54xx_l4_abe__dmic =3D {
>  	.master		=3D &omap54xx_l4_abe_hwmod,
> @@ -2417,6 +2478,9 @@ static struct omap_hwmod_ocp_if *omap54xx_hwmod=
_ocp_ifs[] __initdata =3D {
>  	&omap54xx_l3_main_1__l3_main_3,
>  	&omap54xx_l3_main_2__l3_main_3,
>  	&omap54xx_l4_cfg__l3_main_3,
> +	&omap54xx_l4_abe__aess,
> +	&omap54xx_l4_abe__aess_dma,
> +	&omap54xx_aess__l4_abe,
>  	&omap54xx_l3_main_1__l4_abe,
>  	&omap54xx_mpu__l4_abe,
>  	&omap54xx_l3_main_1__l4_cfg,
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
