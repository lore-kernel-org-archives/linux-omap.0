From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 13/13] ARM: OMAP2+: hwmod: AM43x: new w.r.t AM335x
Date: Wed, 21 Aug 2013 17:03:37 +0530
Message-ID: <5214A591.4000507@ti.com>
References: <cover.1375443858.git.afzal@ti.com>
 <6c3b2ee2a2f15ece31e96730ddb21a72d338ccb7.1375443858.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <6c3b2ee2a2f15ece31e96730ddb21a72d338ccb7.1375443858.git.afzal@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Afzal Mohammed <afzal@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, benoit.cousson@gmail.com, Benoit Cousson <benoit.cousson@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Friday 02 August 2013 07:08 PM, Afzal Mohammed wrote:
> Add hwmod support for IP's that are present in AM43x, but not in
> AM335x. AM43x additional ones added here are,
> 1. synctimer
> 2. timer8-11
> 3. ehrpwm3-5
> 4. spi2-4
> 5. gpio4-5
> 
> Also AM43x pruss interconnect is different asc compared to AM335x.
> 
> Update hwmod with the above details and register 'ocpif' if platform
> being run is AM43x.
> 
> AM43x also has IP's like qspi, hdq1w, vpfe, des, rng, usb, dss. These
> are not handled here due to either of following two reasons,
> 1. To avoid churn; most of them don't have DT bindings, which would
>    necessitate adding address space in hwmod, which any way would have
>    to be removed once DT bindings happen with driver support.
> 2. patches would come in from sources other than the author
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_33xx_data.c |  366 +++++++++++++++++++++++++++-
>  1 file changed, 364 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c

Again for readability, its better to have files structured the way omap2420 and omap2430 do with the
reuse. Its confusing to have am43xx specific hwmods in am33xx_data file.

