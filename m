From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 07/10] ARM: OMAP3: update cpuidle latency and threshold figures
Date: Thu, 14 Jun 2012 17:05:58 +0200
Message-ID: <1339686361-11526-8-git-send-email-j-pihet@ti.com>
References: <1339686361-11526-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:40827 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756140Ab2FNPGU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 11:06:20 -0400
Received: by mail-wi0-f172.google.com with SMTP id hj8so6649604wib.1
        for <linux-omap@vger.kernel.org>; Thu, 14 Jun 2012 08:06:19 -0700 (PDT)
In-Reply-To: <1339686361-11526-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com
Cc: Jean Pihet <j-pihet@ti.com>

Update the data from the measurements performed at HW and SW levels.

Cf. http://www.omappedia.org/wiki/Power_Management_Device_Latencies_Measurement
for a detailed explanation on where are the numbers coming from.

ToDo:
- Measure the wake-up latencies for all power domains for OMAP3
- Correct some numbers when sys_clkreq and sys_offmode are supported

Signed-off-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   52 +++++++++++++++++++++++++++----------
 1 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 9319f94..9438385 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -295,6 +295,30 @@ DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
  *
  * - target_residency: required amount of time in the C state
  *  to break even on energy cost
+ *
+ * The MPU latency and threshold values for the C-states are the worst case
+ * values from the HW and SW, as described in details at
+ * http://www.omappedia.org/wiki/Power_Management_Device_Latencies_Measurement#cpuidle_results
+ *
+ * Measurements conditions and remarks:
+ *  . the measurements have been performed at OPP50
+ *  . the sys_offmode signal is not supported and so not used for the
+ *    measurements. Instead the latency and threshold values for C9 are
+ *    corrected with the value for Triton 2, which is 11.5ms
+ *  . the sys_clkreq signal is not used and so a correction is needed - TBD
+ *  . the sys_clkoff signal is supported, this value need to be corrected with
+ *    the correct value of SYSCLK on/off timings (1ms for sysclk on, 2.5ms
+ *    for sysclk off)
+ *  . the setup time of DPLLs is included in the measured values. However
+ *    this is only valid for DPLLs that are enabled to auto-idle at
+ *    measurement time. There currently is no provision for the dynamic
+ *    nature of the auto-idle setting
+ *  . in order to force the cpuidle algorithm to chose the power efficient
+ *    C-states (C1, C3, C5, C7) in preference, the other C-states have a
+ *    threshold value equal to the next power efficient C-state
+ *
+ * The latency and threshold values can be overriden by data from the board
+ * files, using omap3_pm_init_cpuidle.
  */
 struct cpuidle_driver omap3_idle_driver = {
 	.name = 	"omap3_idle",
@@ -302,56 +326,56 @@ struct cpuidle_driver omap3_idle_driver = {
 	.states = {
 		{
 			.enter		  = omap3_enter_idle,
-			.exit_latency	  = 2 + 2,
-			.target_residency = 5,
+			.exit_latency	  = 73 + 78,
+			.target_residency = 152,
 			.flags		  = CPUIDLE_FLAG_TIME_VALID,
 			.name		  = "C1",
 			.desc		  = "MPU ON + CORE ON",
 		},
 		{
 			.enter		  = omap3_enter_idle_bm,
-			.exit_latency	  = 10 + 10,
-			.target_residency = 30,
+			.exit_latency	  = 165 + 88,
+			.target_residency = 345,
 			.flags		  = CPUIDLE_FLAG_TIME_VALID,
 			.name		  = "C2",
 			.desc		  = "MPU ON + CORE ON",
 		},
 		{
 			.enter		  = omap3_enter_idle_bm,
-			.exit_latency	  = 50 + 50,
-			.target_residency = 300,
+			.exit_latency	  = 163 + 182,
+			.target_residency = 345,
 			.flags		  = CPUIDLE_FLAG_TIME_VALID,
 			.name		  = "C3",
 			.desc		  = "MPU RET + CORE ON",
 		},
 		{
 			.enter		  = omap3_enter_idle_bm,
-			.exit_latency	  = 1500 + 1800,
-			.target_residency = 4000,
+			.exit_latency	  = 2852 + 605,
+			.target_residency = 150000,
 			.flags		  = CPUIDLE_FLAG_TIME_VALID,
 			.name		  = "C4",
 			.desc		  = "MPU OFF + CORE ON",
 		},
 		{
 			.enter		  = omap3_enter_idle_bm,
-			.exit_latency	  = 2500 + 7500,
-			.target_residency = 12000,
+			.exit_latency	  = 800 + 366,
+			.target_residency = 2120,
 			.flags		  = CPUIDLE_FLAG_TIME_VALID,
 			.name		  = "C5",
 			.desc		  = "MPU RET + CORE RET",
 		},
 		{
 			.enter		  = omap3_enter_idle_bm,
-			.exit_latency	  = 3000 + 8500,
-			.target_residency = 15000,
+			.exit_latency	  = 4080 + 801,
+			.target_residency = 215000,
 			.flags		  = CPUIDLE_FLAG_TIME_VALID,
 			.name		  = "C6",
 			.desc		  = "MPU OFF + CORE RET",
 		},
 		{
 			.enter		  = omap3_enter_idle_bm,
-			.exit_latency	  = 10000 + 30000,
-			.target_residency = 30000,
+			.exit_latency	  = 4300 + 13000,
+			.target_residency = 215000,
 			.flags		  = CPUIDLE_FLAG_TIME_VALID,
 			.name		  = "C7",
 			.desc		  = "MPU OFF + CORE OFF",
-- 
1.7.7.6

