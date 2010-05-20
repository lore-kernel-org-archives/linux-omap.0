From: Manjunatha GK <manjugk@ti.com>
Subject: [PATCH] OMAP2/3: Keypad: Fix memory leak
Date: Thu, 20 May 2010 19:59:49 +0530
Message-ID: <1274365792-24938-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56256 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755075Ab0ETOa0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 May 2010 10:30:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Damodar <x0132156@ti.com>, Tony Lindgren <tony@atomide.com>

From: Damodar <x0132156@ti.com>

This patch corrects Possible memory leak of 'input' allocated
through input_allocate_device and Suspicious dereference of pointer 'pdata'
before NULL check

Signed-off-by: Damodar Santhapuri <x0132156@ti.com>
Signed-off-by: Manjunatha GK <manjugk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>

---
 drivers/input/keyboard/twl4030_keypad.c |   21 +++++++++++++--------
 1 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/input/keyboard/twl4030_keypad.c b/drivers/input/keyboard/twl4030_keypad.c
index 7aa59e0..aa13aec 100644
--- a/drivers/input/keyboard/twl4030_keypad.c
+++ b/drivers/input/keyboard/twl4030_keypad.c
@@ -326,30 +326,34 @@ static int __devinit twl4030_kp_program(struct twl4030_keypad *kp)
  */
 static int __devinit twl4030_kp_probe(struct platform_device *pdev)
 {
-	struct twl4030_keypad_data *pdata = pdev->dev.platform_data;
-	const struct matrix_keymap_data *keymap_data = pdata->keymap_data;
+	struct twl4030_keypad_data *pdata;
+	const struct matrix_keymap_data *keymap_data;
 	struct twl4030_keypad *kp;
 	struct input_dev *input;
 	u8 reg;
 	int error;
-
+	if (!pdev) {
+		printk(KERN_ERR "Invalid platorm_device\n");
+		return -EINVAL;
+	}
+	pdata = pdev->dev.platform_data;
 	if (!pdata || !pdata->rows || !pdata->cols ||
 	    pdata->rows > TWL4030_MAX_ROWS || pdata->cols > TWL4030_MAX_COLS) {
 		dev_err(&pdev->dev, "Invalid platform_data\n");
 		return -EINVAL;
 	}
-
+	keymap_data = pdata->keymap_data;
 	kp = kzalloc(sizeof(*kp), GFP_KERNEL);
+	if (!kp)
+		return  -ENOMEM;
 	input = input_allocate_device();
-	if (!kp || !input) {
+	if (!input) {
 		error = -ENOMEM;
-		goto err1;
+		goto err0;
 	}
-
 	/* Get the debug Device */
 	kp->dbg_dev = &pdev->dev;
 	kp->input = input;
-
 	kp->n_rows = pdata->rows;
 	kp->n_cols = pdata->cols;
 	kp->irq = platform_get_irq(pdev, 0);
@@ -424,6 +428,7 @@ err2:
 	input = NULL;
 err1:
 	input_free_device(input);
+err0:
 	kfree(kp);
 	return error;
 }
-- 
1.7.0.4

