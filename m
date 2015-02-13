From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] ARM: dra7xx: hwmod: drop .modulemode from pcie1/2 hwmods
Date: Fri, 13 Feb 2015 19:45:37 +0530
Message-ID: <54DE0709.7080208@ti.com>
References: <1422978684-4826-1-git-send-email-grygorii.strashko@linaro.org> <54D874E9.1040302@ti.com> <54D88BB3.4060104@linaro.org> <54D8B515.201@ti.com> <54D8C9C3.5090500@linaro.org> <54DC4B99.8070009@ti.com> <54DC65E0.7090206@linaro.org> <alpine.DEB.2.02.1502121507480.3767@utopia.booyaka.com> <54DCD3C3.3010008@linaro.org> <alpine.DEB.2.02.1502121627210.3767@utopia.booyaka.com> <alpine.DEB.2.02.1502121644570.3767@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48764 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752446AbbBMOQJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Feb 2015 09:16:09 -0500
In-Reply-To: <alpine.DEB.2.02.1502121644570.3767@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, sumit.semwal@linaro.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>

Hi Paul,

On Thursday 12 February 2015 10:15 PM, Paul Walmsley wrote:
> On Thu, 12 Feb 2015, Paul Walmsley wrote:
>
>> On Fri, 13 Feb 2015, Grygorii.Strashko@linaro.org wrote:
>>
>>> On 02/12/2015 11:08 PM, Paul Walmsley wrote:
>>>> Thanks guys.
>>>>
>>>> On Thu, 12 Feb 2015, Grygorii.Strashko@linaro.org wrote:
>>>>
>>>>> Looks good for me and seems working.
>>>>
>>>> Grygorii, can I add your Acked-by?
>>>>
>>>>
>>>> - Paul
>>>>
>>>
>>> There is my "Signed-off-by" :)
>>
>> OK thanks, queued for v3.20-rc.
>
> Actually, could you guys test the updated patch?  It had to be changed to
> apply on mainline and I don't have a DRA7xx board to test.

We don't use resets used here in mainline. I'll send an updated patch for mainline.

Thanks
Kishon

