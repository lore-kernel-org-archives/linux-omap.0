From: Jan Weitzel <j.weitzel@phytec.de>
Subject: [PATCH] ARM: type casts update_sched_clock cyc_to_sched_clock
	cyc_to_fixed_sched_clock
Date: Tue, 5 Apr 2011 09:43:21 +0200
Message-ID: <1301989401-11984-1-git-send-email-j.weitzel@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: kaloz@openwrt.org, khc@pm.waw.pl, linux@arm.linux.org.uk, tony@atomide.com, eric.y.miao@gmail.com, kernel@pengutronix.de, rubini@unipv.it, STEricsson_nomadik_linux@list.st.com, ben-lin
Cc: linux-tegra@vger.kernel.org, Jan Weitzel <j.weitzel@phytec.de>, linux-omap@vger.kernel.org, trivial@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

parameter "u32 mask" type cast befor inversion

Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
---
 arch/arm/mach-ixp4xx/common.c         |    4 ++--
 arch/arm/mach-mmp/time.c              |    4 ++--
 arch/arm/mach-omap1/time.c            |    4 ++--
 arch/arm/mach-pxa/time.c              |    4 ++--
 arch/arm/mach-sa1100/time.c           |    4 ++--
 arch/arm/mach-tegra/timer.c           |    4 ++--
 arch/arm/mach-u300/timer.c            |    4 ++--
 arch/arm/plat-iop/time.c              |    4 ++--
 arch/arm/plat-mxc/time.c              |    4 ++--
 arch/arm/plat-nomadik/timer.c         |    4 ++--
 arch/arm/plat-omap/counter_32k.c      |    4 ++--
 arch/arm/plat-orion/time.c            |    4 ++--
 arch/arm/plat-s5p/s5p-time.c          |    4 ++--
 arch/arm/plat-versatile/sched-clock.c |    4 ++--
 14 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index ed19bc3..20338bc 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -407,13 +407,13 @@ static DEFINE_CLOCK_DATA(cd);
 unsigned long long notrace sched_clock(void)
 {
 	u32 cyc = *IXP4XX_OSTS;
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
+	return cyc_to_sched_clock(&cd, cyc, ~(u32)0);
 }
 
 static void notrace ixp4xx_update_sched_clock(void)
 {
 	u32 cyc = *IXP4XX_OSTS;
-	update_sched_clock(&cd, cyc, (u32)~0);
+	update_sched_clock(&cd, cyc, ~(u32)0);
 }
 
 /*
diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index aeb9ae2..78d178f 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -62,13 +62,13 @@ static inline uint32_t timer_read(void)
 unsigned long long notrace sched_clock(void)
 {
 	u32 cyc = timer_read();
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
+	return cyc_to_sched_clock(&cd, cyc, ~(u32)0);
 }
 
 static void notrace mmp_update_sched_clock(void)
 {
 	u32 cyc = timer_read();
-	update_sched_clock(&cd, cyc, (u32)~0);
+	update_sched_clock(&cd, cyc, ~(u32)0);
 }
 
 static irqreturn_t timer_interrupt(int irq, void *dev_id)
diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
index 6885d2f..830e4d8 100644
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -221,7 +221,7 @@ static DEFINE_CLOCK_DATA(cd);
 static inline unsigned long long notrace _omap_mpu_sched_clock(void)
 {
 	u32 cyc = mpu_read(&clocksource_mpu);
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
+	return cyc_to_sched_clock(&cd, cyc, ~(u32)0);
 }
 
 #ifndef CONFIG_OMAP_32K_TIMER
@@ -239,7 +239,7 @@ static unsigned long long notrace omap_mpu_sched_clock(void)
 static void notrace mpu_update_sched_clock(void)
 {
 	u32 cyc = mpu_read(&clocksource_mpu);
-	update_sched_clock(&cd, cyc, (u32)~0);
+	update_sched_clock(&cd, cyc, ~(u32)0);
 }
 
 static void __init omap_init_clocksource(unsigned long rate)
diff --git a/arch/arm/mach-pxa/time.c b/arch/arm/mach-pxa/time.c
index 428da3f..57e1432 100644
--- a/arch/arm/mach-pxa/time.c
+++ b/arch/arm/mach-pxa/time.c
@@ -37,13 +37,13 @@ static DEFINE_CLOCK_DATA(cd);
 unsigned long long notrace sched_clock(void)
 {
 	u32 cyc = OSCR;
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
+	return cyc_to_sched_clock(&cd, cyc, ~(u32)0);
 }
 
 static void notrace pxa_update_sched_clock(void)
 {
 	u32 cyc = OSCR;
-	update_sched_clock(&cd, cyc, (u32)~0);
+	update_sched_clock(&cd, cyc, ~(u32)0);
 }
 
 
diff --git a/arch/arm/mach-sa1100/time.c b/arch/arm/mach-sa1100/time.c
index ae4f3d8..0251d67 100644
--- a/arch/arm/mach-sa1100/time.c
+++ b/arch/arm/mach-sa1100/time.c
@@ -36,13 +36,13 @@ static DEFINE_CLOCK_DATA(cd);
 unsigned long long notrace sched_clock(void)
 {
 	u32 cyc = OSCR;
-	return cyc_to_fixed_sched_clock(&cd, cyc, (u32)~0, SC_MULT, SC_SHIFT);
+	return cyc_to_fixed_sched_clock(&cd, cyc, ~(u32)0, SC_MULT, SC_SHIFT);
 }
 
 static void notrace sa1100_update_sched_clock(void)
 {
 	u32 cyc = OSCR;
-	update_sched_clock(&cd, cyc, (u32)~0);
+	update_sched_clock(&cd, cyc, ~(u32)0);
 }
 
 #define MIN_OSCR_DELTA 2
diff --git a/arch/arm/mach-tegra/timer.c b/arch/arm/mach-tegra/timer.c
index 0fcb1eb..6394dfc 100644
--- a/arch/arm/mach-tegra/timer.c
+++ b/arch/arm/mach-tegra/timer.c
@@ -131,13 +131,13 @@ static DEFINE_CLOCK_DATA(cd);
 unsigned long long notrace sched_clock(void)
 {
 	u32 cyc = timer_readl(TIMERUS_CNTR_1US);
-	return cyc_to_fixed_sched_clock(&cd, cyc, (u32)~0, SC_MULT, SC_SHIFT);
+	return cyc_to_fixed_sched_clock(&cd, cyc, ~(u32)0, SC_MULT, SC_SHIFT);
 }
 
 static void notrace tegra_update_sched_clock(void)
 {
 	u32 cyc = timer_readl(TIMERUS_CNTR_1US);
-	update_sched_clock(&cd, cyc, (u32)~0);
+	update_sched_clock(&cd, cyc, ~(u32)0);
 }
 
 /*
diff --git a/arch/arm/mach-u300/timer.c b/arch/arm/mach-u300/timer.c
index 3ec58bd..825b138 100644
--- a/arch/arm/mach-u300/timer.c
+++ b/arch/arm/mach-u300/timer.c
@@ -359,13 +359,13 @@ static DEFINE_CLOCK_DATA(cd);
 unsigned long long notrace sched_clock(void)
 {
 	u32 cyc = readl(U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT2CC);
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
+	return cyc_to_sched_clock(&cd, cyc, ~(u32)0);
 }
 
 static void notrace u300_update_sched_clock(void)
 {
 	u32 cyc = readl(U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT2CC);
-	update_sched_clock(&cd, cyc, (u32)~0);
+	update_sched_clock(&cd, cyc, ~(u32)0);
 }
 
 
diff --git a/arch/arm/plat-iop/time.c b/arch/arm/plat-iop/time.c
index 07f23bb..e851900 100644
--- a/arch/arm/plat-iop/time.c
+++ b/arch/arm/plat-iop/time.c
@@ -60,13 +60,13 @@ static DEFINE_CLOCK_DATA(cd);
 unsigned long long notrace sched_clock(void)
 {
 	u32 cyc = 0xffffffffu - read_tcr1();
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
+	return cyc_to_sched_clock(&cd, cyc, ~(u32)0);
 }
 
 static void notrace iop_update_sched_clock(void)
 {
 	u32 cyc = 0xffffffffu - read_tcr1();
-	update_sched_clock(&cd, cyc, (u32)~0);
+	update_sched_clock(&cd, cyc, ~(u32)0);
 }
 
 /*
diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
index 2237ff8..20017f3 100644
--- a/arch/arm/plat-mxc/time.c
+++ b/arch/arm/plat-mxc/time.c
@@ -134,13 +134,13 @@ unsigned long long notrace sched_clock(void)
 {
 	cycle_t cyc = clocksource_mxc.read(&clocksource_mxc);
 
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
+	return cyc_to_sched_clock(&cd, cyc, ~(u32)0);
 }
 
 static void notrace mxc_update_sched_clock(void)
 {
 	cycle_t cyc = clocksource_mxc.read(&clocksource_mxc);
-	update_sched_clock(&cd, cyc, (u32)~0);
+	update_sched_clock(&cd, cyc, ~(u32)0);
 }
 
 static int __init mxc_clocksource_init(struct clk *timer_clk)
diff --git a/arch/arm/plat-nomadik/timer.c b/arch/arm/plat-nomadik/timer.c
index 4172340..d307440 100644
--- a/arch/arm/plat-nomadik/timer.c
+++ b/arch/arm/plat-nomadik/timer.c
@@ -63,13 +63,13 @@ unsigned long long notrace sched_clock(void)
 		return 0;
 
 	cyc = -readl(mtu_base + MTU_VAL(0));
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
+	return cyc_to_sched_clock(&cd, cyc, ~(u32)0);
 }
 
 static void notrace nomadik_update_sched_clock(void)
 {
 	u32 cyc = -readl(mtu_base + MTU_VAL(0));
-	update_sched_clock(&cd, cyc, (u32)~0);
+	update_sched_clock(&cd, cyc, ~(u32)0);
 }
 
 /* Clockevent device: use one-shot mode */
diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index f7fed60..bb7b7a2 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -123,7 +123,7 @@ static DEFINE_CLOCK_DATA(cd);
 static inline unsigned long long notrace _omap_32k_sched_clock(void)
 {
 	u32 cyc = clocksource_32k.read(&clocksource_32k);
-	return cyc_to_fixed_sched_clock(&cd, cyc, (u32)~0, SC_MULT, SC_SHIFT);
+	return cyc_to_fixed_sched_clock(&cd, cyc, ~(u32)0, SC_MULT, SC_SHIFT);
 }
 
 #ifndef CONFIG_OMAP_MPU_TIMER
@@ -141,7 +141,7 @@ unsigned long long notrace omap_32k_sched_clock(void)
 static void notrace omap_update_sched_clock(void)
 {
 	u32 cyc = clocksource_32k.read(&clocksource_32k);
-	update_sched_clock(&cd, cyc, (u32)~0);
+	update_sched_clock(&cd, cyc, ~(u32)0);
 }
 
 /**
diff --git a/arch/arm/plat-orion/time.c b/arch/arm/plat-orion/time.c
index 742b032..60f6291 100644
--- a/arch/arm/plat-orion/time.c
+++ b/arch/arm/plat-orion/time.c
@@ -65,14 +65,14 @@ static DEFINE_CLOCK_DATA(cd);
 unsigned long long notrace sched_clock(void)
 {
 	u32 cyc = ~readl(timer_base + TIMER0_VAL_OFF);
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
+	return cyc_to_sched_clock(&cd, cyc, ~(u32)0);
 }
 
 
 static void notrace orion_update_sched_clock(void)
 {
 	u32 cyc = ~readl(timer_base + TIMER0_VAL_OFF);
-	update_sched_clock(&cd, cyc, (u32)~0);
+	update_sched_clock(&cd, cyc, ~(u32)0);
 }
 
 static void __init setup_sched_clock(unsigned long tclk)
diff --git a/arch/arm/plat-s5p/s5p-time.c b/arch/arm/plat-s5p/s5p-time.c
index 8090403..1a1f7ab 100644
--- a/arch/arm/plat-s5p/s5p-time.c
+++ b/arch/arm/plat-s5p/s5p-time.c
@@ -346,7 +346,7 @@ unsigned long long notrace sched_clock(void)
 	}
 
 	cyc = ~__raw_readl(S3C_TIMERREG(offset));
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
+	return cyc_to_sched_clock(&cd, cyc, ~(u32)0);
 }
 
 static void notrace s5p_update_sched_clock(void)
@@ -371,7 +371,7 @@ static void notrace s5p_update_sched_clock(void)
 	}
 
 	cyc = ~__raw_readl(S3C_TIMERREG(offset));
-	update_sched_clock(&cd, cyc, (u32)~0);
+	update_sched_clock(&cd, cyc, ~(u32)0);
 }
 
 struct clocksource time_clocksource = {
diff --git a/arch/arm/plat-versatile/sched-clock.c b/arch/arm/plat-versatile/sched-clock.c
index 3d6a4c2..7fa3418 100644
--- a/arch/arm/plat-versatile/sched-clock.c
+++ b/arch/arm/plat-versatile/sched-clock.c
@@ -38,7 +38,7 @@ unsigned long long notrace sched_clock(void)
 {
 	if (ctr) {
 		u32 cyc = readl(ctr);
-		return cyc_to_fixed_sched_clock(&cd, cyc, (u32)~0,
+		return cyc_to_fixed_sched_clock(&cd, cyc, ~(u32)0,
 						SC_MULT, SC_SHIFT);
 	} else
 		return 0;
@@ -47,7 +47,7 @@ unsigned long long notrace sched_clock(void)
 static void notrace versatile_update_sched_clock(void)
 {
 	u32 cyc = readl(ctr);
-	update_sched_clock(&cd, cyc, (u32)~0);
+	update_sched_clock(&cd, cyc, ~(u32)0);
 }
 
 void __init versatile_sched_clock_init(void __iomem *reg, unsigned long rate)
-- 
1.7.0.4
