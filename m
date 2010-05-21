From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2t2 06/17] omap: mailbox: update omap1 probing
Date: Sat, 22 May 2010 00:44:38 +0300
Message-ID: <1274478289-22188-7-git-send-email-felipe.contreras@gmail.com>
References: <1274478289-22188-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40510 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390Ab0EUVpH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 May 2010 17:45:07 -0400
Received: by mail-fx0-f46.google.com with SMTP id 5so1251271fxm.19
        for <linux-omap@vger.kernel.org>; Fri, 21 May 2010 14:45:06 -0700 (PDT)
In-Reply-To: <1274478289-22188-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Felipe Contreras <felipe.contreras@gmail.com>

Based on omap2 code.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap1/mailbox.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index 15bf2a2..211b9fc 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -146,12 +146,7 @@ EXPORT_SYMBOL(mbox_dsp_info);
 static int __devinit omap1_mbox_probe(struct platform_device *pdev)
 {
 	struct resource *res;
-
-	if (pdev->num_resources != 2) {
-		dev_err(&pdev->dev, "invalid number of resources: %d\n",
-			pdev->num_resources);
-		return -ENODEV;
-	}
+	int ret;
 
 	/* MBOX base */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -161,27 +156,32 @@ static int __devinit omap1_mbox_probe(struct platform_device *pdev)
 	}
 
 	mbox_base = ioremap(res->start, resource_size(res));
-	if (!mbox_base) {
-		dev_err(&pdev->dev, "ioremap failed\n");
-		return -ENODEV;
-	}
+	if (!mbox_base)
+		return -ENOMEM;
 
 	/* DSP IRQ */
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (unlikely(!res)) {
 		dev_err(&pdev->dev, "invalid irq resource\n");
-		iounmap(mbox_base);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_out;
 	}
 	mbox_dsp_info.irq = res->start;
 
-	return omap_mbox_register(&pdev->dev, &mbox_dsp_info);
+	ret = omap_mbox_register(&pdev->dev, &mbox_dsp_info);
+	if (ret)
+		goto err_out;
+	return 0;
+
+err_out:
+	iounmap(mbox_base);
+	return ret;
 }
 
 static int __devexit omap1_mbox_remove(struct platform_device *pdev)
 {
 	omap_mbox_unregister(&mbox_dsp_info);
-
+	iounmap(mbox_base);
 	return 0;
 }
 
-- 
1.7.1

