From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc1-omap git] twl4030_keypad cleanup
Date: Thu, 5 Feb 2009 16:54:15 -0800
Message-ID: <200902051654.15601.david-b@pacbell.net>
References: <200901200051.47122.david-b@pacbell.net> <200901222259.16234.david-b@pacbell.net> <20090204192115.GM7215@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:41579 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750990AbZBFAyT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Feb 2009 19:54:19 -0500
In-Reply-To: <20090204192115.GM7215@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: OMAP <linux-omap@vger.kernel.org>

On Wednesday 04 February 2009, Tony Lindgren wrote:
>=20
> > Start cleaning up the twl4030 keypad driver to become more
> > suitable for mainline.
> >=20
> > =A0- Remove false OMAP dependencies: =A0names, <mach/keypad.h>, Kco=
nfig
> > =A0- We don't need a miniature header file
> > =A0- Add missing input_sync()
> > =A0- ...
> >=20
> > The driver should also be renamed as "twl4030_keypad.c"; that will
> > be a different patch.
>=20
> Pushing this to l-o tree, let me know when/if you need the patch
> against the mainline tree added to the omap-upstream queue.

I'll (re?)send the mainline patch in a bit.

Meanwhile, here's the rename patch.

- Dave

=3D=3D=3D=3D=3D CUT HERE
=46rom: David Brownell <dbrownell@users.sourceforge.net>

Rename this so it no longer presumes needless OMAP dependency.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/input/keyboard/Makefile             |    2=20
 drivers/input/keyboard/omap-twl4030keypad.c |  489 -------------------=
------
 drivers/input/keyboard/twl4030keypad.c      |  493 +++++++++++++++++++=
+++++++
 3 files changed, 494 insertions(+), 490 deletions(-)

--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -22,7 +22,7 @@ obj-$(CONFIG_KEYBOARD_OMAP)		+=3D omap-key
 obj-$(CONFIG_OMAP_PS2)			+=3D innovator_ps2.o
 obj-$(CONFIG_KEYBOARD_TSC2301)		+=3D tsc2301_kp.o
 obj-$(CONFIG_KEYBOARD_LM8323)		+=3D lm8323.o
-obj-$(CONFIG_KEYBOARD_TWL4030)		+=3D omap-twl4030keypad.o
+obj-$(CONFIG_KEYBOARD_TWL4030)		+=3D twl4030keypad.o
 obj-$(CONFIG_KEYBOARD_PXA27x)		+=3D pxa27x_keypad.o
 obj-$(CONFIG_KEYBOARD_PXA930_ROTARY)	+=3D pxa930_rotary.o
 obj-$(CONFIG_KEYBOARD_AAED2000)		+=3D aaed2000_kbd.o
