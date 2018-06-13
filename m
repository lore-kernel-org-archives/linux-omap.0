From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 7/8] x86: tsc: Register the persistent clock
Date: Wed, 13 Jun 2018 19:32:34 +0800
Message-ID: <3010faf8a1dda56be4eac0d5aa393fbfb96f3077.1528878545.git.baolin.wang@linaro.org>
References: <cover.1528878545.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1528878545.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1528878545.git.baolin.wang@linaro.org>
References: <cover.1528878545.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, john.stultz@linaro.org, daniel.lezcano@linaro.org, arnd@arndb.de, tony@atomide.com, aaro.koskinen@iki.fi, linux@armlinux.org.uk, mark.rutland@arm.com, marc.zyngier@arm.com
Cc: baolin.wang@linaro.org, broonie@kernel.org, paulmck@linux.vnet.ibm.com, mlichvar@redhat.com, rdunlap@infradead.org, kstewart@linuxfoundation.org, gregkh@linuxfoundation.org, pombredanne@nexb.com, thierry.reding@gmail.com, jonathanh@nvidia.com, heiko@sntech.de, linus.walleij@linaro.org, viresh.kumar@linaro.org, mingo@kernel.org, hpa@zytor.com, peterz@infradead.org, douly.fnst@cn.fujitsu.com, len.brown@intel.com, rajvi.jingar@intel.com, alexandre.belloni@bootlin.com, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Register the tsc as one persistent clock to compensate the suspend time
if the tsc clocksource is always available.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/x86/Kconfig      |    1 +
 arch/x86/kernel/tsc.c |   21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 297789a..549dd01 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -200,6 +200,7 @@ config X86
 	select USER_STACKTRACE_SUPPORT
 	select VIRT_TO_BUS
 	select X86_FEATURE_NAMES		if PROC_FS
+	select PERSISTENT_CLOCK
 
 config INSTRUCTION_DECODER
 	def_bool y
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 74392d9..cb4f495 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -11,6 +11,7 @@
 #include <linux/delay.h>
 #include <linux/clocksource.h>
 #include <linux/percpu.h>
+#include <linux/persistent_clock.h>
 #include <linux/timex.h>
 #include <linux/static_key.h>
 
@@ -1032,6 +1033,11 @@ static u64 read_tsc(struct clocksource *cs)
 	return (u64)rdtsc_ordered();
 }
 
+static u64 notrace tsc_read_persistent_clock(void)
+{
+	return (u64)rdtsc_ordered();
+}
+
 static void tsc_cs_mark_unstable(struct clocksource *cs)
 {
 	if (tsc_unstable)
@@ -1300,6 +1306,14 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 	if (boot_cpu_has(X86_FEATURE_ART))
 		art_related_clocksource = &clocksource_tsc;
 	clocksource_register_khz(&clocksource_tsc, tsc_khz);
+
+	if (clocksource_tsc.flags & CLOCK_SOURCE_SUSPEND_NONSTOP) {
+		persistent_clock_init_and_register(tsc_read_persistent_clock,
+						   CLOCKSOURCE_MASK(64),
+						   tsc_khz * 1000, 0);
+		persistent_clock_start_alarmtimer();
+	}
+
 unreg:
 	clocksource_unregister(&clocksource_tsc_early);
 }
@@ -1327,6 +1341,13 @@ static int __init init_tsc_clocksource(void)
 		if (boot_cpu_has(X86_FEATURE_ART))
 			art_related_clocksource = &clocksource_tsc;
 		clocksource_register_khz(&clocksource_tsc, tsc_khz);
+
+		if (clocksource_tsc.flags & CLOCK_SOURCE_SUSPEND_NONSTOP) {
+			persistent_clock_init_and_register(tsc_read_persistent_clock,
+							   CLOCKSOURCE_MASK(64),
+							   tsc_khz * 1000, 0);
+			persistent_clock_start_alarmtimer();
+		}
 unreg:
 		clocksource_unregister(&clocksource_tsc_early);
 		return 0;
-- 
1.7.9.5
