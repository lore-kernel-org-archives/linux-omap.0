From: kishon <a0393678@ti.com>
Subject: Re: [PATCH 1/7] [RFC] OMAP: MCBSP: hwmod database for 2xxx devices
Date: Wed, 06 Oct 2010 16:02:46 +0530
Message-ID: <4CAC504E.3040708@ti.com>
References: <1286296662-7639-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38771 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758636Ab0JFKea (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Oct 2010 06:34:30 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o96AYQej015876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 6 Oct 2010 05:34:29 -0500
In-Reply-To: <1286296662-7639-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kamat, Nishant" <nskamat@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "Basak, Partha" <p-basak2@ti.com>

Hi,

Next version of this patch series will have proper subject in it.

-Kishon

On Tuesday 05 October 2010 10:07 PM, ABRAHAM, KISHON VIJAY wrote:
> From: Charulatha V<charu@ti.com>
>
> Signed-off-by: Kishon Vijay Abraham I<kishon@ti.com>
> Signed-off-by: Charulatha V<charu@ti.com>
> Signed-off-by: Shubhrajyoti D<shubhrajyoti@ti.com>
> Cc: Partha Basak<p-basak2@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod_2420_data.c |  125 +++++++++++
>   arch/arm/mach-omap2/omap_hwmod_2430_data.c |  313 ++++++++++++++++++++++++++++
>   2 files changed, 438 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> index adf6e36..289ef86 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> @@ -36,6 +36,8 @@ static struct omap_hwmod omap2420_iva_hwmod;
>   static struct omap_hwmod omap2420_l3_main_hwmod;
>   static struct omap_hwmod omap2420_l4_core_hwmod;
>   static struct omap_hwmod omap2420_wd_timer2_hwmod;
> +static struct omap_hwmod omap2420_mcbsp1_hwmod;
> +static struct omap_hwmod omap2420_mcbsp2_hwmod;
>
>   /* L3 ->  L4_CORE interface */
>   static struct omap_hwmod_ocp_if omap2420_l3_main__l4_core = {
> @@ -418,6 +420,127 @@ static struct omap_hwmod omap2420_uart3_hwmod = {
>          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
>   };
>
> +/*
> + * 'mcbsp' class
> + * multi channel buffered serial port controller
> + */
> +
> +static struct omap_hwmod_class omap2420_mcbsp_hwmod_class = {
> +       .name = "mcbsp",
> +};
> +
> +/* mcbsp1 */
> +static struct omap_hwmod_irq_info omap2420_mcbsp1_irqs[] = {
> +       { .name = "tx", .irq = 59 },
> +       { .name = "rx", .irq = 60 },
> +};
> +
> +static struct omap_hwmod_dma_info omap2420_mcbsp1_sdma_chs[] = {
> +       { .name = "rx", .dma_req = 31 },
> +       { .name = "tx", .dma_req = 30 },
> +};
> +
> +static struct omap_hwmod_addr_space omap2420_mcbsp1_addrs[] = {
> +       {
> +               .pa_start       = 0x48074000,
> +               .pa_end         = 0x480740ff,
> +               .flags          = ADDR_TYPE_RT
> +       },
> +};
> +
> +/* l4_core ->  mcbsp1 */
> +static struct omap_hwmod_ocp_if omap2420_l4_core__mcbsp1 = {
> +       .master         =&omap2420_l4_core_hwmod,
> +       .slave          =&omap2420_mcbsp1_hwmod,
> +       .clk            = "mcbsp1_ick",
> +       .addr           = omap2420_mcbsp1_addrs,
> +       .addr_cnt       = ARRAY_SIZE(omap2420_mcbsp1_addrs),
> +       .user           = OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* mcbsp1 slave ports */
> +static struct omap_hwmod_ocp_if *omap2420_mcbsp1_slaves[] = {
> +&omap2420_l4_core__mcbsp1,
> +};
> +
> +static struct omap_hwmod omap2420_mcbsp1_hwmod = {
> +       .name           = "mcbsp1",
> +       .class          =&omap2420_mcbsp_hwmod_class,
> +       .mpu_irqs       = omap2420_mcbsp1_irqs,
> +       .mpu_irqs_cnt   = ARRAY_SIZE(omap2420_mcbsp1_irqs),
> +       .sdma_reqs      = omap2420_mcbsp1_sdma_chs,
> +       .sdma_reqs_cnt  = ARRAY_SIZE(omap2420_mcbsp1_sdma_chs),
> +       .main_clk       = "mcbsp1_fck",
> +       .prcm           = {
> +               .omap2 = {
> +                       .prcm_reg_id = 1,
> +                       .module_bit = OMAP24XX_EN_MCBSP1_SHIFT,
> +                       .module_offs = CORE_MOD,
> +                       .idlest_reg_id = 1,
> +                       .idlest_idle_bit = OMAP24XX_EN_MCBSP1_SHIFT,
> +               },
> +       },
> +       .slaves         = omap2420_mcbsp1_slaves,
> +       .slaves_cnt     = ARRAY_SIZE(omap2420_mcbsp1_slaves),
> +       .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
> +};
> +
> +/* mcbsp2 */
> +static struct omap_hwmod_irq_info omap2420_mcbsp2_irqs[] = {
> +       { .name = "tx", .irq = 62 },
> +       { .name = "rx", .irq = 63 },
> +};
> +
> +static struct omap_hwmod_dma_info omap2420_mcbsp2_sdma_chs[] = {
> +       { .name = "rx", .dma_req = 33 },
> +       { .name = "tx", .dma_req = 32 },
> +};
> +
> +static struct omap_hwmod_addr_space omap2420_mcbsp2_addrs[] = {
> +       {
> +               .pa_start       = 0x48076000,
> +               .pa_end         = 0x480760ff,
> +               .flags          = ADDR_TYPE_RT
> +       },
> +};
> +
> +/* l4_core ->  mcbsp2 */
> +static struct omap_hwmod_ocp_if omap2420_l4_core__mcbsp2 = {
> +       .master         =&omap2420_l4_core_hwmod,
> +       .slave          =&omap2420_mcbsp2_hwmod,
> +       .clk            = "mcbsp2_ick",
> +       .addr           = omap2420_mcbsp2_addrs,
> +       .addr_cnt       = ARRAY_SIZE(omap2420_mcbsp2_addrs),
> +       .user           = OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* mcbsp2 slave ports */
> +static struct omap_hwmod_ocp_if *omap2420_mcbsp2_slaves[] = {
> +&omap2420_l4_core__mcbsp2,
> +};
> +
> +static struct omap_hwmod omap2420_mcbsp2_hwmod = {
> +       .name           = "mcbsp2",
> +       .class          =&omap2420_mcbsp_hwmod_class,
> +       .mpu_irqs       = omap2420_mcbsp2_irqs,
> +       .mpu_irqs_cnt   = ARRAY_SIZE(omap2420_mcbsp2_irqs),
> +       .sdma_reqs      = omap2420_mcbsp2_sdma_chs,
> +       .sdma_reqs_cnt  = ARRAY_SIZE(omap2420_mcbsp2_sdma_chs),
> +       .main_clk       = "mcbsp2_fck",
> +       .prcm           = {
> +               .omap2 = {
> +                       .prcm_reg_id = 1,
> +                       .module_bit = OMAP24XX_EN_MCBSP2_SHIFT,
> +                       .module_offs = CORE_MOD,
> +                       .idlest_reg_id = 1,
> +                       .idlest_idle_bit = OMAP24XX_EN_MCBSP2_SHIFT,
> +               },
> +       },
> +       .slaves         = omap2420_mcbsp2_slaves,
> +       .slaves_cnt     = ARRAY_SIZE(omap2420_mcbsp2_slaves),
> +       .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
> +};
> +
>   static __initdata struct omap_hwmod *omap2420_hwmods[] = {
>          &omap2420_l3_main_hwmod,
>          &omap2420_l4_core_hwmod,
> @@ -428,6 +551,8 @@ static __initdata struct omap_hwmod *omap2420_hwmods[] = {
>          &omap2420_uart1_hwmod,
>          &omap2420_uart2_hwmod,
>          &omap2420_uart3_hwmod,
> +&omap2420_mcbsp1_hwmod,
> +&omap2420_mcbsp2_hwmod,
>          NULL,
>   };
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> index 12d939e..5eb1fe4 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> @@ -36,6 +36,11 @@ static struct omap_hwmod omap2430_iva_hwmod;
>   static struct omap_hwmod omap2430_l3_main_hwmod;
>   static struct omap_hwmod omap2430_l4_core_hwmod;
>   static struct omap_hwmod omap2430_wd_timer2_hwmod;
> +static struct omap_hwmod omap2430_mcbsp1_hwmod;
> +static struct omap_hwmod omap2430_mcbsp2_hwmod;
> +static struct omap_hwmod omap2430_mcbsp3_hwmod;
> +static struct omap_hwmod omap2430_mcbsp4_hwmod;
> +static struct omap_hwmod omap2430_mcbsp5_hwmod;
>
>   /* L3 ->  L4_CORE interface */
>   static struct omap_hwmod_ocp_if omap2430_l3_main__l4_core = {
> @@ -418,6 +423,309 @@ static struct omap_hwmod omap2430_uart3_hwmod = {
>          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
>   };
>
> +/*
> + * 'mcbsp' class
> + * multi channel buffered serial port controller
> + */
> +
> +static struct omap_hwmod_class_sysconfig omap2430_mcbsp_sysc = {
> +       .rev_offs       = 0x007C,
> +       .sysc_offs      = 0x008C,
> +       .sysc_flags     = (SYSC_HAS_SOFTRESET),
> +       .sysc_fields    =&omap_hwmod_sysc_type1,
> +};
> +
> +static struct omap_hwmod_class omap2430_mcbsp_hwmod_class = {
> +       .name = "mcbsp",
> +       .sysc =&omap2430_mcbsp_sysc,
> +};
> +
> +/* mcbsp1 */
> +static struct omap_hwmod_irq_info omap2430_mcbsp1_irqs[] = {
> +       { .name = "tx",         .irq = 59 },
> +       { .name = "rx",         .irq = 60 },
> +       { .name = "ovr",        .irq = 61 },
> +       { .name = "common",     .irq = 64 },
> +};
> +
> +static struct omap_hwmod_dma_info omap2430_mcbsp1_sdma_chs[] = {
> +       { .name = "rx", .dma_req = 31 },
> +       { .name = "tx", .dma_req = 30 },
> +};
> +
> +static struct omap_hwmod_addr_space omap2430_mcbsp1_addrs[] = {
> +       {
> +               .pa_start       = 0x48074000,
> +               .pa_end         = 0x480740ff,
> +               .flags          = ADDR_TYPE_RT
> +       },
> +};
> +
> +/* l4_core ->  mcbsp1 */
> +static struct omap_hwmod_ocp_if omap2430_l4_core__mcbsp1 = {
> +       .master         =&omap2430_l4_core_hwmod,
> +       .slave          =&omap2430_mcbsp1_hwmod,
> +       .clk            = "mcbsp1_ick",
> +       .addr           = omap2430_mcbsp1_addrs,
> +       .addr_cnt       = ARRAY_SIZE(omap2430_mcbsp1_addrs),
> +       .user           = OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* mcbsp1 slave ports */
> +static struct omap_hwmod_ocp_if *omap2430_mcbsp1_slaves[] = {
> +&omap2430_l4_core__mcbsp1,
> +};
> +
> +static struct omap_hwmod omap2430_mcbsp1_hwmod = {
> +       .name           = "mcbsp1",
> +       .class          =&omap2430_mcbsp_hwmod_class,
> +       .mpu_irqs       = omap2430_mcbsp1_irqs,
> +       .mpu_irqs_cnt   = ARRAY_SIZE(omap2430_mcbsp1_irqs),
> +       .sdma_reqs      = omap2430_mcbsp1_sdma_chs,
> +       .sdma_reqs_cnt  = ARRAY_SIZE(omap2430_mcbsp1_sdma_chs),
> +       .main_clk       = "mcbsp1_fck",
> +       .prcm           = {
> +               .omap2 = {
> +                       .prcm_reg_id = 1,
> +                       .module_bit = OMAP24XX_EN_MCBSP1_SHIFT,
> +                       .module_offs = CORE_MOD,
> +                       .idlest_reg_id = 1,
> +                       .idlest_idle_bit = OMAP24XX_EN_MCBSP1_SHIFT,
> +               },
> +       },
> +       .slaves         = omap2430_mcbsp1_slaves,
> +       .slaves_cnt     = ARRAY_SIZE(omap2430_mcbsp1_slaves),
> +       .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
> +};
> +
> +/* mcbsp2 */
> +static struct omap_hwmod_irq_info omap2430_mcbsp2_irqs[] = {
> +       { .name = "tx",         .irq = 62 },
> +       { .name = "rx",         .irq = 63 },
> +       { .name = "common",     .irq = 16 },
> +};
> +
> +static struct omap_hwmod_dma_info omap2430_mcbsp2_sdma_chs[] = {
> +       { .name = "rx", .dma_req = 33 },
> +       { .name = "tx", .dma_req = 32 },
> +};
> +
> +static struct omap_hwmod_addr_space omap2430_mcbsp2_addrs[] = {
> +       {
> +               .pa_start       = 0x48076000,
> +               .pa_end         = 0x480760ff,
> +               .flags          = ADDR_TYPE_RT
> +       },
> +};
> +
> +/* l4_core ->  mcbsp2 */
> +static struct omap_hwmod_ocp_if omap2430_l4_core__mcbsp2 = {
> +       .master         =&omap2430_l4_core_hwmod,
> +       .slave          =&omap2430_mcbsp2_hwmod,
> +       .clk            = "mcbsp2_ick",
> +       .addr           = omap2430_mcbsp2_addrs,
> +       .addr_cnt       = ARRAY_SIZE(omap2430_mcbsp2_addrs),
> +       .user           = OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* mcbsp2 slave ports */
> +static struct omap_hwmod_ocp_if *omap2430_mcbsp2_slaves[] = {
> +&omap2430_l4_core__mcbsp2,
> +};
> +
> +static struct omap_hwmod omap2430_mcbsp2_hwmod = {
> +       .name           = "mcbsp2",
> +       .class          =&omap2430_mcbsp_hwmod_class,
> +       .mpu_irqs       = omap2430_mcbsp2_irqs,
> +       .mpu_irqs_cnt   = ARRAY_SIZE(omap2430_mcbsp2_irqs),
> +       .sdma_reqs      = omap2430_mcbsp2_sdma_chs,
> +       .sdma_reqs_cnt  = ARRAY_SIZE(omap2430_mcbsp2_sdma_chs),
> +       .main_clk       = "mcbsp2_fck",
> +       .prcm           = {
> +               .omap2 = {
> +                       .prcm_reg_id = 1,
> +                       .module_bit = OMAP24XX_EN_MCBSP2_SHIFT,
> +                       .module_offs = CORE_MOD,
> +                       .idlest_reg_id = 1,
> +                       .idlest_idle_bit = OMAP24XX_EN_MCBSP2_SHIFT,
> +               },
> +       },
> +       .slaves         = omap2430_mcbsp2_slaves,
> +       .slaves_cnt     = ARRAY_SIZE(omap2430_mcbsp2_slaves),
> +       .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
> +};
> +
> +/* mcbsp3 */
> +static struct omap_hwmod_irq_info omap2430_mcbsp3_irqs[] = {
> +       { .name = "tx",         .irq = 89 },
> +       { .name = "rx",         .irq = 90 },
> +       { .name = "common",     .irq = 17 },
> +};
> +
> +static struct omap_hwmod_dma_info omap2430_mcbsp3_sdma_chs[] = {
> +       { .name = "rx", .dma_req = 17 },
> +       { .name = "tx", .dma_req = 16 },
> +};
> +
> +static struct omap_hwmod_addr_space omap2430_mcbsp3_addrs[] = {
> +       {
> +               .pa_start       = 0x4808C000,
> +               .pa_end         = 0x4808C0ff,
> +               .flags          = ADDR_TYPE_RT
> +       },
> +};
> +
> +/* l4_core ->  mcbsp3 */
> +static struct omap_hwmod_ocp_if omap2430_l4_core__mcbsp3 = {
> +       .master         =&omap2430_l4_core_hwmod,
> +       .slave          =&omap2430_mcbsp3_hwmod,
> +       .clk            = "mcbsp3_ick",
> +       .addr           = omap2430_mcbsp3_addrs,
> +       .addr_cnt       = ARRAY_SIZE(omap2430_mcbsp3_addrs),
> +       .user           = OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* mcbsp3 slave ports */
> +static struct omap_hwmod_ocp_if *omap2430_mcbsp3_slaves[] = {
> +&omap2430_l4_core__mcbsp3,
> +};
> +
> +static struct omap_hwmod omap2430_mcbsp3_hwmod = {
> +       .name           = "mcbsp3",
> +       .class          =&omap2430_mcbsp_hwmod_class,
> +       .mpu_irqs       = omap2430_mcbsp3_irqs,
> +       .mpu_irqs_cnt   = ARRAY_SIZE(omap2430_mcbsp3_irqs),
> +       .sdma_reqs      = omap2430_mcbsp3_sdma_chs,
> +       .sdma_reqs_cnt  = ARRAY_SIZE(omap2430_mcbsp3_sdma_chs),
> +       .main_clk       = "mcbsp3_fck",
> +       .prcm           = {
> +               .omap2 = {
> +                       .prcm_reg_id = 1,
> +                       .module_bit = OMAP2430_EN_MCBSP3_SHIFT,
> +                       .module_offs = CORE_MOD,
> +                       .idlest_reg_id = 2,
> +                       .idlest_idle_bit = OMAP2430_ST_MCBSP3_SHIFT,
> +               },
> +       },
> +       .slaves         = omap2430_mcbsp3_slaves,
> +       .slaves_cnt     = ARRAY_SIZE(omap2430_mcbsp3_slaves),
> +       .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
> +};
> +
> +/* mcbsp4 */
> +static struct omap_hwmod_irq_info omap2430_mcbsp4_irqs[] = {
> +       { .name = "tx",         .irq = 54 },
> +       { .name = "rx",         .irq = 55 },
> +       { .name = "common",     .irq = 18 },
> +};
> +
> +static struct omap_hwmod_dma_info omap2430_mcbsp4_sdma_chs[] = {
> +       { .name = "rx", .dma_req = 19 },
> +       { .name = "tx", .dma_req = 18 },
> +};
> +
> +static struct omap_hwmod_addr_space omap2430_mcbsp4_addrs[] = {
> +       {
> +               .pa_start       = 0x4808E000,
> +               .pa_end         = 0x4808E0ff,
> +               .flags          = ADDR_TYPE_RT
> +       },
> +};
> +
> +/* l4_core ->  mcbsp4 */
> +static struct omap_hwmod_ocp_if omap2430_l4_core__mcbsp4 = {
> +       .master         =&omap2430_l4_core_hwmod,
> +       .slave          =&omap2430_mcbsp4_hwmod,
> +       .clk            = "mcbsp4_ick",
> +       .addr           = omap2430_mcbsp4_addrs,
> +       .addr_cnt       = ARRAY_SIZE(omap2430_mcbsp4_addrs),
> +       .user           = OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* mcbsp4 slave ports */
> +static struct omap_hwmod_ocp_if *omap2430_mcbsp4_slaves[] = {
> +&omap2430_l4_core__mcbsp4,
> +};
> +
> +static struct omap_hwmod omap2430_mcbsp4_hwmod = {
> +       .name           = "mcbsp4",
> +       .class          =&omap2430_mcbsp_hwmod_class,
> +       .mpu_irqs       = omap2430_mcbsp4_irqs,
> +       .mpu_irqs_cnt   = ARRAY_SIZE(omap2430_mcbsp4_irqs),
> +       .sdma_reqs      = omap2430_mcbsp4_sdma_chs,
> +       .sdma_reqs_cnt  = ARRAY_SIZE(omap2430_mcbsp4_sdma_chs),
> +       .main_clk       = "mcbsp4_fck",
> +       .prcm           = {
> +               .omap2 = {
> +                       .prcm_reg_id = 1,
> +                       .module_bit = OMAP2430_EN_MCBSP4_SHIFT,
> +                       .module_offs = CORE_MOD,
> +                       .idlest_reg_id = 2,
> +                       .idlest_idle_bit = OMAP2430_ST_MCBSP4_SHIFT,
> +               },
> +       },
> +       .slaves         = omap2430_mcbsp4_slaves,
> +       .slaves_cnt     = ARRAY_SIZE(omap2430_mcbsp4_slaves),
> +       .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
> +};
> +
> +/* mcbsp5 */
> +static struct omap_hwmod_irq_info omap2430_mcbsp5_irqs[] = {
> +       { .name = "tx",         .irq = 81 },
> +       { .name = "rx",         .irq = 82 },
> +       { .name = "common",     .irq = 19 },
> +};
> +
> +static struct omap_hwmod_dma_info omap2430_mcbsp5_sdma_chs[] = {
> +       { .name = "rx", .dma_req = 21 },
> +       { .name = "tx", .dma_req = 20 },
> +};
> +
> +static struct omap_hwmod_addr_space omap2430_mcbsp5_addrs[] = {
> +       {
> +               .pa_start       = 0x48096000,
> +               .pa_end         = 0x480960ff,
> +               .flags          = ADDR_TYPE_RT
> +       },
> +};
> +
> +/* l4_core ->  mcbsp5 */
> +static struct omap_hwmod_ocp_if omap2430_l4_core__mcbsp5 = {
> +       .master         =&omap2430_l4_core_hwmod,
> +       .slave          =&omap2430_mcbsp5_hwmod,
> +       .clk            = "mcbsp5_ick",
> +       .addr           = omap2430_mcbsp5_addrs,
> +       .addr_cnt       = ARRAY_SIZE(omap2430_mcbsp5_addrs),
> +       .user           = OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* mcbsp5 slave ports */
> +static struct omap_hwmod_ocp_if *omap2430_mcbsp5_slaves[] = {
> +&omap2430_l4_core__mcbsp5,
> +};
> +
> +static struct omap_hwmod omap2430_mcbsp5_hwmod = {
> +       .name           = "mcbsp5",
> +       .class          =&omap2430_mcbsp_hwmod_class,
> +       .mpu_irqs       = omap2430_mcbsp5_irqs,
> +       .mpu_irqs_cnt   = ARRAY_SIZE(omap2430_mcbsp5_irqs),
> +       .sdma_reqs      = omap2430_mcbsp5_sdma_chs,
> +       .sdma_reqs_cnt  = ARRAY_SIZE(omap2430_mcbsp5_sdma_chs),
> +       .main_clk       = "mcbsp5_fck",
> +       .prcm           = {
> +               .omap2 = {
> +                       .prcm_reg_id = 1,
> +                       .module_bit = OMAP2430_EN_MCBSP5_SHIFT,
> +                       .module_offs = CORE_MOD,
> +                       .idlest_reg_id = 2,
> +                       .idlest_idle_bit = OMAP2430_ST_MCBSP5_SHIFT,
> +               },
> +       },
> +       .slaves         = omap2430_mcbsp5_slaves,
> +       .slaves_cnt     = ARRAY_SIZE(omap2430_mcbsp5_slaves),
> +       .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
> +};
> +
>   static __initdata struct omap_hwmod *omap2430_hwmods[] = {
>          &omap2430_l3_main_hwmod,
>          &omap2430_l4_core_hwmod,
> @@ -428,6 +736,11 @@ static __initdata struct omap_hwmod *omap2430_hwmods[] = {
>          &omap2430_uart1_hwmod,
>          &omap2430_uart2_hwmod,
>          &omap2430_uart3_hwmod,
> +&omap2430_mcbsp1_hwmod,
> +&omap2430_mcbsp2_hwmod,
> +&omap2430_mcbsp3_hwmod,
> +&omap2430_mcbsp4_hwmod,
> +&omap2430_mcbsp5_hwmod,
>          NULL,
>   };
>
> --
> 1.7.0.4
>

