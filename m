From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 2/3] perf: add OMAP support for the new power events
Date: Wed, 5 Jan 2011 12:05:18 +0100
Message-ID: <AANLkTi=3pek3+Vv+c1TCxBH2RJcoSXq8TL8CyK9ABMeu@mail.gmail.com>
References: <1294136263-24020-1-git-send-email-j-pihet@ti.com>
	<1294138484-24729-1-git-send-email-j-pihet@ti.com>
	<alpine.DEB.2.00.1101041146160.19319@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1101041146160.19319@utopia.booyaka.com>
Sender: linux-perf-users-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: mingo@elte.hu, trenn@suse.de, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, linux-perf-users@vger.kernel.org, rjw@sisk.pl, Jean Pihet <j-pihet@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Paul,

On Tue, Jan 4, 2011 at 7:48 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hello Jean,
>
> On Tue, 4 Jan 2011, jean.pihet@newoldbits.com wrote:
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
>> - clocks changes (enable, disable, set_rate),
>
> A question about these. =A0Are these only meant to track calls to the=
se
> functions from outside the clock code? =A0Or meant to track actual ha=
rdware
> clock changes?
The former: this is used to track the clock requests from outside the
clock framework.

> If the latter, then it might make sense to put these
> trace points into the functions that actually change the hardware
> registers, e.g., omap2_dflt_clk_{enable,disable}(), etc., since a
> clk_enable() on a leaf clock may result in many internal system clock=
s
> being enabled up the clock tree.
I agree with you it is better to track the actual clock changes instead=
=2E
I propose to move the tracepoints to omap2_clk_{enable...} which
enables all the clocks irrespectively of the installed handler.
Note about the clock handlers: omap2_dflt_clk_enable happens to be the
handler for all controllable clocks but could that change in the
future?

>
>
> - Paul

Thanks,
Jean

>
>> - change of power domains next power states.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0| =A0 =A07 +++++++
>> =A0arch/arm/mach-omap2/powerdomain.c | =A0 =A03 +++
>> =A0arch/arm/plat-omap/clock.c =A0 =A0 =A0 =A0| =A0 13 ++++++++++---
>> =A03 files changed, 20 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34=
xx.c
>> index 0ec8a04..0ee0b0e 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -29,6 +29,7 @@
>> =A0#include <linux/delay.h>
>> =A0#include <linux/slab.h>
>> =A0#include <linux/console.h>
>> +#include <trace/events/power.h>
>>
>> =A0#include <plat/sram.h>
>> =A0#include <plat/clockdomain.h>
>> @@ -506,8 +507,14 @@ static void omap3_pm_idle(void)
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
>> index 6527ec3..73cbe9a 100644
>> --- a/arch/arm/mach-omap2/powerdomain.c
>> +++ b/arch/arm/mach-omap2/powerdomain.c
>> @@ -23,6 +23,7 @@
>> =A0#include <linux/errno.h>
>> =A0#include <linux/err.h>
>> =A0#include <linux/io.h>
>> +#include <trace/events/power.h>
>>
>> =A0#include <asm/atomic.h>
>>
>> @@ -440,6 +441,8 @@ int pwrdm_set_next_pwrst(struct powerdomain *pwr=
dm, u8 pwrst)
>> =A0 =A0 =A0 pr_debug("powerdomain: setting next powerstate for %s to=
 %0x\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pwrdm->name, pwrst);
>>
>> + =A0 =A0 trace_power_domain_target(pwrdm->name, pwrst, smp_processo=
r_id());
>> +
>> =A0 =A0 =A0 prm_rmw_mod_reg_bits(OMAP_POWERSTATE_MASK,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(pwrst << OMA=
P_POWERSTATE_SHIFT),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pwrdm->prcm_o=
ffs, pwrstctrl_reg_offs);
>> diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
>> index fc62fb5..7cbb09b 100644
>> --- a/arch/arm/plat-omap/clock.c
>> +++ b/arch/arm/plat-omap/clock.c
>> @@ -21,6 +21,7 @@
>> =A0#include <linux/cpufreq.h>
>> =A0#include <linux/debugfs.h>
>> =A0#include <linux/io.h>
>> +#include <trace/events/power.h>
>>
>> =A0#include <plat/clock.h>
>>
>> @@ -43,8 +44,10 @@ int clk_enable(struct clk *clk)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>
>> =A0 =A0 =A0 spin_lock_irqsave(&clockfw_lock, flags);
>> - =A0 =A0 if (arch_clock->clk_enable)
>> + =A0 =A0 if (arch_clock->clk_enable) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 trace_clock_enable(clk->name, 1, smp_proce=
ssor_id());
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D arch_clock->clk_enable(clk);
>> + =A0 =A0 }
>> =A0 =A0 =A0 spin_unlock_irqrestore(&clockfw_lock, flags);
>>
>> =A0 =A0 =A0 return ret;
>> @@ -66,8 +69,10 @@ void clk_disable(struct clk *clk)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 if (arch_clock->clk_disable)
>> + =A0 =A0 if (arch_clock->clk_disable) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 trace_clock_disable(clk->name, 0, smp_proc=
essor_id());
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 arch_clock->clk_disable(clk);
>> + =A0 =A0 }
>>
>> =A0out:
>> =A0 =A0 =A0 spin_unlock_irqrestore(&clockfw_lock, flags);
>> @@ -120,8 +125,10 @@ int clk_set_rate(struct clk *clk, unsigned long=
 rate)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>>
>> =A0 =A0 =A0 spin_lock_irqsave(&clockfw_lock, flags);
>> - =A0 =A0 if (arch_clock->clk_set_rate)
>> + =A0 =A0 if (arch_clock->clk_set_rate) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 trace_clock_set_rate(clk->name, rate, smp_=
processor_id());
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D arch_clock->clk_set_rate(clk, ra=
te);
>> + =A0 =A0 }
>> =A0 =A0 =A0 if (ret =3D=3D 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (clk->recalc)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk->rate =3D clk->recal=
c(clk);
>> --
>> 1.7.2.3
>>
>
>
> - Paul
>
