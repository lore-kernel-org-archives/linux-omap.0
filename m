From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH 1/2] SDTI: Fix sdti to use right clocks from clockfw
Date: Fri,  9 Jan 2009 09:52:32 +0200
Message-ID: <1231487553-17892-2-git-send-email-jouni.hogander@nokia.com>
References: <1231487553-17892-1-git-send-email-jouni.hogander@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:25120 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081AbZAIHws (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jan 2009 02:52:48 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n097piu0031699
	for <linux-omap@vger.kernel.org>; Fri, 9 Jan 2009 01:52:15 -0600
Received: from localhost.localdomain (trdhcp147193.ntc.nokia.com [172.22.147.193])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n097pfA8025740
	for <linux-omap@vger.kernel.org>; Fri, 9 Jan 2009 09:51:43 +0200
In-Reply-To: <1231487553-17892-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

SDTI uses pclk and pclkx2 instead of emu_per_alwon_ck. This patch
fixes sdti to use those clocks.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 drivers/misc/sti/sdti.c |   47 +++++++++++++++++++++++++++++++++++++----------
 1 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/sti/sdti.c b/drivers/misc/sti/sdti.c
index 92ce57b..8c27504 100644
--- a/drivers/misc/sti/sdti.c
+++ b/drivers/misc/sti/sdti.c
@@ -34,7 +34,7 @@
 #define SDTI_SYSCONFIG_SOFTRESET	(1 << 1)
 #define SDTI_SYSCONFIG_AUTOIDLE		(1 << 0)
 
-static struct clk *sdti_ck;
+static struct clk *sdti_fck, *sdti_ick;
 void __iomem *sti_base, *sti_channel_base;
 static DEFINE_SPINLOCK(sdti_lock);
 
@@ -70,14 +70,30 @@ static void omap_sdti_reset(void)
 static int __init omap_sdti_init(void)
 {
 	char buf[64];
-	int i;
+	int i, ret = 0;
 
-	sdti_ck = clk_get(NULL, "emu_per_alwon_ck");
-	if (IS_ERR(sdti_ck)) {
-		printk(KERN_ERR "Cannot get clk emu_per_alwon_ck\n");
-		return PTR_ERR(sdti_ck);
+	sdti_fck = clk_get(NULL, "pclk_fck");
+	if (IS_ERR(sdti_fck)) {
+		printk(KERN_ERR "Cannot get clk pclk_fck\n");
+		ret = PTR_ERR(sdti_fck);
+		goto err0;
+	}
+	sdti_ick = clk_get(NULL, "pclkx2_fck");
+	if (IS_ERR(sdti_ick)) {
+		printk(KERN_ERR "Cannot get clk pclkx2_fck\n");
+		ret = PTR_ERR(sdti_ick);
+		goto err1;
+	}
+	ret = clk_enable(sdti_fck);
+	if (ret) {
+		printk(KERN_ERR "Cannot enable sdti_fck\n");
+		goto err2;
+	}
+	ret = clk_enable(sdti_ick);
+	if (ret) {
+		printk(KERN_ERR "Cannot enable sdti_ick\n");
+		goto err3;
 	}
-	clk_enable(sdti_ck);
 
 	omap_sdti_reset();
 	sti_writel(0xC5ACCE55, SDTI_LOCK_ACCESS);
@@ -107,14 +123,25 @@ static int __init omap_sdti_init(void)
 	printk(KERN_INFO "%s", buf);
 	sti_channel_write_trace(strlen(buf), 0xc3, buf, 239);
 
-	return 0;
+	return ret;
+
+err3:
+	clk_disable(sdti_fck);
+err2:
+	clk_put(sdti_ick);
+err1:
+	clk_put(sdti_fck);
+err0:
+	return ret;
 }
 
 static void omap_sdti_exit(void)
 {
 	sti_writel(0, SDTI_WINCTRL);
-	clk_disable(sdti_ck);
-	clk_put(sdti_ck);
+	clk_disable(sdti_fck);
+	clk_disable(sdti_ick);
+	clk_put(sdti_fck);
+	clk_put(sdti_ick);
 }
 
 static int __devinit omap_sdti_probe(struct platform_device *pdev)
-- 
1.6.0.1

