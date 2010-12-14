From: shubhrajyoti@ti.com
Subject: [PATCH v7] Enable Runtime PM functionality in OMAP4 driver based on the following assumptions:
Date: Tue, 14 Dec 2010 21:00:19 +0530
Message-ID: <1292340619-14504-1-git-send-email-a0393217@india.ti.com>
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Abraham Arce <x0066660@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
List-Id: linux-omap@vger.kernel.org

From: Abraham Arce <x0066660@ti.com>

- Runtime PM selected by ARCH_OMAP2PLUS_TYPICAL && ARCH_OMAP2PLUS,
  which is the default OMAP2+ defconfig including OMAP4
- Runtime PM APIs handles Clock Framework APIs
- Do not do the keypadconfig if the irq request fails

A minimal pm runtime get/put approach is implemented in probe/remove calls
respectively based on:

- Keyboard controller in wakeup domain so it is always on and
  power impact may be minimal
- Cutting of clocks will prevent interrupts


Signed-off-by: Abraham Arce <x0066660@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
Updating the changelogs as per Kevin's suggestion

 drivers/input/keyboard/omap4-keypad.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index 45bd097..36239e2 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -29,6 +29,7 @@
 #include <linux/io.h>
 #include <linux/input.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 
 #include <plat/omap4-keypad.h>
 
@@ -239,7 +240,8 @@ static int __devinit omap4_keypad_probe(struct platform_device *pdev)
 	matrix_keypad_build_keymap(pdata->keymap_data, row_shift,
 			input_dev->keycode, input_dev->keybit);
 
-	omap4_keypad_config(keypad_data);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
 
 	error = request_irq(keypad_data->irq, omap4_keypad_interrupt,
 			     IRQF_TRIGGER_RISING,
@@ -255,8 +257,9 @@ static int __devinit omap4_keypad_probe(struct platform_device *pdev)
 		goto err_free_irq;
 	}
 
-
+	omap4_keypad_config(keypad_data);
 	platform_set_drvdata(pdev, keypad_data);
+
 	return 0;
 
 err_free_irq:
@@ -278,6 +281,10 @@ static int __devexit omap4_keypad_remove(struct platform_device *pdev)
 	struct resource *res;
 
 	free_irq(keypad_data->irq, keypad_data);
+
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
 	input_unregister_device(keypad_data->input);
 
 	iounmap(keypad_data->base);
-- 
1.7.0.4

