From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 11/15] omap: mailbox: split platform driver
Date: Thu, 13 May 2010 20:47:32 +0300
Message-ID: <1273772856-10881-12-git-send-email-felipe.contreras@gmail.com>
References: <1273772856-10881-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:11171 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758639Ab0EMRsv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 13:48:51 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2624632fgg.1
        for <linux-omap@vger.kernel.org>; Thu, 13 May 2010 10:48:50 -0700 (PDT)
In-Reply-To: <1273772856-10881-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>

This will allow the current 'mailbox_mach' to be built-in.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap1/mailbox.c             |   50 +++++------------------------
 arch/arm/mach-omap2/mailbox.c             |   50 +++++------------------------
 arch/arm/plat-omap/include/plat/mailbox.h |    4 ++
 arch/arm/plat-omap/mailbox.c              |   45 +++++++++++++++++++++++++-
 4 files changed, 64 insertions(+), 85 deletions(-)

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index 64c1dc2..036e159 100644
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
 
 	if (false) {
 	}
@@ -234,7 +196,7 @@ static int __init omap1_mbox_init(void)
 		return -ENODEV;
 	}
 
-	pdev = platform_device_alloc("omap1-mailbox", -1);
+	pdev = platform_device_alloc("omap-mailbox", -1);
 	if (!pdev) {
 		err = -ENOMEM;
 		goto err_out;
@@ -244,6 +206,11 @@ static int __init omap1_mbox_init(void)
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
@@ -254,7 +221,7 @@ static int __init omap1_mbox_init(void)
 		return -ENOMEM;
 	}
 
-	return platform_driver_register(&omap1_mbox_driver);
+	return 0;
 
 err_out:
 	return err;
@@ -262,7 +229,6 @@ err_out:
 
 static void __exit omap1_mbox_exit(void)
 {
-	platform_driver_unregister(&omap1_mbox_driver);
 	iounmap(mbox_base);
 }
 
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 941ee30..7abd159 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -417,51 +417,13 @@ static struct resource omap4_mbox_resources[] = {
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
 
 	if (false) {
 	}
@@ -499,7 +461,7 @@ static int __init omap2_mbox_init(void)
 		return -ENODEV;
 	}
 
-	pdev = platform_device_alloc("omap2-mailbox", -1);
+	pdev = platform_device_alloc("omap-mailbox", -1);
 	if (!pdev) {
 		err = -ENOMEM;
 		goto err_out;
@@ -509,6 +471,11 @@ static int __init omap2_mbox_init(void)
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
@@ -519,7 +486,7 @@ static int __init omap2_mbox_init(void)
 		return -ENOMEM;
 	}
 
-	return platform_driver_register(&omap2_mbox_driver);
+	return 0;
 
 err_out:
 	return err;
@@ -527,7 +494,6 @@ err_out:
 
 static void __exit omap2_mbox_exit(void)
 {
-	platform_driver_unregister(&omap2_mbox_driver);
 	iounmap(mbox_base);
 }
 
diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
index 729166b..cfbe221 100644
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
index 822c377..7ccd1e7 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -25,6 +25,7 @@
 #include <linux/interrupt.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/platform_device.h>
 
 #include <plat/mailbox.h>
 
@@ -408,14 +409,56 @@ int omap_mbox_unregister(struct omap_mbox *mbox)
 }
 EXPORT_SYMBOL(omap_mbox_unregister);
 
-static int __init omap_mbox_init(void)
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
 {
+	struct omap_mbox_platform_data *pdata = pdev->dev.platform_data;
+	int i;
+
+	for (i = 0; pdata->list[i]; i++)
+		omap_mbox_unregister(pdata->list[i]);
+
 	return 0;
 }
+
+static struct platform_driver omap_mbox_driver = {
+	.probe = omap_mbox_probe,
+	.remove = __devexit_p(omap_mbox_remove),
+	.driver = {
+		.name = "omap-mailbox",
+	},
+};
+
+static int __init omap_mbox_init(void)
+{
+	return platform_driver_register(&omap_mbox_driver);
+}
 module_init(omap_mbox_init);
 
 static void __exit omap_mbox_exit(void)
 {
+	platform_driver_unregister(&omap_mbox_driver);
 }
 module_exit(omap_mbox_exit);
 
-- 
1.7.1

