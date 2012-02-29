From: Richard Zhao <richard.zhao@linaro.org>
Subject: [PATCH 1/2] ARM: add cpufreq transiton notifier to adjust loops_per_jiffy for smp
Date: Wed, 29 Feb 2012 15:18:14 +0800
Message-ID: <1330499895-12364-2-git-send-email-richard.zhao@linaro.org>
References: <1330499895-12364-1-git-send-email-richard.zhao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from db3ehsobe006.messaging.microsoft.com ([213.199.154.144]:45469
	"EHLO DB3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1030774Ab2B2HSd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Feb 2012 02:18:33 -0500
In-Reply-To: <1330499895-12364-1-git-send-email-richard.zhao@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org
Cc: linux@arm.linux.org.uk, davej@redhat.com, will.deacon@arm.com, catalin.marinas@arm.com, davidb@codeaurora.org, arnd@arndb.de, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, patches@linaro.org, Richard Zhao <richard.zhao@linaro.org>

If CONFIG_SMP, cpufreq skips loops_per_jiffy update, because different
arch has different per-cpu loops_per_jiffy definition.

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/smp.c |   54 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index cdeb727..4381bef 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -25,6 +25,7 @@
 #include <linux/percpu.h>
 #include <linux/clockchips.h>
 #include <linux/completion.h>
+#include <linux/cpufreq.h>
 
 #include <linux/atomic.h>
 #include <asm/cacheflush.h>
@@ -599,3 +600,56 @@ int setup_profiling_timer(unsigned int multiplier)
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


