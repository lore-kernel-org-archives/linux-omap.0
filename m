From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH] OMAP3: PM: Added resched check into idle calls
Date: Fri, 20 Mar 2009 15:21:02 +0200
Message-ID: <1237555262-13678-2-git-send-email-tero.kristo@nokia.com>
References: <>
 <1237555262-13678-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:46784 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbZCTNln (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 09:41:43 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n2KDfbm0026307
	for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 15:41:39 +0200
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n2KDe9RU020548
	for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 15:40:11 +0200
In-Reply-To: <1237555262-13678-1-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

Fixes a bug where scheduling is delayed until next wakeup due to race
condition (e.g. interrupt requests scheduling just before omap_sram_idle
is entered.)

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    2 +-
 arch/arm/mach-omap2/pm34xx.c      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 62fbb2e..037c02e 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -96,7 +96,7 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 	pwrdm_set_next_pwrst(mpu_pd, mpu_state);
 	pwrdm_set_next_pwrst(core_pd, core_state);
 
-	if (omap_irq_pending())
+	if (omap_irq_pending() || need_resched())
 		goto return_sleep_time;
 
 	/* Execute ARM wfi */
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index d39cfa4..6b13076 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -585,7 +585,7 @@ static void omap3_pm_idle(void)
 	if (!omap3_can_sleep())
 		goto out;
 
-	if (omap_irq_pending())
+	if (omap_irq_pending() || need_resched())
 		goto out;
 
 	omap_sram_idle();
-- 
1.5.4.3

