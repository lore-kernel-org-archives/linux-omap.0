From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [RFC PATCH 11/11] arm:omap:am33xx: Add am335x support in generic omap_hwmod
Date: Sun, 20 Nov 2011 22:49:15 +0530
Message-ID: <1321809555-13833-12-git-send-email-hvaibhav@ti.com>
References: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37459 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753766Ab1KTRUD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 20 Nov 2011 12:20:03 -0500
In-Reply-To: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, Vaibhav Hiremath <hvaibhav@ti.com>

AM335X is bit different than OMAP3/4 architecture when it comes to
PRCM module, for example, the way module is enabled/disabled.
Although it is closer to OMAP4 architecure but the register offset
and PRCM partitions won't match, so we need to seperate API's
for AM335X.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   29 +++++++++++++++++++++++------
 1 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index dfd3743..4360cb7 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -147,6 +147,7 @@

 #include "cm2xxx_3xxx.h"
 #include "cminst44xx.h"
+#include "cminst33xx.h"
 #include "prm2xxx_3xxx.h"
 #include "prm44xx.h"
 #include "prminst44xx.h"
@@ -689,7 +690,7 @@ static void _disable_optional_clocks(struct omap_hwmod *oh)
 static void _enable_module(struct omap_hwmod *oh)
 {
 	/* The module mode does not exist prior OMAP4 */
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
+	if (!cpu_is_am33xx() && (cpu_is_omap24xx() || cpu_is_omap34xx()))
 		return;

 	if (!oh->clkdm || !oh->prcm.omap4.modulemode)
@@ -698,7 +699,13 @@ static void _enable_module(struct omap_hwmod *oh)
 	pr_debug("omap_hwmod: %s: _enable_module: %d\n",
 		 oh->name, oh->prcm.omap4.modulemode);

-	omap4_cminst_module_enable(oh->prcm.omap4.modulemode,
+	if (cpu_is_am33xx())
+		am33xx_cminst_module_enable(oh->prcm.omap4.modulemode,
+				   oh->clkdm->cm_inst,
+				   oh->clkdm->clkdm_offs,
+				   oh->prcm.omap4.clkctrl_offs);
+	else
+		omap4_cminst_module_enable(oh->prcm.omap4.modulemode,
 				   oh->clkdm->prcm_partition,
 				   oh->clkdm->cm_inst,
 				   oh->clkdm->clkdm_offs,
@@ -715,7 +722,7 @@ static void _enable_module(struct omap_hwmod *oh)
 static void _disable_module(struct omap_hwmod *oh)
 {
 	/* The module mode does not exist prior OMAP4 */
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
+	if (!cpu_is_am33xx() && (cpu_is_omap24xx() || cpu_is_omap34xx()))
 		return;

 	if (!oh->clkdm || !oh->prcm.omap4.modulemode)
@@ -723,7 +730,12 @@ static void _disable_module(struct omap_hwmod *oh)

 	pr_debug("omap_hwmod: %s: _disable_module\n", oh->name);

-	omap4_cminst_module_disable(oh->clkdm->prcm_partition,
+	if (cpu_is_am33xx())
+		am33xx_cminst_module_disable(oh->clkdm->cm_inst,
+				    oh->clkdm->clkdm_offs,
+				    oh->prcm.omap4.clkctrl_offs);
+	else
+		omap4_cminst_module_disable(oh->clkdm->prcm_partition,
 				    oh->clkdm->cm_inst,
 				    oh->clkdm->clkdm_offs,
 				    oh->prcm.omap4.clkctrl_offs);
@@ -1169,7 +1181,7 @@ static int _wait_target_ready(struct omap_hwmod *oh)
 static int _wait_target_disable(struct omap_hwmod *oh)
 {
 	/* TODO: For now just handle OMAP4+ */
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
+	if (!cpu_is_am33xx() && (cpu_is_omap24xx() || cpu_is_omap34xx()))
 		return 0;

 	if (!oh)
@@ -1181,7 +1193,12 @@ static int _wait_target_disable(struct omap_hwmod *oh)
 	if (oh->flags & HWMOD_NO_IDLEST)
 		return 0;

-	return omap4_cminst_wait_module_idle(oh->clkdm->prcm_partition,
+	if (cpu_is_am33xx())
+		return am33xx_cminst_wait_module_idle(oh->clkdm->cm_inst,
+					     oh->clkdm->clkdm_offs,
+					     oh->prcm.omap4.clkctrl_offs);
+	else
+		return omap4_cminst_wait_module_idle(oh->clkdm->prcm_partition,
 					     oh->clkdm->cm_inst,
 					     oh->clkdm->clkdm_offs,
 					     oh->prcm.omap4.clkctrl_offs);
--
1.7.0.4

