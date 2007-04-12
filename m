From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH / RFC] TWL4030 Keypad driver support (final)
Date: Wed, 11 Apr 2007 20:21:27 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47A95875@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


This patch adds TWL4030 Keypad driver support for 2430 SDP.=20

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files:
 drivers/input/keyboard/Kconfig
 drivers/input/keyboard/Makefile
 drivers/input/keyboard/omap-twl4030keypad.c
 drivers/input/keyboard/twl4030-keypad.h=20
 include/asm-arm/arch-omap/board-2430sdp.h
 include/asm-arm/arch-omap/twl4030.h
 arch/arm/mach-omap2/board-2430sdp.c
=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff -purN linux-omap/drivers/input/keyboard/Kconfig
lin_for_hsi2c/drivers/input/keyboard/Kconfig
--- linux-omap/drivers/input/keyboard/Kconfig	2007-04-02
02:30:03.000000000 -0500
+++ lin_for_hsi2c/drivers/input/keyboard/Kconfig	2007-04-10
15:23:03.000000000 -0500
@@ -203,6 +203,15 @@ config KEYBOARD_OMAP
 	  To compile this driver as a module, choose M here: the
 	  module will be called omap-keypad.
=20
+config KEYBOARD_TWL4030
+	tristate "TI TWL4030 keypad support"
+	depends on INPUT_KEYBOARD && TWL4030_CORE && MACH_OMAP_2430SDP
+	help
+	  Say Y here if you want to use the OMAP TWL4030 keypad.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called omap-twl4030keypad.
+
 config OMAP_PS2
 	tristate "TI OMAP Innovator 1510 PS/2 keyboard & mouse support"
 	depends on ARCH_OMAP15XX && MACH_OMAP_INNOVATOR
diff -purN linux-omap/drivers/input/keyboard/Makefile
lin_for_hsi2c/drivers/input/keyboard/Makefile
--- linux-omap/drivers/input/keyboard/Makefile	2007-04-02
02:30:03.000000000 -0500
+++ lin_for_hsi2c/drivers/input/keyboard/Makefile	2007-04-10
15:21:15.000000000 -0500
@@ -21,4 +21,4 @@ obj-$(CONFIG_OMAP_PS2)			+=3D
innovator_ps
 obj-$(CONFIG_KEYBOARD_AAED2000)         +=3D aaed2000_kbd.o
 obj-$(CONFIG_KEYBOARD_GPIO)		+=3D gpio_keys.o
 obj-$(CONFIG_KEYBOARD_TSC2301)		+=3D tsc2301_kp.o
