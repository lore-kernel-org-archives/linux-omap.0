From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V3 5/7] ARM: OMAP3: Update clocksource timer selection
Date: Tue, 5 Feb 2013 10:49:55 -0600
Message-ID: <51113833.2090306@ti.com>
References: <1360007196-21350-1-git-send-email-jon-hunter@ti.com> <1360007196-21350-6-git-send-email-jon-hunter@ti.com> <5110C53F.1010203@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41031 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751437Ab3BEQuB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Feb 2013 11:50:01 -0500
In-Reply-To: <5110C53F.1010203@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>


On 02/05/2013 02:39 AM, Igor Grinberg wrote:
> On 02/04/13 21:46, Jon Hunter wrote:
>> When booting with device-tree for OMAP3 and AM335x devices and a gptimer
>> is used as the clocksource (which is always the case for AM335x), a
>> gptimer located in a power domain that is not always-on is selected.
>> Ideally we should use a gptimer located in a power domain that is always
>> on (such as the wake-up domain) so that time can be maintained during a
>> kernel suspend without keeping on additional power domains unnecessarily.
>>
>> In order to fix this so that we can select a gptimer located in a power
>> domain that is always-on, the following changes were made ...
>> 1. Currently, only when selecting a gptimer to use for a clockevent
>>    timer, do we pass a timer property that can be used to select a
>>    specific gptimer. Change this so that we can pass a property when
>>    selecting a gptimer to use for a clocksource timer too.
>> 2. Currently, when selecting either a gptimer to use for a clockevent
>>    timer or a clocksource timer and no timer property is passed, then
>>    the first available timer is selected regardless of the properties
>>    it has. Change this so that if no properties are passed, then a timer
>>    that does not have additional features (such as always-on, dsp-irq,
>>    pwm, and secure) is selected.
>>
>> Please note that using a gptimer for both clocksource and clockevents
>> can have a system power impact during idle. The reason being is that
>> OMAP and AMxxx devices typically only have one gptimer in a power domain
>> that is always-on. Therefore when the kernel is idle both the clocksource
>> and clockevent timers will be active and this will keep additional power
>> domains on. During kernel suspend, only the clocksource timer is active
>> and therefore, it is better to use a gptimer in a power domain that is
>> always-on for clocksource.
> 
> Hmmm...
> Do I miss something or you have forgot to update the commit message?

Ugh you are right :-(

Some how yesterday when rebasing the series and adding a couple more
patches, I royally screwed it up. How about the following ...

Cheers
Jon

>From c82699e94d0255b3b1524e0d5ff4fd1f5852de69 Mon Sep 17 00:00:00 2001
From: Jon Hunter <jon-hunter@ti.com>
Date: Mon, 28 Jan 2013 17:53:57 -0600
Subject: [PATCH] ARM: OMAP3: Update clocksource timer selection

When booting with device-tree for OMAP3 and AM335x devices and a gptimer
is used as the clocksource (which is always the case for AM335x), a
gptimer located in a power domain that is not always-on is selected.
Ideally we should use a gptimer for clocksource that is located in a
power domain that is always on (such as the wake-up domain) so that time
can be maintained during a kernel suspend without keeping on additional
power domains unnecessarily.

In order to fix this so that we can select a gptimer located in a power
domain that is always-on, the following changes were made ...
1. Currently, only when selecting a gptimer to use for a clockevent
   timer, do we pass a timer property that can be used to select a
   specific gptimer. Change this so that we can pass a property when
   selecting a gptimer to use for a clocksource timer too.
2. Currently, when selecting either a gptimer to use for a clockevent
   timer or a clocksource timer and no timer property is passed, then
   the first available timer is selected regardless of the properties
   it has. Change this so that if no properties are passed, then a timer
   that does not have additional features (such as always-on, dsp-irq,
   pwm, and secure) is selected.

For OMAP3 and AM335x devices that use a gptimer for clocksource, change
the selection of the gptimer so that by default the gptimer located in
the always-on power domain is used for clocksource instead of
clockevents.

Please note that using a gptimer for both clocksource and clockevents
can have a system power impact during idle. The reason being is that
OMAP and AMxxx devices typically only have one gptimer in a power domain
that is always-on. Therefore when the kernel is idle both the clocksource
and clockevent timers will be active and this will keep additional power
domains on. During kernel suspend, only the clocksource timer is active
and therefore, it is better to use a gptimer in a power domain that is
always-on for clocksource.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap2/timer.c |   33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 3ad9a3b..fce495e 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -160,6 +160,12 @@ static struct device_node * __init omap_get_timer_dt(struct of_device_id *match,
 		if (property && !of_get_property(np, property, NULL))
 			continue;
 
+		if (!property && (of_get_property(np, "ti,timer-alwon", NULL) ||
+				  of_get_property(np, "ti,timer-dsp", NULL) ||
+				  of_get_property(np, "ti,timer-pwm", NULL) ||
+				  of_get_property(np, "ti,timer-secure", NULL)))
+			continue;
+
 		of_add_property(np, &device_disabled);
 		return np;
 	}
@@ -435,13 +441,14 @@ static int __init __maybe_unused omap2_sync32k_clocksource_init(void)
 }
 
 static void __init omap2_gptimer_clocksource_init(int gptimer_id,
-						const char *fck_source)
+						  const char *fck_source,
+						  const char *property)
 {
 	int res;
 
 	clksrc.errata = omap_dm_timer_get_errata();
 
-	res = omap_dm_timer_init_one(&clksrc, gptimer_id, fck_source, NULL,
+	res = omap_dm_timer_init_one(&clksrc, gptimer_id, fck_source, property,
 				     &clocksource_gpt.name,
 				     OMAP_TIMER_NONPOSTED);
 	BUG_ON(res);
@@ -538,47 +545,49 @@ static inline void __init realtime_counter_init(void)
 #endif
 
 #define OMAP_SYS_GP_TIMER_INIT(name, clkev_nr, clkev_src, clkev_prop,	\
-			       clksrc_nr, clksrc_src)			\
+			       clksrc_nr, clksrc_src, clksrc_prop)	\
 void __init omap##name##_gptimer_timer_init(void)			\
 {									\
 	omap_dmtimer_init();						\
 	omap2_gp_clockevent_init((clkev_nr), clkev_src, clkev_prop);	\
-	omap2_gptimer_clocksource_init((clksrc_nr), clksrc_src);	\
+	omap2_gptimer_clocksource_init((clksrc_nr), clksrc_src,		\
+					clksrc_prop);			\
 }
 
 #define OMAP_SYS_32K_TIMER_INIT(name, clkev_nr, clkev_src, clkev_prop,	\
