From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH] PM debug: Fix problems with PM timers
Date: Mon, 26 Jan 2009 10:42:51 +0200
Message-ID: <1232959371-16669-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:38111 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbZAZIza (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Jan 2009 03:55:30 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n0Q8t8kp006853
	for <linux-omap@vger.kernel.org>; Mon, 26 Jan 2009 10:55:27 +0200
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n0Q8sqDL004338
	for <linux-omap@vger.kernel.org>; Mon, 26 Jan 2009 10:54:53 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Camera sleep deny fix introduced a problem that broke MPU state timers, this
is now fixed. Also removed DPLL* powerdomain timers from the status dumps.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm-debug.c |    3 ++-
 arch/arm/mach-omap2/pm34xx.c   |    3 +--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 2fc821a..bbd96a3 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -397,7 +397,8 @@ static int pwrdm_dbg_show_timer(struct powerdomain *pwrdm, void *user)
 	int i;
 
 	if (strcmp(pwrdm->name, "emu_pwrdm") == 0 ||
-		strcmp(pwrdm->name, "wkup_pwrdm") == 0)
+		strcmp(pwrdm->name, "wkup_pwrdm") == 0 ||
+		strncmp(pwrdm->name, "dpll", 4) == 0)
 		return 0;
 
 	pwrdm_state_switch(pwrdm);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index b2db0ba..4ab37d5 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -407,8 +407,6 @@ void omap_sram_idle(void)
 					       OMAP3_PRM_VOLTCTRL_OFFSET);
 	}
 
-	omap2_clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
-
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
 		per_prev_state = pwrdm_read_prev_pwrst(per_pwrdm);
@@ -431,6 +429,7 @@ void omap_sram_idle(void)
 
 	pwrdm_post_transition();
 
+	omap2_clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
 }
 
 /*
-- 
1.5.4.3