-
+obj-$(CONFIG_KEYBOARD_TWL4030)	  +=3D omap-twl4030keypad.o
diff -purN linux-omap/drivers/input/keyboard/omap-twl4030keypad.c
lin_for_hsi2c/drivers/input/keyboard/omap-twl4030keypad.c
--- linux-omap/drivers/input/keyboard/omap-twl4030keypad.c
1969-12-31 18:00:00.000000000 -0600
+++ lin_for_hsi2c/drivers/input/keyboard/omap-twl4030keypad.c
2007-04-11 13:05:20.000000000 -0500
@@ -0,0 +1,458 @@
+/*
+ * drivers/input/omap-twl4030keypad.c
+ *
+ * Copyright (C) 2007 Texas Instruments, Inc.
+ *
+ * Code re-arranged and cleaned up for 2430SDP by:
+ * Syed Mohammed Khasim <x0khasim@ti.com>
+ *
+ * Initial Code:
+ * Manjunatha G K <manjugk@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
USA
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/types.h>
+#include <linux/input.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/i2c.h>
+#include <asm/irq.h>
+#include <asm/arch/keypad.h>
+#include <asm/arch/twl4030.h>
+#include "twl4030-keypad.h"
+
+#define OMAP_TWL4030KEYPAD_LOG_LEVEL	1
+
+#define KEY(col, row, val)	(((col) << 28) | ((row) << 24) | (val))
+#define NUM_ROWS		5
+#define NUM_COLS		6
+
+#define ROW_MASK		((1<<NUM_ROWS)-1)
+
+#define SCAN_RATE		HZ/20
+#define KEYNUM_MASK		0xFF000000
+#define ROWCOL_MASK		0x00FFFFFF
+
+/* Driver Name */
+#define OMAP_TWL4030KEYPAD_NAME		"omap_twl4030keypad"
+
+#ifndef CONFIG_TWL4030KEY_AUTORPT
+#define CONFIG_TWL4030KEY_AUTORPT	100
+#endif
+
+#define SCAN_RATE			HZ/20
+
+#if (OMAP_TWL4030KEYPAD_LOG_LEVEL >=3D 1)
+char *switch_name[NUM_ROWS][NUM_COLS] =3D {
+	{"S2_L", "S2_D", "S2_S", "S3", "S4", "S23"},
+	{"S2_R", "S2_U", "S5", "S6", "S7", "S24"},
+	{"S8", "S9", "S10", "S11", "S12", "S25"},
+	{"S13", "S14", "S15", "S16", "S17", "S26"},
+	{"S18", "S19", "S20", "S21", "S22", "S27"},
+};
+#endif
+
+/* Global variables */
+static int *keymap;
+static unsigned char keypad_state[NUM_ROWS];
+
+/* Function Templates */
+static struct input_dev *omap_twl4030kp;
+struct timer_list kptimer;
+static void omap_kp_timer(unsigned long);
+static void twl4030_keypad_scan(void);
+struct work_struct timer_work;
+void twl4030_kp_work(void *data);
+void twl4030_timer_work(void *data);
+
+static int twl4030_kpread_u8(u32 module, u8 * data, u32 reg)
+{
+	int ret;
+	ret =3D twl4030_i2c_read_u8(module, data, reg);
+	if (ret < 0) {
+		printk(KERN_WARNING
+			"Could not read TWL4030 register %X - returned
%d[%x]\n",
+			reg, ret, ret);
+		return ret;
+	}
+	return ret;
+}
+
+static int twl4030_kpwrite_u8(u32 module, u8 data, u32 reg)
+{
+	int ret;
+	ret =3D twl4030_i2c_write_u8(module, data, reg);
+	if (ret < 0) {
+		printk(KERN_WARNING
+			"Could not write TWL4030 register %X - returned
%d[%x]\n",
+			reg, ret, ret);
+		return ret;
+	}
+	return ret;
+}
+
+static inline int omap_kp_find_key(int col, int row)
+{
+	int i, key;
+
+	key =3D KEY(col, row, 0);
+	for (i =3D 0; keymap[i] !=3D 0; i++) {
+		if ((keymap[i] & KEYNUM_MASK) =3D=3D key) {
+			return keymap[i] & ROWCOL_MASK;
+		}
+	}
+	return -EINVAL;
+}
+
+static void twl4030_keypad_scan(void) {
+
+	unsigned char new_state[NUM_ROWS], changed, key_down =3D 0;
+	u8 col, row, spurious =3D 0;
+	u8 code_reg =3D REG_FULL_CODE_7_0;
+	int ret;
+
+	/* check for any changes */
+	ret =3D
+		twl4030_i2c_read(TWL4030_MODULE_KEYPAD, new_state,
code_reg,
+				 NUM_ROWS);
+	if (ret < 0) {
+		printk(KERN_WARNING
+				"Could not read TWL4030 register %X -
returned %d[%x]\n",
+				code_reg, ret, ret);
+	}
+
+	/* check for changes and print those */
+	for (row =3D 0; row < NUM_ROWS; row++) {
+		changed =3D new_state[row] ^ keypad_state[row];
+		key_down |=3D new_state[row];
+
+		if (changed =3D=3D 0)
+			continue;
+
+		for (col =3D 0; col < NUM_COLS; col++) {
+			int key;
+			if (!(changed & (1 << col)))
+				continue;
+
+#if (OMAP_TWL4030KEYPAD_LOG_LEVEL >=3D 1)
+			printk("key %s %s\n", switch_name[row][col],
+				(new_state[row] & (1 << col)) ? "press"
: "release");
+#endif
+			key =3D omap_kp_find_key(col, row);
+			if (key < 0) {
+				printk(KERN_WARNING
+						"omap-keypad: Spurious
key event %d-%d\n",
+						col, row);
+				/* We scan again after a couple of
seconds */
+				spurious =3D 1;
+				continue;
+			}
+
+			input_report_key(omap_twl4030kp, key,
+					 new_state[row] & (1 << col));
+		}
+	}
+	if (key_down) {
+		/*
+		 * some key is pressed - keep irq disabled and use timer
+		 * to poll for key release
+		 */
+		if (spurious)
+			mod_timer(&kptimer, jiffies + SCAN_RATE * 2);
+		else
+			mod_timer(&kptimer, jiffies + SCAN_RATE);
+	}
+	memcpy(keypad_state, new_state, sizeof(keypad_state));
+}
+
+void twl4030_timer_work(void *data)
+{
+	twl4030_keypad_scan();
+}
+
+void omap_kp_timer(unsigned long data)
+{
+	schedule_work(&timer_work);
+}
+
+/*
+ * Keypad interrupt handler
+ */
+static irqreturn_t do_kp_irq(int irq, void *dev_id)
+{
+	u8 reg;
+	int ret;
+
+	/* Mask keypad interrupts */
+	reg =3D KEYP_IMR1_MASK;
+	ret =3D twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, reg,
REG_KEYP_IMR1);
+
+	/*
+	 * Scan keypad for any changes
+	 * in keypad matrix.
+	 */
+	twl4030_keypad_scan();
+
+	/* Clear TWL4030 PIH interrupt */
+	ret =3D twl4030_kpread_u8(TWL4030_MODULE_KEYPAD, &reg,
REG_KEYP_ISR1);
+
+	/* Enable interrupts */
+	reg =3D KEYP_IMR1_UNMASK;
+	ret =3D twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, reg,
REG_KEYP_IMR1);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * Registers keypad device with input sub system
+ * and configures TWL4030 keypad registers
+ *
+ */
+static int __init omap_kp_probe(struct platform_device *pdev)
+{
+	u8 reg, i;
+	u8 code_reg =3D REG_FULL_CODE_7_0;
+	int ret =3D 0;
+	struct omap_kp_platform_data *pdata =3D  pdev->dev.platform_data;
+
+#ifdef CONFIG_TWL4030KEYPAD_AUTORPT
+	int keyreptime =3D 0;
+#endif
+
+	if (!pdata->rows || !pdata->cols || !pdata->keymap) {
+		printk(KERN_ERR "No rows, cols or keymap from pdata\n");
+		return -EINVAL;
+	}
+
+	omap_twl4030kp =3D input_allocate_device();
+		if (omap_twl4030kp =3D=3D NULL) {
+		return -ENOMEM;
+	}
+
+	keymap =3D pdata->keymap;
+
+	/* setup input device */
+	set_bit(EV_KEY, omap_twl4030kp->evbit);
+
+	/* Enable auto repeat feature of Linux input subsystem */
+
+	set_bit(EV_REP, omap_twl4030kp->evbit);
+	for (i =3D 0; keymap[i] !=3D 0; i++)
+		set_bit(keymap[i] & 0x00ffffff, omap_twl4030kp->keybit);
+	omap_twl4030kp->name =3D OMAP_TWL4030KEYPAD_NAME;
+	input_register_device(omap_twl4030kp);
+
+	init_timer(&kptimer);
+	kptimer.function =3D omap_kp_timer;
+
+	/*
+	 * Since keypad driver uses I2C for reading
+	 * twl4030 keypad registers, tasklets cannot
+	 * be used.
+ 	 */
+
+	INIT_WORK(&timer_work, twl4030_timer_work);
+
+#ifdef CONFIG_TWL4030KEYPAD_AUTORPT
+	keyreptime =3D
+		(CONFIG_TWL4030KEY_AUTORPT) / (31.25 * 32 * 0.001) - 1;
+
+	/* Reset keypad module */
+	reg =3D 0;
+	ret =3D twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, reg,
REG_KEYP_CTRL_REG);
+	if (ret < 0)
+		goto exit_path4;
+
+	/*
+	 *  mask all events - dont care abt result - should
+	 *  be done by default on a reset of KP module.. still..
+	 */
+	(void)twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, 0xff,
REG_KEYP_IMR1);
+
+	/*
+	 * Set keypad control register to Normal operation,
+	 * hardware decoding,hardware key auto repeat feature
+	 * and keypad power on
+	 */
+	reg =3D KEYP_CTRL_REG_MASK_AUTORPT;
+#else
+
+	reg =3D KEYP_CTRL_REG_MASK_NOAUTORPT;
+
+#endif
+	ret =3D twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, reg,
REG_KEYP_CTRL_REG);
+	if (ret < 0)
+		goto exit_path3;
+
+	/* Set all events to Falling Edge detection */
+	reg =3D KEYP_EDR_MASK;
+	ret =3D twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, reg,
REG_KEYP_EDR);
+	if (ret < 0)
+		goto exit_path3;
+
+	/* Set Pre Scalar Field PTV to 4 */
+	reg =3D BIT_LK_PTV_REG_PTV_M & (BIT_PTV_REG_PTV4 <<
BIT_LK_PTV_REG_PTV);
+
+#ifdef CONFIG_TWL4030KEYPAD_AUTORPT
+	/* Set 4 bit MSB auto repeat key value in PTV reg */
+	reg |=3D BIT_LK_PTV_REG_MSB_LK_M & ((keyreptime >> 8)
+					<< BIT_LK_PTV_REG_MSB_LK);
+#endif
+
+	ret =3D twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, reg,
REG_LK_PTV_REG);
+	if (ret < 0)
+		goto exit_path3;
+
+	/*
+	 * Set key debounce time to 10 ms using equation
+	 * Tint =3D Tclk * (LOAD_TIM+1) * 2^(PTV+1)
+	 * Where Tclk =3D 31.25 us ( since kbd_if_clk is 32KHz)
+	 * PTV =3D 4 for all the operations.
+	 */
+	ret =3D twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, 0x3f,
REG_KEY_DEB_REG);
+	if (ret < 0)
+		goto exit_path3;
+
+#ifdef CONFIG_TWL4030KEYPAD_AUTORPT
+	reg =3D 0;
+	/*
+	 * Set LSB 8 bit timer value for key auto repeat.
+	 * Use the above formula to compute the Timer value
+	 * Ex:
+	 * 100 ms , LOAD_TIM =3D 63
+	 * 200 ms , LOAD_TIM =3D c7
+	 * 300 ms , LOAD_TIM =3D 12B
+	 * 500 ms , LOAD_TIM =3D 1F3
+	 * 1 sec,	LOAD_TIM =3D 3E7
+	 * Default is set to 100 ms.
+	 */
+	reg =3D BIT_LONG_KEY_REG1_LSB_LK_M &
+		(keyreptime << BIT_LONG_KEY_REG1_LSB_LK);
+
+	ret =3D twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, reg,
REG_LONG_KEY_REG1);
+	if (ret < 0)
+		goto exit_path3;
+#endif
+
+	/* Set SIH Ctrl register */
+	reg =3D KEYP_SIH_CTRL_MASK;
+	ret =3D twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, reg,
REG_KEYP_SIH_CTRL);
+	if (ret < 0)
+		goto exit_path3;
+
+	/*
+	 * This ISR will always execute in kernel thread context because
of
+	 * the need to access the TWL4030 over the I2C bus.
+	 */
+	ret =3D request_irq(TWL4030_MODIRQ_KEYPAD, do_kp_irq,
+		SA_INTERRUPT, "TWL4030 Keypad", omap_twl4030kp);
+	if (ret < 0) {
+		printk(KERN_INFO
+				"request_irq failed for irq no=3D%d\n",
+				TWL4030_MODIRQ_KEYPAD);
+		goto exit_path3;
+	} else {
+		/* Enable keypad module interrupts now. */
+		reg =3D KEYP_IMR1_UNMASK;
+		ret =3D
+			twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, reg,
+						REG_KEYP_IMR1);
+		if (ret < 0) {
+			/* mask all events - dont care abt result */
+			(void)twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD,
0xff,
+						 REG_KEYP_IMR1);
+			goto exit_path4;
+		}
+	}
+
+#if (OMAP_TWL4030KEYPAD_LOG_LEVEL >=3D 1)
+	printk
+	  ("********TWL4030 keypad module configuration registers
dump*********\n");
+	twl4030_kpread_u8(TWL4030_MODULE_KEYPAD, &reg,
REG_KEYP_CTRL_REG);
+	printk("Register REG_KEYP_CTRL_REG : %X\n", reg);
+	twl4030_kpread_u8(TWL4030_MODULE_KEYPAD, &reg, REG_KEYP_EDR);
+	printk("Register REG_KEYP_EDR: %X\n", reg);
+	twl4030_kpread_u8(TWL4030_MODULE_KEYPAD, &reg, REG_LK_PTV_REG);
+	printk("Register REG_LK_PTV_REG: %X\n", reg);
+	twl4030_kpread_u8(TWL4030_MODULE_KEYPAD, &reg, REG_KEY_DEB_REG);
+	printk("Register REG_KEY_DEB_REG: %X\n", reg);
+	twl4030_kpread_u8(TWL4030_MODULE_KEYPAD, &reg,
REG_LONG_KEY_REG1);
+	printk("Register REG_LONG_KEY_REG1: %X\n", reg);
+	twl4030_kpread_u8(TWL4030_MODULE_KEYPAD, &reg,
REG_KEYP_SIH_CTRL);
+	printk("Register REG_KEYP_SIH_CTRL: %X\n", reg);
+	twl4030_kpread_u8(TWL4030_MODULE_KEYPAD, &reg, REG_KEYP_IMR1);
+	printk("Register REG_KEYP_IMR1: %X\n", reg);
+	printk("****************END******************\n");
+#endif
+	/* Read initial state of keypad matrix. */
+	ret =3D twl4030_i2c_read(TWL4030_MODULE_KEYPAD, keypad_state,
code_reg,
+		NUM_ROWS);
+	if (ret < 0) {
+		printk(KERN_WARNING
+				"Could not read TWL4030 register %X -
returned %d[%x]\n",
+				reg, ret, ret);
+		goto exit_path4;
+	}
+
+	return (ret);
+exit_path4:
+	free_irq(TWL4030_MODIRQ_KEYPAD, NULL);
+exit_path3:
+	input_unregister_device(omap_twl4030kp);
+	return -ENODEV;
+}
+
+static int omap_kp_remove(struct platform_device *pdev)
+{
+	free_irq(TWL4030_MODIRQ_KEYPAD, NULL);
+	del_timer_sync(&kptimer);
+
+	input_unregister_device(omap_twl4030kp);
+	return 0;
+}
+
+
+static struct platform_driver omap_kp_driver =3D {
+	.probe		=3D omap_kp_probe,
+	.remove		=3D omap_kp_remove,
+	.driver		=3D {
+		.name	=3D OMAP_TWL4030KEYPAD_NAME,
+	},
+};
+
+/*
+ * OMAP TWL4030 Keypad init
+ */
+static int __devinit omap_kp_init(void)
+{
+	printk(KERN_INFO "OMAP Keypad Driver\n");
+	return platform_driver_register(&omap_kp_driver);
+}
+
+static void __exit omap_kp_exit(void)
+{
+	platform_driver_unregister(&omap_kp_driver);
+}
+
+module_init(omap_kp_init);
+module_exit(omap_kp_exit);
+MODULE_AUTHOR("Texas Instruments");
+MODULE_DESCRIPTION("OMAP TWL4030 Keypad Driver");
+MODULE_LICENSE("GPL");
diff -purN linux-omap/drivers/input/keyboard/twl4030-keypad.h
lin_for_hsi2c/drivers/input/keyboard/twl4030-keypad.h
--- linux-omap/drivers/input/keyboard/twl4030-keypad.h	1969-12-31
18:00:00.000000000 -0600
+++ lin_for_hsi2c/drivers/input/keyboard/twl4030-keypad.h
2007-04-11 13:08:16.000000000 -0500
@@ -0,0 +1,376 @@
+/*
+ * drivers/input/twl4030-keypad.h - Register defines for TWL4030 keypad
module
+ *
+ * Copyright (C) 2006-2007 Texas Instruments, Inc.
+ *
+ * Code re-arranged and cleaned up by:
+ * 	Syed Mohammed Khasim <x0khasim@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
USA
+ */
+#ifndef __TWL4030_KEYPAD_H__
+#define __TWL4030_KEYPAD_H__
+
+/* Register Definitions */
+#define REG_KEYP_CTRL_REG			(0x0)
+#define REG_KEY_DEB_REG				(0x1)
+#define REG_LONG_KEY_REG1			(0x2)
+#define REG_LK_PTV_REG				(0x3)
+#define REG_TIME_OUT_REG1			(0x4)
+#define REG_TIME_OUT_REG2			(0x5)
+#define REG_KBC_REG				(0x6)
+#define REG_KBR_REG				(0x7)
+#define REG_KEYP_SMS				(0x8)
+#define REG_FULL_CODE_7_0			(0x9)
+#define REG_FULL_CODE_15_8			(0xA)
+#define REG_FULL_CODE_23_16			(0xB)
+#define REG_FULL_CODE_31_24			(0xC)
+#define REG_FULL_CODE_39_32			(0xD)
+#define REG_FULL_CODE_47_40			(0xE)
+#define REG_FULL_CODE_55_48			(0xF)
+#define REG_FULL_CODE_63_56			(0x10)
+#define REG_KEYP_ISR1				(0x11)
+#define REG_KEYP_IMR1				(0x12)
+#define REG_KEYP_ISR2				(0x13)
+#define REG_KEYP_IMR2				(0x14)
+#define REG_KEYP_SIR				(0x15)
+#define REG_KEYP_EDR				(0x16)
+#define REG_KEYP_SIH_CTRL			(0x17)
+
+/* BitField Definitions */
+
+/* KEYP_CTRL_REG Fields */
+#define BIT_KEYP_CTRL_REG_SOFT_NRST		(0x000)
+#define BIT_KEYP_CTRL_REG_SOFT_NRST_M		(0x00000001)
+#define BIT_KEYP_CTRL_REG_SOFTMODEN		(0x001)
+#define BIT_KEYP_CTRL_REG_SOFTMODEN_M		(0x00000002)
+#define BIT_KEYP_CTRL_REG_LK_EN			(0x002)
+#define BIT_KEYP_CTRL_REG_LK_EN_M		(0x00000004)
+#define BIT_KEYP_CTRL_REG_TOE_EN		(0x003)
+#define BIT_KEYP_CTRL_REG_TOE_EN_M		(0x00000008)
+#define BIT_KEYP_CTRL_REG_TOLE_EN		(0x004)
+#define BIT_KEYP_CTRL_REG_TOLE_EN_M		(0x00000010)
+#define BIT_KEYP_CTRL_REG_RP_EN			(0x005)
+#define BIT_KEYP_CTRL_REG_RP_EN_M		(0x00000020)
+#define BIT_KEYP_CTRL_REG_KBD_ON		(0x006)
+#define BIT_KEYP_CTRL_REG_KBD_ON_M		(0x00000040)
+
+#define KEYP_CTRL_REG_MASK_AUTORPT
BIT_KEYP_CTRL_REG_SOFT_NRST_M |\
+
BIT_KEYP_CTRL_REG_RP_EN_M |\
+
BIT_KEYP_CTRL_REG_SOFTMODEN_M |\
+
BIT_KEYP_CTRL_REG_KBD_ON_M
+
+#define KEYP_CTRL_REG_MASK_NOAUTORPT
BIT_KEYP_CTRL_REG_SOFT_NRST_M |\
+
BIT_KEYP_CTRL_REG_SOFTMODEN_M |\
+
BIT_KEYP_CTRL_REG_KBD_ON_M
+
+/* KEY_DEB_REG Fields */
+#define BIT_KEY_DEB_REG_KEYP_DEB		(0x000)
+#define BIT_KEY_DEB_REG_KEYP_DEB_M		(0x0000003F)
+#define BIT_KEY_DEB9				(0x9)
+
+/* LONG_KEY_REG1 Fields */
+#define BIT_LONG_KEY_REG1_LSB_LK		(0x000)
+#define BIT_LONG_KEY_REG1_LSB_LK_M		(0x000000FF)
+#define BIT_LONG_KEY_100MS			(0x63)
+
+/* LK_PTV_REG Fields */
+#define BIT_LK_PTV_REG_MSB_LK			(0x000)
+#define BIT_LK_PTV_REG_MSB_LK_M			(0x0000000F)
+#define BIT_LK_PTV_REG_PTV			(0x005)
+#define BIT_LK_PTV_REG_PTV_M			(0x000000E0)
+#define BIT_PTV_REG_PTV4			(0x4)
+
+/* TIME_OUT_REG1 Fields */
+#define BIT_TIME_OUT_REG1_LSB_TO		(0x000)
+#define BIT_TIME_OUT_REG1_LSB_TO_M		(0x000000FF)
+
+/* TIME_OUT_REG2 Fields */
+#define BIT_TIME_OUT_REG2_MSB_TO		(0x000)
+#define BIT_TIME_OUT_REG2_MSB_TO_M		(0x000000FF)
+
+/* KBC_REG Fields */
+#define BIT_KBC_REG_KBC0			(0x000)
+#define BIT_KBC_REG_KBC0_M			(0x00000001)
+#define BIT_KBC_REG_KBC1			(0x001)
+#define BIT_KBC_REG_KBC1_M			(0x00000002)
+#define BIT_KBC_REG_KBC2			(0x002)
+#define BIT_KBC_REG_KBC2_M			(0x00000004)
+#define BIT_KBC_REG_KBC3			(0x003)
+#define BIT_KBC_REG_KBC3_M			(0x00000008)
+#define BIT_KBC_REG_KBC4			(0x004)
+#define BIT_KBC_REG_KBC4_M			(0x00000010)
+#define BIT_KBC_REG_KBC5			(0x005)
+#define BIT_KBC_REG_KBC5_M			(0x00000020)
+#define BIT_KBC_REG_KBC6			(0x006)
+#define BIT_KBC_REG_KBC6_M			(0x00000040)
+#define BIT_KBC_REG_KBC7			(0x007)
+#define BIT_KBC_REG_KBC7_M			(0x00000080)
+
+/* KBR_REG Fields */
+#define BIT_KBR_REG_KBR0			(0x000)
+#define BIT_KBR_REG_KBR0_M			(0x00000001)
+#define BIT_KBR_REG_KBR1			(0x001)
+#define BIT_KBR_REG_KBR1_M			(0x00000002)
+#define BIT_KBR_REG_KBR2			(0x002)
+#define BIT_KBR_REG_KBR2_M			(0x00000004)
+#define BIT_KBR_REG_KBR3			(0x003)
+#define BIT_KBR_REG_KBR3_M			(0x00000008)
+#define BIT_KBR_REG_KBR4			(0x004)
+#define BIT_KBR_REG_KBR4_M			(0x00000010)
+#define BIT_KBR_REG_KBR5			(0x005)
+#define BIT_KBR_REG_KBR5_M			(0x00000020)
+#define BIT_KBR_REG_KBR6			(0x006)
+#define BIT_KBR_REG_KBR6_M			(0x00000040)
+#define BIT_KBR_REG_KBR7			(0x007)
+#define BIT_KBR_REG_KBR7_M			(0x00000080)
+
+/* KEYP_SMS Fields */
+#define BIT_KEYP_SMS_STMSTS			(0x000)
+#define BIT_KEYP_SMS_STMSTS_M			(0x0000000F)
+#define BIT_KEYP_SMS_SIR_EN			(0x004)
+#define BIT_KEYP_SMS_SIR_EN_M			(0x00000010)
+#define BIT_KEYP_SMS_MISS_EN			(0x005)
+#define BIT_KEYP_SMS_MISS_EN_M			(0x00000020)
+
+/* FULL_CODE_7_0 Fields */
+#define BIT_FULL_CODE_7_0_FULL_CODE_K0		(0x000)
+#define BIT_FULL_CODE_7_0_FULL_CODE_K0_M	(0x00000001)
+#define BIT_FULL_CODE_7_0_FULL_CODE_K1		(0x001)
+#define BIT_FULL_CODE_7_0_FULL_CODE_K1_M	(0x00000002)
+#define BIT_FULL_CODE_7_0_FULL_CODE_K2		(0x002)
+#define BIT_FULL_CODE_7_0_FULL_CODE_K2_M	(0x00000004)
+#define BIT_FULL_CODE_7_0_FULL_CODE_K3		(0x003)
+#define BIT_FULL_CODE_7_0_FULL_CODE_K3_M	(0x00000008)
+#define BIT_FULL_CODE_7_0_FULL_CODE_K4		(0x004)
+#define BIT_FULL_CODE_7_0_FULL_CODE_K4_M	(0x00000010)
+#define BIT_FULL_CODE_7_0_FULL_CODE_K5		(0x005)
+#define BIT_FULL_CODE_7_0_FULL_CODE_K5_M	(0x00000020)
+#define BIT_FULL_CODE_7_0_FULL_CODE_K6		(0x006)
+#define BIT_FULL_CODE_7_0_FULL_CODE_K6_M	(0x00000040)
+#define BIT_FULL_CODE_7_0_FULL_CODE_K7		(0x007)
+#define BIT_FULL_CODE_7_0_FULL_CODE_K7_M	(0x00000080)
+
+/* FULL_CODE_15_8 Fields */
+#define BIT_FULL_CODE_15_8_FULL_CODE_K8		(0x000)
+#define BIT_FULL_CODE_15_8_FULL_CODE_K8_M	(0x00000001)
+#define BIT_FULL_CODE_15_8_FULL_CODE_K9		(0x001)
+#define BIT_FULL_CODE_15_8_FULL_CODE_K9_M	(0x00000002)
+#define BIT_FULL_CODE_15_8_FULL_CODE_K10	(0x002)
+#define BIT_FULL_CODE_15_8_FULL_CODE_K10_M	(0x00000004)
+#define BIT_FULL_CODE_15_8_FULL_CODE_K11	(0x003)
+#define BIT_FULL_CODE_15_8_FULL_CODE_K11_M	(0x00000008)
+#define BIT_FULL_CODE_15_8_FULL_CODE_K12	(0x004)
+#define BIT_FULL_CODE_15_8_FULL_CODE_K12_M	(0x00000010)
+#define BIT_FULL_CODE_15_8_FULL_CODE_K13	(0x005)
+#define BIT_FULL_CODE_15_8_FULL_CODE_K13_M	(0x00000020)
+#define BIT_FULL_CODE_15_8_FULL_CODE_K14	(0x006)
+#define BIT_FULL_CODE_15_8_FULL_CODE_K14_M	(0x00000040)
+#define BIT_FULL_CODE_15_8_FULL_CODE_K15	(0x007)
+#define BIT_FULL_CODE_15_8_FULL_CODE_K15_M	(0x00000080)
+
+/* FULL_CODE_23_16 Fields */
+#define BIT_FULL_CODE_23_16_FULL_CODE_K16	(0x000)
+#define BIT_FULL_CODE_23_16_FULL_CODE_K16_M	(0x00000001)
+#define BIT_FULL_CODE_23_16_FULL_CODE_K17	(0x001)
+#define BIT_FULL_CODE_23_16_FULL_CODE_K17_M	(0x00000002)
+#define BIT_FULL_CODE_23_16_FULL_CODE_K18	(0x002)
+#define BIT_FULL_CODE_23_16_FULL_CODE_K18_M	(0x00000004)
+#define BIT_FULL_CODE_23_16_FULL_CODE_K19	(0x003)
+#define BIT_FULL_CODE_23_16_FULL_CODE_K19_M	(0x00000008)
+#define BIT_FULL_CODE_23_16_FULL_CODE_K20	(0x004)
+#define BIT_FULL_CODE_23_16_FULL_CODE_K20_M	(0x00000010)
+#define BIT_FULL_CODE_23_16_FULL_CODE_K21	(0x005)
+#define BIT_FULL_CODE_23_16_FULL_CODE_K21_M	(0x00000020)
+#define BIT_FULL_CODE_23_16_FULL_CODE_K22	(0x006)
+#define BIT_FULL_CODE_23_16_FULL_CODE_K22_M	(0x00000040)
+#define BIT_FULL_CODE_23_16_FULL_CODE_K23	(0x007)
+#define BIT_FULL_CODE_23_16_FULL_CODE_K23_M	(0x00000080)
+
+/* FULL_CODE_31_24 Fields */
+#define BIT_FULL_CODE_31_24_FULL_CODE_K24	(0x000)
+#define BIT_FULL_CODE_31_24_FULL_CODE_K24_M	(0x00000001)
+#define BIT_FULL_CODE_31_24_FULL_CODE_K25	(0x001)
+#define BIT_FULL_CODE_31_24_FULL_CODE_K25_M	(0x00000002)
+#define BIT_FULL_CODE_31_24_FULL_CODE_K26	(0x002)
+#define BIT_FULL_CODE_31_24_FULL_CODE_K26_M	(0x00000004)
+#define BIT_FULL_CODE_31_24_FULL_CODE_K27	(0x003)
+#define BIT_FULL_CODE_31_24_FULL_CODE_K27_M	(0x00000008)
+#define BIT_FULL_CODE_31_24_FULL_CODE_K28	(0x004)
+#define BIT_FULL_CODE_31_24_FULL_CODE_K28_M	(0x00000010)
+#define BIT_FULL_CODE_31_24_FULL_CODE_K29	(0x005)
+#define BIT_FULL_CODE_31_24_FULL_CODE_K29_M	(0x00000020)
+#define BIT_FULL_CODE_31_24_FULL_CODE_K30	(0x006)
+#define BIT_FULL_CODE_31_24_FULL_CODE_K30_M	(0x00000040)
+#define BIT_FULL_CODE_31_24_FULL_CODE_K31	(0x007)
+#define BIT_FULL_CODE_31_24_FULL_CODE_K31_M	(0x00000080)
+
+/* FULL_CODE_39_32 Fields */
+#define BIT_FULL_CODE_39_32_FULL_CODE_K32	(0x000)
+#define BIT_FULL_CODE_39_32_FULL_CODE_K32_M	(0x00000001)
+#define BIT_FULL_CODE_39_32_FULL_CODE_K33	(0x001)
+#define BIT_FULL_CODE_39_32_FULL_CODE_K33_M	(0x00000002)
+#define BIT_FULL_CODE_39_32_FULL_CODE_K34	(0x002)
+#define BIT_FULL_CODE_39_32_FULL_CODE_K34_M	(0x00000004)
+#define BIT_FULL_CODE_39_32_FULL_CODE_K35	(0x003)
+#define BIT_FULL_CODE_39_32_FULL_CODE_K35_M	(0x00000008)
+#define BIT_FULL_CODE_39_32_FULL_CODE_K36	(0x004)
+#define BIT_FULL_CODE_39_32_FULL_CODE_K36_M	(0x00000010)
+#define BIT_FULL_CODE_39_32_FULL_CODE_K37	(0x005)
+#define BIT_FULL_CODE_39_32_FULL_CODE_K37_M	(0x00000020)
+#define BIT_FULL_CODE_39_32_FULL_CODE_K38	(0x006)
+#define BIT_FULL_CODE_39_32_FULL_CODE_K38_M	(0x00000040)
+#define BIT_FULL_CODE_39_32_FULL_CODE_K39	(0x007)
+#define BIT_FULL_CODE_39_32_FULL_CODE_K39_M	(0x00000080)
+
+/* FULL_CODE_47_40 Fields */
+#define BIT_FULL_CODE_47_40_FULL_CODE_K40	(0x000)
+#define BIT_FULL_CODE_47_40_FULL_CODE_K40_M	(0x00000001)
+#define BIT_FULL_CODE_47_40_FULL_CODE_K41	(0x001)
+#define BIT_FULL_CODE_47_40_FULL_CODE_K41_M	(0x00000002)
+#define BIT_FULL_CODE_47_40_FULL_CODE_K42	(0x002)
+#define BIT_FULL_CODE_47_40_FULL_CODE_K42_M	(0x00000004)
+#define BIT_FULL_CODE_47_40_FULL_CODE_K43	(0x003)
+#define BIT_FULL_CODE_47_40_FULL_CODE_K43_M	(0x00000008)
+#define BIT_FULL_CODE_47_40_FULL_CODE_K44	(0x004)
+#define BIT_FULL_CODE_47_40_FULL_CODE_K44_M	(0x00000010)
+#define BIT_FULL_CODE_47_40_FULL_CODE_K45	(0x005)
+#define BIT_FULL_CODE_47_40_FULL_CODE_K45_M	(0x00000020)
+#define BIT_FULL_CODE_47_40_FULL_CODE_K46	(0x006)
+#define BIT_FULL_CODE_47_40_FULL_CODE_K46_M	(0x00000040)
+#define BIT_FULL_CODE_47_40_FULL_CODE_K47	(0x007)
+#define BIT_FULL_CODE_47_40_FULL_CODE_K47_M	(0x00000080)
+
+/* FULL_CODE_55_48 Fields */
+#define BIT_FULL_CODE_55_48_FULL_CODE_K48	(0x000)
+#define BIT_FULL_CODE_55_48_FULL_CODE_K48_M	(0x00000001)
+#define BIT_FULL_CODE_55_48_FULL_CODE_K49	(0x001)
+#define BIT_FULL_CODE_55_48_FULL_CODE_K49_M	(0x00000002)
+#define BIT_FULL_CODE_55_48_FULL_CODE_K50	(0x002)
+#define BIT_FULL_CODE_55_48_FULL_CODE_K50_M	(0x00000004)
+#define BIT_FULL_CODE_55_48_FULL_CODE_K51	(0x003)
+#define BIT_FULL_CODE_55_48_FULL_CODE_K51_M	(0x00000008)
+#define BIT_FULL_CODE_55_48_FULL_CODE_K52	(0x004)
+#define BIT_FULL_CODE_55_48_FULL_CODE_K52_M	(0x00000010)
+#define BIT_FULL_CODE_55_48_FULL_CODE_K53	(0x005)
+#define BIT_FULL_CODE_55_48_FULL_CODE_K53_M	(0x00000020)
+#define BIT_FULL_CODE_55_48_FULL_CODE_K54	(0x006)
+#define BIT_FULL_CODE_55_48_FULL_CODE_K54_M	(0x00000040)
+#define BIT_FULL_CODE_55_48_FULL_CODE_K55	(0x007)
+#define BIT_FULL_CODE_55_48_FULL_CODE_K55_M	(0x00000080)
+
+/* FULL_CODE_63_56 Fields */
+#define BIT_FULL_CODE_63_56_FULL_CODE_K56	(0x000)
+#define BIT_FULL_CODE_63_56_FULL_CODE_K56_M	(0x00000001)
+#define BIT_FULL_CODE_63_56_FULL_CODE_K57	(0x001)
+#define BIT_FULL_CODE_63_56_FULL_CODE_K57_M	(0x00000002)
+#define BIT_FULL_CODE_63_56_FULL_CODE_K58	(0x002)
+#define BIT_FULL_CODE_63_56_FULL_CODE_K58_M	(0x00000004)
+#define BIT_FULL_CODE_63_56_FULL_CODE_K59	(0x003)
+#define BIT_FULL_CODE_63_56_FULL_CODE_K59_M	(0x00000008)
+#define BIT_FULL_CODE_63_56_FULL_CODE_K60	(0x004)
+#define BIT_FULL_CODE_63_56_FULL_CODE_K60_M	(0x00000010)
+#define BIT_FULL_CODE_63_56_FULL_CODE_K61	(0x005)
+#define BIT_FULL_CODE_63_56_FULL_CODE_K61_M	(0x00000020)
+#define BIT_FULL_CODE_63_56_FULL_CODE_K62	(0x006)
+#define BIT_FULL_CODE_63_56_FULL_CODE_K62_M	(0x00000040)
+#define BIT_FULL_CODE_63_56_FULL_CODE_K63	(0x007)
+#define BIT_FULL_CODE_63_56_FULL_CODE_K63_M	(0x00000080)
+
+/* KEYP_ISR1 Fields */
+#define BIT_KEYP_ISR1_ITKPISR1			(0x000)
+#define BIT_KEYP_ISR1_ITKPISR1_M		(0x00000001)
+#define BIT_KEYP_ISR1_ITLKISR1			(0x001)
+#define BIT_KEYP_ISR1_ITLKISR1_M		(0x00000002)
+#define BIT_KEYP_ISR1_ITTOISR1			(0x002)
+#define BIT_KEYP_ISR1_ITTOISR1_M		(0x00000004)
+#define BIT_KEYP_ISR1_ITMISR1			(0x003)
+#define BIT_KEYP_ISR1_ITMISR1_M			(0x00000008)
+#define KEYP_ISR1_CLEAR				(0x0F)
+
+/* KEYP_IMR1 Fields */
+#define BIT_KEYP_IMR1_ITKPIMR1			(0x000)
+#define BIT_KEYP_IMR1_ITKPIMR1_M		(0x00000001)
+#define BIT_KEYP_IMR1_ITLKIMR1			(0x001)
+#define BIT_KEYP_IMR1_ITLKIMR1_M		(0x00000002)
+#define BIT_KEYP_IMR1_ITTOIMR1			(0x002)
+#define BIT_KEYP_IMR1_ITTOIMR1_M		(0x00000004)
+#define BIT_KEYP_IMR1_ITMISIMR1			(0x003)
+#define BIT_KEYP_IMR1_ITMISIMR1_M		(0x00000008)
+#define KEYP_IMR1_MASK				(0x0F)
+#define KEYP_IMR1_UNMASK			(0x00)
+
+/* KEYP_ISR2 Fields */
+#define BIT_KEYP_ISR2_ITKPISR2			(0x000)
+#define BIT_KEYP_ISR2_ITKPISR2_M		(0x00000001)
+#define BIT_KEYP_ISR2_ITLKISR2			(0x001)
+#define BIT_KEYP_ISR2_ITLKISR2_M		(0x00000002)
+#define BIT_KEYP_ISR2_ITTOISR2			(0x002)
+#define BIT_KEYP_ISR2_ITTOISR2_M		(0x00000004)
+#define BIT_KEYP_ISR2_ITMISR2			(0x003)
+#define BIT_KEYP_ISR2_ITMISR2_M			(0x00000008)
+
+/* KEYP_IMR2 Fields */
+#define BIT_KEYP_IMR2_ITKPIMR2			(0x000)
+#define BIT_KEYP_IMR2_ITKPIMR2_M		(0x00000001)
+#define BIT_KEYP_IMR2_ITLKIMR2			(0x001)
+#define BIT_KEYP_IMR2_ITLKIMR2_M		(0x00000002)
+#define BIT_KEYP_IMR2_ITTOIMR2			(0x002)
+#define BIT_KEYP_IMR2_ITTOIMR2_M		(0x00000004)
+#define BIT_KEYP_IMR2_ITMISIMR2			(0x003)
+#define BIT_KEYP_IMR2_ITMISIMR2_M		(0x00000008)
+
+/* KEYP_SIR Fields */
+#define BIT_KEYP_SIR_ITKPSIR			(0x000)
+#define BIT_KEYP_SIR_ITKPSIR_M			(0x00000001)
+#define BIT_KEYP_SIR_ITLKSIR			(0x001)
+#define BIT_KEYP_SIR_ITLKSIR_M			(0x00000002)
+#define BIT_KEYP_SIR_ITTOSIR			(0x002)
+#define BIT_KEYP_SIR_ITTOSIR_M			(0x00000004)
+#define BIT_KEYP_SIR_ITMISSIR			(0x003)
+#define BIT_KEYP_SIR_ITMISSIR_M			(0x00000008)
+
+/* KEYP_EDR Fields */
+#define BIT_KEYP_EDR_ITKPFALLING		(0x000)
+#define BIT_KEYP_EDR_ITKPFALLING_M		(0x00000001)
+#define BIT_KEYP_EDR_ITKPRISING			(0x001)
+#define BIT_KEYP_EDR_ITKPRISING_M		(0x00000002)
+#define BIT_KEYP_EDR_ITLKFALLING		(0x002)
+#define BIT_KEYP_EDR_ITLKFALLING_M		(0x00000004)
+#define BIT_KEYP_EDR_ITLKRISING			(0x003)
+#define BIT_KEYP_EDR_ITLKRISING_M		(0x00000008)
+#define BIT_KEYP_EDR_ITTOFALLING		(0x004)
+#define BIT_KEYP_EDR_ITTOFALLING_M		(0x00000010)
+#define BIT_KEYP_EDR_ITTORISING			(0x005)
+#define BIT_KEYP_EDR_ITTORISING_M		(0x00000020)
+#define BIT_KEYP_EDR_ITMISFALLING		(0x006)
+#define BIT_KEYP_EDR_ITMISFALLING_M		(0x00000040)
+#define BIT_KEYP_EDR_ITMISRISING		(0x007)
+#define BIT_KEYP_EDR_ITMISRISING_M		(0x00000080)
+
+#define KEYP_EDR_MASK
BIT_KEYP_EDR_ITKPFALLING_M |\
+
BIT_KEYP_EDR_ITLKFALLING_M |\
+
BIT_KEYP_EDR_ITTOFALLING_M |\
+
BIT_KEYP_EDR_ITMISFALLING_M
+/* KEYP_SIH_CTRL Fields */
+#define BIT_KEYP_SIH_CTRL_EXCLEN		(0x000)
+#define BIT_KEYP_SIH_CTRL_EXCLEN_M		(0x00000001)
+#define BIT_KEYP_SIH_CTRL_PENDDIS		(0x001)
+#define BIT_KEYP_SIH_CTRL_PENDDIS_M		(0x00000002)
+#define BIT_KEYP_SIH_CTRL_COR			(0x002)
+#define BIT_KEYP_SIH_CTRL_COR_M			(0x00000004)
+#define KEYP_SIH_CTRL_MASK			(0x04)
+
+#endif	/* End of __TWL4030-KEYPAD_H__ */

