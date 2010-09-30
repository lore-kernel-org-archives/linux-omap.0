From: Abraham Arce <x0066660@ti.com>
Subject: [PATCH v6 5/8] Input: omap4 - Wake-up on events & long presses
Date: Thu, 30 Sep 2010 00:35:32 -0500
Message-ID: <1285824932-25454-1-git-send-email-x0066660@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Mike Turquette <mturquette@ti.com>, Abraham Arce <x0066660@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Mike Turquette <mturquette@ti.com>

Programs keyboard controller to generate a wake-up request on events and
on long key presses.  Does not generate wake-up requests on timeouts
since driver code does not handle them.

This allows keyboard to wake-up OMAP from suspend.

Signed-off-by: Mike Turquette <mturquette@ti.com>
Signed-off-by: Abraham Arce <x0066660@ti.com>
---
 drivers/input/keyboard/omap4-keypad.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index 07e792e..45bd097 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -54,6 +54,8 @@
 #define OMAP4_DEF_IRQENABLE_EVENTEN	(1 << 0)
 #define OMAP4_DEF_IRQENABLE_LONGKEY	(1 << 1)
 #define OMAP4_DEF_IRQENABLE_TIMEOUTEN	(1 << 2)
+#define OMAP4_DEF_WUP_EVENT_ENA		(1 << 0)
+#define OMAP4_DEF_WUP_LONG_KEY_ENA	(1 << 1)
 #define OMAP4_DEF_CTRL_NOSOFTMODE	(1 << 1)
 #define OMAP4_DEF_CTRLPTVVALUE		(1 << 2)
 #define OMAP4_DEF_CTRLPTV		(1 << 1)
@@ -88,6 +90,8 @@ static void __devinit omap4_keypad_config(struct omap4_keypad *keypad_data)
 			keypad_data->base + OMAP4_KBD_IRQSTATUS);
 	__raw_writel(OMAP4_DEF_IRQENABLE_EVENTEN | OMAP4_DEF_IRQENABLE_LONGKEY,
 			keypad_data->base + OMAP4_KBD_IRQENABLE);
+	__raw_writel(OMAP4_DEF_WUP_EVENT_ENA | OMAP4_DEF_WUP_LONG_KEY_ENA,
+			keypad_data->base + OMAP4_KBD_WAKEUPENABLE);
 }
 
 /* Interrupt handler */
-- 
1.6.3.3

