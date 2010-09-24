From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] OMAP4: PM: Declare idle modules as functional too
Date: Fri, 24 Sep 2010 12:40:48 +0530
Message-ID: <1285312248-15734-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59017 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963Ab0IXHK7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Sep 2010 03:10:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>, Partha Basak <p-basak2@ti.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

The omap4_cm_wait_module_ready function would only check for
the modules to be completely functional before declaring them
ready to be accessed.
There might also be instances where in the module is actually
in idle (under h/w control) but should still be declared
accessible, as the h/w control would make it functional when
needed.

Hence make omap4_cm_wait_module_ready return true in case
the module is fully functional *or* in idle state.
Fail only if the module is fully disabled or stuck intransition.

The explaination from the TRM for the idlest bits on OMAP4 is as
below for quick reference

Module idle state:
0x0 func:     Module is fully functional, including OCP
0x1 trans:    Module is performing transition: wakeup, or sleep, or sleep
              abortion
0x2 idle:     Module is in Idle mode (only OCP part). It is functional if
              using separate functional clock
0x3 disabled: Module is disabled and cannot be accessed

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Partha Basak <p-basak2@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/cm4xxx.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/cm4xxx.c b/arch/arm/mach-omap2/cm4xxx.c
index b101091..f8a660a 100644
--- a/arch/arm/mach-omap2/cm4xxx.c
+++ b/arch/arm/mach-omap2/cm4xxx.c
@@ -43,7 +43,6 @@
  *                 using separate functional clock
  *   0x3 disabled: Module is disabled and cannot be accessed
  *
- * TODO: Need to handle module accessible in idle state
  */
 int omap4_cm_wait_module_ready(void __iomem *clkctrl_reg)
 {
@@ -52,9 +51,11 @@ int omap4_cm_wait_module_ready(void __iomem *clkctrl_reg)
 	if (!clkctrl_reg)
 		return 0;
 
-	omap_test_timeout(((__raw_readl(clkctrl_reg) &
-			    OMAP4430_IDLEST_MASK) == 0),
-			  MAX_MODULE_READY_TIME, i);
+	omap_test_timeout((
+		((__raw_readl(clkctrl_reg) & OMAP4430_IDLEST_MASK) == 0) ||
+		 (((__raw_readl(clkctrl_reg) & OMAP4430_IDLEST_MASK) >>
+		  OMAP4430_IDLEST_SHIFT) == 0x2)),
+		MAX_MODULE_READY_TIME, i);
 
 	return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
 }
-- 
1.7.0.4

