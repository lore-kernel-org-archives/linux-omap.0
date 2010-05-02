From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 4/8] omap: mailbox: reorganize omap2 registering
Date: Mon,  3 May 2010 02:59:54 +0300
Message-ID: <1272844798-25330-5-git-send-email-felipe.contreras@gmail.com>
References: <1272844798-25330-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:64079 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604Ab0ECAA0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 May 2010 20:00:26 -0400
Received: by mail-bw0-f219.google.com with SMTP id 19so1032679bwz.21
        for <linux-omap@vger.kernel.org>; Sun, 02 May 2010 17:00:25 -0700 (PDT)
In-Reply-To: <1272844798-25330-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>, Felipe Contreras <felipe.contreras@gmail.com>

The omap_mbox_list structure will allow us to split the actual
registers.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap2/mailbox.c |  100 ++++++++++++++++++++---------------------
 1 files changed, 49 insertions(+), 51 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index a328664..8603464 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -70,6 +70,13 @@ struct omap_mbox2_priv {
 	unsigned long irqdisable;
 };
 
+struct omap_mbox_list {
+	unsigned num;
+	struct omap_mbox **mbox;
+};
+
+struct omap_mbox_list list;
+
 static struct clk *mbox_ick_handle;
 
 static void omap2_mbox_enable_irq(struct omap_mbox *mbox,
@@ -287,6 +294,8 @@ struct omap_mbox mbox_dsp_info = {
 };
 EXPORT_SYMBOL(mbox_dsp_info);
 
+struct omap_mbox *omap3_mboxes[] = { &mbox_dsp_info };
+
 /* IVA */
 static struct omap_mbox2_priv omap2_mbox_iva_priv = {
 	.tx_fifo = {
@@ -310,6 +319,8 @@ static struct omap_mbox mbox_iva_info = {
 	.priv	= &omap2_mbox_iva_priv,
 };
 
+struct omap_mbox *omap2_mboxes[] = { &mbox_iva_info, &mbox_dsp_info };
+
 /* OMAP4 */
 static struct omap_mbox2_priv omap2_mbox_1_priv = {
 	.tx_fifo = {
@@ -357,80 +368,67 @@ struct omap_mbox mbox_2_info = {
 };
 EXPORT_SYMBOL(mbox_2_info);
 
+struct omap_mbox *omap4_mboxes[] = { &mbox_1_info, &mbox_2_info };
+
 static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	int ret;
+	int i;
+
+	res = pdev->resource;
 
-	/* MBOX base */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (unlikely(!res)) {
-		dev_err(&pdev->dev, "invalid mem resource\n");
-		return -ENODEV;
-	}
 	mbox_base = ioremap(res->start, resource_size(res));
 	if (!mbox_base)
 		return -ENOMEM;
 
-	/* DSP or IVA2 IRQ */
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (cpu_is_omap3430()) {
+		list.num = ARRAY_SIZE(omap3_mboxes);
+		list.mbox = omap3_mboxes;
 
-	if (unlikely(!res)) {
-		dev_err(&pdev->dev, "invalid irq resource\n");
-		ret = -ENODEV;
-		goto err_dsp;
+		list.mbox[0]->irq = res[1].start;
 	}
-	if (cpu_is_omap44xx()) {
-		mbox_1_info.irq = res->start;
-		ret = omap_mbox_register(&pdev->dev, &mbox_1_info);
-	} else {
-		mbox_dsp_info.irq = res->start;
-		ret = omap_mbox_register(&pdev->dev, &mbox_dsp_info);
+	else if (cpu_is_omap2420()) {
+		list.num = ARRAY_SIZE(omap2_mboxes);
+		list.mbox = omap2_mboxes;
+
+		list.mbox[0]->irq = res[1].start;
+		list.mbox[1]->irq = res[2].start;
 	}
-	if (ret)
-		goto err_dsp;
-
-	if (cpu_is_omap44xx()) {
-		mbox_2_info.irq = res->start;
-		ret = omap_mbox_register(&pdev->dev, &mbox_2_info);
-		if (ret) {
-			omap_mbox_unregister(&mbox_1_info);
-			goto err_dsp;
-		}
+	else if (cpu_is_omap44xx()) {
+		list.num = ARRAY_SIZE(omap4_mboxes);
+		list.mbox = omap4_mboxes;
+
+		list.mbox[0]->irq = res[1].start;
+		list.mbox[1]->irq = res[1].start;
 	}
-	if (cpu_is_omap2420()) {
-		/* IVA IRQ */
-		res = platform_get_resource(pdev, IORESOURCE_IRQ, 1);
-		if (unlikely(!res)) {
-			dev_err(&pdev->dev, "invalid irq resource\n");
-			ret = -ENODEV;
-			goto err_iva1;
-		}
-		mbox_iva_info.irq = res->start;
-		ret = omap_mbox_register(&pdev->dev, &mbox_iva_info);
+	else {
+		pr_err("%s: platform not supported\n", __func__);
+		return -ENODEV;
+	}
+
+	for (i = 0; i < list.num; i++) {
+		struct omap_mbox *mbox = list.mbox[i];
+		ret = omap_mbox_register(&pdev->dev, mbox);
 		if (ret)
-			goto err_iva1;
+			goto err_out;
 	}
 	return 0;
 
-err_iva1:
-	omap_mbox_unregister(&mbox_dsp_info);
-
-err_dsp:
+err_out:
+	while (i--)
+		omap_mbox_unregister(list.mbox[i]);
 	iounmap(mbox_base);
 	return ret;
 }
 
 static int __devexit omap2_mbox_remove(struct platform_device *pdev)
 {
-	if (cpu_is_omap2420())
-		omap_mbox_unregister(&mbox_iva_info);
-
-	if (cpu_is_omap44xx()) {
-		omap_mbox_unregister(&mbox_2_info);
-		omap_mbox_unregister(&mbox_1_info);
-	} else
-		omap_mbox_unregister(&mbox_dsp_info);
+	int i;
+
+	for (i = 0; i < list.num; i++)
+		omap_mbox_unregister(list.mbox[i]);
+
 	iounmap(mbox_base);
 	return 0;
 }
-- 
1.7.1

