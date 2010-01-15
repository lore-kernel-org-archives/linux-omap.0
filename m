From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 09/10] DSPBRIDGE: checkpatch - printk() should include KERN_ facility level
Date: Fri, 15 Jan 2010 15:28:40 -0600
Message-ID: <1263590921-24357-10-git-send-email-omar.ramirez@ti.com>
References: <1263590921-24357-1-git-send-email-omar.ramirez@ti.com>
 <1263590921-24357-2-git-send-email-omar.ramirez@ti.com>
 <1263590921-24357-3-git-send-email-omar.ramirez@ti.com>
 <1263590921-24357-4-git-send-email-omar.ramirez@ti.com>
 <1263590921-24357-5-git-send-email-omar.ramirez@ti.com>
 <1263590921-24357-6-git-send-email-omar.ramirez@ti.com>
 <1263590921-24357-7-git-send-email-omar.ramirez@ti.com>
 <1263590921-24357-8-git-send-email-omar.ramirez@ti.com>
 <1263590921-24357-9-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58661 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758280Ab0AOVSz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 16:18:55 -0500
In-Reply-To: <1263590921-24357-9-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

WARNING: printk() should include KERN_ facility level

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dbc.h |    2 +-
 arch/arm/plat-omap/include/dspbridge/gt.h  |    2 +-
 drivers/dsp/bridge/gen/_gt_para.c          |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dbc.h b/arch/arm/plat-omap/include/dspbridge/dbc.h
index e9cb548..ac5d178 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbc.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbc.h
@@ -36,7 +36,7 @@
 
 #define DBC_Assert(exp) \
     if (!(exp)) \
-	printk("%s, line %d: Assertion (" #exp ") failed.\n", \
+	pr_err("%s, line %d: Assertion (" #exp ") failed.\n", \
 	__FILE__, __LINE__)
 #define DBC_Require DBC_Assert	/* Function Precondition.  */
 #define DBC_Ensure  DBC_Assert	/* Function Postcondition. */
diff --git a/arch/arm/plat-omap/include/dspbridge/gt.h b/arch/arm/plat-omap/include/dspbridge/gt.h
index b43b1e7..6082d15 100644
--- a/arch/arm/plat-omap/include/dspbridge/gt.h
+++ b/arch/arm/plat-omap/include/dspbridge/gt.h
@@ -232,7 +232,7 @@ extern struct GT_Config _GT_params;
 
 #define GT_assert(mask, expr) \
 	(!(expr) ? \
-	    printk("assertion violation: %s, line %d\n", \
+	    pr_err("assertion violation: %s, line %d\n", \
 			    __FILE__, __LINE__), NULL : NULL)
 
 #define GT_config(config)     (_GT_params = *(config))
diff --git a/drivers/dsp/bridge/gen/_gt_para.c b/drivers/dsp/bridge/gen/_gt_para.c
index 9f8246b..f676d3f 100644
--- a/drivers/dsp/bridge/gen/_gt_para.c
+++ b/drivers/dsp/bridge/gen/_gt_para.c
@@ -77,7 +77,7 @@ static void error(char *fmt, ...)
 
 	va_end(va);
 
-	printk("ERROR: ");
+	pr_err("ERROR: ");
 	printk(fmt, arg1, arg2, arg3, arg4, arg5, arg6);
 
 #if defined(DEBUG) || defined(DDSP_DEBUG_PRODUCT)
-- 
1.6.2.4

