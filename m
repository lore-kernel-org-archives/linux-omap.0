From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCHv3 6/17] dmtimer: add omap44xx hwmod database
Date: Thu, 30 Sep 2010 23:32:32 +0200
Message-ID: <4CA501F0.5030203@ti.com>
References: <1285059188-26441-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54081 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753533Ab0I3Vcm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Sep 2010 17:32:42 -0400
In-Reply-To: <1285059188-26441-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>, "Basak, Partha" <p-basak2@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

All the comments of the previous patch are applicable here too.
+ some more...

On 9/21/2010 10:53 AM, DebBarma, Tarun Kanti wrote:
> From: Thara Gopinath<thara@ti.com>

I wrote the original patch for the OMAP4 hwmod data, so I should still 
be the author.
You should add as well a reference to the original patch.

> This patch adds hwmod database for OMAP44xx.
> In the hwmod class definition .rev field is
> initialized with timer ip version to distinguish
> the timers in different OMAP platforms.

Then I should have my signed-off-by here.

> Signed-off-by: Partha Basak<p-basak2@ti.com>
> Signed-off-by: Thara Gopinath<thara@ti.com>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> Cc: Cousson, Benoit<b-cousson@ti.com>
> Cc: Paul Walmsley<paul@pwsan.com>
> Cc: Kevin Hilman<khilman@deeprootsystems.com>
> Cc: Tony Lindgren<tony@atomide.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  660 ++++++++++++++++++++++++++++
>   1 files changed, 660 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index e20b0ee..28d65e9 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -23,6 +23,8 @@
>   #include<plat/omap_hwmod.h>
>   #include<plat/cpu.h>
>
> +#include<plat/dmtimer.h>
> +#include<plat/omap_device.h>
>   #include "omap_hwmod_common_data.h"
>
>   #include "cm.h"
> @@ -452,6 +454,651 @@ static struct omap_hwmod omap44xx_mpu_hwmod = {
>          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>   };
>
> +/*
> + * 'timer' class
> + * general purpose timer module with accurate 1ms tick
> + * This class contains several variants: ['timer_1ms', 'timer']
> + */
> +static char *timer_clk_src_names[] = {
> +       "sys_clkin_ck",
> +       "sys_32k_ck",
> +       NULL,
> +};
> +
> +static char *timer_clk_src_names_abe[] = {
> +       "syc_clk_div_ck",
> +       "sys_32k_ck",
> +       NULL,
> +};

Nothing new here, but that extra complexity added by the different ABE 
sys_clk does show that we have to find a better way to select the source 
clock.

