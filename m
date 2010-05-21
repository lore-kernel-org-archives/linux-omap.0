From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2t2 12/17] omap: mailbox: split platform driver
Date: Sat, 22 May 2010 00:44:44 +0300
Message-ID: <1274478289-22188-13-git-send-email-felipe.contreras@gmail.com>
References: <1274478289-22188-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48769 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754221Ab0EUVp3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 May 2010 17:45:29 -0400
Received: by mail-bw0-f46.google.com with SMTP id 7so202277bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 21 May 2010 14:45:28 -0700 (PDT)
In-Reply-To: <1274478289-22188-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Felipe Contreras <felipe.contreras@gmail.com>

This will allow the current 'mailbox_mach' to be built-in.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap1/mailbox.c             |   50 +++++------------------------
 arch/arm/mach-omap2/mailbox.c             |   50 +++++------------------------
 arch/arm/plat-omap/include/plat/mailbox.h |    4 ++
 arch/arm/plat-omap/mailbox.c              |   46 +++++++++++++++++++++++++-
 4 files changed, 64 insertions(+), 86 deletions(-)

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index 91780a0..f29ba8e 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -161,51 +161,13 @@ static struct resource omap1_mbox_resources[] = {
 };
 #endif
 
-static int __devinit omap1_mbox_probe(struct platform_device *pdev)
-{
-	struct resource *res;
-	int ret;
-	int i;
-
-	res = pdev->resource;
-
-	for (i = 0; list[i]; i++) {
-		ret = omap_mbox_register(&pdev->dev, list[i]);
-		if (ret)
-			goto err_out;
-	}
-	return 0;
-
-err_out:
-	while (i--)
-		omap_mbox_unregister(list[i]);
-	return ret;
-}
-
-static int __devexit omap1_mbox_remove(struct platform_device *pdev)
-{
-	int i;
-
-	for (i = 0; list[i]; i++)
-		omap_mbox_unregister(list[i]);
-
-	return 0;
-}
-
-static struct platform_driver omap1_mbox_driver = {
-	.probe	= omap1_mbox_probe,
-	.remove	= __devexit_p(omap1_mbox_remove),
-	.driver	= {
-		.name	= "omap1-mailbox",
-	},
-};
-
 static int __init omap1_mbox_init(void)
 {
 	int err;
 	struct platform_device *pdev;
 	struct resource *res;
 	unsigned num;
+	struct omap_mbox_platform_data pdata;
 
 	if (false);
 #if defined(CONFIG_ARCH_OMAP15XX)
@@ -233,7 +195,7 @@ static int __init omap1_mbox_init(void)
 		return -ENODEV;
 	}
 
-	pdev = platform_device_alloc("omap1-mailbox", -1);
+	pdev = platform_device_alloc("omap-mailbox", -1);
 	if (!pdev) {
 		err = -ENOMEM;
 		goto err_out;
@@ -243,6 +205,11 @@ static int __init omap1_mbox_init(void)
 	if (err)
 		goto err_out;
 
+	pdata.list = list;
+	err = platform_device_add_data(pdev, &pdata, sizeof(pdata));
+	if (err)
+		goto err_out;
+
 	err = platform_device_add(pdev);
 	if (err)
 		goto err_out;
@@ -253,7 +220,7 @@ static int __init omap1_mbox_init(void)
 		return -ENOMEM;
 	}
 
-	return platform_driver_register(&omap1_mbox_driver);
+	return 0;
 
 err_out:
 	return err;
@@ -261,7 +228,6 @@ err_out:
 
 static void __exit omap1_mbox_exit(void)
 {
-	platform_driver_unregister(&omap1_mbox_driver);
 	iounmap(mbox_base);
 }
 
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index adbf5d7..a54898a 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -438,51 +438,13 @@ static struct resource omap4_mbox_resources[] = {
 };
 #endif
 
-static int __devinit omap2_mbox_probe(struct platform_device *pdev)
-{
-	struct resource *res;
-	int ret;
-	int i;
-
-	res = pdev->resource;
-
-	for (i = 0; list[i]; i++) {
-		ret = omap_mbox_register(&pdev->dev, list[i]);
-		if (ret)
-			goto err_out;
-	}
-	return 0;
-
-err_out:
-	while (i--)
-		omap_mbox_unregister(list[i]);
-	return ret;
-}
-
-static int __devexit omap2_mbox_remove(struct platform_device *pdev)
-{
-	int i;
-
-	for (i = 0; list[i]; i++)
-		omap_mbox_unregister(list[i]);
-
-	return 0;
-}
-
-static struct platform_driver omap2_mbox_driver = {
-	.probe = omap2_mbox_probe,
-	.remove = __devexit_p(omap2_mbox_remove),
-	.driver = {
-		.name = "omap2-mailbox",
-	},
-};
-
 static int __init omap2_mbox_init(void)
 {
 	int err;
 	struct platform_device *pdev;
 	struct resource *res;
 	unsigned num;
+	struct omap_mbox_platform_data pdata;
 
 	if (false);
 #if defined(CONFIG_ARCH_OMAP3430)
@@ -519,7 +481,7 @@ static int __init omap2_mbox_init(void)
 		return -ENODEV;
 	}
 
