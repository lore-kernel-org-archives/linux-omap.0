From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 1/9] cpuidle: Add common time keeping and irq enabling
Date: Wed, 29 Feb 2012 16:43:19 +0530
Message-ID: <4F4E084F.5050505@linux.vnet.ibm.com>
References: <1330485109-7327-1-git-send-email-rob.lee@linaro.org> <1330485109-7327-2-git-send-email-rob.lee@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:54245 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754706Ab2B2LNo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Feb 2012 06:13:44 -0500
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-omap@vger.kernel.org> from <deepthi@linux.vnet.ibm.com>;
	Wed, 29 Feb 2012 10:57:23 +1000
In-Reply-To: <1330485109-7327-2-git-send-email-rob.lee@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Lee <rob.lee@linaro.org>
Cc: len.brown@intel.com, khilman@ti.com, robherring2@gmail.com, Baohua.Song@csr.com, amit.kucheria@linaro.org, nicolas.ferre@atmel.com, linux@maxim.org.za, kgene.kim@samsung.com, amit.kachhap@linaro.org, magnus.damm@gmail.com, nsekhar@ti.com, daniel.lezcano@linaro.org, mturquette@linaro.org, vincent.guittot@linaro.org, arnd.bergmann@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, broonie@opensource.wolfsonmicro.com, nicolas.pitre@linaro.org, linux@arm.linux.org.uk, jean.pihet@newoldbits.com, venki@google.com, ccross@google.com, g.trinabh@gmail.com, kernel@wantstofly.org, lethal@linux-sh.org, jon-hunter@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org

Hi Rob,


On 02/29/2012 08:41 AM, Robert Lee wrote:

