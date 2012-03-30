From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check
 presence of 32k timer
Date: Fri, 30 Mar 2012 06:34:17 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A831840C2E@DBDE01.ent.ti.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
 <1326983304-14619-2-git-send-email-hvaibhav@ti.com> <87mx9ej8fp.fsf@ti.com>
 <CACVXFVOqmC0OhT-Dim8dL9pWnmGwO2-Awc4V2Jziyf7DHQdYcQ@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83181EF3F@DBDE01.ent.ti.com>
 <CACVXFVP4J8N271Tww77Btm9fGNiP17MepjswBJ0V-8Z4sNt8Eg@mail.gmail.com>
 <4F672364.3020403@ti.com>
 <79CD15C6BA57404B839C016229A409A83182386C@DBDE01.ent.ti.com>
 <CAMQu2gyFNXgx87Fsq5is88DOkOx-nWK6ohwyFV-CY2uTkZCGMA@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83183EA54@DBDE01.ent.ti.com>
 <CAMQu2gyF83HJOE9Rf-fZXXMt=p_WFjFf3DpAeW8L8+htR4E6-g@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83183EB47@DBDE01.ent.ti.com>
 <CAMQu2gzYULK+=6-WKQnnQDpzTYW7xKAOZo7obyu2q178jtNE-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53978 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754582Ab2C3Geg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Mar 2012 02:34:36 -0400
In-Reply-To: <CAMQu2gzYULK+=6-WKQnnQDpzTYW7xKAOZo7obyu2q178jtNE-Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Ming Lei <tom.leiming@gmail.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Balbi, Felipe" <balbi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

On Wed, Mar 28, 2012 at 20:19:07, Shilimkar, Santosh wrote:
> On Wed, Mar 28, 2012 at 8:07 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
> > On Wed, Mar 28, 2012 at 19:50:02, Shilimkar, Santosh wrote:
> >> On Wed, Mar 28, 2012 at 7:46 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
> >> > On Wed, Mar 21, 2012 at 19:30:01, Shilimkar, Santosh wrote:
> >> >> On Wed, Mar 21, 2012 at 5:12 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
> >> >> > On Mon, Mar 19, 2012 at 17:45:32, Shilimkar, Santosh wrote:
> >> >> >> On Monday 19 March 2012 05:14 PM, Ming Lei wrote:
> >> >> >> > On Mon, Mar 19, 2012 at 7:11 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
> >>
> >> [...]
> >>
> >> >
> >> >> Btw, if you need PM, how are you going to use GPTIMER
> >> >> as a clocksource. Note sys-clock is generally stopped in
> >> >> low power states. So that leaves you option with using
> >> >> gptimer with 32K clock and in that case, GPTIMER
> >> >> is not a better clock-source compare to 32K sync timer
> >> >> and so shouldn't be the rating.
> >> >>
> >> >
> >> > AM33xx has GPTIMER1 in wakeup domain, so that we are already using as a
> >> > Clocksource, without any issues.
> >> >
> >> GPTIMER1 is in wakeup domain on OMAP too but that doesn't
> >> solve the issue I am talking. Once the sysclock is stopped, GPTIMER
> >> can't tick anymore even if it is in wakeup domain.
> >>
> >> The only way it will work is using always running 32KHz clock as
> >> the clock input to GPT1. And then the end result is the accuracy
> >> of GPTIMER = sync 32K timer. So they are of same rating.
> >>
> >
> > Ohh ok, sorry I should have clarified it in my last response itself.
> >
> np.
> 
> > AM33xx architecture is bit different than OMAP family, and gmtimer1 is
> > sourced from RTC32K clock, which is in wakeup domain.
> > This means we have RTC32K clock always running across suspend/resume.
> >
> > 0 - SEL1: Select CLK_M_OSC clock
> > 1 - SEL2: Select CLK_32KHZ clock
> > 2 - SEL3: Select TCLKIN clock
> > 3 - SEL4: Select CLK_RC32K clock
> > 4 - SEL5: Selects the CLK_32768 from 32KHz Crystal Osc
> >
> >
> > We use value "4" here, for RTC32K (always on clock).
> > I hope this clarifies what I am trying to say here.
> >
> I thought so and now if you look at last part of my comment.
> 
> Rating of 32K based synctimer and 32K based GPTIMER
> should be same because of the precision. That's the main
> point why I was saying that GPTIMER is not a better
> clock-source( with 32k clock src)  than sync timer when
> both are enabled together.
> 

