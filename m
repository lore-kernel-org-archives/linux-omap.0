From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 12/15] ARM: OMAP4+: CPUidle: Cleanup idle driver for OMAP5 support
Date: Fri, 1 Mar 2013 17:41:01 +0530
Message-ID: <1362139864-9233-13-git-send-email-santosh.shilimkar@ti.com>
References: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44898 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752385Ab3CAMKX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Mar 2013 07:10:23 -0500
In-Reply-To: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

The OMAP5 idle driver can re-use most of OMAP4 CPUidle driver
implementation. Also the next derivative SOCs are going to re-use
the MPUSS so, same driver with minor updates can be re-used.

Prepare the code so that its easier to add CPUidle support for
OMAP5 devices.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/cpuidle44xx.c |   30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index 9de47a7..df81243 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -1,7 +1,7 @@
 /*
- * OMAP4 CPU idle Routines
+ * OMAP4PLUS CPU idle Routines
  *
- * Copyright (C) 2011 Texas Instruments, Inc.
+ * Copyright (C) 2011-2013 Texas Instruments, Inc.
  * Santosh Shilimkar <santosh.shilimkar@ti.com>
  * Rajendra Nayak <rnayak@ti.com>
  *
@@ -22,15 +22,16 @@
 #include "pm.h"
 #include "prm.h"
 #include "clockdomain.h"
+#include "soc.h"
 
 /* Machine specific information */
-struct omap4_idle_statedata {
+struct idle_statedata {
 	u32 cpu_state;
 	u32 mpu_logic_state;
 	u32 mpu_state;
 };
 
-static struct omap4_idle_statedata omap4_idle_data[] = {
+static struct idle_statedata omap4_idle_data[] = {
 	{
 		.cpu_state = PWRDM_POWER_ON,
 		.mpu_state = PWRDM_POWER_ON,
@@ -53,11 +54,12 @@ static struct clockdomain *cpu_clkdm[NR_CPUS];
 
 static atomic_t abort_barrier;
 static bool cpu_done[NR_CPUS];
+static struct idle_statedata *state_ptr;
 
 /* Private functions */
 
 /**
- * omap4_enter_idle_coupled_[simple/coupled] - OMAP4 cpuidle entry functions
+ * omap_enter_idle_[simple/coupled] - OMAP4PLUS cpuidle entry functions
  * @dev: cpuidle device
  * @drv: cpuidle driver
  * @index: the index of state to be entered
@@ -66,7 +68,7 @@ static bool cpu_done[NR_CPUS];
  * specified low power state selected by the governor.
  * Returns the amount of time spent in the low power state.
  */
-static int omap4_enter_idle_simple(struct cpuidle_device *dev,
+static int omap_enter_idle_simple(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
 			int index)
 {
@@ -74,11 +76,11 @@ static int omap4_enter_idle_simple(struct cpuidle_device *dev,
 	return index;
 }
 
-static int omap4_enter_idle_coupled(struct cpuidle_device *dev,
+static int omap_enter_idle_coupled(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
 			int index)
 {
-	struct omap4_idle_statedata *cx = &omap4_idle_data[index];
+	struct idle_statedata *cx = state_ptr + index;
 	int cpu_id = smp_processor_id();
 
 	/*
@@ -167,7 +169,7 @@ static void omap_setup_broadcast_timer(void *arg)
 	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ON, &cpu);
 }
 
-static DEFINE_PER_CPU(struct cpuidle_device, omap4_idle_dev);
+static DEFINE_PER_CPU(struct cpuidle_device, omap_idle_dev);
 
 static struct cpuidle_driver omap4_idle_driver = {
 	.name				= "omap4_idle",
@@ -179,7 +181,7 @@ static struct cpuidle_driver omap4_idle_driver = {
 			.exit_latency = 2 + 2,
 			.target_residency = 5,
 			.flags = CPUIDLE_FLAG_TIME_VALID,
-			.enter = omap4_enter_idle_simple,
+			.enter = omap_enter_idle_simple,
 			.name = "C1",
 			.desc = "MPUSS ON"
 		},
@@ -188,7 +190,7 @@ static struct cpuidle_driver omap4_idle_driver = {
 			.exit_latency = 328 + 440,
 			.target_residency = 960,
 			.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED,
-			.enter = omap4_enter_idle_coupled,
+			.enter = omap_enter_idle_coupled,
 			.name = "C2",
 			.desc = "MPUSS CSWR",
 		},
@@ -197,7 +199,7 @@ static struct cpuidle_driver omap4_idle_driver = {
 			.exit_latency = 460 + 518,
 			.target_residency = 1100,
 			.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED,
-			.enter = omap4_enter_idle_coupled,
+			.enter = omap_enter_idle_coupled,
 			.name = "C3",
 			.desc = "MPUSS OSWR",
 		},
@@ -219,6 +221,7 @@ int __init omap4_idle_init(void)
 	struct cpuidle_device *dev;
 	unsigned int cpu_id = 0;
 
+	/* Configure the broadcast timer on each cpu */
 	mpu_pd = pwrdm_lookup("mpu_pwrdm");
 	cpu_pd[0] = pwrdm_lookup("cpu0_pwrdm");
 	cpu_pd[1] = pwrdm_lookup("cpu1_pwrdm");
@@ -234,11 +237,12 @@ int __init omap4_idle_init(void)
 	on_each_cpu(omap_setup_broadcast_timer, NULL, 1);
 
 	for_each_cpu(cpu_id, cpu_online_mask) {
-		dev = &per_cpu(omap4_idle_dev, cpu_id);
+		dev = &per_cpu(omap_idle_dev, cpu_id);
 		dev->cpu = cpu_id;
 #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
 		dev->coupled_cpus = *cpu_online_mask;
 #endif
+		state_ptr = &omap4_idle_data[0];
 		cpuidle_register_driver(&omap4_idle_driver);
 
 		if (cpuidle_register_device(dev)) {
-- 
1.7.9.5

