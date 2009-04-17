From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 02/02] OMAP3 clock: Update cpufreq driver
Date: Fri, 17 Apr 2009 11:27:53 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FB251DD3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55777 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755565AbZDQF6V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Apr 2009 01:58:21 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Jean Pihet <jpihet@mvista.com>

From: Rajendra Nayak <rnayak@ti.com>

This patch removes all refrences to virtual clock
nodes in CPUFreq driver.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Jean Pihet <jpihet@mvista.com>
---
 arch/arm/plat-omap/cpu-omap.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

Index: linux-omap-2.6/arch/arm/plat-omap/cpu-omap.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/cpu-omap.c	2009-04-15 12:04:34.000000000 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/cpu-omap.c	2009-04-15 12:30:29.000000000 +0530
@@ -40,7 +40,7 @@ static struct cpufreq_frequency_table *f
 #ifdef CONFIG_ARCH_OMAP1
 #define MPU_CLK		"mpu"
 #elif CONFIG_ARCH_OMAP3
-#define MPU_CLK		"virt_vdd1_prcm_set"
+#define MPU_CLK		"arm_fck"
 #else
 #define MPU_CLK		"virt_prcm_set"
 #endif
@@ -82,7 +82,9 @@ static int omap_target(struct cpufreq_po
 		       unsigned int target_freq,
 		       unsigned int relation)
 {
+#ifdef CONFIG_ARCH_OMAP1
 	struct cpufreq_freqs freqs;
+#endif
 	int ret = 0;
 
 	/* Ensure desired rate is within allowed range.  Some govenors
@@ -92,13 +94,13 @@ static int omap_target(struct cpufreq_po
 	if (target_freq > policy->cpuinfo.max_freq)
 		target_freq = policy->cpuinfo.max_freq;
 
+#ifdef CONFIG_ARCH_OMAP1
 	freqs.old = omap_getspeed(0);
 	freqs.new = clk_round_rate(mpu_clk, target_freq * 1000) / 1000;
 	freqs.cpu = 0;
 
 	if (freqs.old == freqs.new)
 		return ret;
-#ifdef CONFIG_ARCH_OMAP1
 	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
 #ifdef CONFIG_CPU_FREQ_DEBUG
 	printk(KERN_DEBUG "cpufreq-omap: transition: %u --> %u\n",
@@ -110,7 +112,7 @@ static int omap_target(struct cpufreq_po
 	if (mpu_opps) {
 		int ind;
 		for (ind = 1; ind <= MAX_VDD1_OPP; ind++) {
-			if (mpu_opps[ind].rate/1000 >= freqs.new) {
+			if (mpu_opps[ind].rate/1000 >= target_freq) {
 				omap_pm_cpu_set_freq
 					(mpu_opps[ind].rate);
 				break;