Santosh,

In case of OMAP, we are using timer 2 for clocksource

OMAP_SYS_TIMER_INIT(2, 1, OMAP2_CLKEV_SOURCE, 2, OMAP2_MPU_SOURCE)
OMAP_SYS_TIMER_INIT(3, 1, OMAP3_CLKEV_SOURCE, 2, OMAP3_MPU_SOURCE)

And timer2 as clocksource is never used, since we have CONFIG_OMAP_32K_TIMER 
defined in our defconfig.

Also, after looking at the code, I came across another problem, setup_sched_clock(). But this can be easily fixed, if we source both the timers with same clock (here 32k_fck).


Let me propose this,

How about, if I keep timer2 source always set to 32k_fclk for omap2,3,4?
And also, as mentioned by Santosh, I will register both the clocks as 
clocksource with the same rating.
By default, kernel is going to use 32k_counter as a clocksource, and through 
Command prompt user can override it without any issues.

Just to make sure that, whatever I am trying to propse here works and don't get into unknown issue; I changed my code for this, and it is working for me without any issues.

Also, this way I can completely get rid of option CONFIG_OMAP_32K_TIMER_HZ.




diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 6b12372..ded78b7 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -45,6 +45,7 @@
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
 #include <plat/omap-pm.h>
+#include <plat/clock.h>
 
 #include "powerdomain.h"
 
@@ -57,18 +58,18 @@
 #define OMAP3_32K_SOURCE	"omap_32k_fck"
 #define OMAP4_32K_SOURCE	"sys_32k_ck"
 
-#ifdef CONFIG_OMAP_32K_TIMER
+//#ifdef CONFIG_OMAP_32K_TIMER
 #define OMAP2_CLKEV_SOURCE	OMAP2_32K_SOURCE
 #define OMAP3_CLKEV_SOURCE	OMAP3_32K_SOURCE
 #define OMAP4_CLKEV_SOURCE	OMAP4_32K_SOURCE
 #define OMAP3_SECURE_TIMER	12
-#else
+/*#else
 #define OMAP2_CLKEV_SOURCE	OMAP2_MPU_SOURCE
 #define OMAP3_CLKEV_SOURCE	OMAP3_MPU_SOURCE
 #define OMAP4_CLKEV_SOURCE	OMAP4_MPU_SOURCE
 #define OMAP3_SECURE_TIMER	1
 #endif
-
+*/
 /* MAX_GPTIMER_ID: number of GPTIMERs on the chip */
 #define MAX_GPTIMER_ID		12
 
@@ -244,6 +245,7 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
 
 /* Clocksource code */
 static struct omap_dm_timer clksrc;
+static bool is_dmtimer_clocksource;
 
 /*
  * clocksource
@@ -253,20 +255,38 @@ static cycle_t clocksource_read_cycles(struct clocksource *cs)
 	return (cycle_t)__omap_dm_timer_read_counter(&clksrc, 1);
 }
 
+static int clocksource_enable(struct clocksource *cs)
+{
+	__omap_dm_timer_load_start(&clksrc,
+			OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR,
+			omap_32k_read_sched_clock(), 1);
+
+	is_dmtimer_clocksource = true;
+	return 0;
+}
+
+static void clocksource_disable(struct clocksource *cs)
+{
+	__omap_dm_timer_stop(&clksrc, 1, clksrc.rate);
+	is_dmtimer_clocksource = false;
+}
+
 static struct clocksource clocksource_gpt = {
 	.name		= "gp timer",
-	.rating		= 300,
+	.rating		= 250,
 	.read		= clocksource_read_cycles,
+	.enable		= clocksource_enable,
+	.disable	= clocksource_disable,
 	.mask		= CLOCKSOURCE_MASK(32),
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static u32 notrace dmtimer_read_sched_clock(void)
+static u32 notrace read_sched_clock(void)
 {
-	if (clksrc.reserved)
+	if (is_dmtimer_clocksource && clksrc.reserved)
 		return __omap_dm_timer_read_counter(&clksrc, 1);
-
-	return 0;
+	else
+		return omap_32k_read_sched_clock();
 }
 
 /* Setup free-running counter for clocksource */
