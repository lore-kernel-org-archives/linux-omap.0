From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 1/2] OMAP3: PM: Check BM for C2 state
Date: Mon, 26 Oct 2009 15:10:39 +0200
Message-ID: <1256562640-15242-2-git-send-email-tero.kristo@nokia.com>
References: <>
 <1256562640-15242-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:39975 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754663AbZJZN0F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Oct 2009 09:26:05 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9QDPjhZ006232
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 15:26:07 +0200
In-Reply-To: <1256562640-15242-1-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: De-Schrijver Peter <Peter.De-Schrijver@nokia.com>

From: De-Schrijver Peter <Peter.De-Schrijver@nokia.com>

C2 can't be entered while we have bus activity.

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index c44a942..a0d9f56 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -38,7 +38,7 @@
 
 #define OMAP3_MAX_STATES 7
 #define OMAP3_STATE_C1 0 /* C1 - MPU WFI + Core active */
-#define OMAP3_STATE_C2 1 /* C2 - MPU WFI + Core inactive */
+#define OMAP3_STATE_C2 1 /* C2 - MPU inactive + Core inactive */
 #define OMAP3_STATE_C3 2 /* C3 - MPU CSWR + Core inactive */
 #define OMAP3_STATE_C4 3 /* C4 - MPU OFF + Core iactive */
 #define OMAP3_STATE_C5 4 /* C5 - MPU RET + Core RET */
@@ -169,7 +169,7 @@ DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
  *
  * Below is the desciption of each C state.
  * 	C1 . MPU WFI + Core active
- *	C2 . MPU WFI + Core inactive
+ *	C2 . MPU inactive + Core inactive
  *	C3 . MPU CSWR + Core inactive
  *	C4 . MPU OFF + Core inactive
  *	C5 . MPU CSWR + Core CSWR
@@ -196,7 +196,8 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C2].threshold = 30;
 	omap3_power_states[OMAP3_STATE_C2].mpu_state = PWRDM_POWER_ON;
 	omap3_power_states[OMAP3_STATE_C2].core_state = PWRDM_POWER_ON;
-	omap3_power_states[OMAP3_STATE_C2].flags = CPUIDLE_FLAG_TIME_VALID;
+	omap3_power_states[OMAP3_STATE_C2].flags = CPUIDLE_FLAG_TIME_VALID |
+				CPUIDLE_FLAG_CHECK_BM;
 
 	/* C3 . MPU CSWR + Core inactive */
 	omap3_power_states[OMAP3_STATE_C3].valid = 1;
-- 
1.5.4.3

