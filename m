From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 1/1] OMAP3 PM Add C0 state
Date: Wed, 18 Feb 2009 18:21:58 +0200
Message-ID: <1234974118-27446-2-git-send-email-peter.de-schrijver@nokia.com>
References: <1234974118-27446-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:52406 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659AbZBRQWF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Feb 2009 11:22:05 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n1IGLeea003412
	for <linux-omap@vger.kernel.org>; Wed, 18 Feb 2009 18:22:02 +0200
In-Reply-To: <1234974118-27446-1-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>


Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   53 ++++++++++++++++++++++++++++++-------
 1 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 62fbb2e..0b5fd52 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -26,6 +26,7 @@
 #include <mach/pm.h>
 #include <mach/prcm.h>
 #include <mach/powerdomain.h>
+#include <mach/clockdomain.h>
 #include <mach/control.h>
 #include <mach/serial.h>
 
@@ -34,9 +35,10 @@
 #ifdef CONFIG_CPU_IDLE
 
 #define OMAP3_MAX_STATES 7
-#define OMAP3_STATE_C1 1 /* C1 - MPU WFI + Core active */
-#define OMAP3_STATE_C2 2 /* C2 - MPU CSWR + Core active */
-#define OMAP3_STATE_C3 3 /* C3 - MPU OFF + Core active */
+#define OMAP3_STATE_C0 0 /* C0 - MPU WFI + Core active */
+#define OMAP3_STATE_C1 1 /* C1 - MPU WFI + Core inactive */
+#define OMAP3_STATE_C2 2 /* C2 - MPU CSWR + Core inactive */
+#define OMAP3_STATE_C3 3 /* C3 - MPU OFF + Core inactive */
 #define OMAP3_STATE_C4 4 /* C4 - MPU RET + Core RET */
 #define OMAP3_STATE_C5 5 /* C5 - MPU OFF + Core RET */
 #define OMAP3_STATE_C6 6 /* C6 - MPU OFF + Core OFF */
@@ -63,6 +65,16 @@ static int omap3_idle_bm_check(void)
 	return 0;
 }
 
+static int _cpuidle_allow_idle(struct powerdomain *pwrdm, struct clockdomain *clkdm)
+{
+	omap2_clkdm_allow_idle(clkdm);
+}
+
+static int _cpuidle_deny_idle(struct powerdomain *pwrdm, struct clockdomain *clkdm)
+{
+	omap2_clkdm_deny_idle(clkdm);
+}
+
 /**
  * omap3_enter_idle - Programs OMAP3 to enter the specified state
  * @dev: cpuidle device
@@ -99,9 +111,19 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 	if (omap_irq_pending())
 		goto return_sleep_time;
 
+	if (cx->type == OMAP3_STATE_C0) {
+		pwrdm_for_each_clkdm(mpu_pd, _cpuidle_deny_idle);
+		pwrdm_for_each_clkdm(core_pd, _cpuidle_deny_idle);
+	}
+
 	/* Execute ARM wfi */
 	omap_sram_idle();
 
+	if (cx->type == OMAP3_STATE_C0) {
+		pwrdm_for_each_clkdm(mpu_pd, _cpuidle_allow_idle);
+		pwrdm_for_each_clkdm(core_pd, _cpuidle_allow_idle);
+	}
+	
 return_sleep_time:
 	getnstimeofday(&ts_postidle);
 	ts_idle = timespec_sub(ts_postidle, ts_preidle);
@@ -140,16 +162,27 @@ DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
 /* omap3_init_power_states - Initialises the OMAP3 specific C states.
  *
  * Below is the desciption of each C state.
- *	C1 . MPU WFI + Core active
- *	C2 . MPU CSWR + Core active
- *	C3 . MPU OFF + Core active
+ * 	C0 . MPU WFI + Core active
+ *	C1 . MPU WFI + Core inactive
+ *	C2 . MPU CSWR + Core inactive
+ *	C3 . MPU OFF + Core inactive
  *	C4 . MPU CSWR + Core CSWR
  *	C5 . MPU OFF + Core CSWR
  *	C6 . MPU OFF + Core OFF
  */
 void omap_init_power_states(void)
 {
-	/* C1 . MPU WFI + Core active */
+	/* C0 . MPU WFI + Core active */
+	omap3_power_states[OMAP3_STATE_C0].valid = 1;
+	omap3_power_states[OMAP3_STATE_C0].type = OMAP3_STATE_C0;
+	omap3_power_states[OMAP3_STATE_C0].sleep_latency = 2;
+	omap3_power_states[OMAP3_STATE_C0].wakeup_latency = 2;
+	omap3_power_states[OMAP3_STATE_C0].threshold = 5;
+	omap3_power_states[OMAP3_STATE_C0].mpu_state = PWRDM_POWER_ON;
+	omap3_power_states[OMAP3_STATE_C0].core_state = PWRDM_POWER_ON;
+	omap3_power_states[OMAP3_STATE_C0].flags = CPUIDLE_FLAG_TIME_VALID;
+
+	/* C1 . MPU WFI + Core inactive */
 	omap3_power_states[OMAP3_STATE_C1].valid = 1;
 	omap3_power_states[OMAP3_STATE_C1].type = OMAP3_STATE_C1;
 	omap3_power_states[OMAP3_STATE_C1].sleep_latency = 10;
@@ -159,7 +192,7 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C1].core_state = PWRDM_POWER_ON;
 	omap3_power_states[OMAP3_STATE_C1].flags = CPUIDLE_FLAG_TIME_VALID;
 
-	/* C2 . MPU CSWR + Core active */
+	/* C2 . MPU CSWR + Core inactive */
 	omap3_power_states[OMAP3_STATE_C2].valid = 1;
 	omap3_power_states[OMAP3_STATE_C2].type = OMAP3_STATE_C2;
 	omap3_power_states[OMAP3_STATE_C2].sleep_latency = 50;
@@ -170,7 +203,7 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C2].flags = CPUIDLE_FLAG_TIME_VALID |
 				CPUIDLE_FLAG_CHECK_BM;
 
-	/* C3 . MPU OFF + Core active */
+	/* C3 . MPU OFF + Core inactive */
 	omap3_power_states[OMAP3_STATE_C3].valid = 1;
 	omap3_power_states[OMAP3_STATE_C3].type = OMAP3_STATE_C3;
 	omap3_power_states[OMAP3_STATE_C3].sleep_latency = 1500;
@@ -244,7 +277,7 @@ int omap3_idle_init(void)
 
 	dev = &per_cpu(omap3_idle_dev, smp_processor_id());
 
-	for (i = 1; i < OMAP3_MAX_STATES; i++) {
+	for (i = 0; i < OMAP3_MAX_STATES; i++) {
 		cx = &omap3_power_states[i];
 		state = &dev->states[count];
 
-- 
1.5.6.3

