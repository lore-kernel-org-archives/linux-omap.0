From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 7/8] omap: mailbox: split platform_driver
Date: Mon,  3 May 2010 03:02:46 +0300
Message-ID: <1272844967-25441-3-git-send-email-felipe.contreras@gmail.com>
References: <1272844798-25330-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:51880 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604Ab0ECADQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 May 2010 20:03:16 -0400
Received: by mail-bw0-f219.google.com with SMTP id 19so1033152bwz.21
        for <linux-omap@vger.kernel.org>; Sun, 02 May 2010 17:03:15 -0700 (PDT)
In-Reply-To: <1272844798-25330-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>, Felipe Contreras <felipe.contreras@gmail.com>

Only OMAP2+ for now.

This would allow the current 'mailbox_mach' to be built-in.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap2/mailbox.c             |   60 +++-------------------------
 arch/arm/plat-omap/include/plat/mailbox.h |    5 ++
 arch/arm/plat-omap/mailbox.c              |   43 ++++++++++++++++++++-
 3 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 474c1e7..5adac95 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -18,8 +18,6 @@
 #include <plat/mailbox.h>
 #include <mach/irqs.h>
 
-#define DRV_NAME "omap2-mailbox"
-
 #define MAILBOX_REVISION		0x000
 #define MAILBOX_SYSCONFIG		0x010
 #define MAILBOX_SYSSTATUS		0x014
@@ -70,13 +68,6 @@ struct omap_mbox2_priv {
 	unsigned long irqdisable;
 };
 
-struct omap_mbox_list {
-	unsigned num;
-	struct omap_mbox **mbox;
-};
-
-struct omap_mbox_list list;
-
 static struct clk *mbox_ick_handle;
 
 static void omap2_mbox_enable_irq(struct omap_mbox *mbox,
@@ -410,46 +401,6 @@ static struct resource omap4_mbox_resources[] = {
 	},
 };
 
-static int __devinit omap2_mbox_probe(struct platform_device *pdev)
-{
-	struct resource *res;
-	int ret;
-	int i;
-
-	res = pdev->resource;
-
-	for (i = 0; i < list.num; i++) {
-		struct omap_mbox *mbox = list.mbox[i];
-		ret = omap_mbox_register(&pdev->dev, mbox);
-		if (ret)
-			goto err_out;
-	}
-	return 0;
-
-err_out:
-	while (i--)
-		omap_mbox_unregister(list.mbox[i]);
-	return ret;
-}
-
-static int __devexit omap2_mbox_remove(struct platform_device *pdev)
-{
-	int i;
-
-	for (i = 0; i < list.num; i++)
-		omap_mbox_unregister(list.mbox[i]);
-
-	return 0;
-}
-
-static struct platform_driver omap2_mbox_driver = {
-	.probe = omap2_mbox_probe,
-	.remove = __devexit_p(omap2_mbox_remove),
-	.driver = {
-		.name = DRV_NAME,
-	},
-};
-
 static int __init omap2_mbox_init(void)
 {
 	int err;
@@ -489,7 +440,7 @@ static int __init omap2_mbox_init(void)
 		return -ENODEV;
 	}
 
-	pdev = platform_device_alloc("omap2-mailbox", -1);
+	pdev = platform_device_alloc("omap-mailbox", -1);
 	if (!pdev) {
 		err = -ENOMEM;
 		goto err_out;
@@ -499,6 +450,10 @@ static int __init omap2_mbox_init(void)
 	if (err)
 		goto err_out;
 
+	err = platform_device_add_data(pdev, &list, sizeof(list));
+	if (err)
+		goto err_out;
+
 	err = platform_device_add(pdev);
 	if (err)
 		goto err_out;
@@ -509,7 +464,7 @@ static int __init omap2_mbox_init(void)
 		return -ENOMEM;
 	}
 
-	return platform_driver_register(&omap2_mbox_driver);
+	return 0;
 
 err_out:
 	return err;
@@ -517,7 +472,6 @@ err_out:
 
 static void __exit omap2_mbox_exit(void)
 {
-	platform_driver_unregister(&omap2_mbox_driver);
 	iounmap(mbox_base);
 }
 
@@ -527,4 +481,4 @@ module_exit(omap2_mbox_exit);
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("omap mailbox: omap2/3/4 architecture specific functions");
 MODULE_AUTHOR("Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Paul Mundt");
-MODULE_ALIAS("platform:"DRV_NAME);
+MODULE_ALIAS("platform:omap2-mailbox");
diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
index 729166b..f8ac2ca 100644
--- a/arch/arm/plat-omap/include/plat/mailbox.h
+++ b/arch/arm/plat-omap/include/plat/mailbox.h
@@ -67,6 +67,11 @@ struct omap_mbox {
 	void			(*err_notify)(void);
 };
 
+struct omap_mbox_list {
+	unsigned num;
+	struct omap_mbox **mbox;
+};
+
 int omap_mbox_msg_send(struct omap_mbox *, mbox_msg_t msg);
 void omap_mbox_init_seq(struct omap_mbox *);
 
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 822c377..22cdc79 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -25,6 +25,7 @@
 #include <linux/interrupt.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/platform_device.h>
 
 #include <plat/mailbox.h>
 
@@ -408,14 +409,54 @@ int omap_mbox_unregister(struct omap_mbox *mbox)
 }
 EXPORT_SYMBOL(omap_mbox_unregister);
 
-static int __init omap_mbox_init(void)
+static int __devinit omap_mbox_probe(struct platform_device *pdev)
 {
+	struct omap_mbox_list *list = pdev->dev.platform_data;
+	int ret;
+	int i;
+
+	for (i = 0; i < list->num; i++) {
+		struct omap_mbox *mbox = list->mbox[i];
+		ret = omap_mbox_register(&pdev->dev, mbox);
+		if (ret)
+			goto err_out;
+	}
 	return 0;
+
+err_out:
+	while (i--)
+		omap_mbox_unregister(list->mbox[i]);
+	return ret;
+}
+
+static int __devexit omap_mbox_remove(struct platform_device *pdev)
+{
+	struct omap_mbox_list *list = pdev->dev.platform_data;
+	int i;
+
+	for (i = 0; i < list->num; i++)
+		omap_mbox_unregister(list->mbox[i]);
+
+	return 0;
+}
+
+static struct platform_driver omap_mbox_driver = {
+	.probe	= omap_mbox_probe,
+	.remove	= __devexit_p(omap_mbox_remove),
+	.driver	= {
+		.name	= "omap-mailbox",
+	},
+};
+
+static int __init omap_mbox_init(void)
+{
+	return platform_driver_register(&omap_mbox_driver);
 }
 module_init(omap_mbox_init);
 
 static void __exit omap_mbox_exit(void)
 {
+	platform_driver_unregister(&omap_mbox_driver);
 }
 module_exit(omap_mbox_exit);
 
-- 
1.7.1

