From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] perf: add OMAP support for the new power events
Date: Thu, 10 Mar 2011 09:09:37 +0100
Message-ID: <AANLkTikaQ69Rt9Q6vtm8F_S=qLftM=yqjrUcTqj2Rihm@mail.gmail.com>
References: <1298052645-4164-1-git-send-email-j-pihet@ti.com>
	<1299147943-2929-1-git-send-email-j-pihet@ti.com>
	<878vwnvnvj.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:40455 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159Ab1CJIJi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 03:09:38 -0500
Received: by qyg14 with SMTP id 14so1197558qyg.19
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 00:09:37 -0800 (PST)
In-Reply-To: <878vwnvnvj.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Thomas Renninger <trenn@suse.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

On Thu, Mar 10, 2011 at 1:08 AM, Kevin Hilman <khilman@ti.com> wrote:
> Jean Pihet <jean.pihet@newoldbits.com> writes:
>
>> The patch adds the new power management trace points for
>> the OMAP architecture.
>>
>> The trace points are for:
>> - default idle handler. Since the cpuidle framework is
>> =A0 instrumented in the generic way there is no need to
>> =A0 add trace points in the OMAP specific cpuidle handler;
>> - cpufreq (DVFS),
>
> Minor: AFAICT, this patch doesn't instrument CPUfreq.
The generic framework provides a cpu_frequency event. Furthermore the
clock_set_rate events are reporting the various SoC clock rate
changes.
Indeed the changelog is not accurate enough. Is '- cpufreq (DVFS)
events are covered by the generic cpu_frequency events and the SoC
clock changes events' better?

>
>> - SoC clocks changes (enable, disable, set_rate),
>> - power domain states: the desired target state and -if different-
>> =A0 the actually hit state.
>>
>> Because of the generic nature of the changes, OMAP3 and OMAP4 are su=
pported.
>>
>> Tested on OMAP3 with suspend/resume, cpuidle, basic DVFS.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>
> With Paul's ack on the powerdomain changes, I'll queue this for 2.6.3=
9
> after making the above change in the changelog.

Thanks!
Jean

>
> Kevin
>
>
>> ---
>> =A0arch/arm/mach-omap2/clock.c =A0 =A0 =A0 | =A0 11 +++++++++--
>> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0| =A0 =A07 +++++++
>> =A0arch/arm/mach-omap2/powerdomain.c | =A0 26 ++++++++++++++++++++++=
+---
>> =A03 files changed, 39 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock=
=2Ec
>> index 46d03cc..180299e 100644
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
>> @@ -261,8 +263,10 @@ void omap2_clk_disable(struct clk *clk)
>>
>> =A0 =A0 =A0 pr_debug("clock: %s: disabling in hardware\n", clk->name=
);
>>
>> - =A0 =A0 if (clk->ops && clk->ops->disable)
>> + =A0 =A0 if (clk->ops && clk->ops->disable) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 trace_clock_disable(clk->name, 0, smp_proc=
essor_id());
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk->ops->disable(clk);
>> + =A0 =A0 }
>>
>> =A0 =A0 =A0 if (clk->clkdm)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkdm_clk_disable(clk->clkdm, clk);
>> @@ -314,6 +318,7 @@ int omap2_clk_enable(struct clk *clk)
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 if (clk->ops && clk->ops->enable) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 trace_clock_enable(clk->name, 1, smp_proce=
ssor_id());
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D clk->ops->enable(clk);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "clock: %s: coul=
d not enable: %d\n",
>> @@ -353,8 +358,10 @@ int omap2_clk_set_rate(struct clk *clk, unsigne=
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
>> index bd610bc..d46b9ff 100644
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
>> @@ -514,8 +515,14 @@ static void omap3_pm_idle(void)
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
>> index eaed0df..1495eed 100644
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
>> @@ -32,6 +35,8 @@
>>
>> =A0#include "pm.h"
>>
>> +#define PWRDM_TRACE_STATES_FLAG =A0 =A0 =A0(1<<31)
>> +
>> =A0enum {
>> =A0 =A0 =A0 PWRDM_STATE_NOW =3D 0,
>> =A0 =A0 =A0 PWRDM_STATE_PREV,
>> @@ -130,8 +135,7 @@ static void _update_logic_membank_counters(struc=
t powerdomain *pwrdm)
>> =A0static int _pwrdm_state_switch(struct powerdomain *pwrdm, int fla=
g)
>> =A0{
>>
>> - =A0 =A0 int prev;
>> - =A0 =A0 int state;
>> + =A0 =A0 int prev, state, trace_state =3D 0;
>>
>> =A0 =A0 =A0 if (pwrdm =3D=3D NULL)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> @@ -148,6 +152,17 @@ static int _pwrdm_state_switch(struct powerdoma=
in *pwrdm, int flag)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm->state_counter[pre=
v]++;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (prev =3D=3D PWRDM_POWER_RET)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 _update_logic_membank_co=
unters(pwrdm);
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* If the power domain did not hit the d=
esired state,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* generate a trace event with both the =
desired and hit states
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (state !=3D prev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 trace_state =3D (PWRDM_TRA=
CE_STATES_FLAG |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0((state & OMAP_POWERSTATE_MASK) << 8) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0((prev & OMAP_POWERSTATE_MASK) << 0));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 trace_power_domain_target(=
pwrdm->name, trace_state,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 smp_processor_id());
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 default:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> @@ -406,8 +421,13 @@ int pwrdm_set_next_pwrst(struct powerdomain *pw=
rdm, u8 pwrst)
>> =A0 =A0 =A0 pr_debug("powerdomain: setting next powerstate for %s to=
 %0x\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pwrdm->name, pwrst);
>>
>> - =A0 =A0 if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst)
>> + =A0 =A0 if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Trace the pwrdm desired target state */
>> + =A0 =A0 =A0 =A0 =A0 =A0 trace_power_domain_target(pwrdm->name, pwr=
st,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 smp_processor_id());
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Program the pwrdm desired target state =
*/
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
