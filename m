From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/3] ARM: OMAP3: hwmod data: Merge and
 remove the McBSP sidetone related data
Date: Fri, 18 Mar 2016 16:09:50 +0200
Message-ID: <56EC0C2E.4070408@ti.com>
References: <1458296929-718-1-git-send-email-peter.ujfalusi@ti.com>
 <1458296929-718-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1458296929-718-3-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Paul Walmsley <paul@pwsan.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 03/18/2016 12:28 PM, Peter Ujfalusi wrote:
> McBSP2 and 3 have integrated sidetone block. The sidetone alone can not
> operate, can not be enabled separately from the McBSP it is attached to.
> The sidetone is enabled via McBSP register(s) and it is using the McBSP
> module's iclk as clock. While the sidetone block of McBSP does have it's
> SYSCONFIG registers to enable/disable AUTOIDLE (of McBSP_ICLK) this alone
> does not mean that we should have dedicated hwmod for McBSP internal
> blocks. Note: The AUTOIDLE bit is set after reset and hwmod is not changi=
ng
> it in runtime.
> The sidetone can not be enabled separately from McBSP, it can only enabled
> when McBSP is in use.
> Furthermore the sidetone data is specifying the exact same prcm registers
> and bits as the McBSP hwmod it is attached to.
> As one of the main function of the sidetone hwmod data is to convey the
> address and irq number to the main mcbsp hwmod, move them directly to the
> corresponding McBSP's hwmod data.

