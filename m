From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP5: Enable arch timer support
Date: Mon, 10 Sep 2012 14:47:33 +0200
Message-ID: <504DE165.4000208@ti.com>
References: <1344856045-15134-1-git-send-email-santosh.shilimkar@ti.com> <1344856045-15134-3-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50143 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757750Ab2IJMrh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Sep 2012 08:47:37 -0400
In-Reply-To: <1344856045-15134-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.orig, tony@atomide.com

Hi Santosh,

On 08/13/2012 01:07 PM, Santosh Shilimkar wrote:
> Enable Cortex A15 generic timer support for OMAP5 based SOCs.
> The CPU local timers run on the free running real time counter clock.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/boot/dts/omap5.dtsi |    6 ++++++
>  arch/arm/mach-omap2/Kconfig  |    1 +
>  arch/arm/mach-omap2/timer.c  |    7 +++++++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index 57e5270..9686056 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -73,6 +73,12 @@
>  			      <0x48212000 0x1000>;
>  		};
>  
> +		arch-timer {

arch-timer is the ARM specific name, so I guess here it should be named
with the generic timer name.

> +			compatible = "arm,armv7-timer";
> +			interrupts = <1 14 0x304>;

Could you add some comment, because these hexa value are a little bit
hard to understand.

> +			clock-frequency = <6140000>;
> +		};
> +

That node does not even have a base address?
If this is located inside the MPU, it should not be in the OCP node.

Silly question: Don't we have one arch-timer per CPU?

Regards,
Benoit


>  		gpio1: gpio@4ae10000 {
>  			compatible = "ti,omap4-gpio";
>  			ti,hwmods = "gpio1";
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
> index 9b17e6c..f74dbb2 100644
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
> @@ -480,9 +481,15 @@ OMAP_SYS_TIMER(4)
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

