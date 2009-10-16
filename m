From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 01/17] PM: fix suspend control for IVA2
Date: Fri, 16 Oct 2009 13:48:54 +0300
Message-ID: <1255690150-16853-2-git-send-email-tero.kristo@nokia.com>
References: <>
 <1255690150-16853-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:51239 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463AbZJPLEP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 07:04:15 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9GB2Qcq001617
	for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2009 14:02:46 +0300
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-sa02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9GB2fZt022261
	for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2009 14:02:43 +0300
In-Reply-To: <1255690150-16853-1-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

IVA2 controls its target power state individually, thus suspend should not
touch IVA2. Without this patch DSP suspend always fails.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Acked-by: Ameya Palande <ameya.palande@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index a3e3729..5e2ef63 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -81,7 +81,7 @@ static int (*_omap_save_secure_sram)(u32 *addr);
 
 static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
 static struct powerdomain *core_pwrdm, *per_pwrdm;
-static struct powerdomain *cam_pwrdm;
+static struct powerdomain *cam_pwrdm, *iva2_pwrdm;
 
 static struct prm_setup_vc prm_setup = {
 	.clksetup = 0xff,
@@ -676,6 +676,12 @@ static int omap3_pm_suspend(void)
 		pwrst->saved_state = pwrdm_read_next_pwrst(pwrst->pwrdm);
 	/* Set ones wanted by suspend */
 	list_for_each_entry(pwrst, &pwrst_list, node) {
+		/* Special handling for IVA2, just use current sleep state */
+		if (pwrst->pwrdm == iva2_pwrdm) {
+			state = pwrdm_read_pwrst(pwrst->pwrdm);
+			if (state < PWRDM_POWER_ON)
+				pwrst->next_state = state;
+		}
 		if (set_pwrdm_state(pwrst->pwrdm, pwrst->next_state))
 			goto restore;
 		if (pwrdm_clear_all_prev_pwrst(pwrst->pwrdm))
@@ -1183,6 +1189,7 @@ static int __init omap3_pm_init(void)
 	per_pwrdm = pwrdm_lookup("per_pwrdm");
 	core_pwrdm = pwrdm_lookup("core_pwrdm");
 	cam_pwrdm = pwrdm_lookup("cam_pwrdm");
+	iva2_pwrdm = pwrdm_lookup("iva2_pwrdm");
 
 	omap_push_sram_idle();
 #ifdef CONFIG_SUSPEND
-- 
1.5.4.3

