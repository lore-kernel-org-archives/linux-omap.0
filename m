From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCHv3 4/17] dmtimer: add omap2430 hwmod database
Date: Sat, 9 Oct 2010 20:50:16 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB035E840686@dbde02.ent.ti.com>
References: <1285059138-26391-1-git-send-email-tarun.kanti@ti.com>
 <4CA4FD55.80802@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53628 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754735Ab0JIPUZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Oct 2010 11:20:25 -0400
In-Reply-To: <4CA4FD55.80802@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>, "Basak, Partha" <p-basak2@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

Benoit,

> -----Original Message-----
> From: Cousson, Benoit
> Sent: Friday, October 01, 2010 2:43 AM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Gopinath, Thara; Basak, Partha; Paul
> Walmsley; Kevin Hilman; Tony Lindgren
> Subject: Re: [PATCHv3 4/17] dmtimer: add omap2430 hwmod database
>
> All the comments of the previous patch are applicable here too.
> + a new one that I forgot in previous patches...
Ok, they will be taken care!
-tarun
>
> On 9/21/2010 10:52 AM, DebBarma, Tarun Kanti wrote:
> > From: Thara Gopinath<thara@ti.com>
> >
> > This patch adds hwmod database for OMAP2430.
> > In the hwmod class definition .rev field is
> > initialized with timer ip version to distinguish
> > the timers in different OMAP platforms.
> >
> > Signed-off-by: Partha Basak<p-basak2@ti.com>
> > Signed-off-by: Thara Gopinath<thara@ti.com>
> > Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> The order of the sign-off does matter. The original author should be the
> first, and then next contributor will follow with potentially a small
> explanation of what he did on top of the original author, if that does
> make apply.
>
Sure, I will follow in the next series.

