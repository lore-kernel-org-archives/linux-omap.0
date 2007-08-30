From: Hiroshi.DOYU@nokia.com
Subject: [PATCH] ARM: OMAP: Fix sleep under spinlock for cpufreq
Date: Thu, 30 Aug 2007 12:46:39 +0300
Message-ID: <11884671992065-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
List-Id: linux-omap@vger.kernel.org

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

[   10.523437] BUG: sleeping function called from invalid context at kernel/mut6
[   10.523437] in_atomic():0, irqs_disabled():128
[   10.523437] [<c002c168>] (dump_stack+0x0/0x14) from [<c005374c>] (__might_sl)
[   10.523437] [<c0053698>] (__might_sleep+0x0/0xd4) from [<c024fdf4>] (mutex_l)
[   10.523437]  r5 = C02F0DE8  r4 = C02F0DF0
[   10.523437] [<c024fdd4>] (mutex_lock+0x0/0x44) from [<c0041df4>] (clk_get+0x)
[   10.523437]  r4 = 00000000
[   10.523437] [<c0041da4>] (clk_get+0x0/0x128) from [<c0046520>] (omap_getspee)
[   10.523437]  r8 = 00000002  r7 = 00000000  r6 = C031DAF8  r5 = C0473980
[   10.523437]  r4 = 00000000
[   10.523437] [<c00464fc>] (omap_getspeed+0x0/0x5c) from [<c01b8518>] (cpufreq)
[   10.523437]  r5 = C0473980  r4 = 00000002

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/cpu-omap.c |   32 ++++++++++----------------------
 1 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index a0c71dc..47bf282 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -33,43 +33,33 @@
 #define MPU_CLK		"virt_prcm_set"
 #endif
 
+static struct clk *mpu_clk;
+
 /* TODO: Add support for SDRAM timing changes */
 
 int omap_verify_speed(struct cpufreq_policy *policy)
 {
-	struct clk * mpu_clk;
-
 	if (policy->cpu)
 		return -EINVAL;
 
 	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
 				     policy->cpuinfo.max_freq);
-	mpu_clk = clk_get(NULL, MPU_CLK);
-	if (IS_ERR(mpu_clk))
-		return PTR_ERR(mpu_clk);
+
 	policy->min = clk_round_rate(mpu_clk, policy->min * 1000) / 1000;
 	policy->max = clk_round_rate(mpu_clk, policy->max * 1000) / 1000;
 	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
 				     policy->cpuinfo.max_freq);
-	clk_put(mpu_clk);
-
 	return 0;
 }
 
 unsigned int omap_getspeed(unsigned int cpu)
 {
-	struct clk * mpu_clk;
 	unsigned long rate;
 
 	if (cpu)
 		return 0;
 
-	mpu_clk = clk_get(NULL, MPU_CLK);
-	if (IS_ERR(mpu_clk))
-		return 0;
 	rate = clk_get_rate(mpu_clk) / 1000;
-	clk_put(mpu_clk);
-
 	return rate;
 }
 
@@ -77,14 +67,9 @@ static int omap_target(struct cpufreq_policy *policy,
 		       unsigned int target_freq,
 		       unsigned int relation)
 {
-	struct clk * mpu_clk;
 	struct cpufreq_freqs freqs;
 	int ret = 0;
 
-	mpu_clk = clk_get(NULL, MPU_CLK);
-	if (IS_ERR(mpu_clk))
-		return PTR_ERR(mpu_clk);
-
 	freqs.old = omap_getspeed(0);
 	freqs.new = clk_round_rate(mpu_clk, target_freq * 1000) / 1000;
 	freqs.cpu = 0;
@@ -92,15 +77,12 @@ static int omap_target(struct cpufreq_policy *policy,
 	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
 	ret = clk_set_rate(mpu_clk, target_freq * 1000);
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
-	clk_put(mpu_clk);
 
 	return ret;
 }
 
 static int __init omap_cpu_init(struct cpufreq_policy *policy)
 {
-	struct clk * mpu_clk;
-
 	mpu_clk = clk_get(NULL, MPU_CLK);
 	if (IS_ERR(mpu_clk))
 		return PTR_ERR(mpu_clk);
@@ -112,17 +94,23 @@ static int __init omap_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.min_freq = clk_round_rate(mpu_clk, 0) / 1000;
 	policy->cpuinfo.max_freq = clk_round_rate(mpu_clk, VERY_HI_RATE) / 1000;
 	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
-	clk_put(mpu_clk);
 
 	return 0;
 }
 
+static int omap_cpu_exit(struct cpufreq_policy *policy)
+{
+	clk_put(mpu_clk);
+	return 0;
+}
+
 static struct cpufreq_driver omap_driver = {
 	.flags		= CPUFREQ_STICKY,
 	.verify		= omap_verify_speed,
 	.target		= omap_target,
 	.get		= omap_getspeed,
 	.init		= omap_cpu_init,
+	.exit		= omap_cpu_exit,
 	.name		= "omap",
 };
 
-- 
1.5.3.rc6
