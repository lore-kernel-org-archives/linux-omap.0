From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 11/59] omap: namespace cleanup to arch/arm/mach-omap1/id.c
Date: Wed, 12 Nov 2008 00:56:30 +0200
Message-ID: <1226444238-14614-12-git-send-email-me@felipebalbi.com>
References: <1226444238-14614-1-git-send-email-me@felipebalbi.com>
 <1226444238-14614-2-git-send-email-me@felipebalbi.com>
 <1226444238-14614-3-git-send-email-me@felipebalbi.com>
 <1226444238-14614-4-git-send-email-me@felipebalbi.com>
 <1226444238-14614-5-git-send-email-me@felipebalbi.com>
 <1226444238-14614-6-git-send-email-me@felipebalbi.com>
 <1226444238-14614-7-git-send-email-me@felipebalbi.com>
 <1226444238-14614-8-git-send-email-me@felipebalbi.com>
 <1226444238-14614-9-git-send-email-me@felipebalbi.com>
 <1226444238-14614-10-git-send-email-me@felipebalbi.com>
 <1226444238-14614-11-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:40033 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbYKKXBK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 18:01:10 -0500
In-Reply-To: <1226444238-14614-11-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap1/id.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap1/id.c b/arch/arm/mach-omap1/id.c
index 89bb875..dea9431 100644
--- a/arch/arm/mach-omap1/id.c
+++ b/arch/arm/mach-omap1/id.c
@@ -74,8 +74,8 @@ static u16 __init omap_get_jtag_id(void)
 {
 	u32 prod_id, omap_id;
 
-	prod_id = omap_readl(OMAP_PRODUCTION_ID_1);
-	omap_id = omap_readl(OMAP32_ID_1);
+	prod_id = __raw_readl(OMAP_PRODUCTION_ID_1);
+	omap_id = __raw_readl(OMAP32_ID_1);
 
 	/* Check for unusable OMAP_PRODUCTION_ID_1 on 1611B/5912 and 730 */
 	if (((prod_id >> 20) == 0) || (prod_id == omap_id))
@@ -102,7 +102,7 @@ static u8 __init omap_get_die_rev(void)
 {
 	u32 die_rev;
 
-	die_rev = omap_readl(OMAP_DIE_ID_1);
+	die_rev = __raw_readl(OMAP_DIE_ID_1);
 
 	/* Check for broken OMAP_DIE_ID on early 1710 */
 	if (((die_rev >> 12) & 0xffff) == omap_get_jtag_id())
@@ -112,7 +112,7 @@ static u8 __init omap_get_die_rev(void)
 	if (die_rev)
 		return die_rev;
 
-	die_rev = (omap_readl(OMAP32_ID_1) >> 28) & 0xf;
+	die_rev = (__raw_readl(OMAP32_ID_1) >> 28) & 0xf;
 
 	return die_rev;
 }
@@ -127,25 +127,25 @@ void __init omap_check_revision(void)
 
 	jtag_id = omap_get_jtag_id();
 	die_rev = omap_get_die_rev();
-	omap_id = omap_readl(OMAP32_ID_0);
+	omap_id = __raw_readl(OMAP32_ID_0);
 
 #ifdef DEBUG
-	printk(KERN_DEBUG "OMAP_DIE_ID_0: 0x%08x\n", omap_readl(OMAP_DIE_ID_0));
+	printk(KERN_DEBUG "OMAP_DIE_ID_0: 0x%08x\n", __raw_readl(OMAP_DIE_ID_0));
 	printk(KERN_DEBUG "OMAP_DIE_ID_1: 0x%08x DIE_REV: %i\n",
-		omap_readl(OMAP_DIE_ID_1),
-	       (omap_readl(OMAP_DIE_ID_1) >> 17) & 0xf);
+		__raw_readl(OMAP_DIE_ID_1),
+	       (__raw_readl(OMAP_DIE_ID_1) >> 17) & 0xf);
 	printk(KERN_DEBUG "OMAP_PRODUCTION_ID_0: 0x%08x\n",
-		omap_readl(OMAP_PRODUCTION_ID_0));
+		__raw_readl(OMAP_PRODUCTION_ID_0));
 	printk(KERN_DEBUG "OMAP_PRODUCTION_ID_1: 0x%08x JTAG_ID: 0x%04x\n",
-		omap_readl(OMAP_PRODUCTION_ID_1),
-		omap_readl(OMAP_PRODUCTION_ID_1) & 0xffff);
-	printk(KERN_DEBUG "OMAP32_ID_0: 0x%08x\n", omap_readl(OMAP32_ID_0));
-	printk(KERN_DEBUG "OMAP32_ID_1: 0x%08x\n", omap_readl(OMAP32_ID_1));
+		__raw_readl(OMAP_PRODUCTION_ID_1),
+		__raw_readl(OMAP_PRODUCTION_ID_1) & 0xffff);
+	printk(KERN_DEBUG "OMAP32_ID_0: 0x%08x\n", __raw_readl(OMAP32_ID_0));
+	printk(KERN_DEBUG "OMAP32_ID_1: 0x%08x\n", __raw_readl(OMAP32_ID_1));
 	printk(KERN_DEBUG "JTAG_ID: 0x%04x DIE_REV: %i\n", jtag_id, die_rev);
 #endif
 
-	system_serial_high = omap_readl(OMAP_DIE_ID_0);
-	system_serial_low = omap_readl(OMAP_DIE_ID_1);
+	system_serial_high = __raw_readl(OMAP_DIE_ID_0);
+	system_serial_low = __raw_readl(OMAP_DIE_ID_1);
 
 	/* First check only the major version in a safe way */
 	for (i = 0; i < ARRAY_SIZE(omap_ids); i++) {
-- 
1.6.0.2.307.gc427

