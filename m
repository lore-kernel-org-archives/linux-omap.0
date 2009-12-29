From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [patch-v2.6.33-rc2+ 04/12] arm: omap1: mailbox: kill compile warning
Date: Wed, 30 Dec 2009 00:51:24 +0200
Message-ID: <1262127092-14878-5-git-send-email-felipe.balbi@nokia.com>
References: <1262127092-14878-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:58941 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbZL2W4d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 17:56:33 -0500
In-Reply-To: <1262127092-14878-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <felipe.balbi@nokia.com>

use ioremap and remove unused variable to get rid
of compile warnings.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap1/devices.c |    2 +-
 arch/arm/mach-omap1/mailbox.c |    9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 23ded2d..9caf51b 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -71,7 +71,7 @@ static inline void omap_init_rtc(void) {}
 #  define INT_DSP_MAILBOX1	INT_1610_DSP_MAILBOX1
 #endif
 
-#define OMAP1_MBOX_BASE		OMAP1_IO_ADDRESS(OMAP16XX_MAILBOX_BASE)
+#define OMAP1_MBOX_BASE		OMAP16XX_MAILBOX_BASE
 
 static struct resource mbox_resources[] = {
 	{
diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index caf889a..4f5b3da 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -146,7 +146,6 @@ EXPORT_SYMBOL(mbox_dsp_info);
 static int __devinit omap1_mbox_probe(struct platform_device *pdev)
 {
 	struct resource *res;
-	int ret = 0;
 
 	if (pdev->num_resources != 2) {
 		dev_err(&pdev->dev, "invalid number of resources: %d\n",
@@ -160,12 +159,18 @@ static int __devinit omap1_mbox_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "invalid mem resource\n");
 		return -ENODEV;
 	}
-	mbox_base = res->start;
+
+	mbox_base = ioremap(res->start, resource_size(res));
+	if (!mbox_base) {
+		dev_err(&pdev->dev, "ioremap failed\n");
+		return -ENODEV;
+	}
 
 	/* DSP IRQ */
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (unlikely(!res)) {
 		dev_err(&pdev->dev, "invalid irq resource\n");
+		iounmap(mbox_base);
 		return -ENODEV;
 	}
 	mbox_dsp_info.irq = res->start;
-- 
1.6.6.35.g1d85d

