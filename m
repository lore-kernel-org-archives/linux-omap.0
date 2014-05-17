From: Joachim Eastwood <manabian@gmail.com>
Subject: [PATCH 2/2] Input: omap-keypad - remove platform data support
Date: Sat, 17 May 2014 23:24:11 +0200
Message-ID: <1400361851-32274-3-git-send-email-manabian@gmail.com>
References: <1400361851-32274-1-git-send-email-manabian@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:53491 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbaEQVY0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 May 2014 17:24:26 -0400
In-Reply-To: <1400361851-32274-1-git-send-email-manabian@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: illia.smyrnov@ti.com, dmitry.torokhov@gmail.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-input@vger.kernel.org, Joachim Eastwood <manabian@gmail.com>

This is unused since all users (OMAP4/5) are DT only.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 drivers/input/keyboard/Kconfig             |  2 +-
 drivers/input/keyboard/omap4-keypad.c      | 31 ++++++------------------------
 include/linux/platform_data/omap4-keypad.h | 13 -------------
 3 files changed, 7 insertions(+), 39 deletions(-)
 delete mode 100644 include/linux/platform_data/omap4-keypad.h

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 76842d7dc2e3..295cbf4763b1 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -578,7 +578,7 @@ config KEYBOARD_OMAP
 
 config KEYBOARD_OMAP4
 	tristate "TI OMAP4+ keypad support"
-	depends on ARCH_OMAP2PLUS
+	depends on OF || ARCH_OMAP2PLUS
 	select INPUT_MATRIXKMAP
 	help
 	  Say Y here if you want to use the OMAP4+ keypad.
diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index 0400b3f2b4b9..8b32f44e84ee 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -28,11 +28,10 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/input.h>
+#include <linux/input/matrix_keypad.h>
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
 
-#include <linux/platform_data/omap4-keypad.h>
-
 /* OMAP4 registers */
 #define OMAP4_KBD_REVISION		0x00
 #define OMAP4_KBD_SYSCONFIG		0x10
@@ -218,7 +217,6 @@ static void omap4_keypad_close(struct input_dev *input)
 	pm_runtime_put_sync(input->dev.parent);
 }
 
-#ifdef CONFIG_OF
 static int omap4_keypad_parse_dt(struct device *dev,
 				 struct omap4_keypad *keypad_data)
 {
@@ -235,20 +233,10 @@ static int omap4_keypad_parse_dt(struct device *dev,
 
 	return 0;
 }
-#else
-static inline int omap4_keypad_parse_dt(struct device *dev,
-					struct omap4_keypad *keypad_data)
-{
-	return -ENOSYS;
-}
-#endif
 
 static int omap4_keypad_probe(struct platform_device *pdev)
 {
-	const struct omap4_keypad_platform_data *pdata =
-				dev_get_platdata(&pdev->dev);
-	const struct matrix_keymap_data *keymap_data =
-				pdata ? pdata->keymap_data : NULL;
+	const struct matrix_keymap_data *keymap_data = NULL;
 	struct omap4_keypad *keypad_data;
 	struct input_dev *input_dev;
 	struct resource *res;
@@ -277,14 +265,9 @@ static int omap4_keypad_probe(struct platform_device *pdev)
 
 	keypad_data->irq = irq;
 
-	if (pdata) {
-		keypad_data->rows = pdata->rows;
-		keypad_data->cols = pdata->cols;
-	} else {
-		error = omap4_keypad_parse_dt(&pdev->dev, keypad_data);
-		if (error)
-			return error;
-	}
+	error = omap4_keypad_parse_dt(&pdev->dev, keypad_data);
+	if (error)
+		return error;
 
 	res = request_mem_region(res->start, resource_size(res), pdev->name);
 	if (!res) {
@@ -434,13 +417,11 @@ static int omap4_keypad_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id omap_keypad_dt_match[] = {
 	{ .compatible = "ti,omap4-keypad" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, omap_keypad_dt_match);
-#endif
 
 #ifdef CONFIG_PM_SLEEP
 static int omap4_keypad_suspend(struct device *dev)
@@ -482,7 +463,7 @@ static struct platform_driver omap4_keypad_driver = {
 		.name	= "omap4-keypad",
 		.owner	= THIS_MODULE,
 		.pm	= &omap4_keypad_pm_ops,
-		.of_match_table = of_match_ptr(omap_keypad_dt_match),
+		.of_match_table = omap_keypad_dt_match,
 	},
 };
 module_platform_driver(omap4_keypad_driver);
diff --git a/include/linux/platform_data/omap4-keypad.h b/include/linux/platform_data/omap4-keypad.h
deleted file mode 100644
index 4eef5fb05a17..000000000000
--- a/include/linux/platform_data/omap4-keypad.h
+++ /dev/null
@@ -1,13 +0,0 @@
-#ifndef __LINUX_INPUT_OMAP4_KEYPAD_H
-#define __LINUX_INPUT_OMAP4_KEYPAD_H
-
-#include <linux/input/matrix_keypad.h>
-
-struct omap4_keypad_platform_data {
-	const struct matrix_keymap_data *keymap_data;
-
-	u8 rows;
-	u8 cols;
-};
-
-#endif /* __LINUX_INPUT_OMAP4_KEYPAD_H */
-- 
1.8.0