--- a/drivers/input/keyboard/omap-twl4030keypad.c
+++ /dev/null
@@ -1,489 +0,0 @@
-/*
- * drivers/input/keyboard/omap-twl4030keypad.c
- *
- * Copyright (C) 2007 Texas Instruments, Inc.
- * Copyright (C) 2008 Nokia Corporation
- *
- * Code re-written for 2430SDP by:
- * Syed Mohammed Khasim <x0khasim@ti.com>
- *
- * Initial Code:
- * Manjunatha G K <manjugk@ti.com>
- *
- * This program is free software; you can redistribute it and/or modif=
y
- * it under the terms of the GNU General Public License as published b=
y
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307=
 USA
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/input.h>
-#include <linux/platform_device.h>
-#include <linux/i2c/twl4030.h>
-
-/*
- * The TWL4030 family chips include a keypad controller that supports
- * up to an 8x8 switch matrix.  The controller can issue system wakeup
- * events, since it uses only the always-on 32KiHz oscillator, and has
- * an internal state machine that decodes pressed keys, including
- * multi-key combinations.
- *
- * This driver lets boards define what keycodes they wish to report fo=
r
- * which scancodes, as part of the "struct twl4030_keypad_data" used i=
n
- * the probe() routine.
- *
- * See the TPS65950 documentation; that's the general availability
- * version of the TWL5030 second generation part.
- */
-#define MAX_ROWS		8	/* TWL4030 hard limit */
-
-struct twl4030_keypad {
-	unsigned	*keymap;
-	unsigned int	keymapsize;
-	u16		kp_state[MAX_ROWS];
-	unsigned	n_rows;
-	unsigned	n_cols;
-	unsigned	irq;
-
-	struct device	*dbg_dev;
-	struct input_dev *input;
-};
-
-#define ROWCOL_MASK	KEY(0xf, 0xf, 0)
-#define KEYNUM_MASK	~PERSISTENT_KEY(0xf, 0xf)
-
-/*--------------------------------------------------------------------=
--*/
-
-/* arbitrary prescaler value 0..7 */
-#define PTV_PRESCALER			4
-
-/* Register Offsets */
-#define KEYP_CTRL			0x00
-#define KEYP_DEB			0x01
-#define KEYP_LONG_KEY			0x02
-#define KEYP_LK_PTV			0x03
-#define KEYP_TIMEOUT_L			0x04
-#define KEYP_TIMEOUT_H			0x05
-#define KEYP_KBC			0x06
-#define KEYP_KBR			0x07
-#define KEYP_SMS			0x08
-#define KEYP_FULL_CODE_7_0		0x09	/* row 0 column status */
-#define KEYP_FULL_CODE_15_8		0x0a	/* ... row 1 ... */
-#define KEYP_FULL_CODE_23_16		0x0b
-#define KEYP_FULL_CODE_31_24		0x0c
-#define KEYP_FULL_CODE_39_32		0x0d
-#define KEYP_FULL_CODE_47_40		0x0e
-#define KEYP_FULL_CODE_55_48		0x0f
-#define KEYP_FULL_CODE_63_56		0x10
-#define KEYP_ISR1			0x11
-#define KEYP_IMR1			0x12
-#define KEYP_ISR2			0x13
-#define KEYP_IMR2			0x14
-#define KEYP_SIR			0x15
-#define KEYP_EDR			0x16	/* edge triggers */
-#define KEYP_SIH_CTRL			0x17
-
-/* KEYP_CTRL_REG Fields */
-#define KEYP_CTRL_SOFT_NRST		BIT(0)
-#define KEYP_CTRL_SOFTMODEN		BIT(1)
-#define KEYP_CTRL_LK_EN			BIT(2)
-#define KEYP_CTRL_TOE_EN		BIT(3)
-#define KEYP_CTRL_TOLE_EN		BIT(4)
-#define KEYP_CTRL_RP_EN			BIT(5)
-#define KEYP_CTRL_KBD_ON		BIT(6)
-
-/* KEYP_DEB, KEYP_LONG_KEY, KEYP_TIMEOUT_x*/
-#define KEYP_PERIOD_US(t, prescale)	((t) / (31 << (prescale + 1)) - 1)
-
-/* KEYP_LK_PTV_REG Fields */
-#define KEYP_LK_PTV_PTV_SHIFT		5
-
-/* KEYP_{IMR,ISR,SIR} Fields */
-#define KEYP_IMR1_MIS			BIT(3)
-#define KEYP_IMR1_TO			BIT(2)
-#define KEYP_IMR1_LK			BIT(1)
-#define KEYP_IMR1_KP			BIT(0)
-
-/* KEYP_EDR Fields */
-#define KEYP_EDR_KP_FALLING		0x01
-#define KEYP_EDR_KP_RISING		0x02
-#define KEYP_EDR_KP_BOTH		0x03
-#define KEYP_EDR_LK_FALLING		0x04
-#define KEYP_EDR_LK_RISING		0x08
-#define KEYP_EDR_TO_FALLING		0x10
-#define KEYP_EDR_TO_RISING		0x20
-#define KEYP_EDR_MIS_FALLING		0x40
-#define KEYP_EDR_MIS_RISING		0x80
-
-
-/*--------------------------------------------------------------------=
--*/
-
-static int twl4030_kpread(struct twl4030_keypad *kp,
-		u8 *data, u32 reg, u8 num_bytes)
-{
-	int ret;
-
-	ret =3D twl4030_i2c_read(TWL4030_MODULE_KEYPAD, data, reg, num_bytes)=
;
-	if (ret < 0) {
-		dev_warn(kp->dbg_dev,
-			"Couldn't read TWL4030: %X - ret %d[%x]\n",
-			 reg, ret, ret);
-		return ret;
-	}
-	return ret;
-}
-
-static int twl4030_kpwrite_u8(struct twl4030_keypad *kp, u8 data, u32 =
reg)
-{
-	int ret;
-
-	ret =3D twl4030_i2c_write_u8(TWL4030_MODULE_KEYPAD, data, reg);
-	if (ret < 0) {
-		dev_warn(kp->dbg_dev,
-			"Could not write TWL4030: %X - ret %d[%x]\n",
-			 reg, ret, ret);
-		return ret;
-	}
-	return ret;
-}
-
-static int twl4030_find_key(struct twl4030_keypad *kp, int col, int ro=
w)
-{
-	int i, rc;
-
-	rc =3D KEY(col, row, 0);
-	for (i =3D 0; i < kp->keymapsize; i++)
-		if ((kp->keymap[i] & ROWCOL_MASK) =3D=3D rc)
-			return kp->keymap[i] & (KEYNUM_MASK | KEY_PERSISTENT);
-
-	return -EINVAL;
-}
-
-static inline u16 twl4030_col_xlate(struct twl4030_keypad *kp, u8 col)
-{
-	/* If all bits in a row are active for all coloumns then
-	 * we have that row line connected to gnd. Mark this
-	 * key on as if it was on matrix position n_cols (ie
-	 * one higher than the size of the matrix).
-	 */
-	if (col =3D=3D 0xFF)
-		return 1 << kp->n_cols;
-	else
-		return col & ((1 << kp->n_cols) - 1);
-}
-
-static int twl4030_read_kp_matrix_state(struct twl4030_keypad *kp, u16=
 *state)
