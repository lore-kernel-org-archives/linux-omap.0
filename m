From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/2] Input: omap-keypad: Fix keyboard debounce configuration
Date: Sun,  2 Dec 2018 17:29:32 -0800
Message-ID: <20181203012933.6647-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Axel Haslam <axelhaslam@ti.com>, Felipe Balbi <felipe.balbi@linux.intel.com>, Illia Smyrnov <illia.smyrnov@ti.com>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Scott <hashcode0f@gmail.com>, NeKit <nekit1000@gmail.com>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

I noticed that the Android v3.0.8 kernel on droid4 is using different
keypad values from the mainline kernel and does not have issues with
keys occasionally being stuck until pressed again. Turns out there was
an earlier patch posted to fix this as "Input: omap-keypad: errata i689:
Correct debounce time", but it was never reposted to fix use macros
for timing calculations.

This updated version is using macros, and also fixes the use of the
input clock rate to use 32768KiHz instead of 32000KiHz. And we want to
use the known good Android kernel values of 3 and 6 instead of 2 and 6
in the earlier patch.

Cc: Axel Haslam <axelhaslam@ti.com>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
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
 drivers/input/keyboard/omap4-keypad.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -60,8 +60,18 @@
 
 /* OMAP4 values */
 #define OMAP4_VAL_IRQDISABLE		0x0
-#define OMAP4_VAL_DEBOUNCINGTIME	0x7
-#define OMAP4_VAL_PVT			0x7
+
+/*
+ * Errata i689: If a key is released for a time shorter than debounce time,
+ * the keyboard will idle and never detect the key release. The workaround
+ * is to use at least a 12ms debounce time. See omap5432 TRM chapter
+ * "26.4.6.2 Keyboard Controller Timer" for more information.
+ */
+#define OMAP4_KEYPAD_PTV_DIV_128        0x6
+#define OMAP4_KEYPAD_DEBOUNCINGTIME_MS(dbms, ptv)     \
+	((((dbms) * 1000) / ((1 << ((ptv) + 1)) * (1000000 / 32768))) - 1)
+#define OMAP4_VAL_DEBOUNCINGTIME_16MS					\
+	OMAP4_KEYPAD_DEBOUNCINGTIME_MS(16, OMAP4_KEYPAD_PTV_DIV_128)
 
 enum {
 	KBD_REVISION_OMAP4 = 0,
@@ -181,9 +191,9 @@ static int omap4_keypad_open(struct input_dev *input)
 
 	kbd_writel(keypad_data, OMAP4_KBD_CTRL,
 			OMAP4_DEF_CTRL_NOSOFTMODE |
-			(OMAP4_VAL_PVT << OMAP4_DEF_CTRL_PTV_SHIFT));
+			(OMAP4_KEYPAD_PTV_DIV_128 << OMAP4_DEF_CTRL_PTV_SHIFT));
 	kbd_writel(keypad_data, OMAP4_KBD_DEBOUNCINGTIME,
-			OMAP4_VAL_DEBOUNCINGTIME);
+			OMAP4_VAL_DEBOUNCINGTIME_16MS);
 	/* clear pending interrupts */
 	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
 			 kbd_read_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS));
-- 
2.19.2
