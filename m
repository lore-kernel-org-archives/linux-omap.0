From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 4/8] OMAP3: PM: Prevented DVFS state switches when enabling off-mode
Date: Fri,  9 Jan 2009 17:49:04 +0200
Message-ID: <1231516148-10260-5-git-send-email-tero.kristo@nokia.com>
References: <>
 <1231516148-10260-1-git-send-email-tero.kristo@nokia.com>
 <1231516148-10260-2-git-send-email-tero.kristo@nokia.com>
 <1231516148-10260-3-git-send-email-tero.kristo@nokia.com>
 <1231516148-10260-4-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:35830 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684AbZAIQBq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jan 2009 11:01:46 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n09G1PSj020394
	for <linux-omap@vger.kernel.org>; Fri, 9 Jan 2009 10:01:44 -0600
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n09FwtlN031435
	for <linux-omap@vger.kernel.org>; Fri, 9 Jan 2009 17:59:01 +0200
In-Reply-To: <1231516148-10260-4-git-send-email-tero.kristo@nokia.com>
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
index 7879589..301963e 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -843,8 +843,12 @@ void omap3_pm_off_mode_enable(int enable)
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

