From: Abraham Arce <x0066660@ti.com>
Subject: [PATCH v6 3/8] Input: omap4 - SYSCONFIG register configuration
Date: Thu, 30 Sep 2010 00:29:20 -0500
Message-ID: <1285824565-24906-4-git-send-email-x0066660@ti.com>
References: <1285824565-24906-1-git-send-email-x0066660@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1285824565-24906-1-git-send-email-x0066660@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Abraham Arce <x0066660@ti.com>
List-Id: linux-omap@vger.kernel.org

Remove SYSCONFIG register configuration, omap hwmod framework will
use internal API to modify as required

Other minor updates:

- Change a variable name from DEF to VAL, this represents a value
- Break line width to 80 characters

Signed-off-by: Abraham Arce <x0066660@ti.com>
---
 drivers/input/keyboard/omap4-keypad.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index 788169d..2b61f5f 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -51,17 +51,15 @@
 #define OMAP4_KBD_FULLCODE63_32		0x48
 
 /* OMAP4 bit definitions */
-#define OMAP4_DEF_SYSCONFIG_SOFTRST	(1 << 1)
-#define OMAP4_DEF_SYSCONFIG_ENAWKUP	(1 << 2)
 #define OMAP4_DEF_IRQENABLE_EVENTEN	(1 << 0)
 #define OMAP4_DEF_IRQENABLE_LONGKEY	(1 << 1)
 #define OMAP4_DEF_IRQENABLE_TIMEOUTEN	(1 << 2)
 #define OMAP4_DEF_CTRL_NOSOFTMODE	(1 << 1)
 #define OMAP4_DEF_CTRLPTVVALUE		(1 << 2)
 #define OMAP4_DEF_CTRLPTV		(1 << 1)
-#define OMAP4_DEF_IRQDISABLE		0x00
 
 /* OMAP4 values */
+#define OMAP4_VAL_IRQDISABLE		0x00
 #define OMAP4_VAL_DEBOUNCINGTIME	0x07
 #define OMAP4_VAL_FUNCTIONALCFG		0x1E
 
@@ -82,13 +80,11 @@ struct omap4_keypad {
 
 static void __devinit omap4_keypad_config(struct omap4_keypad *keypad_data)
 {
-	__raw_writel(OMAP4_DEF_SYSCONFIG_SOFTRST | OMAP4_DEF_SYSCONFIG_ENAWKUP,
-			keypad_data->base + OMAP4_KBD_SYSCONFIG);
 	__raw_writel(OMAP4_VAL_FUNCTIONALCFG,
 			keypad_data->base + OMAP4_KBD_CTRL);
 	__raw_writel(OMAP4_VAL_DEBOUNCINGTIME,
 			keypad_data->base + OMAP4_KBD_DEBOUNCINGTIME);
-	__raw_writel(OMAP4_DEF_IRQDISABLE,
+	__raw_writel(OMAP4_VAL_IRQDISABLE,
 			keypad_data->base + OMAP4_KBD_IRQSTATUS);
 	__raw_writel(OMAP4_DEF_IRQENABLE_EVENTEN | OMAP4_DEF_IRQENABLE_LONGKEY,
 			keypad_data->base + OMAP4_KBD_IRQENABLE);
@@ -104,11 +100,12 @@ static irqreturn_t omap4_keypad_interrupt(int irq, void *dev_id)
 	u32 *new_state = (u32 *) key_state;
 
 	/* Disable interrupts */
-	__raw_writel(OMAP4_DEF_IRQDISABLE,
+	__raw_writel(OMAP4_VAL_IRQDISABLE,
 		     keypad_data->base + OMAP4_KBD_IRQENABLE);
 
 	*new_state = __raw_readl(keypad_data->base + OMAP4_KBD_FULLCODE31_0);
-	*(new_state + 1) = __raw_readl(keypad_data->base + OMAP4_KBD_FULLCODE63_32);
+	*(new_state + 1) = __raw_readl(keypad_data->base
+						+ OMAP4_KBD_FULLCODE63_32);
 
 	for (row = 0; row < keypad_data->rows; row++) {
 		changed = key_state[row] ^ keypad_data->key_state[row];
-- 
1.6.3.3

