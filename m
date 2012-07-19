From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [RFC][PATCH v2 1/1] ARM: OMAP2+: PM: Register suspend ops even in the presence of DT blob
Date: Thu, 19 Jul 2012 17:38:48 +0530
Message-ID: <1342699728-19831-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49936 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751810Ab2GSMJY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jul 2012 08:09:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com, b-cousson@ti.com, paul@pswan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vaibhav Bedia <vaibhav.bedia@ti.com>

As per the comment in omap2_common_late_init() looks like the
original intent of the DT check was to treat only the PMIC
and SR initialization differently. Recent changes to consolidate
the suspend-resume code across OMAP3/4 resulted into the
registration of suspend ops also being dependent on the check
for DT blob. Since the suspend-resume operation should not
really be dependent on the usage of DT remove this dependency
by wrapping the PMIC and SR init under the DT check.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
v2->v1
 - As suggested by Paul, Instead of moving around the suspend ops
   registration just wrap the PMIC and SR init under the DT check.
 - Fixed up Kevin's email address :\

 arch/arm/mach-omap2/pm.c |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 9cb5ced..46848f7 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -302,19 +302,18 @@ int __init omap2_common_pm_late_init(void)
 	 * a completely different mechanism.
 	 * Disable this part if a DT blob is available.
 	 */
-	if (of_have_populated_dt())
-		return 0;
+	if (!of_have_populated_dt()) {
+		/* Init the voltage layer */
+		omap_pmic_late_init();
+		omap_voltage_late_init();
 
-	/* Init the voltage layer */
-	omap_pmic_late_init();
-	omap_voltage_late_init();
+		/* Initialize the voltages */
+		omap3_init_voltages();
+		omap4_init_voltages();
 
-	/* Initialize the voltages */
-	omap3_init_voltages();
-	omap4_init_voltages();
-
-	/* Smartreflex device init */
-	omap_devinit_smartreflex();
+		/* Smartreflex device init */
+		omap_devinit_smartreflex();
+	}
 
 #ifdef CONFIG_SUSPEND
 	suspend_set_ops(&omap_pm_ops);
-- 
1.7.0.4

