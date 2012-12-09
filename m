From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 01/10] ARM: OMAP3/4: cpuidle: fix sparse and checkpatch
 warnings
Date: Sat, 08 Dec 2012 18:23:37 -0700
Message-ID: <20121209012334.19716.44831.stgit@dusk.lan>
References: <20121209011755.19716.25244.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38988 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932172Ab2LIBYb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Dec 2012 20:24:31 -0500
In-Reply-To: <20121209011755.19716.25244.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>

Fix the following sparse warnings in the OMAP3/4 CPUIdle code:

arch/arm/mach-omap2/cpuidle34xx.c:272:1: warning: symbol 'omap3_idle_dev' was not declared. Should it be static?
arch/arm/mach-omap2/cpuidle34xx.c:274:23: warning: symbol 'omap3_idle_driver' was not declared. Should it be static?
arch/arm/mach-omap2/cpuidle44xx.c:164:1: warning: symbol 'omap4_idle_dev' was not declared. Should it be static?
arch/arm/mach-omap2/cpuidle44xx.c:166:23: warning: symbol 'omap4_idle_driver' was not declared. Should it be static?

Also fix the following checkpatch warnings:

WARNING: please, no space before tabs
#44: FILE: arch/arm/mach-omap2/cpuidle34xx.c:105:
+^I.name = ^I"omap3_idle",$

WARNING: please, no space before tabs
#45: FILE: arch/arm/mach-omap2/cpuidle34xx.c:106:
+^I.owner = ^ITHIS_MODULE,$

ERROR: code indent should use tabs where possible
#211: FILE: arch/arm/mach-omap2/cpuidle44xx.c:74:
+                        /* C2 - CPU0 OFF + CPU1 OFF + MPU CSWR */$


Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   14 +++++++++-----
 arch/arm/mach-omap2/cpuidle44xx.c |   28 ++++++++++++++++------------
 2 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index ad70220..e6215b5 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -53,6 +53,8 @@ struct omap3_idle_statedata {
  */
 #define OMAP_CPUIDLE_CX_NO_CLKDM_IDLE		BIT(0)
 
+static struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
+
 /*
  * Prevent PER OFF if CORE is not in RETention or OFF as this would
  * disable PER wakeups completely.
@@ -97,7 +99,7 @@ static struct omap3_idle_statedata omap3_idle_data[] = {
 	},
 };
 
-static struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
+/* Private functions */
 
 static int __omap3_enter_idle(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
@@ -269,11 +271,11 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 	return ret;
 }
 
-DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
+static DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
 
-struct cpuidle_driver omap3_idle_driver = {
-	.name = 	"omap3_idle",
-	.owner = 	THIS_MODULE,
+static struct cpuidle_driver omap3_idle_driver = {
+	.name =		"omap3_idle",
+	.owner =	THIS_MODULE,
 	.states = {
 		{
 			.enter		  = omap3_enter_idle_bm,
@@ -336,6 +338,8 @@ struct cpuidle_driver omap3_idle_driver = {
 	.safe_state_index = 0,
 };
 
+/* Public functions */
+
 /**
  * omap3_idle_init - Init routine for OMAP3 idle
  *
diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index 288bee6..d639aef 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -54,6 +54,8 @@ static struct clockdomain *cpu_clkdm[NR_CPUS];
 static atomic_t abort_barrier;
 static bool cpu_done[NR_CPUS];
 
+/* Private functions */
+
 /**
  * omap4_enter_idle_coupled_[simple/coupled] - OMAP4 cpuidle entry functions
  * @dev: cpuidle device
@@ -161,9 +163,19 @@ fail:
 	return index;
 }
 
-DEFINE_PER_CPU(struct cpuidle_device, omap4_idle_dev);
+/*
+ * For each cpu, setup the broadcast timer because local timers
+ * stops for the states above C1.
+ */
+static void omap_setup_broadcast_timer(void *arg)
+{
+	int cpu = smp_processor_id();
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ON, &cpu);
+}
+
+static DEFINE_PER_CPU(struct cpuidle_device, omap4_idle_dev);
 
-struct cpuidle_driver omap4_idle_driver = {
+static struct cpuidle_driver omap4_idle_driver = {
 	.name				= "omap4_idle",
 	.owner				= THIS_MODULE,
 	.en_core_tk_irqen		= 1,
@@ -178,7 +190,7 @@ struct cpuidle_driver omap4_idle_driver = {
 			.desc = "MPUSS ON"
 		},
 		{
-                        /* C2 - CPU0 OFF + CPU1 OFF + MPU CSWR */
+			/* C2 - CPU0 OFF + CPU1 OFF + MPU CSWR */
 			.exit_latency = 328 + 440,
 			.target_residency = 960,
 			.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED,
@@ -200,15 +212,7 @@ struct cpuidle_driver omap4_idle_driver = {
 	.safe_state_index = 0,
 };
 
-/*
- * For each cpu, setup the broadcast timer because local timers
- * stops for the states above C1.
- */
-static void omap_setup_broadcast_timer(void *arg)
-{
-	int cpu = smp_processor_id();
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ON, &cpu);
-}
+/* Public functions */
 
 /**
  * omap4_idle_init - Init routine for OMAP4 idle


