From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 09/15] omap: mailbox: move more stuff to omap_mbox_init()
Date: Thu, 13 May 2010 20:47:30 +0300
Message-ID: <1273772856-10881-10-git-send-email-felipe.contreras@gmail.com>
References: <1273772856-10881-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:11171 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870Ab0EMRso (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 13:48:44 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2624632fgg.1
        for <linux-omap@vger.kernel.org>; Thu, 13 May 2010 10:48:44 -0700 (PDT)
In-Reply-To: <1273772856-10881-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>

Will be needed to split the platform_driver.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap1/mailbox.c |   23 ++++++++++--------
 arch/arm/mach-omap2/mailbox.c |   50 ++++++++++++++--------------------------
 2 files changed, 31 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index e28b226..d57fb5d 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -169,14 +169,6 @@ static int __devinit omap1_mbox_probe(struct platform_device *pdev)
 
 	res = pdev->resource;
 
-	mbox_base = ioremap(res[0].start, resource_size(&res[0]));
-	if (!mbox_base)
-		return -ENOMEM;
-
-	list = omap1_mboxes;
-
-	list[0]->irq = res[1].start;
-
 	for (i = 0; list[i]; i++) {
 		ret = omap_mbox_register(&pdev->dev, list[i]);
 		if (ret)
@@ -187,7 +179,6 @@ static int __devinit omap1_mbox_probe(struct platform_device *pdev)
 err_out:
 	while (i--)
 		omap_mbox_unregister(list[i]);
-	iounmap(mbox_base);
 	return ret;
 }
 
@@ -198,7 +189,6 @@ static int __devexit omap1_mbox_remove(struct platform_device *pdev)
 	for (i = 0; list[i]; i++)
 		omap_mbox_unregister(list[i]);
 
-	iounmap(mbox_base);
 	return 0;
 }
 
@@ -223,14 +213,20 @@ static int __init omap1_mbox_init(void)
 	else if (cpu_is_omap15xx()) {
 		res = omap1_mbox_resources;
 		num = ARRAY_SIZE(omap1_mbox_resources);
+		list = omap1_mboxes;
+
 		res[1].end += 0x23;
+		list[0]->irq = res[1].start;
 	}
 #endif
 #if defined(CONFIG_ARCH_OMAP16XX)
 	else if (cpu_is_omap16xx()) {
 		res = omap1_mbox_resources;
 		num = ARRAY_SIZE(omap1_mbox_resources);
+		list = omap1_mboxes;
+
 		res[1].end += 0x2f;
+		list[0]->irq = res[1].start;
 	}
 #endif
 	else {
@@ -252,6 +248,12 @@ static int __init omap1_mbox_init(void)
 	if (err)
 		goto err_out;
 
+	mbox_base = ioremap(res[0].start, resource_size(&res[0]));
+	if (!mbox_base) {
+		platform_device_put(pdev);
+		return -ENOMEM;
+	}
+
 	return platform_driver_register(&omap1_mbox_driver);
 
 err_out:
@@ -261,6 +263,7 @@ err_out:
 static void __exit omap1_mbox_exit(void)
 {
 	platform_driver_unregister(&omap1_mbox_driver);
+	iounmap(mbox_base);
 }
 
 module_init(omap1_mbox_init);
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 31a0659..cea18bc 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -427,36 +427,6 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 
 	res = pdev->resource;
 
-	mbox_base = ioremap(res[0].start, resource_size(&res[0]));
-	if (!mbox_base)
-		return -ENOMEM;
-
-	if (false) {
-	}
-#if defined(CONFIG_ARCH_OMAP3430)
-	else if (cpu_is_omap3430()) {
-		list = omap3_mboxes;
-
-		list[0]->irq = res[1].start;
-	}
-#endif
-#if defined(CONFIG_ARCH_OMAP2420)
-	else if (cpu_is_omap2420()) {
-		list = omap2_mboxes;
-
-		list[0]->irq = res[1].start;
-		list[1]->irq = res[2].start;
-	}
-#endif
-#if defined(CONFIG_ARCH_OMAP4)
-	else if (cpu_is_omap44xx()) {
-		list = omap4_mboxes;
-
-		list[0]->irq = res[1].start;
-		list[1]->irq = res[1].start;
-	}
-#endif
-
 	for (i = 0; list[i]; i++) {
 		ret = omap_mbox_register(&pdev->dev, list[i]);
 		if (ret)
@@ -467,7 +437,6 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 err_out:
 	while (i--)
 		omap_mbox_unregister(list[i]);
-	iounmap(mbox_base);
 	return ret;
 }
 
@@ -478,7 +447,6 @@ static int __devexit omap2_mbox_remove(struct platform_device *pdev)
 	for (i = 0; list[i]; i++)
 		omap_mbox_unregister(list[i]);
 
-	iounmap(mbox_base);
 	return 0;
 }
 
@@ -503,18 +471,29 @@ static int __init omap2_mbox_init(void)
 	else if (cpu_is_omap3430()) {
 		res = omap3_mbox_resources;
 		num = ARRAY_SIZE(omap3_mbox_resources);
+		list = omap3_mboxes;
+
+		list[0]->irq = res[1].start;
 	}
 #endif
 #if defined(CONFIG_ARCH_OMAP2420)
 	else if (cpu_is_omap2420()) {
 		res = omap2_mbox_resources;
 		num = ARRAY_SIZE(omap2_mbox_resources);
+		list = omap2_mboxes;
+
+		list[0]->irq = res[1].start;
+		list[1]->irq = res[2].start;
 	}
 #endif
 #if defined(CONFIG_ARCH_OMAP4)
 	else if (cpu_is_omap44xx()) {
 		res = omap4_mbox_resources;
 		num = ARRAY_SIZE(omap4_mbox_resources);
+		list = omap4_mboxes;
+
+		list[0]->irq = res[1].start;
+		list[1]->irq = res[1].start;
 	}
 #endif
 	else {
@@ -536,6 +515,12 @@ static int __init omap2_mbox_init(void)
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
@@ -545,6 +530,7 @@ err_out:
 static void __exit omap2_mbox_exit(void)
 {
 	platform_driver_unregister(&omap2_mbox_driver);
+	iounmap(mbox_base);
 }
 
 module_init(omap2_mbox_init);
-- 
1.7.1

