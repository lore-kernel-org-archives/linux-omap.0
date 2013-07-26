From: Illia Smyrnov <illia.smyrnov@ti.com>
Subject: [PATCH v2 3/3] Input: omap-keypad: Set irq to level instead of edge
Date: Fri, 26 Jul 2013 20:09:06 +0300
Message-ID: <1374858546-25034-4-git-send-email-illia.smyrnov@ti.com>
References: <1374858546-25034-1-git-send-email-illia.smyrnov@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1374858546-25034-1-git-send-email-illia.smyrnov@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Axel Haslam <axelhaslam@ti.com>

Set mpu irq to level instead of edge, since if mpu is in low power
an edge detection may be lost if the event is a wkup event.

Signed-off-by: Axel Haslam <axelhaslam@ti.com>
Signed-off-by: Illia Smyrnov <illia.smyrnov@ti.com>
---
 Based on top of v3.11-rc2

 Depends on:
 Input: omap-keypad: Convert to threaded IRQ
 https://patchwork.kernel.org/patch/2832920/

 drivers/input/keyboard/omap4-keypad.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index e8bdc76..7adb53e 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -374,9 +374,13 @@ static int omap4_keypad_probe(struct platform_device *pdev)
 		goto err_free_keymap;
 	}
 
+	/*
+	 * Set irq level detection for mpu. Edge event are missed in gic
+	 * if the mpu is in low power and keypad event is a wakeup
+	 */
 	error = request_threaded_irq(keypad_data->irq, omap4_keypad_irq_handler,
 				     omap4_keypad_irq_thread_fn,
-				     IRQF_TRIGGER_RISING,
+				     IRQF_TRIGGER_HIGH,
 				     "omap4-keypad", keypad_data);
 	if (error) {
 		dev_err(&pdev->dev, "failed to register interrupt\n");
-- 
1.7.9.5

