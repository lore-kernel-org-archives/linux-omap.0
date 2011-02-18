From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] perf: add OMAP support for the new power events
Date: Fri, 18 Feb 2011 19:14:26 +0100
Message-ID: <AANLkTik8y_LszTZdc2tt=yXGO6QpWqjHnTojn2L0jFWK@mail.gmail.com>
References: <1295878857-8983-1-git-send-email-j-pihet@ti.com>
	<87oc6jiox0.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:53721 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755679Ab1BRSO1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Feb 2011 13:14:27 -0500
Received: by qyk7 with SMTP id 7so321872qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 10:14:26 -0800 (PST)
In-Reply-To: <87oc6jiox0.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Thomas Renninger <trenn@suse.de>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Thu, Feb 10, 2011 at 10:02 PM, Kevin Hilman <khilman@ti.com> wrote:
> jean.pihet@newoldbits.com writes:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> The patch adds the new power management trace points for
>> the OMAP architecture.
>>
>> The trace points are for:
>> - default idle handler. Since the cpuidle framework is
>> =A0 instrumented in the generic way there is no need to
>> =A0 add trace points in the OMAP specific cpuidle handler;
>> - cpufreq (DVFS),
>> - SoC clocks changes (enable, disable, set_rate),
>> - change of power domains next power states.
>>
>> Tested on OMAP3 with suspend/resume, cpuidle, basic DVFS
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>
> Looks good to me. =A0Please post one more time with linux-arm-kernel =
in Cc.
> After that, unless there are objections, I'll queue for 2.6.39.
Ok thanks for reviewing the patch.
I sent the updated patch. The change is an extra trace point in the
case a power domain did not hit the desired target state. This allows
the parsing/GUI tools to trace the desired and actually hit states.

Regards,
Jean

>
> Kevin
>
>> ---
>> =A0arch/arm/mach-omap2/clock.c =A0 =A0 =A0 | =A0 =A08 +++++++-
>> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0| =A0 =A07 +++++++
>> =A0arch/arm/mach-omap2/powerdomain.c | =A0 =A08 +++++++-
>> =A03 files changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock=
=2Ec
>> index 2a2f152..72af75d 100644
>> --- a/arch/arm/mach-omap2/clock.c
>> +++ b/arch/arm/mach-omap2/clock.c
>> @@ -22,7 +22,9 @@
>> =A0#include <linux/clk.h>
>> =A0#include <linux/io.h>
>> =A0#include <linux/bitops.h>
>> +#include <trace/events/power.h>
>>
>> +#include <asm/cpu.h>
>> =A0#include <plat/clock.h>
>> =A0#include "clockdomain.h"
>> =A0#include <plat/cpu.h>
>> @@ -261,6 +263,7 @@ void omap2_clk_disable(struct clk *clk)
>>
>> =A0 =A0 =A0 pr_debug("clock: %s: disabling in hardware\n", clk->name=
);
>>
>> + =A0 =A0 trace_clock_disable(clk->name, 0, smp_processor_id());
>> =A0 =A0 =A0 clk->ops->disable(clk);
>>
>> =A0 =A0 =A0 if (clk->clkdm)
>> @@ -312,6 +315,7 @@ int omap2_clk_enable(struct clk *clk)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 trace_clock_enable(clk->name, 1, smp_processor_id());
>> =A0 =A0 =A0 ret =3D clk->ops->enable(clk);
>> =A0 =A0 =A0 if (ret) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "clock: %s: could not enable: %d=
\n", clk->name, ret);
>> @@ -349,8 +353,10 @@ int omap2_clk_set_rate(struct clk *clk, unsigne=
d long rate)
>> =A0 =A0 =A0 pr_debug("clock: set_rate for clock %s to rate %ld\n", c=
lk->name, rate);
>>
>> =A0 =A0 =A0 /* dpll_ck, core_ck, virt_prcm_set; plus all clksel cloc=
ks */
>> - =A0 =A0 if (clk->set_rate)
>> + =A0 =A0 if (clk->set_rate) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 trace_clock_set_rate(clk->name, rate, smp_=
processor_id());
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D clk->set_rate(clk, rate);
>> + =A0 =A0 }
>>
>> =A0 =A0 =A0 return ret;
>> =A0}
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34=
xx.c
>> index 8cbbead..7c5e0ee 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -29,6 +29,7 @@
>> =A0#include <linux/delay.h>
>> =A0#include <linux/slab.h>
>> =A0#include <linux/console.h>
>> +#include <trace/events/power.h>
>>
>> =A0#include <plat/sram.h>
>> =A0#include "clockdomain.h"
>> @@ -518,8 +519,14 @@ static void omap3_pm_idle(void)
>> =A0 =A0 =A0 if (omap_irq_pending() || need_resched())
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>
>> + =A0 =A0 trace_power_start(POWER_CSTATE, 1, smp_processor_id());
>> + =A0 =A0 trace_cpu_idle(1, smp_processor_id());
>> +
>> =A0 =A0 =A0 omap_sram_idle();
>>
>> + =A0 =A0 trace_power_end(smp_processor_id());
>> + =A0 =A0 trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
>> +
>> =A0out:
>> =A0 =A0 =A0 local_fiq_enable();
>> =A0 =A0 =A0 local_irq_enable();
>> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2=
/powerdomain.c
>> index eaed0df..e1feb50 100644
>> --- a/arch/arm/mach-omap2/powerdomain.c
>> +++ b/arch/arm/mach-omap2/powerdomain.c
>> @@ -19,12 +19,15 @@
>> =A0#include <linux/list.h>
>> =A0#include <linux/errno.h>
>> =A0#include <linux/string.h>
>> +#include <trace/events/power.h>
>> +
>> =A0#include "cm2xxx_3xxx.h"
>> =A0#include "prcm44xx.h"
>> =A0#include "cm44xx.h"
>> =A0#include "prm2xxx_3xxx.h"
>> =A0#include "prm44xx.h"
>>
>> +#include <asm/cpu.h>
>> =A0#include <plat/cpu.h>
>> =A0#include "powerdomain.h"
>> =A0#include "clockdomain.h"
>> @@ -406,8 +409,11 @@ int pwrdm_set_next_pwrst(struct powerdomain *pw=
rdm, u8 pwrst)
>> =A0 =A0 =A0 pr_debug("powerdomain: setting next powerstate for %s to=
 %0x\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pwrdm->name, pwrst);
>>
>> - =A0 =A0 if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst)
>> + =A0 =A0 if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 trace_power_domain_target(pwrdm->name, pwr=
st,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 smp_processor_id());
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D arch_pwrdm->pwrdm_set_next_pwrst=
(pwrdm, pwrst);
>> + =A0 =A0 }
>>
>> =A0 =A0 =A0 return ret;
>> =A0}
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
