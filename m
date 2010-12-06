From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH v5 2/12] OMAP2420: hwmod data: add dmtimer
Date: Mon, 6 Dec 2010 22:27:26 +0530
Message-ID: <20101206165726.GB4924@manju-desktop>
References: <1291679059-13419-1-git-send-email-tarun.kanti@ti.com>
 <1291679059-13419-3-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:54109 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752582Ab0LFQ6B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 11:58:01 -0500
Received: by gwj23 with SMTP id 23so4695430gwj.4
        for <linux-omap@vger.kernel.org>; Mon, 06 Dec 2010 08:57:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1291679059-13419-3-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>

On Tue, Dec 07, 2010 at 05:14:09AM +0530, Tarun Kanti DebBarma wrote:
> From: Thara Gopinath <thara@ti.com>
> 
> Add dmtimer data.
> 
> Signed-off-by: Thara Gopinath <thara@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Acked-by: Cousson, Benoit <b-cousson@ti.com>
> Reviewed-by: Varadarajan, Charulatha <charu@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c |  635 ++++++++++++++++++++++++++++
>  1 files changed, 635 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> index adf6e36..6d2e527 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> @@ -16,6 +16,7 @@
>  #include <plat/cpu.h>
>  #include <plat/dma.h>
>  #include <plat/serial.h>
> +#include <plat/dmtimer.h>
>  
>  #include "omap_hwmod_common_data.h"
>  
> @@ -228,6 +229,626 @@ static struct omap_hwmod omap2420_iva_hwmod = {
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
>  };
>  
> +/* Timer Common */
> +static struct omap_hwmod_class_sysconfig omap2420_timer_sysc = {
> +	.rev_offs	= 0x0000,
> +	.sysc_offs	= 0x0010,
> +	.syss_offs	= 0x0014,
> +	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_CLOCKACTIVITY |
> +			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
> +			   SYSC_HAS_AUTOIDLE),
> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> +	.clockact       = 0x2,
> +	.sysc_fields    = &omap_hwmod_sysc_type1,
> +};
> +
> +static struct omap_hwmod_class omap2420_timer_hwmod_class = {
> +	.name = "timer",
> +	.sysc = &omap2420_timer_sysc,
> +	.rev = OMAP_TIMER_IP_VERSION_1,

You are using this macro here and defined the same in v5-6-12*
This will break build. Define this macro in the same patch.

> +};
> +
> +/* timer1 */
> +static struct omap_hwmod omap2420_timer1_hwmod;
> +static struct omap_hwmod_irq_info omap2420_timer1_mpu_irqs[] = {
> +	{ .irq = INT_24XX_GPTIMER1, },

For a given platform, irq numbers are constants. You can replace this
assignment as:

{.irq = xx, }, /* INT_24XX_GPTIMER1 */

GPIO has followed the same convention. I2C and UART needs cleanup for
this.


> +};
> +
> +static struct omap_hwmod_addr_space omap2420_timer1_addrs[] = {
> +	{
> +		.pa_start	= 0x48028000,
> +		.pa_end		= 0x48028000 + SZ_1K - 1,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_wkup -> timer1 */
> +static struct omap_hwmod_ocp_if omap2420_l4_wkup__timer1 = {
> +	.master		= &omap2420_l4_wkup_hwmod,
> +	.slave		= &omap2420_timer1_hwmod,
> +	.clk		= "gpt1_ick",
> +	.addr		= omap2420_timer1_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap2420_timer1_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* timer1 slave port */
> +static struct omap_hwmod_ocp_if *omap2420_timer1_slaves[] = {
> +	&omap2420_l4_wkup__timer1,
> +};
> +
> +/* timer1 hwmod */
> +static struct omap_hwmod omap2420_timer1_hwmod = {
> +	.name		= "timer1",
> +	.mpu_irqs	= omap2420_timer1_mpu_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap2420_timer1_mpu_irqs),
> +	.main_clk	= "gpt1_fck",
> +	.prcm		= {
> +		.omap2 = {
> +			.prcm_reg_id = 1,
> +			.module_bit = OMAP24XX_EN_GPT1_SHIFT,
> +			.module_offs = WKUP_MOD,
> +			.idlest_reg_id = 1,
> +			.idlest_idle_bit = OMAP24XX_ST_GPT1_SHIFT,
> +		},
> +	},
> +	.slaves		= omap2420_timer1_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap2420_timer1_slaves),
> +	.class		= &omap2420_timer_hwmod_class,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
> +};
> +
> +/* timer2 */
> +static struct omap_hwmod omap2420_timer2_hwmod;
> +static struct omap_hwmod_irq_info omap2420_timer2_mpu_irqs[] = {
> +	{ .irq = INT_24XX_GPTIMER2, },
> +};
> +
> +static struct omap_hwmod_addr_space omap2420_timer2_addrs[] = {
> +	{
> +		.pa_start	= 0x4802a000,
> +		.pa_end		= 0x4802a000 + SZ_1K - 1,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_core -> timer2 */
> +static struct omap_hwmod_ocp_if omap2420_l4_core__timer2 = {
> +	.master		= &omap2420_l4_core_hwmod,
> +	.slave		= &omap2420_timer2_hwmod,
> +	.clk		= "gpt2_ick",
> +	.addr		= omap2420_timer2_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap2420_timer2_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* timer2 slave port */
> +static struct omap_hwmod_ocp_if *omap2420_timer2_slaves[] = {
> +	&omap2420_l4_core__timer2,
> +};
> +
> +/* timer2 hwmod */
> +static struct omap_hwmod omap2420_timer2_hwmod = {
> +	.name		= "timer2",
> +	.mpu_irqs	= omap2420_timer2_mpu_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap2420_timer2_mpu_irqs),
> +	.main_clk	= "gpt2_fck",
> +	.prcm		= {
> +		.omap2 = {
> +			.prcm_reg_id = 1,
> +			.module_bit = OMAP24XX_EN_GPT2_SHIFT,
> +			.module_offs = CORE_MOD,
> +			.idlest_reg_id = 1,
> +			.idlest_idle_bit = OMAP24XX_ST_GPT2_SHIFT,
> +		},
> +	},
> +	.slaves		= omap2420_timer2_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap2420_timer2_slaves),
> +	.class		= &omap2420_timer_hwmod_class,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
> +};
> +
> +/* timer3 */
> +static struct omap_hwmod omap2420_timer3_hwmod;
> +static struct omap_hwmod_irq_info omap2420_timer3_mpu_irqs[] = {
> +	{ .irq = INT_24XX_GPTIMER3, },
> +};
> +
> +static struct omap_hwmod_addr_space omap2420_timer3_addrs[] = {
> +	{
> +		.pa_start	= 0x48078000,
> +		.pa_end		= 0x48078000 + SZ_1K - 1,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_core -> timer3 */
> +static struct omap_hwmod_ocp_if omap2420_l4_core__timer3 = {
> +	.master		= &omap2420_l4_core_hwmod,
> +	.slave		= &omap2420_timer3_hwmod,
> +	.clk		= "gpt3_ick",
> +	.addr		= omap2420_timer3_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap2420_timer3_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* timer3 slave port */
> +static struct omap_hwmod_ocp_if *omap2420_timer3_slaves[] = {
> +	&omap2420_l4_core__timer3,
> +};
> +
> +/* timer3 hwmod */
> +static struct omap_hwmod omap2420_timer3_hwmod = {
> +	.name		= "timer3",
> +	.mpu_irqs	= omap2420_timer3_mpu_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap2420_timer3_mpu_irqs),
> +	.main_clk	= "gpt3_fck",
> +	.prcm		= {
> +		.omap2 = {
> +			.prcm_reg_id = 1,
> +			.module_bit = OMAP24XX_EN_GPT3_SHIFT,
> +			.module_offs = CORE_MOD,
> +			.idlest_reg_id = 1,
> +			.idlest_idle_bit = OMAP24XX_ST_GPT3_SHIFT,
> +		},
> +	},
> +	.slaves		= omap2420_timer3_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap2420_timer3_slaves),
> +	.class		= &omap2420_timer_hwmod_class,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
> +};
> +
> +/* timer4 */
> +static struct omap_hwmod omap2420_timer4_hwmod;
> +static struct omap_hwmod_irq_info omap2420_timer4_mpu_irqs[] = {
> +	{ .irq = INT_24XX_GPTIMER4, },
> +};
> +
> +static struct omap_hwmod_addr_space omap2420_timer4_addrs[] = {
> +	{
> +		.pa_start	= 0x4807a000,
> +		.pa_end		= 0x4807a000 + SZ_1K - 1,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_core -> timer4 */
> +static struct omap_hwmod_ocp_if omap2420_l4_core__timer4 = {
> +	.master		= &omap2420_l4_core_hwmod,
> +	.slave		= &omap2420_timer4_hwmod,
> +	.clk		= "gpt4_ick",
> +	.addr		= omap2420_timer4_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap2420_timer4_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* timer4 slave port */
> +static struct omap_hwmod_ocp_if *omap2420_timer4_slaves[] = {
> +	&omap2420_l4_core__timer4,
> +};
> +
> +/* timer4 hwmod */
> +static struct omap_hwmod omap2420_timer4_hwmod = {
> +	.name		= "timer4",
> +	.mpu_irqs	= omap2420_timer4_mpu_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap2420_timer4_mpu_irqs),
> +	.main_clk	= "gpt4_fck",
> +	.prcm		= {
> +		.omap2 = {
> +			.prcm_reg_id = 1,
> +			.module_bit = OMAP24XX_EN_GPT4_SHIFT,
> +			.module_offs = CORE_MOD,
> +			.idlest_reg_id = 1,
> +			.idlest_idle_bit = OMAP24XX_ST_GPT4_SHIFT,
> +		},
> +	},
> +	.slaves		= omap2420_timer4_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap2420_timer4_slaves),
> +	.class		= &omap2420_timer_hwmod_class,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
> +};
> +
> +/* timer5 */
> +static struct omap_hwmod omap2420_timer5_hwmod;
> +static struct omap_hwmod_irq_info omap2420_timer5_mpu_irqs[] = {
> +	{ .irq = INT_24XX_GPTIMER5, },
> +};
> +
> +static struct omap_hwmod_addr_space omap2420_timer5_addrs[] = {
> +	{
> +		.pa_start	= 0x4807c000,
> +		.pa_end		= 0x4807c000 + SZ_1K - 1,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +};
> +
> +/* l4_core -> timer5 */
> +static struct omap_hwmod_ocp_if omap2420_l4_core__timer5 = {
> +	.master		= &omap2420_l4_core_hwmod,
> +	.slave		= &omap2420_timer5_hwmod,
> +	.clk		= "gpt5_ick",
> +	.addr		= omap2420_timer5_addrs,
> +	.addr_cnt	= ARRAY_SIZE(omap2420_timer5_addrs),
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* timer5 slave port */
> +static struct omap_hwmod_ocp_if *omap2420_timer5_slaves[] = {
> +	&omap2420_l4_core__timer5,
> +};
> +
> +/* timer5 hwmod */
> +static struct omap_hwmod omap2420_timer5_hwmod = {
> +	.name		= "timer5",
> +	.mpu_irqs	= omap2420_timer5_mpu_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap2420_timer5_mpu_irqs),
> +	.main_clk	= "gpt5_fck",
> +	.prcm		= {
> +		.omap2 = {
> +			.prcm_reg_id = 1,
> +			.module_bit = OMAP24XX_EN_GPT5_SHIFT,
> +			.module_offs = CORE_MOD,
> +			.idlest_reg_id = 1,
> +			.idlest_idle_bit = OMAP24XX_ST_GPT5_SHIFT,
> +		},
> +	},
> +	.slaves		= omap2420_timer5_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap2420_timer5_slaves),
> +	.class		= &omap2420_timer_hwmod_class,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
> +};
> +
> +

extra line.

-Manjunath