diff -purN linux-omap/include/asm-arm/arch-omap/board-2430sdp.h
lin_for_hsi2c/include/asm-arm/arch-omap/board-2430sdp.h
--- linux-omap/include/asm-arm/arch-omap/board-2430sdp.h
2006-12-17 08:56:42.000000000 -0600
+++ lin_for_hsi2c/include/asm-arm/arch-omap/board-2430sdp.h
2007-04-11 13:13:42.000000000 -0500
@@ -30,7 +30,7 @@
 #define __ASM_ARCH_OMAP_2430SDP_H
=20
 /* Placeholder for 2430SDP specific defines */
-#define OMAP24XX_ETHR_START		 0x08000300
+#define OMAP24XX_ETHR_START		0x08000300
 #define OMAP24XX_ETHR_GPIO_IRQ		149
 #define SDP2430_CS0_BASE		0x04000000
=20
@@ -39,6 +39,10 @@
 /* TWL4030 Primary Interrupt Handler (PIH) interrupts */
 #define IH_TWL4030_BASE			IH_BOARD_BASE
 #define IH_TWL4030_END			(IH_TWL4030_BASE+8)
-#define NR_IRQS				(IH_TWL4030_END)
+
+/* TWL4030 GPIO Interrupts */
+#define IH_TWL4030_GPIO_BASE		(IH_TWL4030_END)
+#define IH_TWL4030_GPIO_END		(IH_TWL4030_BASE+18)
+#define NR_IRQS				(IH_TWL4030_GPIO_END)
=20
 #endif /* __ASM_ARCH_OMAP_2430SDP_H */
