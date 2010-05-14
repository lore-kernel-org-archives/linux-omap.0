From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 07/17] omap: mailbox: reorganize registering
Date: Fri, 14 May 2010 18:01:40 +0300
Message-ID: <1273849310-32169-8-git-send-email-felipe.contreras@gmail.com>
References: <1273849310-32169-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:44846 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755373Ab0ENPCR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 11:02:17 -0400
Received: by mail-ew0-f216.google.com with SMTP id 8so902320ewy.28
        for <linux-omap@vger.kernel.org>; Fri, 14 May 2010 08:02:17 -0700 (PDT)
In-Reply-To: <1273849310-32169-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>

This is a step forward to split the mbox registers.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap1/mailbox.c |   41 +++++++++--------
 arch/arm/mach-omap2/mailbox.c |  102 +++++++++++++++++------------------------
 2 files changed, 64 insertions(+), 79 deletions(-)

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index 211b9fc..d81b238 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -29,6 +29,8 @@
 
 static void __iomem *mbox_base;
 
+static struct omap_mbox **list;
+
 struct omap_mbox1_fifo {
 	unsigned long cmd;
 	unsigned long data;
@@ -143,44 +145,45 @@ struct omap_mbox mbox_dsp_info = {
 };
 EXPORT_SYMBOL(mbox_dsp_info);
 
+struct omap_mbox *omap1_mboxes[] = { &mbox_dsp_info, NULL };
+
 static int __devinit omap1_mbox_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	int ret;
+	int i;
 
-	/* MBOX base */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (unlikely(!res)) {
-		dev_err(&pdev->dev, "invalid mem resource\n");
-		return -ENODEV;
-	}
+	res = pdev->resource;
 
-	mbox_base = ioremap(res->start, resource_size(res));
+	mbox_base = ioremap(res[0].start, resource_size(&res[0]));
 	if (!mbox_base)
 		return -ENOMEM;
 
-	/* DSP IRQ */
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (unlikely(!res)) {
-		dev_err(&pdev->dev, "invalid irq resource\n");
-		ret = -ENODEV;
-		goto err_out;
-	}
-	mbox_dsp_info.irq = res->start;
+	list = omap1_mboxes;
 
-	ret = omap_mbox_register(&pdev->dev, &mbox_dsp_info);
-	if (ret)
-		goto err_out;
+	list[0]->irq = res[1].start;
+
+	for (i = 0; list[i]; i++) {
+		ret = omap_mbox_register(&pdev->dev, list[i]);
+		if (ret)
+			goto err_out;
+	}
 	return 0;
 
 err_out:
+	while (i--)
+		omap_mbox_unregister(list[i]);
 	iounmap(mbox_base);
 	return ret;
 }
 
 static int __devexit omap1_mbox_remove(struct platform_device *pdev)
 {
-	omap_mbox_unregister(&mbox_dsp_info);
+	int i;
+
+	for (i = 0; list[i]; i++)
+		omap_mbox_unregister(list[i]);
+
 	iounmap(mbox_base);
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 7afc9aa..5dda11c 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -56,6 +56,8 @@
 
 static void __iomem *mbox_base;
 
+static struct omap_mbox **list;
+
 struct omap_mbox2_fifo {
 	unsigned long msg;
 	unsigned long fifo_stat;
@@ -308,6 +310,8 @@ struct omap_mbox mbox_dsp_info = {
 };
 EXPORT_SYMBOL(mbox_dsp_info);
 
+struct omap_mbox *omap3_mboxes[] = { &mbox_dsp_info, NULL };
+
 #if defined(CONFIG_ARCH_OMAP2420)
 
 /* IVA */
@@ -332,6 +336,8 @@ static struct omap_mbox mbox_iva_info = {
 	.ops	= &omap2_mbox_ops,
 	.priv	= &omap2_mbox_iva_priv,
 };
+
+struct omap_mbox *omap2_mboxes[] = { &mbox_iva_info, &mbox_dsp_info, NULL };
 #endif
 
 /* OMAP4 */
@@ -381,89 +387,65 @@ struct omap_mbox mbox_2_info = {
 };
 EXPORT_SYMBOL(mbox_2_info);
 
+struct omap_mbox *omap4_mboxes[] = { &mbox_1_info, &mbox_2_info, NULL };
+
 static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	int ret;
+	int i;
 
-	/* MBOX base */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (unlikely(!res)) {
-		dev_err(&pdev->dev, "invalid mem resource\n");
-		return -ENODEV;
-	}
-	mbox_base = ioremap(res->start, resource_size(res));
+	res = pdev->resource;
+
+	mbox_base = ioremap(res[0].start, resource_size(&res[0]));
 	if (!mbox_base)
 		return -ENOMEM;
 
-	/* DSP or IVA2 IRQ */
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (cpu_is_omap3430()) {
+		list = omap3_mboxes;
 
-	if (unlikely(!res)) {
-		dev_err(&pdev->dev, "invalid irq resource\n");
-		ret = -ENODEV;
-		goto err_dsp;
+		list[0]->irq = res[1].start;
 	}
-	if (cpu_is_omap44xx()) {
-		mbox_1_info.irq = res->start;
-		ret = omap_mbox_register(&pdev->dev, &mbox_1_info);
-	} else {
-		mbox_dsp_info.irq = res->start;
-		ret = omap_mbox_register(&pdev->dev, &mbox_dsp_info);
+#if defined(CONFIG_ARCH_OMAP2420)
+	else if (cpu_is_omap2420()) {
+		list = omap2_mboxes;
+
+		list[0]->irq = res[1].start;
+		list[1]->irq = res[2].start;
 	}
-	if (ret)
-		goto err_dsp;
+#endif
+	else if (cpu_is_omap44xx()) {
+		list = omap4_mboxes;
 
-	if (cpu_is_omap44xx()) {
-		mbox_2_info.irq = res->start;
-		ret = omap_mbox_register(&pdev->dev, &mbox_2_info);
-		if (ret) {
-			omap_mbox_unregister(&mbox_1_info);
-			goto err_dsp;
-		}
+		list[0]->irq = res[1].start;
+		list[1]->irq = res[1].start;
 	}
-#if defined(CONFIG_ARCH_OMAP2420) /* IVA */
-	if (cpu_is_omap2420()) {
-		/* IVA IRQ */
-		res = platform_get_resource(pdev, IORESOURCE_IRQ, 1);
-		if (unlikely(!res)) {
-			dev_err(&pdev->dev, "invalid irq resource\n");
-			ret = -ENODEV;
-			omap_mbox_unregister(&mbox_dsp_info);
-			goto err_dsp;
-		}
-		mbox_iva_info.irq = res->start;
-		ret = omap_mbox_register(&pdev->dev, &mbox_iva_info);
-		if (ret) {
-			omap_mbox_unregister(&mbox_dsp_info);
-			goto err_dsp;
-		}
+	else {
+		pr_err("%s: platform not supported\n", __func__);
+		return -ENODEV;
 	}
-#endif
-	return 0;
 
-#if defined(CONFIG_ARCH_OMAP2420) /* IVA */
-err_iva1:
-	omap_mbox_unregister(&mbox_dsp_info);
-#endif
+	for (i = 0; list[i]; i++) {
+		ret = omap_mbox_register(&pdev->dev, list[i]);
+		if (ret)
+			goto err_out;
+	}
+	return 0;
 
-err_dsp:
+err_out:
+	while (i--)
+		omap_mbox_unregister(list[i]);
 	iounmap(mbox_base);
 	return ret;
 }
 
 static int __devexit omap2_mbox_remove(struct platform_device *pdev)
 {
-#if defined(CONFIG_ARCH_OMAP2420)
-	if (cpu_is_omap2420())
-		omap_mbox_unregister(&mbox_iva_info);
-#endif
+	int i;
+
+	for (i = 0; list[i]; i++)
+		omap_mbox_unregister(list[i]);
 
-	if (cpu_is_omap44xx()) {
-		omap_mbox_unregister(&mbox_2_info);
-		omap_mbox_unregister(&mbox_1_info);
-	} else
-		omap_mbox_unregister(&mbox_dsp_info);
 	iounmap(mbox_base);
 	return 0;
 }
-- 
1.7.1

