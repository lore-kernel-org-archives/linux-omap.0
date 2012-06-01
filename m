From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 3/3] ARM: OMAP3: PM: cpuidle: optimize the clkdm idle latency in C1 state
Date: Fri,  1 Jun 2012 17:11:08 +0200
Message-ID: <1338563468-31403-4-git-send-email-j-pihet@ti.com>
References: <1338563468-31403-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:63887 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752924Ab2FAPLX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jun 2012 11:11:23 -0400
Received: by wgbdr13 with SMTP id dr13so2035762wgb.1
        for <linux-omap@vger.kernel.org>; Fri, 01 Jun 2012 08:11:22 -0700 (PDT)
In-Reply-To: <1338563468-31403-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org
Cc: Jean Pihet <j-pihet@ti.com>

For a power domain to idle all the clock domains in it must idle.
This patch implements an optimization of the cpuidle code by
denying and later allowing only the first registered clock domain
of a power domain, and so optimizes the latency of the low power code.

The functions _cpuidle_allow_idle and _cpuidle_deny_idle are
not used anymore and so are removed.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   22 ++++------------------
 1 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 2e2f1c6..e6ae3fe 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -77,20 +77,6 @@ static struct omap3_idle_statedata omap3_idle_data[] = {
 
 static struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
 
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
@@ -108,8 +94,8 @@ static int __omap3_enter_idle(struct cpuidle_device *dev,
 
 	/* Deny idle for C1 */
 	if (index == 0) {
-		pwrdm_for_each_clkdm(mpu_pd, _cpuidle_deny_idle);
-		pwrdm_for_each_clkdm(core_pd, _cpuidle_deny_idle);
+		clkdm_deny_idle(mpu_pd->pwrdm_clkdms[0]);
+		clkdm_deny_idle(core_pd->pwrdm_clkdms[0]);
 	}
 
 	/*
@@ -131,8 +117,8 @@ static int __omap3_enter_idle(struct cpuidle_device *dev,
 
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

