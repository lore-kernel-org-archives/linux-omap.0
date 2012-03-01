From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 1/9] cpuidle: Add common time keeping and irq enabling
Date: Thu, 01 Mar 2012 09:45:56 +0530
Message-ID: <4F4EF7FC.9040403@linux.vnet.ibm.com>
References: <1330562578-3410-1-git-send-email-rob.lee@linaro.org>
 <1330562578-3410-2-git-send-email-rob.lee@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1330562578-3410-2-git-send-email-rob.lee@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robert Lee <rob.lee@linaro.org>
Cc: nicolas.pitre@linaro.org, venki@google.com, linaro-dev@lists.linaro.org, linux-sh@vger.kernel.org, tony@atomide.com, nicolas.ferre@atmel.com, linux@arm.linux.org.uk, ccross@google.com, kernel@wantstofly.org, khilman@ti.com, kgene.kim@samsung.com, mturquette@linaro.org, daniel.lezcano@linaro.org, magnus.damm@gmail.com, arnd.bergmann@linaro.org, jon-hunter@ti.com, len.brown@intel.com, patches@linaro.org, nsekhar@ti.com, jean.pihet@newoldbits.com, rjw@sisk.pl, Baohua.Song@csr.com, vincent.guittot@linaro.org, linux-omap@vger.kernel.org, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, g.trinabh@gmail.com, linux-pm@vger.kernel.org, broonie@opensource.wolfsonmicro.com, amit.kucheria@linaro.org, lethal@linux-sh.org, amit.kachhap@linaro.org
List-Id: linux-omap@vger.kernel.org

Hi Rob,

On 03/01/2012 06:12 AM, Robert Lee wrote:

> Make necessary changes to implement time keeping and irq enabling
> in the core cpuidle code.  This will allow the removal of these
> functionalities from various platform cpuidle implementations whose
> timekeeping and irq enabling follows the form in this common code.


The generic cpuidle changes look good, but is there a reason as
to why these changes are enabled only for ARM and not other
archs ?

