From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Buffer overrun in the TWL4030 keypad driver with Nokia RX51
Date: Sat, 17 Jul 2010 14:37:05 -0700
Message-ID: <20100717213705.GA22477@core.coreip.homeip.net>
References: <201007161728.44227.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:48022 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754099Ab0GQVhL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Jul 2010 17:37:11 -0400
Content-Disposition: inline
In-Reply-To: <201007161728.44227.laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Amit Kucheria <amit.kucheria@verdurent.com>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Hi Laurent.

On Fri, Jul 16, 2010 at 05:28:43PM +0200, Laurent Pinchart wrote:
> Hi everybody,
> 
> I've spent the day debugging a kernel crash in the USB networking code to find 
> out the problem was caused by a buffer overrun in the TWL4030 keypad driver. 
> 
> The Nokia RX51 board code (arch/arm/mach-omap2/board-rx51-peripherals.c) 
> defines a key map for the matrix keypad keyboard. The hardware seems to use 
> all of the 8 rows and 8 columns of the keypad, although not all possible 
> locations are used.
> 
> The TWL4030 supports keypads with at most 8 rows and 8 columns. Most keys are 
> defined with a row and column number between 0 and 7, except
> 
>         KEY(0xff, 2, KEY_F9),
>         KEY(0xff, 4, KEY_F10),
>         KEY(0xff, 5, KEY_F11),
> 
> The row number is set to 0xff. As the generic matrix keypad support 
> (include/linux/input/matrix_keypad.h) supports at most 16 rows and 16 columns, 
> it masks all but the lower 4 bits of the row and column numbers in the KEY 
> macro.

[..snipped..]

Thanks for the report. Could yo uplease try the patch below and let me
know if it works.

I have some concerns with the keymap assignments, I see that Amit
changed them during KEY(col, row) -> KEY(row, col) conversion. I marked
the entries I am concerned with with XXX.

Thanks.

-- 
Dmitry

Input: twl40300-keypad - fix handling of "all ground" rows

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

The Nokia RX51 board code (arch/arm/mach-omap2/board-rx51-peripherals.c)
defines a key map for the matrix keypad keyboard. The hardware seems to
use all of the 8 rows and 8 columns of the keypad, although not all
possible locations are used.

The TWL4030 supports keypads with at most 8 rows and 8 columns. Most keys
are defined with a row and column number between 0 and 7, except

        KEY(0xff, 2, KEY_F9),
        KEY(0xff, 4, KEY_F10),
        KEY(0xff, 5, KEY_F11),

which represent keycodes that should be emitted when entire row is
connected to the ground. The driver handles this case as if we had an
extra column in the key matrix. Unfortunately we do not allocate enough
space and end up owerwriting some random memory.

Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 arch/arm/mach-omap2/board-rx51-peripherals.c |   28 ++++++++++++++++++++------
 drivers/input/keyboard/twl4030_keypad.c      |   17 ++++++++++------
 2 files changed, 32 insertions(+), 13 deletions(-)


diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index abdf321..ea32143 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -175,6 +175,10 @@ static void __init rx51_add_gpio_keys(void)
 #endif /* CONFIG_KEYBOARD_GPIO || CONFIG_KEYBOARD_GPIO_MODULE */
 
 static int board_keymap[] = {
+	/*
+	 * Note that KEY(x, 8, KEY_XXX) entries represent "entire row
+	 * connected to the ground" matrix state.
+	 */
 	KEY(0, 0, KEY_Q),
 	KEY(0, 1, KEY_O),
 	KEY(0, 2, KEY_P),
@@ -182,6 +186,8 @@ static int board_keymap[] = {
 	KEY(0, 4, KEY_BACKSPACE),
 	KEY(0, 6, KEY_A),
 	KEY(0, 7, KEY_S),
+//	KEY(0, 8, KEY_F6),	// XXX was removed
+
 	KEY(1, 0, KEY_W),
 	KEY(1, 1, KEY_D),
 	KEY(1, 2, KEY_F),
@@ -190,6 +196,8 @@ static int board_keymap[] = {
 	KEY(1, 5, KEY_J),
 	KEY(1, 6, KEY_K),
 	KEY(1, 7, KEY_L),
+//	KEY(1, 8, KEY_F7),	// XXX was moved to (7, 1)
+
 	KEY(2, 0, KEY_E),
 	KEY(2, 1, KEY_DOT),
 	KEY(2, 2, KEY_UP),
@@ -197,6 +205,8 @@ static int board_keymap[] = {
 	KEY(2, 5, KEY_Z),
 	KEY(2, 6, KEY_X),
 	KEY(2, 7, KEY_C),
+	KEY(2, 8, KEY_F9),	// XXX was F8 and moved to (7, 2), F9 was (4, 8)
+
 	KEY(3, 0, KEY_R),
 	KEY(3, 1, KEY_V),
 	KEY(3, 2, KEY_B),
@@ -205,20 +215,24 @@ static int board_keymap[] = {
 	KEY(3, 5, KEY_SPACE),
 	KEY(3, 6, KEY_SPACE),
 	KEY(3, 7, KEY_LEFT),
+
 	KEY(4, 0, KEY_T),
 	KEY(4, 1, KEY_DOWN),
 	KEY(4, 2, KEY_RIGHT),
 	KEY(4, 4, KEY_LEFTCTRL),
-	KEY(4, 5, KEY_RIGHTALT),
-	KEY(4, 6, KEY_LEFTSHIFT),
+	KEY(4, 5, KEY_RIGHTALT),	// XXX was LEFTSHIFT
+	KEY(4, 6, KEY_LEFTSHIFT),	// XXX was FN which is now removed
+	KEY(4, 8, KEY_10),		// XXX was F9 and moved to (2, 8), F10 was (5, 8)
+
+
 	KEY(5, 0, KEY_Y),
+	KEY(5, 8, KEY_11),		// XXX was F10 and moved to (4, 8), F11 is new
+
 	KEY(6, 0, KEY_U),
+
 	KEY(7, 0, KEY_I),
-	KEY(7, 1, KEY_F7),
-	KEY(7, 2, KEY_F8),
-	KEY(0xff, 2, KEY_F9),
-	KEY(0xff, 4, KEY_F10),
-	KEY(0xff, 5, KEY_F11),
+	KEY(7, 1, KEY_F7),		// XXX was undefined
+	KEY(7, 2, KEY_F8),		// XXX was undefined
 };
 
 static struct matrix_keymap_data board_map_data = {
diff --git a/drivers/input/keyboard/twl4030_keypad.c b/drivers/input/keyboard/twl4030_keypad.c
index 7aa59e0..fb16b5e 100644
--- a/drivers/input/keyboard/twl4030_keypad.c
+++ b/drivers/input/keyboard/twl4030_keypad.c
@@ -51,8 +51,12 @@
  */
 #define TWL4030_MAX_ROWS	8	/* TWL4030 hard limit */
 #define TWL4030_MAX_COLS	8
-#define TWL4030_ROW_SHIFT	3
-#define TWL4030_KEYMAP_SIZE	(TWL4030_MAX_ROWS * TWL4030_MAX_COLS)
+/*
+ * Note that we add space for an extra column so that we can handle
+ * row lines connected to the gnd (see twl4030_col_xlate()).
+ */
+#define TWL4030_ROW_SHIFT	4
+#define TWL4030_KEYMAP_SIZE	(TWL4030_MAX_ROWS << TWL4030_ROW_SHIFT)
 
 struct twl4030_keypad {
 	unsigned short	keymap[TWL4030_KEYMAP_SIZE];
@@ -182,7 +186,7 @@ static int twl4030_read_kp_matrix_state(struct twl4030_keypad *kp, u16 *state)
 	return ret;
 }
 
-static int twl4030_is_in_ghost_state(struct twl4030_keypad *kp, u16 *key_state)
+static bool twl4030_is_in_ghost_state(struct twl4030_keypad *kp, u16 *key_state)
 {
 	int i;
 	u16 check = 0;
@@ -191,12 +195,12 @@ static int twl4030_is_in_ghost_state(struct twl4030_keypad *kp, u16 *key_state)
 		u16 col = key_state[i];
 
 		if ((col & check) && hweight16(col) > 1)
-			return 1;
+			return true;
 
 		check |= col;
 	}
 
-	return 0;
+	return false;
 }
 
 static void twl4030_kp_scan(struct twl4030_keypad *kp, bool release_all)
@@ -225,7 +229,8 @@ static void twl4030_kp_scan(struct twl4030_keypad *kp, bool release_all)
 		if (!changed)
 			continue;
 
-		for (col = 0; col < kp->n_cols; col++) {
+		/* Extra column handles "all gnd" rows */
+		for (col = 0; col < kp->n_cols + 1; col++) {
 			int code;
 
 			if (!(changed & (1 << col)))
