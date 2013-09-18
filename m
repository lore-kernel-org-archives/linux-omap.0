From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP5/DRA7: realtime_counter: Configure CNTFRQ register
Date: Wed, 18 Sep 2013 09:31:24 -0400
Message-ID: <5239AB2C.1090201@ti.com>
References: <1379503416-26318-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36025 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752607Ab3IRNcA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Sep 2013 09:32:00 -0400
In-Reply-To: <1379503416-26318-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, rnayak@ti.com, tony@atomide.com, nm@ti.com, marc.zyngier@arm.com, mark.rutland@arm.com

On Wednesday 18 September 2013 07:23 AM, Sricharan R wrote:
> The realtime counter called master counter, produces the count
> used by the private timer peripherals in the MPU_CLUSTER. The
> CNTFRQ per cpu register is used to denote the frequency of the counter.
> Currently the frequency value is passed from the
> DT file, but this is not scalable when we have other non-DT guest
> OS. This register must be set to the right value by the
> host OS, as this will be propagated to the guests as well.
> 
Its not host OS but ROM code/secure code. Host OS is not
ideal place to set it up.

> More discussions and the reason for adding this in a non-DT
> way can be seen from below.
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg93832.html
> 
> So configuring this secure register for all the cpus here.
> 
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Sricharan R <r.sricharan@ti.com>
> ---
>  arch/arm/mach-omap2/omap-secure.h |    2 ++
>  arch/arm/mach-omap2/omap-smp.c    |    9 +++++++++
>  arch/arm/mach-omap2/timer.c       |    6 ++++++
>  3 files changed, 17 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap2/omap-secure.h
> index a171a5a..4de9a00 100644
> --- a/arch/arm/mach-omap2/omap-secure.h
> +++ b/arch/arm/mach-omap2/omap-secure.h
> @@ -51,6 +51,8 @@
>  
>  #define OMAP5_MON_AMBA_IF_INDEX		0x108
>  
> +#define OMAP5_DRA7_MON_SET_CNTFRQ_INDEX	0x109
> +
Nice. Looks like OMAP5 ES2.0 addition which I missed.

>  /* Secure PPA(Primary Protected Application) APIs */
>  #define OMAP4_PPA_L2_POR_INDEX		0x23
>  #define OMAP4_PPA_CPU_ACTRL_SMP_INDEX	0x25
> diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
> index 98a1146..00873b4 100644
> --- a/arch/arm/mach-omap2/omap-smp.c
> +++ b/arch/arm/mach-omap2/omap-smp.c
> @@ -41,6 +41,8 @@
>  
>  u16 pm44xx_errata;
>  
> +extern unsigned long arch_timer_freq;
> +
>  /* SCU base address */
>  static void __iomem *scu_base;
>  
> @@ -66,6 +68,13 @@ static void __cpuinit omap4_secondary_init(unsigned int cpu)
>  							4, 0, 0, 0, 0, 0);
>  
>  	/*
> +	 * Configure the CNTFRQ register for the secondary cpu's which
> +	 * indicates the frequency of the cpu local timers.
> +	 */
> +	if (soc_is_omap54xx() || soc_is_dra7xx())
CNTFREQ programming was not supported on OMAP5 ES1.0 and that was one
of the reason this parameter came into picture. So you need to skip
the ES1.0 here. 

> +		omap_smc1(OMAP5_DRA7_MON_SET_CNTFRQ_INDEX, arch_timer_freq);
> +
> +	/*
>  	 * Synchronise with the boot thread.
>  	 */
>  	spin_lock(&boot_lock);
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index fd9238d..2c499f3 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -55,6 +55,7 @@
>  #include "soc.h"
>  #include "common.h"
>  #include "powerdomain.h"
> +#include "omap-secure.h"
>  
>  #define REALTIME_COUNTER_BASE				0x48243200
>  #define INCREMENTER_NUMERATOR_OFFSET			0x10
> @@ -65,6 +66,7 @@
>  
>  static struct omap_dm_timer clkev;
>  static struct clock_event_device clockevent_gpt;
> +unsigned long arch_timer_freq;
>  
>  static irqreturn_t omap2_gp_timer_interrupt(int irq, void *dev_id)
>  {
> @@ -546,7 +548,11 @@ static void __init realtime_counter_init(void)
>  	reg |= den;
>  	__raw_writel(reg, base + INCREMENTER_DENUMERATOR_RELOAD_OFFSET);
>  
> +	arch_timer_freq = (rate / den) * num;
> +
>  	iounmap(base);
> +
> +	omap_smc1(OMAP5_DRA7_MON_SET_CNTFRQ_INDEX, arch_timer_freq);

Few problems with this approach..

1. CNTFREQ needs to be programmed on all CPUs. Even though arch-timer
code uses boot-cpu now thats not safe for guest which can start on
secondary CPUs. So please update this in secondary boot path as well.

2. When you power cycle CPU, you will loose the value of this register
so you need to reprogram them on every CPU power up. Both DRA and OMAP5
doesn't support that part yet but do remember to patch that when
such support gets added.

Can you please fix above comments and repost. I will ack that then.

Regards,
Santosh

