From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 03/05] OMAP3: Enables C3 and C5
Date: Wed, 8 Oct 2008 17:31:32 +0530
Message-ID: <001901c9293d$9acd00c0$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57028 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753740AbYJHMBl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Oct 2008 08:01:41 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: 'Kevin Hilman' <khilman@deeprootsystems.com>

This enables support for MPU OFF.
Enables states C3 and C5.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/cpuidle34xx.c	2008-10-08 16:51:45.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c	2008-10-08 16:52:43.000000000 +0530
@@ -26,6 +26,7 @@
 #include <mach/pm.h>
 #include <mach/prcm.h>
 #include <mach/powerdomain.h>
+#include <mach/control.h>
 
 #ifdef CONFIG_CPU_IDLE
 
@@ -179,7 +180,7 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C2].flags = CPUIDLE_FLAG_TIME_VALID;
 
 	/* C3 . MPU OFF + Core active */
-	omap3_power_states[OMAP3_STATE_C3].valid = 0;
+	omap3_power_states[OMAP3_STATE_C3].valid = 1;
 	omap3_power_states[OMAP3_STATE_C3].type = OMAP3_STATE_C3;
 	omap3_power_states[OMAP3_STATE_C3].sleep_latency = 1500;
 	omap3_power_states[OMAP3_STATE_C3].wakeup_latency = 1800;
@@ -200,7 +201,7 @@ void omap_init_power_states(void)
 				CPUIDLE_FLAG_CHECK_BM;
 
 	/* C5 . MPU OFF + Core CSWR */
-	omap3_power_states[OMAP3_STATE_C5].valid = 0;
+	omap3_power_states[OMAP3_STATE_C5].valid = 1;
 	omap3_power_states[OMAP3_STATE_C5].type = OMAP3_STATE_C5;
 	omap3_power_states[OMAP3_STATE_C5].sleep_latency = 3000;
 	omap3_power_states[OMAP3_STATE_C5].wakeup_latency = 8500;
@@ -240,6 +241,8 @@ int omap3_idle_init(void)
 	struct cpuidle_state *state;
 	struct cpuidle_device *dev;
 
+	omap3_save_scratchpad_contents();
+
 	omap_init_power_states();
 	cpuidle_register_driver(&omap3_idle_driver);
 

