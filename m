From: Abraham Arce <x0066660@ti.com>
Subject: [PATCH v6 2/8] Input: omap4 - use platform device helpers
Date: Thu, 30 Sep 2010 00:29:19 -0500
Message-ID: <1285824565-24906-3-git-send-email-x0066660@ti.com>
References: <1285824565-24906-1-git-send-email-x0066660@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40688 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753137Ab0I3FaN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Sep 2010 01:30:13 -0400
In-Reply-To: <1285824565-24906-1-git-send-email-x0066660@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-input@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Abraham Arce <x0066660@ti.com>

Get mem and irq resources using platform helpers

 - platform_get_base
 - platform_get_irq

Signed-off-by: Abraham Arce <x0066660@ti.com>
---
 arch/arm/plat-omap/include/plat/omap4-keypad.h |    4 +--
 drivers/input/keyboard/omap4-keypad.c          |   40 +++++++++++++++++++++---
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap4-keypad.h b/arch/arm/plat-omap/include/plat/omap4-keypad.h
index 522a8ab..2b1d9bc 100644
--- a/arch/arm/plat-omap/include/plat/omap4-keypad.h
+++ b/arch/arm/plat-omap/include/plat/omap4-keypad.h
@@ -8,9 +8,7 @@ struct omap4_keypad_platform_data {
 
 	u8 rows;
 	u8 cols;
-
-	u16 irq;
-	void __iomem *base;
 };
 
+extern int omap4_keyboard_init(struct omap4_keypad_platform_data *);
 #endif
diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index 975f8bb..788169d 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -148,7 +148,10 @@ static int __devinit omap4_keypad_probe(struct platform_device *pdev)
 	const struct omap4_keypad_platform_data *pdata;
 	struct omap4_keypad *keypad_data;
 	struct input_dev *input_dev;
+	struct resource *res;
+	resource_size_t size;
 	unsigned int row_shift, max_keys;
+	int irq;
 	int error;
 
 	/* platform data */
@@ -158,12 +161,14 @@ static int __devinit omap4_keypad_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	if (!pdata->base) {
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
 		dev_err(&pdev->dev, "no base address specified\n");
 		return -EINVAL;
 	}
 
-	if (!pdata->irq) {
+	irq = platform_get_irq(pdev, 0);
+	if (!irq) {
 		dev_err(&pdev->dev, "no keyboard irq assigned\n");
 		return -EINVAL;
 	}
@@ -184,9 +189,23 @@ static int __devinit omap4_keypad_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	keypad_data->base = pdata->base;
-	keypad_data->irq = pdata->irq;
+	size = resource_size(res);
+
+	res = request_mem_region(res->start, size, pdev->name);
+	if (!res) {
+		dev_err(&pdev->dev, "can't request mem region\n");
+		error = -EBUSY;
+		goto err_free_keypad;
+	}
 
+	keypad_data->base = ioremap(res->start, resource_size(res));
+	if (!keypad_data->base) {
+		dev_err(&pdev->dev, "can't ioremap mem resource\n");
+		error = -ENOMEM;
+		goto err_release_mem;
+	}
+
+	keypad_data->irq = irq;
 	keypad_data->row_shift = row_shift;
 	keypad_data->rows = pdata->rows;
 	keypad_data->cols = pdata->cols;
@@ -195,7 +214,7 @@ static int __devinit omap4_keypad_probe(struct platform_device *pdev)
 	keypad_data->input = input_dev = input_allocate_device();
 	if (!input_dev) {
 		error = -ENOMEM;
-		goto err_free_keypad;
+		goto err_unmap;
 	}
 
 	input_dev->name = pdev->name;
@@ -243,6 +262,10 @@ err_free_irq:
 	free_irq(keypad_data->irq, keypad_data);
 err_free_input:
 	input_free_device(input_dev);
+err_unmap:
+	iounmap(keypad_data->base);
+err_release_mem:
+	release_mem_region(res->start, size);
 err_free_keypad:
 	kfree(keypad_data);
 	return error;
@@ -251,9 +274,16 @@ err_free_keypad:
 static int __devexit omap4_keypad_remove(struct platform_device *pdev)
 {
 	struct omap4_keypad *keypad_data = platform_get_drvdata(pdev);
+	struct resource *res;
 
 	free_irq(keypad_data->irq, keypad_data);
 	input_unregister_device(keypad_data->input);
+
+	iounmap(keypad_data->base);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(res->start, resource_size(res));
+
 	kfree(keypad_data);
 	platform_set_drvdata(pdev, NULL);
 
-- 
1.6.3.3

