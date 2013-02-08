From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] ARM: OMAP2+: PM: Fix the dt return condition in pm_late_init()
Date: Fri, 8 Feb 2013 20:41:44 +0530
Message-ID: <1360336306-18277-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52707 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946062Ab3BHPKg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Feb 2013 10:10:36 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>

Commit 1416408d {ARM: OMAP2+: PM: share some suspend-related functions
across OMAP2, 3, 4} moved suspend code to common place but now with
that change, for DT build on OMAP4, suspend hooks are not getting
registered which results in no suspend support.

The DT return condition is limited to PMIC and smartreflex
initialization and hence restrict it so that suspend ops gets
registered.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/pm.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index f4b3143..1ec4299 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -345,19 +345,19 @@ int __init omap2_common_pm_late_init(void)
 	 * a completely different mechanism.
 	 * Disable this part if a DT blob is available.
 	 */
-	if (of_have_populated_dt())
-		return 0;
+	if (!of_have_populated_dt()) {
 
-	/* Init the voltage layer */
-	omap_pmic_late_init();
-	omap_voltage_late_init();
+		/* Init the voltage layer */
+		omap_pmic_late_init();
+		omap_voltage_late_init();
 
-	/* Initialize the voltages */
-	omap3_init_voltages();
-	omap4_init_voltages();
+		/* Initialize the voltages */
+		omap3_init_voltages();
+		omap4_init_voltages();
 
-	/* Smartreflex device init */
-	omap_devinit_smartreflex();
+		/* Smartreflex device init */
+		omap_devinit_smartreflex();
+	}
 
 #ifdef CONFIG_SUSPEND
 	suspend_set_ops(&omap_pm_ops);
-- 
1.7.9.5

