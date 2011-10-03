From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH v2] OMAP2PLUS: DSS: Ensure DSS works correctly if display
 is enabled in bootloader
Date: Mon, 3 Oct 2011 10:52:03 +0530
Message-ID: <4E89467B.4080103@ti.com>
References: <1315811306-11001-1-git-send-email-archit@ti.com> <alpine.DEB.2.00.1110022237171.4611@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45118 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750976Ab1JCFUu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Oct 2011 01:20:50 -0400
In-Reply-To: <alpine.DEB.2.00.1110022237171.4611@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "R, Sricharan" <r.sricharan@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Paul,

On Monday 03 October 2011 10:15 AM, Paul Walmsley wrote:
> Hi
>
> some comments:
>
> On Mon, 12 Sep 2011, Archit Taneja wrote:
>
>> Resetting DISPC when a DISPC output is enabled causes the DSS to go into an
>> inconsistent state. Thus if the bootloader has enabled a display, the hwmod code
>> cannot reset the DISPC module just like that, but the outputs need to be
>> disabled first.
>>
>> Add function dispc_disable_outputs() which disables all active overlay manager
>> and ensure all frame transfers are completed.
>>
>> Modify omap_dss_reset() to call this function and clear DSS_CONTROL,
>> DSS_SDI_CONTROL and DSS_PLL_CONTROL so that DSS is in a clean state when the
>> DSS2 driver starts.
>>
>> This resolves the hang issue(caused by a L3 error during boot) seen on the
>> beagle board C3, which has a factory bootloader that enables display. The issue
>> is resolved with this patch.
>>
>> Acked-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
>> Tested-by: R, Sricharan<r.sricharan@ti.com>
>> Signed-off-by: Archit Taneja<archit@ti.com>
>> ---
>> v2:
>>
>> - Added more info in the commit message, fixed some typos.
>>
>> The patch depends on a HWMOD patch series which has been posted by Tomi, it can
>> be tested by applying over the following branch:
>>
>> https://gitorious.org/linux-omap-dss2/linux/commits/master
>>
>>   arch/arm/mach-omap2/display.c |  110 +++++++++++++++++++++++++++++++++++++++++
>>   1 files changed, 110 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
>> index 93db7c1..eab81f4 100644
>> --- a/arch/arm/mach-omap2/display.c
>> +++ b/arch/arm/mach-omap2/display.c
>> @@ -30,6 +30,30 @@
>>
>>   #include "control.h"
>>
>> +#define DISPC_BASE_OMAP2     0x48050400
>> +#define DISPC_BASE_OMAP4     0x48041000
>
> These should definitely not be needed -- they can be obtained from the
> hwmod data and there is clearly something wrong if any IP block addresses
> exist outside of those data files.

The reason we had to do this was because the function omap_dss_reset() 
is tied to the dss hwmod and not dispc hwmod. Hence, we don't have DISPC 
related info through the hwmod struct available through omap_dss_reset().

It would have been easy(and more sensible) if we had tied the code in 
dispc_disable_outputs() to a custom reset function for the dispc hwmod 
directly, but that unfortunately breaks some functionality. The current 
omap_dss_reset() function does this:

	- enable DSS opt clocks to complete power on reset.

	- see if the power on reset is completed by reading DSS_SYSNCONG

	- disable DSS opt clocks

If we don't do the things done in dispc_disable_outputs() before 
disabling DSS opt clocks, we would be in trouble.

Hence, there is a need to access DISPC registers in the dss hwmod 
itself, this forced us to create the base macros and the use of 
omap_readl/writel functions.

I considered changing the order in which the hwmods are registered, i.e 
dispc first and dss later, but that didn't seem right

Could you suggest how we could go about this? Is there a way to access 
dispc hwmod's data in dss hwmod's custom reset function?

I agree with all the other comments and things you have done in the 
patch you made. Thanks for the thorough review and the patch, i'll keep 
these comments in mind for future.

Regards,
Archit

