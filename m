From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 01/11 RESEND] ARM: OMAP: DRA7: hwmod: Add data for McASP3
Date: Fri, 25 Sep 2015 10:02:41 +0300
Message-ID: <5604F191.3010206@ti.com>
References: <1442326206-30192-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442326206-30192-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

Paul,

On 09/15/2015 05:10 PM, Peter Ujfalusi wrote:
> McASP3 is used by default on DRA7x based boards for audio.

Can you take a look at this patch? It would be great to have this one r=
eviewed
so the audio support for the dra7 family could be applied by Tony.

Thanks,
P=E9ter

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi Paul,
>=20
> this patch is part of my earlier series and as Tony suggested I'll re=
send the
> hwmod patch for you to review since I missed you from the TO in the s=
eries.
>=20
> The original series:
> https://www.mail-archive.com/linux-omap@vger.kernel.org/msg119319.htm=
l
>=20
> Regards,
> Peter
>=20
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 41 +++++++++++++++++++++=
++++++++++
>  1 file changed, 41 insertions(+)
>=20
> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mac=
h-omap2/omap_hwmod_7xx_data.c
> index 562247bced49..c38b7fa30c27 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> @@ -1298,6 +1298,38 @@ static struct omap_hwmod dra7xx_mcspi4_hwmod =3D=
 {
>  };
> =20
>  /*
> + * 'mcasp' class
> + *
> + */
> +static struct omap_hwmod_class_sysconfig dra7xx_mcasp_sysc =3D {
> +	.sysc_offs	=3D 0x0004,
> +	.sysc_flags	=3D SYSC_HAS_SIDLEMODE,
> +	.idlemodes	=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> +	.sysc_fields	=3D &omap_hwmod_sysc_type3,
> +};
> +
> +static struct omap_hwmod_class dra7xx_mcasp_hwmod_class =3D {
> +	.name	=3D "mcasp",
> +	.sysc	=3D &dra7xx_mcasp_sysc,
> +};
> +
> +/* mcasp3 */
> +static struct omap_hwmod dra7xx_mcasp3_hwmod =3D {
> +	.name		=3D "mcasp3",
> +	.class		=3D &dra7xx_mcasp_hwmod_class,
> +	.clkdm_name	=3D "l4per2_clkdm",
> +	.main_clk	=3D "mcasp3_ahclkx_mux",
> +	.flags		=3D HWMOD_SWSUP_SIDLE,
> +	.prcm =3D {
> +		.omap4 =3D {
> +			.clkctrl_offs =3D DRA7XX_CM_L4PER2_MCASP3_CLKCTRL_OFFSET,
> +			.context_offs =3D DRA7XX_RM_L4PER2_MCASP3_CONTEXT_OFFSET,
> +			.modulemode   =3D MODULEMODE_SWCTRL,
> +		},
> +	},
> +};
> +
> +/*
>   * 'mmc' class
>   *
>   */
> @@ -2566,6 +2598,14 @@ static struct omap_hwmod_ocp_if dra7xx_l3_main=
_1__hdmi =3D {
>  	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
>  };
> =20
> +/* l4_per2 -> mcasp3 */
> +static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp3 =3D {
> +	.master		=3D &dra7xx_l4_per2_hwmod,
> +	.slave		=3D &dra7xx_mcasp3_hwmod,
> +	.clk		=3D "l3_iclk_div",
> +	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
>  static struct omap_hwmod_addr_space dra7xx_elm_addrs[] =3D {
>  	{
>  		.pa_start	=3D 0x48078000,
> @@ -3338,6 +3378,7 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_o=
cp_ifs[] __initdata =3D {
>  	&dra7xx_l4_wkup__dcan1,
>  	&dra7xx_l4_per2__dcan2,
>  	&dra7xx_l4_per2__cpgmac0,
> +	&dra7xx_l4_per2__mcasp3,
>  	&dra7xx_gmac__mdio,
>  	&dra7xx_l4_cfg__dma_system,
>  	&dra7xx_l3_main_1__dss,
>=20
