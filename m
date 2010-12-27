From: shubhrajyoti@ti.com
Subject: [PATCH v8 3/3] OMAP4:keypad: PM runtime
Date: Mon, 27 Dec 2010 11:21:46 +0530
Message-ID: <1293429106-16543-4-git-send-email-shubhrajyoti@ti.com>
References: <1293429106-16543-1-git-send-email-shubhrajyoti@ti.com>
 <1293429106-16543-2-git-send-email-shubhrajyoti@ti.com>
 <1293429106-16543-3-git-send-email-shubhrajyoti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40051 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543Ab0L0Fv4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Dec 2010 00:51:56 -0500
In-Reply-To: <1293429106-16543-3-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-input@vger.kernel.org
Cc: Abraham Arce <x0066660@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

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
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/input/keyboard/omap4-keypad.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index 45bd097..fcfbb9b 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -29,6 +29,7 @@
 #include <linux/io.h>
 #include <linux/input.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 
 #include <plat/omap4-keypad.h>
 
@@ -239,6 +240,9 @@ static int __devinit omap4_keypad_probe(struct platform_device *pdev)
 	matrix_keypad_build_keymap(pdata->keymap_data, row_shift,
 			input_dev->keycode, input_dev->keybit);
 
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
+
 	omap4_keypad_config(keypad_data);
 
 	error = request_irq(keypad_data->irq, omap4_keypad_interrupt,
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

