From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 2/2] arm: omap1: mailbox: kill compile warning
Date: Tue, 22 Dec 2009 22:15:55 +0200
Message-ID: <1261512955-19437-3-git-send-email-felipe.balbi@nokia.com>
References: <1261512955-19437-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:52262 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002AbZLVUR3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Dec 2009 15:17:29 -0500
In-Reply-To: <1261512955-19437-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Balbi <felipe.balbi@nokia.com>

remove unused variable and kill compile warning.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap1/mailbox.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index 38a7d2c..3fcce3d 100644
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
1.6.6.rc0