My signed-off is missing :(
Also I have noticed one thing with this patch: it will cause regression in
legacy boot on OMPA3.
The code in mach-omap2/mcbsp.c is checking:
if (oh->dev_attr) {
...
}

To decide if the mcbsp port has sidetone or not, and if it does it will fill
in the hooks to be able to disable and enable the McBSP idle modes in PRCM =
level.

I will resend the DTS and OMAP patches with a fix included.

BTW: I'm working on a solution which will work with DT boot as well. Curren=
tly
in DT booted kernel we can not get stable sidetone.

Sorry,
P=E9ter

> ---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 120 ++++-------------------=
------
>  1 file changed, 14 insertions(+), 106 deletions(-)
> =

> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-o=
map2/omap_hwmod_3xxx_data.c
> index 9869a75c5d96..317e9b816a02 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -1175,13 +1175,10 @@ static struct omap_hwmod_irq_info omap3xxx_mcbsp2=
_irqs[] =3D {
>  	{ .name =3D "common", .irq =3D 17 + OMAP_INTC_START, },
>  	{ .name =3D "tx", .irq =3D 62 + OMAP_INTC_START, },
>  	{ .name =3D "rx", .irq =3D 63 + OMAP_INTC_START, },
> +	{ .name =3D "sidetone", .irq =3D 4 + OMAP_INTC_START, },
>  	{ .irq =3D -1 },
>  };
>  =

> -static struct omap_mcbsp_dev_attr omap34xx_mcbsp2_dev_attr =3D {
> -	.sidetone	=3D "mcbsp2_sidetone",
> -};
> -
>  static struct omap_hwmod omap3xxx_mcbsp2_hwmod =3D {
>  	.name		=3D "mcbsp2",
>  	.class		=3D &omap3xxx_mcbsp_hwmod_class,
> @@ -1199,7 +1196,6 @@ static struct omap_hwmod omap3xxx_mcbsp2_hwmod =3D {
>  	},
>  	.opt_clks	=3D mcbsp234_opt_clks,
>  	.opt_clks_cnt	=3D ARRAY_SIZE(mcbsp234_opt_clks),
> -	.dev_attr	=3D &omap34xx_mcbsp2_dev_attr,
>  };
>  =

>  /* mcbsp3 */
> @@ -1207,13 +1203,10 @@ static struct omap_hwmod_irq_info omap3xxx_mcbsp3=
_irqs[] =3D {
>  	{ .name =3D "common", .irq =3D 22 + OMAP_INTC_START, },
>  	{ .name =3D "tx", .irq =3D 89 + OMAP_INTC_START, },
>  	{ .name =3D "rx", .irq =3D 90 + OMAP_INTC_START, },
> +	{ .name =3D "sidetone", .irq =3D 5 + OMAP_INTC_START, },
>  	{ .irq =3D -1 },
>  };
>  =

> -static struct omap_mcbsp_dev_attr omap34xx_mcbsp3_dev_attr =3D {
> -	.sidetone	=3D "mcbsp3_sidetone",
> -};
> -
>  static struct omap_hwmod omap3xxx_mcbsp3_hwmod =3D {
>  	.name		=3D "mcbsp3",
>  	.class		=3D &omap3xxx_mcbsp_hwmod_class,
> @@ -1231,7 +1224,6 @@ static struct omap_hwmod omap3xxx_mcbsp3_hwmod =3D {
>  	},
>  	.opt_clks	=3D mcbsp234_opt_clks,
>  	.opt_clks_cnt	=3D ARRAY_SIZE(mcbsp234_opt_clks),
> -	.dev_attr	=3D &omap34xx_mcbsp3_dev_attr,
>  };
>  =

>  /* mcbsp4 */
> @@ -1300,62 +1292,6 @@ static struct omap_hwmod omap3xxx_mcbsp5_hwmod =3D=
 {
>  	.opt_clks_cnt	=3D ARRAY_SIZE(mcbsp15_opt_clks),
>  };
>  =

> -/* 'mcbsp sidetone' class */
> -static struct omap_hwmod_class_sysconfig omap3xxx_mcbsp_sidetone_sysc =
=3D {
> -	.sysc_offs	=3D 0x0010,
> -	.sysc_flags	=3D SYSC_HAS_AUTOIDLE,
> -	.sysc_fields	=3D &omap_hwmod_sysc_type1,
> -};
> -
> -static struct omap_hwmod_class omap3xxx_mcbsp_sidetone_hwmod_class =3D {
> -	.name =3D "mcbsp_sidetone",
> -	.sysc =3D &omap3xxx_mcbsp_sidetone_sysc,
> -};
> -
> -/* mcbsp2_sidetone */
> -static struct omap_hwmod_irq_info omap3xxx_mcbsp2_sidetone_irqs[] =3D {
> -	{ .name =3D "irq", .irq =3D 4 + OMAP_INTC_START, },
> -	{ .irq =3D -1 },
> -};
> -
> -static struct omap_hwmod omap3xxx_mcbsp2_sidetone_hwmod =3D {
> -	.name		=3D "mcbsp2_sidetone",
> -	.class		=3D &omap3xxx_mcbsp_sidetone_hwmod_class,
> -	.mpu_irqs	=3D omap3xxx_mcbsp2_sidetone_irqs,
> -	.main_clk	=3D "mcbsp2_fck",
> -	.prcm		=3D {
> -		.omap2 =3D {
> -			.prcm_reg_id =3D 1,
> -			 .module_bit =3D OMAP3430_EN_MCBSP2_SHIFT,
> -			.module_offs =3D OMAP3430_PER_MOD,
> -			.idlest_reg_id =3D 1,
> -			.idlest_idle_bit =3D OMAP3430_ST_MCBSP2_SHIFT,
> -		},
> -	},
> -};
> -
> -/* mcbsp3_sidetone */
> -static struct omap_hwmod_irq_info omap3xxx_mcbsp3_sidetone_irqs[] =3D {
> -	{ .name =3D "irq", .irq =3D 5 + OMAP_INTC_START, },
> -	{ .irq =3D -1 },
> -};
> -
> -static struct omap_hwmod omap3xxx_mcbsp3_sidetone_hwmod =3D {
> -	.name		=3D "mcbsp3_sidetone",
> -	.class		=3D &omap3xxx_mcbsp_sidetone_hwmod_class,
> -	.mpu_irqs	=3D omap3xxx_mcbsp3_sidetone_irqs,
> -	.main_clk	=3D "mcbsp3_fck",
> -	.prcm		=3D {
> -		.omap2 =3D {
> -			.prcm_reg_id =3D 1,
> -			.module_bit =3D OMAP3430_EN_MCBSP3_SHIFT,
> -			.module_offs =3D OMAP3430_PER_MOD,
> -			.idlest_reg_id =3D 1,
> -			.idlest_idle_bit =3D OMAP3430_ST_MCBSP3_SHIFT,
> -		},
> -	},
> -};
> -
>  /* SR common */
>  static struct omap_hwmod_sysc_fields omap34xx_sr_sysc_fields =3D {
>  	.clkact_shift	=3D 20,
> @@ -3108,6 +3044,12 @@ static struct omap_hwmod_addr_space omap3xxx_mcbsp=
2_addrs[] =3D {
>  		.pa_end		=3D 0x490220ff,
>  		.flags		=3D ADDR_TYPE_RT
>  	},
> +	{
> +		.name		=3D "sidetone",
> +		.pa_start	=3D 0x49028000,
> +		.pa_end		=3D 0x490280ff,
> +		.flags		=3D ADDR_TYPE_RT
> +	},
>  	{ }
>  };
>  =

> @@ -3127,6 +3069,12 @@ static struct omap_hwmod_addr_space omap3xxx_mcbsp=
3_addrs[] =3D {
>  		.pa_end		=3D 0x490240ff,
>  		.flags		=3D ADDR_TYPE_RT
>  	},
> +	{
> +		.name		=3D "sidetone",
> +		.pa_start	=3D 0x4902A000,
> +		.pa_end		=3D 0x4902A0ff,
> +		.flags		=3D ADDR_TYPE_RT
> +	},
>  	{ }
>  };
>  =

