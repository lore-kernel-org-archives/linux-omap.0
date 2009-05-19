From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: [PATCH] OMAP3: PM: Do not Enable SmartReflex if OPP tables not defined
Date: Tue, 19 May 2009 15:37:51 +0300
Message-ID: <1242736671-27268-1-git-send-email-ext-roger.quadros@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:63195 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790AbZESMkP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 08:40:15 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

Prevent SmartReflex driver driver from loading if OPP tables are
not defined by platform. This removes possibility of NULL pointer
reference in SmartReflex driver code.

Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
---
 arch/arm/mach-omap2/smartreflex.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index b032366..4823ce8 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -852,6 +852,12 @@ static int __init omap3_sr_init(void)
 	int ret = 0;
 	u8 RdReg;
 
+	/* Exit if OPP tables are not defined */
+        if (!(mpu_opps && l3_opps)) {
+                pr_err("SR: OPP rate tables not defined for platform, not enabling SmartReflex\n");
+		return -ENODEV;
+        }
+
 	/* Enable SR on T2 */
 	ret = twl4030_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &RdReg,
 					R_DCDC_GLOBAL_CFG);
-- 
1.6.0.4

