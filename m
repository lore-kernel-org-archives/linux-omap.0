From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 10/11] ARM: DRA7: hwmod: Add data for McASP1/2/4/5/6/7/8
Date: Tue, 1 Mar 2016 18:43:29 +0200
Message-ID: <56D5C6B1.6040005@ti.com>
References: <1456411827-23962-1-git-send-email-peter.ujfalusi@ti.com>
 <1456411827-23962-11-git-send-email-peter.ujfalusi@ti.com>
 <alpine.DEB.2.02.1603010900590.14948@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.02.1603010900590.14948@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, robh+dt@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Paul,

On 03/01/2016 11:11 AM, Paul Walmsley wrote:
> Hi P=E9ter
> =

> A few questions:
> =

> On Thu, 25 Feb 2016, Peter Ujfalusi wrote:
> =

>> Add missing data for all McASP ports for the dra7 family
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> =

> 1. The patch doesn't set the HWMOD_OPT_CLKS_NEEDED flag for McASP1 and 2, =

> but does set it for McASP4-8.  Could you please confirm that this is =

> intentional, and if so, why?

All should have the HWMOD_OPT_CLKS_NEEDED as both fclk and ahclkx is treated
as functional clock and needs to be available in order to be able to access
McASP registers.
Sorry, I can only test McASP3 and somehow I overlooked this when copy-pasti=
ng
the data.

> 2. The patch sets HWMOD_SWSUP_SIDLE for McASP1 and 2, but doesn't set it =

> for McASP4-8.  Could you please confirm that this is intentional, and if =

> so, why?  The descriptions of the MODULEMODE fields in SPRUHZ6 look =

> identical.

I need to confirm this, but all McASP should have the same set of flags.

> =

> 3. Can McASP1,2,3 bus-master onto the L3?  If so, then there should be =

> "dra7xx_mcasp1__l3_main_1"-style links to indicate this.

I need to check this, but I don't think McASP1,2,3 can be bus-master onto L=
3.

> =

> =

> - Paul

I can resend the series next week as I'm out of office this week.

-- =

P=E9ter

> =

>> ---
>>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 235 +++++++++++++++++++++++=
+++++++
>>  1 file changed, 235 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-o=
map2/omap_hwmod_7xx_data.c
>> index 3953ad031c43..3bd067afa702 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>> @@ -1374,6 +1374,50 @@ static struct omap_hwmod_class dra7xx_mcasp_hwmod=
_class =3D {
>>  	.sysc	=3D &dra7xx_mcasp_sysc,
>>  };
>>  =