>
>
> - Paul
>
>  From 0f9a1ee083a7adbb2c867d5c8d25d7e5fcb38b07 Mon Sep 17 00:00:00 2001
> From: Kishon Vijay Abraham I <kishon@ti.com>
> Date: Thu, 12 Feb 2015 09:29:31 -0700
> Subject: [PATCH] ARM: DRA7: hwmod_data: Fix hwmod data for pcie
>
> Fixed hwmod data for pcie by having the correct module mode offset.
> Previously this module mode offset was part of pcie PHY which was wrong.
> Now this module mode offset was moved to pcie hwmod and removed the
> hwmod data
> for pcie phy. While at that renamed pcie_hwmod to pciess_hwmod in order
> to match with the name given in TRM.
>
> This helps to get rid of the following warning
> "omap_hwmod: pcie1: _wait_target_disable failed"
>
> [Grygorii.Strashko@linaro.org: Found the issue that actually caused
>    "omap_hwmod: pcie1: _wait_target_disable failed"]
> Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> [paul@pwsan.com: updated to apply on mainline]
> ---
>   arch/arm/boot/dts/dra7.dtsi               |   2 -
>   arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 111 ++++++++++--------------------
>   2 files changed, 35 insertions(+), 78 deletions(-)
>
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 5827fedafd43..18a904db32bb 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -1111,7 +1111,6 @@
>   					      "wkupclk", "refclk",
>   					      "div-clk", "phy-div";
>   				#phy-cells = <0>;
> -				ti,hwmods = "pcie1-phy";
>   			};
>
>   			pcie2_phy: pciephy@4a095000 {
> @@ -1130,7 +1129,6 @@
>   					      "wkupclk", "refclk",
>   					      "div-clk", "phy-div";
>   				#phy-cells = <0>;
> -				ti,hwmods = "pcie2-phy";
>   				status = "disabled";
>   			};
>   		};
> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> index e8692e7675b8..6a74a7ea8c95 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> @@ -1466,29 +1466,43 @@ static struct omap_hwmod dra7xx_ocp2scp3_hwmod = {
>    *
>    */
>
> -static struct omap_hwmod_class dra7xx_pcie_hwmod_class = {
> +static struct omap_hwmod_class dra7xx_pciess_hwmod_class = {
>   	.name	= "pcie",
>   };
>
>   /* pcie1 */
> -static struct omap_hwmod dra7xx_pcie1_hwmod = {
> +static struct omap_hwmod_rst_info dra7xx_pciess1_resets[] = {
> +	{ .name = "pcie", .rst_shift = 0 },
> +};
> +
> +static struct omap_hwmod dra7xx_pciess1_hwmod = {
>   	.name		= "pcie1",
> -	.class		= &dra7xx_pcie_hwmod_class,
> +	.class		= &dra7xx_pciess_hwmod_class,
>   	.clkdm_name	= "pcie_clkdm",
>   	.main_clk	= "l4_root_clk_div",
> +	.rst_lines	= dra7xx_pciess1_resets,
> +	.rst_lines_cnt	= ARRAY_SIZE(dra7xx_pciess1_resets),
>   	.prcm = {
>   		.omap4 = {
> -			.clkctrl_offs	= DRA7XX_CM_PCIE_CLKSTCTRL_OFFSET,
> +			.clkctrl_offs	= DRA7XX_CM_L3INIT_PCIESS1_CLKCTRL_OFFSET,
> +			.context_offs	= DRA7XX_RM_L3INIT_PCIESS1_CONTEXT_OFFSET,
>   			.modulemode	= MODULEMODE_SWCTRL,
>   		},
>   	},
>   };
>
>   /* pcie2 */
> -static struct omap_hwmod dra7xx_pcie2_hwmod = {
> +
> +static struct omap_hwmod_rst_info dra7xx_pciess2_resets[] = {
> +	{ .name = "pcie", .rst_shift = 1 },
> +};
> +
> +static struct omap_hwmod dra7xx_pciess2_hwmod = {
>   	.name		= "pcie2",
> -	.class		= &dra7xx_pcie_hwmod_class,
> +	.class		= &dra7xx_pciess_hwmod_class,
>   	.clkdm_name	= "pcie_clkdm",
> +	.rst_lines	= dra7xx_pciess2_resets,
> +	.rst_lines_cnt	= ARRAY_SIZE(dra7xx_pciess2_resets),
>   	.main_clk	= "l4_root_clk_div",
>   	.prcm = {
>   		.omap4 = {
> @@ -1498,44 +1512,7 @@ static struct omap_hwmod dra7xx_pcie2_hwmod = {
>   	},
>   };
>
> -/*
> - * 'PCIE PHY' class
> - *
> - */
>
> -static struct omap_hwmod_class dra7xx_pcie_phy_hwmod_class = {
> -	.name	= "pcie-phy",
> -};
> -
> -/* pcie1 phy */
> -static struct omap_hwmod dra7xx_pcie1_phy_hwmod = {
> -	.name		= "pcie1-phy",
> -	.class		= &dra7xx_pcie_phy_hwmod_class,
> -	.clkdm_name	= "l3init_clkdm",
> -	.main_clk	= "l4_root_clk_div",
> -	.prcm = {
> -		.omap4 = {
> -			.clkctrl_offs = DRA7XX_CM_L3INIT_PCIESS1_CLKCTRL_OFFSET,
> -			.context_offs = DRA7XX_RM_L3INIT_PCIESS1_CONTEXT_OFFSET,
> -			.modulemode   = MODULEMODE_SWCTRL,
> -		},
> -	},
> -};
> -
> -/* pcie2 phy */
> -static struct omap_hwmod dra7xx_pcie2_phy_hwmod = {
> -	.name		= "pcie2-phy",
> -	.class		= &dra7xx_pcie_phy_hwmod_class,
> -	.clkdm_name	= "l3init_clkdm",
> -	.main_clk	= "l4_root_clk_div",
> -	.prcm = {
> -		.omap4 = {
> -			.clkctrl_offs = DRA7XX_CM_L3INIT_PCIESS2_CLKCTRL_OFFSET,
> -			.context_offs = DRA7XX_RM_L3INIT_PCIESS2_CONTEXT_OFFSET,
> -			.modulemode   = MODULEMODE_SWCTRL,
> -		},
> -	},
> -};
>
>   /*
>    * 'qspi' class
> @@ -2877,50 +2854,34 @@ static struct omap_hwmod_ocp_if dra7xx_l4_cfg__ocp2scp3 = {
>   	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>   };
>
> -/* l3_main_1 -> pcie1 */
> -static struct omap_hwmod_ocp_if dra7xx_l3_main_1__pcie1 = {
> +/* l3_main_1 -> pciess1 */
> +static struct omap_hwmod_ocp_if dra7xx_l3_main_1__pciess1 = {
>   	.master		= &dra7xx_l3_main_1_hwmod,
> -	.slave		= &dra7xx_pcie1_hwmod,
> +	.slave		= &dra7xx_pciess1_hwmod,
>   	.clk		= "l3_iclk_div",
>   	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>   };
>
> -/* l4_cfg -> pcie1 */
> -static struct omap_hwmod_ocp_if dra7xx_l4_cfg__pcie1 = {
> +/* l4_cfg -> pciess1 */
> +static struct omap_hwmod_ocp_if dra7xx_l4_cfg__pciess1 = {
>   	.master		= &dra7xx_l4_cfg_hwmod,
> -	.slave		= &dra7xx_pcie1_hwmod,
> +	.slave		= &dra7xx_pciess1_hwmod,
>   	.clk		= "l4_root_clk_div",
>   	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>   };
>
> -/* l3_main_1 -> pcie2 */
> -static struct omap_hwmod_ocp_if dra7xx_l3_main_1__pcie2 = {
> +/* l3_main_1 -> pciess2 */
> +static struct omap_hwmod_ocp_if dra7xx_l3_main_1__pciess2 = {
>   	.master		= &dra7xx_l3_main_1_hwmod,
> -	.slave		= &dra7xx_pcie2_hwmod,
> +	.slave		= &dra7xx_pciess2_hwmod,
>   	.clk		= "l3_iclk_div",
>   	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>   };
>
>   /* l4_cfg -> pcie2 */
> -static struct omap_hwmod_ocp_if dra7xx_l4_cfg__pcie2 = {
> -	.master		= &dra7xx_l4_cfg_hwmod,
> -	.slave		= &dra7xx_pcie2_hwmod,
> -	.clk		= "l4_root_clk_div",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_cfg -> pcie1 phy */
> -static struct omap_hwmod_ocp_if dra7xx_l4_cfg__pcie1_phy = {
> -	.master		= &dra7xx_l4_cfg_hwmod,
> -	.slave		= &dra7xx_pcie1_phy_hwmod,
> -	.clk		= "l4_root_clk_div",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_cfg -> pcie2 phy */
> -static struct omap_hwmod_ocp_if dra7xx_l4_cfg__pcie2_phy = {
> +static struct omap_hwmod_ocp_if dra7xx_l4_cfg__pciess2 = {
>   	.master		= &dra7xx_l4_cfg_hwmod,
> -	.slave		= &dra7xx_pcie2_phy_hwmod,
> +	.slave		= &dra7xx_pciess2_hwmod,
>   	.clk		= "l4_root_clk_div",
>   	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>   };
> @@ -3327,12 +3288,10 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
>   	&dra7xx_l4_cfg__mpu,
>   	&dra7xx_l4_cfg__ocp2scp1,
>   	&dra7xx_l4_cfg__ocp2scp3,
> -	&dra7xx_l3_main_1__pcie1,
> -	&dra7xx_l4_cfg__pcie1,
> -	&dra7xx_l3_main_1__pcie2,
> -	&dra7xx_l4_cfg__pcie2,
> -	&dra7xx_l4_cfg__pcie1_phy,
> -	&dra7xx_l4_cfg__pcie2_phy,
> +	&dra7xx_l3_main_1__pciess1,
> +	&dra7xx_l4_cfg__pciess1,
> +	&dra7xx_l3_main_1__pciess2,
> +	&dra7xx_l4_cfg__pciess2,
>   	&dra7xx_l3_main_1__qspi,
>   	&dra7xx_l4_per3__rtcss,
>   	&dra7xx_l4_cfg__sata,
>
