From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH v2] arm: omap1: mailbox: kill compile warning
Date: Tue, 29 Dec 2009 02:59:12 +0200
Message-ID: <1262048352-23291-1-git-send-email-felipe.balbi@nokia.com>
References: <20091229002656.GW3512@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:44480 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbZL2A7Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Dec 2009 19:59:24 -0500
In-Reply-To: <20091229002656.GW3512@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Balbi <felipe.balbi@nokia.com>

remove unused variable and kill compile warning.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---

Changes from previous version:
	- Removed OMAP1_IO_ADDRESS() from OMAP1_MBOX_BASE define

 arch/arm/mach-omap1/devices.c |    2 +-
 arch/arm/mach-omap1/mailbox.c |    1 -
 2 files changed, 1 insertions(+), 2 deletions(-)

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
index caf889a..a4dd4c0 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -146,7 +146,6 @@ EXPORT_SYMBOL(mbox_dsp_info);
 static int __devinit omap1_mbox_probe(struct platform_device *pdev)
 {
 	struct resource *res;
-	int ret = 0;
 
 	if (pdev->num_resources != 2) {
 		dev_err(&pdev->dev, "invalid number of resources: %d\n",
-- 
1.6.6.35.g1d85d

