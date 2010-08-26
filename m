From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] OMAP2: add cpuidle and cpufreq events tracing
Date: Thu, 26 Aug 2010 18:56:04 +0200
Message-ID: <AANLkTiknAXe4SNavZpwSVY__v4bRTiWZEA5NxMMi5y10@mail.gmail.com>
References: <AANLkTim-n+3sTzrxKStniAjHFWxGx4xVAf=FkZ4U282f@mail.gmail.com>
	<87r5hmft7c.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:61883 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720Ab0HZQ4I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Aug 2010 12:56:08 -0400
Received: by qyk33 with SMTP id 33so1919760qyk.19
        for <linux-omap@vger.kernel.org>; Thu, 26 Aug 2010 09:56:07 -0700 (PDT)
In-Reply-To: <87r5hmft7c.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

Hi Kevin,

On Wed, Aug 25, 2010 at 8:22 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Hi Jean,
>
> Jean Pihet <jean.pihet@newoldbits.com> writes:
>
=2E..
>
>> Add the cpuidle power_start and power_end events. The state
>> parameter of power_start has the following meaning:
>> - -1: from the suspend handler (omap3_pm_suspend),
>> - 1: from the default idle handler (omap3_pm_idle),
>> - other values are the C-states from the cpuidle handler
>> =A0 =A0(omap3_enter_idle).
>
> Are these definitions standard across other arches too? =A0The use of
> POWER_CSTATE from supend seems less than intuitive.
Only x86 is using those events, and only for idle (values >=3D 0).
I have added -1 to differentiate the suspend from the regular idle but
it sems that it is not the best option.
Is a new type of power event more suited, e.g. POWER_SSTATE? If so I
will have to add it in the event definition header (in
include/trace/events/power.h) and the patch will be submitted to LKML.

Thanks!
Jean

>
=2E..
> Kevin
>
>> ---
>> =A0arch/arm/mach-omap2/cpuidle34xx.c | =A0 =A02 ++
>> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0| =A0 =A04 ++++
>> =A0arch/arm/plat-omap/cpu-omap.c =A0 =A0 | =A0 =A05 ++++-
>> =A03 files changed, 10 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c
>> b/arch/arm/mach-omap2/cpuidle34xx.c
>> index 3d3d035..6113bd9 100644
>> --- a/arch/arm/mach-omap2/cpuidle34xx.c
>> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
>> @@ -24,6 +24,7 @@
>>
>> =A0#include <linux/sched.h>
>> =A0#include <linux/cpuidle.h>
>> +#include <trace/events/power.h>
>>
>> =A0#include <plat/prcm.h>
>> =A0#include <plat/irqs.h>
>> @@ -130,6 +131,7 @@ static int omap3_enter_idle(struct cpuidle_devic=
e *dev,
>> =A0 =A0 =A0 local_irq_disable();
>> =A0 =A0 =A0 local_fiq_disable();
>>
>> + =A0 =A0 trace_power_start(POWER_CSTATE, cx->type, smp_processor_id=
());
>> =A0 =A0 =A0 pwrdm_set_next_pwrst(mpu_pd, mpu_state);
>> =A0 =A0 =A0 pwrdm_set_next_pwrst(core_pd, core_state);
>>
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34=
xx.c
>> index f25bc3d..ea3b816 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -28,6 +28,7 @@
>> =A0#include <linux/clk.h>
>> =A0#include <linux/delay.h>
>> =A0#include <linux/slab.h>
>> +#include <trace/events/power.h>
>>
>> =A0#include <plat/sram.h>
>> =A0#include <plat/clockdomain.h>
>> @@ -588,6 +589,7 @@ static void omap3_pm_idle(void)
>> =A0 =A0 =A0 if (omap_irq_pending() || need_resched())
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>
>> + =A0 =A0 trace_power_start(POWER_CSTATE, 1, smp_processor_id());
>> =A0 =A0 =A0 omap_sram_idle();
>>
>> =A0out:
>> @@ -628,6 +630,8 @@ static int omap3_pm_suspend(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_pm_wakeup_on_timer(wakeup_timer_se=
conds,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0wakeup_timer_milliseconds);
>>
>> + =A0 =A0 trace_power_start(POWER_CSTATE, -1, smp_processor_id());
>> =A0 =A0 =A0 /* Read current next_pwrsts */
>> =A0 =A0 =A0 list_for_each_entry(pwrst, &pwrst_list, node)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrst->saved_state =3D pwrdm_read_next_p=
wrst(pwrst->pwrdm);
>> diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-=
omap.c
>> index df08829..cc4e41f 100644
>> --- a/arch/arm/plat-omap/cpu-omap.c
>> +++ b/arch/arm/plat-omap/cpu-omap.c
>> @@ -25,6 +25,7 @@
>> =A0#include <linux/err.h>
>> =A0#include <linux/clk.h>
>> =A0#include <linux/io.h>
>> +#include <trace/events/power.h>
>>
>> =A0#include <mach/hardware.h>
>> =A0#include <plat/clock.h>
>> @@ -116,8 +117,10 @@ static int omap_target(struct cpufreq_policy *p=
olicy,
>> =A0 =A0 =A0 cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
>> =A0#elif defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
>> =A0 =A0 =A0 freq =3D target_freq * 1000;
>> - =A0 =A0 if (opp_find_freq_ceil(mpu_dev, &freq))
>> + =A0 =A0 if (opp_find_freq_ceil(mpu_dev, &freq)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 trace_power_frequency(POWER_PSTATE, freq, =
smp_processor_id());
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_pm_cpu_set_freq(freq);
>> + =A0 =A0 }
>> =A0#endif
>> =A0 =A0 =A0 return ret;
>> =A0}
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
