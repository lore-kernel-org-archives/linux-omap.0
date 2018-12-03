From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] Input: omap-keypad: Fix idle configration to not block SoC idle states
Date: Sun,  2 Dec 2018 17:29:33 -0800
Message-ID: <20181203012933.6647-2-tony@atomide.com>
References: <20181203012933.6647-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181203012933.6647-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Axel Haslam <axelhaslam@ti.com>, Illia Smyrnov <illia.smyrnov@ti.com>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Scott <hashcode0f@gmail.com>, NeKit <nekit1000@gmail.com>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

With PM enabled, I noticed that pressing a key on the droid4 keyboard will
block deeper idle states for the SoC. Looks like we can fix this by
managing the idle register to gether with the interrupt similar to what
we already do for the GPIO controller.

Note that we now must also disable OMAP4_DEF_IRQENABLE_LONGKEY as it
should not be used together with debounce according to the TRM.

Cc: Axel Haslam <axelhaslam@ti.com>
Cc: Illia Smyrnov <illia.smyrnov@ti.com>
Cc: Marcel Partap <mpartap@gmx.net>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Michael Scott <hashcode0f@gmail.com>
Cc: NeKit <nekit1000@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Reported-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/input/keyboard/omap4-keypad.c | 28 ++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -53,11 +53,12 @@
 /* OMAP4 bit definitions */
 #define OMAP4_DEF_IRQENABLE_EVENTEN	BIT(0)
 #define OMAP4_DEF_IRQENABLE_LONGKEY	BIT(1)
-#define OMAP4_DEF_WUP_EVENT_ENA		BIT(0)
-#define OMAP4_DEF_WUP_LONG_KEY_ENA	BIT(1)
 #define OMAP4_DEF_CTRL_NOSOFTMODE	BIT(1)
 #define OMAP4_DEF_CTRL_PTV_SHIFT	2
 
+#define OMAP4_KBD_IRQ_MASK		(OMAP4_DEF_IRQENABLE_LONGKEY | \
+					 OMAP4_DEF_IRQENABLE_EVENTEN)
+
 /* OMAP4 values */
 #define OMAP4_VAL_IRQDISABLE		0x0
 
@@ -127,9 +128,11 @@ static irqreturn_t omap4_keypad_irq_handler(int irq, void *dev_id)
 	struct omap4_keypad *keypad_data = dev_id;
 
 	if (kbd_read_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS)) {
-		/* Disable interrupts */
+		/* Disable interrupts and wake-up events */
 		kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
 				 OMAP4_VAL_IRQDISABLE);
+		kbd_writel(keypad_data, OMAP4_KBD_WAKEUPENABLE, 0);
+
 		return IRQ_WAKE_THREAD;
 	}
 
@@ -173,10 +176,9 @@ static irqreturn_t omap4_keypad_irq_thread_fn(int irq, void *dev_id)
 	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
 			 kbd_read_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS));
 
-	/* enable interrupts */
-	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
-		OMAP4_DEF_IRQENABLE_EVENTEN |
-				OMAP4_DEF_IRQENABLE_LONGKEY);
+	/* enable interrupts and wake-up events */
+	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE, OMAP4_KBD_IRQ_MASK);
+	kbd_writel(keypad_data, OMAP4_KBD_WAKEUPENABLE, OMAP4_KBD_IRQ_MASK);
 
 	return IRQ_HANDLED;
 }
@@ -197,11 +199,10 @@ static int omap4_keypad_open(struct input_dev *input)
 	/* clear pending interrupts */
 	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
 			 kbd_read_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS));
-	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
-			OMAP4_DEF_IRQENABLE_EVENTEN |
-				OMAP4_DEF_IRQENABLE_LONGKEY);
-	kbd_writel(keypad_data, OMAP4_KBD_WAKEUPENABLE,
-			OMAP4_DEF_WUP_EVENT_ENA | OMAP4_DEF_WUP_LONG_KEY_ENA);
+
+	/* enable interrupts and wake-up events */
+	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE, OMAP4_KBD_IRQ_MASK);
+	kbd_writel(keypad_data, OMAP4_KBD_WAKEUPENABLE, OMAP4_KBD_IRQ_MASK);
 
 	enable_irq(keypad_data->irq);
 
@@ -214,9 +215,10 @@ static void omap4_keypad_close(struct input_dev *input)
 
 	disable_irq(keypad_data->irq);
 
-	/* Disable interrupts */
+	/* Disable interrupts and wake-up events */
 	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
 			 OMAP4_VAL_IRQDISABLE);
+	kbd_writel(keypad_data, OMAP4_KBD_WAKEUPENABLE, 0);
 
 	/* clear pending interrupts */
 	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
-- 
2.19.2
