From: jean.pihet@newoldbits.com
Subject: [PATCH 2/2] ARM: OMAP3: PM: cpuidle: optimize the clkdm idle latency in C1 state
Date: Wed,  9 May 2012 12:55:12 +0200
Message-ID: <1336560912-26753-2-git-send-email-j-pihet@ti.com>
References: <1336560912-26753-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:54796 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507Ab2EIKz3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 06:55:29 -0400
Received: by werb10 with SMTP id b10so84201wer.19
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 03:55:28 -0700 (PDT)
In-Reply-To: <1336560912-26753-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

It is not needed to iterate through all the clock domains of a
power domain in order to allow or deny it to idle.
This patch allows or denies only the first registered clock domain
of a power domain, and so optimizes the latency of the low power
code. The functions _cpuidle_allow_idle and _cpuidle_deny_idle are
not used anymore and so are removed.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   22 ++++------------------
 1 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 353dd8d..d44b68a 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -73,20 +73,6 @@ struct omap3_idle_statedata omap3_idle_data[OMAP3_NUM_STATES];
 
 struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
 
-static int _cpuidle_allow_idle(struct powerdomain *pwrdm,
-				struct clockdomain *clkdm)
-{
-	clkdm_allow_idle(clkdm);
-	return 0;
-}
-
-static int _cpuidle_deny_idle(struct powerdomain *pwrdm,
-				struct clockdomain *clkdm)
-{
-	clkdm_deny_idle(clkdm);
-	return 0;
-}
-
 static int __omap3_enter_idle(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 				int index)
@@ -105,8 +91,8 @@ static int __omap3_enter_idle(struct cpuidle_device *dev,
 
 	/* Deny idle for C1 */
 	if (index == 0) {
-		pwrdm_for_each_clkdm(mpu_pd, _cpuidle_deny_idle);
-		pwrdm_for_each_clkdm(core_pd, _cpuidle_deny_idle);
+		clkdm_deny_idle(mpu_pd->pwrdm_clkdms[0]);
+		clkdm_deny_idle(core_pd->pwrdm_clkdms[0]);
 	}
 
 	/*
@@ -128,8 +114,8 @@ static int __omap3_enter_idle(struct cpuidle_device *dev,
 
 	/* Re-allow idle for C1 */
 	if (index == 0) {
-		pwrdm_for_each_clkdm(mpu_pd, _cpuidle_allow_idle);
-		pwrdm_for_each_clkdm(core_pd, _cpuidle_allow_idle);
+		clkdm_allow_idle(mpu_pd->pwrdm_clkdms[0]);
+		clkdm_allow_idle(core_pd->pwrdm_clkdms[0]);
 	}
 
 return_sleep_time:
-- 
1.7.7.6