-{
-	u8 new_state[MAX_ROWS];
-	int row;
-	int ret =3D twl4030_kpread(kp,
-				 new_state, KEYP_FULL_CODE_7_0, kp->n_rows);
-	if (ret >=3D 0) {
-		for (row =3D 0; row < kp->n_rows; row++)
-			state[row] =3D twl4030_col_xlate(kp, new_state[row]);
-	}
-	return ret;
-}
-
-static int twl4030_is_in_ghost_state(struct twl4030_keypad *kp, u16 *k=
ey_state)
-{
-	int i;
-	u16 check =3D 0;
-
-	for (i =3D 0; i < kp->n_rows; i++) {
-		u16 col =3D key_state[i];
-
-		if ((col & check) && hweight16(col) > 1)
-			return 1;
-		check |=3D col;
-	}
-
-	return 0;
-}
-
-static void twl4030_kp_scan(struct twl4030_keypad *kp, int release_all=
)
-{
-	u16 new_state[MAX_ROWS];
-	int col, row;
-
-	if (release_all)
-		memset(new_state, 0, sizeof(new_state));
-	else {
-		/* check for any changes */
-		int ret =3D twl4030_read_kp_matrix_state(kp, new_state);
-
-		if (ret < 0)	/* panic ... */
-			return;
-		if (twl4030_is_in_ghost_state(kp, new_state))
-			return;
-	}
-
-	/* check for changes and print those */
-	for (row =3D 0; row < kp->n_rows; row++) {
-		int changed =3D new_state[row] ^ kp->kp_state[row];
-
-		if (!changed)
-			continue;
-
-		for (col =3D 0; col < kp->n_cols; col++) {
-			int key;
-
-			if (!(changed & (1 << col)))
-				continue;
-
-			dev_dbg(kp->dbg_dev, "key [%d:%d] %s\n", row, col,
-				(new_state[row] & (1 << col)) ?
-				"press" : "release");
-
-			key =3D twl4030_find_key(kp, col, row);
-			if (key < 0)
-				dev_warn(kp->dbg_dev,
-					"Spurious key event %d-%d\n",
-					 col, row);
-			else if (key & KEY_PERSISTENT)
-				continue;
-			else
-				input_report_key(kp->input, key,
-						 new_state[row] & (1 << col));
-		}
-		kp->kp_state[row] =3D new_state[row];
-	}
-	input_sync(kp->input);
-}
-
-/*
- * Keypad interrupt handler
- */
-static irqreturn_t do_kp_irq(int irq, void *_kp)
-{
-	struct twl4030_keypad *kp =3D _kp;
-	u8 reg;
-	int ret;
-
-#ifdef CONFIG_LOCKDEP
-	/* WORKAROUND for lockdep forcing IRQF_DISABLED on us, which
-	 * we don't want and can't tolerate.  Although it might be
-	 * friendlier not to borrow this thread context...
-	 */
-	local_irq_enable();
-#endif
-
-	/* Read & Clear TWL4030 pending interrupt */
-	ret =3D twl4030_kpread(kp, &reg, KEYP_ISR1, 1);
-
-	/* Release all keys if I2C has gone bad or
-	 * the KEYP has gone to idle state */
-	if ((ret >=3D 0) && (reg & KEYP_IMR1_KP))
-		twl4030_kp_scan(kp, 0);
-	else
-		twl4030_kp_scan(kp, 1);
-
-	return IRQ_HANDLED;
-}
-
-/*
- * Registers keypad device with input subsystem
- * and configures TWL4030 keypad registers
- */
-static int __devinit twl4030_kp_probe(struct platform_device *pdev)
-{
-	u8 reg;
-	int i;
-	int ret =3D 0;
-	struct twl4030_keypad *kp;
-	struct twl4030_keypad_data *pdata =3D pdev->dev.platform_data;
-
-	if (!pdata || !pdata->rows || !pdata->cols || !pdata->keymap
-			|| pdata->rows > 8 || pdata->cols > 8) {
-		dev_err(&pdev->dev, "Invalid platform_data\n");
-		return -EINVAL;
-	}
-
-	kp =3D kzalloc(sizeof(*kp), GFP_KERNEL);
-	if (!kp)
-		return -ENOMEM;
-
-	platform_set_drvdata(pdev, kp);
-
-	/* Get the debug Device */
-	kp->dbg_dev =3D &pdev->dev;
-
-	kp->input =3D input_allocate_device();
-	if (!kp->input) {
-		kfree(kp);
-		return -ENOMEM;
-	}
-
-	kp->keymap =3D pdata->keymap;
-	kp->keymapsize =3D pdata->keymapsize;
-	kp->n_rows =3D pdata->rows;
-	kp->n_cols =3D pdata->cols;
-	kp->irq =3D platform_get_irq(pdev, 0);
-
-	/* setup input device */
-	__set_bit(EV_KEY, kp->input->evbit);
-
-	/* Enable auto repeat feature of Linux input subsystem */
-	if (pdata->rep)
-		__set_bit(EV_REP, kp->input->evbit);
-
-	for (i =3D 0; i < kp->keymapsize; i++)
-		__set_bit(kp->keymap[i] & KEYNUM_MASK,
-				kp->input->keybit);
-
-	kp->input->name		=3D "TWL4030 Keypad";
-	kp->input->phys		=3D "twl4030_keypad/input0";
-	kp->input->dev.parent	=3D &pdev->dev;
-
-	kp->input->id.bustype	=3D BUS_HOST;
-	kp->input->id.vendor	=3D 0x0001;
-	kp->input->id.product	=3D 0x0001;
-	kp->input->id.version	=3D 0x0003;
-
-	kp->input->keycode	=3D kp->keymap;
-	kp->input->keycodesize	=3D sizeof(unsigned int);
-	kp->input->keycodemax	=3D kp->keymapsize;
-
-	ret =3D input_register_device(kp->input);
-	if (ret < 0) {
-		dev_err(kp->dbg_dev,
-			"Unable to register twl4030 keypad device\n");
-		goto err2;
-	}
-
-	/* Enable controller, with hardware decoding but not autorepeat */
-	reg =3D KEYP_CTRL_SOFT_NRST | KEYP_CTRL_SOFTMODEN
-		| KEYP_CTRL_TOE_EN | KEYP_CTRL_KBD_ON;
-	ret =3D twl4030_kpwrite_u8(kp, reg, KEYP_CTRL);
-	if (ret < 0)
-		goto err3;
-
-	/* NOTE:  we could use sih_setup() here to package keypad
-	 * event sources as four different IRQs ... but we don't.
-	 */
-
-	/* Enable TO rising and KP rising and falling edge detection */
-	reg =3D KEYP_EDR_KP_BOTH | KEYP_EDR_TO_RISING;
-	ret =3D twl4030_kpwrite_u8(kp, reg, KEYP_EDR);
-	if (ret < 0)
-		goto err3;
-
-	/* Set PTV prescaler Field */
-	reg =3D (PTV_PRESCALER << KEYP_LK_PTV_PTV_SHIFT);
-	ret =3D twl4030_kpwrite_u8(kp, reg, KEYP_LK_PTV);
-	if (ret < 0)
-		goto err3;
-
-	/* Set key debounce time to 20 ms */
-	i =3D KEYP_PERIOD_US(20000, PTV_PRESCALER);
-	ret =3D twl4030_kpwrite_u8(kp, i, KEYP_DEB);
-	if (ret < 0)
-		goto err3;
-
-	/* Set timeout period to 100 ms */
-	i =3D KEYP_PERIOD_US(200000, PTV_PRESCALER);
-	ret =3D twl4030_kpwrite_u8(kp, (i & 0xFF), KEYP_TIMEOUT_L);
-	if (ret < 0)
-		goto err3;
-	ret =3D twl4030_kpwrite_u8(kp, (i >> 8), KEYP_TIMEOUT_H);
-	if (ret < 0)
-		goto err3;
-
-	/* Enable Clear-on-Read; disable remembering events that fire
-	 * after the IRQ but before our handler acks (reads) them,
-	 */
-	reg =3D TWL4030_SIH_CTRL_COR_MASK | TWL4030_SIH_CTRL_PENDDIS_MASK;
-	ret =3D twl4030_kpwrite_u8(kp, reg, KEYP_SIH_CTRL);
-	if (ret < 0)
-		goto err3;
-
-	/* initialize key state; irqs update it from here on */
-	ret =3D twl4030_read_kp_matrix_state(kp, kp->kp_state);
-	if (ret < 0)
-		goto err3;
-
-	/*
-	 * This ISR will always execute in kernel thread context because of
-	 * the need to access the TWL4030 over the I2C bus.
-	 *
-	 * NOTE:  we assume this host is wired to TWL4040 INT1, not INT2 ...
-	 */
-	ret =3D request_irq(kp->irq, do_kp_irq, 0, pdev->name, kp);
-	if (ret < 0) {
-		dev_info(kp->dbg_dev, "request_irq failed for irq no=3D%d\n",
-			kp->irq);
-		goto err3;
-	} else {
-		/* Enable KP and TO interrupts now. */
-		reg =3D (u8) ~(KEYP_IMR1_KP | KEYP_IMR1_TO);
-		ret =3D twl4030_kpwrite_u8(kp, reg, KEYP_IMR1);
-		if (ret < 0)
-			goto err5;
-	}
-
-	return ret;
-err5:
-	/* mask all events - we don't care about the result */
-	(void) twl4030_kpwrite_u8(kp, 0xff, KEYP_IMR1);
-	free_irq(kp->irq, NULL);
-err3:
-	input_unregister_device(kp->input);
-	kp->input =3D NULL;
-err2:
-	input_free_device(kp->input);
-	kfree(kp);
-	return -ENODEV;
-}
-
-static int __devexit twl4030_kp_remove(struct platform_device *pdev)
-{
-	struct twl4030_keypad *kp =3D platform_get_drvdata(pdev);
-
-	free_irq(kp->irq, kp);
-	input_unregister_device(kp->input);
-	kfree(kp);
-
-	return 0;
-}
-
-MODULE_ALIAS("platform:twl4030_keypad");
-
-static struct platform_driver twl4030_kp_driver =3D {
-	.probe		=3D twl4030_kp_probe,
-	.remove		=3D __devexit_p(twl4030_kp_remove),
-	.driver		=3D {
-		.name	=3D "twl4030_keypad",
-		.owner	=3D THIS_MODULE,
-	},
-};
-
-/*
- * OMAP TWL4030 Keypad init
- */
-static int __init twl4030_kp_init(void)
-{
-	return platform_driver_register(&twl4030_kp_driver);
-}
-module_init(twl4030_kp_init);
-
-static void __exit twl4030_kp_exit(void)
-{
-	platform_driver_unregister(&twl4030_kp_driver);
-}
-module_exit(twl4030_kp_exit);
-
-MODULE_AUTHOR("Texas Instruments");
-MODULE_DESCRIPTION("TWL4030 Keypad Driver");
-MODULE_LICENSE("GPL");
--- /dev/null
+++ b/drivers/input/keyboard/twl4030keypad.c
@@ -0,0 +1,493 @@
+/*
+ * twl4030keypad.c - driver for 8x8 keypad controller in twl4030 chips
+ *
+ * Copyright (C) 2007 Texas Instruments, Inc.
+ * Copyright (C) 2008 Nokia Corporation
+ *
+ * Code re-written for 2430SDP by:
+ * Syed Mohammed Khasim <x0khasim@ti.com>
+ *
+ * Initial Code:
+ * Manjunatha G K <manjugk@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License as published b=
y
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307=
 USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/input.h>
+#include <linux/platform_device.h>
+#include <linux/i2c/twl4030.h>
+
+
+/*
+ * The TWL4030 family chips include a keypad controller that supports
+ * up to an 8x8 switch matrix.  The controller can issue system wakeup
+ * events, since it uses only the always-on 32KiHz oscillator, and has
+ * an internal state machine that decodes pressed keys, including
+ * multi-key combinations.
+ *
+ * This driver lets boards define what keycodes they wish to report fo=
r
+ * which scancodes, as part of the "struct twl4030_keypad_data" used i=
n
+ * the probe() routine.
+ *
+ * See the TPS65950 documentation; that's the general availability
+ * version of the TWL5030 second generation part.
+ */
+#define MAX_ROWS		8	/* TWL4030 hard limit */
+
+struct twl4030_keypad {
+	unsigned	*keymap;
+	unsigned int	keymapsize;
+	u16		kp_state[MAX_ROWS];
+	unsigned	n_rows;
+	unsigned	n_cols;
+	unsigned	irq;
+
+	struct device	*dbg_dev;
+	struct input_dev *input;
+};
+
+#define ROWCOL_MASK	KEY(0xf, 0xf, 0)
+#define KEYNUM_MASK	~PERSISTENT_KEY(0xf, 0xf)
+
+/*--------------------------------------------------------------------=
--*/
+
+/* arbitrary prescaler value 0..7 */
+#define PTV_PRESCALER			4
+
+/* Register Offsets */
+#define KEYP_CTRL			0x00
+#define KEYP_DEB			0x01
+#define KEYP_LONG_KEY			0x02
+#define KEYP_LK_PTV			0x03
+#define KEYP_TIMEOUT_L			0x04
+#define KEYP_TIMEOUT_H			0x05
+#define KEYP_KBC			0x06
+#define KEYP_KBR			0x07
+#define KEYP_SMS			0x08
+#define KEYP_FULL_CODE_7_0		0x09	/* row 0 column status */
+#define KEYP_FULL_CODE_15_8		0x0a	/* ... row 1 ... */
+#define KEYP_FULL_CODE_23_16		0x0b
+#define KEYP_FULL_CODE_31_24		0x0c
+#define KEYP_FULL_CODE_39_32		0x0d
+#define KEYP_FULL_CODE_47_40		0x0e
+#define KEYP_FULL_CODE_55_48		0x0f
+#define KEYP_FULL_CODE_63_56		0x10
+#define KEYP_ISR1			0x11
+#define KEYP_IMR1			0x12
+#define KEYP_ISR2			0x13
+#define KEYP_IMR2			0x14
+#define KEYP_SIR			0x15
+#define KEYP_EDR			0x16	/* edge triggers */
+#define KEYP_SIH_CTRL			0x17
+
+/* KEYP_CTRL_REG Fields */
+#define KEYP_CTRL_SOFT_NRST		BIT(0)
+#define KEYP_CTRL_SOFTMODEN		BIT(1)
+#define KEYP_CTRL_LK_EN			BIT(2)
+#define KEYP_CTRL_TOE_EN		BIT(3)
+#define KEYP_CTRL_TOLE_EN		BIT(4)
+#define KEYP_CTRL_RP_EN			BIT(5)
+#define KEYP_CTRL_KBD_ON		BIT(6)
+
+/* KEYP_DEB, KEYP_LONG_KEY, KEYP_TIMEOUT_x*/
+#define KEYP_PERIOD_US(t, prescale)	((t) / (31 << (prescale + 1)) - 1)
+
+/* KEYP_LK_PTV_REG Fields */
+#define KEYP_LK_PTV_PTV_SHIFT		5
+
+/* KEYP_{IMR,ISR,SIR} Fields */
+#define KEYP_IMR1_MIS			BIT(3)
+#define KEYP_IMR1_TO			BIT(2)
+#define KEYP_IMR1_LK			BIT(1)
+#define KEYP_IMR1_KP			BIT(0)
+
+/* KEYP_EDR Fields */
+#define KEYP_EDR_KP_FALLING		0x01
+#define KEYP_EDR_KP_RISING		0x02
+#define KEYP_EDR_KP_BOTH		0x03
+#define KEYP_EDR_LK_FALLING		0x04
+#define KEYP_EDR_LK_RISING		0x08
+#define KEYP_EDR_TO_FALLING		0x10
+#define KEYP_EDR_TO_RISING		0x20
+#define KEYP_EDR_MIS_FALLING		0x40
+#define KEYP_EDR_MIS_RISING		0x80
+
+
+/*--------------------------------------------------------------------=
--*/
+
+static int twl4030_kpread(struct twl4030_keypad *kp,
+		u8 *data, u32 reg, u8 num_bytes)
+{
+	int ret;
+
+	ret =3D twl4030_i2c_read(TWL4030_MODULE_KEYPAD, data, reg, num_bytes)=
;
+	if (ret < 0) {
+		dev_warn(kp->dbg_dev,
+			"Couldn't read TWL4030: %X - ret %d[%x]\n",
+			 reg, ret, ret);
+		return ret;
+	}
+	return ret;
+}
+
+static int twl4030_kpwrite_u8(struct twl4030_keypad *kp, u8 data, u32 =
reg)
+{
+	int ret;
+
+	ret =3D twl4030_i2c_write_u8(TWL4030_MODULE_KEYPAD, data, reg);
+	if (ret < 0) {
+		dev_warn(kp->dbg_dev,
+			"Could not write TWL4030: %X - ret %d[%x]\n",
+			 reg, ret, ret);
+		return ret;
+	}
+	return ret;
+}
+
+static int twl4030_find_key(struct twl4030_keypad *kp, int col, int ro=
w)
+{
+	int i, rc;
+
+	rc =3D KEY(col, row, 0);
+	for (i =3D 0; i < kp->keymapsize; i++)
+		if ((kp->keymap[i] & ROWCOL_MASK) =3D=3D rc)
+			return kp->keymap[i] & (KEYNUM_MASK | KEY_PERSISTENT);
+
+	return -EINVAL;
+}
+
+static inline u16 twl4030_col_xlate(struct twl4030_keypad *kp, u8 col)
+{
+	/* If all bits in a row are active for all coloumns then
+	 * we have that row line connected to gnd. Mark this
+	 * key on as if it was on matrix position n_cols (ie
+	 * one higher than the size of the matrix).
+	 */
+	if (col =3D=3D 0xFF)
+		return 1 << kp->n_cols;
+	else
+		return col & ((1 << kp->n_cols) - 1);
+}
+
+static int twl4030_read_kp_matrix_state(struct twl4030_keypad *kp, u16=
 *state)
