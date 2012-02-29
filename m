From: Rob Lee <rob.lee@linaro.org>
Subject: Re: [PATCH v6 1/9] cpuidle: Add common time keeping and irq enabling
Date: Wed, 29 Feb 2012 07:33:39 -0600
Message-ID: <CAMXH7KG-SGa9ofJXt_i=A7bDLUMHxB8u2v9HYyR=iioBbKusjw@mail.gmail.com>
References: <1330485109-7327-1-git-send-email-rob.lee@linaro.org>
	<1330485109-7327-2-git-send-email-rob.lee@linaro.org>
	<4F4E084F.5050505@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <4F4E084F.5050505@linux.vnet.ibm.com>
Sender: linux-sh-owner@vger.kernel.org
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Cc: len.brown@intel.com, khilman@ti.com, robherring2@gmail.com, Baohua.Song@csr.com, amit.kucheria@linaro.org, nicolas.ferre@atmel.com, linux@maxim.org.za, kgene.kim@samsung.com, amit.kachhap@linaro.org, magnus.damm@gmail.com, nsekhar@ti.com, daniel.lezcano@linaro.org, mturquette@linaro.org, vincent.guittot@linaro.org, arnd.bergmann@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, broonie@opensource.wolfsonmicro.com, nicolas.pitre@linaro.org, linux@arm.linux.org.uk, jean.pihet@newoldbits.com, venki@google.com, ccross@google.com, g.trinabh@gmail.com, kernel@wantstofly.org, lethal@linux-sh.org, jon-hunter@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hello Deepthi,

