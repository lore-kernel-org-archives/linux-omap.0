From: jean.pihet@newoldbits.com
Subject: [PATCH 8/8] OMAP PM: early init of the pwrdms states
Date: Wed,  4 May 2011 15:35:17 +0200
Message-ID: <1304516117-9334-9-git-send-email-j-pihet@ti.com>
References: <1304516117-9334-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34287 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625Ab1EDNfq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 09:35:46 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so835938wya.19
        for <linux-omap@vger.kernel.org>; Wed, 04 May 2011 06:35:45 -0700 (PDT)
In-Reply-To: <1304516117-9334-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, paul@pwsan.com
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

The powerdomains next states are initialized in pwrdms_setup as a
late_initcall. Because the wake-up constraint can be requested
early in the boot sequence, the power domains next states can be
overwritten by pwrdms_setup.

This patch fixes it by initializing the power domains next states
early at boot, so that the constraints can be applied.
Later in the pwrdms_setup function the currently programmed
next states are re-used as next state values.

Applies to OMAP3 and OMAP4.

Tested on OMAP3 Beagleboard in RET/OFF using wake-up latency constraints
on MPU, CORE and PER.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c      |    2 +-
 arch/arm/mach-omap2/pm44xx.c      |    2 +-
 arch/arm/mach-omap2/powerdomain.c |    5 +++++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 0c5e3a4..8d202a7 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -840,7 +840,7 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 	if (!pwrst)
 		return -ENOMEM;
 	pwrst->pwrdm = pwrdm;
-	pwrst->next_state = PWRDM_POWER_RET;
+	pwrst->next_state = pwrdm_read_next_pwrst(pwrdm);
 	list_add(&pwrst->node, &pwrst_list);
 
 	if (pwrdm_has_hdwr_sar(pwrdm))
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 59a870b..049efe9 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -84,7 +84,7 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 	if (!pwrst)
 		return -ENOMEM;
 	pwrst->pwrdm = pwrdm;
-	pwrst->next_state = PWRDM_POWER_ON;
+	pwrdm->state = pwrdm_read_pwrst(pwrdm);
 	list_add(&pwrst->node, &pwrst_list);
 
 	return pwrdm_set_next_pwrst(pwrst->pwrdm, pwrst->next_state);
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 9860630..3294707 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -78,6 +78,7 @@ static struct powerdomain *_pwrdm_lookup(const char *name)
 static int _pwrdm_register(struct powerdomain *pwrdm)
 {
 	int i;
+	int next_state = PWRDM_POWER_RET;
 
 	if (!pwrdm || !pwrdm->name)
 		return -EINVAL;
@@ -114,6 +115,10 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
 	pwrdm_wait_transition(pwrdm);
 	pwrdm->state = pwrdm_read_pwrst(pwrdm);
 	pwrdm->state_counter[pwrdm->state] = 1;
+	/* Early init of the next power state */
+	if (cpu_is_omap44xx())
+		next_state = PWRDM_POWER_ON;
+	pwrdm_set_next_pwrst(pwrdm, next_state);
 
 	pr_debug("powerdomain: registered %s\n", pwrdm->name);
 
-- 
1.7.2.5

