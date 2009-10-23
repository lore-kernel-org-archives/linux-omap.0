From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 07/10] OMAP3: PM: CPUidle: Start C-state definitions from base 0
Date: Fri, 23 Oct 2009 09:59:05 -0700
Message-ID: <1256317148-25506-8-git-send-email-khilman@deeprootsystems.com>
References: <1256317148-25506-1-git-send-email-khilman@deeprootsystems.com>
 <1256317148-25506-2-git-send-email-khilman@deeprootsystems.com>
 <1256317148-25506-3-git-send-email-khilman@deeprootsystems.com>
 <1256317148-25506-4-git-send-email-khilman@deeprootsystems.com>
 <1256317148-25506-5-git-send-email-khilman@deeprootsystems.com>
 <1256317148-25506-6-git-send-email-khilman@deeprootsystems.com>
 <1256317148-25506-7-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:11746 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574AbZJWQ7c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Oct 2009 12:59:32 -0400
Received: by qw-out-2122.google.com with SMTP id 9so1391355qwb.37
        for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 09:59:37 -0700 (PDT)
In-Reply-To: <1256317148-25506-7-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Sanjeev Premi <premi@ti.com>

From: Sanjeev Premi <premi@ti.com>

The current definition of C-states starts from base 1.
Whereas, the cpuidle driver uses base 0. This patch
eliminates need for explicit mapping (add/ sbutract)
due to different base values.

Signed-off-by: Sanjeev Premi <premi@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index c11377d..5128b8c 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -35,14 +35,14 @@
 
 #ifdef CONFIG_CPU_IDLE
 
-#define OMAP3_MAX_STATES 8
-#define OMAP3_STATE_C1 1 /* C1 - MPU WFI + Core active */
-#define OMAP3_STATE_C2 2 /* C2 - MPU WFI + Core inactive */
-#define OMAP3_STATE_C3 3 /* C3 - MPU CSWR + Core inactive */
-#define OMAP3_STATE_C4 4 /* C4 - MPU OFF + Core iactive */
-#define OMAP3_STATE_C5 5 /* C5 - MPU RET + Core RET */
-#define OMAP3_STATE_C6 6 /* C6 - MPU OFF + Core RET */
-#define OMAP3_STATE_C7 7 /* C7 - MPU OFF + Core OFF */
+#define OMAP3_MAX_STATES 7
+#define OMAP3_STATE_C1 0 /* C1 - MPU WFI + Core active */
+#define OMAP3_STATE_C2 1 /* C2 - MPU WFI + Core inactive */
+#define OMAP3_STATE_C3 2 /* C3 - MPU CSWR + Core inactive */
+#define OMAP3_STATE_C4 3 /* C4 - MPU OFF + Core iactive */
+#define OMAP3_STATE_C5 4 /* C5 - MPU RET + Core RET */
+#define OMAP3_STATE_C6 5 /* C6 - MPU OFF + Core RET */
+#define OMAP3_STATE_C7 6 /* C7 - MPU OFF + Core OFF */
 
 struct omap3_processor_cx {
 	u8 valid;
@@ -279,7 +279,7 @@ int __init omap3_idle_init(void)
 
 	dev = &per_cpu(omap3_idle_dev, smp_processor_id());
 
-	for (i = 1; i < OMAP3_MAX_STATES; i++) {
+	for (i = OMAP3_STATE_C1; i < OMAP3_MAX_STATES; i++) {
 		cx = &omap3_power_states[i];
 		state = &dev->states[count];
 
-- 
1.6.4.3

