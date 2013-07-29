From: Illia Smyrnov <illia.smyrnov@ti.com>
Subject: [PATCH v3 3/3] Input: omap-keypad: Setup irq type from DT
Date: Mon, 29 Jul 2013 19:45:11 +0300
Message-ID: <1375116311-13999-4-git-send-email-illia.smyrnov@ti.com>
References: <1375116311-13999-1-git-send-email-illia.smyrnov@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1375116311-13999-1-git-send-email-illia.smyrnov@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

OMAP4 is DT only, so read the keypad IRQ type from DT instead hardcoding it
in driver.

Cc: Felipe Balbi <balbi@ti.com>
Signed-off-by: Illia Smyrnov <illia.smyrnov@ti.com>
---
 Based on top of v3.11-rc3

 Depends on:
 Input: omap-keypad: Convert to threaded IRQ
 https://patchwork.kernel.org/patch/2832920/

 drivers/input/keyboard/omap4-keypad.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index e8bdc76..75f8b94 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -375,8 +375,7 @@ static int omap4_keypad_probe(struct platform_device *pdev)
 	}
 
 	error = request_threaded_irq(keypad_data->irq, omap4_keypad_irq_handler,
-				     omap4_keypad_irq_thread_fn,
-				     IRQF_TRIGGER_RISING,
+				     omap4_keypad_irq_thread_fn, 0,
 				     "omap4-keypad", keypad_data);
 	if (error) {
 		dev_err(&pdev->dev, "failed to register interrupt\n");
-- 
1.7.9.5
