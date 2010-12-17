From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 26/40] ARM: ensure all sched_clock() implementations are notrace marked
Date: Fri, 17 Dec 2010 11:47:12 +0000
Message-ID: <E1PTYmG-0006jK-5r@rmk-PC.arm.linux.org.uk>
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42176 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547Ab0LQLsV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 06:48:21 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Imre Kaloz <kaloz@openwrt.org>, Krzysztof Halasa <khc@pm.waw.pl>, Eric Miao <eric.y.miao@gmail.com>, Colin Cross <ccross@android.com>, Erik Gilling <konkers@android.com>, Olof
Cc: linux-arm-kernel@lists.infradead.org

ftrace requires sched_clock() to be notrace.  Ensure that all
implementations are so marked.  Also make sure that they include
linux/sched.h

Also ensure OMAP clocksource read functions are marked notrace as
they're used for sched_clock() too.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-ixp4xx/common.c         |    2 +-
 arch/arm/mach-mmp/time.c              |    2 +-
 arch/arm/mach-pxa/time.c              |    2 +-
 arch/arm/mach-sa1100/generic.c        |    2 +-
 arch/arm/mach-tegra/timer.c           |    3 ++-
 arch/arm/mach-u300/timer.c            |    1 +
 arch/arm/plat-iop/time.c              |    3 ++-
 arch/arm/plat-nomadik/timer.c         |    1 +
 arch/arm/plat-omap/counter_32k.c      |   15 ++++++++-------
 arch/arm/plat-orion/time.c            |    2 +-
 arch/arm/plat-versatile/sched-clock.c |    2 +-
 11 files changed, 20 insertions(+), 15 deletions(-)

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
index b49f2f5..c52bd84 100644
--- a/arch/arm/mach-tegra/timer.c
+++ b/arch/arm/mach-tegra/timer.c
@@ -18,6 +18,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/sched.h>
 #include <linux/time.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -110,7 +111,7 @@ static struct clocksource tegra_clocksource = {
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-unsigned long long sched_clock(void)
+unsigned long long notrace sched_clock(void)
 {
 	return cnt32_to_63(timer_readl(TIMERUS_CNTR_1US)) * 1000;
 }
diff --git a/arch/arm/mach-u300/timer.c b/arch/arm/mach-u300/timer.c
index 377ff7f..6c68fe7 100644
--- a/arch/arm/mach-u300/timer.c
+++ b/arch/arm/mach-u300/timer.c
@@ -9,6 +9,7 @@
  * Author: Linus Walleij <linus.walleij@stericsson.com>
  */
 #include <linux/interrupt.h>
+#include <linux/sched.h>
 #include <linux/time.h>
 #include <linux/timex.h>
 #include <linux/clockchips.h>
diff --git a/arch/arm/plat-iop/time.c b/arch/arm/plat-iop/time.c
index cd6d54f..0c6da54 100644
--- a/arch/arm/plat-iop/time.c
+++ b/arch/arm/plat-iop/time.c
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/time.h>
 #include <linux/init.h>
+#include <linux/sched.h>
 #include <linux/timex.h>
 #include <linux/io.h>
 #include <linux/clocksource.h>
@@ -52,7 +53,7 @@ static struct clocksource iop_clocksource = {
 /*
  * IOP sched_clock() implementation via its clocksource.
  */
-unsigned long long sched_clock(void)
+unsigned long long notrace sched_clock(void)
 {
 	cycle_t cyc = iop_clocksource_read(NULL);
 	struct clocksource *cs = &iop_clocksource;
diff --git a/arch/arm/plat-nomadik/timer.c b/arch/arm/plat-nomadik/timer.c
index b0bd6df..c3b8a22 100644
--- a/arch/arm/plat-nomadik/timer.c
+++ b/arch/arm/plat-nomadik/timer.c
@@ -19,6 +19,7 @@
 #include <linux/err.h>
 #include <linux/cnt32_to_63.h>
 #include <linux/timer.h>
+#include <linux/sched.h>
 #include <asm/mach/time.h>
 
 #include <plat/mtu.h>
diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index 8f149f5..aed301b 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/sched.h>
 
 #include <plat/common.h>
 #include <plat/board.h>
@@ -44,7 +45,7 @@
 static u32 offset_32k __read_mostly;
 
 #ifdef CONFIG_ARCH_OMAP16XX
-static cycle_t omap16xx_32k_read(struct clocksource *cs)
+static cycle_t notrace omap16xx_32k_read(struct clocksource *cs)
 {
 	return omap_readl(OMAP16XX_TIMER_32K_SYNCHRONIZED) - offset_32k;
 }
@@ -53,7 +54,7 @@ static cycle_t omap16xx_32k_read(struct clocksource *cs)
 #endif
 
 #ifdef CONFIG_ARCH_OMAP2420
-static cycle_t omap2420_32k_read(struct clocksource *cs)
+static cycle_t notrace omap2420_32k_read(struct clocksource *cs)
 {
 	return omap_readl(OMAP2420_32KSYNCT_BASE + 0x10) - offset_32k;
 }
@@ -62,7 +63,7 @@ static cycle_t omap2420_32k_read(struct clocksource *cs)
 #endif
 
 #ifdef CONFIG_ARCH_OMAP2430
-static cycle_t omap2430_32k_read(struct clocksource *cs)
+static cycle_t notrace omap2430_32k_read(struct clocksource *cs)
 {
 	return omap_readl(OMAP2430_32KSYNCT_BASE + 0x10) - offset_32k;
 }
@@ -71,7 +72,7 @@ static cycle_t omap2430_32k_read(struct clocksource *cs)
 #endif
 
 #ifdef CONFIG_ARCH_OMAP3
-static cycle_t omap34xx_32k_read(struct clocksource *cs)
+static cycle_t notrace omap34xx_32k_read(struct clocksource *cs)
 {
 	return omap_readl(OMAP3430_32KSYNCT_BASE + 0x10) - offset_32k;
 }
@@ -80,7 +81,7 @@ static cycle_t omap34xx_32k_read(struct clocksource *cs)
 #endif
 
 #ifdef CONFIG_ARCH_OMAP4
-static cycle_t omap44xx_32k_read(struct clocksource *cs)
+static cycle_t notrace omap44xx_32k_read(struct clocksource *cs)
 {
 	return omap_readl(OMAP4430_32KSYNCT_BASE + 0x10) - offset_32k;
 }
@@ -92,7 +93,7 @@ static cycle_t omap44xx_32k_read(struct clocksource *cs)
  * Kernel assumes that sched_clock can be called early but may not have
  * things ready yet.
  */
-static cycle_t omap_32k_read_dummy(struct clocksource *cs)
+static cycle_t notrace omap_32k_read_dummy(struct clocksource *cs)
 {
 	return 0;
 }
@@ -109,7 +110,7 @@ static struct clocksource clocksource_32k = {
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

