From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 1/2] ARM: OMAP: Add initialisation for the real-time counter.
Date: Mon, 13 Aug 2012 16:37:24 +0530
Message-ID: <1344856045-15134-2-git-send-email-santosh.shilimkar@ti.com>
References: <1344856045-15134-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56197 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751687Ab2HMLHe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Aug 2012 07:07:34 -0400
In-Reply-To: <1344856045-15134-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.orig, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

The real time counter also called master counter, is a free-running
counter. It produces the count used by the CPU local timer peripherals
in the MPU cluster. The timer counts at a rate of 6.144 MHz.

The ratio registers needs to be configured based on system clock
only onetime. After initialisation, hardware takes care of adjusting
the clock in different low power modes to keep counter rate constant.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    4 ++
 arch/arm/mach-omap2/timer.c |   89 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index dd2db02..2120f90 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -24,6 +24,9 @@ config ARCH_OMAP2PLUS_TYPICAL
 config SOC_HAS_OMAP2_SDRC
 	bool "OMAP2 SDRAM Controller support"
 
+config SOC_HAS_REALTIME_COUNTER
+	bool "Real time free running counter"
+
 config ARCH_OMAP2
 	bool "TI OMAP2"
 	depends on ARCH_OMAP2PLUS
@@ -69,6 +72,7 @@ config SOC_OMAP5
 	select CPU_V7
 	select ARM_GIC
 	select HAVE_SMP
+	select SOC_HAS_REALTIME_COUNTER
 
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 2ff6d41..9b17e6c 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -69,6 +69,11 @@
 #define OMAP3_SECURE_TIMER	1
 #endif
 
+#define REALTIME_COUNTER_BASE				0x48243200
+#define INCREMENTER_NUMERATOR_OFFSET			0x10
+#define INCREMENTER_DENUMERATOR_RELOAD_OFFSET		0x14
+#define NUMERATOR_DENUMERATOR_MASK			0xfffff000
+
 /* Clockevent code */
 
 static struct omap_dm_timer clkev;
@@ -339,6 +344,83 @@ static void __init omap2_clocksource_init(int gptimer_id,
 		omap2_gptimer_clocksource_init(gptimer_id, fck_source);
 }
 
+#ifdef CONFIG_SOC_HAS_REALTIME_COUNTER
+/*
+ * The realtime counter also called master counter, is a free-running
+ * counter, which is related to real time. It produces the count used
+ * by the CPU local timer peripherals in the MPU cluster. The timer counts
+ * at a rate of 6.144 MHz. Because the device operates on different clocks
+ * in different power modes, the master counter shifts operation between
+ * clocks, adjusting the increment per clock in hardware accordingly to
+ * maintain a constant count rate.
+ */
+static void __init realtime_counter_init(void)
+{
+	void __iomem *base;
+	static struct clk *sys_clk;
+	unsigned long rate;
+	unsigned int reg, num, den;
+
+	base = ioremap(REALTIME_COUNTER_BASE, SZ_32);
+	if (!base) {
+		pr_err("%s: ioremap failed\n", __func__);
+		return;
+	}
+	sys_clk = clk_get(NULL, "sys_clkin_ck");
+	if (!sys_clk) {
+		pr_err("%s: failed to get system clock handle\n", __func__);
+		return;
+	}
+
+	rate = clk_get_rate(sys_clk);
+	switch (rate) {
+	case 1200000:
+		num = 64;
+		den = 125;
+		break;
+	case 1300000:
+		num = 768;
+		den = 1625;
+		break;
+	case 19200000:
+		num = 8;
+		den = 25;
+		break;
+	case 2600000:
+		num = 384;
+		den = 1625;
+		break;
+	case 2700000:
+		num = 256;
+		den = 1125;
+		break;
+	case 38400000:
+		num = 4;
+		den = 25;
+		break;
+	default:
+		/* Program it for 38.4 MHz */
+		num = 4;
+		den = 25;
+		break;
+	}
+
+	/* Program numerator and denumerator registers */
+	reg = __raw_readl(base + INCREMENTER_NUMERATOR_OFFSET) &
+			NUMERATOR_DENUMERATOR_MASK;
+	reg |= num;
+	__raw_writel(reg, base + INCREMENTER_NUMERATOR_OFFSET);
+
+	reg = __raw_readl(base + INCREMENTER_NUMERATOR_OFFSET) &
+			NUMERATOR_DENUMERATOR_MASK;
+	reg |= den;
+	__raw_writel(reg, base + INCREMENTER_DENUMERATOR_RELOAD_OFFSET);
+}
+#else
+static inline void __init realtime_counter_init(void)
+{}
+#endif
+
 #define OMAP_SYS_TIMER_INIT(name, clkev_nr, clkev_src,			\
 				clksrc_nr, clksrc_src)			\
 static void __init omap##name##_timer_init(void)			\
@@ -396,7 +478,12 @@ OMAP_SYS_TIMER(4)
 #endif
 
 #ifdef CONFIG_SOC_OMAP5
-OMAP_SYS_TIMER_INIT(5, 1, OMAP4_CLKEV_SOURCE, 2, OMAP4_MPU_SOURCE)
+static void __init omap5_timer_init(void)
+{
+	omap2_gp_clockevent_init(1, OMAP4_CLKEV_SOURCE);
+	omap2_clocksource_init(2, OMAP4_MPU_SOURCE);
+	realtime_counter_init();
+}
 OMAP_SYS_TIMER(5)
 #endif
 
-- 
1.7.9.5

