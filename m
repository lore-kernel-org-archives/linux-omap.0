From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 7/8] OMAP3: update cpuidle latency and threshold figures
Date: Wed, 21 Sep 2011 18:14:08 +0200
Message-ID: <1316621649-3622-8-git-send-email-j-pihet@ti.com>
References: <1316621649-3622-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53151 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928Ab1IUQPB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 12:15:01 -0400
Received: by mail-wy0-f174.google.com with SMTP id 34so2066409wyg.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Sep 2011 09:15:00 -0700 (PDT)
In-Reply-To: <1316621649-3622-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.co>
Cc: Jean Pihet <j-pihet@ti.com>

Update the data from the measurements performed at HW and SW levels.

Cf. http://www.omappedia.org/wiki/Power_Management_Device_Latencies_Measurement
for a detailed explanation on where are the numbers magically coming from.

ToDo:
- Measure the wake-up latencies for all power domains for OMAP3
- Correct some numbers when sys_clkreq and sys_offmode are supported

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 1b8e0da..4b3e994 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -44,20 +44,20 @@
  * pass these details from the board file.
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
1.7.4.1

