From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 10/11] ARM: DRA7: hwmod: Add data for
 McASP1/2/4/5/6/7/8
Date: Tue, 1 Mar 2016 09:11:31 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1603010900590.14948@utopia.booyaka.com>
References: <1456411827-23962-1-git-send-email-peter.ujfalusi@ti.com> <1456411827-23962-11-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-1209212906-1456823491=:14948"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456411827-23962-11-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, robh+dt@kernel.org, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-1209212906-1456823491=:14948
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi P=E9ter

A few questions:

On Thu, 25 Feb 2016, Peter Ujfalusi wrote:

> Add missing data for all McASP ports for the dra7 family
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

1. The patch doesn't set the HWMOD_OPT_CLKS_NEEDED flag for McASP1 and 2,=
=20
but does set it for McASP4-8.  Could you please confirm that this is=20
intentional, and if so, why?

2. The patch sets HWMOD_SWSUP_SIDLE for McASP1 and 2, but doesn't set it=20
for McASP4-8.  Could you please confirm that this is intentional, and if=20
so, why?  The descriptions of the MODULEMODE fields in SPRUHZ6 look=20
identical.

3. Can McASP1,2,3 bus-master onto the L3?  If so, then there should be=20
"dra7xx_mcasp1__l3_main_1"-style links to indicate this.


- Paul