> @@ -3177,44 +3125,6 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__=
mcbsp5 =3D {
>  	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
>  };
>  =

> -static struct omap_hwmod_addr_space omap3xxx_mcbsp2_sidetone_addrs[] =3D=
 {
> -	{
> -		.name		=3D "sidetone",
> -		.pa_start	=3D 0x49028000,
> -		.pa_end		=3D 0x490280ff,
> -		.flags		=3D ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
> -/* l4_per -> mcbsp2_sidetone */
> -static struct omap_hwmod_ocp_if omap3xxx_l4_per__mcbsp2_sidetone =3D {
> -	.master		=3D &omap3xxx_l4_per_hwmod,
> -	.slave		=3D &omap3xxx_mcbsp2_sidetone_hwmod,
> -	.clk		=3D "mcbsp2_ick",
> -	.addr		=3D omap3xxx_mcbsp2_sidetone_addrs,
> -	.user		=3D OCP_USER_MPU,
> -};
> -
> -static struct omap_hwmod_addr_space omap3xxx_mcbsp3_sidetone_addrs[] =3D=
 {
> -	{
> -		.name		=3D "sidetone",
> -		.pa_start	=3D 0x4902A000,
> -		.pa_end		=3D 0x4902A0ff,
> -		.flags		=3D ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
> -/* l4_per -> mcbsp3_sidetone */
> -static struct omap_hwmod_ocp_if omap3xxx_l4_per__mcbsp3_sidetone =3D {
> -	.master		=3D &omap3xxx_l4_per_hwmod,
> -	.slave		=3D &omap3xxx_mcbsp3_sidetone_hwmod,
> -	.clk		=3D "mcbsp3_ick",
> -	.addr		=3D omap3xxx_mcbsp3_sidetone_addrs,
> -	.user		=3D OCP_USER_MPU,
> -};
> -
>  /* l4_core -> mailbox */
>  static struct omap_hwmod_ocp_if omap3xxx_l4_core__mailbox =3D {
>  	.master		=3D &omap3xxx_l4_core_hwmod,
> @@ -3651,8 +3561,6 @@ static struct omap_hwmod_ocp_if *omap3xxx_hwmod_ocp=
_ifs[] __initdata =3D {
>  	&omap3xxx_l4_per__mcbsp3,
>  	&omap3xxx_l4_per__mcbsp4,
>  	&omap3xxx_l4_core__mcbsp5,
> -	&omap3xxx_l4_per__mcbsp2_sidetone,
> -	&omap3xxx_l4_per__mcbsp3_sidetone,
>  	&omap34xx_l4_core__mcspi1,
>  	&omap34xx_l4_core__mcspi2,
>  	&omap34xx_l4_core__mcspi3,
> =
