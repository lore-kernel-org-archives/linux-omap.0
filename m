From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 19/29] OMAP3: Do not set mpu, core, neon states if cpuidle is used
Date: Thu, 11 Sep 2008 15:34:03 +0300
Message-ID: <1221136453-16697-19-git-send-email-khilman@deeprootsystems.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:48489 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755833AbYIKMeo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 08:34:44 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8BCYL65003375
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 15:34:42 +0300
In-Reply-To: <1221136453-16697-18-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jouni Hogander <jouni.hogander@nokia.com>, Git administrator <gitowner@stego.research.nokia.com>

From: Jouni Hogander <jouni.hogander@nokia.com>

Let the cpuidle do the selection.

Signed-off-by: Git administrator <gitowner@stego.research.nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index d696dde..d6acf6c 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -815,12 +815,7 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm)
 	if (!pwrst)
 		return -ENOMEM;
 	pwrst->pwrdm = pwrdm;
-	if (!strcmp(pwrst->pwrdm->name, "core_pwrdm") ||
-			!strcmp(pwrst->pwrdm->name, "mpu_pwrdm") ||
-			!strcmp(pwrst->pwrdm->name, "mpu_pwrdm"))
-		pwrst->next_state = PWRDM_POWER_ON;
-	else
-		pwrst->next_state = PWRDM_POWER_OFF;
+	pwrst->next_state = PWRDM_POWER_RET;
 	list_add(&pwrst->node, &pwrst_list);
 
 	if (pwrdm_has_hdwr_sar(pwrdm))
@@ -838,7 +833,15 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm)
 	if (sysfs_create_file(suspend_dir_kobj, &(attr->attr)))
 		return -ENOMEM;
 
-	return set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
+#ifdef CONFIG_CPU_IDLE
+	/* Let cpuidle do selection here */
+	if (!strcmp(pwrst->pwrdm->name, "core_pwrdm") ||
+	    !strcmp(pwrst->pwrdm->name, "mpu_pwrdm") ||
+	    !strcmp(pwrst->pwrdm->name, "neon_pwrdm"))
+		return set_pwrdm_state(pwrst->pwrdm, PWRDM_POWER_ON);
+	else
+#endif
+		return set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
 }
 
 void omap_push_sram_idle()
-- 
1.6.0

