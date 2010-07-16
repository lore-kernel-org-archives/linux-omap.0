From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Buffer overrun in the TWL4030 keypad driver with Nokia RX51
Date: Fri, 16 Jul 2010 17:28:43 +0200
Message-ID: <201007161728.44227.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Amit Kucheria <amit.kucheria@verdurent.com>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi everybody,

I've spent the day debugging a kernel crash in the USB networking code to find 
out the problem was caused by a buffer overrun in the TWL4030 keypad driver. 

The Nokia RX51 board code (arch/arm/mach-omap2/board-rx51-peripherals.c) 
defines a key map for the matrix keypad keyboard. The hardware seems to use 
all of the 8 rows and 8 columns of the keypad, although not all possible 
locations are used.

The TWL4030 supports keypads with at most 8 rows and 8 columns. Most keys are 
defined with a row and column number between 0 and 7, except

        KEY(0xff, 2, KEY_F9),
        KEY(0xff, 4, KEY_F10),
        KEY(0xff, 5, KEY_F11),

The row number is set to 0xff. As the generic matrix keypad support 
(include/linux/input/matrix_keypad.h) supports at most 16 rows and 16 columns, 
it masks all but the lower 4 bits of the row and column numbers in the KEY 
macro.

#define MATRIX_MAX_ROWS         16
#define MATRIX_MAX_COLS         16

#define KEY(row, col, val)      ((((row) & (MATRIX_MAX_ROWS - 1)) << 24) |\
                                 (((col) & (MATRIX_MAX_COLS - 1)) << 16) |\
                                 (val & 0xffff))

This leads to an effective row number equal to 15.

The TWL4030 keypad driver (drivers/input/keyboard/twl4030_keypad.c) allocates 
in twl4030_kp_probe a 8x8 keycodes map, part of the twl4030_keypad structure.

#define TWL4030_MAX_ROWS        8       /* TWL4030 hard limit */
#define TWL4030_MAX_COLS        8
#define TWL4030_ROW_SHIFT       3
#define TWL4030_KEYMAP_SIZE     (TWL4030_MAX_ROWS * TWL4030_MAX_COLS)

struct twl4030_keypad {
        unsigned short  keymap[TWL4030_KEYMAP_SIZE];
...

It then calls matrix_keypad_build_keymap (include/linux/input/matrix_keypad.h) 
to initialize the keycodes map from the keymap defined in platform data. The 
function loops over all the keymap platform data entries, and initializes the 
corresponding keycodes map entry. The entry index is computed with

#define MATRIX_SCAN_CODE(row, col, row_shift)   (((row) << (row_shift)) + 
(col))

called with row_shift set to TWL4030_ROW_SHIFT, defined as 3.

For the 3 keys defined with a row equal to 0xff, the map entry index is then 
equal to (15 << 3) + col, which is bigger than the number of keycodes map 
entries in the twl4030_keypad structure. Writing to that invalid index 
overwrites random memory.

The 0xff row number is used to detect rows completely connected to ground (see 
the comment in twl4030_col_xlate, drivers/input/keyboard/twl4030_keypad.c). 
The related code in twl4030_col_xlate is obviously wrong, returning a column 
number too large for the allocated keycodes map if the hardware keypad has 8 
columns.

I can try to provide a patch, but I'm not familiar enough with the TWL4030 
keypad driver and the generic matrix keypad code to know what the best fix 
would be. Hopefully this should be quite clear for the TWL4030 keypad driver 
developers.

-- 
Regards,

Laurent Pinchart
