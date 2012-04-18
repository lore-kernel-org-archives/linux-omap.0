From: jean.pihet@newoldbits.com
Subject: [PATCH 5/6] ARM: OMAP3: update cpuidle latency and threshold figures
Date: Wed, 18 Apr 2012 15:45:19 +0200
Message-ID: <1334756720-29166-6-git-send-email-j-pihet@ti.com>
References: <1334756720-29166-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:60460 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345Ab2DRNpw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Apr 2012 09:45:52 -0400
Received: by wibhq7 with SMTP id hq7so710286wib.1
        for <linux-omap@vger.kernel.org>; Wed, 18 Apr 2012 06:45:51 -0700 (PDT)
In-Reply-To: <1334756720-29166-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Update the data from the measurements performed at HW and SW levels.

Cf. http://www.omappedia.org/wiki/Power_Management_Device_Latencies_Measurement
for a detailed explanation on where are the numbers coming from.

ToDo:
- Measure the wake-up latencies for all power domains for OMAP3
- Correct some numbers when sys_clkreq and sys_offmode are supported

Signed-off-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   52 +++++++++++++++++++++++-------------
 1 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 2f95cfc..e406d7b 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -39,27 +39,41 @@
 #ifdef CONFIG_CPU_IDLE
 
 /*
- * The MPU latencies/thresholds for various C states have
- * to be configured from the respective board files.
- * These are some default values (which might not provide
- * the best power savings) used on boards which do not
- * pass these details from the board file.
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
+ *  . in order to force the cpuidle algorithm to chose the power efficient
+ *    C-states (C1, C3, C5, C7) in preference, the other C-states have a
+ *    threshold value equal to the next power efficient C-state
+ * 
+ * The latency and threshold values can be overriden by data from the board
+ * files, using omap3_pm_init_cpuidle.
  */
 static struct cpuidle_params cpuidle_params_table[] = {
-	/* C1 */
-	{2 + 2, 5, 1},
-	/* C2 */
-	{10 + 10, 30, 1},
-	/* C3 */
-	{50 + 50, 300, 1},
-	/* C4 */
-	{1500 + 1800, 4000, 1},
-	/* C5 */
-	{2500 + 7500, 12000, 1},
-	/* C6 */
-	{3000 + 8500, 15000, 1},
-	/* C7 */
-	{10000 + 30000, 300000, 1},
+	/* C1 . MPU WFI + Core active */
+	{73 + 78, 152, 1},
+	/* C2 . MPU WFI + Core inactive */
+	{165 + 88, 345, 1},
+	/* C3 . MPU CSWR + Core inactive */
+	{163 + 182, 345, 1},
+	/* C4 . MPU OFF + Core inactive */
+	{2852 + 605, 150000, 1},
+	/* C5 . MPU RET + Core RET */
+	{800 + 366, 2120, 1},
+	/* C6 . MPU OFF + Core RET */
+	{4080 + 801, 215000, 1},
+	/* C7 . MPU OFF + Core OFF */
+	{4300 + 13000, 215000, 1},
 };
 #define OMAP3_NUM_STATES ARRAY_SIZE(cpuidle_params_table)
 
-- 
1.7.7.6

