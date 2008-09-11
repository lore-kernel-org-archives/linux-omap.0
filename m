From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 23/29] OMAP3: PM: Add new Kconfig option to enable/disable off mode
Date: Thu, 11 Sep 2008 15:34:07 +0300
Message-ID: <1221136453-16697-23-git-send-email-khilman@deeprootsystems.com>
References: <87iqt2amoi.fsf@deeprootsystems.com>
 <1221136453-16697-1-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-2-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-3-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-4-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-5-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-6-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-7-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-8-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-9-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-10-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-11-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-12-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-13-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-14-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-15-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-16-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-17-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-18-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-19-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-20-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-21-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-22-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:19021 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756017AbYIKMfG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 08:35:06 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8BCZ2KS019090
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 15:35:04 +0300
In-Reply-To: <1221136453-16697-22-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jouni Hogander <jouni.hogander@nokia.com>

From: Jouni Hogander <jouni.hogander@nokia.com>

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/Kconfig       |    6 ++++++
 arch/arm/mach-omap2/cpuidle34xx.c |   12 ++++++++++++
 arch/arm/mach-omap2/pm34xx.c      |    4 ++++
 3 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 362edfa..5c0eafc 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -142,3 +142,9 @@ config OMAP_TICK_GPTIMER
 	  due to hardware sensitivity to glitches on the OMAP 32kHz clock
 	  input.
 
+config OMAP3_OFF_MODE
+	bool "OMAP 3430 OFF mode support"
+	depends on ARCH_OMAP3
+	default n
+	help
+	  Use off mode for powerdomains.
\ No newline at end of file
diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index c970a06..248b365 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -555,7 +555,11 @@ void omap_init_power_states(void)
 						CPUIDLE_FLAG_BALANCED;
 
 	/* C3 . MPU OFF + Core active */
+#ifdef CONFIG_OMAP3_OFF_MODE
 	omap3_power_states[OMAP3_STATE_C3].valid = 1;
+#else
+	omap3_power_states[OMAP3_STATE_C3].valid = 0;
+#endif
 	omap3_power_states[OMAP3_STATE_C3].type = OMAP3_STATE_C3;
 	omap3_power_states[OMAP3_STATE_C3].sleep_latency = 1500;
 	omap3_power_states[OMAP3_STATE_C3].wakeup_latency = 1800;
@@ -577,7 +581,11 @@ void omap_init_power_states(void)
 			CPUIDLE_FLAG_BALANCED | CPUIDLE_FLAG_CHECK_BM;
 
 	/* C5 . MPU OFF + Core CSWR */
+#ifdef CONFIG_OMAP3_OFF_MODE
 	omap3_power_states[OMAP3_STATE_C5].valid = 1;
+#else
+	omap3_power_states[OMAP3_STATE_C5].valid = 0;
+#endif
 	omap3_power_states[OMAP3_STATE_C5].type = OMAP3_STATE_C5;
 	omap3_power_states[OMAP3_STATE_C5].sleep_latency = 3000;
 	omap3_power_states[OMAP3_STATE_C5].wakeup_latency = 8500;
@@ -588,7 +596,11 @@ void omap_init_power_states(void)
 			CPUIDLE_FLAG_BALANCED | CPUIDLE_FLAG_CHECK_BM;
 
 	/* C6 . MPU OFF + Core OFF */
+#ifdef CONFIG_OMAP3_OFF_MODE
 	omap3_power_states[OMAP3_STATE_C6].valid = 1;
+#else
+	omap3_power_states[OMAP3_STATE_C6].valid = 0;
+#endif
 	omap3_power_states[OMAP3_STATE_C6].type = OMAP3_STATE_C6;
 	omap3_power_states[OMAP3_STATE_C6].sleep_latency = 10000;
 	omap3_power_states[OMAP3_STATE_C6].wakeup_latency = 30000;
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index fc7da5a..53814b6 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -801,7 +801,11 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm)
 	if (!pwrst)
 		return -ENOMEM;
 	pwrst->pwrdm = pwrdm;
+#ifdef CONFIG_OMAP3_OFF_MODE
+	pwrst->next_state = PWRDM_POWER_OFF;
+#else
 	pwrst->next_state = PWRDM_POWER_RET;
+#endif
 	list_add(&pwrst->node, &pwrst_list);
 
 	if (pwrdm_has_hdwr_sar(pwrdm))
-- 
1.6.0