>
>
> > Cc: Cousson, Benoit<b-cousson@ti.com>
> > Cc: Paul Walmsley<paul@pwsan.com>
> > Cc: Kevin Hilman<khilman@deeprootsystems.com>
> > Cc: Tony Lindgren<tony@atomide.com>
> > ---
> >   arch/arm/mach-omap2/omap_hwmod_2430_data.c |  620
> ++++++++++++++++++++++++++++
> >   1 files changed, 620 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-
> omap2/omap_hwmod_2430_data.c
> > index 4526628..4b43fb9 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> > @@ -16,6 +16,8 @@
> >   #include<plat/cpu.h>
> >   #include<plat/dma.h>
> >
> > +#include<plat/dmtimer.h>
> > +#include<plat/omap_device.h>
> >   #include "omap_hwmod_common_data.h"
> >
> >   #include "prm-regbits-24xx.h"
> > @@ -127,6 +129,612 @@ static struct omap_hwmod_ocp_if
> *omap2430_mpu_masters[] = {
> >          &omap2430_mpu__l3_main,
> >   };
> >
> > +/* Timer Common */
> > +static char *timer_clk_src_names[] = {
> > +       "sys_ck",
> > +       "func_32k_ck",
> > +       "alt_ck",
> > +       NULL
> > +};
> > +
> > +static struct omap_timer_dev_attr timer_dev_attr = {
> > +       .clk_names      = timer_clk_src_names,
> > +};
> > +
> > +static struct omap_hwmod_class_sysconfig omap2430_timer_sysc = {
> > +       .rev_offs       = 0x0000,
> > +       .sysc_offs      = 0x0010,
> > +       .syss_offs      = 0x0014,
> > +       .sysc_flags     = (SYSC_HAS_SIDLEMODE | SYSC_HAS_CLOCKACTIVITY |
> > +                          SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
> > +                          SYSC_HAS_AUTOIDLE),
> > +       .idlemodes      = (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> > +       .sysc_fields    =&omap_hwmod_sysc_type1,
> > +};
> > +
> > +static struct omap_hwmod_class omap2430_timer_hwmod_class = {
> > +       .name = "timer",
> > +       .sysc =&omap2430_timer_sysc,
> > +       .rev = OMAP_TIMER_IP_VERSION_1,
> > +};
> > +
> > +
> > +/* timer1 */
> > +static struct omap_hwmod omap2430_timer1_hwmod;
> > +static struct omap_hwmod_irq_info omap2430_timer1_mpu_irqs[] = {
> > +       { .irq = INT_24XX_GPTIMER1, },
> > +};
> > +
> > +static struct omap_hwmod_addr_space omap2430_timer1_addrs[] = {
> > +       {
> > +               .pa_start       = 0x49018000,
> > +               .pa_end         = 0x49018000 + SZ_1K - 1,
> > +               .flags          = ADDR_TYPE_RT
> > +       },
> > +};
> > +
> > +/* l4_wkup ->  timer1 */
> > +static struct omap_hwmod_ocp_if omap2430_l4_wkup__timer1 = {
> > +       .master         =&omap2430_l4_wkup_hwmod,
> > +       .slave          =&omap2430_timer1_hwmod,
> > +       .clk            = "gpt1_ick",
> > +       .addr           = omap2430_timer1_addrs,
> > +       .addr_cnt       = ARRAY_SIZE(omap2430_timer1_addrs),
> > +       .user           = OCP_USER_MPU | OCP_USER_SDMA,
> > +};
> > +
> > +/* timer1 slave port */
> > +static struct omap_hwmod_ocp_if *omap2430_timer1_slaves[] = {
> > +&omap2430_l4_wkup__timer1,
> > +};
> > +
> > +/* timer1 hwmod */
> > +static struct omap_hwmod omap2430_timer1_hwmod = {
> > +       .name           = "timer1",
> > +       .mpu_irqs       = omap2430_timer1_mpu_irqs,
> > +       .mpu_irqs_cnt   = ARRAY_SIZE(omap2430_timer1_mpu_irqs),
> > +       .main_clk       = "gpt1_fck",
> > +       .prcm           = {
> > +               .omap2 = {
> > +                       .prcm_reg_id = 1,
> > +                       .module_bit = OMAP24XX_EN_GPT1_SHIFT,
> > +                       .module_offs = WKUP_MOD,
> > +                       .idlest_reg_id = 1,
> > +                       .idlest_idle_bit = OMAP24XX_EN_GPT1_SHIFT,
> > +               },
> > +       },
> > +       .dev_attr       =&timer_dev_attr,
> > +       .slaves         = omap2430_timer1_slaves,
> > +       .slaves_cnt     = ARRAY_SIZE(omap2430_timer1_slaves),
> > +       .class          =&omap2430_timer_hwmod_class,
> > +       .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
> > +};
> > +
> > +
> > +/* timer2 */
> > +static struct omap_hwmod omap2430_timer2_hwmod;
> > +static struct omap_hwmod_irq_info omap2430_timer2_mpu_irqs[] = {
> > +       { .irq = INT_24XX_GPTIMER2, },
> > +};
> > +
> > +static struct omap_hwmod_addr_space omap2430_timer2_addrs[] = {
> > +       {
> > +               .pa_start       = 0x4802a000,
> > +               .pa_end         = 0x4802a000 + SZ_1K - 1,
> > +               .flags          = ADDR_TYPE_RT
> > +       },
> > +};
> > +/* l4_core ->  timer2 */
> > +static struct omap_hwmod_ocp_if omap2430_l4_core__timer2 = {
> > +       .master         =&omap2430_l4_core_hwmod,
> > +       .slave          =&omap2430_timer2_hwmod,
> > +       .clk            = "gpt2_ick",
> > +       .addr           = omap2430_timer2_addrs,
> > +       .addr_cnt       = ARRAY_SIZE(omap2430_timer2_addrs),
> > +       .user           = OCP_USER_MPU | OCP_USER_SDMA,
> > +};
> > +/* timer2 slave port */
> > +static struct omap_hwmod_ocp_if *omap2430_timer2_slaves[] = {
> > +&omap2430_l4_core__timer2,
> > +};
> > +/* timer2 hwmod */
> > +static struct omap_hwmod omap2430_timer2_hwmod = {
> > +       .name           = "timer2",
> > +       .mpu_irqs       = omap2430_timer2_mpu_irqs,
> > +       .mpu_irqs_cnt   = ARRAY_SIZE(omap2430_timer2_mpu_irqs),
> > +       .main_clk       = "gpt2_fck",
> > +       .prcm           = {
> > +               .omap2 = {
> > +                       .prcm_reg_id = 1,
> > +                       .module_bit = OMAP24XX_EN_GPT2_SHIFT,
> > +                       .module_offs = CORE_MOD,
> > +                       .idlest_reg_id = 1,
> > +                       .idlest_idle_bit = OMAP24XX_EN_GPT2_SHIFT,
> > +               },
> > +       },
> > +       .dev_attr       =&timer_dev_attr,
> > +       .slaves         = omap2430_timer2_slaves,
> > +       .slaves_cnt     = ARRAY_SIZE(omap2430_timer2_slaves),
> > +       .class          =&omap2430_timer_hwmod_class,
> > +       .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
> > +};
> > +
> > +/* timer3 */
> > +static struct omap_hwmod omap2430_timer3_hwmod;
> > +static struct omap_hwmod_irq_info omap2430_timer3_mpu_irqs[] = {
> > +       { .irq = INT_24XX_GPTIMER3, },
> > +};
> > +static struct omap_hwmod_addr_space omap2430_timer3_addrs[] = {
> > +       {
> > +               .pa_start       = 0x48078000,
> > +               .pa_end         = 0x48078000 + SZ_1K - 1,
> > +               .flags          = ADDR_TYPE_RT
> > +       },
> > +};
> > +/* l4_core ->  timer3 */
> > +static struct omap_hwmod_ocp_if omap2430_l4_core__timer3 = {
> > +       .master         =&omap2430_l4_core_hwmod,
> > +       .slave          =&omap2430_timer3_hwmod,
> > +       .clk            = "gpt3_ick",
> > +       .addr           = omap2430_timer3_addrs,
> > +       .addr_cnt       = ARRAY_SIZE(omap2430_timer3_addrs),
> > +       .user           = OCP_USER_MPU | OCP_USER_SDMA,
> > +};
> > +/* timer3 slave port */
> > +static struct omap_hwmod_ocp_if *omap2430_timer3_slaves[] = {
> > +&omap2430_l4_core__timer3,
> > +};
> > +/* timer3 hwmod */
> > +static struct omap_hwmod omap2430_timer3_hwmod = {
> > +       .name           = "timer3",
> > +       .mpu_irqs       = omap2430_timer3_mpu_irqs,
> > +       .mpu_irqs_cnt   = ARRAY_SIZE(omap2430_timer3_mpu_irqs),
> > +       .main_clk       = "gpt3_fck",
> > +       .prcm           = {
> > +               .omap2 = {
> > +                       .prcm_reg_id = 1,
> > +                       .module_bit = OMAP24XX_EN_GPT3_SHIFT,
> > +                       .module_offs = CORE_MOD,
> > +                       .idlest_reg_id = 1,
> > +                       .idlest_idle_bit = OMAP24XX_EN_GPT3_SHIFT,
> > +               },
> > +       },
> > +       .dev_attr       =&timer_dev_attr,
> > +       .slaves         = omap2430_timer3_slaves,
> > +       .slaves_cnt     = ARRAY_SIZE(omap2430_timer3_slaves),
> > +       .class          =&omap2430_timer_hwmod_class,
> > +       .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
> > +};
> > +
> > +
> > +/* timer4 */
> > +static struct omap_hwmod omap2430_timer4_hwmod;
> > +static struct omap_hwmod_irq_info omap2430_timer4_mpu_irqs[] = {
> > +       { .irq = INT_24XX_GPTIMER4, },
> > +};
> > +
> > +static struct omap_hwmod_addr_space omap2430_timer4_addrs[] = {
> > +       {
> > +               .pa_start       = 0x4807a000,
> > +               .pa_end         = 0x4807a000 + SZ_1K - 1,
> > +               .flags          = ADDR_TYPE_RT
> > +       },
> > +};
> > +/* l4_core ->  timer4 */
> > +static struct omap_hwmod_ocp_if omap2430_l4_core__timer4 = {
> > +       .master         =&omap2430_l4_core_hwmod,
> > +       .slave          =&omap2430_timer4_hwmod,
> > +       .clk            = "gpt4_ick",
> > +       .addr           = omap2430_timer4_addrs,
> > +       .addr_cnt       = ARRAY_SIZE(omap2430_timer4_addrs),
> > +       .user           = OCP_USER_MPU | OCP_USER_SDMA,
> > +};
> > +/* timer4 slave port */
> > +static struct omap_hwmod_ocp_if *omap2430_timer4_slaves[] = {
> > +&omap2430_l4_core__timer4,
> > +};
> > +/* timer4 hwmod */
> > +static struct omap_hwmod omap2430_timer4_hwmod = {
> > +       .name           = "timer4",
> > +       .mpu_irqs       = omap2430_timer4_mpu_irqs,
> > +       .mpu_irqs_cnt   = ARRAY_SIZE(omap2430_timer4_mpu_irqs),
> > +       .main_clk       = "gpt4_fck",
> > +       .prcm           = {
> > +               .omap2 = {
> > +                       .prcm_reg_id = 1,
> > +                       .module_bit = OMAP24XX_EN_GPT4_SHIFT,
> > +                       .module_offs = CORE_MOD,
> > +                       .idlest_reg_id = 1,
> > +                       .idlest_idle_bit = OMAP24XX_EN_GPT4_SHIFT,
> > +               },
> > +       },
> > +       .dev_attr       =&timer_dev_attr,
> > +       .slaves         = omap2430_timer4_slaves,
> > +       .slaves_cnt     = ARRAY_SIZE(omap2430_timer4_slaves),
> > +       .class          =&omap2430_timer_hwmod_class,
> > +       .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
> > +};
> > +
> > +/* timer5 */
> > +static struct omap_hwmod omap2430_timer5_hwmod;
> > +static struct omap_hwmod_irq_info omap2430_timer5_mpu_irqs[] = {
> > +       { .irq = INT_24XX_GPTIMER5, },
> > +};
> > +static struct omap_hwmod_addr_space omap2430_timer5_addrs[] = {
> > +       {
> > +               .pa_start       = 0x4807c000,
> > +               .pa_end         = 0x4807c000 + SZ_1K - 1,
> > +               .flags          = ADDR_TYPE_RT
> > +       },
> > +};
> > +/* l4_core ->  timer5 */
> > +static struct omap_hwmod_ocp_if omap2430_l4_core__timer5 = {
> > +       .master         =&omap2430_l4_core_hwmod,
> > +       .slave          =&omap2430_timer5_hwmod,
> > +       .clk            = "gpt5_ick",
> > +       .addr           = omap2430_timer5_addrs,
> > +       .addr_cnt       = ARRAY_SIZE(omap2430_timer5_addrs),
> > +       .user           = OCP_USER_MPU | OCP_USER_SDMA,
> > +};
> > +/* timer5 slave port */
> > +static struct omap_hwmod_ocp_if *omap2430_timer5_slaves[] = {
> > +&omap2430_l4_core__timer5,
> > +};
> > +/* timer5 hwmod */
> > +static struct omap_hwmod omap2430_timer5_hwmod = {
> > +       .name           = "timer5",
> > +       .mpu_irqs       = omap2430_timer5_mpu_irqs,
> > +       .mpu_irqs_cnt   = ARRAY_SIZE(omap2430_timer5_mpu_irqs),
> > +       .main_clk       = "gpt5_fck",
> > +       .prcm           = {
> > +               .omap2 = {
> > +                       .prcm_reg_id = 1,
> > +                       .module_bit = OMAP24XX_EN_GPT5_SHIFT,
> > +                       .module_offs = CORE_MOD,
> > +                       .idlest_reg_id = 1,
> > +                       .idlest_idle_bit = OMAP24XX_EN_GPT5_SHIFT,
> > +               },
> > +       },
> > +       .dev_attr       =&timer_dev_attr,
> > +       .slaves         = omap2430_timer5_slaves,
> > +       .slaves_cnt     = ARRAY_SIZE(omap2430_timer5_slaves),
> > +       .class          =&omap2430_timer_hwmod_class,
> > +       .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
> > +};
> > +
> > +/* timer6 */
> > +static struct omap_hwmod omap2430_timer6_hwmod;
> > +static struct omap_hwmod_irq_info omap2430_timer6_mpu_irqs[] = {
> > +       { .irq = INT_24XX_GPTIMER6, },
> > +};
> > +
> > +static struct omap_hwmod_addr_space omap2430_timer6_addrs[] = {
> > +       {
> > +               .pa_start       = 0x4807e000,
> > +               .pa_end         = 0x4807e000 + SZ_1K - 1,
> > +               .flags          = ADDR_TYPE_RT
> > +       },
> > +};
> > +/* l4_core ->  timer6 */
> > +static struct omap_hwmod_ocp_if omap2430_l4_core__timer6 = {
> > +       .master         =&omap2430_l4_core_hwmod,
> > +       .slave          =&omap2430_timer6_hwmod,
> > +       .clk            = "gpt6_ick",
> > +       .addr           = omap2430_timer6_addrs,
> > +       .addr_cnt       = ARRAY_SIZE(omap2430_timer6_addrs),
> > +       .user           = OCP_USER_MPU | OCP_USER_SDMA,
> > +};
> > +/* timer6 slave port */
> > +static struct omap_hwmod_ocp_if *omap2430_timer6_slaves[] = {
> > +&omap2430_l4_core__timer6,
> > +};
> > +/* timer6 hwmod */
> > +static struct omap_hwmod omap2430_timer6_hwmod = {
> > +       .name           = "timer6",
> > +       .mpu_irqs       = omap2430_timer6_mpu_irqs,
> > +       .mpu_irqs_cnt   = ARRAY_SIZE(omap2430_timer6_mpu_irqs),
> > +       .main_clk       = "gpt6_fck",
> > +       .prcm           = {
> > +               .omap2 = {
> > +                       .prcm_reg_id = 1,
> > +                       .module_bit = OMAP24XX_EN_GPT6_SHIFT,
> > +                       .module_offs = CORE_MOD,
> > +                       .idlest_reg_id = 1,
> > +                       .idlest_idle_bit = OMAP24XX_EN_GPT6_SHIFT,
> > +               },
> > +       },
> > +       .dev_attr       =&timer_dev_attr,
> > +       .slaves         = omap2430_timer6_slaves,
> > +       .slaves_cnt     = ARRAY_SIZE(omap2430_timer6_slaves),
> > +       .class          =&omap2430_timer_hwmod_class,
> > +       .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
> > +};
> > +
> > +
> > +/* timer7 */
> > +static struct omap_hwmod omap2430_timer7_hwmod;
> > +static struct omap_hwmod_irq_info omap2430_timer7_mpu_irqs[] = {
> > +       { .irq = INT_24XX_GPTIMER7, },
> > +};
> > +static struct omap_hwmod_addr_space omap2430_timer7_addrs[] = {
> > +       {
> > +               .pa_start       = 0x48080000,
> > +               .pa_end         = 0x48080000 + SZ_1K - 1,
> > +               .flags          = ADDR_TYPE_RT
> > +       },
> > +};
> > +/* l4_core ->  timer7 */
> > +static struct omap_hwmod_ocp_if omap2430_l4_core__timer7 = {
> > +       .master         =&omap2430_l4_core_hwmod,
> > +       .slave          =&omap2430_timer7_hwmod,
> > +       .clk            = "gpt7_ick",
> > +       .addr           = omap2430_timer7_addrs,
> > +       .addr_cnt       = ARRAY_SIZE(omap2430_timer7_addrs),
> > +       .user           = OCP_USER_MPU | OCP_USER_SDMA,
> > +};
> > +/* timer7 slave port */
> > +static struct omap_hwmod_ocp_if *omap2430_timer7_slaves[] = {
> > +&omap2430_l4_core__timer7,
> > +};
> > +/* timer7 hwmod */
> > +static struct omap_hwmod omap2430_timer7_hwmod = {
> > +       .name           = "timer7",
> > +       .mpu_irqs       = omap2430_timer7_mpu_irqs,
> > +       .mpu_irqs_cnt   = ARRAY_SIZE(omap2430_timer7_mpu_irqs),
> > +       .main_clk       = "gpt7_fck",
> > +       .prcm           = {
> > +               .omap2 = {
> > +                       .prcm_reg_id = 1,
> > +                       .module_bit = OMAP24XX_EN_GPT7_SHIFT,
> > +                       .module_offs = CORE_MOD,
> > +                       .idlest_reg_id = 1,
> > +                       .idlest_idle_bit = OMAP24XX_EN_GPT7_SHIFT,
> > +               },
> > +       },
> > +       .dev_attr       =&timer_dev_attr,
> > +       .slaves         = omap2430_timer7_slaves,
> > +       .slaves_cnt     = ARRAY_SIZE(omap2430_timer7_slaves),
> > +       .class          =&omap2430_timer_hwmod_class,
> > +       .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
> > +};
> > +
> > +/* timer8 */
> > +static struct omap_hwmod omap2430_timer8_hwmod;
> > +static struct omap_hwmod_irq_info omap2430_timer8_mpu_irqs[] = {
> > +       { .irq = INT_24XX_GPTIMER8, },
> > +};
> > +static struct omap_hwmod_addr_space omap2430_timer8_addrs[] = {
> > +       {
> > +               .pa_start       = 0x48082000,
> > +               .pa_end         = 0x48082000 + SZ_1K - 1,
> > +               .flags          = ADDR_TYPE_RT
> > +       },
> > +};
> > +/* l4_core ->  timer8 */
> > +static struct omap_hwmod_ocp_if omap2430_l4_core__timer8 = {
> > +       .master         =&omap2430_l4_core_hwmod,
> > +       .slave          =&omap2430_timer8_hwmod,
> > +       .clk            = "gpt8_ick",
> > +       .addr           = omap2430_timer8_addrs,
> > +       .addr_cnt       = ARRAY_SIZE(omap2430_timer8_addrs),
> > +       .user           = OCP_USER_MPU | OCP_USER_SDMA,
> > +};
> > +/* timer8 slave port */
> > +static struct omap_hwmod_ocp_if *omap2430_timer8_slaves[] = {
> > +&omap2430_l4_core__timer8,
> > +};
> > +/* timer8 hwmod */
> > +static struct omap_hwmod omap2430_timer8_hwmod = {
> > +       .name           = "timer8",
> > +       .mpu_irqs       = omap2430_timer8_mpu_irqs,
> > +       .mpu_irqs_cnt   = ARRAY_SIZE(omap2430_timer8_mpu_irqs),
> > +       .main_clk       = "gpt8_fck",
> > +       .prcm           = {
> > +               .omap2 = {
> > +                       .prcm_reg_id = 1,
> > +                       .module_bit = OMAP24XX_EN_GPT8_SHIFT,
> > +                       .module_offs = CORE_MOD,
> > +                       .idlest_reg_id = 1,
> > +                       .idlest_idle_bit = OMAP24XX_EN_GPT8_SHIFT,
> > +               },
> > +       },
> > +       .dev_attr       =&timer_dev_attr,
> > +       .slaves         = omap2430_timer8_slaves,
> > +       .slaves_cnt     = ARRAY_SIZE(omap2430_timer8_slaves),
> > +       .class          =&omap2430_timer_hwmod_class,
> > +       .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
> > +};
> > +
> > +/* timer9 */
> > +static struct omap_hwmod omap2430_timer9_hwmod;
> > +static struct omap_hwmod_irq_info omap2430_timer9_mpu_irqs[] = {
> > +       { .irq = INT_24XX_GPTIMER9, },
> > +};
> > +
> > +static struct omap_hwmod_addr_space omap2430_timer9_addrs[] = {
> > +       {
> > +               .pa_start       = 0x48084000,
> > +               .pa_end         = 0x48084000 + SZ_1K - 1,
> > +               .flags          = ADDR_TYPE_RT
> > +       },
> > +};
> > +/* l4_core ->  timer9 */
> > +static struct omap_hwmod_ocp_if omap2430_l4_core__timer9 = {
> > +       .master         =&omap2430_l4_core_hwmod,
> > +       .slave          =&omap2430_timer9_hwmod,
> > +       .clk            = "gpt9_ick",
> > +       .addr           = omap2430_timer9_addrs,
> > +       .addr_cnt       = ARRAY_SIZE(omap2430_timer9_addrs),
> > +       .user           = OCP_USER_MPU | OCP_USER_SDMA,
> > +};
> > +/* timer9 slave port */
> > +static struct omap_hwmod_ocp_if *omap2430_timer9_slaves[] = {
> > +&omap2430_l4_core__timer9,
> > +};
> > +/* timer9 hwmod */
> > +static struct omap_hwmod omap2430_timer9_hwmod = {
> > +       .name           = "timer9",
> > +       .mpu_irqs       = omap2430_timer9_mpu_irqs,
> > +       .mpu_irqs_cnt   = ARRAY_SIZE(omap2430_timer9_mpu_irqs),
> > +       .main_clk       = "gpt9_fck",
> > +       .prcm           = {
> > +               .omap2 = {
> > +                       .prcm_reg_id = 1,
> > +                       .module_bit = OMAP24XX_EN_GPT9_SHIFT,
> > +                       .module_offs = CORE_MOD,
> > +                       .idlest_reg_id = 1,
> > +                       .idlest_idle_bit = OMAP24XX_EN_GPT9_SHIFT,
> > +               },
> > +       },
> > +       .dev_attr       =&timer_dev_attr,
> > +       .slaves         = omap2430_timer9_slaves,
> > +       .slaves_cnt     = ARRAY_SIZE(omap2430_timer9_slaves),
> > +       .class          =&omap2430_timer_hwmod_class,
> > +       .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
> > +};
> > +
> > +/* timer10 */
> > +static struct omap_hwmod omap2430_timer10_hwmod;
> > +static struct omap_hwmod_irq_info omap2430_timer10_mpu_irqs[] = {
> > +       { .irq = INT_24XX_GPTIMER10, },
> > +};
> > +static struct omap_hwmod_addr_space omap2430_timer10_addrs[] = {
> > +       {
> > +               .pa_start       = 0x48086000,
> > +               .pa_end         = 0x48086000 + SZ_1K - 1,
> > +               .flags          = ADDR_TYPE_RT
> > +       },
> > +};
> > +/* l4_core ->  timer10 */
> > +static struct omap_hwmod_ocp_if omap2430_l4_core__timer10 = {
> > +       .master         =&omap2430_l4_core_hwmod,
> > +       .slave          =&omap2430_timer10_hwmod,
> > +       .clk            = "gpt10_ick",
> > +       .addr           = omap2430_timer10_addrs,
> > +       .addr_cnt       = ARRAY_SIZE(omap2430_timer10_addrs),
> > +       .user           = OCP_USER_MPU | OCP_USER_SDMA,
> > +};
> > +/* timer10 slave port */
> > +static struct omap_hwmod_ocp_if *omap2430_timer10_slaves[] = {
> > +&omap2430_l4_core__timer10,
> > +};
> > +/* timer10 hwmod */
> > +static struct omap_hwmod omap2430_timer10_hwmod = {
> > +       .name           = "timer10",
> > +       .mpu_irqs       = omap2430_timer10_mpu_irqs,
> > +       .mpu_irqs_cnt   = ARRAY_SIZE(omap2430_timer10_mpu_irqs),
> > +       .main_clk       = "gpt10_fck",
> > +       .prcm           = {
> > +               .omap2 = {
> > +                       .prcm_reg_id = 1,
> > +                       .module_bit = OMAP24XX_EN_GPT10_SHIFT,
> > +                       .module_offs = CORE_MOD,
> > +                       .idlest_reg_id = 1,
> > +                       .idlest_idle_bit = OMAP24XX_EN_GPT10_SHIFT,
> > +               },
> > +       },
> > +       .dev_attr       =&timer_dev_attr,
> > +       .slaves         = omap2430_timer10_slaves,
> > +       .slaves_cnt     = ARRAY_SIZE(omap2430_timer10_slaves),
> > +       .class          =&omap2430_timer_hwmod_class,
> > +       .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
> > +};
> > +
> > +/* timer11 */
> > +static struct omap_hwmod omap2430_timer11_hwmod;
> > +static struct omap_hwmod_irq_info omap2430_timer11_mpu_irqs[] = {
> > +       { .irq = INT_24XX_GPTIMER11, },
> > +};
> > +static struct omap_hwmod_addr_space omap2430_timer11_addrs[] = {
> > +       {
> > +               .pa_start       = 0x48088000,
> > +               .pa_end         = 0x48088000 + SZ_1K - 1,
> > +               .flags          = ADDR_TYPE_RT
> > +       },
> > +};
> > +/* l4_core ->  timer11 */
> > +static struct omap_hwmod_ocp_if omap2430_l4_core__timer11 = {
> > +       .master         =&omap2430_l4_core_hwmod,
> > +       .slave          =&omap2430_timer11_hwmod,
> > +       .clk            = "gpt11_ick",
> > +       .addr           = omap2430_timer11_addrs,
> > +       .addr_cnt       = ARRAY_SIZE(omap2430_timer11_addrs),
> > +       .user           = OCP_USER_MPU | OCP_USER_SDMA,
> > +};
> > +/* timer11 slave port */
> > +static struct omap_hwmod_ocp_if *omap2430_timer11_slaves[] = {
> > +&omap2430_l4_core__timer11,
> > +};
> > +/* timer11 hwmod */
> > +static struct omap_hwmod omap2430_timer11_hwmod = {
> > +       .name           = "timer11",
> > +       .mpu_irqs       = omap2430_timer11_mpu_irqs,
> > +       .mpu_irqs_cnt   = ARRAY_SIZE(omap2430_timer11_mpu_irqs),
> > +       .main_clk       = "gpt11_fck",
> > +       .prcm           = {
> > +               .omap2 = {
> > +                       .prcm_reg_id = 1,
> > +                       .module_bit = OMAP24XX_EN_GPT11_SHIFT,
> > +                       .module_offs = CORE_MOD,
> > +                       .idlest_reg_id = 1,
> > +                       .idlest_idle_bit = OMAP24XX_EN_GPT11_SHIFT,
> > +               },
> > +       },
> > +       .dev_attr       =&timer_dev_attr,
> > +       .slaves         = omap2430_timer11_slaves,
> > +       .slaves_cnt     = ARRAY_SIZE(omap2430_timer11_slaves),
> > +       .class          =&omap2430_timer_hwmod_class,
> > +       .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
> > +};
> > +
> > +
> > +/* timer12 */
> > +static struct omap_hwmod omap2430_timer12_hwmod;
> > +static struct omap_hwmod_irq_info omap2430_timer12_mpu_irqs[] = {
> > +       { .irq = INT_24XX_GPTIMER12, },
> > +};
> > +static struct omap_hwmod_addr_space omap2430_timer12_addrs[] = {
> > +       {
> > +               .pa_start       = 0x4808a000,
> > +               .pa_end         = 0x4808a000 + SZ_1K - 1,
> > +               .flags          = ADDR_TYPE_RT
> > +       },
> > +};
> > +/* l4_core ->  timer12 */
> > +static struct omap_hwmod_ocp_if omap2430_l4_core__timer12 = {
> > +       .master         =&omap2430_l4_core_hwmod,
> > +       .slave          =&omap2430_timer12_hwmod,
> > +       .clk            = "gpt12_ick",
> > +       .addr           = omap2430_timer12_addrs,
> > +       .addr_cnt       = ARRAY_SIZE(omap2430_timer12_addrs),
> > +       .user           = OCP_USER_MPU | OCP_USER_SDMA,
> > +};
> > +/* timer12 slave port */
> > +static struct omap_hwmod_ocp_if *omap2430_timer12_slaves[] = {
> > +&omap2430_l4_core__timer12,
> > +};
> > +/* timer12 hwmod */
> > +static struct omap_hwmod omap2430_timer12_hwmod = {
> > +       .name           = "timer12",
> > +       .mpu_irqs       = omap2430_timer12_mpu_irqs,
> > +       .mpu_irqs_cnt   = ARRAY_SIZE(omap2430_timer12_mpu_irqs),
> > +       .main_clk       = "gpt12_fck",
> > +       .prcm           = {
> > +               .omap2 = {
> > +                       .prcm_reg_id = 1,
> > +                       .module_bit = OMAP24XX_EN_GPT12_SHIFT,
> > +                       .module_offs = CORE_MOD,
> > +                       .idlest_reg_id = 1,
> > +                       .idlest_idle_bit = OMAP24XX_EN_GPT12_SHIFT,
> > +               },
> > +       },
> > +       .dev_attr       =&timer_dev_attr,
> > +       .slaves         = omap2430_timer12_slaves,
> > +       .slaves_cnt     = ARRAY_SIZE(omap2430_timer12_slaves),
> > +       .class          =&omap2430_timer_hwmod_class,
> > +       .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
> > +};
> > +
> >   /* MPU */
> >   static struct omap_hwmod omap2430_mpu_hwmod = {
> >          .name           = "mpu",
> > @@ -171,6 +779,18 @@ static __initdata struct omap_hwmod
> *omap2430_hwmods[] = {
> >          &omap2430_l4_wkup_hwmod,
> >          &omap2430_mpu_hwmod,
> >          &omap2430_iva_hwmod,
> > +&omap2430_timer1_hwmod,
> > +&omap2430_timer2_hwmod,
> > +&omap2430_timer3_hwmod,
> > +&omap2430_timer4_hwmod,
> > +&omap2430_timer5_hwmod,
> > +&omap2430_timer6_hwmod,
> > +&omap2430_timer7_hwmod,
> > +&omap2430_timer8_hwmod,
> > +&omap2430_timer9_hwmod,
> > +&omap2430_timer10_hwmod,
> > +&omap2430_timer11_hwmod,
> > +&omap2430_timer12_hwmod,
> >          NULL,
> >   };
> >
> > --
> > 1.6.0.4
> >

