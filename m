From: Kevin Hilman <khilman@ti.com>
Subject: Re: PM related performance degradation on OMAP3
Date: Tue, 01 May 2012 10:27:46 -0700
Message-ID: <87txzzhkvh.fsf@ti.com>
References: <CANOLnOP5gq4Vtt00SgRNW-3GZDWk0sukBgJx4V6rkMLL+b6G-w@mail.gmail.com>
	<877gxobudk.fsf@ti.com>
	<CANOLnOPbHBshCdbmSOjYdubWqUivrVpR-+eaayu=v4Yy6yKdsQ@mail.gmail.com>
	<87ehrtn6na.fsf@ti.com>
	<CANOLnOM_-yhr-j=UO3ynJ6HyJxzd_2FshPMXMLpcBcOB0mL7Qw@mail.gmail.com>
	<87y5puwhus.fsf@ti.com>
	<CAORVsuWP72dHFSBhX=Kux7GEk33qQgR74a74FFwzA8uniSabAQ@mail.gmail.com>
	<877gx5dwz2.fsf@ti.com>
	<CAORVsuXX9c+8-uJ1e1U920_jy0MK53jmCu+hXhHaXapHArMeLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:56110 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753933Ab2EAR1s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 May 2012 13:27:48 -0400
Received: by pbbrp12 with SMTP id rp12so3058927pbb.15
        for <linux-omap@vger.kernel.org>; Tue, 01 May 2012 10:27:46 -0700 (PDT)
In-Reply-To: <CAORVsuXX9c+8-uJ1e1U920_jy0MK53jmCu+hXhHaXapHArMeLg@mail.gmail.com>
	(Jean Pihet's message of "Tue, 1 May 2012 16:10:44 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

Jean Pihet <jean.pihet@newoldbits.com> writes:

> HI Kevin, Grazvydas,
>
> On Tue, Apr 24, 2012 at 4:29 PM, Kevin Hilman <khilman@ti.com> wrote:
>> Jean Pihet <jean.pihet@newoldbits.com> writes:
>>
>>> Hi Grazvydas, Kevin,
>>>
>>> I did some gather some performance measurements and statistics using
>>> custom tracepoints in __omap3_enter_idle.
> I posted the patches for the power domains registers cache, cf.
> http://marc.info/?l=linux-omap&m=133587781712039&w=2.
>
>>> All the details are at
>>> http://www.omappedia.org/wiki/Power_Management_Device_Latencies_Measurement#C1_performance_problem:_analysis
> I updated the page with the measurements results with Kevin's patches
> and the registers cache patches.
>
> The results are showing that:
> - the registers cache optimizes the low power mode transitions, but is
> not sufficient to obtain a big gain. A few unused domains are
> transitioning, which causes a big penalty in the idle path.

PER is the one that seems to be causing the most latency.  

Can you try do your measurements using hack below which makes sure that
PER isn't any deeper than CORE?

Kevin

>From bb2f67ed93dc83c645080e293d315d383c23c0c6 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Mon, 16 Apr 2012 17:53:14 -0700
Subject: [PATCH] cpuidle34xx: per follows core, C1 use _bm

---
 arch/arm/mach-omap2/cpuidle34xx.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 374708d..00400ad 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -278,9 +278,11 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 	cx = cpuidle_get_statedata(&dev->states_usage[index]);
 	core_next_state = cx->core_state;
 	per_next_state = per_saved_state = pwrdm_read_next_pwrst(per_pd);
-	if ((per_next_state == PWRDM_POWER_OFF) &&
-	    (core_next_state > PWRDM_POWER_RET))
-		per_next_state = PWRDM_POWER_RET;
+	/* if ((per_next_state == PWRDM_POWER_OFF) && */
+	/*     (core_next_state > PWRDM_POWER_RET)) */
+	/* 	per_next_state = PWRDM_POWER_RET; */
+	if (per_next_state < core_next_state)
+		per_next_state = core_next_state;
 
 	/* Are we changing PER target state? */
 	if (per_next_state != per_saved_state)
@@ -374,7 +376,6 @@ int __init omap3_idle_init(void)
 
 	/* C1 . MPU WFI + Core active */
 	_fill_cstate(drv, 0, "MPU ON + CORE ON");
-	(&drv->states[0])->enter = omap3_enter_idle;
 	drv->safe_state_index = 0;
 	cx = _fill_cstate_usage(dev, 0);
 	cx->valid = 1;	/* C1 is always valid */
-- 
1.7.9.2

