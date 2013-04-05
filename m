From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v3 4/4] ARM: OMAP4+: CPUidle: Consolidate idle driver for
 OMAP5 support
Date: Fri, 05 Apr 2013 14:29:03 -0700
Message-ID: <878v4wll9c.fsf@linaro.org>
References: <1365166743-5940-1-git-send-email-santosh.shilimkar@ti.com>
 <1365166743-5940-5-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1365166743-5940-5-git-send-email-santosh.shilimkar@ti.com>
 (Santosh Shilimkar's message of "Fri, 5 Apr 2013 18:29:03 +0530")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> The OMAP5 idle driver can re-use most of OMAP4 CPUidle driver
> implementation. Also the next derivative SOCs are going to re-use
> the MPUSS so, same driver with minor updates can be re-used.
>
> Prepare the code so that its easier to add CPUidle support for
> OMAP5 devices.
>
> Acked-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Due to dependencies, I'll add this one to my for_3.10/cleanup/cpuidle
branch.

Kevin

> ---
>  arch/arm/mach-omap2/cpuidle44xx.c |   31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
> index 767f657..ca1551a 100644
> --- a/arch/arm/mach-omap2/cpuidle44xx.c
> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
> @@ -1,7 +1,7 @@
>  /*
> - * OMAP4 CPU idle Routines
> + * OMAP4+ CPU idle Routines
>   *
> - * Copyright (C) 2011 Texas Instruments, Inc.
> + * Copyright (C) 2011-2013 Texas Instruments, Inc.
>   * Santosh Shilimkar <santosh.shilimkar@ti.com>
>   * Rajendra Nayak <rnayak@ti.com>
>   *
> @@ -24,13 +24,13 @@
>  #include "clockdomain.h"
>  
>  /* Machine specific information */
> -struct omap4_idle_statedata {
> +struct idle_statedata {
>  	u32 cpu_state;
>  	u32 mpu_logic_state;
>  	u32 mpu_state;
>  };
>  
> -static struct omap4_idle_statedata omap4_idle_data[] = {
> +static struct idle_statedata omap4_idle_data[] = {
>  	{
>  		.cpu_state = PWRDM_POWER_ON,
>  		.mpu_state = PWRDM_POWER_ON,
> @@ -53,11 +53,12 @@ static struct clockdomain *cpu_clkdm[NR_CPUS];
>  
>  static atomic_t abort_barrier;
>  static bool cpu_done[NR_CPUS];
> +static struct idle_statedata *state_ptr = &omap4_idle_data[0];
>  
>  /* Private functions */
>  
>  /**
> - * omap4_enter_idle_coupled_[simple/coupled] - OMAP4 cpuidle entry functions
> + * omap_enter_idle_[simple/coupled] - OMAP4PLUS cpuidle entry functions
>   * @dev: cpuidle device
>   * @drv: cpuidle driver
>   * @index: the index of state to be entered
> @@ -66,7 +67,7 @@ static bool cpu_done[NR_CPUS];
>   * specified low power state selected by the governor.
>   * Returns the amount of time spent in the low power state.
>   */
> -static int omap4_enter_idle_simple(struct cpuidle_device *dev,
> +static int omap_enter_idle_simple(struct cpuidle_device *dev,
>  			struct cpuidle_driver *drv,
>  			int index)
>  {
> @@ -74,11 +75,11 @@ static int omap4_enter_idle_simple(struct cpuidle_device *dev,
>  	return index;
>  }
>  
> -static int omap4_enter_idle_coupled(struct cpuidle_device *dev,
> +static int omap_enter_idle_coupled(struct cpuidle_device *dev,
>  			struct cpuidle_driver *drv,
>  			int index)
>  {
> -	struct omap4_idle_statedata *cx = &omap4_idle_data[index];
> +	struct idle_statedata *cx = state_ptr + index;
>  	int cpu_id = smp_processor_id();
>  
>  	/*
> @@ -168,7 +169,7 @@ static void omap_setup_broadcast_timer(void *arg)
>  	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ON, &cpu);
>  }
>  
> -static DEFINE_PER_CPU(struct cpuidle_device, omap4_idle_dev);
> +static DEFINE_PER_CPU(struct cpuidle_device, omap_idle_dev);
>  
>  static struct cpuidle_driver omap4_idle_driver = {
>  	.name				= "omap4_idle",
> @@ -180,7 +181,7 @@ static struct cpuidle_driver omap4_idle_driver = {
>  			.exit_latency = 2 + 2,
>  			.target_residency = 5,
>  			.flags = CPUIDLE_FLAG_TIME_VALID,
> -			.enter = omap4_enter_idle_simple,
> +			.enter = omap_enter_idle_simple,
>  			.name = "C1",
>  			.desc = "CPUx ON, MPUSS ON"
>  		},
> @@ -189,7 +190,7 @@ static struct cpuidle_driver omap4_idle_driver = {
>  			.exit_latency = 328 + 440,
>  			.target_residency = 960,
>  			.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED,
> -			.enter = omap4_enter_idle_coupled,
> +			.enter = omap_enter_idle_coupled,
>  			.name = "C2",
>  			.desc = "CPUx OFF, MPUSS CSWR",
>  		},
> @@ -198,7 +199,7 @@ static struct cpuidle_driver omap4_idle_driver = {
>  			.exit_latency = 460 + 518,
>  			.target_residency = 1100,
>  			.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED,
> -			.enter = omap4_enter_idle_coupled,
> +			.enter = omap_enter_idle_coupled,
>  			.name = "C3",
>  			.desc = "CPUx OFF, MPUSS OSWR",
>  		},
> @@ -210,9 +211,9 @@ static struct cpuidle_driver omap4_idle_driver = {
>  /* Public functions */
>  
>  /**
> - * omap4_idle_init - Init routine for OMAP4 idle
> + * omap4_idle_init - Init routine for OMAP4+ idle
>   *
> - * Registers the OMAP4 specific cpuidle driver to the cpuidle
> + * Registers the OMAP4+ specific cpuidle driver to the cpuidle
>   * framework with the valid set of states.
>   */
>  int __init omap4_idle_init(void)
> @@ -240,7 +241,7 @@ int __init omap4_idle_init(void)
>  	}
>  
>  	for_each_cpu(cpu_id, cpu_online_mask) {
> -		dev = &per_cpu(omap4_idle_dev, cpu_id);
> +		dev = &per_cpu(omap_idle_dev, cpu_id);
>  		dev->cpu = cpu_id;
>  #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
>  		dev->coupled_cpus = *cpu_online_mask;
