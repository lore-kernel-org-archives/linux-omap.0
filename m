From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 05/17] omap4: pm: Initialise all the clockdomains to supported states
Date: Sat, 19 Feb 2011 16:12:26 +0530
Message-ID: <1298112158-28469-6-git-send-email-santosh.shilimkar@ti.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50535 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753896Ab1BSKmu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Feb 2011 05:42:50 -0500
In-Reply-To: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>

Initialise hardware supervised mode for all clockdomains if it's
supported. Initiate sleep transition for other clockdomains,
if they are not being used.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/pm44xx.c |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index b142673..9a9dc41 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -17,9 +17,11 @@
 #include <linux/slab.h>
 #include <plat/clock.h>
 
-#include "powerdomain.h"
 #include <mach/omap4-common.h>
 
+#include "powerdomain.h"
+#include "clockdomain.h"
+
 struct power_state {
 	struct powerdomain *pwrdm;
 	u32 next_state;
@@ -74,6 +76,22 @@ static const struct platform_suspend_ops omap_pm_ops = {
 };
 #endif /* CONFIG_SUSPEND */
 
+/*
+ * Enable hardwarew supervised mode for all clockdomains if it's
+ * supported. Initiate sleep transition for other clockdomains, if
+ * they are not used
+ */
+static int __init clkdms_setup(struct clockdomain *clkdm, void *unused)
+{
+	if (clkdm->flags & CLKDM_CAN_ENABLE_AUTO)
+		clkdm_allow_idle(clkdm);
+	else if (clkdm->flags & CLKDM_CAN_FORCE_SLEEP &&
+			atomic_read(&clkdm->usecount) == 0)
+		clkdm_sleep(clkdm);
+	return 0;
+}
+
+
 static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 {
 	struct power_state *pwrst;
@@ -116,6 +134,8 @@ static int __init omap4_pm_init(void)
 	/* Enable autoidle for all clks which support it*/
 	omap_clk_enable_autoidle();
 
+	(void) clkdm_for_each(clkdms_setup, NULL);
+
 	ret = omap4_mpuss_init();
 	if (ret) {
 		pr_err("Failed to initialise OMAP4 MPUSS\n");
-- 
1.6.0.4

