From: Roman Tereshonkov <roman.tereshonkov@nokia.com>
Subject: [PATCH] Rid of product specific SDTI pin multiplexing.
Date: Tue,  5 Aug 2008 11:43:59 +0300
Message-ID: <1217925839-3583-1-git-send-email-roman.tereshonkov@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:63733 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760610AbYHEIql (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 04:46:41 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m758goNV006637
	for <linux-omap@vger.kernel.org>; Tue, 5 Aug 2008 03:46:39 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Roman Tereshonkov <roman.tereshonkov@nokia.com>


Signed-off-by: Roman Tereshonkov <roman.tereshonkov@nokia.com>
---
 drivers/misc/sti/sdti.c |   27 ++-------------------------
 1 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/drivers/misc/sti/sdti.c b/drivers/misc/sti/sdti.c
index adfbcbc..e12fb12 100644
--- a/drivers/misc/sti/sdti.c
+++ b/drivers/misc/sti/sdti.c
@@ -31,13 +31,8 @@
 #define CPU1_TRACE_EN		0x01
 #define CPU2_TRACE_EN		0x02
 
-#define EPM_BASE		0x5401D000
-#define EPM_CONTROL_0		0x50
-#define EPM_CONTROL_1		0x54
-#define EPM_CONTROL_2		0x58
-
 static struct clk *sdti_ck;
-unsigned long sti_base, sti_channel_base, epm_base;
+unsigned long sti_base, sti_channel_base;
 static DEFINE_SPINLOCK(sdti_lock);
 
 void omap_sti_channel_write_trace(int len, int id, void *data,
@@ -69,20 +64,6 @@ static void omap_sdti_reset(void)
 		printk(KERN_WARNING "XTI: no real reset\n");
 }
 
-void init_epm(void)
-{
-	epm_base = (unsigned long)ioremap(EPM_BASE, 256);
-	if (unlikely(!epm_base)) {
-		printk(KERN_ERR "EPM cannot be ioremapped\n");
-		return;
-	}
-
-	__raw_writel(1<<30, epm_base + EPM_CONTROL_2);
-	__raw_writel(0x78, epm_base + EPM_CONTROL_0);
-	__raw_writel(0x80000000, epm_base + EPM_CONTROL_1);
-	__raw_writel(1<<31 | 0x00007770, epm_base + EPM_CONTROL_2);
-}
-
 static int __init omap_sdti_init(void)
 {
 	char buf[64];
@@ -95,9 +76,6 @@ static int __init omap_sdti_init(void)
 	}
 	clk_enable(sdti_ck);
 
-	/* Init emulation pin manager */
-	init_epm();
-
 	omap_sdti_reset();
 	sti_writel(0xC5ACCE55, SDTI_LOCK_ACCESS);
 
@@ -110,7 +88,7 @@ static int __init omap_sdti_init(void)
 	/* 4 bits dual, fclk/3 */
 	sti_writel(0x43, SDTI_SCONFIG);
 
-	/* CPU1 trace enable */
+	/* CPU2 trace enable */
 	sti_writel(i | CPU2_TRACE_EN, SDTI_WINCTRL);
 	i = sti_readl(SDTI_WINCTRL);
 
@@ -177,7 +155,6 @@ static int __devexit omap_sdti_remove(struct platform_device *pdev)
 {
 	iounmap((void *)sti_channel_base);
 	iounmap((void *)sti_base);
-	iounmap((void *)epm_base);
 	omap_sdti_exit();
 
 	return 0;
-- 
1.5.5.1