> ---
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 235 ++++++++++++++++++++++++=
++++++
>  1 file changed, 235 insertions(+)
>=20
> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-om=
ap2/omap_hwmod_7xx_data.c
> index 3953ad031c43..3bd067afa702 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> @@ -1374,6 +1374,50 @@ static struct omap_hwmod_class dra7xx_mcasp_hwmod_=
class =3D {
>  =09.sysc=09=3D &dra7xx_mcasp_sysc,
>  };
> =20
> +/* mcasp1 */
> +static struct omap_hwmod_opt_clk mcasp1_opt_clks[] =3D {
> +=09{ .role =3D "ahclkx", .clk =3D "mcasp1_ahclkx_mux" },
> +};
> +
> +static struct omap_hwmod dra7xx_mcasp1_hwmod =3D {
> +=09.name=09=09=3D "mcasp1",
> +=09.class=09=09=3D &dra7xx_mcasp_hwmod_class,
> +=09.clkdm_name=09=3D "ipu_clkdm",
> +=09.main_clk=09=3D "mcasp1_aux_gfclk_mux",
> +=09.flags=09=09=3D HWMOD_SWSUP_SIDLE,
> +=09.prcm =3D {
> +=09=09.omap4 =3D {
> +=09=09=09.clkctrl_offs =3D DRA7XX_CM_IPU_MCASP1_CLKCTRL_OFFSET,
> +=09=09=09.context_offs =3D DRA7XX_RM_IPU_MCASP1_CONTEXT_OFFSET,
> +=09=09=09.modulemode   =3D MODULEMODE_SWCTRL,
> +=09=09},
> +=09},
> +=09.opt_clks=09=3D mcasp1_opt_clks,
> +=09.opt_clks_cnt=09=3D ARRAY_SIZE(mcasp1_opt_clks),
> +};
> +
> +/* mcasp2 */
> +static struct omap_hwmod_opt_clk mcasp2_opt_clks[] =3D {
> +=09{ .role =3D "ahclkx", .clk =3D "mcasp2_ahclkx_mux" },
> +};
> +
> +static struct omap_hwmod dra7xx_mcasp2_hwmod =3D {
> +=09.name=09=09=3D "mcasp2",
> +=09.class=09=09=3D &dra7xx_mcasp_hwmod_class,
> +=09.clkdm_name=09=3D "l4per2_clkdm",
> +=09.main_clk=09=3D "mcasp2_aux_gfclk_mux",
> +=09.flags=09=09=3D HWMOD_SWSUP_SIDLE,
> +=09.prcm =3D {
> +=09=09.omap4 =3D {
> +=09=09=09.clkctrl_offs =3D DRA7XX_CM_L4PER2_MCASP2_CLKCTRL_OFFSET,
> +=09=09=09.context_offs =3D DRA7XX_RM_L4PER2_MCASP2_CONTEXT_OFFSET,
> +=09=09=09.modulemode   =3D MODULEMODE_SWCTRL,
> +=09=09},
> +=09},
> +=09.opt_clks=09=3D mcasp2_opt_clks,
> +=09.opt_clks_cnt=09=3D ARRAY_SIZE(mcasp2_opt_clks),
> +};
> +
>  /* mcasp3 */
>  static struct omap_hwmod_opt_clk mcasp3_opt_clks[] =3D {
>  =09{ .role =3D "ahclkx", .clk =3D "mcasp3_ahclkx_mux" },
> @@ -1396,6 +1440,116 @@ static struct omap_hwmod dra7xx_mcasp3_hwmod =3D =
{
>  =09.opt_clks_cnt=09=3D ARRAY_SIZE(mcasp3_opt_clks),
>  };
> =20
> +/* mcasp4 */
> +static struct omap_hwmod_opt_clk mcasp4_opt_clks[] =3D {
> +=09{ .role =3D "ahclkx", .clk =3D "mcasp4_ahclkx_mux" },
> +};
> +
> +static struct omap_hwmod dra7xx_mcasp4_hwmod =3D {
> +=09.name=09=09=3D "mcasp4",
> +=09.class=09=09=3D &dra7xx_mcasp_hwmod_class,
> +=09.clkdm_name=09=3D "l4per2_clkdm",
> +=09.main_clk=09=3D "mcasp4_aux_gfclk_mux",
> +=09.flags=09=09=3D HWMOD_OPT_CLKS_NEEDED,
> +=09.prcm =3D {
> +=09=09.omap4 =3D {
> +=09=09=09.clkctrl_offs =3D DRA7XX_CM_L4PER2_MCASP4_CLKCTRL_OFFSET,
> +=09=09=09.context_offs =3D DRA7XX_RM_L4PER2_MCASP4_CONTEXT_OFFSET,
> +=09=09=09.modulemode   =3D MODULEMODE_SWCTRL,
> +=09=09},
> +=09},
> +=09.opt_clks=09=3D mcasp4_opt_clks,
> +=09.opt_clks_cnt=09=3D ARRAY_SIZE(mcasp4_opt_clks),
> +};
> +
> +/* mcasp5 */
> +static struct omap_hwmod_opt_clk mcasp5_opt_clks[] =3D {
> +=09{ .role =3D "ahclkx", .clk =3D "mcasp5_ahclkx_mux" },
> +};
> +
> +static struct omap_hwmod dra7xx_mcasp5_hwmod =3D {
> +=09.name=09=09=3D "mcasp5",
> +=09.class=09=09=3D &dra7xx_mcasp_hwmod_class,
> +=09.clkdm_name=09=3D "l4per2_clkdm",
> +=09.main_clk=09=3D "mcasp5_aux_gfclk_mux",
> +=09.flags=09=09=3D HWMOD_OPT_CLKS_NEEDED,
> +=09.prcm =3D {
> +=09=09.omap4 =3D {
> +=09=09=09.clkctrl_offs =3D DRA7XX_CM_L4PER2_MCASP5_CLKCTRL_OFFSET,
> +=09=09=09.context_offs =3D DRA7XX_RM_L4PER2_MCASP5_CONTEXT_OFFSET,
> +=09=09=09.modulemode   =3D MODULEMODE_SWCTRL,
> +=09=09},
> +=09},
> +=09.opt_clks=09=3D mcasp5_opt_clks,
> +=09.opt_clks_cnt=09=3D ARRAY_SIZE(mcasp5_opt_clks),
> +};
> +
> +/* mcasp6 */
> +static struct omap_hwmod_opt_clk mcasp6_opt_clks[] =3D {
> +=09{ .role =3D "ahclkx", .clk =3D "mcasp6_ahclkx_mux" },
> +};
> +
> +static struct omap_hwmod dra7xx_mcasp6_hwmod =3D {
> +=09.name=09=09=3D "mcasp6",
> +=09.class=09=09=3D &dra7xx_mcasp_hwmod_class,
> +=09.clkdm_name=09=3D "l4per2_clkdm",
> +=09.main_clk=09=3D "mcasp6_aux_gfclk_mux",
> +=09.flags=09=09=3D HWMOD_OPT_CLKS_NEEDED,
> +=09.prcm =3D {
> +=09=09.omap4 =3D {
> +=09=09=09.clkctrl_offs =3D DRA7XX_CM_L4PER2_MCASP6_CLKCTRL_OFFSET,
> +=09=09=09.context_offs =3D DRA7XX_RM_L4PER2_MCASP6_CONTEXT_OFFSET,
> +=09=09=09.modulemode   =3D MODULEMODE_SWCTRL,
> +=09=09},
> +=09},
> +=09.opt_clks=09=3D mcasp6_opt_clks,
> +=09.opt_clks_cnt=09=3D ARRAY_SIZE(mcasp6_opt_clks),
> +};
> +
> +/* mcasp7 */
> +static struct omap_hwmod_opt_clk mcasp7_opt_clks[] =3D {
> +=09{ .role =3D "ahclkx", .clk =3D "mcasp7_ahclkx_mux" },
> +};
> +
> +static struct omap_hwmod dra7xx_mcasp7_hwmod =3D {
> +=09.name=09=09=3D "mcasp7",
> +=09.class=09=09=3D &dra7xx_mcasp_hwmod_class,
> +=09.clkdm_name=09=3D "l4per2_clkdm",
> +=09.main_clk=09=3D "mcasp7_aux_gfclk_mux",
> +=09.flags=09=09=3D HWMOD_OPT_CLKS_NEEDED,
> +=09.prcm =3D {
> +=09=09.omap4 =3D {
> +=09=09=09.clkctrl_offs =3D DRA7XX_CM_L4PER2_MCASP7_CLKCTRL_OFFSET,
> +=09=09=09.context_offs =3D DRA7XX_RM_L4PER2_MCASP7_CONTEXT_OFFSET,
> +=09=09=09.modulemode   =3D MODULEMODE_SWCTRL,
> +=09=09},
> +=09},
> +=09.opt_clks=09=3D mcasp7_opt_clks,
> +=09.opt_clks_cnt=09=3D ARRAY_SIZE(mcasp7_opt_clks),
> +};
> +
> +/* mcasp8 */
> +static struct omap_hwmod_opt_clk mcasp8_opt_clks[] =3D {
> +=09{ .role =3D "ahclkx", .clk =3D "mcasp8_ahclkx_mux" },
> +};
> +
> +static struct omap_hwmod dra7xx_mcasp8_hwmod =3D {
> +=09.name=09=09=3D "mcasp8",
> +=09.class=09=09=3D &dra7xx_mcasp_hwmod_class,
> +=09.clkdm_name=09=3D "l4per2_clkdm",
> +=09.main_clk=09=3D "mcasp8_aux_gfclk_mux",
> +=09.flags=09=09=3D HWMOD_OPT_CLKS_NEEDED,
> +=09.prcm =3D {
> +=09=09.omap4 =3D {
> +=09=09=09.clkctrl_offs =3D DRA7XX_CM_L4PER2_MCASP8_CLKCTRL_OFFSET,
> +=09=09=09.context_offs =3D DRA7XX_RM_L4PER2_MCASP8_CONTEXT_OFFSET,
> +=09=09=09.modulemode   =3D MODULEMODE_SWCTRL,
> +=09=09},
> +=09},
> +=09.opt_clks=09=3D mcasp8_opt_clks,
> +=09.opt_clks_cnt=09=3D ARRAY_SIZE(mcasp8_opt_clks),
> +};
> +
>  /*
>   * 'mmc' class
>   *
> @@ -2703,6 +2857,38 @@ static struct omap_hwmod_ocp_if dra7xx_l3_main_1__=
hdmi =3D {
>  =09.user=09=09=3D OCP_USER_MPU | OCP_USER_SDMA,
>  };
> =20
> +/* l4_per2 -> mcasp1 */
> +static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp1 =3D {
> +=09.master=09=09=3D &dra7xx_l4_per2_hwmod,
> +=09.slave=09=09=3D &dra7xx_mcasp1_hwmod,
> +=09.clk=09=09=3D "l4_root_clk_div",
> +=09.user=09=09=3D OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* l3_main_1 -> mcasp1 */
> +static struct omap_hwmod_ocp_if dra7xx_l3_main_1__mcasp1 =3D {
> +=09.master=09=09=3D &dra7xx_l3_main_1_hwmod,
> +=09.slave=09=09=3D &dra7xx_mcasp1_hwmod,
> +=09.clk=09=09=3D "l3_iclk_div",
> +=09.user=09=09=3D OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* l4_per2 -> mcasp2 */
> +static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp2 =3D {
> +=09.master=09=09=3D &dra7xx_l4_per2_hwmod,
> +=09.slave=09=09=3D &dra7xx_mcasp2_hwmod,
> +=09.clk=09=09=3D "l4_root_clk_div",
> +=09.user=09=09=3D OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* l3_main_1 -> mcasp2 */
> +static struct omap_hwmod_ocp_if dra7xx_l3_main_1__mcasp2 =3D {
> +=09.master=09=09=3D &dra7xx_l3_main_1_hwmod,
> +=09.slave=09=09=3D &dra7xx_mcasp2_hwmod,
> +=09.clk=09=09=3D "l3_iclk_div",
> +=09.user=09=09=3D OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
>  /* l4_per2 -> mcasp3 */
>  static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp3 =3D {
>  =09.master=09=09=3D &dra7xx_l4_per2_hwmod,
> @@ -2719,6 +2905,46 @@ static struct omap_hwmod_ocp_if dra7xx_l3_main_1__=
mcasp3 =3D {
>  =09.user=09=09=3D OCP_USER_MPU | OCP_USER_SDMA,
>  };
> =20
> +/* l4_per2 -> mcasp4 */
> +static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp4 =3D {
> +=09.master=09=09=3D &dra7xx_l4_per2_hwmod,
> +=09.slave=09=09=3D &dra7xx_mcasp4_hwmod,
> +=09.clk=09=09=3D "l4_root_clk_div",
> +=09.user=09=09=3D OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* l4_per2 -> mcasp5 */
> +static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp5 =3D {
> +=09.master=09=09=3D &dra7xx_l4_per2_hwmod,
> +=09.slave=09=09=3D &dra7xx_mcasp5_hwmod,
> +=09.clk=09=09=3D "l4_root_clk_div",
> +=09.user=09=09=3D OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* l4_per2 -> mcasp6 */
> +static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp6 =3D {
> +=09.master=09=09=3D &dra7xx_l4_per2_hwmod,
> +=09.slave=09=09=3D &dra7xx_mcasp6_hwmod,
> +=09.clk=09=09=3D "l4_root_clk_div",
> +=09.user=09=09=3D OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* l4_per2 -> mcasp7 */
> +static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp7 =3D {
> +=09.master=09=09=3D &dra7xx_l4_per2_hwmod,
> +=09.slave=09=09=3D &dra7xx_mcasp7_hwmod,
> +=09.clk=09=09=3D "l4_root_clk_div",
> +=09.user=09=09=3D OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* l4_per2 -> mcasp8 */
> +static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp8 =3D {
> +=09.master=09=09=3D &dra7xx_l4_per2_hwmod,
> +=09.slave=09=09=3D &dra7xx_mcasp8_hwmod,
> +=09.clk=09=09=3D "l4_root_clk_div",
> +=09.user=09=09=3D OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
>  /* l4_per1 -> elm */
>  static struct omap_hwmod_ocp_if dra7xx_l4_per1__elm =3D {
>  =09.master=09=09=3D &dra7xx_l4_per1_hwmod,
> @@ -3461,8 +3687,17 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_=
ifs[] __initdata =3D {
>  =09&dra7xx_l4_wkup__dcan1,
>  =09&dra7xx_l4_per2__dcan2,
>  =09&dra7xx_l4_per2__cpgmac0,
> +=09&dra7xx_l4_per2__mcasp1,
> +=09&dra7xx_l3_main_1__mcasp1,
> +=09&dra7xx_l4_per2__mcasp2,
> +=09&dra7xx_l3_main_1__mcasp2,
>  =09&dra7xx_l4_per2__mcasp3,
>  =09&dra7xx_l3_main_1__mcasp3,
> +=09&dra7xx_l4_per2__mcasp4,
> +=09&dra7xx_l4_per2__mcasp5,
> +=09&dra7xx_l4_per2__mcasp6,
> +=09&dra7xx_l4_per2__mcasp7,
> +=09&dra7xx_l4_per2__mcasp8,
>  =09&dra7xx_gmac__mdio,
>  =09&dra7xx_l4_cfg__dma_system,
>  =09&dra7xx_l3_main_1__tpcc,
> --=20
> 2.7.1
>=20


- Paul
--843723315-1209212906-1456823491=:14948--
