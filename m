From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 10/18][V3] ARM: OMAP3: cpuidle - remove errata check in the init function
Date: Tue, 24 Apr 2012 16:05:31 +0200
Message-ID: <1335276339-11135-11-git-send-email-daniel.lezcano@linaro.org>
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33562 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650Ab2DXOGB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Apr 2012 10:06:01 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so716062wgb.1
        for <linux-omap@vger.kernel.org>; Tue, 24 Apr 2012 07:06:01 -0700 (PDT)
In-Reply-To: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, khilman@ti.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

The errata check is done in the next_valid_state function, no need to check
that in the omap3_idle_init function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 11a2c23..f394ea6 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -430,16 +430,6 @@ int __init omap3_idle_init(void)
 
 	/* C7 . MPU OFF + Core OFF */
 	cx = _fill_cstate_usage(dev, 6);
-	/*
-	 * Erratum i583: implementation for ES rev < Es1.2 on 3630. We cannot
-	 * enable OFF mode in a stable form for previous revisions.
-	 * We disable C7 state as a result.
-	 */
-	if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583)) {
-		cx->valid = 0;
-		pr_warn("%s: core off state C7 disabled due to i583\n",
-			__func__);
-	}
 	cx->mpu_state = PWRDM_POWER_OFF;
 	cx->core_state = PWRDM_POWER_OFF;
 
-- 
1.7.5.4

