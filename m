From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP5: Enable arch timer support
Date: Thu, 13 Sep 2012 10:56:25 +0200
Message-ID: <50519FB9.9060208@ti.com>
References: <1344856045-15134-1-git-send-email-santosh.shilimkar@ti.com> <1344856045-15134-3-git-send-email-santosh.shilimkar@ti.com> <504DE165.4000208@ti.com> <CAMQu2gxE8e9RBykLDyukZwV7dPKv3nG1vCynO1pijUBXBnyq8Q@mail.gmail.com> <504DE79B.3090302@ti.com> <CAMQu2gwT=XHcZtdKfYacGyt21Mo0of8MmSMNE+0PP9wemKSyxw@mail.gmail.com> <CAMQu2gzKDLBJmVdm0SUr0ec=LueT0mqBUYmHyGMsav5k=ggKQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56224 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751941Ab2IMI43 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Sep 2012 04:56:29 -0400
In-Reply-To: <CAMQu2gzKDLBJmVdm0SUr0ec=LueT0mqBUYmHyGMsav5k=ggKQg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.orig

Hi Santosh,

On 09/11/2012 11:29 AM, Shilimkar, Santosh wrote:
> Benoit,
> 
> On Mon, Sep 10, 2012 at 7:09 PM, Shilimkar, Santosh
> <santosh.shilimkar@ti.com> wrote:
>> On Mon, Sep 10, 2012 at 6:44 PM, Benoit Cousson <b-cousson@ti.com> wrote:
>>>
> 
> [...]
> 
>>>>> Silly question: Don't we have one arch-timer per CPU?
>>>>>
>>>> It is per CPU just like A9 TWD
>>>
>>> Shouldn't we have two nodes then?
>>>
>> I need to check this but arch timer DT node should be same
>> as the twd DT node. May be one node with reference to
>> each CPU node should do but am not too sure about the DT
>> nodes and how all that work.
>>
> Here is an updated patch based on our discussion. Thanks for comments.
> Let me know if you are ok with this version.

Cool, thanks for the update.

> From 98f6a3b4b52ef7c76ed8b19bf9257c51ee5d7323 Mon Sep 17 00:00:00 2001
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Date: Mon, 13 Aug 2012 14:39:03 +0530
> Subject: [PATCH] ARM: OMAP5: Enable arch timer support
> 
> Enable Cortex A15 generic timer support for OMAP5 based SOCs.
> The CPU local timers run on the free running real time counter clock.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Benoit Cousson <b-cousson@ti.com>

Tony,

I can potentially add it along with the timer changes in the dts part2
series if you ack the timer patch. We don't have tons of OMAP5 content
in the dts branch so it should not conflict.

Regards,
Benoit

> ---
>  arch/arm/boot/dts/omap5.dtsi |   12 ++++++++++++
>  arch/arm/mach-omap2/Kconfig  |    1 +
>  arch/arm/mach-omap2/timer.c  |    7 +++++++
>  3 files changed, 20 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index 57e5270..7b986ed 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -33,9 +33,21 @@
>  	cpus {
>  		cpu@0 {
>  			compatible = "arm,cortex-a15";
> +			timer {
> +				compatible = "arm,armv7-timer";
> +				/* 14th PPI IRQ, active low level-sensitive */
> +				interrupts = <1 14 0x308>;
> +				clock-frequency = <6144000>;
> +			};
>  		};
>  		cpu@1 {
>  			compatible = "arm,cortex-a15";
> +			timer {
> +				compatible = "arm,armv7-timer";
> +				/* 14th PPI IRQ, active low level-sensitive */
> +				interrupts = <1 14 0x308>;
> +				clock-frequency = <6144000>;
> +			};
>  		};
>  	};
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 2120f90..53fb77c 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -73,6 +73,7 @@ config SOC_OMAP5
>  	select ARM_GIC
>  	select HAVE_SMP
>  	select SOC_HAS_REALTIME_COUNTER
> +	select ARM_ARCH_TIMER
> 
>  comment "OMAP Core Type"
>  	depends on ARCH_OMAP2
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index 8f5b88b..46982d0 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -41,6 +41,7 @@
>  #include <plat/dmtimer.h>
>  #include <asm/smp_twd.h>
>  #include <asm/sched_clock.h>
> +#include <asm/arch_timer.h>
>  #include "common.h"
>  #include <plat/omap_hwmod.h>
>  #include <plat/omap_device.h>
> @@ -481,9 +482,15 @@ OMAP_SYS_TIMER(4)
>  #ifdef CONFIG_SOC_OMAP5
>  static void __init omap5_timer_init(void)
>  {
> +	int err;
> +
>  	omap2_gp_clockevent_init(1, OMAP4_CLKEV_SOURCE);
>  	omap2_clocksource_init(2, OMAP4_MPU_SOURCE);
>  	realtime_counter_init();
> +
> +	err = arch_timer_of_register();
> +	if (err)
> +		pr_err("%s: arch_timer_register failed %d\n", __func__, err);
>  }
>  OMAP_SYS_TIMER(5)
>  #endif
> 

