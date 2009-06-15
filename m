From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/1] omap mailbox: platform_get_irq() error ignored
Date: Mon, 15 Jun 2009 12:25:33 +0300
Message-ID: <1245057933-21380-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:24868 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbZFOJZo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Jun 2009 05:25:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ext Roel Kluin <roel.kluin@gmail.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: ext Roel Kluin <roel.kluin@gmail.com>

platform_get_irq may return -ENXIO. but struct omap_mbox mbox_dsp_info.irq
is unsigned, so the error was not noticed.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/mailbox.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index fd5b8a5..6f71f37 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -282,12 +282,12 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* DSP or IVA2 IRQ */
-	mbox_dsp_info.irq = platform_get_irq(pdev, 0);
-	if (mbox_dsp_info.irq < 0) {
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0) {
 		dev_err(&pdev->dev, "invalid irq resource\n");
-		ret = -ENODEV;
 		goto err_dsp;
 	}
+	mbox_dsp_info.irq = ret;
 
 	ret = omap_mbox_register(&pdev->dev, &mbox_dsp_info);
 	if (ret)
-- 
1.6.0.4

