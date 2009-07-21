From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 12/14] OMAP3: PM: Fix wrong sequence in suspend.
Date: Tue, 21 Jul 2009 15:08:38 -0700
Message-ID: <1248214120-18886-13-git-send-email-khilman@deeprootsystems.com>
References: <1248214120-18886-1-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-2-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-3-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-4-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-5-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-6-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-7-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-8-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-9-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-10-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-11-git-send-email-khilman@deeprootsystems.com>
 <1248214120-18886-12-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:7329 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756236AbZGUWJM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jul 2009 18:09:12 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1009646wfd.4
        for <linux-omap@vger.kernel.org>; Tue, 21 Jul 2009 15:09:12 -0700 (PDT)
In-Reply-To: <1248214120-18886-12-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Jouni Hogander <jouni.hogander@nokia.com>

From: Jouni Hogander <jouni.hogander@nokia.com>

Powerdomain previous state is checked after restoring new states in
suspend. This patch fixes this problem.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index b07efb2..488d595 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -326,7 +326,6 @@ static int omap3_pm_suspend(void)
 restore:
 	/* Restore next_pwrsts */
 	list_for_each_entry(pwrst, &pwrst_list, node) {
-		set_pwrdm_state(pwrst->pwrdm, pwrst->saved_state);
 		state = pwrdm_read_prev_pwrst(pwrst->pwrdm);
 		if (state > pwrst->next_state) {
 			printk(KERN_INFO "Powerdomain (%s) didn't enter "
@@ -334,6 +333,7 @@ restore:
 			       pwrst->pwrdm->name, pwrst->next_state);
 			ret = -1;
 		}
+		set_pwrdm_state(pwrst->pwrdm, pwrst->saved_state);
 	}
 	if (ret)
 		printk(KERN_ERR "Could not enter target state in pm_suspend\n");
-- 
1.6.3.3

