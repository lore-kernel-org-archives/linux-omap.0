From: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Subject: Re: [PATCH] ARM: dra7xx: hwmod: drop .modulemode from pcie1/2 hwmods
Date: Thu, 12 Feb 2015 16:35:44 +0800
Message-ID: <54DC65E0.7090206@linaro.org>
References: <1422978684-4826-1-git-send-email-grygorii.strashko@linaro.org> <54D874E9.1040302@ti.com> <54D88BB3.4060104@linaro.org> <54D8B515.201@ti.com> <54D8C9C3.5090500@linaro.org> <54DC4B99.8070009@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:40036 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755223AbbBLIft (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Feb 2015 03:35:49 -0500
Received: by pdev10 with SMTP id v10so10478037pde.7
        for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2015 00:35:49 -0800 (PST)
In-Reply-To: <54DC4B99.8070009@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org
Cc: sumit.semwal@linaro.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>

On 02/12/2015 02:43 PM, Kishon Vijay Abraham I wrote:
> On Monday 09 February 2015 08:22 PM, Grygorii.Strashko@linaro.org wro=
te:
>> On 02/09/2015 09:24 PM, Kishon Vijay Abraham I wrote:
>>> Hi,
>>>
>>> On Monday 09 February 2015 03:58 PM, Grygorii.Strashko@linaro.org w=
rote:
>>>> Hi Kishon,
>>>> On 02/09/2015 04:50 PM, Kishon Vijay Abraham I wrote:
>>>>> On Tuesday 03 February 2015 09:21 PM, grygorii.strashko@linaro.or=
g
>>>>> wrote:
>>>>>> From: Grygorii Strashko <grygorii.strashko@linaro.org>
>>>>>>
>>>>>> Now DRA7xx pcie1/2 hwmods define PRCM configuration as following=
:
>>>>>>     .clkctrl_offs =3D DRA7XX_CM_PCIE_CLKSTCTRL_OFFSET,
>>>>>>     .rstctrl_offs =3D DRA7XX_RM_L3INIT_RSTCTRL_OFFSET,
>>>>>>     .modulemode   =3D MODULEMODE_SWCTRL,
>>>>>> which is completely wrong because DRA7XX_CM_PCIE_CLKSTCTRL_OFFSE=
T
>>>>>> is clockdomain ctrl register and NOT module ctrl register.
>>>>>> And they have diffrent allowed values for bits[0,1]:
>>>>>> CLKTRCTRL=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=
=80=89=E2=80=89=E2=80=89MODULEMODE=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=
=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=
=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=
=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=
=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89
>>>>>> 0x0:=E2=80=89NO_SLEEP=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=
0x0:=E2=80=89Module=E2=80=89is=E2=80=89disabled=E2=80=89by=E2=80=89SW.=E2=
=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=
=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89
>>>>>> 0x1:=E2=80=89SW_SLEEP=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=
0x1:=E2=80=89Module=E2=80=89is=E2=80=89managed=E2=80=89automatically=E2=
=80=89by=E2=80=89HW=E2=80=89=E2=80=89
>>>>>> 0x2:=E2=80=89SW_WKUP=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=
=E2=80=890x2:=E2=80=89Module=E2=80=89is=E2=80=89explicitly=E2=80=89enab=
led.=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=
=89=E2=80=89=E2=80=89
>>>>>> 0x3:=E2=80=89HW_AUTO=E2=80=89=E2=80=89=E2=80=89=E2=80=89=E2=80=89=
=E2=80=890x3:=E2=80=89Reserved=E2=80=89=E2=80=89
>>>>>>
>>>>>> As result, following message can be seen during suspend:
>>>>>>     "omap_hwmod: pcie1: _wait_target_disable failed"
>>>>>>
>>>>>> Fix it by removing .modulemode from pcie1/2 hwmods and, in that
>>>>>> way, prevent clockdomain ctrl register writing from HWMOD core.
>>>>>
>>>>> Looks correct except for one change.
>>>>>
>>>>> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>>>>
>>>>>> Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
>>>>>> ---
>>>>>>
>>>>>> More over, it looks like pcie1/2 hwmods are fake and have to be
>>>>>> dropped at all.
>>>>>> The real HWMODs are PCIESS1/2.
>>>>>
>>>>> Not sure I get this. You mean "dra7xx_pcie1_hwmod" should be
>>>>> replaced with
>>>>> "dra7xx_pciess1_hwmod"? Or you mean an entire new hwmod is missin=
g?
>>>>>
>>>>> Please note we still have to enable the clock domain and main clo=
ck.
>>>>> We've also
>>>>> purposefully omitted sysconfig from hwmod data since pcie reset
>>>>> (RM_PCIESS_RSTCTRL) should be done before accessing the syconfig
>>>>> register and
>>>>> the infrastructure for that is currently not present.
>>>>
>>>> What I'm trying to say is that now PM control data mixed between
>>>> "pcieX" and "pcieX-phy" hwmods.
>>>> After this patch "pcieX" hwmods will actually do nothing (I assume
>>>> that "pciex-phy" will be
>>>> enabled before "pcieX"), and probably can be removed if "pcie_clkd=
m"
>>>> could be attached to "pcieX-phy" hwmod
>>>> instead.
>>>>
>>>> More over, now, "pcie_clkdm" is connected to "pcieX" hwmod while
>>>> MODULEMODE register is controlled
>>>> by "pciex-phy" hwmod, so when pciess is going to be enabled the
>>>> "l3init_clkdm" will be waken-up by
>>>> hwmode core and not "pcie_clkdm" - as I can remember this is not g=
ood
>>>> (we should alway wake-up clockdomain
>>>>   and keep it in SWSUP mode while changing MODULEMODE and SYSC
>>>> registers).
>>>>
>>>> static struct omap_hwmod dra7xx_pcie1_hwmod =3D {
>>>>     .name        =3D "pcie1",
>>>>     .class        =3D &dra7xx_pcie_hwmod_class,
>>>>     .clkdm_name    =3D "pcie_clkdm",
>>>>     .main_clk    =3D "l4_root_clk_div",
>>>>
>>>> static struct omap_hwmod dra7xx_pcie1_phy_hwmod =3D {
>>>>     .name        =3D "pcie1-phy",
>>>>     .class        =3D &dra7xx_pcie_phy_hwmod_class,
>>>>     .clkdm_name    =3D "l3init_clkdm",
>>>>     .main_clk    =3D "l4_root_clk_div",
>>>>
>>>> So, in my opinion, some rework may be needed here.
>>>> Am I right?
>>>
>>> you are right. We should have a single hwmod like dra7xx_pciess1_hw=
mod
>>> whose
>>> clkdm should be "pcie_clkdm" and whose clkctrl_offs should be
>>> DRA7XX_CM_L3INIT_PCIESS1_CLKCTRL_OFFSET (for controlling MODULEMODE=
).
>>> PCIE PHY
>>> shouldn't have a hwmod entry at all.
>>>
>>> Thanks
>>> Kishon
>>>
>>
>> Could this patch be applied any way? It fixes real issue for me.
>
> A proper fix should look something like below IMO
>

Looks good for me and seems working.

>
>  From 1c177d37ac46885a4dc17bacec33071ac23c56da Mon Sep 17 00:00:00 20=
01
> From: Kishon Vijay Abraham I <kishon@ti.com>
> Date: Thu, 12 Feb 2015 11:55:08 +0530
> Subject: [RFC PATCH] ARM: DRA7: hwmod_data: Fix hwmod data for pcie
>
> Fixed hwmod data for pcie by having the correct module mode offset.
> Previously this module mode offset was part of pcie PHY which was wro=
ng.
> Now this module mode offset was moved to pcie hwmod and removed the
> hwmod data
> for pcie phy. While at that renamed pcie_hwmod to pciess_hwmod in ord=
er
> to match with the name given in TRM.
>
> This helps to get rid of the following warning
> "omap_hwmod: pcie1: _wait_target_disable failed"
>
> [Grygorii.Strashko@linaro.org: Found the issue that actually caused
>   "omap_hwmod: pcie1: _wait_target_disable failed"]
> Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> this patch was created on 3.14 kernel after applying reset framework
> patches
> required for testing PCIe. I can port this to mainline if this patch =
is
> fine.
>
>   arch/arm/boot/dts/dra7.dtsi               |    2 -
>   arch/arm/mach-omap2/omap_hwmod_7xx_data.c |  107
> +++++++----------------------
>   2 files changed, 26 insertions(+), 83 deletions(-)
>
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dts=
i
> index a4b1337..d7a1ff9 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -1364,7 +1364,6 @@
>                             "wkupclk", "refclk",
>                             "div-clk", "phy-div";
>                   #phy-cells =3D <0>;
> -                ti,hwmods =3D "pcie1-phy";
>               };
>
>               pcie2_phy: pciephy@4a095000 {
> @@ -1383,7 +1382,6 @@
>                             "wkupclk", "refclk",
>                             "div-clk", "phy-div";
>                   #phy-cells =3D <0>;
> -                ti,hwmods =3D "pcie2-phy";
>               };
>           };
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> index 5ae755c..56f2c58 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> @@ -1968,25 +1968,26 @@ static struct omap_hwmod dra7xx_ocp2scp3_hwmo=
d =3D {
>    *
>    */
>
> -static struct omap_hwmod_class dra7xx_pcie_hwmod_class =3D {
> +static struct omap_hwmod_class dra7xx_pciess_hwmod_class =3D {
>       .name    =3D "pcie",
>   };
>
>   /* pcie1 */
> -static struct omap_hwmod_rst_info dra7xx_pcie1_resets[] =3D {
> +static struct omap_hwmod_rst_info dra7xx_pciess1_resets[] =3D {
>       { .name =3D "pcie", .rst_shift =3D 0 },
>   };
>
> -static struct omap_hwmod dra7xx_pcie1_hwmod =3D {
> +static struct omap_hwmod dra7xx_pciess1_hwmod =3D {
>       .name        =3D "pcie1",
> -    .class        =3D &dra7xx_pcie_hwmod_class,
> +    .class        =3D &dra7xx_pciess_hwmod_class,
>       .clkdm_name    =3D "pcie_clkdm",
> -    .rst_lines    =3D dra7xx_pcie1_resets,
> -    .rst_lines_cnt    =3D ARRAY_SIZE(dra7xx_pcie1_resets),
> +    .rst_lines    =3D dra7xx_pciess1_resets,
> +    .rst_lines_cnt    =3D ARRAY_SIZE(dra7xx_pciess1_resets),
>       .main_clk    =3D "l4_root_clk_div",
>       .prcm =3D {
>           .omap4 =3D {
> -            .clkctrl_offs    =3D DRA7XX_CM_PCIE_CLKSTCTRL_OFFSET,
> +            .clkctrl_offs =3D DRA7XX_CM_L3INIT_PCIESS1_CLKCTRL_OFFSE=
T,
> +            .context_offs =3D DRA7XX_RM_L3INIT_PCIESS1_CONTEXT_OFFSE=
T,
>               .rstctrl_offs    =3D DRA7XX_RM_L3INIT_RSTCTRL_OFFSET,
>               .modulemode    =3D MODULEMODE_SWCTRL,
>           },
> @@ -1994,60 +1995,22 @@ static struct omap_hwmod dra7xx_pcie1_hwmod =3D=
 {
>   };
>
>   /* pcie2 */
> -static struct omap_hwmod_rst_info dra7xx_pcie2_resets[] =3D {
> +static struct omap_hwmod_rst_info dra7xx_pciess2_resets[] =3D {
>       { .name =3D "pcie", .rst_shift =3D 1 },
>   };
>
> -static struct omap_hwmod dra7xx_pcie2_hwmod =3D {
> +static struct omap_hwmod dra7xx_pciess2_hwmod =3D {
>       .name        =3D "pcie2",
> -    .class        =3D &dra7xx_pcie_hwmod_class,
> +    .class        =3D &dra7xx_pciess_hwmod_class,
>       .clkdm_name    =3D "pcie_clkdm",
> -    .rst_lines    =3D dra7xx_pcie2_resets,
> -    .rst_lines_cnt    =3D ARRAY_SIZE(dra7xx_pcie2_resets),
> -    .main_clk    =3D "l4_root_clk_div",
> -    .prcm =3D {
> -        .omap4 =3D {
> -            .clkctrl_offs =3D DRA7XX_CM_PCIE_CLKSTCTRL_OFFSET,
> -            .rstctrl_offs =3D DRA7XX_RM_L3INIT_RSTCTRL_OFFSET,
> -            .modulemode   =3D MODULEMODE_SWCTRL,
> -        },
> -    },
> -};
> -
> -/*
> - * 'PCIE PHY' class
> - *
> - */
> -
> -static struct omap_hwmod_class dra7xx_pcie_phy_hwmod_class =3D {
> -    .name    =3D "pcie-phy",
> -};
> -
> -/* pcie1 phy */
> -static struct omap_hwmod dra7xx_pcie1_phy_hwmod =3D {
> -    .name        =3D "pcie1-phy",
> -    .class        =3D &dra7xx_pcie_phy_hwmod_class,
> -    .clkdm_name    =3D "l3init_clkdm",
> -    .main_clk    =3D "l4_root_clk_div",
> -    .prcm =3D {
> -        .omap4 =3D {
> -            .clkctrl_offs =3D DRA7XX_CM_L3INIT_PCIESS1_CLKCTRL_OFFSE=
T,
> -            .context_offs =3D DRA7XX_RM_L3INIT_PCIESS1_CONTEXT_OFFSE=
T,
> -            .modulemode   =3D MODULEMODE_SWCTRL,
> -        },
> -    },
> -};
> -
> -/* pcie2 phy */
> -static struct omap_hwmod dra7xx_pcie2_phy_hwmod =3D {
> -    .name        =3D "pcie2-phy",
> -    .class        =3D &dra7xx_pcie_phy_hwmod_class,
> -    .clkdm_name    =3D "l3init_clkdm",
> +    .rst_lines    =3D dra7xx_pciess2_resets,
> +    .rst_lines_cnt    =3D ARRAY_SIZE(dra7xx_pciess2_resets),
>       .main_clk    =3D "l4_root_clk_div",
>       .prcm =3D {
>           .omap4 =3D {
>               .clkctrl_offs =3D DRA7XX_CM_L3INIT_PCIESS2_CLKCTRL_OFFS=
ET,
>               .context_offs =3D DRA7XX_RM_L3INIT_PCIESS2_CONTEXT_OFFS=
ET,
> +            .rstctrl_offs =3D DRA7XX_RM_L3INIT_RSTCTRL_OFFSET,
>               .modulemode   =3D MODULEMODE_SWCTRL,
>           },
>       },
> @@ -3621,49 +3584,33 @@ static struct omap_hwmod_ocp_if
> dra7xx_l4_cfg__ocp2scp3 =3D {
>   };
>
>   /* l3_main_1 -> pcie1 */
> -static struct omap_hwmod_ocp_if dra7xx_l3_main_1__pcie1 =3D {
> +static struct omap_hwmod_ocp_if dra7xx_l3_main_1__pciess1 =3D {
>       .master        =3D &dra7xx_l3_main_1_hwmod,
> -    .slave        =3D &dra7xx_pcie1_hwmod,
> +    .slave        =3D &dra7xx_pciess1_hwmod,
>       .clk        =3D "l3_iclk_div",
>       .user        =3D OCP_USER_MPU | OCP_USER_SDMA,
>   };
>
>   /* l4_cfg -> pcie1 */
> -static struct omap_hwmod_ocp_if dra7xx_l4_cfg__pcie1 =3D {
> +static struct omap_hwmod_ocp_if dra7xx_l4_cfg__pciess1 =3D {
>       .master        =3D &dra7xx_l4_cfg_hwmod,
> -    .slave        =3D &dra7xx_pcie1_hwmod,
> +    .slave        =3D &dra7xx_pciess1_hwmod,
>       .clk        =3D "l4_root_clk_div",
>       .user        =3D OCP_USER_MPU | OCP_USER_SDMA,
>   };
>
>   /* l3_main_1 -> pcie2 */
> -static struct omap_hwmod_ocp_if dra7xx_l3_main_1__pcie2 =3D {
> +static struct omap_hwmod_ocp_if dra7xx_l3_main_1__pciess2 =3D {
>       .master        =3D &dra7xx_l3_main_1_hwmod,
> -    .slave        =3D &dra7xx_pcie2_hwmod,
> +    .slave        =3D &dra7xx_pciess2_hwmod,
>       .clk        =3D "l3_iclk_div",
>       .user        =3D OCP_USER_MPU | OCP_USER_SDMA,
>   };
>
>   /* l4_cfg -> pcie2 */
> -static struct omap_hwmod_ocp_if dra7xx_l4_cfg__pcie2 =3D {
> -    .master        =3D &dra7xx_l4_cfg_hwmod,
> -    .slave        =3D &dra7xx_pcie2_hwmod,
> -    .clk        =3D "l4_root_clk_div",
> -    .user        =3D OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_cfg -> pcie1 phy */
> -static struct omap_hwmod_ocp_if dra7xx_l4_cfg__pcie1_phy =3D {
> -    .master        =3D &dra7xx_l4_cfg_hwmod,
> -    .slave        =3D &dra7xx_pcie1_phy_hwmod,
> -    .clk        =3D "l4_root_clk_div",
> -    .user        =3D OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
> -/* l4_cfg -> pcie2 phy */
> -static struct omap_hwmod_ocp_if dra7xx_l4_cfg__pcie2_phy =3D {
> +static struct omap_hwmod_ocp_if dra7xx_l4_cfg__pciess2 =3D {
>       .master        =3D &dra7xx_l4_cfg_hwmod,
> -    .slave        =3D &dra7xx_pcie2_phy_hwmod,
> +    .slave        =3D &dra7xx_pciess2_hwmod,
>       .clk        =3D "l4_root_clk_div",
>       .user        =3D OCP_USER_MPU | OCP_USER_SDMA,
>   };
> @@ -4153,12 +4100,10 @@ static struct omap_hwmod_ocp_if
> *dra7xx_hwmod_ocp_ifs[] __initdata =3D {
>       &dra7xx_l4_cfg__mpu,
>       &dra7xx_l4_cfg__ocp2scp1,
>       &dra7xx_l4_cfg__ocp2scp3,
> -    &dra7xx_l3_main_1__pcie1,
> -    &dra7xx_l4_cfg__pcie1,
> -    &dra7xx_l3_main_1__pcie2,
> -    &dra7xx_l4_cfg__pcie2,
> -    &dra7xx_l4_cfg__pcie1_phy,
> -    &dra7xx_l4_cfg__pcie2_phy,
> +    &dra7xx_l3_main_1__pciess1,
> +    &dra7xx_l4_cfg__pciess1,
> +    &dra7xx_l3_main_1__pciess2,
> +    &dra7xx_l4_cfg__pciess2,
>       &dra7xx_l4_cfg__pruss1, /* AM57xx only */
>       &dra7xx_l4_cfg__pruss2, /* AM57xx only */
>       &dra7xx_l3_main_1__qspi,


--=20
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
