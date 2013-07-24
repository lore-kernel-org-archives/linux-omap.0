From: Illia Smyrnov <illia.smyrnov@ti.com>
Subject: [PATCH v3 3/3] Input: omap-keypad: Clear interrupts on open
Date: Wed, 24 Jul 2013 18:54:53 +0300
Message-ID: <1374681293-5320-4-git-send-email-illia.smyrnov@ti.com>
References: <1374681293-5320-1-git-send-email-illia.smyrnov@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1374681293-5320-1-git-send-email-illia.smyrnov@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Clear interrupts when open keypad.

According to TRM, the recommended way for keyboard controller
initialization is clear the interrupt-status register, then set up
certain keyboard events for generating an interrupt request and
set up expected source of wake-up event that generates a wake-up
request.

Signed-off-by: Illia Smyrnov <illia.smyrnov@ti.com>
---
 drivers/input/keyboard/omap4-keypad.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index b876a0d..0244262 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -185,8 +185,9 @@ static int omap4_keypad_open(struct input_dev *input)
 			(OMAP4_VAL_PVT << OMAP4_DEF_CTRL_PTV_SHIFT));
 	kbd_writel(keypad_data, OMAP4_KBD_DEBOUNCINGTIME,
 			OMAP4_VAL_DEBOUNCINGTIME);
+	/* clear pending interrupts */
 	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
-			OMAP4_VAL_IRQDISABLE);
+			 kbd_read_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS));
 	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
 			OMAP4_DEF_IRQENABLE_EVENTEN |
 				OMAP4_DEF_IRQENABLE_LONGKEY);
-- 
1.7.0.4
