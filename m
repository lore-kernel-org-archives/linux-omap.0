From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 21/23] OMAP3: PM: Prevented DVFS state switches when enabling off-mode
Date: Thu, 11 Dec 2008 17:52:40 +0200
Message-ID: <1229010762-3150-22-git-send-email-tero.kristo@nokia.com>
References: <>
 <1229010762-3150-1-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-2-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-3-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-4-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-5-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-6-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-7-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-8-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-9-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-10-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-11-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-12-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-13-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-14-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-15-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-16-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-17-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-18-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-19-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-20-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-21-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53966 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756220AbYLKP7S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 10:59:18 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mBBFxClQ006140
	for <linux-omap@vger.kernel.org>; Thu, 11 Dec 2008 09:59:15 -0600
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id mBBFwci2011022
	for <linux-omap@vger.kernel.org>; Thu, 11 Dec 2008 17:59:08 +0200
In-Reply-To: <1229010762-3150-21-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

resource_refresh() call tried to refresh DVFS OPP levels also. This should
eventually be fixed in a way that DVFS VDD2 level is actually governed by
something.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index e0c952e..7367f68 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -783,8 +783,12 @@ void omap3_pm_off_mode_enable(int enable)
 		state = PWRDM_POWER_RET;
 
 #ifdef CONFIG_OMAP_PM_SRF
+	resource_lock_opp(VDD1_OPP);
+	resource_lock_opp(VDD2_OPP);
 	if (resource_refresh())
 		printk(KERN_ERR "Error: could not refresh resources\n");
+	resource_unlock_opp(VDD1_OPP);
+	resource_unlock_opp(VDD2_OPP);
 #endif
 	list_for_each_entry(pwrst, &pwrst_list, node) {
 		pwrst->next_state = state;
-- 
1.5.4.3