diff -purN linux-omap/include/asm-arm/arch-omap/twl4030.h
lin_for_hsi2c/include/asm-arm/arch-omap/twl4030.h
--- linux-omap/include/asm-arm/arch-omap/twl4030.h	2007-01-08
18:57:20.000000000 -0600
+++ lin_for_hsi2c/include/asm-arm/arch-omap/twl4030.h	2007-04-10
15:20:42.000000000 -0500
@@ -72,6 +72,23 @@
 #define TWL4030_VAUX3_DEV_GRP		0x1F
 #define TWL4030_VAUX3_DEDICATED		0x22
=20
+/* TWL4030 GPIO interrupt definitions */
+
+#define TWL4030_GPIO_MIN		0
+#define TWL4030_GPIO_MAX		18
+#define TWL4030_GPIO_MAX_CD		2
+#define TWL4030_GPIO_IRQ_NO(n)		(IH_TWL4030_GPIO_BASE+n)
+#define TWL4030_GPIO_IS_INPUT		1
+#define TWL4030_GPIO_IS_OUTPUT		0
+#define TWL4030_GPIO_IS_ENABLE		1
+#define TWL4030_GPIO_IS_DISABLE		0
+#define TWL4030_GPIO_PULL_UP		0
+#define TWL4030_GPIO_PULL_DOWN		1
+#define TWL4030_GPIO_PULL_NONE		2
+#define TWL4030_GPIO_EDGE_NONE		0
+#define TWL4030_GPIO_EDGE_RISING	1
+#define TWL4030_GPIO_EDGE_FALLING	2
+
 /* Functions to read and write from TWL4030 */