>> +/* mcasp1 */
>> +static struct omap_hwmod_opt_clk mcasp1_opt_clks[] =3D {
>> +	{ .role =3D "ahclkx", .clk =3D "mcasp1_ahclkx_mux" },
>> +};
>> +
>> +static struct omap_hwmod dra7xx_mcasp1_hwmod =3D {
>> +	.name		=3D "mcasp1",
>> +	.class		=3D &dra7xx_mcasp_hwmod_class,
>> +	.clkdm_name	=3D "ipu_clkdm",
>> +	.main_clk	=3D "mcasp1_aux_gfclk_mux",
>> +	.flags		=3D HWMOD_SWSUP_SIDLE,
>> +	.prcm =3D {
>> +		.omap4 =3D {
>> +			.clkctrl_offs =3D DRA7XX_CM_IPU_MCASP1_CLKCTRL_OFFSET,
>> +			.context_offs =3D DRA7XX_RM_IPU_MCASP1_CONTEXT_OFFSET,
>> +			.modulemode   =3D MODULEMODE_SWCTRL,
>> +		},
>> +	},
>> +	.opt_clks	=3D mcasp1_opt_clks,
>> +	.opt_clks_cnt	=3D ARRAY_SIZE(mcasp1_opt_clks),
>> +};
>> +
>> +/* mcasp2 */
>> +static struct omap_hwmod_opt_clk mcasp2_opt_clks[] =3D {
>> +	{ .role =3D "ahclkx", .clk =3D "mcasp2_ahclkx_mux" },
>> +};
>> +
>> +static struct omap_hwmod dra7xx_mcasp2_hwmod =3D {
>> +	.name		=3D "mcasp2",
>> +	.class		=3D &dra7xx_mcasp_hwmod_class,
>> +	.clkdm_name	=3D "l4per2_clkdm",
>> +	.main_clk	=3D "mcasp2_aux_gfclk_mux",
>> +	.flags		=3D HWMOD_SWSUP_SIDLE,
>> +	.prcm =3D {
>> +		.omap4 =3D {
>> +			.clkctrl_offs =3D DRA7XX_CM_L4PER2_MCASP2_CLKCTRL_OFFSET,
>> +			.context_offs =3D DRA7XX_RM_L4PER2_MCASP2_CONTEXT_OFFSET,
>> +			.modulemode   =3D MODULEMODE_SWCTRL,
>> +		},
>> +	},
>> +	.opt_clks	=3D mcasp2_opt_clks,
>> +	.opt_clks_cnt	=3D ARRAY_SIZE(mcasp2_opt_clks),
>> +};
>> +
>>  /* mcasp3 */
>>  static struct omap_hwmod_opt_clk mcasp3_opt_clks[] =3D {
>>  	{ .role =3D "ahclkx", .clk =3D "mcasp3_ahclkx_mux" },
>> @@ -1396,6 +1440,116 @@ static struct omap_hwmod dra7xx_mcasp3_hwmod =3D=
 {
>>  	.opt_clks_cnt	=3D ARRAY_SIZE(mcasp3_opt_clks),
>>  };
>>  =

>> +/* mcasp4 */
>> +static struct omap_hwmod_opt_clk mcasp4_opt_clks[] =3D {
>> +	{ .role =3D "ahclkx", .clk =3D "mcasp4_ahclkx_mux" },
>> +};
>> +
>> +static struct omap_hwmod dra7xx_mcasp4_hwmod =3D {
>> +	.name		=3D "mcasp4",
>> +	.class		=3D &dra7xx_mcasp_hwmod_class,
>> +	.clkdm_name	=3D "l4per2_clkdm",
>> +	.main_clk	=3D "mcasp4_aux_gfclk_mux",
>> +	.flags		=3D HWMOD_OPT_CLKS_NEEDED,
>> +	.prcm =3D {
>> +		.omap4 =3D {
>> +			.clkctrl_offs =3D DRA7XX_CM_L4PER2_MCASP4_CLKCTRL_OFFSET,
>> +			.context_offs =3D DRA7XX_RM_L4PER2_MCASP4_CONTEXT_OFFSET,
>> +			.modulemode   =3D MODULEMODE_SWCTRL,
>> +		},
>> +	},
>> +	.opt_clks	=3D mcasp4_opt_clks,
>> +	.opt_clks_cnt	=3D ARRAY_SIZE(mcasp4_opt_clks),
>> +};
>> +
>> +/* mcasp5 */
>> +static struct omap_hwmod_opt_clk mcasp5_opt_clks[] =3D {
>> +	{ .role =3D "ahclkx", .clk =3D "mcasp5_ahclkx_mux" },
>> +};
>> +
>> +static struct omap_hwmod dra7xx_mcasp5_hwmod =3D {
>> +	.name		=3D "mcasp5",
>> +	.class		=3D &dra7xx_mcasp_hwmod_class,
>> +	.clkdm_name	=3D "l4per2_clkdm",
>> +	.main_clk	=3D "mcasp5_aux_gfclk_mux",
>> +	.flags		=3D HWMOD_OPT_CLKS_NEEDED,
>> +	.prcm =3D {
>> +		.omap4 =3D {
>> +			.clkctrl_offs =3D DRA7XX_CM_L4PER2_MCASP5_CLKCTRL_OFFSET,
>> +			.context_offs =3D DRA7XX_RM_L4PER2_MCASP5_CONTEXT_OFFSET,
>> +			.modulemode   =3D MODULEMODE_SWCTRL,
>> +		},
>> +	},
>> +	.opt_clks	=3D mcasp5_opt_clks,
>> +	.opt_clks_cnt	=3D ARRAY_SIZE(mcasp5_opt_clks),
>> +};
>> +
>> +/* mcasp6 */
>> +static struct omap_hwmod_opt_clk mcasp6_opt_clks[] =3D {
>> +	{ .role =3D "ahclkx", .clk =3D "mcasp6_ahclkx_mux" },
>> +};
>> +
>> +static struct omap_hwmod dra7xx_mcasp6_hwmod =3D {
>> +	.name		=3D "mcasp6",
>> +	.class		=3D &dra7xx_mcasp_hwmod_class,
>> +	.clkdm_name	=3D "l4per2_clkdm",
>> +	.main_clk	=3D "mcasp6_aux_gfclk_mux",
>> +	.flags		=3D HWMOD_OPT_CLKS_NEEDED,
>> +	.prcm =3D {
>> +		.omap4 =3D {
>> +			.clkctrl_offs =3D DRA7XX_CM_L4PER2_MCASP6_CLKCTRL_OFFSET,
>> +			.context_offs =3D DRA7XX_RM_L4PER2_MCASP6_CONTEXT_OFFSET,
>> +			.modulemode   =3D MODULEMODE_SWCTRL,
>> +		},
>> +	},
>> +	.opt_clks	=3D mcasp6_opt_clks,
>> +	.opt_clks_cnt	=3D ARRAY_SIZE(mcasp6_opt_clks),
>> +};
>> +
>> +/* mcasp7 */
>> +static struct omap_hwmod_opt_clk mcasp7_opt_clks[] =3D {
>> +	{ .role =3D "ahclkx", .clk =3D "mcasp7_ahclkx_mux" },
>> +};
>> +
>> +static struct omap_hwmod dra7xx_mcasp7_hwmod =3D {
>> +	.name		=3D "mcasp7",
>> +	.class		=3D &dra7xx_mcasp_hwmod_class,
>> +	.clkdm_name	=3D "l4per2_clkdm",
>> +	.main_clk	=3D "mcasp7_aux_gfclk_mux",
>> +	.flags		=3D HWMOD_OPT_CLKS_NEEDED,
>> +	.prcm =3D {
>> +		.omap4 =3D {
>> +			.clkctrl_offs =3D DRA7XX_CM_L4PER2_MCASP7_CLKCTRL_OFFSET,
>> +			.context_offs =3D DRA7XX_RM_L4PER2_MCASP7_CONTEXT_OFFSET,
>> +			.modulemode   =3D MODULEMODE_SWCTRL,
>> +		},
>> +	},
>> +	.opt_clks	=3D mcasp7_opt_clks,
>> +	.opt_clks_cnt	=3D ARRAY_SIZE(mcasp7_opt_clks),
>> +};
>> +
>> +/* mcasp8 */
>> +static struct omap_hwmod_opt_clk mcasp8_opt_clks[] =3D {
>> +	{ .role =3D "ahclkx", .clk =3D "mcasp8_ahclkx_mux" },
>> +};
>> +
>> +static struct omap_hwmod dra7xx_mcasp8_hwmod =3D {
>> +	.name		=3D "mcasp8",
>> +	.class		=3D &dra7xx_mcasp_hwmod_class,
>> +	.clkdm_name	=3D "l4per2_clkdm",
>> +	.main_clk	=3D "mcasp8_aux_gfclk_mux",
>> +	.flags		=3D HWMOD_OPT_CLKS_NEEDED,
>> +	.prcm =3D {
>> +		.omap4 =3D {
>> +			.clkctrl_offs =3D DRA7XX_CM_L4PER2_MCASP8_CLKCTRL_OFFSET,
>> +			.context_offs =3D DRA7XX_RM_L4PER2_MCASP8_CONTEXT_OFFSET,
>> +			.modulemode   =3D MODULEMODE_SWCTRL,
>> +		},
>> +	},
>> +	.opt_clks	=3D mcasp8_opt_clks,
>> +	.opt_clks_cnt	=3D ARRAY_SIZE(mcasp8_opt_clks),
>> +};
>> +
>>  /*
>>   * 'mmc' class
>>   *
>> @@ -2703,6 +2857,38 @@ static struct omap_hwmod_ocp_if dra7xx_l3_main_1_=
_hdmi =3D {
>>  	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
>>  };
>>  =

>> +/* l4_per2 -> mcasp1 */
>> +static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp1 =3D {
>> +	.master		=3D &dra7xx_l4_per2_hwmod,
>> +	.slave		=3D &dra7xx_mcasp1_hwmod,
>> +	.clk		=3D "l4_root_clk_div",
>> +	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
>> +};
>> +
>> +/* l3_main_1 -> mcasp1 */
>> +static struct omap_hwmod_ocp_if dra7xx_l3_main_1__mcasp1 =3D {
>> +	.master		=3D &dra7xx_l3_main_1_hwmod,
>> +	.slave		=3D &dra7xx_mcasp1_hwmod,
>> +	.clk		=3D "l3_iclk_div",
>> +	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
>> +};
>> +
>> +/* l4_per2 -> mcasp2 */
>> +static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp2 =3D {
>> +	.master		=3D &dra7xx_l4_per2_hwmod,
>> +	.slave		=3D &dra7xx_mcasp2_hwmod,
>> +	.clk		=3D "l4_root_clk_div",
>> +	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
>> +};
>> +
>> +/* l3_main_1 -> mcasp2 */
>> +static struct omap_hwmod_ocp_if dra7xx_l3_main_1__mcasp2 =3D {
>> +	.master		=3D &dra7xx_l3_main_1_hwmod,
>> +	.slave		=3D &dra7xx_mcasp2_hwmod,
>> +	.clk		=3D "l3_iclk_div",
>> +	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
>> +};
>> +
>>  /* l4_per2 -> mcasp3 */
>>  static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp3 =3D {
>>  	.master		=3D &dra7xx_l4_per2_hwmod,
>> @@ -2719,6 +2905,46 @@ static struct omap_hwmod_ocp_if dra7xx_l3_main_1_=
_mcasp3 =3D {
>>  	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
>>  };
>>  =

>> +/* l4_per2 -> mcasp4 */
>> +static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp4 =3D {
>> +	.master		=3D &dra7xx_l4_per2_hwmod,
>> +	.slave		=3D &dra7xx_mcasp4_hwmod,
>> +	.clk		=3D "l4_root_clk_div",
>> +	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
>> +};
>> +
>> +/* l4_per2 -> mcasp5 */
>> +static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp5 =3D {
>> +	.master		=3D &dra7xx_l4_per2_hwmod,
>> +	.slave		=3D &dra7xx_mcasp5_hwmod,
>> +	.clk		=3D "l4_root_clk_div",
>> +	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
>> +};
>> +
>> +/* l4_per2 -> mcasp6 */
>> +static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp6 =3D {
>> +	.master		=3D &dra7xx_l4_per2_hwmod,
>> +	.slave		=3D &dra7xx_mcasp6_hwmod,
>> +	.clk		=3D "l4_root_clk_div",
>> +	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
>> +};
>> +
>> +/* l4_per2 -> mcasp7 */
>> +static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp7 =3D {
>> +	.master		=3D &dra7xx_l4_per2_hwmod,
>> +	.slave		=3D &dra7xx_mcasp7_hwmod,
>> +	.clk		=3D "l4_root_clk_div",
>> +	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
>> +};
>> +
>> +/* l4_per2 -> mcasp8 */
>> +static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp8 =3D {
>> +	.master		=3D &dra7xx_l4_per2_hwmod,
>> +	.slave		=3D &dra7xx_mcasp8_hwmod,
>> +	.clk		=3D "l4_root_clk_div",
>> +	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
>> +};
>> +
>>  /* l4_per1 -> elm */
>>  static struct omap_hwmod_ocp_if dra7xx_l4_per1__elm =3D {
>>  	.master		=3D &dra7xx_l4_per1_hwmod,
>> @@ -3461,8 +3687,17 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp=
_ifs[] __initdata =3D {
>>  	&dra7xx_l4_wkup__dcan1,
>>  	&dra7xx_l4_per2__dcan2,
>>  	&dra7xx_l4_per2__cpgmac0,
>> +	&dra7xx_l4_per2__mcasp1,
>> +	&dra7xx_l3_main_1__mcasp1,
>> +	&dra7xx_l4_per2__mcasp2,
>> +	&dra7xx_l3_main_1__mcasp2,
>>  	&dra7xx_l4_per2__mcasp3,
>>  	&dra7xx_l3_main_1__mcasp3,
>> +	&dra7xx_l4_per2__mcasp4,
>> +	&dra7xx_l4_per2__mcasp5,
>> +	&dra7xx_l4_per2__mcasp6,
>> +	&dra7xx_l4_per2__mcasp7,
>> +	&dra7xx_l4_per2__mcasp8,
>>  	&dra7xx_gmac__mdio,
>>  	&dra7xx_l4_cfg__dma_system,
>>  	&dra7xx_l3_main_1__tpcc,
>> -- =

>> 2.7.1
>>
> =

> =

> - Paul
> =
