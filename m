From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V2 01/14] ARM: OMAP: Add DMTIMER definitions for posted
 mode
Date: Thu, 8 Nov 2012 10:52:40 -0600
Message-ID: <509BE358.2080004@ti.com>
References: <1352314890-22224-1-git-send-email-jon-hunter@ti.com> <1352314890-22224-2-git-send-email-jon-hunter@ti.com> <509ADAFE.4070109@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42777 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752404Ab2KHQwp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Nov 2012 11:52:45 -0500
In-Reply-To: <509ADAFE.4070109@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 11/07/2012 04:04 PM, Santosh Shilimkar wrote:
> On Wednesday 07 November 2012 01:01 PM, Jon Hunter wrote:
>> For OMAP2+ devices, when using DMTIMERs for system timers
>> (clock-events and
>> clock-source) the posted mode configuration of the timers is used. To
>> allow
>> the compiler to optimise the functions for configuring and reading the
>> system
>> timers, the posted flag variable is hard-coded with the value 1. To
>> make it
>> clear that posted mode is being used add some definitions so that it
>> is more
>> readable.
>>
>> Add separate definitions for the clock-events and clock-source timers
>> so that
>> we can change the posted mode of clock-events and clock-source
>> independently.
>>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>> ---
>>   arch/arm/mach-omap2/timer.c               |   26
>> +++++++++++++++++++-------
>>   arch/arm/plat-omap/include/plat/dmtimer.h |    4 ++++
>>   2 files changed, 23 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
>> index 0758bae..28c6078 100644
>> --- a/arch/arm/mach-omap2/timer.c
>> +++ b/arch/arm/mach-omap2/timer.c
>> @@ -82,6 +82,13 @@
>>   #define INCREMENTER_DENUMERATOR_RELOAD_OFFSET        0x14
>>   #define NUMERATOR_DENUMERATOR_MASK            0xfffff000
>>
>> +/*
>> + * For clock-events timer, always use posted mode to
>> + * minimise CPU overhead for configuring the timer.
>> + */
>> +#define OMAP_CLKEVT_POSTEDMODE    OMAP_TIMER_POSTED
>> +#define OMAP_CLKSRC_POSTEDMODE    OMAP_TIMER_POSTED
>> +
> I don't see need of above defines. Just use OMAP_TIMER_POSTED directly
> with API. Rest of the patch looks fine.
> 
> Apart from above one comment,
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Ok, updated and dropped the additional definitions. Let me know if you 
are ok with this.

Cheers
Jon

>From f1c783b5af933374431bcb8acb01d0b5c79d5661 Mon Sep 17 00:00:00 2001
From: Jon Hunter <jon-hunter@ti.com>
Date: Thu, 27 Sep 2012 11:49:45 -0500
Subject: [PATCH 1/2] ARM: OMAP: Add DMTIMER definitions for posted mode

For OMAP2+ devices, when using DMTIMERs for system timers (clock-events and
clock-source) the posted mode configuration of the timers is used. To allow
the compiler to optimise the functions for configuring and reading the system
timers, the posted flag variable is hard-coded with the value 1. To make it
clear that posted mode is being used add some definitions so that it is more
readable.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/timer.c               |   17 ++++++++++-------
 arch/arm/plat-omap/include/plat/dmtimer.h |    4 ++++
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 0758bae..ad427ba 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -107,7 +107,7 @@ static int omap2_gp_timer_set_next_event(unsigned long cycles,
 					 struct clock_event_device *evt)
 {
 	__omap_dm_timer_load_start(&clkev, OMAP_TIMER_CTRL_ST,
-						0xffffffff - cycles, 1);
+				   0xffffffff - cycles, OMAP_TIMER_POSTED);
 
 	return 0;
 }
@@ -117,7 +117,7 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
 {
 	u32 period;
 
-	__omap_dm_timer_stop(&clkev, 1, clkev.rate);
+	__omap_dm_timer_stop(&clkev, OMAP_TIMER_POSTED, clkev.rate);
 
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
@@ -125,10 +125,10 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
 		period -= 1;
 		/* Looks like we need to first set the load value separately */
 		__omap_dm_timer_write(&clkev, OMAP_TIMER_LOAD_REG,
-					0xffffffff - period, 1);
+				      0xffffffff - period, OMAP_TIMER_POSTED);
 		__omap_dm_timer_load_start(&clkev,
 					OMAP_TIMER_CTRL_AR | OMAP_TIMER_CTRL_ST,
-						0xffffffff - period, 1);
+					0xffffffff - period, OMAP_TIMER_POSTED);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
 		break;
@@ -358,7 +358,8 @@ static bool use_gptimer_clksrc;
  */
 static cycle_t clocksource_read_cycles(struct clocksource *cs)
 {
-	return (cycle_t)__omap_dm_timer_read_counter(&clksrc, 1);
+	return (cycle_t)__omap_dm_timer_read_counter(&clksrc,
+						     OMAP_TIMER_POSTED);
 }
 
 static struct clocksource clocksource_gpt = {
@@ -372,7 +373,8 @@ static struct clocksource clocksource_gpt = {
 static u32 notrace dmtimer_read_sched_clock(void)
 {
 	if (clksrc.reserved)
-		return __omap_dm_timer_read_counter(&clksrc, 1);
+		return __omap_dm_timer_read_counter(&clksrc,
+						    OMAP_TIMER_POSTED);
 
 	return 0;
 }
@@ -454,7 +456,8 @@ static void __init omap2_gptimer_clocksource_init(int gptimer_id,
 	BUG_ON(res);
 
 	__omap_dm_timer_load_start(&clksrc,
-			OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0, 1);
+				   OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0,
+				   OMAP_TIMER_POSTED);
 	setup_sched_clock(dmtimer_read_sched_clock, 32, clksrc.rate);
 
 	if (clocksource_register_hz(&clocksource_gpt, clksrc.rate))
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 348f855..835c3bdf 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -55,6 +55,10 @@
 #define OMAP_TIMER_TRIGGER_OVERFLOW		0x01
 #define OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE	0x02
 
+/* posted mode types */
+#define OMAP_TIMER_NONPOSTED			0x00
+#define OMAP_TIMER_POSTED			0x01
+
 /* timer capabilities used in hwmod database */
 #define OMAP_TIMER_SECURE				0x80000000
 #define OMAP_TIMER_ALWON				0x40000000
-- 
1.7.9.5

