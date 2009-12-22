From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 1/2] arm: omap1: mailbox: kill compile warning
Date: Tue, 22 Dec 2009 22:15:54 +0200
Message-ID: <1261512955-19437-2-git-send-email-felipe.balbi@nokia.com>
References: <1261512955-19437-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:58392 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbZLVUTV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Dec 2009 15:19:21 -0500
In-Reply-To: <1261512955-19437-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Balbi <felipe.balbi@nokia.com>

use ioremap to get the virtual address and
avoid a compile warning.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap1/mailbox.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index caf889a..38a7d2c 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -160,7 +160,12 @@ static int __devinit omap1_mbox_probe(struct platform_device *pdev)
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
-- 
1.6.6.rc0

