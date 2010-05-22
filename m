From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 10/14] omap: mailbox: reorganize registering
Date: Sat, 22 May 2010 20:14:21 +0300
Message-ID: <1274548465-20208-11-git-send-email-felipe.contreras@gmail.com>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57665 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755801Ab0EVROy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 May 2010 13:14:54 -0400
Received: by mail-bw0-f46.google.com with SMTP id 7so383738bwz.19
        for <linux-omap@vger.kernel.org>; Sat, 22 May 2010 10:14:53 -0700 (PDT)
In-Reply-To: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Felipe Contreras <felipe.contreras@gmail.com>

It's more extensible this way.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap1/mailbox.c |   41 +++++++++-------
 arch/arm/mach-omap2/mailbox.c |  106 +++++++++++++++++------------------------
 2 files changed, 66 insertions(+), 81 deletions(-)

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index 590ac66..38c21a2 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -29,6 +29,8 @@
 
 static void __iomem *mbox_base;
 
+static struct omap_mbox **list;
+
 struct omap_mbox1_fifo {
 	unsigned long cmd;
 	unsigned long data;
@@ -142,44 +144,45 @@ struct omap_mbox mbox_dsp_info = {
 	.priv	= &omap1_mbox_dsp_priv,
 };
 
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
+
+	list = omap1_mboxes;
 
-	mbox_base = ioremap(res->start, resource_size(res));
+	list[0]->irq = platform_get_irq_byname(pdev, "dsp");
+
+	mbox_base = ioremap(res[0].start, resource_size(&res[0]));
 	if (!mbox_base)
 		return -ENOMEM;
 
-	/* DSP IRQ */
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (unlikely(!res)) {
-		dev_err(&pdev->dev, "invalid irq resource\n");
-		ret = -ENODEV;
-		goto err_out;
+	for (i = 0; list[i]; i++) {
+		ret = omap_mbox_register(&pdev->dev, list[i]);
+		if (ret)
+			goto err_out;
 	}
-	mbox_dsp_info.irq = res->start;
-
-	ret = omap_mbox_register(&pdev->dev, &mbox_dsp_info);
-	if (ret)
-		goto err_out;
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
index 3ff1ad5..f55fa84 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -56,6 +56,8 @@
 
 static void __iomem *mbox_base;
 
+static struct omap_mbox **list;
+
 struct omap_mbox2_fifo {
 	unsigned long msg;
 	unsigned long fifo_stat;
@@ -307,6 +309,8 @@ struct omap_mbox mbox_dsp_info = {
 	.priv	= &omap2_mbox_dsp_priv,
 };
 
+struct omap_mbox *omap3_mboxes[] = { &mbox_dsp_info, NULL };
+
 #if defined(CONFIG_ARCH_OMAP2420)
 
 /* IVA */
@@ -331,6 +335,8 @@ static struct omap_mbox mbox_iva_info = {
 	.ops	= &omap2_mbox_ops,
 	.priv	= &omap2_mbox_iva_priv,
 };
+
+struct omap_mbox *omap2_mboxes[] = { &mbox_iva_info, &mbox_dsp_info, NULL };
 #endif
 
 /* OMAP4 */
@@ -378,89 +384,65 @@ struct omap_mbox mbox_2_info = {
 	.priv	= &omap2_mbox_2_priv,
 };
 
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
-	if (!mbox_base)
-		return -ENOMEM;
+	res = pdev->resource;
 
-	/* DSP or IVA2 IRQ */
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (cpu_is_omap3430()) {
+		list = omap3_mboxes;
 
-	if (unlikely(!res)) {
-		dev_err(&pdev->dev, "invalid irq resource\n");
-		ret = -ENODEV;
-		goto err_dsp;
+		list[0]->irq = platform_get_irq_byname(pdev, "dsp");
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
+		list[0]->irq = platform_get_irq_byname(pdev, "dsp");
+		list[1]->irq = platform_get_irq_byname(pdev, "iva");
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
+		list[0]->irq = list[1]->irq =
+			platform_get_irq_byname(pdev, "mbox");
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
+	mbox_base = ioremap(res[0].start, resource_size(&res[0]));
+	if (!mbox_base)
+		return -ENOMEM;
 
-err_dsp:
+	for (i = 0; list[i]; i++) {
+		ret = omap_mbox_register(&pdev->dev, list[i]);
+		if (ret)
+			goto err_out;
+	}
+	return 0;
+
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

