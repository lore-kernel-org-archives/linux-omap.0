From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] perf: add OMAP support for the new power events
Date: Mon, 21 Feb 2011 09:44:04 +0100
Message-ID: <AANLkTiktdLja39dC38E_LciYZK7+pTp3_Sgm9jf5FA4R@mail.gmail.com>
References: <1298052645-4164-1-git-send-email-j-pihet@ti.com>
	<ec45f3f591691ce6a5253dfb70cc8e90@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:55160 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936Ab1BUIoF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Feb 2011 03:44:05 -0500
Received: by qyk7 with SMTP id 7so1764474qyk.19
        for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 00:44:05 -0800 (PST)
In-Reply-To: <ec45f3f591691ce6a5253dfb70cc8e90@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Thomas Renninger <trenn@suse.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean Pihet-XID <j-pihet@ti.com>

Hi Santosh,

On Sat, Feb 19, 2011 at 7:55 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of jean.pihet@newoldbits.com
>> Sent: Friday, February 18, 2011 11:41 PM
>> To: Kevin Hilman; Thomas Renninger; linux-omap@vger.kernel.org;
>> linux-arm-kernel@lists.infradead.org
>> Cc: Jean Pihet
>> Subject: [PATCH] perf: add OMAP support for the new power events
>>
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
>> - power domain states: the desired target state and -if different-
>> =A0 the actually hit state.
>>
>> Because of the generic nature of the changes, OMAP3 and OMAP4 are
>> supported.
>>
>> Tested on OMAP3 with suspend/resume, cpuidle, basic DVFS.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/clock.c =A0 =A0 =A0 | =A0 =A08 +++++++-
>> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0| =A0 =A07 +++++++
>> =A0arch/arm/mach-omap2/powerdomain.c | =A0 26 ++++++++++++++++++++++=
+---
>> =A03 files changed, 37 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-
>> omap2/clock.c
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
\n", clk->name,
>> ret);
>> @@ -349,8 +353,10 @@ int omap2_clk_set_rate(struct clk *clk,
>> unsigned long rate)
>> =A0 =A0 =A0 pr_debug("clock: set_rate for clock %s to rate %ld\n", c=
lk-
>> >name, rate);
>>
>> =A0 =A0 =A0 /* dpll_ck, core_ck, virt_prcm_set; plus all clksel cloc=
ks */
>> - =A0 =A0 if (clk->set_rate)
>> + =A0 =A0 if (clk->set_rate) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 trace_clock_set_rate(clk->name, rate,
>> smp_processor_id());
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D clk->set_rate(clk, rate);
>> + =A0 =A0 }
>>
>> =A0 =A0 =A0 return ret;
>> =A0}
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-
>> omap2/pm34xx.c
>> index 2f864e4..d1cc3f4 100644
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
>> @@ -519,8 +520,14 @@ static void omap3_pm_idle(void)
>> =A0 =A0 =A0 if (omap_irq_pending() || need_resched())
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>
>> + =A0 =A0 trace_power_start(POWER_CSTATE, 1, smp_processor_id());
>> + =A0 =A0 trace_cpu_idle(1, smp_processor_id());
>> +
>
> This default idle code won't be used when you enable the
> CONFIG_CPUIDLE. That case the cpuidle34xx.c idle code gets
> registered.
That is correct. OMAP has a default idle handler (omap3_pm_idle) and a
cpuidle handler (omap3_enter_idle in
arch/arm/mach-omap2/cpuidle34xx.c).

> Shouldn't you patch that code instead? This is more or less
> dead code and it is just like default idle code when idle
> drivers isn't registered.
The cpuidle framework already is instrumented in a generic way. This
code adds the instrumentation to the default idle handler so that all
cases are covered. BTW the patch description gives that information.

If there is dead code then it is not only the code from this patch but
all the code for the default idle handler.

Thanks for reviewing.

Regards,
Jean

>
>
>> =A0 =A0 =A0 omap_sram_idle();
>>
>> + =A0 =A0 trace_power_end(smp_processor_id());
>> + =A0 =A0 trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
>> +
>> =A0out:
>> =A0 =A0 =A0 local_fiq_enable();
>> =A0 =A0 =A0 local_irq_enable();
>> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-
>> omap2/powerdomain.c
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
>> @@ -130,8 +135,7 @@ static void
>> _update_logic_membank_counters(struct powerdomain *pwrdm)
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
>> @@ -148,6 +152,17 @@ static int _pwrdm_state_switch(struct
>> powerdomain *pwrdm, int flag)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm->state_counter[pre=
v]++;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (prev =3D=3D PWRDM_POWER_RET)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 _update_logic_membank_co=
unters(pwrdm);
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* If the power domain did not hit the d=
esired state,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* generate a trace event with both the =
desired and hit
>> states
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (state !=3D prev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 trace_state =3D (PWRDM_TRA=
CE_STATES_FLAG |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0((state & OMAP_POWERSTATE_MASK) <<
> 8)
>> |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0((prev & OMAP_POWERSTATE_MASK) <<
>> 0));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 trace_power_domain_target(=
pwrdm->name,
>> trace_state,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 smp_processor_id());
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 default:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> @@ -406,8 +421,13 @@ int pwrdm_set_next_pwrst(struct powerdomain
>> *pwrdm, u8 pwrst)
>> =A0 =A0 =A0 pr_debug("powerdomain: setting next powerstate for %s to
>> %0x\n",
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
>> --
>> 1.7.2.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-
>> omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
