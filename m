From: jean.pihet@newoldbits.com
Subject: [PATCH 07/13] OMAP PM: early init of the pwrdms states
Date: Thu, 28 Jul 2011 10:30:14 +0200
Message-ID: <1311841821-10252-8-git-send-email-j-pihet@ti.com>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:44924 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755173Ab1G1IbH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jul 2011 04:31:07 -0400
Received: by mail-ww0-f42.google.com with SMTP id 11so3768360wwg.1
        for <linux-omap@vger.kernel.org>; Thu, 28 Jul 2011 01:31:07 -0700 (PDT)
In-Reply-To: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foun>
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

The powerdomains next states are initialized in pwrdms_setup as a
late_initcall. Because the PM QoS devices constraint can be requested
early in the boot sequence, the power domains next states can be
overwritten by pwrdms_setup.

This patch fixes it by initializing the power domains next states
early at boot, so that the constraints can be applied.
Later in the pwrdms_setup function the currently programmed
next states are re-used as next state values.

Applies to OMAP3 and OMAP4.

Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using
wake-up latency constraints on MPU, CORE and PER.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c      |    2 +-
 arch/arm/mach-omap2/pm44xx.c      |    2 +-
 arch/arm/mach-omap2/powerdomain.c |    3 +++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 96a7624..af626ac 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -822,7 +822,7 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 	if (!pwrst)
 		return -ENOMEM;
 	pwrst->pwrdm = pwrdm;
-	pwrst->next_state = PWRDM_POWER_RET;
+	pwrst->next_state = pwrdm_read_next_pwrst(pwrdm);
 	list_add(&pwrst->node, &pwrst_list);
 
 	if (pwrdm_has_hdwr_sar(pwrdm))
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 59a870b..91ede72 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -84,7 +84,7 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 	if (!pwrst)
 		return -ENOMEM;
 	pwrst->pwrdm = pwrdm;
-	pwrst->next_state = PWRDM_POWER_ON;
+	pwrst->next_state = pwrdm_read_next_pwrst(pwrdm);
 	list_add(&pwrst->node, &pwrst_list);
 
 	return pwrdm_set_next_pwrst(pwrst->pwrdm, pwrst->next_state);
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 9af0847..63c3e7a 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -108,6 +108,9 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
 	pwrdm->state = pwrdm_read_pwrst(pwrdm);
 	pwrdm->state_counter[pwrdm->state] = 1;
 
+	/* Early init of the next power state */
+	pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_RET);
+
 	pr_debug("powerdomain: registered %s\n", pwrdm->name);
 
 	return 0;
-- 
1.7.2.5

