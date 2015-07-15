From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 2/5] ARM: OMAP2+: DRA7: Add hwmod entries for PWMSS
Date: Wed, 15 Jul 2015 21:54:22 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1507152029460.32764@utopia.booyaka.com>
References: <1433332284-10766-1-git-send-email-vigneshr@ti.com> <1433332284-10766-3-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433332284-10766-3-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

some comments.

On Wed, 3 Jun 2015, Vignesh R wrote:

> Add hwmod entries for the PWMSS on DRA7.
> 
> Set l4_root_clk_div as the main_clk of PWMSS. It is fixed-factored clock
> equal to L4PER2_L3_GICLK/2(l3_iclk_div/2).
> As per AM57x TRM SPRUHZ6[1], October 2014, Section 29.1.3 Table 29-4,
> clock source to PWMSS is L4PER2_L3_GICLK. But it is actually
> L4PER2_L3_GICLK/2. The TRM does not show the division by 2.

Is the divide-by-two coming from PWMSS_EPWM.EPWM_TBCTL[HSPCLKDIV]?  Or is 
HSPCLKDIV a separate divider after the divide-by-2 you mention above?

> [1] www.ti.com/lit/ug/spruhz6/spruhz6.pdf
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
> 
> v2:
>  * add TRM references.
> 
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 239 ++++++++++++++++++++++++++++++
>  1 file changed, 239 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> index 0e64c2fac0b5..86a7ac9a3138 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> @@ -362,6 +362,149 @@ static struct omap_hwmod dra7xx_dcan2_hwmod = {
>  	},
>  };
>  
> +/* pwmss  */
> +static struct omap_hwmod_class_sysconfig dra7xx_epwmss_sysc = {
> +	.rev_offs	= 0x0,
> +	.sysc_offs	= 0x4,
> +	.sysc_flags	= SYSC_HAS_SIDLEMODE | SYSC_HAS_RESET_STATUS,

This doesn't match SPRUHZ6 Table 29-13 "PWMSS_SYSCONFIG".  There's no 
RESETSTATUS bit.  There is a SOFTRESET bit. 

Could you please confirm whether this is intentional?

> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> +	.sysc_fields	= &omap_hwmod_sysc_type2,
> +};
> +
> +struct omap_hwmod_class dra7xx_epwmss_hwmod_class = {
> +	.name		= "epwmss",
> +	.sysc		= &dra7xx_epwmss_sysc,
> +};
> +
> +static struct omap_hwmod_class dra7xx_ecap_hwmod_class = {
> +	.name		= "ecap",
> +};
> +
> +static struct omap_hwmod_class dra7xx_eqep_hwmod_class = {
> +	.name		= "eqep",
> +};
> +
> +struct omap_hwmod_class dra7xx_ehrpwm_hwmod_class = {
> +	.name		= "ehrpwm",
> +};
> +
> +/* epwmss0 */
> +struct omap_hwmod dra7xx_epwmss0_hwmod = {
> +	.name		= "epwmss0",
> +	.class		= &dra7xx_epwmss_hwmod_class,
> +	.clkdm_name	= "l4per2_clkdm",
> +	.main_clk	= "l4_root_clk_div",
> +	.prcm		= {
> +		.omap4	= {
> +			.modulemode	= MODULEMODE_SWCTRL,
> +			.clkctrl_offs	= DRA7XX_CM_L4PER2_PWMSS1_CLKCTRL_OFFSET,
> +			.context_offs	= DRA7XX_RM_L4PER2_PWMSS1_CONTEXT_OFFSET,
> +		},
> +	},

Per my comment on the previous patch, sounds like it might be better to 
mark this as HWMOD_SWSUP_SIDLE?  Then again, see the next comment below 
re: main_clk.

> +};
> +
> +/* ecap0 */
> +struct omap_hwmod dra7xx_ecap0_hwmod = {
> +	.name		= "ecap0",
> +	.class		= &dra7xx_ecap_hwmod_class,
> +	.clkdm_name	= "l4per2_clkdm",
> +	.main_clk	= "l4_root_clk_div",

Looking at SPRUHZ6 Section 29.1.4.2 "PWMSS Modules Local Clock Gating", 
there appears to be a local "mini-PRCM" for the PWMSS which implements 
clock gating and reports back on the status of what I'd guess is the local 
clock gating FSM.

So from that point of view, you should probably create a clock driver that 
manages both the clock gate request bit and the FSM status bit.  It should 
be something that can be reused for the other PWMSS IP blocks.  Then 
you'd create per-IP block clock nodes and set the main_clk to point to 
that node.

> +};
> +
> +/* eqep0 */
> +struct omap_hwmod dra7xx_eqep0_hwmod = {
> +	.name		= "eqep0",
> +	.class		= &dra7xx_eqep_hwmod_class,
> +	.clkdm_name	= "l4per2_clkdm",
> +	.main_clk	= "l4_root_clk_div",

Same main_clk comments as for ecap0.

> +};
> +
> +/* ehrpwm0 */
> +struct omap_hwmod dra7xx_ehrpwm0_hwmod = {
> +	.name		= "ehrpwm0",
> +	.class		= &dra7xx_ehrpwm_hwmod_class,
> +	.clkdm_name	= "l4per2_clkdm",
> +	.main_clk	= "l4_root_clk_div",

Same main_clk comments as for ecap0.

> +};
> +
> +/* epwmss1 */
> +struct omap_hwmod dra7xx_epwmss1_hwmod = {
> +	.name		= "epwmss1",
> +	.class		= &dra7xx_epwmss_hwmod_class,
> +	.clkdm_name	= "l4per2_clkdm",
> +	.main_clk	= "l4_root_clk_div",
> +	.prcm		= {
> +		.omap4	= {
> +			.modulemode	= MODULEMODE_SWCTRL,
> +			.clkctrl_offs	= DRA7XX_CM_L4PER2_PWMSS2_CLKCTRL_OFFSET,
> +			.context_offs	= DRA7XX_RM_L4PER2_PWMSS2_CONTEXT_OFFSET,
> +		},
> +	},

Same flags comment as for epwmss0.

> +};
> +
> +/* ecap1 */
> +struct omap_hwmod dra7xx_ecap1_hwmod = {
> +	.name		= "ecap1",
> +	.class		= &dra7xx_ecap_hwmod_class,
> +	.clkdm_name	= "l4per2_clkdm",
> +	.main_clk	= "l4_root_clk_div",

Same main_clk comments as for ecap0.

> +};
> +
> +/* eqep1 */
> +struct omap_hwmod dra7xx_eqep1_hwmod = {
> +	.name		= "eqep1",
> +	.class		= &dra7xx_eqep_hwmod_class,
> +	.clkdm_name	= "l4per2_clkdm",
> +	.main_clk	= "l4_root_clk_div",

Same main_clk comments as for ecap0.

> +};
> +
> +/* ehrpwm1 */
> +struct omap_hwmod dra7xx_ehrpwm1_hwmod = {
> +	.name		= "ehrpwm1",
> +	.class		= &dra7xx_ehrpwm_hwmod_class,
> +	.clkdm_name	= "l4per2_clkdm",
> +	.main_clk	= "l4_root_clk_div",

Same main_clk comments as for ecap0.

> +};
> +
> +/* epwmss2 */
> +struct omap_hwmod dra7xx_epwmss2_hwmod = {
> +	.name		= "epwmss2",
> +	.class		= &dra7xx_epwmss_hwmod_class,
> +	.clkdm_name	= "l4per2_clkdm",
> +	.main_clk	= "l4_root_clk_div",
> +	.prcm		= {
> +		.omap4	= {
> +			.modulemode	= MODULEMODE_SWCTRL,
> +			.clkctrl_offs	= DRA7XX_CM_L4PER2_PWMSS3_CLKCTRL_OFFSET,
> +			.context_offs	= DRA7XX_RM_L4PER2_PWMSS3_CONTEXT_OFFSET,
> +		},
> +	},

Same flags comment as for epwmss0.

> +};
> +
> +/* ecap2 */
> +struct omap_hwmod dra7xx_ecap2_hwmod = {
> +	.name		= "ecap2",
> +	.class		= &dra7xx_ecap_hwmod_class,
> +	.clkdm_name	= "l4per2_clkdm",
> +	.main_clk	= "l4_root_clk_div",

Same main_clk comments as for ecap0.

> +};
> +
> +/* eqep2 */
> +struct omap_hwmod dra7xx_eqep2_hwmod = {
> +	.name		= "eqep2",
> +	.class		= &dra7xx_eqep_hwmod_class,
> +	.clkdm_name	= "l4per2_clkdm",
> +	.main_clk	= "l4_root_clk_div",

Same main_clk comments as for ecap0.

> +};
> +
> +/* ehrpwm2 */
> +struct omap_hwmod dra7xx_ehrpwm2_hwmod = {
> +	.name		= "ehrpwm2",
> +	.class		= &dra7xx_ehrpwm_hwmod_class,
> +	.clkdm_name	= "l4per2_clkdm",
> +	.main_clk	= "l4_root_clk_div",

Same main_clk comments as for ecap0.

> +};
> +
>  /*
>   * 'dma' class
>   *
> @@ -2601,6 +2744,90 @@ static struct omap_hwmod_ocp_if dra7xx_l4_per1__gpio6 = {
>  	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>  };
>  
> +struct omap_hwmod_ocp_if dra7xx_l4_per2__epwmss0 = {
> +	.master		= &dra7xx_l4_per2_hwmod,
> +	.slave		= &dra7xx_epwmss0_hwmod,
> +	.clk		= "l4_root_clk_div",
> +	.user		= OCP_USER_MPU,
> +};
> +
> +struct omap_hwmod_ocp_if dra7xx_epwmss0__ecap0 = {
> +	.master		= &dra7xx_epwmss0_hwmod,
> +	.slave		= &dra7xx_ecap0_hwmod,
> +	.clk		= "l4_root_clk_div",

Same main_clk comments as for ecap0.

> +	.user		= OCP_USER_MPU,
> +};
> +
> +struct omap_hwmod_ocp_if dra7xx_epwmss0__eqep0 = {
> +	.master		= &dra7xx_epwmss0_hwmod,
> +	.slave		= &dra7xx_eqep0_hwmod,
> +	.clk		= "l4_root_clk_div",

Same main_clk comments as for ecap0.

> +	.user		= OCP_USER_MPU,
> +};
> +
> +struct omap_hwmod_ocp_if dra7xx_epwmss0__ehrpwm0 = {
> +	.master		= &dra7xx_epwmss0_hwmod,
> +	.slave		= &dra7xx_ehrpwm0_hwmod,
> +	.clk		= "l4_root_clk_div",

Same main_clk comments as for ecap0.

> +	.user		= OCP_USER_MPU,
> +};
> +
> +struct omap_hwmod_ocp_if dra7xx_l4_per2__epwmss1 = {
> +	.master		= &dra7xx_l4_per2_hwmod,
> +	.slave		= &dra7xx_epwmss1_hwmod,
> +	.clk		= "l4_root_clk_div",
> +	.user		= OCP_USER_MPU,
> +};
> +
> +struct omap_hwmod_ocp_if dra7xx_epwmss1__ecap1 = {
> +	.master		= &dra7xx_epwmss1_hwmod,
> +	.slave		= &dra7xx_ecap1_hwmod,
> +	.clk		= "l4_root_clk_div",

Same main_clk comments as for ecap0.

> +	.user		= OCP_USER_MPU,
> +};
> +
> +struct omap_hwmod_ocp_if dra7xx_epwmss1__eqep1 = {
> +	.master		= &dra7xx_epwmss1_hwmod,
> +	.slave		= &dra7xx_eqep1_hwmod,
> +	.clk		= "l4_root_clk_div",

Same main_clk comments as for ecap0.

> +	.user		= OCP_USER_MPU,
> +};
> +
> +struct omap_hwmod_ocp_if dra7xx_epwmss1__ehrpwm1 = {
> +	.master		= &dra7xx_epwmss1_hwmod,
> +	.slave		= &dra7xx_ehrpwm1_hwmod,
> +	.clk		= "l4_root_clk_div",

Same main_clk comments as for ecap0.

> +	.user		= OCP_USER_MPU,
> +};
> +
> +struct omap_hwmod_ocp_if dra7xx_l4_per2__epwmss2 = {
> +	.master		= &dra7xx_l4_per2_hwmod,
> +	.slave		= &dra7xx_epwmss2_hwmod,
> +	.clk		= "l4_root_clk_div",
> +	.user		= OCP_USER_MPU,
> +};
> +
> +struct omap_hwmod_ocp_if dra7xx_epwmss2__ecap2 = {
> +	.master		= &dra7xx_epwmss2_hwmod,
> +	.slave		= &dra7xx_ecap2_hwmod,
> +	.clk		= "l4_root_clk_div",

Same main_clk comments as for ecap0.

> +	.user		= OCP_USER_MPU,
> +};
> +
> +struct omap_hwmod_ocp_if dra7xx_epwmss2__eqep2 = {
> +	.master		= &dra7xx_epwmss2_hwmod,
> +	.slave		= &dra7xx_eqep2_hwmod,
> +	.clk		= "l4_root_clk_div",

Same main_clk comments as for ecap0.

> +	.user		= OCP_USER_MPU,
> +};
> +
> +struct omap_hwmod_ocp_if dra7xx_epwmss2__ehrpwm2 = {
> +	.master		= &dra7xx_epwmss2_hwmod,
> +	.slave		= &dra7xx_ehrpwm2_hwmod,
> +	.clk		= "l4_root_clk_div",

Same main_clk comments as for ecap0.

> +	.user		= OCP_USER_MPU,
> +};
> +
>  /* l4_per1 -> gpio7 */
>  static struct omap_hwmod_ocp_if dra7xx_l4_per1__gpio7 = {
>  	.master		= &dra7xx_l4_per1_hwmod,
> @@ -3394,6 +3621,18 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
>  	&dra7xx_l3_main_1__vcp2,
>  	&dra7xx_l4_per2__vcp2,
>  	&dra7xx_l4_wkup__wd_timer2,
> +	&dra7xx_l4_per2__epwmss0,
> +	&dra7xx_epwmss0__ecap0,
> +	&dra7xx_epwmss0__eqep0,
> +	&dra7xx_epwmss0__ehrpwm0,
> +	&dra7xx_l4_per2__epwmss1,
> +	&dra7xx_epwmss1__ecap1,
> +	&dra7xx_epwmss1__eqep1,
> +	&dra7xx_epwmss1__ehrpwm1,
> +	&dra7xx_l4_per2__epwmss2,
> +	&dra7xx_epwmss2__ecap2,
> +	&dra7xx_epwmss2__eqep2,
> +	&dra7xx_epwmss2__ehrpwm2,
>  	NULL,
>  };
>  
> -- 
> 2.4.1
> 


- Paul