> +
> +static struct omap_timer_dev_attr timer_dev_attr = {
> +       .clk_names      = timer_clk_src_names,
> +};
> +
> +static struct omap_timer_dev_attr timer_dev_attr_abe = {
> +       .clk_names      = timer_clk_src_names_abe,
> +};
> +
> +static struct omap_hwmod_class_sysconfig omap44xx_timer_1ms_sysc = {
> +       .rev_offs       = 0x0000,
> +       .sysc_offs      = 0x0010,
> +       .sysc_flags     = (SYSC_HAS_SIDLEMODE | SYSC_HAS_CLOCKACTIVITY |
> +                          SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
> +                          SYSC_HAS_EMUFREE | SYSC_HAS_AUTOIDLE |
> +                          SYSS_MISSING),
> +       .idlemodes      = (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> +       .sysc_fields    =&omap_hwmod_sysc_type1,
> +};
> +
> +/*
> + * during early boot when device model is not fully up and running
> + * any one of the dmtimers could be used by gmtimer implementation
> + * to provide system ticks. in order to enable hwmod api to search
> + * all the dmtimers irrespective of the class (ms and non-ms) it
> + * belongs the .name field is assigned a uniform name 'timer'.
> + */
> +static struct omap_hwmod_class omap44xx_timer_1ms_hwmod_class = {
> +       .name = "timer_1ms",
> +       .sysc =&omap44xx_timer_1ms_sysc,
> +       .rev = OMAP_TIMER_IP_VERSION_1,
> +};
> +
> +static struct omap_hwmod_class_sysconfig omap44xx_timer_sysc = {
> +       .rev_offs       = 0x0000,
> +       .sysc_offs      = 0x0010,
> +       .sysc_flags     = (SYSC_HAS_SIDLEMODE | SYSC_HAS_EMUFREE |
> +                          SYSC_HAS_SOFTRESET | SYSS_MISSING),

The reset status flag is still missing, but in that case it should be 
the SYSC_HAS_RESET_STATUS flag.

Regards,
Benoit

> +       .idlemodes      = (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> +       .sysc_fields    =&omap_hwmod_sysc_type2,
> +};
> +
> +static struct omap_hwmod_class omap44xx_timer_hwmod_class = {
> +       .name = "timer",
> +       .sysc =&omap44xx_timer_sysc,
> +       .rev = OMAP_TIMER_IP_VERSION_2,
> +};
> +
> +/* timer1 */
> +static struct omap_hwmod omap44xx_timer1_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_timer1_irqs[] = {
> +       { .irq = 37 + OMAP44XX_IRQ_GIC_START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_timer1_addrs[] = {
> +       {
> +               .pa_start       = 0x4a318000,
> +               .pa_end         = 0x4a31807f,
> +               .flags          = ADDR_TYPE_RT
> +       },
> +};
> +
> +/* l4_wkup ->  timer1 */
> +static struct omap_hwmod_ocp_if omap44xx_l4_wkup__timer1 = {
> +       .master         =&omap44xx_l4_wkup_hwmod,
> +       .slave          =&omap44xx_timer1_hwmod,
> +       .clk            = "l4_wkup_clk_mux_ck",
> +       .addr           = omap44xx_timer1_addrs,
> +       .addr_cnt       = ARRAY_SIZE(omap44xx_timer1_addrs),
> +       .user           = OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* timer1 slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_timer1_slaves[] = {
> +&omap44xx_l4_wkup__timer1,
> +};
> +
> +static struct omap_hwmod omap44xx_timer1_hwmod = {
> +       .name           = "timer1",
> +       .class          =&omap44xx_timer_1ms_hwmod_class,
> +       .mpu_irqs       = omap44xx_timer1_irqs,
> +       .mpu_irqs_cnt   = ARRAY_SIZE(omap44xx_timer1_irqs),
> +       .main_clk       = "timer1_fck",
> +       .prcm = {
> +               .omap4 = {
> +                       .clkctrl_reg = OMAP4430_CM_WKUP_TIMER1_CLKCTRL,
> +               },
> +       },
> +       .dev_attr       =&timer_dev_attr,
> +       .slaves         = omap44xx_timer1_slaves,
> +       .slaves_cnt     = ARRAY_SIZE(omap44xx_timer1_slaves),
> +       .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
> +/* timer2 */
> +static struct omap_hwmod omap44xx_timer2_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_timer2_irqs[] = {
> +       { .irq = 38 + OMAP44XX_IRQ_GIC_START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_timer2_addrs[] = {
> +       {
> +               .pa_start       = 0x48032000,
> +               .pa_end         = 0x4803207f,
> +               .flags          = ADDR_TYPE_RT
> +       },
> +};
> +
> +/* l4_per ->  timer2 */
> +static struct omap_hwmod_ocp_if omap44xx_l4_per__timer2 = {
> +       .master         =&omap44xx_l4_per_hwmod,
> +       .slave          =&omap44xx_timer2_hwmod,
> +       .clk            = "l4_div_ck",
> +       .addr           = omap44xx_timer2_addrs,
> +       .addr_cnt       = ARRAY_SIZE(omap44xx_timer2_addrs),
> +       .user           = OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* timer2 slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_timer2_slaves[] = {
> +&omap44xx_l4_per__timer2,
> +};
> +
> +static struct omap_hwmod omap44xx_timer2_hwmod = {
> +       .name           = "timer2",
> +       .class          =&omap44xx_timer_1ms_hwmod_class,
> +       .mpu_irqs       = omap44xx_timer2_irqs,
> +       .mpu_irqs_cnt   = ARRAY_SIZE(omap44xx_timer2_irqs),
> +       .main_clk       = "timer2_fck",
> +       .prcm = {
> +               .omap4 = {
> +                       .clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER2_CLKCTRL,
> +               },
> +       },
> +       .dev_attr       =&timer_dev_attr,
> +       .slaves         = omap44xx_timer2_slaves,
> +       .slaves_cnt     = ARRAY_SIZE(omap44xx_timer2_slaves),
> +       .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
> +/* timer3 */
> +static struct omap_hwmod omap44xx_timer3_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_timer3_irqs[] = {
> +       { .irq = 39 + OMAP44XX_IRQ_GIC_START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_timer3_addrs[] = {
> +       {
> +               .pa_start       = 0x48034000,
> +               .pa_end         = 0x4803407f,
> +               .flags          = ADDR_TYPE_RT
> +       },
> +};
> +
> +/* l4_per ->  timer3 */
> +static struct omap_hwmod_ocp_if omap44xx_l4_per__timer3 = {
> +       .master         =&omap44xx_l4_per_hwmod,
> +       .slave          =&omap44xx_timer3_hwmod,
> +       .clk            = "l4_div_ck",
> +       .addr           = omap44xx_timer3_addrs,
> +       .addr_cnt       = ARRAY_SIZE(omap44xx_timer3_addrs),
> +       .user           = OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* timer3 slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_timer3_slaves[] = {
> +&omap44xx_l4_per__timer3,
> +};
> +
> +static struct omap_hwmod omap44xx_timer3_hwmod = {
> +       .name           = "timer3",
> +       .class          =&omap44xx_timer_hwmod_class,
> +       .mpu_irqs       = omap44xx_timer3_irqs,
> +       .mpu_irqs_cnt   = ARRAY_SIZE(omap44xx_timer3_irqs),
> +       .main_clk       = "timer3_fck",
> +       .prcm = {
> +               .omap4 = {
> +                       .clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER3_CLKCTRL,
> +               },
> +       },
> +       .dev_attr       =&timer_dev_attr,
> +       .slaves         = omap44xx_timer3_slaves,
> +       .slaves_cnt     = ARRAY_SIZE(omap44xx_timer3_slaves),
> +       .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
> +/* timer4 */
> +static struct omap_hwmod omap44xx_timer4_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_timer4_irqs[] = {
> +       { .irq = 40 + OMAP44XX_IRQ_GIC_START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_timer4_addrs[] = {
> +       {
> +               .pa_start       = 0x48036000,
> +               .pa_end         = 0x4803607f,
> +               .flags          = ADDR_TYPE_RT
> +       },
> +};
> +
> +/* l4_per ->  timer4 */
> +static struct omap_hwmod_ocp_if omap44xx_l4_per__timer4 = {
> +       .master         =&omap44xx_l4_per_hwmod,
> +       .slave          =&omap44xx_timer4_hwmod,
> +       .clk            = "l4_div_ck",
> +       .addr           = omap44xx_timer4_addrs,
> +       .addr_cnt       = ARRAY_SIZE(omap44xx_timer4_addrs),
> +       .user           = OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* timer4 slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_timer4_slaves[] = {
> +&omap44xx_l4_per__timer4,
> +};
> +
> +static struct omap_hwmod omap44xx_timer4_hwmod = {
> +       .name           = "timer4",
> +       .class          =&omap44xx_timer_hwmod_class,
> +       .mpu_irqs       = omap44xx_timer4_irqs,
> +       .mpu_irqs_cnt   = ARRAY_SIZE(omap44xx_timer4_irqs),
> +       .main_clk       = "timer4_fck",
> +       .prcm = {
> +               .omap4 = {
> +                       .clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER4_CLKCTRL,
> +               },
> +       },
> +       .dev_attr       =&timer_dev_attr,
> +       .slaves         = omap44xx_timer4_slaves,
> +       .slaves_cnt     = ARRAY_SIZE(omap44xx_timer4_slaves),
> +       .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
> +/* timer5 */
> +static struct omap_hwmod omap44xx_timer5_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_timer5_irqs[] = {
> +       { .irq = 41 + OMAP44XX_IRQ_GIC_START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_timer5_addrs[] = {
> +       {
> +               .pa_start       = 0x40138000,
> +               .pa_end         = 0x4013807f,
> +               .flags          = ADDR_TYPE_RT
> +       },
> +};
> +
> +/* l4_abe ->  timer5 */
> +static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer5 = {
> +       .master         =&omap44xx_l4_abe_hwmod,
> +       .slave          =&omap44xx_timer5_hwmod,
> +       .clk            = "ocp_abe_iclk",
> +       .addr           = omap44xx_timer5_addrs,
> +       .addr_cnt       = ARRAY_SIZE(omap44xx_timer5_addrs),
> +       .user           = OCP_USER_MPU,
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_timer5_dma_addrs[] = {
> +       {
> +               .pa_start       = 0x49038000,
> +               .pa_end         = 0x4903807f,
> +               .flags          = ADDR_TYPE_RT
> +       },
> +};
> +
> +/* l4_abe ->  timer5 (dma) */
> +static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer5_dma = {
> +       .master         =&omap44xx_l4_abe_hwmod,
> +       .slave          =&omap44xx_timer5_hwmod,
> +       .clk            = "ocp_abe_iclk",
> +       .addr           = omap44xx_timer5_dma_addrs,
> +       .addr_cnt       = ARRAY_SIZE(omap44xx_timer5_dma_addrs),
> +       .user           = OCP_USER_SDMA,
> +};
> +
> +/* timer5 slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_timer5_slaves[] = {
> +&omap44xx_l4_abe__timer5,
> +&omap44xx_l4_abe__timer5_dma,
> +};
> +
> +static struct omap_hwmod omap44xx_timer5_hwmod = {
> +       .name           = "timer5",
> +       .class          =&omap44xx_timer_hwmod_class,
> +       .mpu_irqs       = omap44xx_timer5_irqs,
> +       .mpu_irqs_cnt   = ARRAY_SIZE(omap44xx_timer5_irqs),
> +       .main_clk       = "timer5_fck",
> +       .prcm = {
> +               .omap4 = {
> +                       .clkctrl_reg = OMAP4430_CM1_ABE_TIMER5_CLKCTRL,
> +               },
> +       },
> +       .dev_attr       =&timer_dev_attr_abe,
> +       .slaves         = omap44xx_timer5_slaves,
> +       .slaves_cnt     = ARRAY_SIZE(omap44xx_timer5_slaves),
> +       .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
> +/* timer6 */
> +static struct omap_hwmod omap44xx_timer6_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_timer6_irqs[] = {
> +       { .irq = 42 + OMAP44XX_IRQ_GIC_START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_timer6_addrs[] = {
> +       {
> +               .pa_start       = 0x4013a000,
> +               .pa_end         = 0x4013a07f,
> +               .flags          = ADDR_TYPE_RT
> +       },
> +};
> +
> +/* l4_abe ->  timer6 */
> +static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer6 = {
> +       .master         =&omap44xx_l4_abe_hwmod,
> +       .slave          =&omap44xx_timer6_hwmod,
> +       .clk            = "ocp_abe_iclk",
> +       .addr           = omap44xx_timer6_addrs,
> +       .addr_cnt       = ARRAY_SIZE(omap44xx_timer6_addrs),
> +       .user           = OCP_USER_MPU,
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_timer6_dma_addrs[] = {
> +       {
> +               .pa_start       = 0x4903a000,
> +               .pa_end         = 0x4903a07f,
> +               .flags          = ADDR_TYPE_RT
> +       },
> +};
> +
> +/* l4_abe ->  timer6 (dma) */
> +static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer6_dma = {
> +       .master         =&omap44xx_l4_abe_hwmod,
> +       .slave          =&omap44xx_timer6_hwmod,
> +       .clk            = "ocp_abe_iclk",
> +       .addr           = omap44xx_timer6_dma_addrs,
> +       .addr_cnt       = ARRAY_SIZE(omap44xx_timer6_dma_addrs),
> +       .user           = OCP_USER_SDMA,
> +};
> +
> +/* timer6 slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_timer6_slaves[] = {
> +&omap44xx_l4_abe__timer6,
> +&omap44xx_l4_abe__timer6_dma,
> +};
> +
> +static struct omap_hwmod omap44xx_timer6_hwmod = {
> +       .name           = "timer6",
> +       .class          =&omap44xx_timer_hwmod_class,
> +       .mpu_irqs       = omap44xx_timer6_irqs,
> +       .mpu_irqs_cnt   = ARRAY_SIZE(omap44xx_timer6_irqs),
> +       .main_clk       = "timer6_fck",
> +       .prcm = {
> +               .omap4 = {
> +                       .clkctrl_reg = OMAP4430_CM1_ABE_TIMER6_CLKCTRL,
> +               },
> +       },
> +       .dev_attr       =&timer_dev_attr_abe,
> +       .slaves         = omap44xx_timer6_slaves,
> +       .slaves_cnt     = ARRAY_SIZE(omap44xx_timer6_slaves),
> +       .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
> +/* timer7 */
> +static struct omap_hwmod omap44xx_timer7_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_timer7_irqs[] = {
> +       { .irq = 43 + OMAP44XX_IRQ_GIC_START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_timer7_addrs[] = {
> +       {
> +               .pa_start       = 0x4013c000,
> +               .pa_end         = 0x4013c07f,
> +               .flags          = ADDR_TYPE_RT
> +       },
> +};
> +
> +/* l4_abe ->  timer7 */
> +static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer7 = {
> +       .master         =&omap44xx_l4_abe_hwmod,
> +       .slave          =&omap44xx_timer7_hwmod,
> +       .clk            = "ocp_abe_iclk",
> +       .addr           = omap44xx_timer7_addrs,
> +       .addr_cnt       = ARRAY_SIZE(omap44xx_timer7_addrs),
> +       .user           = OCP_USER_MPU,
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_timer7_dma_addrs[] = {
> +       {
> +               .pa_start       = 0x4903c000,
> +               .pa_end         = 0x4903c07f,
> +               .flags          = ADDR_TYPE_RT
> +       },
> +};
> +
> +/* l4_abe ->  timer7 (dma) */
> +static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer7_dma = {
> +       .master         =&omap44xx_l4_abe_hwmod,
> +       .slave          =&omap44xx_timer7_hwmod,
> +       .clk            = "ocp_abe_iclk",
> +       .addr           = omap44xx_timer7_dma_addrs,
> +       .addr_cnt       = ARRAY_SIZE(omap44xx_timer7_dma_addrs),
> +       .user           = OCP_USER_SDMA,
> +};
> +
> +/* timer7 slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_timer7_slaves[] = {
> +&omap44xx_l4_abe__timer7,
> +&omap44xx_l4_abe__timer7_dma,
> +};
> +
> +static struct omap_hwmod omap44xx_timer7_hwmod = {
> +       .name           = "timer7",
> +       .class          =&omap44xx_timer_hwmod_class,
> +       .mpu_irqs       = omap44xx_timer7_irqs,
> +       .mpu_irqs_cnt   = ARRAY_SIZE(omap44xx_timer7_irqs),
> +       .main_clk       = "timer7_fck",
> +       .prcm = {
> +               .omap4 = {
> +                       .clkctrl_reg = OMAP4430_CM1_ABE_TIMER7_CLKCTRL,
> +               },
> +       },
> +       .dev_attr       =&timer_dev_attr_abe,
> +       .slaves         = omap44xx_timer7_slaves,
> +       .slaves_cnt     = ARRAY_SIZE(omap44xx_timer7_slaves),
> +       .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
> +/* timer8 */
> +static struct omap_hwmod omap44xx_timer8_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_timer8_irqs[] = {
> +       { .irq = 44 + OMAP44XX_IRQ_GIC_START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_timer8_addrs[] = {
> +       {
> +               .pa_start       = 0x4013e000,
> +               .pa_end         = 0x4013e07f,
> +               .flags          = ADDR_TYPE_RT
> +       },
> +};
> +
> +/* l4_abe ->  timer8 */
> +static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer8 = {
> +       .master         =&omap44xx_l4_abe_hwmod,
> +       .slave          =&omap44xx_timer8_hwmod,
> +       .clk            = "ocp_abe_iclk",
> +       .addr           = omap44xx_timer8_addrs,
> +       .addr_cnt       = ARRAY_SIZE(omap44xx_timer8_addrs),
> +       .user           = OCP_USER_MPU,
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_timer8_dma_addrs[] = {
> +       {
> +               .pa_start       = 0x4903e000,
> +               .pa_end         = 0x4903e07f,
> +               .flags          = ADDR_TYPE_RT
> +       },
> +};
> +
> +/* l4_abe ->  timer8 (dma) */
> +static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer8_dma = {
> +       .master         =&omap44xx_l4_abe_hwmod,
> +       .slave          =&omap44xx_timer8_hwmod,
> +       .clk            = "ocp_abe_iclk",
> +       .addr           = omap44xx_timer8_dma_addrs,
> +       .addr_cnt       = ARRAY_SIZE(omap44xx_timer8_dma_addrs),
> +       .user           = OCP_USER_SDMA,
> +};
> +
> +/* timer8 slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_timer8_slaves[] = {
> +&omap44xx_l4_abe__timer8,
> +&omap44xx_l4_abe__timer8_dma,
> +};
> +
> +static struct omap_hwmod omap44xx_timer8_hwmod = {
> +       .name           = "timer8",
> +       .class          =&omap44xx_timer_hwmod_class,
> +       .mpu_irqs       = omap44xx_timer8_irqs,
> +       .mpu_irqs_cnt   = ARRAY_SIZE(omap44xx_timer8_irqs),
> +       .main_clk       = "timer8_fck",
> +       .prcm = {
> +               .omap4 = {
> +                       .clkctrl_reg = OMAP4430_CM1_ABE_TIMER8_CLKCTRL,
> +               },
> +       },
> +       .dev_attr       =&timer_dev_attr_abe,
> +       .slaves         = omap44xx_timer8_slaves,
> +       .slaves_cnt     = ARRAY_SIZE(omap44xx_timer8_slaves),
> +       .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
> +/* timer9 */
> +static struct omap_hwmod omap44xx_timer9_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_timer9_irqs[] = {
> +       { .irq = 45 + OMAP44XX_IRQ_GIC_START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_timer9_addrs[] = {
> +       {
> +               .pa_start       = 0x4803e000,
> +               .pa_end         = 0x4803e07f,
> +               .flags          = ADDR_TYPE_RT
> +       },
> +};
> +
> +/* l4_per ->  timer9 */
> +static struct omap_hwmod_ocp_if omap44xx_l4_per__timer9 = {
> +       .master         =&omap44xx_l4_per_hwmod,
> +       .slave          =&omap44xx_timer9_hwmod,
> +       .clk            = "l4_div_ck",
> +       .addr           = omap44xx_timer9_addrs,
> +       .addr_cnt       = ARRAY_SIZE(omap44xx_timer9_addrs),
> +       .user           = OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* timer9 slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_timer9_slaves[] = {
> +&omap44xx_l4_per__timer9,
> +};
> +
> +static struct omap_hwmod omap44xx_timer9_hwmod = {
> +       .name           = "timer9",
> +       .class          =&omap44xx_timer_hwmod_class,
> +       .mpu_irqs       = omap44xx_timer9_irqs,
> +       .mpu_irqs_cnt   = ARRAY_SIZE(omap44xx_timer9_irqs),
> +       .main_clk       = "timer9_fck",
> +       .prcm = {
> +               .omap4 = {
> +                       .clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER9_CLKCTRL,
> +               },
> +       },
> +       .dev_attr       =&timer_dev_attr,
> +       .slaves         = omap44xx_timer9_slaves,
> +       .slaves_cnt     = ARRAY_SIZE(omap44xx_timer9_slaves),
> +       .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
> +/* timer10 */
> +static struct omap_hwmod omap44xx_timer10_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_timer10_irqs[] = {
> +       { .irq = 46 + OMAP44XX_IRQ_GIC_START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_timer10_addrs[] = {
> +       {
> +               .pa_start       = 0x48086000,
> +               .pa_end         = 0x4808607f,
> +               .flags          = ADDR_TYPE_RT
> +       },
> +};
> +
> +/* l4_per ->  timer10 */
> +static struct omap_hwmod_ocp_if omap44xx_l4_per__timer10 = {
> +       .master         =&omap44xx_l4_per_hwmod,
> +       .slave          =&omap44xx_timer10_hwmod,
> +       .clk            = "l4_div_ck",
> +       .addr           = omap44xx_timer10_addrs,
> +       .addr_cnt       = ARRAY_SIZE(omap44xx_timer10_addrs),
> +       .user           = OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* timer10 slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_timer10_slaves[] = {
> +&omap44xx_l4_per__timer10,
> +};
> +
> +static struct omap_hwmod omap44xx_timer10_hwmod = {
> +       .name           = "timer10",
> +       .class          =&omap44xx_timer_1ms_hwmod_class,
> +       .mpu_irqs       = omap44xx_timer10_irqs,
> +       .mpu_irqs_cnt   = ARRAY_SIZE(omap44xx_timer10_irqs),
> +       .main_clk       = "timer10_fck",
> +       .prcm = {
> +               .omap4 = {
> +                       .clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER10_CLKCTRL,
> +               },
> +       },
> +       .dev_attr       =&timer_dev_attr,
> +       .slaves         = omap44xx_timer10_slaves,
> +       .slaves_cnt     = ARRAY_SIZE(omap44xx_timer10_slaves),
> +       .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
> +/* timer11 */
> +static struct omap_hwmod omap44xx_timer11_hwmod;
> +static struct omap_hwmod_irq_info omap44xx_timer11_irqs[] = {
> +       { .irq = 47 + OMAP44XX_IRQ_GIC_START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_timer11_addrs[] = {
> +       {
> +               .pa_start       = 0x48088000,
> +               .pa_end         = 0x4808807f,
> +               .flags          = ADDR_TYPE_RT
> +       },
> +};
> +
> +/* l4_per ->  timer11 */
> +static struct omap_hwmod_ocp_if omap44xx_l4_per__timer11 = {
> +       .master         =&omap44xx_l4_per_hwmod,
> +       .slave          =&omap44xx_timer11_hwmod,
> +       .clk            = "l4_div_ck",
> +       .addr           = omap44xx_timer11_addrs,
> +       .addr_cnt       = ARRAY_SIZE(omap44xx_timer11_addrs),
> +       .user           = OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* timer11 slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_timer11_slaves[] = {
> +&omap44xx_l4_per__timer11,
> +};
> +
> +static struct omap_hwmod omap44xx_timer11_hwmod = {
> +       .name           = "timer11",
> +       .class          =&omap44xx_timer_hwmod_class,
> +       .mpu_irqs       = omap44xx_timer11_irqs,
> +       .mpu_irqs_cnt   = ARRAY_SIZE(omap44xx_timer11_irqs),
> +       .main_clk       = "timer11_fck",
> +       .prcm = {
> +               .omap4 = {
> +                       .clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER11_CLKCTRL,
> +               },
> +       },
> +       .dev_attr       =&timer_dev_attr,
> +       .slaves         = omap44xx_timer11_slaves,
> +       .slaves_cnt     = ARRAY_SIZE(omap44xx_timer11_slaves),
> +       .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
>   static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
>          /* dmm class */
>          &omap44xx_dmm_hwmod,
> @@ -472,6 +1119,19 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
>
>          /* mpu class */
>          &omap44xx_mpu_hwmod,
> +
> +       /* timer class */
> +&omap44xx_timer1_hwmod,
> +&omap44xx_timer2_hwmod,
> +&omap44xx_timer3_hwmod,
> +&omap44xx_timer4_hwmod,
> +&omap44xx_timer5_hwmod,
> +&omap44xx_timer6_hwmod,
> +&omap44xx_timer7_hwmod,
> +&omap44xx_timer8_hwmod,
> +&omap44xx_timer9_hwmod,
> +&omap44xx_timer10_hwmod,
> +&omap44xx_timer11_hwmod,
>          NULL,
>   };
>
> --
> 1.6.0.4
>