> index 7897fec..0efafd8 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> @@ -1595,6 +1595,228 @@ static struct omap_hwmod am33xx_usbss_hwmod = {
>  	},
>  };
>  
> +static struct omap_hwmod_class_sysconfig am43xx_synctimer_sysc = {
> +	.rev_offs	= 0x0,
> +	.sysc_offs	= 0x4,
> +	.sysc_flags	= SYSC_HAS_SIDLEMODE,
> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO),
> +	.sysc_fields	= &omap_hwmod_sysc_type1,
> +};
> +
> +static struct omap_hwmod_class am43xx_synctimer_hwmod_class = {
> +	.name	= "synctimer",
> +	.sysc	= &am43xx_synctimer_sysc,
> +};
> +
> +static struct omap_hwmod am43xx_synctimer_hwmod = {
> +	.name		= "counter_32k",
> +	.class		= &am43xx_synctimer_hwmod_class,
> +	.clkdm_name	= "l4_wkup_aon_clkdm",
> +	.flags		= HWMOD_SWSUP_SIDLE,
> +	.main_clk	= "synctimer_32kclk",
> +	.prcm = {
> +		.omap4 = {
> +			.clkctrl_offs = AM43XX_CM_WKUP_SYNCTIMER_CLKCTRL_OFFSET,
> +			.modulemode   = MODULEMODE_SWCTRL,
> +		},
> +	},
> +};
> +
> +static struct omap_hwmod am43xx_timer8_hwmod = {
> +	.name		= "timer8",
> +	.class		= &am33xx_timer_hwmod_class,
> +	.clkdm_name	= "l4ls_clkdm",
> +	.main_clk	= "timer8_fck",
> +	.prcm		= {
> +		.omap4	= {
> +			.clkctrl_offs	= AM43XX_CM_PER_TIMER8_CLKCTRL_OFFSET,
> +			.modulemode	= MODULEMODE_SWCTRL,
> +		},
> +	},
> +};
> +
> +static struct omap_hwmod am43xx_timer9_hwmod = {
> +	.name		= "timer9",
> +	.class		= &am33xx_timer_hwmod_class,
> +	.clkdm_name	= "l4ls_clkdm",
> +	.main_clk	= "timer9_fck",
> +	.prcm		= {
> +		.omap4	= {
> +			.clkctrl_offs	= AM43XX_CM_PER_TIMER9_CLKCTRL_OFFSET,
> +			.modulemode	= MODULEMODE_SWCTRL,
> +		},
> +	},
> +};
> +
> +static struct omap_hwmod am43xx_timer10_hwmod = {
> +	.name		= "timer10",
> +	.class		= &am33xx_timer_hwmod_class,
> +	.clkdm_name	= "l4ls_clkdm",
> +	.main_clk	= "timer10_fck",
> +	.prcm		= {
> +		.omap4	= {
> +			.clkctrl_offs	= AM43XX_CM_PER_TIMER10_CLKCTRL_OFFSET,
> +			.modulemode	= MODULEMODE_SWCTRL,
> +		},
> +	},
> +};
> +
> +static struct omap_hwmod am43xx_timer11_hwmod = {
> +	.name		= "timer11",
> +	.class		= &am33xx_timer_hwmod_class,
> +	.clkdm_name	= "l4ls_clkdm",
> +	.main_clk	= "timer11_fck",
> +	.prcm		= {
> +		.omap4	= {
> +			.clkctrl_offs	= AM43XX_CM_PER_TIMER11_CLKCTRL_OFFSET,
> +			.modulemode	= MODULEMODE_SWCTRL,
> +		},
> +	},
> +};
> +
> +static struct omap_hwmod am43xx_epwmss3_hwmod = {
> +	.name		= "epwmss3",
> +	.class		= &am33xx_epwmss_hwmod_class,
> +	.clkdm_name	= "l4ls_clkdm",
> +	.main_clk	= "l4ls_gclk",
> +	.prcm		= {
> +		.omap4	= {
> +			.clkctrl_offs = AM43XX_CM_PER_EPWMSS3_CLKCTRL_OFFSET,
> +			.modulemode   = MODULEMODE_SWCTRL,
> +		},
> +	},
> +};
> +
> +static struct omap_hwmod am43xx_ehrpwm3_hwmod = {
> +	.name		= "ehrpwm3",
> +	.class		= &am33xx_ehrpwm_hwmod_class,
> +	.clkdm_name	= "l4ls_clkdm",
> +	.main_clk	= "l4ls_gclk",
> +};
> +
> +static struct omap_hwmod am43xx_epwmss4_hwmod = {
> +	.name		= "epwmss4",
> +	.class		= &am33xx_epwmss_hwmod_class,
> +	.clkdm_name	= "l4ls_clkdm",
> +	.main_clk	= "l4ls_gclk",
> +	.prcm		= {
> +		.omap4	= {
> +			.clkctrl_offs = AM43XX_CM_PER_EPWMSS4_CLKCTRL_OFFSET,
> +			.modulemode   = MODULEMODE_SWCTRL,
> +		},
> +	},
> +};
> +
> +static struct omap_hwmod am43xx_ehrpwm4_hwmod = {
> +	.name		= "ehrpwm4",
> +	.class		= &am33xx_ehrpwm_hwmod_class,
> +	.clkdm_name	= "l4ls_clkdm",
> +	.main_clk	= "l4ls_gclk",
> +};
> +
> +static struct omap_hwmod am43xx_epwmss5_hwmod = {
> +	.name		= "epwmss5",
> +	.class		= &am33xx_epwmss_hwmod_class,
> +	.clkdm_name	= "l4ls_clkdm",
> +	.main_clk	= "l4ls_gclk",
> +	.prcm		= {
> +		.omap4	= {
> +			.clkctrl_offs = AM43XX_CM_PER_EPWMSS5_CLKCTRL_OFFSET,
> +			.modulemode   = MODULEMODE_SWCTRL,
> +		},
> +	},
> +};
> +
> +static struct omap_hwmod am43xx_ehrpwm5_hwmod = {
> +	.name		= "ehrpwm5",
> +	.class		= &am33xx_ehrpwm_hwmod_class,
> +	.clkdm_name	= "l4ls_clkdm",
> +	.main_clk	= "l4ls_gclk",
> +};
> +
> +static struct omap_hwmod am43xx_spi2_hwmod = {
> +	.name		= "spi2",
> +	.class		= &am33xx_spi_hwmod_class,
> +	.clkdm_name	= "l4ls_clkdm",
> +	.main_clk	= "dpll_per_m2_div4_ck",
> +	.prcm		= {
> +		.omap4	= {
> +			.clkctrl_offs = AM43XX_CM_PER_SPI2_CLKCTRL_OFFSET,
> +			.modulemode   = MODULEMODE_SWCTRL,
> +		},
> +	},
> +	.dev_attr	= &mcspi_attrib,
> +};
> +
> +static struct omap_hwmod am43xx_spi3_hwmod = {
> +	.name		= "spi3",
> +	.class		= &am33xx_spi_hwmod_class,
> +	.clkdm_name	= "l4ls_clkdm",
> +	.main_clk	= "dpll_per_m2_div4_ck",
> +	.prcm		= {
> +		.omap4	= {
> +			.clkctrl_offs = AM43XX_CM_PER_SPI3_CLKCTRL_OFFSET,
> +			.modulemode   = MODULEMODE_SWCTRL,
> +		},
> +	},
> +	.dev_attr	= &mcspi_attrib,
> +};
> +
> +static struct omap_hwmod am43xx_spi4_hwmod = {
> +	.name		= "spi4",
> +	.class		= &am33xx_spi_hwmod_class,
> +	.clkdm_name	= "l4ls_clkdm",
> +	.main_clk	= "dpll_per_m2_div4_ck",
> +	.prcm		= {
> +		.omap4	= {
> +			.clkctrl_offs = AM43XX_CM_PER_SPI4_CLKCTRL_OFFSET,
> +			.modulemode   = MODULEMODE_SWCTRL,
> +		},
> +	},
> +	.dev_attr	= &mcspi_attrib,
> +};
> +
> +static struct omap_hwmod_opt_clk gpio4_opt_clks[] = {
> +	{ .role = "dbclk", .clk = "gpio4_dbclk" },
> +};
> +
> +static struct omap_hwmod am43xx_gpio4_hwmod = {
> +	.name		= "gpio5",
> +	.class		= &am33xx_gpio_hwmod_class,
> +	.clkdm_name	= "l4ls_clkdm",
> +	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
> +	.main_clk	= "l4ls_gclk",
> +	.prcm		= {
> +		.omap4	= {
> +			.clkctrl_offs = AM43XX_CM_PER_GPIO4_CLKCTRL_OFFSET,
> +			.modulemode   = MODULEMODE_SWCTRL,
> +		},
> +	},
> +	.opt_clks	= gpio4_opt_clks,
> +	.opt_clks_cnt	= ARRAY_SIZE(gpio4_opt_clks),
> +	.dev_attr	= &gpio_dev_attr,
> +};
> +
> +static struct omap_hwmod_opt_clk gpio5_opt_clks[] = {
> +	{ .role = "dbclk", .clk = "gpio5_dbclk" },
> +};
> +
> +static struct omap_hwmod am43xx_gpio5_hwmod = {
> +	.name		= "gpio6",
> +	.class		= &am33xx_gpio_hwmod_class,
> +	.clkdm_name	= "l4ls_clkdm",
> +	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
> +	.main_clk	= "l4ls_gclk",
> +	.prcm		= {
> +		.omap4	= {
> +			.clkctrl_offs = AM43XX_CM_PER_GPIO5_CLKCTRL_OFFSET,
> +			.modulemode   = MODULEMODE_SWCTRL,
> +		},
> +	},
> +	.opt_clks	= gpio5_opt_clks,
> +	.opt_clks_cnt	= ARRAY_SIZE(gpio5_opt_clks),
> +	.dev_attr	= &gpio_dev_attr,
> +};
>  
>  /*
>   * Interfaces
> @@ -2379,6 +2601,125 @@ static struct omap_hwmod_ocp_if am33xx_l3_main__aes0 = {
>  	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>  };
>  
> +static struct omap_hwmod_ocp_if am33xx_l4_wkup__synctimer = {
> +	.master		= &am33xx_l4_wkup_hwmod,
> +	.slave		= &am43xx_synctimer_hwmod,
> +	.clk		= "sys_clkin_ck",
> +	.user		= OCP_USER_MPU,
> +};
> +
> +static struct omap_hwmod_ocp_if am43xx_l4_ls__timer8 = {
> +	.master		= &am33xx_l4_ls_hwmod,
> +	.slave		= &am43xx_timer8_hwmod,
> +	.clk		= "l4ls_gclk",
> +	.user		= OCP_USER_MPU,
> +};
> +
> +static struct omap_hwmod_ocp_if am43xx_l4_ls__timer9 = {
> +	.master		= &am33xx_l4_ls_hwmod,
> +	.slave		= &am43xx_timer9_hwmod,
> +	.clk		= "l4ls_gclk",
> +	.user		= OCP_USER_MPU,
> +};
> +
> +static struct omap_hwmod_ocp_if am43xx_l4_ls__timer10 = {
> +	.master		= &am33xx_l4_ls_hwmod,
> +	.slave		= &am43xx_timer10_hwmod,
> +	.clk		= "l4ls_gclk",
> +	.user		= OCP_USER_MPU,
> +};
> +
> +static struct omap_hwmod_ocp_if am43xx_l4_ls__timer11 = {
> +	.master		= &am33xx_l4_ls_hwmod,
> +	.slave		= &am43xx_timer11_hwmod,
> +	.clk		= "l4ls_gclk",
> +	.user		= OCP_USER_MPU,
> +};
> +
> +static struct omap_hwmod_ocp_if am43xx_l4_ls__epwmss3 = {
> +	.master		= &am33xx_l4_ls_hwmod,
> +	.slave		= &am43xx_epwmss3_hwmod,
> +	.clk		= "l4ls_gclk",
> +	.user		= OCP_USER_MPU,
> +};
> +
> +static struct omap_hwmod_ocp_if am43xx_epwmss3__ehrpwm3 = {
> +	.master		= &am43xx_epwmss3_hwmod,
> +	.slave		= &am43xx_ehrpwm3_hwmod,
> +	.clk		= "l4ls_gclk",
> +	.user		= OCP_USER_MPU,
> +};
> +
> +static struct omap_hwmod_ocp_if am43xx_l4_ls__epwmss4 = {
> +	.master		= &am33xx_l4_ls_hwmod,
> +	.slave		= &am43xx_epwmss4_hwmod,
> +	.clk		= "l4ls_gclk",
> +	.user		= OCP_USER_MPU,
> +};
> +
> +static struct omap_hwmod_ocp_if am43xx_epwmss4__ehrpwm4 = {
> +	.master		= &am43xx_epwmss4_hwmod,
> +	.slave		= &am43xx_ehrpwm4_hwmod,
> +	.clk		= "l4ls_gclk",
> +	.user		= OCP_USER_MPU,
> +};
> +
> +static struct omap_hwmod_ocp_if am43xx_l4_ls__epwmss5 = {
> +	.master		= &am33xx_l4_ls_hwmod,
> +	.slave		= &am43xx_epwmss5_hwmod,
> +	.clk		= "l4ls_gclk",
> +	.user		= OCP_USER_MPU,
> +};
> +
> +static struct omap_hwmod_ocp_if am43xx_epwmss5__ehrpwm5 = {
> +	.master		= &am43xx_epwmss5_hwmod,
> +	.slave		= &am43xx_ehrpwm5_hwmod,
> +	.clk		= "l4ls_gclk",
> +	.user		= OCP_USER_MPU,
> +};
> +
> +static struct omap_hwmod_ocp_if am43xx_l4_ls__mcspi2 = {
> +	.master		= &am33xx_l4_ls_hwmod,
> +	.slave		= &am43xx_spi2_hwmod,
> +	.clk		= "l4ls_gclk",
> +	.user		= OCP_USER_MPU,
> +};
> +
> +static struct omap_hwmod_ocp_if am43xx_l4_ls__mcspi3 = {
> +	.master		= &am33xx_l4_ls_hwmod,
> +	.slave		= &am43xx_spi3_hwmod,
> +	.clk		= "l4ls_gclk",
> +	.user		= OCP_USER_MPU,
> +};
> +
> +static struct omap_hwmod_ocp_if am43xx_l4_ls__mcspi4 = {
> +	.master		= &am33xx_l4_ls_hwmod,
> +	.slave		= &am43xx_spi4_hwmod,
> +	.clk		= "l4ls_gclk",
> +	.user		= OCP_USER_MPU,
> +};
> +
> +static struct omap_hwmod_ocp_if am43xx_l4_ls__gpio4 = {
> +	.master		= &am33xx_l4_ls_hwmod,
> +	.slave		= &am43xx_gpio4_hwmod,
> +	.clk		= "l4ls_gclk",
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +static struct omap_hwmod_ocp_if am43xx_l4_ls__gpio5 = {
> +	.master		= &am33xx_l4_ls_hwmod,
> +	.slave		= &am43xx_gpio5_hwmod,
> +	.clk		= "l4ls_gclk",
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +static struct omap_hwmod_ocp_if am43xx_l3_main__pruss = {
> +	.master		= &am33xx_l3_main_hwmod,
> +	.slave		= &am33xx_pruss_hwmod,
> +	.clk		= "dpll_core_m4_ck",
> +	.user		= OCP_USER_MPU,
> +};
> +
>  #define CLKCTRL(oh, clkctrl) ((oh).prcm.omap4.clkctrl_offs = (clkctrl))
>  
>  static void am43xx_hwmod_clkctrl(void)
> @@ -2591,6 +2932,27 @@ static void am33xx_hwmod_ocpif_clk(void)
>  	am33xx_gpio0_hwmod.main_clk = AM33XX_L4_WKUP_OCPIF_CLK;
>  }
>  
> +static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
> +	&am33xx_l4_wkup__synctimer,
> +	&am43xx_l4_ls__timer8,
> +	&am43xx_l4_ls__timer9,
> +	&am43xx_l4_ls__timer10,
> +	&am43xx_l4_ls__timer11,
> +	&am43xx_l4_ls__epwmss3,
> +	&am43xx_epwmss3__ehrpwm3,
> +	&am43xx_l4_ls__epwmss4,
> +	&am43xx_epwmss4__ehrpwm4,
> +	&am43xx_l4_ls__epwmss5,
> +	&am43xx_epwmss5__ehrpwm5,
> +	&am43xx_l4_ls__mcspi2,
> +	&am43xx_l4_ls__mcspi3,
> +	&am43xx_l4_ls__mcspi4,
> +	&am43xx_l4_ls__gpio4,
> +	&am43xx_l4_ls__gpio5,
> +	&am43xx_l3_main__pruss,
> +	NULL,
> +};
> +
>  static struct omap_hwmod_ocp_if *am33xx_hwmod_ocp_ifs[] __initdata = {
>  	&am33xx_l3_main__emif,
>  	&am33xx_l4_hs__pruss,
> @@ -2702,6 +3064,6 @@ int __init am33xx_hwmod_init(void)
>  
>  	if (soc_is_am33xx())
>  		return omap_hwmod_register_links(am33xx_hwmod_ocp_ifs);
> -
> -	return 0;
> +	else
> +		return omap_hwmod_register_links(am43xx_hwmod_ocp_ifs);
>  }
> 
