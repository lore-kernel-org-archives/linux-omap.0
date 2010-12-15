From: Shubhrajyoti D <a0393217@india.ti.com>
Subject: [PATCH v7] OMAP4:keypad: PM runtime
Date: Wed, 15 Dec 2010 09:39:58 +0530
Message-ID: <1292386198-3587-1-git-send-email-a0393217@india.ti.com>
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Abraham Arce <x0066660@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
List-Id: linux-omap@vger.kernel.org

From: Abraham Arce <x0066660@ti.com>

Enable Runtime PM functionality in OMAP4 driver based on the following assumptions

A minimal pm runtime get/put approach is implemented in probe/remove calls
respectively.

- Keyboard controller in wakeup domain so it is always on and
  power impact may be minimal
- In OMAP4 the device control is at module/device level and ick/fclk level control is
  difficult so cutting of clocks will prevent interrupts.

Signed-off-by: Abraham Arce <x0066660@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
Updating the changelogs as per Kevin's suggestion
 drivers/input/keyboard/omap4-keypad.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index 45bd097..3d35774 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -29,6 +29,7 @@
 #include <linux/io.h>
 #include <linux/input.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 
 #include <plat/omap4-keypad.h>
 
@@ -239,8 +240,11 @@ static int __devinit omap4_keypad_probe(struct platform_device *pdev)
 	matrix_keypad_build_keymap(pdata->keymap_data, row_shift,
 			input_dev->keycode, input_dev->keybit);
 
-	omap4_keypad_config(keypad_data);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
 
+	omap4_keypad_config(keypad_data);
+	
 	error = request_irq(keypad_data->irq, omap4_keypad_interrupt,
 			     IRQF_TRIGGER_RISING,
 			     "omap4-keypad", keypad_data);
@@ -278,6 +282,10 @@ static int __devexit omap4_keypad_remove(struct platform_device *pdev)
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

