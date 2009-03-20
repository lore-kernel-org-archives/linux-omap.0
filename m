From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 02/03] OMAP3 clock: Update cpufreq driver
Date: Fri, 20 Mar 2009 19:20:22 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FAF6EF39@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47886 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753754AbZCTNuc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 09:50:32 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2KDoNhh027125
	for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 08:50:30 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2KDoNms006805
	for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 19:20:23 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Nayak, Rajendra" <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

This patch removes all refrences to virtual clock
nodes in CPUFreq driver.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/plat-omap/cpu-omap.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-omap-pm/arch/arm/plat-omap/cpu-omap.c
===================================================================
--- linux-omap-pm.orig/arch/arm/plat-omap/cpu-omap.c	2009-03-20 16:55:21.967545328 +0530
+++ linux-omap-pm/arch/arm/plat-omap/cpu-omap.c	2009-03-20 16:55:37.038096798 +0530
@@ -40,7 +40,7 @@ static struct cpufreq_frequency_table *f
 #ifdef CONFIG_ARCH_OMAP1
 #define MPU_CLK		"mpu"
 #elif CONFIG_ARCH_OMAP3
-#define MPU_CLK		"virt_vdd1_prcm_set"
+#define MPU_CLK		"arm_fck"
 #else
 #define MPU_CLK		"virt_prcm_set"
 #endif
@@ -92,13 +92,13 @@ static int omap_target(struct cpufreq_po
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
@@ -110,7 +110,7 @@ static int omap_target(struct cpufreq_po
 	if (mpu_opps) {
 		int ind;
 		for (ind = 1; ind <= MAX_VDD1_OPP; ind++) {
-			if (mpu_opps[ind].rate/1000 >= freqs.new) {
+			if (mpu_opps[ind].rate/1000 >= target_freq) {
 				omap_pm_cpu_set_freq
 					(mpu_opps[ind].rate);
 				break;