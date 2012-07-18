From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [RFC][PATCH 1/1] ARM: OMAP2+: PM: Register suspend ops even in the presence of DT blob
Date: Wed, 18 Jul 2012 16:07:30 +0530
Message-ID: <1342607850-12071-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47528 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753294Ab2GRKiH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jul 2012 06:38:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kevin@ti.com, b-cousson@ti.com, paul@pswan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vaibhav Bedia <vaibhav.bedia@ti.com>

As per the comment in omap2_common_late_init() looks like the
original intent of the DT check was to treat only the PMIC
and SR initialization differently. Recent changes to consolidate
the suspend-resume code across OMAP3/4 resulted into the
registration of suspend ops also being dependent on the check
for DT blob. Since the suspend-resume operation should not
really be dependent on the usage of DT, move the suspend ops
registration before the check for DT.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
 arch/arm/mach-omap2/pm.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 9cb5ced..21761c0 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -297,6 +297,10 @@ postcore_initcall(omap2_common_pm_init);
 
 int __init omap2_common_pm_late_init(void)
 {
+#ifdef CONFIG_SUSPEND
+	suspend_set_ops(&omap_pm_ops);
+#endif
+
 	/*
 	 * In the case of DT, the PMIC and SR initialization will be done using
 	 * a completely different mechanism.
@@ -316,9 +320,5 @@ int __init omap2_common_pm_late_init(void)
 	/* Smartreflex device init */
 	omap_devinit_smartreflex();
 
-#ifdef CONFIG_SUSPEND
-	suspend_set_ops(&omap_pm_ops);
-#endif
-
 	return 0;
 }
-- 
1.7.0.4