> Make necessary changes to implement time keeping and irq enabling
> in the core cpuidle code.  This will allow the removal of these
> functionalities from various platform cpuidle implementations whose
> timekeeping and irq enabling follows the form in this common code.
>=20
> Signed-off-by: Robert Lee <rob.lee@linaro.org>
> ---
>  arch/arm/include/asm/cpuidle.h |   14 ++++++
>  drivers/cpuidle/cpuidle.c      |   90 ++++++++++++++++++++++++++++++=
++--------
>  include/linux/cpuidle.h        |   13 ++++++
>  3 files changed, 99 insertions(+), 18 deletions(-)
>  create mode 100644 arch/arm/include/asm/cpuidle.h
>=20
> diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/cp=
uidle.h
> new file mode 100644
> index 0000000..1d2075b
> --- /dev/null
> +++ b/arch/arm/include/asm/cpuidle.h
> @@ -0,0 +1,14 @@
> +#ifndef __ASM_ARM_CPUIDLE_H
> +#define __ASM_ARM_CPUIDLE_H
> +
> +/* Common ARM WFI state */
> +#define CPUIDLE_ARM_WFI_STATE {\
> +	.enter                  =3D cpuidle_simple_enter,\
> +	.exit_latency           =3D 1,\
> +	.target_residency       =3D 1,\
> +	.flags                  =3D CPUIDLE_FLAG_TIME_VALID,\
> +	.name                   =3D "WFI",\
> +	.desc                   =3D "ARM core clock gating (WFI)",\
> +}
> +
> +#endif
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 59f4261..00b02f5 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -18,6 +18,7 @@
>  #include <linux/ktime.h>
>  #include <linux/hrtimer.h>
>  #include <linux/module.h>
> +#include <asm/proc-fns.h>
>  #include <trace/events/power.h>
>=20
>  #include "cpuidle.h"
> @@ -53,6 +54,24 @@ static void cpuidle_kick_cpus(void) {}
>=20
>  static int __cpuidle_register_device(struct cpuidle_device *dev);
>=20
> +static inline int cpuidle_enter(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv, int index)
> +{
> +	struct cpuidle_state *target_state =3D &drv->states[index];
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
> @@ -63,7 +82,6 @@ int cpuidle_idle_call(void)
>  {
>  	struct cpuidle_device *dev =3D __this_cpu_read(cpuidle_devices);
>  	struct cpuidle_driver *drv =3D cpuidle_get_driver();
> -	struct cpuidle_state *target_state;
>  	int next_state, entered_state;
>=20
>  	if (off)
> @@ -92,12 +110,10 @@ int cpuidle_idle_call(void)
>  		return 0;
>  	}
>=20
> -	target_state =3D &drv->states[next_state];
> -
>  	trace_power_start(POWER_CSTATE, next_state, dev->cpu);
>  	trace_cpu_idle(next_state, dev->cpu);
>=20
> -	entered_state =3D target_state->enter(dev, drv, next_state);
> +	entered_state =3D cpuidle_enter_ops(dev, drv, next_state);
>=20
>  	trace_power_end(dev->cpu);
>  	trace_cpu_idle(PWR_EVENT_EXIT, dev->cpu);
> @@ -110,7 +126,8 @@ int cpuidle_idle_call(void)
>  		dev->states_usage[entered_state].time +=3D
>  				(unsigned long long)dev->last_residency;
>  		dev->states_usage[entered_state].usage++;
> -	}
> +	} else
> +		dev->last_residency =3D 0;
>=20
>  	/* give the governor an opportunity to reflect on the outcome */
>  	if (cpuidle_curr_governor->reflect)
> @@ -164,20 +181,29 @@ void cpuidle_resume_and_unlock(void)
>=20
>  EXPORT_SYMBOL_GPL(cpuidle_resume_and_unlock);
>=20
> -#ifdef CONFIG_ARCH_HAS_CPU_RELAX
> -static int poll_idle(struct cpuidle_device *dev,
> -		struct cpuidle_driver *drv, int index)
> +/**
> + * cpuidle_wrap_enter - performs timekeeping and irqen around enter =
function
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
>=20
> -	t1 =3D ktime_get();
> +	time_start =3D ktime_get();
> +
> +	index =3D enter(dev, drv, index);
> +
> +	time_end =3D ktime_get();
> +
>  	local_irq_enable();
> -	while (!need_resched())
> -		cpu_relax();
>=20
> -	t2 =3D ktime_get();
> -	diff =3D ktime_to_us(ktime_sub(t2, t1));
> +	diff =3D ktime_to_us(ktime_sub(time_end, time_start));
>  	if (diff > INT_MAX)
>  		diff =3D INT_MAX;
>=20
> @@ -186,6 +212,31 @@ static int poll_idle(struct cpuidle_device *dev,
>  	return index;
>  }
>=20
> +int cpuidle_simple_enter(struct cpuidle_device *dev,
> +		struct cpuidle_driver *drv, int index)
> +{
> +	cpu_do_idle();
> +
> +	return index;
> +}


The enter routines are always part of  the specific driver code rather
than in the generic cpuidle framework code.
The above function is arm driver specific enter routine, and should be
in arch specific file.
Right now, this causes a build break on Powerpc and Intel boxes.

drivers/cpuidle/cpuidle.c:21:26: error: asm/proc-fns.h: No such file or
directory
drivers/cpuidle/cpuidle.c: In function =91cpuidle_simple_enter=92:
drivers/cpuidle/cpuidle.c:218: error: implicit declaration of function
=91cpu_do_idle=92
make[2]: *** [drivers/cpuidle/cpuidle.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [drivers/cpuidle] Error 2
make[1]: *** Waiting for unfinished jobs....


> +
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
>  	struct cpuidle_state *state =3D &drv->states[0];
> @@ -195,7 +246,6 @@ static void poll_idle_init(struct cpuidle_driver =
*drv)
>  	state->exit_latency =3D 0;
>  	state->target_residency =3D 0;
>  	state->power_usage =3D -1;
> -	state->flags =3D 0;


Also, why is that these flags have been eliminated ?

>  	state->enter =3D poll_idle;
>  }
>  #else
> @@ -212,10 +262,11 @@ static void poll_idle_init(struct cpuidle_drive=
r *drv) {}
>  int cpuidle_enable_device(struct cpuidle_device *dev)
>  {
>  	int ret, i;
> +	struct cpuidle_driver *drv =3D cpuidle_get_driver();
>=20
>  	if (dev->enabled)
>  		return 0;
> -	if (!cpuidle_get_driver() || !cpuidle_curr_governor)
> +	if (!drv || !cpuidle_curr_governor)
>  		return -EIO;
>  	if (!dev->state_count)
>  		return -EINVAL;
> @@ -226,13 +277,16 @@ int cpuidle_enable_device(struct cpuidle_device=
 *dev)
>  			return ret;
>  	}
>=20
> -	poll_idle_init(cpuidle_get_driver());
> +	cpuidle_enter_ops =3D drv->en_core_tk_irqen ?
> +		cpuidle_enter_tk : cpuidle_enter;
> +
> +	poll_idle_init(drv);
>=20
>  	if ((ret =3D cpuidle_add_state_sysfs(dev)))
>  		return ret;
>=20
>  	if (cpuidle_curr_governor->enable &&
> -	    (ret =3D cpuidle_curr_governor->enable(cpuidle_get_driver(), de=
v)))
> +	    (ret =3D cpuidle_curr_governor->enable(drv, dev)))
>  		goto fail_sysfs;
>=20
>  	for (i =3D 0; i < dev->state_count; i++) {
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 712abcc..c91b018 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -15,6 +15,7 @@
>  #include <linux/list.h>
>  #include <linux/kobject.h>
>  #include <linux/completion.h>
> +#include <linux/hrtimer.h>
>=20
>  #define CPUIDLE_STATE_MAX	8
>  #define CPUIDLE_NAME_LEN	16
> @@ -122,6 +123,8 @@ struct cpuidle_driver {
>  	struct module 		*owner;
>=20
>  	unsigned int		power_specified:1;
> +	/* set to 1 to use the core cpuidle time keeping (for all states). =
*/
> +	unsigned int		en_core_tk_irqen:1;
>  	struct cpuidle_state	states[CPUIDLE_STATE_MAX];
>  	int			state_count;
>  	int			safe_state_index;
> @@ -140,6 +143,13 @@ extern void cpuidle_pause_and_lock(void);
>  extern void cpuidle_resume_and_unlock(void);
>  extern int cpuidle_enable_device(struct cpuidle_device *dev);
>  extern void cpuidle_disable_device(struct cpuidle_device *dev);
> +extern int cpuidle_simple_enter(struct cpuidle_device *dev,
> +		struct cpuidle_driver *drv, int index);
> +
> +extern int cpuidle_wrap_enter(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv, int index,
> +				int (*enter)(struct cpuidle_device *dev,
> +					struct cpuidle_driver *drv, int index));
>=20
>  #else
>  static inline void disable_cpuidle(void) { }
> @@ -157,6 +167,9 @@ static inline void cpuidle_resume_and_unlock(void=
) { }
>  static inline int cpuidle_enable_device(struct cpuidle_device *dev)
>  {return -ENODEV; }
>  static inline void cpuidle_disable_device(struct cpuidle_device *dev=
) { }
> +static inline int cpuidle_simple_enter(struct cpuidle_device *dev,
> +		struct cpuidle_driver *drv, int index)
> +{return -ENODEV; }
>=20
>  #endif
>=20


I am for generic time keeping framework, this would remove
loads of redundant code for the same in all the backend drivers.

Cheers,
Deepthi

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