-				clksrc_nr, clksrc_src)			\
+				clksrc_nr, clksrc_src, clksrc_prop)	\
 void __init omap##name##_sync32k_timer_init(void)		\
 {									\
 	omap_dmtimer_init();						\
 	omap2_gp_clockevent_init((clkev_nr), clkev_src, clkev_prop);	\
 	/* Enable the use of clocksource="gp_timer" kernel parameter */	\
 	if (use_gptimer_clksrc)						\
-		omap2_gptimer_clocksource_init((clksrc_nr), clksrc_src);\
+		omap2_gptimer_clocksource_init((clksrc_nr), clksrc_src,	\
+						clksrc_prop);		\
 	else								\
 		omap2_sync32k_clocksource_init();			\
 }
 
 #ifdef CONFIG_ARCH_OMAP2
 OMAP_SYS_32K_TIMER_INIT(2, 1, "timer_32k_ck", "ti,timer-alwon",
-			2, "timer_sys_ck");
+			2, "timer_sys_ck", NULL);
 #endif /* CONFIG_ARCH_OMAP2 */
 
 #ifdef CONFIG_ARCH_OMAP3
 OMAP_SYS_32K_TIMER_INIT(3, 1, "timer_32k_ck", "ti,timer-alwon",
-			2, "timer_sys_ck");
+			2, "timer_sys_ck", NULL);
 OMAP_SYS_32K_TIMER_INIT(3_secure, 12, "secure_32k_fck", "ti,timer-secure",
-			2, "timer_sys_ck");
+			2, "timer_sys_ck", NULL);
 #endif /* CONFIG_ARCH_OMAP3 */
 
 #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM33XX)
-OMAP_SYS_GP_TIMER_INIT(3, 1, "timer_sys_ck", "ti,timer-alwon",
-		       2, "timer_sys_ck");
+OMAP_SYS_GP_TIMER_INIT(3, 2, "timer_sys_ck", NULL,
+		       1, "timer_sys_ck", "ti,timer-alwon");
 #endif
 
 #if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5)
 OMAP_SYS_32K_TIMER_INIT(4, 1, "timer_32k_ck", "ti,timer-alwon",
-			2, "sys_clkin_ck");
+			2, "sys_clkin_ck", NULL);
 #endif
 
 #ifdef CONFIG_ARCH_OMAP4
-- 
1.7.10.4
