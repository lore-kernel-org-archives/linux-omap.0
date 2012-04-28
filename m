From: Richard Zhao <richard.zhao@freescale.com>
Subject: [RESEND PATCH 1/2] ARM: add cpufreq transiton notifier to adjust loops_per_jiffy for smp
Date: Sat, 28 Apr 2012 11:28:42 +0800
Message-ID: <1335583723-18915-1-git-send-email-richard.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org
Cc: linux@arm.linux.org.uk, arnd@arndb.de, catalin.marinas@arm.com, will.deacon@arm.com, davej@redhat.com, linux-omap@vger.kernel.org, Richard Zhao <richard.zhao@freescale.com>
List-Id: linux-omap@vger.kernel.org

If CONFIG_SMP, cpufreq skips loops_per_jiffy update, because different
arch has different per-cpu loops_per_jiffy definition.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/smp.c |   54 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index addbbe8..33af711 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -25,6 +25,7 @@
 #include <linux/percpu.h>
 #include <linux/clockchips.h>
 #include <linux/completion.h>
+#include <linux/cpufreq.h>
 
 #include <linux/atomic.h>
 #include <asm/cacheflush.h>
@@ -604,3 +605,56 @@ int setup_profiling_timer(unsigned int multiplier)
 {
 	return -EINVAL;
 }
+
+#ifdef CONFIG_CPU_FREQ
+
+static DEFINE_PER_CPU(unsigned long, l_p_j_ref);
+static DEFINE_PER_CPU(unsigned long, l_p_j_ref_freq);
+static unsigned long global_l_p_j_ref;
+static unsigned long global_l_p_j_ref_freq;
+
+static int cpufreq_callback(struct notifier_block *nb,
+					unsigned long val, void *data)
+{
+	struct cpufreq_freqs *freq = data;
+	int cpu = freq->cpu;
+
+	if (freq->flags & CPUFREQ_CONST_LOOPS)
+		return NOTIFY_OK;
+
+	if (!per_cpu(l_p_j_ref, cpu)) {
+		per_cpu(l_p_j_ref, cpu) =
+			per_cpu(cpu_data, cpu).loops_per_jiffy;
+		per_cpu(l_p_j_ref_freq, cpu) = freq->old;
+		if (!global_l_p_j_ref) {
+			global_l_p_j_ref = loops_per_jiffy;
+			global_l_p_j_ref_freq = freq->old;
+		}
+	}
+
+	if ((val == CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
+	    (val == CPUFREQ_POSTCHANGE && freq->old > freq->new) ||
+	    (val == CPUFREQ_RESUMECHANGE || val == CPUFREQ_SUSPENDCHANGE)) {
+		loops_per_jiffy = cpufreq_scale(global_l_p_j_ref,
+						global_l_p_j_ref_freq,
+						freq->new);
+		per_cpu(cpu_data, cpu).loops_per_jiffy =
+			cpufreq_scale(per_cpu(l_p_j_ref, cpu),
+					per_cpu(l_p_j_ref_freq, cpu),
+					freq->new);
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block cpufreq_notifier = {
+	.notifier_call  = cpufreq_callback,
+};
+
+static int __init register_cpufreq_notifier(void)
+{
+	return cpufreq_register_notifier(&cpufreq_notifier,
+						CPUFREQ_TRANSITION_NOTIFIER);
+}
+core_initcall(register_cpufreq_notifier);
+
+#endif
-- 
1.7.5.4


