From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH] TWL4030 Keypad Driver - after merging Nishanth's patch.
Date: Wed, 16 May 2007 19:13:55 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47EA0681@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Incorporated Review comments and have merged Nishanth's patch.

This patch adds TWL4030 Keypad driver support for 2430 SDP.=20

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files:
 arch/arm/mach-omap2/board-2430sdp.c      =20
 drivers/input/keyboard/Kconfig           =20
 drivers/input/keyboard/Makefile          =20
 drivers/input/keyboard/omap-twl4030keypad.c
 lin_for_mmc/drivers/input/keyboard/twl4030-keypad.h =20
 lin_for_mmc/include/asm-arm/arch-omap/board-2430sdp.h
 lin_for_mmc/include/asm-arm/arch-omap/twl4030.h     =20
        7 files changed, 554 insertions(+), 3 deletions(-)
=09
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap/arch/arm/mach-omap2/board-2430sdp.c	2007-05-16 =
14:32:40.000000000 -0500
+++ lin_for_mmc/arch/arm/mach-omap2/board-2430sdp.c	2007-05-16 =
18:20:26.000000000 -0500
@@ -19,6 +19,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/delay.h>
+#include <linux/input.h>
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/spi/spi.h>
@@ -34,6 +35,7 @@
 #include <asm/arch/mux.h>
 #include <asm/arch/board.h>
 #include <asm/arch/common.h>
+#include <asm/arch/keypad.h>
 #include <asm/arch/gpmc.h>
 #include <asm/arch/mcspi.h>
 #include "prcm-regs.h"