-	pdev = platform_device_alloc("omap2-mailbox", -1);
+	pdev = platform_device_alloc("omap-mailbox", -1);
 	if (!pdev) {
 		err = -ENOMEM;
 		goto err_out;
@@ -529,6 +491,11 @@ static int __init omap2_mbox_init(void)
 	if (err)
 		goto err_out;
 
+	pdata.list = list;
+	err = platform_device_add_data(pdev, &pdata, sizeof(pdata));
+	if (err)
+		goto err_out;
+
 	err = platform_device_add(pdev);
 	if (err)
 		goto err_out;
@@ -539,7 +506,7 @@ static int __init omap2_mbox_init(void)
 		return -ENOMEM;
 	}
 
-	return platform_driver_register(&omap2_mbox_driver);
+	return 0;
 
 err_out:
 	return err;
@@ -547,7 +514,6 @@ err_out:
 
 static void __exit omap2_mbox_exit(void)
 {
-	platform_driver_unregister(&omap2_mbox_driver);
 	iounmap(mbox_base);
 }
 
diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
index 0c3c4a5..b68fdc3 100644
--- a/arch/arm/plat-omap/include/plat/mailbox.h
+++ b/arch/arm/plat-omap/include/plat/mailbox.h
@@ -67,6 +67,10 @@ struct omap_mbox {
 	void			(*err_notify)(void);
 };
 
+struct omap_mbox_platform_data {
+	struct omap_mbox **list;
+};
+
 int omap_mbox_msg_send(struct omap_mbox *, mbox_msg_t msg);
 void omap_mbox_init_seq(struct omap_mbox *);
 
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 7877bbb..8fbf364 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -29,6 +29,7 @@
 #include <linux/slab.h>
 #include <linux/kfifo.h>
 #include <linux/err.h>
+#include <linux/platform_device.h>
 
 #include <plat/mailbox.h>
 
@@ -403,6 +404,47 @@ int omap_mbox_unregister(struct omap_mbox *mbox)
 }
 EXPORT_SYMBOL(omap_mbox_unregister);
 
+static int __devinit omap_mbox_probe(struct platform_device *pdev)
+{
+	struct omap_mbox_platform_data *pdata = pdev->dev.platform_data;
+	struct resource *res;
+	int ret;
+	int i;
+
+	res = pdev->resource;
+
+	for (i = 0; pdata->list[i]; i++) {
+		ret = omap_mbox_register(&pdev->dev, pdata->list[i]);
+		if (ret)
+			goto err_out;
+	}
+	return 0;
+
+err_out:
+	while (i--)
+		omap_mbox_unregister(pdata->list[i]);
+	return ret;
+}
+
+static int __devexit omap_mbox_remove(struct platform_device *pdev)
+{
+	struct omap_mbox_platform_data *pdata = pdev->dev.platform_data;
+	int i;
+
+	for (i = 0; pdata->list[i]; i++)
+		omap_mbox_unregister(pdata->list[i]);
+
+	return 0;
+}
+
+static struct platform_driver omap_mbox_driver = {
+	.probe = omap_mbox_probe,
+	.remove = __devexit_p(omap_mbox_remove),
+	.driver = {
+		.name = "omap-mailbox",
+	},
+};
+
 static int __init omap_mbox_init(void)
 {
  	int err;
@@ -418,13 +460,13 @@ static int __init omap_mbox_init(void)
 	/* kfifo size sanity check: alignment and minimal size */
 	mbox_kfifo_size = ALIGN(mbox_kfifo_size, sizeof(mbox_msg_t));
 	mbox_kfifo_size = max_t(unsigned int, mbox_kfifo_size, sizeof(mbox_msg_t));
-
-	return 0;
+	return platform_driver_register(&omap_mbox_driver);
 }
 subsys_initcall(omap_mbox_init);
 
 static void __exit omap_mbox_exit(void)
 {
+	platform_driver_unregister(&omap_mbox_driver);
 	destroy_workqueue(mboxd);
  	class_unregister(&omap_mbox_class);
 }
-- 
1.7.1

