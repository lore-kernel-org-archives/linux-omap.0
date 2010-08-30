From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] OMAP2: add cpuidle and cpufreq events tracing
Date: Mon, 30 Aug 2010 15:08:13 +0200
Message-ID: <AANLkTinW=YDTDv9iOkpTgvDdXa0eQLJJgpvvZiG6C+K3@mail.gmail.com>
References: <AANLkTim-n+3sTzrxKStniAjHFWxGx4xVAf=FkZ4U282f@mail.gmail.com>
	<87r5hmft7c.fsf@deeprootsystems.com>
	<AANLkTiknAXe4SNavZpwSVY__v4bRTiWZEA5NxMMi5y10@mail.gmail.com>
	<87iq2wsz2u.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:34615 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755016Ab0H3NIU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Aug 2010 09:08:20 -0400
Received: by qwh6 with SMTP id 6so4807618qwh.19
        for <linux-omap@vger.kernel.org>; Mon, 30 Aug 2010 06:08:19 -0700 (PDT)
In-Reply-To: <87iq2wsz2u.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Fri, Aug 27, 2010 at 2:01 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Jean Pihet <jean.pihet@newoldbits.com> writes:
>
>> Hi Kevin,
>>
>> On Wed, Aug 25, 2010 at 8:22 PM, Kevin Hilman
>> <khilman@deeprootsystems.com> wrote:
>>> Hi Jean,
>>>
>>> Jean Pihet <jean.pihet@newoldbits.com> writes:
>>>
>> ...
>>>
>>>> Add the cpuidle power_start and power_end events. The state
>>>> parameter of power_start has the following meaning:
>>>> - -1: from the suspend handler (omap3_pm_suspend),
>>>> - 1: from the default idle handler (omap3_pm_idle),
>>>> - other values are the C-states from the cpuidle handler
>>>> =A0 =A0(omap3_enter_idle).
>>>
>>> Are these definitions standard across other arches too? =A0The use =
of
>>> POWER_CSTATE from supend seems less than intuitive.
>> Only x86 is using those events, and only for idle (values >=3D 0).
>> I have added -1 to differentiate the suspend from the regular idle b=
ut
>> it sems that it is not the best option.
>> Is a new type of power event more suited, e.g. POWER_SSTATE? If so I
>> will have to add it in the event definition header (in
>> include/trace/events/power.h) and the patch will be submitted to LKM=
L.
>
> Yes, I think a new event is probably more appropriate, but should be
> discussed on LKML.
Indeed.

Here is a respin of the patch, on top of the l-o tree. The rest of the
changes are discussed on LKML.

>
> Kevin
>
Jean

---
Add the cpuidle power_start and power_end events. The state
parameter of power_start has the following meaning:
- 1: from the default idle handler (omap3_pm_idle),
- other values are the C-states from the cpuidle handler
  (omap3_enter_idle).

Add the cpufreq power_frequency event, with the state
parameter being the target CPU frequency.

Cf. http://omappedia.org/wiki/Power_Management_Debug_and_Profiling
for more details on PM debug and profiling.

Signed-off-by: Jean Pihet <jpihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    2 ++
 arch/arm/mach-omap2/pm34xx.c      |    2 ++
 arch/arm/plat-omap/cpu-omap.c     |    5 ++++-
 3 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c
b/arch/arm/mach-omap2/cpuidle34xx.c
index 3d3d035..6113bd9 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -24,6 +24,7 @@

 #include <linux/sched.h>
 #include <linux/cpuidle.h>
+#include <trace/events/power.h>

 #include <plat/prcm.h>
 #include <plat/irqs.h>
@@ -130,6 +131,7 @@ static int omap3_enter_idle(struct cpuidle_device *=
dev,
 	local_irq_disable();
 	local_fiq_disable();

+	trace_power_start(POWER_CSTATE, cx->type, smp_processor_id());
 	pwrdm_set_next_pwrst(mpu_pd, mpu_state);
 	pwrdm_set_next_pwrst(core_pd, core_state);

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.=
c
index f25bc3d..04bc758 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -28,6 +28,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <trace/events/power.h>

 #include <plat/sram.h>
 #include <plat/clockdomain.h>
@@ -588,6 +589,7 @@ static void omap3_pm_idle(void)
 	if (omap_irq_pending() || need_resched())
 		goto out;

+	trace_power_start(POWER_CSTATE, 1, smp_processor_id());
 	omap_sram_idle();

 out:
diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-oma=
p.c
index df08829..cc4e41f 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -25,6 +25,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <trace/events/power.h>

 #include <mach/hardware.h>
 #include <plat/clock.h>
@@ -116,8 +117,10 @@ static int omap_target(struct cpufreq_policy *poli=
cy,
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 #elif defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
 	freq =3D target_freq * 1000;
-	if (opp_find_freq_ceil(mpu_dev, &freq))
+	if (opp_find_freq_ceil(mpu_dev, &freq)) {
+		trace_power_frequency(POWER_PSTATE, freq, smp_processor_id());
 		omap_pm_cpu_set_freq(freq);
+	}
 #endif
 	return ret;
 }
--=20
1.7.1
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