@@ -282,8 +302,8 @@ static void __init omap2_gp_clocksource_init(int gptimer_id,
 	 * execution will fallback to gp-timer.
 	 */
 	res = omap_init_clocksource_32k();
-	if (!res)
-		return;
+	if (res)
+		pr_err("failed to init 32k_counter as a clocksource %d\n", res);
 
 	/* Fall back to gp-timer code */
 	res = omap_dm_timer_init_one(&clksrc, gptimer_id, fck_source);
@@ -292,9 +312,9 @@ static void __init omap2_gp_clocksource_init(int gptimer_id,
 	pr_info("OMAP clocksource: GPTIMER%d at %lu Hz\n",
 		gptimer_id, clksrc.rate);
 
-	__omap_dm_timer_load_start(&clksrc,
-			OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0, 1);
-	setup_sched_clock(dmtimer_read_sched_clock, 32, clksrc.rate);
+//	__omap_dm_timer_load_start(&clksrc,
+//			OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0, 1);
+	setup_sched_clock(read_sched_clock, 32, clksrc.rate);
 
 	if (clocksource_register_hz(&clocksource_gpt, clksrc.rate))
 		pr_err("Could not register clocksource %s\n",
@@ -315,12 +335,12 @@ struct sys_timer omap##name##_timer = {					\
 };
 
 #ifdef CONFIG_ARCH_OMAP2
-OMAP_SYS_TIMER_INIT(2, 1, OMAP2_CLKEV_SOURCE, 2, OMAP2_MPU_SOURCE)
+OMAP_SYS_TIMER_INIT(2, 1, OMAP2_CLKEV_SOURCE, 2, OMAP3_CLKEV_SOURCE)
 OMAP_SYS_TIMER(2)
 #endif
 
 #ifdef CONFIG_ARCH_OMAP3
-OMAP_SYS_TIMER_INIT(3, 1, OMAP3_CLKEV_SOURCE, 2, OMAP3_MPU_SOURCE)
+OMAP_SYS_TIMER_INIT(3, 1, OMAP3_CLKEV_SOURCE, 2, OMAP3_CLKEV_SOURCE)
 OMAP_SYS_TIMER(3)
 OMAP_SYS_TIMER_INIT(3_secure, OMAP3_SECURE_TIMER, OMAP3_CLKEV_SOURCE,
 			2, OMAP3_MPU_SOURCE)
diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index 5a25de0..4d65c2f 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -37,7 +37,7 @@ static void __iomem *timer_32k_base;
 
 #define OMAP16XX_TIMER_32K_SYNCHRONIZED		0xfffbc410
 
-static u32 notrace omap_32k_read_sched_clock(void)
+u32 notrace omap_32k_read_sched_clock(void)
 {
 	return timer_32k_base ? __raw_readl(timer_32k_base) : 0;
 }
@@ -118,7 +118,7 @@ int __init omap_init_clocksource_32k(void)
 		printk(KERN_ERR "%s: can't register clocksource!\n",
 				"32k_counter");
 
-	setup_sched_clock(omap_32k_read_sched_clock, 32, 32768);
+//	setup_sched_clock(omap_32k_read_sched_clock, 32, 32768);
 
 	return 0;
 }
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index b4d7ec3..4afb19b 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -31,6 +31,7 @@
 #include <plat/omap_hwmod.h>
 
 extern int __init omap_init_clocksource_32k(void);
+extern u32 notrace omap_32k_read_sched_clock(void);
 
 extern void omap_reserve(void);
 extern int omap_dss_reset(struct omap_hwmod *);


Thanks,
Vaibhav

