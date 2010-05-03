From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 6/8] omap: mailbox: more more stuff to omap2_mbox_init
Date: Mon,  3 May 2010 03:02:45 +0300
Message-ID: <1272844967-25441-2-git-send-email-felipe.contreras@gmail.com>
References: <1272844798-25330-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:51880 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604Ab0ECADG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 May 2010 20:03:06 -0400
Received: by mail-bw0-f219.google.com with SMTP id 19so1033152bwz.21
        for <linux-omap@vger.kernel.org>; Sun, 02 May 2010 17:03:06 -0700 (PDT)
In-Reply-To: <1272844798-25330-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>, Felipe Contreras <felipe.contreras@gmail.com>

Will be needed to split the platform_driver.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap2/mailbox.c |   49 ++++++++++++++++++----------------------
 1 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index e9a803c..474c1e7 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -418,31 +418,6 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 
 	res = pdev->resource;
 
-	mbox_base = ioremap(res->start, resource_size(res));
-	if (!mbox_base)
-		return -ENOMEM;
-
-	if (cpu_is_omap3430()) {
-		list.num = ARRAY_SIZE(omap3_mboxes);
-		list.mbox = omap3_mboxes;
-
-		list.mbox[0]->irq = res[1].start;
-	}
-	else if (cpu_is_omap2420()) {
-		list.num = ARRAY_SIZE(omap2_mboxes);
-		list.mbox = omap2_mboxes;
-
-		list.mbox[0]->irq = res[1].start;
-		list.mbox[1]->irq = res[2].start;
-	}
-	else if (cpu_is_omap44xx()) {
-		list.num = ARRAY_SIZE(omap4_mboxes);
-		list.mbox = omap4_mboxes;
-
-		list.mbox[0]->irq = res[1].start;
-		list.mbox[1]->irq = res[1].start;
-	}
-
 	for (i = 0; i < list.num; i++) {
 		struct omap_mbox *mbox = list.mbox[i];
 		ret = omap_mbox_register(&pdev->dev, mbox);
@@ -454,7 +429,6 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 err_out:
 	while (i--)
 		omap_mbox_unregister(list.mbox[i]);
-	iounmap(mbox_base);
 	return ret;
 }
 
@@ -465,7 +439,6 @@ static int __devexit omap2_mbox_remove(struct platform_device *pdev)
 	for (i = 0; i < list.num; i++)
 		omap_mbox_unregister(list.mbox[i]);
 
-	iounmap(mbox_base);
 	return 0;
 }
 
@@ -483,18 +456,33 @@ static int __init omap2_mbox_init(void)
 	struct platform_device *pdev;
 	struct resource *res;
 	unsigned num;
+	struct omap_mbox_list list;
 
 	if (cpu_is_omap3430()) {
 		res = omap3_mbox_resources;
 		num = ARRAY_SIZE(omap3_mbox_resources);
+		list.num = ARRAY_SIZE(omap3_mboxes);
+		list.mbox = omap3_mboxes;
+
+		list.mbox[0]->irq = res[1].start;
 	}
 	else if (cpu_is_omap2420()) {
 		res = omap2_mbox_resources;
 		num = ARRAY_SIZE(omap2_mbox_resources);
+		list.num = ARRAY_SIZE(omap2_mboxes);
+		list.mbox = omap2_mboxes;
+
+		list.mbox[0]->irq = res[1].start;
+		list.mbox[1]->irq = res[2].start;
 	}
 	else if (cpu_is_omap44xx()) {
 		res = omap4_mbox_resources;
 		num = ARRAY_SIZE(omap4_mbox_resources);
+		list.num = ARRAY_SIZE(omap4_mboxes);
+		list.mbox = omap4_mboxes;
+
+		list.mbox[0]->irq = res[1].start;
+		list.mbox[1]->irq = res[1].start;
 	}
 	else {
 		pr_err("%s: platform not supported\n", __func__);
@@ -515,6 +503,12 @@ static int __init omap2_mbox_init(void)
 	if (err)
 		goto err_out;
 
+	mbox_base = ioremap(res[0].start, resource_size(&res[0]));
+	if (!mbox_base) {
+		platform_device_put(pdev);
+		return -ENOMEM;
+	}
+
 	return platform_driver_register(&omap2_mbox_driver);
 
 err_out:
@@ -524,6 +518,7 @@ err_out:
 static void __exit omap2_mbox_exit(void)
 {
 	platform_driver_unregister(&omap2_mbox_driver);
+	iounmap(mbox_base);
 }
 
 module_init(omap2_mbox_init);
-- 
1.7.1

