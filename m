From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [PATCH V4] ARM: OMAP5/DRA7: realtime_counter: Configure CNTFRQ
 register
Date: Thu, 3 Oct 2013 15:49:37 +0530
Message-ID: <524D44B9.30208@ti.com>
References: <1379520162-31932-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60632 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374Ab3JCKUI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Oct 2013 06:20:08 -0400
In-Reply-To: <1379520162-31932-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, rnayak@ti.com, tony@atomide.com, nm@ti.com, marc.zyngier@arm.com, mark.rutland@arm.com

Hi Tony,

On Wednesday 18 September 2013 09:32 PM, Sricharan R wrote:
> The realtime counter called master counter, produces the count
> used by the private timer peripherals in the MPU_CLUSTER. The
> CNTFRQ per cpu register is used to denote the frequency of the counter.
> Currently the frequency value is passed from the
> DT file, but this is not scalable when we have other non-DT guest
> OS. This register must be set to the right value by the
> secure rom code. Setting this register helps in propagating the right
> frequency value across OSes.
>
> More discussions and the reason for adding this in a non-DT
> way can be seen from below.
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg93832.html
>
> So configuring this secure register for all the cpus here.
>
> While here, removing the clock-frequency DT entry for omap5 as
> it is no more needed after this patch.
>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Nishanth Menon <nm@ti.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Sricharan R <r.sricharan@ti.com>
> ---
> [V4] Updated commit log, removed the redundant entry in OMAP5.dtsi and
>      a unnecessary newline in timer.c
>
>  arch/arm/boot/dts/omap5.dtsi      |    1 -
>  arch/arm/mach-omap2/omap-secure.h |    2 ++
>  arch/arm/mach-omap2/omap-smp.c    |    9 +++++++++
>  arch/arm/mach-omap2/timer.c       |    5 +++++
>  4 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index 07be2cd..8a45512 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -52,7 +52,6 @@
>  			     <GIC_PPI 14 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>,
>  			     <GIC_PPI 11 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>,
>  			     <GIC_PPI 10 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>;
> -		clock-frequency = <6144000>;
>  	};
>  
>  	gic: interrupt-controller@48211000 {
> diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap2/omap-secure.h
> index 0e72917..5f88824 100644
> --- a/arch/arm/mach-omap2/omap-secure.h
> +++ b/arch/arm/mach-omap2/omap-secure.h
> @@ -42,6 +42,8 @@
>  #define OMAP4_MON_L2X0_AUXCTRL_INDEX	0x109
>  #define OMAP4_MON_L2X0_PREFETCH_INDEX	0x113
>  
> +#define OMAP5_DRA7_MON_SET_CNTFRQ_INDEX	0x109
> +
>  /* Secure PPA(Primary Protected Application) APIs */
>  #define OMAP4_PPA_L2_POR_INDEX		0x23
>  #define OMAP4_PPA_CPU_ACTRL_SMP_INDEX	0x25
> diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
> index 8708b2a..5a3c8d3 100644
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
> @@ -66,6 +68,13 @@ static void omap4_secondary_init(unsigned int cpu)
>  							4, 0, 0, 0, 0, 0);
>  
>  	/*
> +	 * Configure the CNTFRQ register for the secondary cpu's which
> +	 * indicates the frequency of the cpu local timers.
> +	 */
> +	if (soc_is_omap54xx() || soc_is_dra7xx())
> +		omap_smc1(OMAP5_DRA7_MON_SET_CNTFRQ_INDEX, arch_timer_freq);
> +
> +	/*
>  	 * Synchronise with the boot thread.
>  	 */
>  	spin_lock(&boot_lock);
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index fa74a06..d0af9b2 100644
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
> @@ -542,6 +544,9 @@ static void __init realtime_counter_init(void)
>  	reg |= den;
>  	__raw_writel(reg, base + INCREMENTER_DENUMERATOR_RELOAD_OFFSET);
>  
> +	arch_timer_freq = (rate / den) * num;
> +	omap_smc1(OMAP5_DRA7_MON_SET_CNTFRQ_INDEX, arch_timer_freq);
> +
>  	iounmap(base);
>  }
>  #else
 Are you planning to pull this patch and the below $subject patch as well? They are
 acked and tested.

 ARM: DRA7: realtime_counter: Add ratio registers for 20MHZ sys-clk frequency

  http://www.spinics.net/lists/linux-omap/msg97281.html

 
Regards,
 Sricharan
