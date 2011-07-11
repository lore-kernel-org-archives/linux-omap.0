From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [pm-wip/cpufreq] [PATCH] OMAP2+: CPUfreq: update lpj with reference
	value to avoid progressive error.
Date: Mon, 11 Jul 2011 23:10:04 +0530
Message-ID: <1310406004-5060-1-git-send-email-santosh.shilimkar@ti.com>
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
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@ti.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Russell King <rmk+kernel@arm.linux.org.uk>

Adjust _both_ the per-cpu loops_per_jiffy and global lpj. Calibrate them
with with reference to the initial values to avoid a progressively
bigger and bigger error in the value over time.

While at this, re-use the notifiers for UP/SMP since on
UP machine or UP_ON_SMP policy->cpus mask would contain only
the boot CPU.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
[santosh.shilimkar@ti.com: re-based against omap cpufreq
upstream branch and fixed notifiers]
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Kevin Hilman <khilman@ti.com>
---
Patch is outcome of below discussion.
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg51559.html

 arch/arm/mach-omap2/omap2plus-cpufreq.c |   50 ++++++++++++++++--------------
 1 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index 1f3b2e1..de82e87 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -38,6 +38,16 @@
 
 #include <mach/hardware.h>
 
+#ifdef CONFIG_SMP
+struct lpj_info {
+	unsigned long	ref;
+	unsigned int	freq;
+};
+
+static DEFINE_PER_CPU(struct lpj_info, lpj_ref);
+static struct lpj_info global_lpj_ref;
+#endif
+
 static struct cpufreq_frequency_table *freq_table;
 static atomic_t freq_table_users = ATOMIC_INIT(0);
 static struct clk *mpu_clk;
@@ -96,37 +106,18 @@ static int omap_target(struct cpufreq_policy *policy,
 	if (freqs.old == freqs.new && policy->cur == freqs.new)
 		return ret;
 
-	if (!is_smp()) {
-		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
-		goto set_freq;
-	}
-
 	/* notifiers */
 	for_each_cpu(i, policy->cpus) {
 		freqs.cpu = i;
 		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
 	}
 
-set_freq:
 #ifdef CONFIG_CPU_FREQ_DEBUG
 	pr_info("cpufreq-omap: transition: %u --> %u\n", freqs.old, freqs.new);
 #endif
 
 	ret = clk_set_rate(mpu_clk, freqs.new * 1000);
-
-	/*
-	 * Generic CPUFREQ driver jiffy update is under !SMP. So jiffies
-	 * won't get updated when UP machine cpufreq build with
-	 * CONFIG_SMP enabled. Below code is added only to manage that
-	 * scenario
-	 */
 	freqs.new = omap_getspeed(policy->cpu);
-	if (!is_smp()) {
-		loops_per_jiffy =
-			 cpufreq_scale(loops_per_jiffy, freqs.old, freqs.new);
-		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
-		goto skip_lpj;
-	}
 
 #ifdef CONFIG_SMP
 	/*
@@ -134,10 +125,24 @@ set_freq:
 	 * cpufreq driver. So, update the per-CPU loops_per_jiffy value
 	 * on frequency transition. We need to update all dependent CPUs.
 	 */
-	for_each_cpu(i, policy->cpus)
+	for_each_cpu(i, policy->cpus) {
+		struct lpj_info *lpj = &per_cpu(lpj_ref, i);
+		if (!lpj->freq) {
+			lpj->ref = per_cpu(cpu_data, i).loops_per_jiffy;
+			lpj->freq = freqs.old;
+		}
+
 		per_cpu(cpu_data, i).loops_per_jiffy =
-			cpufreq_scale(per_cpu(cpu_data, i).loops_per_jiffy,
-					freqs.old, freqs.new);
+			cpufreq_scale(lpj->ref, lpj->freq, freqs.new);
+	}
+
+	/* And don't forget to adjust the global one */
+	if (!global_lpj_ref.freq) {
+		global_lpj_ref.ref = loops_per_jiffy;
+		global_lpj_ref.freq = freqs.old;
+	}
+	loops_per_jiffy = cpufreq_scale(global_lpj_ref.ref, global_lpj_ref.freq,
+					freqs.new);
 #endif
 
 	/* notifiers */
@@ -146,7 +151,6 @@ set_freq:
 		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 	}
 
-skip_lpj:
 	return ret;
 }
 
-- 
1.6.0.4