=20
 /*

--- linux-omap/arch/arm/mach-omap2/board-2430sdp.c	2007-03-02
17:12:25.000000000 -0600
+++ lin_for_hsi2c/arch/arm/mach-omap2/board-2430sdp.c	2007-04-10
15:31:49.000000000 -0500
@@ -19,6 +19,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/delay.h>
+#include <linux/input.h>
 #include <linux/err.h>
 #include <linux/clk.h>
=20
@@ -32,6 +33,7 @@
 #include <asm/arch/mux.h>
 #include <asm/arch/board.h>
 #include <asm/arch/common.h>
+#include <asm/arch/keypad.h>
 #include <asm/arch/gpmc.h>
 #include "prcm-regs.h"
=20
@@ -114,9 +116,64 @@ static struct platform_device sdp2430_sm
 	.resource	=3D sdp2430_smc91x_resources,
 };
=20
+/*
+ * Key mapping for 2430 SDP board
+ */
+
+static int sdp2430_keymap[] =3D {
+	KEY(0, 0, KEY_LEFT),
+	KEY(0, 1, KEY_RIGHT),
+	KEY(0, 2, KEY_A),
+	KEY(0, 3, KEY_B),
+	KEY(0, 4, KEY_C),
+	KEY(1, 0, KEY_DOWN),
+	KEY(1, 1, KEY_UP),
+	KEY(1, 2, KEY_E),
+	KEY(1, 3, KEY_F),
+	KEY(1, 4, KEY_G),
+	KEY(2, 0, KEY_ENTER),
+	KEY(2, 1, KEY_I),
+	KEY(2, 2, KEY_J),
+	KEY(2, 3, KEY_K),
+	KEY(2, 4, KEY_3),
+	KEY(3, 0, KEY_M),
+	KEY(3, 1, KEY_N),
+	KEY(3, 2, KEY_O),
+	KEY(3, 3, KEY_P),
+	KEY(3, 4, KEY_Q),
+	KEY(4, 0, KEY_R),
+	KEY(4, 1, KEY_4),
+	KEY(4, 2, KEY_T),
+	KEY(4, 3, KEY_U),
+	KEY(4, 4, KEY_D),
+	KEY(5, 0, KEY_V),
+	KEY(5, 1, KEY_W),
+	KEY(5, 2, KEY_L),
+	KEY(5, 3, KEY_S),
+	KEY(5, 4, KEY_H),
+	0
+};
+
+static struct omap_kp_platform_data sdp2430_kp_data =3D {
+	.rows		=3D 5,
+	.cols		=3D 6,
+	.keymap 	=3D sdp2430_keymap,
+	.keymapsize 	=3D ARRAY_SIZE(sdp2430_keymap),
+	.rep		=3D 1,
+};
+
+static struct platform_device sdp2430_kp_device =3D {
+	.name		=3D "omap_twl4030keypad",
+	.id		=3D -1,
+	.dev		=3D {
+		.platform_data	=3D &sdp2430_kp_data,
+	},
+};
+
 static struct platform_device *sdp2430_devices[] __initdata =3D {
 	&sdp2430_smc91x_device,
 	&sdp2430_flash_device,
+	&sdp2430_kp_device,
 };
=20
 static inline void __init sdp2430_init_smc91x(void)
