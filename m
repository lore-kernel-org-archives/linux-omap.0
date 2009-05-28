From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 02/06] OMAP3: PM: Add PER wakeup dependency on WKUP domain
Date: Thu, 28 May 2009 18:13:03 +0530
Message-ID: <1243514587-5323-2-git-send-email-rnayak@ti.com>
References: <1243514587-5323-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44995 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759030AbZE1MnO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 May 2009 08:43:14 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4SCh9rK029937
	for <linux-omap@vger.kernel.org>; Thu, 28 May 2009 07:43:15 -0500
In-Reply-To: <1243514587-5323-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

This patch adds a Wakeup dependency of PER domain on WKUP
domain as a Workaround for a OMAP3430 limitation which causes
PER domain GPIO's to drive random values while coming back
from OFF mode. This limitation applies to all silicon rev's
of OMAP3430.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 80992c5..231b33e 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -86,6 +86,7 @@ static int (*_omap_save_secure_sram)(u32 *addr);
 static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
 static struct powerdomain *core_pwrdm, *per_pwrdm;
 static struct powerdomain *cam_pwrdm;
+static struct powerdomain *wkup_pwrdm;
 
 static struct prm_setup_times prm_setup = {
 	.clksetup = 0xff,
@@ -1042,6 +1043,7 @@ int __init omap3_pm_init(void)
 	per_pwrdm = pwrdm_lookup("per_pwrdm");
 	core_pwrdm = pwrdm_lookup("core_pwrdm");
 	cam_pwrdm = pwrdm_lookup("cam_pwrdm");
+	wkup_pwrdm = pwrdm_lookup("wkup_pwrdm");
 
 	omap_push_sram_idle();
 
@@ -1063,6 +1065,13 @@ int __init omap3_pm_init(void)
 	*/
 	pwrdm_add_wkdep(per_pwrdm, core_pwrdm);
 
+	/*
+	 * This is a WA for an OMAP limitation (Listed in the omap errata doc
+	 * Section 2.23) which causes GPIO modules in PER domain to drive random
+	 * values while coming back from OFF mode.
+	 */
+	pwrdm_add_wkdep(per_pwrdm, wkup_pwrdm);
+
 	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
 		omap3_secure_ram_storage =
 			kmalloc(0x803F, GFP_KERNEL);
-- 
1.5.4.7

