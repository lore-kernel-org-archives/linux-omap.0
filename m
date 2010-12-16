From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH] ARM: ensure all sched_clock() implementations are notrace marked
Date: Thu, 16 Dec 2010 08:18:18 +0000
Message-ID: <E1PT92Y-0004Ba-64@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55178 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066Ab0LPIS7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Dec 2010 03:18:59 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Imre Kaloz <kaloz@openwrt.org>, Krzysztof Halasa <khc@pm.waw.pl>, Eric Miao <eric.y.miao@gmail.com>, Colin Cross <ccross@android.com>, Erik Gilling <konkers@android.com>, Olof Johansson <olof@lixom.net>, Tony Lindgren <tony@atomide.com>, Lennert Buytenhek <kernel@wantstofly.org>, Nicolas Pitre <nico@fluxnic.net>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org

ftrace requires sched_clock() to be notrace.  Ensure that all
implementations are so marked.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-ixp4xx/common.c         |    2 +-
 arch/arm/mach-mmp/time.c              |    2 +-
 arch/arm/mach-pxa/time.c              |    2 +-
 arch/arm/mach-sa1100/generic.c        |    2 +-
 arch/arm/mach-tegra/timer.c           |    2 +-
 arch/arm/plat-iop/time.c              |    2 +-
 arch/arm/plat-omap/counter_32k.c      |    2 +-
 arch/arm/plat-orion/time.c            |    2 +-
 arch/arm/plat-versatile/sched-clock.c |    2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 82fc003..e0b91d8 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -424,7 +424,7 @@ static void __init ixp4xx_clocksource_init(void)
 /*
  * sched_clock()
  */
-unsigned long long sched_clock(void)
+unsigned long long notrace sched_clock(void)
 {
 	cycle_t cyc = ixp4xx_get_cycles(NULL);
 	struct clocksource *cs = &clocksource_ixp4xx;
diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index 0c0ab09..a2ea33d 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -75,7 +75,7 @@ static inline uint32_t timer_read(void)
 	return __raw_readl(TIMERS_VIRT_BASE + TMR_CVWR(0));
 }
 
-unsigned long long sched_clock(void)
+unsigned long long notrace sched_clock(void)
 {
 	unsigned long long v = cnt32_to_63(timer_read());
 	return (v * tcr2ns_scale) >> TCR2NS_SCALE_FACTOR;
diff --git a/arch/arm/mach-pxa/time.c b/arch/arm/mach-pxa/time.c
index caf92c0..b8d9dff 100644
--- a/arch/arm/mach-pxa/time.c
+++ b/arch/arm/mach-pxa/time.c
@@ -51,7 +51,7 @@ static void __init set_oscr2ns_scale(unsigned long oscr_rate)
 		oscr2ns_scale++;
 }
 
-unsigned long long sched_clock(void)
+unsigned long long notrace sched_clock(void)
 {
 	unsigned long long v = cnt32_to_63(OSCR);
 	return (v * oscr2ns_scale) >> OSCR2NS_SCALE_FACTOR;
diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index 3c1fcd6..33b4969 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -119,7 +119,7 @@ unsigned int sa11x0_getspeed(unsigned int cpu)
  *
  *  ( * 1E9 / 3686400 => * 78125 / 288)
  */
-unsigned long long sched_clock(void)
+unsigned long long notrace sched_clock(void)
 {
 	unsigned long long v = cnt32_to_63(OSCR);
 
diff --git a/arch/arm/mach-tegra/timer.c b/arch/arm/mach-tegra/timer.c
index b49f2f5..19a6f7e 100644
--- a/arch/arm/mach-tegra/timer.c
+++ b/arch/arm/mach-tegra/timer.c
@@ -110,7 +110,7 @@ static struct clocksource tegra_clocksource = {
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-unsigned long long sched_clock(void)
+unsigned long long notrace sched_clock(void)
 {
 	return cnt32_to_63(timer_readl(TIMERUS_CNTR_1US)) * 1000;
 }
diff --git a/arch/arm/plat-iop/time.c b/arch/arm/plat-iop/time.c
index cd6d54f..2bb7db4 100644
--- a/arch/arm/plat-iop/time.c
+++ b/arch/arm/plat-iop/time.c
@@ -52,7 +52,7 @@ static struct clocksource iop_clocksource = {
 /*
  * IOP sched_clock() implementation via its clocksource.
  */
-unsigned long long sched_clock(void)
+unsigned long long notrace sched_clock(void)
 {
 	cycle_t cyc = iop_clocksource_read(NULL);
 	struct clocksource *cs = &iop_clocksource;
diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index 8f149f5..0de0583 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -109,7 +109,7 @@ static struct clocksource clocksource_32k = {
  * Returns current time from boot in nsecs. It's OK for this to wrap
  * around for now, as it's just a relative time stamp.
  */
-unsigned long long sched_clock(void)
+unsigned long long notrace sched_clock(void)
 {
 	return clocksource_cyc2ns(clocksource_32k.read(&clocksource_32k),
 				  clocksource_32k.mult, clocksource_32k.shift);
diff --git a/arch/arm/plat-orion/time.c b/arch/arm/plat-orion/time.c
index 11e2583..123f96f 100644
--- a/arch/arm/plat-orion/time.c
+++ b/arch/arm/plat-orion/time.c
@@ -55,7 +55,7 @@ static u32 ticks_per_jiffy;
 
 static unsigned long tclk2ns_scale;
 
-unsigned long long sched_clock(void)
+unsigned long long notrace sched_clock(void)
 {
 	unsigned long long v = cnt32_to_63(0xffffffff - readl(TIMER0_VAL));
 	return (v * tclk2ns_scale) >> TCLK2NS_SCALE_FACTOR;
diff --git a/arch/arm/plat-versatile/sched-clock.c b/arch/arm/plat-versatile/sched-clock.c
index 9696ddc..42efd14 100644
--- a/arch/arm/plat-versatile/sched-clock.c
+++ b/arch/arm/plat-versatile/sched-clock.c
@@ -42,7 +42,7 @@
  * long as there is always less than 89 seconds between successive
  * calls to this function.
  */
-unsigned long long sched_clock(void)
+unsigned long long notrace sched_clock(void)
 {
 	unsigned long long v = cnt32_to_63(readl(REFCOUNTER));
 
-- 
1.6.2.5