+{
+	u8 new_state[MAX_ROWS];
+	int row;
+	int ret =3D twl4030_kpread(kp,
+				 new_state, KEYP_FULL_CODE_7_0, kp->n_rows);
+	if (ret >=3D 0) {
+		for (row =3D 0; row < kp->n_rows; row++)
+			state[row] =3D twl4030_col_xlate(kp, new_state[row]);
+	}
+	return ret;
+}
+
+static int twl4030_is_in_ghost_state(struct twl4030_keypad *kp, u16 *k=
ey_state)
+{
+	int i;
+	u16 check =3D 0;
+
+	for (i =3D 0; i < kp->n_rows; i++) {
+		u16 col =3D key_state[i];
+
+		if ((col & check) && hweight16(col) > 1)
+			return 1;
+		check |=3D col;
+	}
+
+	return 0;
+}
+
+static void twl4030_kp_scan(struct twl4030_keypad *kp, int release_all=
)
+{
+	u16 new_state[MAX_ROWS];
+	int col, row;
+
+	if (release_all)
+		memset(new_state, 0, sizeof(new_state));
+	else {
+		/* check for any changes */
+		int ret =3D twl4030_read_kp_matrix_state(kp, new_state);
+
+		if (ret < 0)	/* panic ... */
+			return;
+		if (twl4030_is_in_ghost_state(kp, new_state))
+			return;
+	}
+
+	/* check for changes and print those */
+	for (row =3D 0; row < kp->n_rows; row++) {
+		int changed =3D new_state[row] ^ kp->kp_state[row];
+
+		if (!changed)
+			continue;
+
+		for (col =3D 0; col < kp->n_cols; col++) {
+			int key;
+
+			if (!(changed & (1 << col)))
+				continue;
+
+			dev_dbg(kp->dbg_dev, "key [%d:%d] %s\n", row, col,
+				(new_state[row] & (1 << col)) ?
+				"press" : "release");
+
+			key =3D twl4030_find_key(kp, col, row);
+			if (key < 0)
+				dev_warn(kp->dbg_dev,
+					"Spurious key event %d-%d\n",
+					 col, row);
+			else if (key & KEY_PERSISTENT)
+				continue;
+			else
+				input_report_key(kp->input, key,
+						 new_state[row] & (1 << col));
+		}
+		kp->kp_state[row] =3D new_state[row];
+	}
+	input_sync(kp->input);
+}
+
+/*
+ * Keypad interrupt handler
+ */
+static irqreturn_t do_kp_irq(int irq, void *_kp)
+{
+	struct twl4030_keypad *kp =3D _kp;
+	u8 reg;
+	int ret;
+
+#ifdef CONFIG_LOCKDEP
+	/* WORKAROUND for lockdep forcing IRQF_DISABLED on us, which
+	 * we don't want and can't tolerate.  Although it might be
+	 * friendlier not to borrow this thread context...
+	 */
+	local_irq_enable();
+#endif
+
+	/* Read & Clear TWL4030 pending interrupt */
+	ret =3D twl4030_kpread(kp, &reg, KEYP_ISR1, 1);
+
+	/* Release all keys if I2C has gone bad or
+	 * the KEYP has gone to idle state */
+	if ((ret >=3D 0) && (reg & KEYP_IMR1_KP))
+		twl4030_kp_scan(kp, 0);
+	else
+		twl4030_kp_scan(kp, 1);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * Registers keypad device with input subsystem
+ * and configures TWL4030 keypad registers
+ */
+static int __devinit twl4030_kp_probe(struct platform_device *pdev)
+{
+	u8 reg;
+	int i;
+	int ret =3D 0;
+	struct twl4030_keypad *kp;
+	struct twl4030_keypad_data *pdata =3D pdev->dev.platform_data;
+
+	if (!pdata || !pdata->rows || !pdata->cols || !pdata->keymap
+			|| pdata->rows > 8 || pdata->cols > 8) {
+		dev_err(&pdev->dev, "Invalid platform_data\n");
+		return -EINVAL;
+	}
+
+	kp =3D kzalloc(sizeof(*kp), GFP_KERNEL);
+	if (!kp)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, kp);
+
+	/* Get the debug Device */
+	kp->dbg_dev =3D &pdev->dev;
+
+	kp->input =3D input_allocate_device();
+	if (!kp->input) {
+		kfree(kp);
+		return -ENOMEM;
+	}
+
+	kp->keymap =3D pdata->keymap;
+	kp->keymapsize =3D pdata->keymapsize;
+	kp->n_rows =3D pdata->rows;
+	kp->n_cols =3D pdata->cols;
+	kp->irq =3D platform_get_irq(pdev, 0);
+
+	/* setup input device */
+	__set_bit(EV_KEY, kp->input->evbit);
+
+	/* Enable auto repeat feature of Linux input subsystem */
+	if (pdata->rep)
+		__set_bit(EV_REP, kp->input->evbit);
+
+	for (i =3D 0; i < kp->keymapsize; i++)
+		__set_bit(kp->keymap[i] & KEYNUM_MASK,
+				kp->input->keybit);
+
+	kp->input->name		=3D "TWL4030 Keypad";
+	kp->input->phys		=3D "twl4030_keypad/input0";
+	kp->input->dev.parent	=3D &pdev->dev;
+
+	kp->input->id.bustype	=3D BUS_HOST;
+	kp->input->id.vendor	=3D 0x0001;
+	kp->input->id.product	=3D 0x0001;
+	kp->input->id.version	=3D 0x0003;
+
+	kp->input->keycode	=3D kp->keymap;
+	kp->input->keycodesize	=3D sizeof(unsigned int);
+	kp->input->keycodemax	=3D kp->keymapsize;
+
+	ret =3D input_register_device(kp->input);
+	if (ret < 0) {
+		dev_err(kp->dbg_dev,
+			"Unable to register twl4030 keypad device\n");
+		goto err2;
+	}
+
+	/* Enable controller, with hardware decoding but not autorepeat */
+	reg =3D KEYP_CTRL_SOFT_NRST | KEYP_CTRL_SOFTMODEN
+		| KEYP_CTRL_TOE_EN | KEYP_CTRL_KBD_ON;
+	ret =3D twl4030_kpwrite_u8(kp, reg, KEYP_CTRL);
+	if (ret < 0)
+		goto err3;
+
+	/* NOTE:  we could use sih_setup() here to package keypad
+	 * event sources as four different IRQs ... but we don't.
+	 */
+
+	/* Enable TO rising and KP rising and falling edge detection */
+	reg =3D KEYP_EDR_KP_BOTH | KEYP_EDR_TO_RISING;
+	ret =3D twl4030_kpwrite_u8(kp, reg, KEYP_EDR);
+	if (ret < 0)
+		goto err3;
+
+	/* Set PTV prescaler Field */
+	reg =3D (PTV_PRESCALER << KEYP_LK_PTV_PTV_SHIFT);
+	ret =3D twl4030_kpwrite_u8(kp, reg, KEYP_LK_PTV);
+	if (ret < 0)
+		goto err3;
+
+	/* Set key debounce time to 20 ms */
+	i =3D KEYP_PERIOD_US(20000, PTV_PRESCALER);
+	ret =3D twl4030_kpwrite_u8(kp, i, KEYP_DEB);
+	if (ret < 0)
+		goto err3;
+
+	/* Set timeout period to 100 ms */
+	i =3D KEYP_PERIOD_US(200000, PTV_PRESCALER);
+	ret =3D twl4030_kpwrite_u8(kp, (i & 0xFF), KEYP_TIMEOUT_L);
+	if (ret < 0)
+		goto err3;
+	ret =3D twl4030_kpwrite_u8(kp, (i >> 8), KEYP_TIMEOUT_H);
+	if (ret < 0)
+		goto err3;
+
+	/* Enable Clear-on-Read; disable remembering events that fire
+	 * after the IRQ but before our handler acks (reads) them,
+	 */
+	reg =3D TWL4030_SIH_CTRL_COR_MASK | TWL4030_SIH_CTRL_PENDDIS_MASK;
+	ret =3D twl4030_kpwrite_u8(kp, reg, KEYP_SIH_CTRL);
+	if (ret < 0)
+		goto err3;
+
+	/* initialize key state; irqs update it from here on */
+	ret =3D twl4030_read_kp_matrix_state(kp, kp->kp_state);
+	if (ret < 0)
+		goto err3;
+
+	/*
+	 * This ISR will always execute in kernel thread context because of
+	 * the need to access the TWL4030 over the I2C bus.
+	 *
+	 * NOTE:  we assume this host is wired to TWL4040 INT1, not INT2 ...
+	 */
+	ret =3D request_irq(kp->irq, do_kp_irq, 0, pdev->name, kp);
+	if (ret < 0) {
+		dev_info(kp->dbg_dev, "request_irq failed for irq no=3D%d\n",
+			kp->irq);
+		goto err3;
+	} else {
+		/* Enable KP and TO interrupts now. */
+		reg =3D (u8) ~(KEYP_IMR1_KP | KEYP_IMR1_TO);
+		ret =3D twl4030_kpwrite_u8(kp, reg, KEYP_IMR1);
+		if (ret < 0)
+			goto err5;
+	}
+
+	return ret;
+err5:
+	/* mask all events - we don't care about the result */
+	(void) twl4030_kpwrite_u8(kp, 0xff, KEYP_IMR1);
+	free_irq(kp->irq, NULL);
+err3:
+	input_unregister_device(kp->input);
+	kp->input =3D NULL;
+err2:
+	input_free_device(kp->input);
+	kfree(kp);
+	return -ENODEV;
+}
+
+static int __devexit twl4030_kp_remove(struct platform_device *pdev)
+{
+	struct twl4030_keypad *kp =3D platform_get_drvdata(pdev);
+
+	free_irq(kp->irq, kp);
+	input_unregister_device(kp->input);
+	kfree(kp);
+
+	return 0;
+}
+
+/*
+ * NOTE: twl4030 are multi-function devices connected via I2C.
+ * So this device is a child of an I2C parent, thus it needs to
+ * support unplug/replug (which most platform devices don't).
+ */
+
+MODULE_ALIAS("platform:twl4030_keypad");
+
+static struct platform_driver twl4030_kp_driver =3D {
+	.probe		=3D twl4030_kp_probe,
+	.remove		=3D __devexit_p(twl4030_kp_remove),
+	.driver		=3D {
+		.name	=3D "twl4030_keypad",
+		.owner	=3D THIS_MODULE,
+	},
+};
+
+static int __init twl4030_kp_init(void)
+{
+	return platform_driver_register(&twl4030_kp_driver);
+}
+module_init(twl4030_kp_init);
+
+static void __exit twl4030_kp_exit(void)
+{
+	platform_driver_unregister(&twl4030_kp_driver);
+}
+module_exit(twl4030_kp_exit);
+
+MODULE_AUTHOR("Texas Instruments");
+MODULE_DESCRIPTION("TWL4030 Keypad Driver");
+MODULE_LICENSE("GPL");

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