On Wed, Feb 29, 2012 at 5:13 AM, Deepthi Dharwar
<deepthi@linux.vnet.ibm.com> wrote:
> Hi Rob,
>
>
> On 02/29/2012 08:41 AM, Robert Lee wrote:
>
>> Make necessary changes to implement time keeping and irq enabling
>> in the core cpuidle code. =A0This will allow the removal of these
>> functionalities from various platform cpuidle implementations whose
>> timekeeping and irq enabling follows the form in this common code.
>>
>> Signed-off-by: Robert Lee <rob.lee@linaro.org>
>> ---
>> =A0arch/arm/include/asm/cpuidle.h | =A0 14 ++++++
>> =A0drivers/cpuidle/cpuidle.c =A0 =A0 =A0| =A0 90 +++++++++++++++++++=
+++++++++++++--------
>> =A0include/linux/cpuidle.h =A0 =A0 =A0 =A0| =A0 13 ++++++
>> =A03 files changed, 99 insertions(+), 18 deletions(-)
>> =A0create mode 100644 arch/arm/include/asm/cpuidle.h
>>
>> diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/c=
puidle.h
>> new file mode 100644
>> index 0000000..1d2075b
>> --- /dev/null
>> +++ b/arch/arm/include/asm/cpuidle.h
>> @@ -0,0 +1,14 @@
>> +#ifndef __ASM_ARM_CPUIDLE_H
>> +#define __ASM_ARM_CPUIDLE_H
>> +
>> +/* Common ARM WFI state */
>> +#define CPUIDLE_ARM_WFI_STATE {\
>> + =A0 =A0 .enter =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D cpuidle_simp=
le_enter,\
>> + =A0 =A0 .exit_latency =A0 =A0 =A0 =A0 =A0 =3D 1,\
>> + =A0 =A0 .target_residency =A0 =A0 =A0 =3D 1,\
>> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D CPUIDLE_FLAG=
_TIME_VALID,\
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "WFI",\
>> + =A0 =A0 .desc =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "ARM core cl=
ock gating (WFI)",\
>> +}
>> +
>> +#endif
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index 59f4261..00b02f5 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -18,6 +18,7 @@
>> =A0#include <linux/ktime.h>
>> =A0#include <linux/hrtimer.h>
>> =A0#include <linux/module.h>
>> +#include <asm/proc-fns.h>
>> =A0#include <trace/events/power.h>
>>
>> =A0#include "cpuidle.h"
>> @@ -53,6 +54,24 @@ static void cpuidle_kick_cpus(void) {}
>>
>> =A0static int __cpuidle_register_device(struct cpuidle_device *dev);
>>
>> +static inline int cpuidle_enter(struct cpuidle_device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct cpu=
idle_driver *drv, int index)
>> +{
>> + =A0 =A0 struct cpuidle_state *target_state =3D &drv->states[index]=
;
>> + =A0 =A0 return target_state->enter(dev, drv, index);
>> +}
>> +
>> +static inline int cpuidle_enter_tk(struct cpuidle_device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct cpui=
dle_driver *drv, int index)
>> +{
>> + =A0 =A0 return cpuidle_wrap_enter(dev, drv, index, cpuidle_enter);
>> +}
>> +
>> +typedef int (*cpuidle_enter_t)(struct cpuidle_device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct cpui=
dle_driver *drv, int index);
>> +
>> +static cpuidle_enter_t cpuidle_enter_ops;
>> +
>> =A0/**
>> =A0 * cpuidle_idle_call - the main idle loop
>> =A0 *
>> @@ -63,7 +82,6 @@ int cpuidle_idle_call(void)
>> =A0{
>> =A0 =A0 =A0 struct cpuidle_device *dev =3D __this_cpu_read(cpuidle_d=
evices);
>> =A0 =A0 =A0 struct cpuidle_driver *drv =3D cpuidle_get_driver();
>> - =A0 =A0 struct cpuidle_state *target_state;
>> =A0 =A0 =A0 int next_state, entered_state;
>>
>> =A0 =A0 =A0 if (off)
>> @@ -92,12 +110,10 @@ int cpuidle_idle_call(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 target_state =3D &drv->states[next_state];
>> -
>> =A0 =A0 =A0 trace_power_start(POWER_CSTATE, next_state, dev->cpu);
>> =A0 =A0 =A0 trace_cpu_idle(next_state, dev->cpu);
>>
>> - =A0 =A0 entered_state =3D target_state->enter(dev, drv, next_state=
);
>> + =A0 =A0 entered_state =3D cpuidle_enter_ops(dev, drv, next_state);
>>
>> =A0 =A0 =A0 trace_power_end(dev->cpu);
>> =A0 =A0 =A0 trace_cpu_idle(PWR_EVENT_EXIT, dev->cpu);
>> @@ -110,7 +126,8 @@ int cpuidle_idle_call(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->states_usage[entered_state].time +=3D
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigne=
d long long)dev->last_residency;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->states_usage[entered_state].usage++=
;
>> - =A0 =A0 }
>> + =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev->last_residency =3D 0;
>>
>> =A0 =A0 =A0 /* give the governor an opportunity to reflect on the ou=
tcome */
>> =A0 =A0 =A0 if (cpuidle_curr_governor->reflect)
>> @@ -164,20 +181,29 @@ void cpuidle_resume_and_unlock(void)
>>
>> =A0EXPORT_SYMBOL_GPL(cpuidle_resume_and_unlock);
>>
>> -#ifdef CONFIG_ARCH_HAS_CPU_RELAX
>> -static int poll_idle(struct cpuidle_device *dev,
>> - =A0 =A0 =A0 =A0 =A0 =A0 struct cpuidle_driver *drv, int index)
>> +/**
>> + * cpuidle_wrap_enter - performs timekeeping and irqen around enter=
 function
>> + * @dev: pointer to a valid cpuidle_device object
>> + * @drv: pointer to a valid cpuidle_driver object
>> + * @index: index of the target cpuidle state.
>> + */
>> +int cpuidle_wrap_enter(struct cpuidle_device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct cpu=
idle_driver *drv, int index,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int (*ente=
r)(struct cpuidle_device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct cpuidle_driver *drv, int index))
>> =A0{
>> - =A0 =A0 ktime_t t1, t2;
>> + =A0 =A0 ktime_t time_start, time_end;
>> =A0 =A0 =A0 s64 diff;
>>
>> - =A0 =A0 t1 =3D ktime_get();
>> + =A0 =A0 time_start =3D ktime_get();
>> +
>> + =A0 =A0 index =3D enter(dev, drv, index);
>> +
>> + =A0 =A0 time_end =3D ktime_get();
>> +
>> =A0 =A0 =A0 local_irq_enable();
>> - =A0 =A0 while (!need_resched())
>> - =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
>>
>> - =A0 =A0 t2 =3D ktime_get();
>> - =A0 =A0 diff =3D ktime_to_us(ktime_sub(t2, t1));
>> + =A0 =A0 diff =3D ktime_to_us(ktime_sub(time_end, time_start));
>> =A0 =A0 =A0 if (diff > INT_MAX)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 diff =3D INT_MAX;
>>
>> @@ -186,6 +212,31 @@ static int poll_idle(struct cpuidle_device *dev=
,
>> =A0 =A0 =A0 return index;
>> =A0}
>>
>> +int cpuidle_simple_enter(struct cpuidle_device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct cpuidle_driver *drv, int index)
>> +{
>> + =A0 =A0 cpu_do_idle();
>> +
>> + =A0 =A0 return index;
>> +}
>
>
> The enter routines are always part of =A0the specific driver code rat=
her
> than in the generic cpuidle framework code.
> The above function is arm driver specific enter routine, and should b=
e
> in arch specific file.
> Right now, this causes a build break on Powerpc and Intel boxes.
>

Ok, I can move this out on next version.

> drivers/cpuidle/cpuidle.c:21:26: error: asm/proc-fns.h: No such file =
or
> directory
> drivers/cpuidle/cpuidle.c: In function =91cpuidle_simple_enter=92:
> drivers/cpuidle/cpuidle.c:218: error: implicit declaration of functio=
n
> =91cpu_do_idle=92
> make[2]: *** [drivers/cpuidle/cpuidle.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [drivers/cpuidle] Error 2
> make[1]: *** Waiting for unfinished jobs....
>
>
>> +
>> +#ifdef CONFIG_ARCH_HAS_CPU_RELAX
>> +static inline int __poll_idle(struct cpuidle_device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct cpuidle_driver *drv, int index)
>> +{
>> + =A0 =A0 while (!need_resched())
>> + =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
>> +
>> + =A0 =A0 return index;
>> +}
>> +
>> +static int poll_idle(struct cpuidle_device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct cpuidle_driver *drv, int index)
>> +{
>> + =A0 =A0 return cpuidle_wrap_enter(dev, =A0drv, index,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __poll_idl=
e);
>> +}
>> +
>> =A0static void poll_idle_init(struct cpuidle_driver *drv)
>> =A0{
>> =A0 =A0 =A0 struct cpuidle_state *state =3D &drv->states[0];
>> @@ -195,7 +246,6 @@ static void poll_idle_init(struct cpuidle_driver=
 *drv)
>> =A0 =A0 =A0 state->exit_latency =3D 0;
>> =A0 =A0 =A0 state->target_residency =3D 0;
>> =A0 =A0 =A0 state->power_usage =3D -1;
>> - =A0 =A0 state->flags =3D 0;
>
>
> Also, why is that these flags have been eliminated ?
>

This shouldn't be there.  Will fix this in next version.

>> =A0 =A0 =A0 state->enter =3D poll_idle;
>> =A0}
>> =A0#else
>> @@ -212,10 +262,11 @@ static void poll_idle_init(struct cpuidle_driv=
er *drv) {}
>> =A0int cpuidle_enable_device(struct cpuidle_device *dev)
>> =A0{
>> =A0 =A0 =A0 int ret, i;
>> + =A0 =A0 struct cpuidle_driver *drv =3D cpuidle_get_driver();
>>
>> =A0 =A0 =A0 if (dev->enabled)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> - =A0 =A0 if (!cpuidle_get_driver() || !cpuidle_curr_governor)
>> + =A0 =A0 if (!drv || !cpuidle_curr_governor)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
>> =A0 =A0 =A0 if (!dev->state_count)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> @@ -226,13 +277,16 @@ int cpuidle_enable_device(struct cpuidle_devic=
e *dev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 poll_idle_init(cpuidle_get_driver());
>> + =A0 =A0 cpuidle_enter_ops =3D drv->en_core_tk_irqen ?
>> + =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_enter_tk : cpuidle_enter;
>> +
>> + =A0 =A0 poll_idle_init(drv);
>>
>> =A0 =A0 =A0 if ((ret =3D cpuidle_add_state_sysfs(dev)))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>>
>> =A0 =A0 =A0 if (cpuidle_curr_governor->enable &&
>> - =A0 =A0 =A0 =A0 (ret =3D cpuidle_curr_governor->enable(cpuidle_get=
_driver(), dev)))
>> + =A0 =A0 =A0 =A0 (ret =3D cpuidle_curr_governor->enable(drv, dev)))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_sysfs;
>>
>> =A0 =A0 =A0 for (i =3D 0; i < dev->state_count; i++) {
>> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
>> index 712abcc..c91b018 100644
>> --- a/include/linux/cpuidle.h
>> +++ b/include/linux/cpuidle.h
>> @@ -15,6 +15,7 @@
>> =A0#include <linux/list.h>
>> =A0#include <linux/kobject.h>
>> =A0#include <linux/completion.h>
>> +#include <linux/hrtimer.h>
>>
>> =A0#define CPUIDLE_STATE_MAX =A0 =A08
>> =A0#define CPUIDLE_NAME_LEN =A0 =A0 16
>> @@ -122,6 +123,8 @@ struct cpuidle_driver {
>> =A0 =A0 =A0 struct module =A0 =A0 =A0 =A0 =A0 *owner;
>>
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0power_specified:1;
>> + =A0 =A0 /* set to 1 to use the core cpuidle time keeping (for all =
states). */
>> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0en_core_tk_irqen:1;
>> =A0 =A0 =A0 struct cpuidle_state =A0 =A0states[CPUIDLE_STATE_MAX];
>> =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 state_count;
>> =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 safe_state_i=
ndex;
>> @@ -140,6 +143,13 @@ extern void cpuidle_pause_and_lock(void);
>> =A0extern void cpuidle_resume_and_unlock(void);
>> =A0extern int cpuidle_enable_device(struct cpuidle_device *dev);
>> =A0extern void cpuidle_disable_device(struct cpuidle_device *dev);
>> +extern int cpuidle_simple_enter(struct cpuidle_device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct cpuidle_driver *drv, int index);
>> +
>> +extern int cpuidle_wrap_enter(struct cpuidle_device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct cpu=
idle_driver *drv, int index,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int (*ente=
r)(struct cpuidle_device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct cpuidle_driver *drv, int index));
>>
>> =A0#else
>> =A0static inline void disable_cpuidle(void) { }
>> @@ -157,6 +167,9 @@ static inline void cpuidle_resume_and_unlock(voi=
d) { }
>> =A0static inline int cpuidle_enable_device(struct cpuidle_device *de=
v)
>> =A0{return -ENODEV; }
>> =A0static inline void cpuidle_disable_device(struct cpuidle_device *=
dev) { }
>> +static inline int cpuidle_simple_enter(struct cpuidle_device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct cpuidle_driver *drv, int index)
>> +{return -ENODEV; }
>>
>> =A0#endif
>>
>
>
> I am for generic time keeping framework, this would remove
> loads of redundant code for the same in all the backend drivers.
>
> Cheers,
> Deepthi
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
