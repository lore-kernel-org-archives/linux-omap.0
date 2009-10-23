From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 03/10] OMAP3: PM: CPUidle: obey enable_off_mode flag
Date: Fri, 23 Oct 2009 09:59:01 -0700
Message-ID: <1256317148-25506-4-git-send-email-khilman@deeprootsystems.com>
References: <1256317148-25506-1-git-send-email-khilman@deeprootsystems.com>
 <1256317148-25506-2-git-send-email-khilman@deeprootsystems.com>
 <1256317148-25506-3-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:11746 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651AbZJWQ7S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Oct 2009 12:59:18 -0400
Received: by qw-out-2122.google.com with SMTP id 9so1391355qwb.37
        for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 09:59:23 -0700 (PDT)
In-Reply-To: <1256317148-25506-3-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

If 'enable_off_mode' is not set, force powerdomain states to RET
instead of OFF.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 0bf1bc3..1120494 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -29,6 +29,8 @@
 #include <plat/irqs.h>
 #include <plat/control.h>
 
+#include "pm.h"
+
 #ifdef CONFIG_CPU_IDLE
 
 #define OMAP3_MAX_STATES 7
@@ -74,6 +76,7 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 {
 	struct omap3_processor_cx *cx = cpuidle_get_statedata(state);
 	struct timespec ts_preidle, ts_postidle, ts_idle;
+	u32 mpu_state = cx->mpu_state, core_state = cx->core_state;
 
 	current_cx_state = *cx;
 
@@ -83,8 +86,15 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 	local_irq_disable();
 	local_fiq_disable();
 
-	set_pwrdm_state(mpu_pd, cx->mpu_state);
-	set_pwrdm_state(core_pd, cx->core_state);
+	if (!enable_off_mode) {
+		if (mpu_state < PWRDM_POWER_RET)
+			mpu_state = PWRDM_POWER_RET;
+		if (core_state < PWRDM_POWER_RET)
+			core_state = PWRDM_POWER_RET;
+	}
+
+	set_pwrdm_state(mpu_pd, mpu_state);
+	set_pwrdm_state(core_pd, core_state);
 
 	if (omap_irq_pending())
 		goto return_sleep_time;
-- 
1.6.4.3