> Signed-off-by: Robert Lee <rob.lee@linaro.org>
> ---
>  arch/arm/include/asm/cpuidle.h |   22 +++++++++++
>  arch/arm/kernel/Makefile       |    2 +-
>  arch/arm/kernel/cpuidle.c      |   21 +++++++++++
>  drivers/cpuidle/cpuidle.c      |   79 ++++++++++++++++++++++++++++++++--------
>  include/linux/cpuidle.h        |   13 ++++++-
>  5 files changed, 119 insertions(+), 18 deletions(-)
>  create mode 100644 arch/arm/include/asm/cpuidle.h
>  create mode 100644 arch/arm/kernel/cpuidle.c
> 
> diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/cpuidle.h
> new file mode 100644
> index 0000000..165676e
> --- /dev/null
> +++ b/arch/arm/include/asm/cpuidle.h
> @@ -0,0 +1,22 @@
> +#ifndef __ASM_ARM_CPUIDLE_H
> +#define __ASM_ARM_CPUIDLE_H
> +
> +#ifdef CONFIG_CPU_IDLE
> +extern int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
> +		struct cpuidle_driver *drv, int index);
> +#else
> +static inline int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
> +		struct cpuidle_driver *drv, int index) { return -ENODEV; }
> +#endif
> +
> +/* Common ARM WFI state */
> +#define ARM_CPUIDLE_WFI_STATE {\
> +	.enter                  = arm_cpuidle_simple_enter,\
> +	.exit_latency           = 1,\
> +	.target_residency       = 1,\
> +	.flags                  = CPUIDLE_FLAG_TIME_VALID,\
> +	.name                   = "WFI",\
> +	.desc                   = "ARM WFI",\
> +}
> +
> +#endif
> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> index 43b740d..940c27f 100644
> --- a/arch/arm/kernel/Makefile
> +++ b/arch/arm/kernel/Makefile
> @@ -21,7 +21,7 @@ obj-$(CONFIG_DEPRECATED_PARAM_STRUCT) += compat.o
> 
>  obj-$(CONFIG_LEDS)		+= leds.o
>  obj-$(CONFIG_OC_ETM)		+= etm.o
> -
> +obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
>  obj-$(CONFIG_ISA_DMA_API)	+= dma.o
>  obj-$(CONFIG_ARCH_ACORN)	+= ecard.o 
>  obj-$(CONFIG_FIQ)		+= fiq.o fiqasm.o
> diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
> new file mode 100644
> index 0000000..89545f6
> --- /dev/null
> +++ b/arch/arm/kernel/cpuidle.c
> @@ -0,0 +1,21 @@
> +/*
> + * Copyright 2012 Linaro Ltd.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <linux/cpuidle.h>
> +#include <asm/proc-fns.h>
> +
> +int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
> +		struct cpuidle_driver *drv, int index)
> +{
> +	cpu_do_idle();
> +
> +	return index;
> +}
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 59f4261..56de5f7 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -53,6 +53,24 @@ static void cpuidle_kick_cpus(void) {}
> 
>  static int __cpuidle_register_device(struct cpuidle_device *dev);
> 
> +static inline int cpuidle_enter(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv, int index)
> +{
> +	struct cpuidle_state *target_state = &drv->states[index];
> +	return target_state->enter(dev, drv, index);
> +}
> +
> +static inline int cpuidle_enter_tk(struct cpuidle_device *dev,
> +			       struct cpuidle_driver *drv, int index)
> +{
> +	return cpuidle_wrap_enter(dev, drv, index, cpuidle_enter);
> +}
> +
> +typedef int (*cpuidle_enter_t)(struct cpuidle_device *dev,
> +			       struct cpuidle_driver *drv, int index);
> +
> +static cpuidle_enter_t cpuidle_enter_ops;
> +
>  /**
>   * cpuidle_idle_call - the main idle loop
>   *
> @@ -63,7 +81,6 @@ int cpuidle_idle_call(void)
>  {
>  	struct cpuidle_device *dev = __this_cpu_read(cpuidle_devices);
>  	struct cpuidle_driver *drv = cpuidle_get_driver();
> -	struct cpuidle_state *target_state;
>  	int next_state, entered_state;
> 
>  	if (off)
> @@ -92,12 +109,10 @@ int cpuidle_idle_call(void)
>  		return 0;
>  	}
> 
> -	target_state = &drv->states[next_state];
> -
>  	trace_power_start(POWER_CSTATE, next_state, dev->cpu);
>  	trace_cpu_idle(next_state, dev->cpu);
> 
> -	entered_state = target_state->enter(dev, drv, next_state);
> +	entered_state = cpuidle_enter_ops(dev, drv, next_state);
> 
>  	trace_power_end(dev->cpu);
>  	trace_cpu_idle(PWR_EVENT_EXIT, dev->cpu);
> @@ -110,6 +125,8 @@ int cpuidle_idle_call(void)
>  		dev->states_usage[entered_state].time +=
>  				(unsigned long long)dev->last_residency;
>  		dev->states_usage[entered_state].usage++;
> +	} else {
> +		dev->last_residency = 0;
>  	}
> 
>  	/* give the governor an opportunity to reflect on the outcome */
> @@ -164,20 +181,29 @@ void cpuidle_resume_and_unlock(void)
> 
>  EXPORT_SYMBOL_GPL(cpuidle_resume_and_unlock);
> 
> -#ifdef CONFIG_ARCH_HAS_CPU_RELAX
> -static int poll_idle(struct cpuidle_device *dev,
> -		struct cpuidle_driver *drv, int index)
> +/**
> + * cpuidle_wrap_enter - performs timekeeping and irqen around enter function
> + * @dev: pointer to a valid cpuidle_device object
> + * @drv: pointer to a valid cpuidle_driver object
> + * @index: index of the target cpuidle state.
> + */
> +int cpuidle_wrap_enter(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv, int index,
> +				int (*enter)(struct cpuidle_device *dev,
> +					struct cpuidle_driver *drv, int index))
>  {
> -	ktime_t	t1, t2;
> +	ktime_t time_start, time_end;
>  	s64 diff;
> 
> -	t1 = ktime_get();
> +	time_start = ktime_get();
> +
> +	index = enter(dev, drv, index);
> +
> +	time_end = ktime_get();
> +
>  	local_irq_enable();
> -	while (!need_resched())
> -		cpu_relax();
> 
> -	t2 = ktime_get();
> -	diff = ktime_to_us(ktime_sub(t2, t1));
> +	diff = ktime_to_us(ktime_sub(time_end, time_start));
>  	if (diff > INT_MAX)
>  		diff = INT_MAX;
> 
> @@ -186,6 +212,23 @@ static int poll_idle(struct cpuidle_device *dev,
>  	return index;
>  }
> 
> +#ifdef CONFIG_ARCH_HAS_CPU_RELAX
> +static inline int __poll_idle(struct cpuidle_device *dev,
> +		struct cpuidle_driver *drv, int index)
> +{
> +	while (!need_resched())
> +		cpu_relax();
> +
> +	return index;
> +}
> +
> +static int poll_idle(struct cpuidle_device *dev,
> +		struct cpuidle_driver *drv, int index)
> +{
> +	return cpuidle_wrap_enter(dev,	drv, index,
> +				__poll_idle);
> +}
> +
>  static void poll_idle_init(struct cpuidle_driver *drv)
>  {
>  	struct cpuidle_state *state = &drv->states[0];
> @@ -212,10 +255,11 @@ static void poll_idle_init(struct cpuidle_driver *drv) {}
>  int cpuidle_enable_device(struct cpuidle_device *dev)
>  {
>  	int ret, i;
> +	struct cpuidle_driver *drv = cpuidle_get_driver();
> 
>  	if (dev->enabled)
>  		return 0;
> -	if (!cpuidle_get_driver() || !cpuidle_curr_governor)
> +	if (!drv || !cpuidle_curr_governor)
>  		return -EIO;
>  	if (!dev->state_count)
>  		return -EINVAL;
> @@ -226,13 +270,16 @@ int cpuidle_enable_device(struct cpuidle_device *dev)
>  			return ret;
>  	}
> 
> -	poll_idle_init(cpuidle_get_driver());
> +	cpuidle_enter_ops = drv->en_core_tk_irqen ?
> +		cpuidle_enter_tk : cpuidle_enter;
> +
> +	poll_idle_init(drv);
> 
>  	if ((ret = cpuidle_add_state_sysfs(dev)))
>  		return ret;
> 
>  	if (cpuidle_curr_governor->enable &&
> -	    (ret = cpuidle_curr_governor->enable(cpuidle_get_driver(), dev)))
> +	    (ret = cpuidle_curr_governor->enable(drv, dev)))
>  		goto fail_sysfs;
> 
>  	for (i = 0; i < dev->state_count; i++) {
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 712abcc..927db28 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -15,6 +15,7 @@
>  #include <linux/list.h>
>  #include <linux/kobject.h>
>  #include <linux/completion.h>
> +#include <linux/hrtimer.h>
> 
>  #define CPUIDLE_STATE_MAX	8
>  #define CPUIDLE_NAME_LEN	16
> @@ -122,6 +123,8 @@ struct cpuidle_driver {
>  	struct module 		*owner;
> 
>  	unsigned int		power_specified:1;
> +	/* set to 1 to use the core cpuidle time keeping (for all states). */
> +	unsigned int		en_core_tk_irqen:1;
>  	struct cpuidle_state	states[CPUIDLE_STATE_MAX];
>  	int			state_count;
>  	int			safe_state_index;
> @@ -140,7 +143,10 @@ extern void cpuidle_pause_and_lock(void);
>  extern void cpuidle_resume_and_unlock(void);
>  extern int cpuidle_enable_device(struct cpuidle_device *dev);
>  extern void cpuidle_disable_device(struct cpuidle_device *dev);
> -
> +extern int cpuidle_wrap_enter(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv, int index,
> +				int (*enter)(struct cpuidle_device *dev,
> +					struct cpuidle_driver *drv, int index));
>  #else
>  static inline void disable_cpuidle(void) { }
>  static inline int cpuidle_idle_call(void) { return -ENODEV; }
> @@ -157,6 +163,11 @@ static inline void cpuidle_resume_and_unlock(void) { }
>  static inline int cpuidle_enable_device(struct cpuidle_device *dev)
>  {return -ENODEV; }
>  static inline void cpuidle_disable_device(struct cpuidle_device *dev) { }
> +static inline int cpuidle_wrap_enter(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv, int index,
> +				int (*enter)(struct cpuidle_device *dev,
> +					struct cpuidle_driver *drv, int index))
> +{ return -ENODEV; }
> 
>  #endif
> 


For the generic cpuidle changes
Reviewed-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