@@ -120,9 +122,64 @@ static struct platform_device sdp2430_sm
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
 static struct tsc2046_platform_data tsc2046_config =3D {

diff -purN linux-omap/include/asm-arm/arch-omap/board-2430sdp.h =
lin_for_mmc/include/asm-arm/arch-omap/board-2430sdp.h
--- linux-omap/include/asm-arm/arch-omap/board-2430sdp.h	2006-12-17 =
08:56:42.000000000 -0600
+++ lin_for_mmc/include/asm-arm/arch-omap/board-2430sdp.h	2007-05-16 =
18:20:26.000000000 -0500
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

diff -purN linux-omap/include/asm-arm/arch-omap/twl4030.h =
lin_for_mmc/include/asm-arm/arch-omap/twl4030.h
--- linux-omap/include/asm-arm/arch-omap/twl4030.h	2007-01-08 =
18:57:20.000000000 -0600
+++ lin_for_mmc/include/asm-arm/arch-omap/twl4030.h	2007-05-16 =
18:20:26.000000000 -0500
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

diff -purN linux-omap/drivers/input/keyboard/Kconfig =
lin_for_mmc/drivers/input/keyboard/Kconfig
--- linux-omap/drivers/input/keyboard/Kconfig	2007-05-16 =
14:32:53.000000000 -0500
+++ lin_for_mmc/drivers/input/keyboard/Kconfig	2007-05-16 =
18:20:26.000000000 -0500
@@ -214,6 +214,16 @@ config KEYBOARD_OMAP
 	  To compile this driver as a module, choose M here: the
 	  module will be called omap-keypad.
=20
+config KEYBOARD_TWL4030
+	tristate "TI TWL4030 keypad support"
+	depends on TWL4030_CORE && MACH_OMAP_2430SDP
+	help
+	  Say Y here if you want to use the OMAP TWL4030 keypad.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called omap-twl4030keypad. This driver depends on
+	  TWL4030 Core and TWL4030 GPIO I2C client driver
+
 config OMAP_PS2
 	tristate "TI OMAP Innovator 1510 PS/2 keyboard & mouse support"
 	depends on ARCH_OMAP15XX && MACH_OMAP_INNOVATOR

diff -purN linux-omap/drivers/input/keyboard/Makefile =
lin_for_mmc/drivers/input/keyboard/Makefile
--- linux-omap/drivers/input/keyboard/Makefile	2007-05-07 =
20:59:21.000000000 -0500
+++ lin_for_mmc/drivers/input/keyboard/Makefile	2007-05-16 =
18:20:26.000000000 -0500
@@ -23,4 +23,4 @@ obj-$(CONFIG_KEYBOARD_PXA27x)		+=3D pxa27x
 obj-$(CONFIG_KEYBOARD_AAED2000)         +=3D aaed2000_kbd.o
 obj-$(CONFIG_KEYBOARD_GPIO)		+=3D gpio_keys.o
 obj-$(CONFIG_KEYBOARD_TSC2301)		+=3D tsc2301_kp.o
-
+obj-$(CONFIG_KEYBOARD_TWL4030)	  +=3D omap-twl4030keypad.o

diff -purN linux-omap/drivers/input/keyboard/omap-twl4030keypad.c =
lin_for_mmc/drivers/input/keyboard/omap-twl4030keypad.c
--- linux-omap/drivers/input/keyboard/omap-twl4030keypad.c	1969-12-31 =
18:00:00.000000000 -0600
+++ lin_for_mmc/drivers/input/keyboard/omap-twl4030keypad.c	2007-05-16 =
18:27:53.000000000 -0500
@@ -0,0 +1,387 @@
+/*
+ * drivers/input/keyboard/omap-twl4030keypad.c
+ *
+ * Copyright (C) 2007 Texas Instruments, Inc.
+ *
+ * Code re-written for 2430SDP by:
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 =
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
+#define OMAP_TWL4030KP_LOG_LEVEL	0
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
+static char *switch_name[NUM_ROWS][NUM_COLS] =3D {
+	{"S2_L", "S2_D", "S2_S", "S3", "S4", "S23"},
+	{"S2_R", "S2_U", "S5", "S6", "S7", "S24"},
+	{"S8", "S9", "S10", "S11", "S12", "S25"},
+	{"S13", "S14", "S15", "S16", "S17", "S26"},
+	{"S18", "S19", "S20", "S21", "S22", "S27"},
+};
+
+/* Global variables */
+static int *keymap;
+static unsigned char kp_state[NUM_ROWS];
+static struct device * dbg_dev;
+
+/* Function Templates */
+static struct input_dev *omap_twl4030kp;
+struct timer_list kptimer;
+static void omap_kp_timer(unsigned long);
+static void twl4030_kp_scan(void);
+struct work_struct timer_work;
+static void twl4030_timer_work(struct work_struct *unused);
+
+static int twl4030_kpread_u8(u32 module, u8 * data, u32 reg)
+{
+	int ret;
+
+	ret =3D twl4030_i2c_read_u8(module, data, reg);
+	if (ret < 0) {
+		dev_warn(dbg_dev, "Couldn't read TWL4030 register %X - ret %d[%x]\n",
+			 reg, ret, ret);
+		return ret;
+	}
+	return ret;
+}
+
+static int twl4030_kpwrite_u8(u32 module, u8 data, u32 reg)
+{
+	int ret;
+
+	ret =3D twl4030_i2c_write_u8(module, data, reg);
+	if (ret < 0) {
+		dev_warn(dbg_dev, "Could not write TWL4030 register %X - ret =
%d[%x]\n",
+			 reg, ret, ret);
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
+	for (i =3D 0; keymap[i] !=3D 0; i++)
+		if ((keymap[i] & KEYNUM_MASK) =3D=3D key)
+			return keymap[i] & ROWCOL_MASK;
+
+	return -EINVAL;
+}
+
+static void twl4030_kp_scan(void)
+{
+	unsigned char new_state[NUM_ROWS], changed, key_down =3D 0;
+	u8 col, row, spurious =3D 0;
+	u8 code_reg =3D REG_FULL_CODE_7_0;
+	int ret;
+
+	/* check for any changes */
+	ret =3D
+		twl4030_i2c_read(TWL4030_MODULE_KEYPAD, new_state, code_reg,
+				 NUM_ROWS);
+	if (ret < 0)
+		dev_warn(dbg_dev, "Could not read TWL4030 register %X - ret =
%d[%x]\n",
+			 code_reg, ret, ret);
+
+	/* check for changes and print those */
+	for (row =3D 0; row < NUM_ROWS; row++) {
+		changed =3D new_state[row] ^ kp_state[row];
+		key_down |=3D new_state[row];
+
+		if (changed =3D=3D 0)
+			continue;
+
+		for (col =3D 0; col < NUM_COLS; col++) {
+			int key;
+
+			if (!(changed & (1 << col)))
+				continue;
+
+			dev_dbg(dbg_dev, "key %s %s\n", switch_name[row][col],
+				(new_state[row] & (1 << col)) ?
+				"press" : "release");
+
+			key =3D omap_kp_find_key(col, row);
+			if (key < 0) {
+				dev_warn(dbg_dev, "omap-kp: Spurious key event %d-%d\n",
+					 col, row);
+				/* We scan again after a couple of seconds */
+				spurious =3D 1;
+				continue;
+			}
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
+	memcpy(kp_state, new_state, sizeof(kp_state));
+}
+
+static void twl4030_timer_work(struct work_struct *unused)
+{
+	twl4030_kp_scan();
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
+	ret =3D twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, reg, REG_KEYP_IMR1);
+
+	/*
+	 * Scan keypad for any changes
+	 * in keypad matrix.
+	 */
+	twl4030_kp_scan();
+
+	/* Clear TWL4030 PIH interrupt */
+	ret =3D twl4030_kpread_u8(TWL4030_MODULE_KEYPAD, &reg, REG_KEYP_ISR1);
+
+	/* Enable interrupts */
+	reg =3D KEYP_IMR1_UNMASK;
+	ret =3D twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, reg, REG_KEYP_IMR1);
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
+	/* Get the debug Device */
+	dbg_dev =3D &(pdev->dev);
+
+	if (!pdata->rows || !pdata->cols || !pdata->keymap) {
+		dev_err(dbg_dev, "No rows, cols or keymap from pdata\n");
+		return -EINVAL;
+	}
+
+	omap_twl4030kp =3D input_allocate_device();
+	if (omap_twl4030kp =3D=3D NULL)
+		return -ENOMEM;
+
+	keymap =3D pdata->keymap;
+
+	/* setup input device */
+	set_bit(EV_KEY, omap_twl4030kp->evbit);
+
+	/* Enable auto repeat feature of Linux input subsystem */
+	set_bit(EV_REP, omap_twl4030kp->evbit);
+
+	for (i =3D 0; keymap[i] !=3D 0; i++)
+		set_bit(keymap[i] & 0x00ffffff, omap_twl4030kp->keybit);
+
+	omap_twl4030kp->name		=3D "omap_twl4030keypad";
+	omap_twl4030kp->phys		=3D "omap_twl4030keypad/input0";
+	omap_twl4030kp->dev.parent	=3D &pdev->dev;
+
+	omap_twl4030kp->id.bustype	=3D BUS_HOST;
+	omap_twl4030kp->id.vendor	=3D 0x0001;
+	omap_twl4030kp->id.product	=3D 0x0001;
+	omap_twl4030kp->id.version	=3D 0x0003;
+
+	omap_twl4030kp->keycode		=3D keymap;
+	omap_twl4030kp->keycodesize	=3D sizeof(unsigned int);
+	omap_twl4030kp->keycodemax	=3D pdata->keymapsize;
+
+	/* Get the debug Device to omap keypad device */
+	dbg_dev =3D &(omap_twl4030kp->dev);
+
+	ret =3D input_register_device(omap_twl4030kp);
+	if (ret < 0) {
+		dev_err(dbg_dev, "Unable to register twl4030 keypad device\n");
+		goto err2;
+	}
+
+	setup_timer(&kptimer,omap_kp_timer,(unsigned long) omap_twl4030kp);
+
+	/*
+	 * Since keypad driver uses I2C for reading
+	 * twl4030 keypad registers, tasklets cannot
+	 * be used.
+	 */
+	INIT_WORK(&timer_work, twl4030_timer_work);
+
+	reg =3D KEYP_CTRL_REG_MASK_NOAUTORPT;
+	ret =3D twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, reg,
+						REG_KEYP_CTRL_REG);
+	if (ret < 0)
+		goto err3;
+
+	/* Set all events to Falling Edge detection */
+	reg =3D KEYP_EDR_MASK;
+	ret =3D twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, reg, REG_KEYP_EDR);
+	if (ret < 0)
+		goto err3;
+
+	/* Set Pre Scalar Field PTV to 4 */
+	reg =3D BIT_LK_PTV_REG_PTV_MASK & (BIT_PTV_REG_PTV4 << =
BIT_LK_PTV_REG_PTV);
+
+	ret =3D twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, reg, =
REG_LK_PTV_REG);
+	if (ret < 0)
+		goto err3;
+
+	/*
+	 * Set key debounce time to 10 ms using equation
+	 * Tint =3D Tclk * (LOAD_TIM+1) * 2^(PTV+1)
+	 * Where Tclk =3D 31.25 us ( since kbd_if_clk is 32KHz)
+	 * PTV =3D 4 for all the operations.
+	 */
+	ret =3D twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, 0x3f,
+						REG_KEY_DEB_REG);
+	if (ret < 0)
+		goto err3;
+
+	/* Set SIH Ctrl register */
+	reg =3D KEYP_SIH_CTRL_MASK;
+	ret =3D twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, reg,
+						REG_KEYP_SIH_CTRL);
+	if (ret < 0)
+		goto err3;
+
+	/*
+	 * This ISR will always execute in kernel thread context because of
+	 * the need to access the TWL4030 over the I2C bus.
+	 */
+	ret =3D request_irq(TWL4030_MODIRQ_KEYPAD, do_kp_irq,
+		IRQF_DISABLED, "TWL4030 Keypad", omap_twl4030kp);
+	if (ret < 0) {
+		dev_info(dbg_dev, "request_irq failed for irq no=3D%d\n",
+			TWL4030_MODIRQ_KEYPAD);
+		goto err3;
+	} else {
+		/* Enable keypad module interrupts now. */
+		reg =3D KEYP_IMR1_UNMASK;
+		ret =3D twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, reg,
+						REG_KEYP_IMR1);
+		if (ret < 0) {
+			/* mask all events - dont care abt result */
+			(void)twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, 0xff,
+						 REG_KEYP_IMR1);
+			goto err4;
+		}
+	}
+
+	/* Read initial state of keypad matrix. */
+	ret =3D twl4030_i2c_read(TWL4030_MODULE_KEYPAD, kp_state, code_reg,
+		NUM_ROWS);
+	if (ret < 0) {
+		dev_warn(dbg_dev, "Could not read TWL4030 register %X - ret =
%d[%x]\n",
+			 reg, ret, ret);
+		goto err4;
+	}
+	return (ret);
+err4:
+	free_irq(TWL4030_MODIRQ_KEYPAD, NULL);
+err3:
+	input_unregister_device(omap_twl4030kp);
+err2:
+	input_free_device(omap_twl4030kp);
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
+		.name	=3D "omap_twl4030keypad",
+	},
+};
+
+/*
+ * OMAP TWL4030 Keypad init
+ */
+static int __devinit omap_kp_init(void)
+{
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

diff -purN linux-omap/drivers/input/keyboard/twl4030-keypad.h =
lin_for_mmc/drivers/input/keyboard/twl4030-keypad.h
--- linux-omap/drivers/input/keyboard/twl4030-keypad.h	1969-12-31 =
18:00:00.000000000 -0600
+++ lin_for_mmc/drivers/input/keyboard/twl4030-keypad.h	2007-05-16 =
18:22:21.000000000 -0500
@@ -0,0 +1,76 @@
+/*
+ * drivers/input/keyboard/twl4030-keypad.h
+ *
+ * Copyright (C) 2006-2007 Texas Instruments, Inc.
+ *
+ * Intial Code:
+ *	Syed Mohammed Khasim <x0khasim@ti.com>
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 =
 USA
+ */
+#ifndef __TWL4030_KEYPAD_H__
+#define __TWL4030_KEYPAD_H__
+
+/* Register Definitions */
+#define REG_KEYP_CTRL_REG			(0x0)
+#define REG_KEY_DEB_REG				(0x1)
+#define REG_LK_PTV_REG				(0x3)
+#define REG_FULL_CODE_7_0			(0x9)
+#define REG_KEYP_ISR1				(0x11)
+#define REG_KEYP_IMR1				(0x12)
+#define REG_KEYP_EDR				(0x16)
+#define REG_KEYP_SIH_CTRL			(0x17)
+
+/* KEYP_CTRL_REG Fields */
+#define BIT_KEYP_CTRL_REG_SOFT_NRST_MASK	(0x00000001)
+#define BIT_KEYP_CTRL_REG_SOFTMODEN_MASK	(0x00000002)
+#define BIT_KEYP_CTRL_REG_LK_EN_MASK		(0x00000004)
+#define BIT_KEYP_CTRL_REG_TOE_EN_MASK		(0x00000008)
+#define BIT_KEYP_CTRL_REG_TOLE_EN_MASK		(0x00000010)
+#define BIT_KEYP_CTRL_REG_RP_EN_MASK		(0x00000020)
+#define BIT_KEYP_CTRL_REG_KBD_ON_MASK		(0x00000040)
+
+
+#define KEYP_CTRL_REG_MASK_NOAUTORPT		BIT_KEYP_CTRL_REG_SOFT_NRST_MASK =
|\
+						BIT_KEYP_CTRL_REG_SOFTMODEN_MASK |\
+						BIT_KEYP_CTRL_REG_KBD_ON_MASK
+
+/* LK_PTV_REG Fields */
+#define BIT_LK_PTV_REG_PTV			(0x005)
+#define BIT_LK_PTV_REG_PTV_MASK			(0x000000E0)
+#define BIT_PTV_REG_PTV4			(0x4)
+
+/* KEYP_IMR1 Fields */
+#define KEYP_IMR1_MASK				(0x0F)
+#define KEYP_IMR1_UNMASK			(0x00)
+
+/* KEYP_EDR Fields */
+#define BIT_KEYP_EDR_ITKPFALLING_MASK		(0x00000001)
+#define BIT_KEYP_EDR_ITKPRISING_MASK		(0x00000002)
+#define BIT_KEYP_EDR_ITLKFALLING_MASK		(0x00000004)
+#define BIT_KEYP_EDR_ITLKRISING_MASK		(0x00000008)
+#define BIT_KEYP_EDR_ITTOFALLING_MASK		(0x00000010)
+#define BIT_KEYP_EDR_ITTORISING_MASK		(0x00000020)
+#define BIT_KEYP_EDR_ITMISFALLING_MASK		(0x00000040)
+#define BIT_KEYP_EDR_ITMISRISING_MASK		(0x00000080)
+
+#define KEYP_EDR_MASK				BIT_KEYP_EDR_ITKPFALLING_MASK |\
+						BIT_KEYP_EDR_ITLKFALLING_MASK |\
+						BIT_KEYP_EDR_ITTOFALLING_MASK |\
+						BIT_KEYP_EDR_ITMISFALLING_MASK
+/* KEYP_SIH_CTRL Fields */
+#define KEYP_SIH_CTRL_MASK			(0x04)
+
+#endif	/* End of __TWL4030-KEYPAD_H__ */