>
>> +
>> +#define DISPC_REG(base, offset)      (base + offset)
>> +
>> +#define DISPC_CONTROL                0x0040
>> +#define DISPC_CONTROL2               0x0238
>> +#define DISPC_IRQSTATUS              0x0018
>> +
>> +#define DSS_SYSCONFIG                0x10
>> +#define DSS_SYSSTATUS                0x14
>> +#define DSS_CONTROL          0x40
>> +#define DSS_SDI_CONTROL              0x44
>> +#define DSS_PLL_CONTROL              0x48
>> +
>> +#define LCD_EN_MASK          (0x1<<  0)
>> +#define DIGIT_EN_MASK                (0x1<<  1)
>> +
>> +#define FRAMEDONE_IRQ_SHIFT  0
>> +#define EVSYNC_EVEN_IRQ_SHIFT        2
>> +#define EVSYNC_ODD_IRQ_SHIFT 3
>> +#define FRAMEDONE2_IRQ_SHIFT 22
>> +#define FRAMEDONETV_IRQ_SHIFT        24
>> +
>>   static struct platform_device omap_display_device = {
>>        .name          = "omapdss",
>>        .id            = -1,
>> @@ -182,6 +206,78 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
>>        return r;
>>   }
>>
>> +static void dispc_disable_outputs(void)
>> +{
>> +     u32 val, irq_mask, base;
>> +     bool lcd_en, digit_en, lcd2_en = false;
>> +     int i, num_mgrs;
>> +
>> +     if (cpu_is_omap44xx()) {
>> +             base = DISPC_BASE_OMAP4;
>> +             num_mgrs = 3;
>> +     } else {
>> +             base = DISPC_BASE_OMAP2;
>> +             num_mgrs = 2;
>> +     }
>
> base should not be needed here.  The num_mgrs should come from the hwmod
> data.  We're trying to get rid of cpu_is_omap*() functions wherever
> possible.
>
>> +
>> +     /* store value of LCDENABLE and DIGITENABLE bits */
>> +     val = omap_readl(DISPC_REG(base, DISPC_CONTROL));
>
> omap_{read,write}l() are deprecated and should no longer be used.  This
> code can use omap_hwmod_{read,write}() instead.  You can pass the struct
> omap_hwmod * into this function from the caller.
>
>> +     lcd_en = val&  LCD_EN_MASK;
>> +     digit_en = val&  DIGIT_EN_MASK;
>> +
>> +     /* store value of LCDENABLE for LCD2 */
>> +     if (num_mgrs>  2) {
>> +             val = omap_readl(DISPC_REG(base, DISPC_CONTROL2));
>> +             lcd2_en = val&  LCD_EN_MASK;
>> +     }
>> +
>> +     /*
>> +      * If any manager was enabled, we need to disable it before DSS clocks
>> +      * are disabled or DISPC module is reset
>> +      */
>> +     if (lcd_en || digit_en || lcd2_en) {
>
> Rather than this massive if block, please test the inverse condition and
> bail out early.  This avoids unnecessary indentation levels that make code
> harder to read.
>
>> +             irq_mask = (lcd_en ? 1 : 0)<<  FRAMEDONE_IRQ_SHIFT;
>> +
>> +             if (cpu_is_omap44xx())
>> +                     irq_mask |= (digit_en ? 1 : 0)<<  FRAMEDONETV_IRQ_SHIFT;
>> +             else
>> +                     irq_mask |= (digit_en ? 1 : 0)<<  EVSYNC_EVEN_IRQ_SHIFT |
>> +                             (digit_en ? 1 : 0)<<  EVSYNC_ODD_IRQ_SHIFT;
>
> Rather than a cpu_is_omap*() test, the presence of a working FRAMEDONETV
> interrupt bit should be passed through the hwmod data.
>
>> +
>> +             irq_mask |= (lcd2_en ? 1 : 0)<<  FRAMEDONE2_IRQ_SHIFT;
>> +
>> +             /*
>> +              * clear any previous FRAMEDONE, FRAMEDONETV, EVSYNC_EVEN/ODD
>> +              * or FRAMEDONE2 interrupts
>> +              */
>> +             omap_writel(irq_mask, DISPC_REG(base, DISPC_IRQSTATUS));
>> +
>> +             /* disable LCD and TV managers */
>> +             val = omap_readl(DISPC_REG(base, DISPC_CONTROL));
>> +             val&= ~(LCD_EN_MASK | DIGIT_EN_MASK);
>> +             omap_writel(val, DISPC_REG(base, DISPC_CONTROL));
>> +
>> +             /* disable LCD2 manager */
>> +             if (num_mgrs>  2) {
>> +                     val = omap_readl(DISPC_REG(base, DISPC_CONTROL2));
>> +                     val&= ~LCD_EN_MASK;
>> +                     omap_writel(val, DISPC_REG(base, DISPC_CONTROL2));
>> +             }
>> +
>> +             i = 0;
>> +             while ((omap_readl(DISPC_REG(base, DISPC_IRQSTATUS))&  irq_mask) !=
>> +                             irq_mask) {
>> +                     i++;
>> +                     if (i>  100) {
>
> Please hoist this constant up to the top of this file, and use a macro
> with a comment.
>
>> +                             printk(KERN_ERR "didn't get FRAMEDONE1/2 or TV"
>> +                                     " interrupt\n");
>
> pr_err() is shorter and better here.
>
>> +                             break;
>> +                     }
>> +                     mdelay(1);
>> +             }
>> +     }
>> +}
>> +
>>   #define MAX_MODULE_SOFTRESET_WAIT    10000
>>   int omap_dss_reset(struct omap_hwmod *oh)
>>   {
>> @@ -198,6 +294,20 @@ int omap_dss_reset(struct omap_hwmod *oh)
>>                if (oc->_clk)
>>                        clk_enable(oc->_clk);
>>
>> +     dispc_disable_outputs();
>
> Pass the struct omap_hwmod *oh in here.
>
>> +
>> +     /* clear SDI registers */
>> +     if (cpu_is_omap3430()) {
>> +             omap_hwmod_write(0x0, oh, DSS_SDI_CONTROL);
>> +             omap_hwmod_write(0x0, oh, DSS_PLL_CONTROL);
>> +     }
>> +
>> +     /*
>> +      * clear DSS_CONTROL register to switch DSS clock sources to
>> +      * PRCM clock, if any
>> +      */
>> +     omap_hwmod_write(0x0, oh, DSS_CONTROL);
>> +
>>        omap_test_timeout((omap_hwmod_read(oh, oh->class->sysc->syss_offs)
>>                                &  SYSS_RESETDONE_MASK),
>>                        MAX_MODULE_SOFTRESET_WAIT, c);
>> --
>> 1.7.1
>
> In the interest of expediency, I've made the above changes to the patch --
> updated patch below.  The following Compile-tested only, so could you
> review it please and make sure I haven't broken anything?  For future
> patches, please keep the comments above in mind.
>
> thanks,
>
>
> - Paul
>
> From: Archit Taneja<archit@ti.com>
> Date: Mon, 12 Sep 2011 12:38:26 +0530
> Subject: [PATCH 1/2] ARM: OMAP2PLUS: DSS: Ensure DSS works correctly if
>   display is enabled in bootloader
>
> Resetting DISPC when a DISPC output is enabled causes the DSS to go into an
> inconsistent state. Thus if the bootloader has enabled a display, the hwmod code
> cannot reset the DISPC module just like that, but the outputs need to be
> disabled first.
>
> Add function dispc_disable_outputs() which disables all active overlay manager
> and ensure all frame transfers are completed.
>
> Modify omap_dss_reset() to call this function and clear DSS_CONTROL,
> DSS_SDI_CONTROL and DSS_PLL_CONTROL so that DSS is in a clean state when the
> DSS2 driver starts.
>
> This resolves the hang issue(caused by a L3 error during boot) seen on the
> beagle board C3, which has a factory bootloader that enables display. The issue
> is resolved with this patch.
>
> Acked-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
> Tested-by: R, Sricharan<r.sricharan@ti.com>
> Signed-off-by: Archit Taneja<archit@ti.com>
> [paul@pwsan.com: restructured code, removed omap_{read,write}l(), removed
>   cpu_is_omap*() calls and converted to dev_attr]
> Signed-off-by: Paul Walmsley<paul@pwsan.com>
> ---
>   arch/arm/mach-omap2/display.c                |  118 ++++++++++++++++++++++++++
>   arch/arm/mach-omap2/display.h                |   29 ++++++
>   arch/arm/mach-omap2/omap_hwmod_2420_data.c   |    1 +
>   arch/arm/mach-omap2/omap_hwmod_2430_data.c   |    1 +
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |    1 +
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |    6 ++
>   arch/arm/mach-omap2/omap_hwmod_common_data.c |    4 +
>   arch/arm/mach-omap2/omap_hwmod_common_data.h |    4 +
>   8 files changed, 164 insertions(+), 0 deletions(-)
>   create mode 100644 arch/arm/mach-omap2/display.h
>
> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
> index cdb675a..fcd2c3a 100644
> --- a/arch/arm/mach-omap2/display.c
> +++ b/arch/arm/mach-omap2/display.c
> @@ -28,6 +28,33 @@
>   #include<plat/omap-pm.h>
>   #include<plat/common.h>
>
> +#include "display.h"
> +
> +#define DISPC_CONTROL          0x0040
> +#define DISPC_CONTROL2         0x0238
> +#define DISPC_IRQSTATUS                0x0018
> +
> +#define DSS_SYSCONFIG          0x10
> +#define DSS_SYSSTATUS          0x14
> +#define DSS_CONTROL            0x40
> +#define DSS_SDI_CONTROL                0x44
> +#define DSS_PLL_CONTROL                0x48
> +
> +#define LCD_EN_MASK            (0x1<<  0)
> +#define DIGIT_EN_MASK          (0x1<<  1)
> +
> +#define FRAMEDONE_IRQ_SHIFT    0
> +#define EVSYNC_EVEN_IRQ_SHIFT  2
> +#define EVSYNC_ODD_IRQ_SHIFT   3
> +#define FRAMEDONE2_IRQ_SHIFT   22
> +#define FRAMEDONETV_IRQ_SHIFT  24
> +
> +/*
> + * FRAMEDONE_IRQ_TIMEOUT: how long (in milliseconds) to wait during DISPC
> + *     reset before deciding that something has gone wrong
> + */
> +#define FRAMEDONE_IRQ_TIMEOUT          100
> +
>   static struct platform_device omap_display_device = {
>          .name          = "omapdss",
>          .id            = -1,
> @@ -128,6 +155,83 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
>          return r;
>   }
>
> +static void dispc_disable_outputs(struct omap_hwmod *oh)
> +{
> +       u32 v, irq_mask = 0;
> +       bool lcd_en, digit_en, lcd2_en = false;
> +       int i;
> +       struct omap_dss_dispc_dev_attr *da;
> +
> +       if (!oh->dev_attr) {
> +               pr_err("display: could not disable outputs during reset due to missing dev_attr\n");
> +               return;
> +       }
> +
> +       da = (struct omap_dss_dispc_dev_attr *)oh->dev_attr;
> +
> +       /* store value of LCDENABLE and DIGITENABLE bits */
> +       v = omap_hwmod_read(oh, DISPC_CONTROL);
> +       lcd_en = v&  LCD_EN_MASK;
> +       digit_en = v&  DIGIT_EN_MASK;
> +
> +       /* store value of LCDENABLE for LCD2 */
> +       if (da->manager_count>  2) {
> +               v = omap_hwmod_read(oh, DISPC_CONTROL2);
> +               lcd2_en = v&  LCD_EN_MASK;
> +       }
> +
> +       if (!(lcd_en | digit_en | lcd2_en))
> +               return; /* no managers currently enabled */
> +
> +       /*
> +        * If any manager was enabled, we need to disable it before
> +        * DSS clocks are disabled or DISPC module is reset
> +        */
> +       if (lcd_en)
> +               irq_mask |= 1<<  FRAMEDONE_IRQ_SHIFT;
> +
> +       if (digit_en) {
> +               if (da->has_framedonetv_irq) {
> +                       irq_mask |= 1<<  FRAMEDONETV_IRQ_SHIFT;
> +               } else {
> +                       irq_mask |= 1<<  EVSYNC_EVEN_IRQ_SHIFT |
> +                               1<<  EVSYNC_ODD_IRQ_SHIFT;
> +               }
> +       }
> +
> +       if (lcd2_en)
> +               irq_mask |= 1<<  FRAMEDONE2_IRQ_SHIFT;
> +
> +       /*
> +        * clear any previous FRAMEDONE, FRAMEDONETV,
> +        * EVSYNC_EVEN/ODD or FRAMEDONE2 interrupts
> +        */
> +       omap_hwmod_write(irq_mask, oh, DISPC_IRQSTATUS);
> +
> +       /* disable LCD and TV managers */
> +       v = omap_hwmod_read(oh, DISPC_CONTROL);
> +       v&= ~(LCD_EN_MASK | DIGIT_EN_MASK);
> +       omap_hwmod_write(v, oh, DISPC_CONTROL);
> +
> +       /* disable LCD2 manager */
> +       if (da->manager_count>  2) {
> +               v = omap_hwmod_read(oh, DISPC_CONTROL2);
> +               v&= ~LCD_EN_MASK;
> +               omap_hwmod_write(v, oh, DISPC_CONTROL2);
> +       }
> +
> +       i = 0;
> +       while ((omap_hwmod_read(oh, DISPC_IRQSTATUS)&  irq_mask) !=
> +              irq_mask) {
> +               i++;
> +               if (i>  FRAMEDONE_IRQ_TIMEOUT) {
> +                       pr_err("didn't get FRAMEDONE1/2 or TV interrupt\n");
> +                       break;
> +               }
> +               mdelay(1);
> +       }
> +}
> +
>   #define MAX_MODULE_SOFTRESET_WAIT      10000
>   int omap_dss_reset(struct omap_hwmod *oh)
>   {
> @@ -144,6 +248,20 @@ int omap_dss_reset(struct omap_hwmod *oh)
>                  if (oc->_clk)
>                          clk_enable(oc->_clk);
>
> +       dispc_disable_outputs(oh);
> +
> +       /* clear SDI registers */
> +       if (cpu_is_omap3430()) {
> +               omap_hwmod_write(0x0, oh, DSS_SDI_CONTROL);
> +               omap_hwmod_write(0x0, oh, DSS_PLL_CONTROL);
> +       }
> +
> +       /*
> +        * clear DSS_CONTROL register to switch DSS clock sources to
> +        * PRCM clock, if any
> +        */
> +       omap_hwmod_write(0x0, oh, DSS_CONTROL);
> +
>          omap_test_timeout((omap_hwmod_read(oh, oh->class->sysc->syss_offs)
>                                  &  SYSS_RESETDONE_MASK),
>                          MAX_MODULE_SOFTRESET_WAIT, c);
> diff --git a/arch/arm/mach-omap2/display.h b/arch/arm/mach-omap2/display.h
> new file mode 100644
> index 0000000..b871b01
> --- /dev/null
> +++ b/arch/arm/mach-omap2/display.h
> @@ -0,0 +1,29 @@
> +/*
> + * display.h - OMAP2+ integration-specific DSS header
> + *
> + * Copyright (C) 2011 Texas Instruments, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see<http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef __ARCH_ARM_MACH_OMAP2_DISPLAY_H
> +#define __ARCH_ARM_MACH_OMAP2_DISPLAY_H
> +
> +#include<linux/kernel.h>
> +
> +struct omap_dss_dispc_dev_attr {
> +       u8      manager_count;
> +       bool    has_framedonetv_irq;
> +};
> +
> +#endif
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> index 09d9395..8e32cb3 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> @@ -945,6 +945,7 @@ static struct omap_hwmod omap2420_dss_dispc_hwmod = {
>          .slaves_cnt     = ARRAY_SIZE(omap2420_dss_dispc_slaves),
>          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
>          .flags          = HWMOD_NO_IDLEST,
> +       .dev_attr       =&omap2_3_dss_dispc_dev_attr
>   };
>
>   /* l4_core ->  dss_rfbi */
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> index 67aff19..6e8ef12 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> @@ -1005,6 +1005,7 @@ static struct omap_hwmod omap2430_dss_dispc_hwmod = {
>          .slaves_cnt     = ARRAY_SIZE(omap2430_dss_dispc_slaves),
>          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
>          .flags          = HWMOD_NO_IDLEST,
> +       .dev_attr       =&omap2_3_dss_dispc_dev_attr
>   };
>
>   /* l4_core ->  dss_rfbi */
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 4a02cc3..12988fe 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -1465,6 +1465,7 @@ static struct omap_hwmod omap3xxx_dss_dispc_hwmod = {
>                                  CHIP_GE_OMAP3430ES2 | CHIP_IS_OMAP3630ES1 |
>                                  CHIP_GE_OMAP3630ES1_1),
>          .flags          = HWMOD_NO_IDLEST,
> +       .dev_attr       =&omap2_3_dss_dispc_dev_attr
>   };
>
>   /*
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 7a7489e..17adfb3 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -1345,6 +1345,11 @@ static struct omap_hwmod_addr_space omap44xx_dss_dispc_addrs[] = {
>          { }
>   };
>
> +static struct omap_dss_dispc_dev_attr omap44xx_dss_dispc_dev_attr = {
> +       .manager_count          = 3,
> +       .has_framedonetv_irq    = 1
> +};
> +
>   /* l4_per ->  dss_dispc */
>   static struct omap_hwmod_ocp_if omap44xx_l4_per__dss_dispc = {
>          .master         =&omap44xx_l4_per_hwmod,
> @@ -1376,6 +1381,7 @@ static struct omap_hwmod omap44xx_dss_dispc_hwmod = {
>          .slaves         = omap44xx_dss_dispc_slaves,
>          .slaves_cnt     = ARRAY_SIZE(omap44xx_dss_dispc_slaves),
>          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +       .dev_attr       =&omap44xx_dss_dispc_dev_attr
>   };
>
>   /*
> diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.c b/arch/arm/mach-omap2/omap_hwmod_common_data.c
> index de832eb..51e5418 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_common_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_common_data.c
> @@ -49,3 +49,7 @@ struct omap_hwmod_sysc_fields omap_hwmod_sysc_type2 = {
>          .srst_shift     = SYSC_TYPE2_SOFTRESET_SHIFT,
>   };
>
> +struct omap_dss_dispc_dev_attr omap2_3_dss_dispc_dev_attr = {
> +       .manager_count          = 2,
> +       .has_framedonetv_irq    = 0
> +};
> diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.h b/arch/arm/mach-omap2/omap_hwmod_common_data.h
> index 39a7c37..ad5d8f0 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_common_data.h
> +++ b/arch/arm/mach-omap2/omap_hwmod_common_data.h
> @@ -16,6 +16,8 @@
>
>   #include<plat/omap_hwmod.h>
>
> +#include "display.h"
> +
>   /* Common address space across OMAP2xxx */
>   extern struct omap_hwmod_addr_space omap2xxx_uart1_addr_space[];
>   extern struct omap_hwmod_addr_space omap2xxx_uart2_addr_space[];
> @@ -111,4 +113,6 @@ extern struct omap_hwmod_class omap2xxx_dma_hwmod_class;
>   extern struct omap_hwmod_class omap2xxx_mailbox_hwmod_class;
>   extern struct omap_hwmod_class omap2xxx_mcspi_class;
>
> +extern struct omap_dss_dispc_dev_attr omap2_3_dss_dispc_dev_attr;
> +
>   #endif
> --
> 1.7.6.3
>
>

