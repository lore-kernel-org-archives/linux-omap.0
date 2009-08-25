From: "Syed Rafiuddin" <rafiuddin.syed@ti.com>
Subject: [PATCH-v2][RFC] OMAP4: Keypad Support for OMAP4430
Date: Tue, 25 Aug 2009 16:09:03 +0530 (IST)
Message-ID: <47940.192.168.10.88.1251196743.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: soni.trilok@gmail.com, linux-input@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Syed Rafiuddin <rafiuddin.syed@ti.com>

Resending with correct Subject.

This patch Adds Keypad support on OMAP4.And adds
OMAP4 register addresses and configures them for OMAP4.


This patch has been updated as per the comments received from
Trilok Soni to remove GPIO based omap2 keypad logic from omap_keypad.c
(http://www.mail-archive.com/linux-omap@vger.kernel.org/msg14570.html)
Matrix_keypad.c (gpio based keypad driver) can be used in OMAP2,
which is not tested on OMAP2 since unavailability of omap2 target's.


Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
---
 drivers/input/keyboard/omap-keypad.c |  247 ++++++++++++++++-------------------
 1 files changed, 115 insertions(+), 132 deletions(-)

Index: kernel-omap4-base/drivers/input/keyboard/omap-keypad.c
===================================================================
--- kernel-omap4-base.orig/drivers/input/keyboard/omap-keypad.c
+++ kernel-omap4-base/drivers/input/keyboard/omap-keypad.c
@@ -44,6 +44,36 @@

 #undef NEW_BOARD_LEARNING_MODE

+#define OMAP4_KBDOCP_BASE              0x4A31C000
+#define OMAP4_KBD_REVISION             0x00
+#define OMAP4_KBD_SYSCONFIG            0x10
+#define OMAP4_KBD_SYSSTATUS            0x14
+#define OMAP4_KBD_IRQSTATUS            0x18
+#define OMAP4_KBD_IRQENABLE            0x1C
+#define OMAP4_KBD_WAKEUPENABLE         0x20
+#define OMAP4_KBD_PENDING              0x24
+#define OMAP4_KBD_CTRL                 0x28
+#define OMAP4_KBD_DEBOUNCINGTIME       0x2C
+#define OMAP4_KBD_LONGKEYTIME          0x30
+#define OMAP4_KBD_TIMEOUT              0x34
+#define OMAP4_KBD_STATEMACHINE         0x38
+#define OMAP4_KBD_ROWINPUTS            0x3C
+#define OMAP4_KBD_COLUMNOUTPUTS                0x40
+#define OMAP4_KBD_FULLCODE31_0         0x44
+#define OMAP4_KBD_FULLCODE63_32                0x48
+
+#define OMAP4_KBD_SYSCONFIG_SOFTRST    (1 << 1)
+#define OMAP4_KBD_SYSCONFIG_ENAWKUP    (1 << 2)
+#define OMAP4_KBD_IRQENABLE_EVENTEN    (1 << 0)
+#define OMAP4_KBD_IRQENABLE_LONGKEY    (1 << 1)
+#define OMAP4_KBD_IRQENABLE_TIMEOUTEN  (1 << 2)
+#define OMAP4_KBD_CTRL_NOSOFTMODE      (1 << 1)
+#define OMAP4_KBD_CTRLPTVVALUE         (1 << 2)
+#define OMAP4_KBD_CTRLPTV              (1 << 1)
+#define OMAP4_KBD_IRQDISABLE           0x00
+
+#define OMAP4_KBD_IRQSTATUSDISABLE     0xffff
+
 static void omap_kp_tasklet(unsigned long);
 static void omap_kp_timer(unsigned long);

@@ -65,55 +95,16 @@ struct omap_kp {
 static DECLARE_TASKLET_DISABLED(kp_tasklet, omap_kp_tasklet, 0);

 static int *keymap;
-static unsigned int *row_gpios;
-static unsigned int *col_gpios;
-
-#ifdef CONFIG_ARCH_OMAP2
-static void set_col_gpio_val(struct omap_kp *omap_kp, u8 value)
-{
-	int col;
-
-	for (col = 0; col < omap_kp->cols; col++)
-		gpio_set_value(col_gpios[col], value & (1 << col));
-}
-
-static u8 get_row_gpio_val(struct omap_kp *omap_kp)
-{
-	int row;
-	u8 value = 0;
-
-	for (row = 0; row < omap_kp->rows; row++) {
-		if (gpio_get_value(row_gpios[row]))
-			value |= (1 << row);
-	}
-	return value;
-}
-#else
-#define		set_col_gpio_val(x, y)	do {} while (0)
-#define		get_row_gpio_val(x)	0
-#endif

 static irqreturn_t omap_kp_interrupt(int irq, void *dev_id)
 {
-	struct omap_kp *omap_kp = dev_id;
+	if (cpu_is_omap44xx()) {
+		/* disable keyboard interrupt and schedule for handling */
+		omap_writel(OMAP4_KBD_IRQDISABLE, OMAP4_KBDOCP_BASE +
+			OMAP4_KBD_IRQENABLE);

-	/* disable keyboard interrupt and schedule for handling */
-	if (cpu_is_omap24xx()) {
-		int i;
-
-		for (i = 0; i < omap_kp->rows; i++) {
-			int gpio_irq = gpio_to_irq(row_gpios[i]);
-			/*
-			 * The interrupt which we're currently handling should
-			 * be disabled _nosync() to avoid deadlocks waiting
-			 * for this handler to complete.  All others should
-			 * be disabled the regular way for SMP safety.
-			 */
-			if (gpio_irq == irq)
-				disable_irq_nosync(gpio_irq);
-			else
-				disable_irq(gpio_irq);
-		}
+		omap_writel(omap_readl(OMAP4_KBDOCP_BASE + OMAP4_KBD_IRQSTATUS),
+			OMAP4_KBDOCP_BASE + OMAP4_KBD_IRQSTATUS);
 	} else
 		/* disable keyboard interrupt and schedule for handling */
 		omap_writew(1, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
@@ -132,14 +123,13 @@ static void omap_kp_scan_keypad(struct o
 {
 	int col = 0;

+	u32 *p = (u32 *) state;
 	/* read the keypad status */
-	if (cpu_is_omap24xx()) {
-		/* read the keypad status */
-		for (col = 0; col < omap_kp->cols; col++) {
-			set_col_gpio_val(omap_kp, ~(1 << col));
-			state[col] = ~(get_row_gpio_val(omap_kp)) & 0xff;
-		}
-		set_col_gpio_val(omap_kp, 0);
+	if (cpu_is_omap44xx()) {
+
+		*p = omap_readl(OMAP4_KBDOCP_BASE + OMAP4_KBD_FULLCODE31_0);
+		*(p + 1) = omap_readl(OMAP4_KBDOCP_BASE +
+					OMAP4_KBD_FULLCODE63_32);

 	} else {
 		/* disable keyboard interrupt and schedule for handling */
@@ -198,7 +188,13 @@ static void omap_kp_tasklet(unsigned lon
 			       row, (new_state[col] & (1 << row)) ?
 			       "pressed" : "released");
 #else
-			key = omap_kp_find_key(col, row);
+
+			/* Keymappings have changed in omap4.*/
+			if (cpu_is_omap44xx())
+				key = omap_kp_find_key(row, col);
+			else
+				key = omap_kp_find_key(col, row);
+
 			if (key < 0) {
 				printk(KERN_WARNING
 				      "omap-keypad: Spurious key event %d-%d\n",
@@ -213,8 +209,16 @@ static void omap_kp_tasklet(unsigned lon
 				continue;

 			kp_cur_group = key & GROUP_MASK;
-			input_report_key(omap_kp_data->input, key & ~GROUP_MASK,
-					 new_state[col] & (1 << row));
+
+			if (cpu_is_omap44xx())
+				input_report_key(omap_kp_data->input,
+					key & ~GROUP_MASK, new_state[row]
+						& (1 << col));
+			else
+				input_report_key(omap_kp_data->input,
+					key & ~GROUP_MASK, new_state[col]
+						& (1 << row));
+
 #endif
 		}
 	}
@@ -229,14 +233,18 @@ static void omap_kp_tasklet(unsigned lon
 		mod_timer(&omap_kp_data->timer, jiffies + delay);
 	} else {
 		/* enable interrupts */
-		if (cpu_is_omap24xx()) {
-			int i;
-			for (i = 0; i < omap_kp_data->rows; i++)
-				enable_irq(gpio_to_irq(row_gpios[i]));
-		} else {
-			omap_writew(0, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
+		if (cpu_is_omap44xx()) {
+			omap_writew(OMAP4_KBD_IRQENABLE_EVENTEN |
+				OMAP4_KBD_IRQENABLE_LONGKEY,
+					OMAP4_KBDOCP_BASE +
+					OMAP4_KBD_IRQENABLE);
 			kp_cur_group = -1;
-		}
+		} else {
+			omap_writew(0, OMAP_MPUIO_BASE +
+				OMAP_MPUIO_KBD_MASKIT);
+				kp_cur_group = -1;
+			}
+
 	}
 }

@@ -296,7 +304,7 @@ static int __devinit omap_kp_probe(struc
 	struct omap_kp *omap_kp;
 	struct input_dev *input_dev;
 	struct omap_kp_platform_data *pdata =  pdev->dev.platform_data;
-	int i, col_idx, row_idx, irq_idx, ret;
+	int i, col_idx, row_idx, ret;

 	if (!pdata->rows || !pdata->cols || !pdata->keymap) {
 		printk(KERN_ERR "No rows, cols or keymap from pdata\n");
@@ -316,7 +324,7 @@ static int __devinit omap_kp_probe(struc
 	omap_kp->input = input_dev;

 	/* Disable the interrupt for the MPUIO keyboard */
-	if (!cpu_is_omap24xx())
+	if (!cpu_is_omap44xx())
 		omap_writew(1, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);

 	keymap = pdata->keymap;
@@ -327,39 +335,11 @@ static int __devinit omap_kp_probe(struc
 	if (pdata->delay)
 		omap_kp->delay = pdata->delay;

-	if (pdata->row_gpios && pdata->col_gpios) {
-		row_gpios = pdata->row_gpios;
-		col_gpios = pdata->col_gpios;
-	}
-
 	omap_kp->rows = pdata->rows;
 	omap_kp->cols = pdata->cols;

-	if (cpu_is_omap24xx()) {
-		/* Cols: outputs */
-		for (col_idx = 0; col_idx < omap_kp->cols; col_idx++) {
-			if (gpio_request(col_gpios[col_idx], "omap_kp_col") < 0) {
-				printk(KERN_ERR "Failed to request"
-				       "GPIO%d for keypad\n",
-				       col_gpios[col_idx]);
-				goto err1;
-			}
-			gpio_direction_output(col_gpios[col_idx], 0);
-		}
-		/* Rows: inputs */
-		for (row_idx = 0; row_idx < omap_kp->rows; row_idx++) {
-			if (gpio_request(row_gpios[row_idx], "omap_kp_row") < 0) {
-				printk(KERN_ERR "Failed to request"
-				       "GPIO%d for keypad\n",
-				       row_gpios[row_idx]);
-				goto err2;
-			}
-			gpio_direction_input(row_gpios[row_idx]);
-		}
-	} else {
-		col_idx = 0;
-		row_idx = 0;
-	}
+	col_idx = 0;
+	row_idx = 0;

 	setup_timer(&omap_kp->timer, omap_kp_timer, (unsigned long)omap_kp);

@@ -369,7 +349,7 @@ static int __devinit omap_kp_probe(struc

 	ret = device_create_file(&pdev->dev, &dev_attr_enable);
 	if (ret < 0)
-		goto err2;
+		goto err1;

 	/* setup input device */
 	__set_bit(EV_KEY, input_dev->evbit);
@@ -387,47 +367,54 @@ static int __devinit omap_kp_probe(struc
 	ret = input_register_device(omap_kp->input);
 	if (ret < 0) {
 		printk(KERN_ERR "Unable to register omap-keypad input device\n");
-		goto err3;
+		goto err2;
 	}

-	if (pdata->dbounce)
-		omap_writew(0xff, OMAP_MPUIO_BASE + OMAP_MPUIO_GPIO_DEBOUNCING);
+	if (pdata->dbounce) {
+		if (cpu_is_omap44xx())
+			omap_writew(0xff, OMAP_MPUIO_BASE +
+				OMAP4_KBD_DEBOUNCINGTIME);
+		else
+			omap_writew(0xff, OMAP_MPUIO_BASE +
+				OMAP_MPUIO_GPIO_DEBOUNCING);
+	}

 	/* scan current status and enable interrupt */
 	omap_kp_scan_keypad(omap_kp, keypad_state);
-	if (!cpu_is_omap24xx()) {
-		omap_kp->irq = platform_get_irq(pdev, 0);
-		if (omap_kp->irq >= 0) {
-			if (request_irq(omap_kp->irq, omap_kp_interrupt, 0,
-					"omap-keypad", omap_kp) < 0)
-				goto err4;
-		}
+
+	/* Configuring OMAP4 keypad registers */
+	if (cpu_is_omap44xx()) {
+		omap_writew(OMAP4_KBD_SYSCONFIG_SOFTRST |
+			OMAP4_KBD_SYSCONFIG_ENAWKUP, OMAP4_KBDOCP_BASE
+				+ OMAP4_KBD_SYSCONFIG);
+		omap_writew((OMAP4_KBD_CTRLPTVVALUE << OMAP4_KBD_CTRLPTV) |
+			OMAP4_KBD_CTRL_NOSOFTMODE,
+				OMAP4_KBDOCP_BASE + OMAP4_KBD_CTRL);
+	}
+
+	omap_kp->irq = platform_get_irq(pdev, 0);
+
+	if (omap_kp->irq >= 0) {
+		if (request_irq(omap_kp->irq, omap_kp_interrupt, 0,
+				"omap-keypad", omap_kp) < 0)
+			goto err3;
+	}
+
+	if (!cpu_is_omap44xx())
 		omap_writew(0, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
-	} else {
-		for (irq_idx = 0; irq_idx < omap_kp->rows; irq_idx++) {
-			if (request_irq(gpio_to_irq(row_gpios[irq_idx]),
-					omap_kp_interrupt,
-					IRQF_TRIGGER_FALLING,
-					"omap-keypad", omap_kp) < 0)
-				goto err5;
-		}
+
+	if (cpu_is_omap44xx()) {
+		omap_writew(OMAP4_KBD_IRQENABLE_EVENTEN |
+			OMAP4_KBD_IRQENABLE_LONGKEY, OMAP4_KBDOCP_BASE +
+				OMAP4_KBD_IRQENABLE);
 	}
 	return 0;
-err5:
-	for (i = irq_idx - 1; i >=0; i--)
-		free_irq(row_gpios[i], 0);
-err4:
+err3:
 	input_unregister_device(omap_kp->input);
 	input_dev = NULL;
-err3:
-	device_remove_file(&pdev->dev, &dev_attr_enable);
 err2:
-	for (i = row_idx - 1; i >=0; i--)
-		gpio_free(row_gpios[i]);
+	device_remove_file(&pdev->dev, &dev_attr_enable);
 err1:
-	for (i = col_idx - 1; i >=0; i--)
-		gpio_free(col_gpios[i]);
-
 	kfree(omap_kp);
 	input_free_device(input_dev);

@@ -440,14 +427,10 @@ static int __devexit omap_kp_remove(stru

 	/* disable keypad interrupt handling */
 	tasklet_disable(&kp_tasklet);
-	if (cpu_is_omap24xx()) {
-		int i;
-		for (i = 0; i < omap_kp->cols; i++)
-			gpio_free(col_gpios[i]);
-		for (i = 0; i < omap_kp->rows; i++) {
-			gpio_free(row_gpios[i]);
-			free_irq(gpio_to_irq(row_gpios[i]), 0);
-		}
+	if (cpu_is_omap44xx()) {
+		omap_writel(OMAP4_KBD_IRQDISABLE, OMAP4_KBDOCP_BASE +
+			OMAP4_KBD_IRQENABLE);
+		free_irq(omap_kp->irq, 0);
 	} else {
 		omap_writew(1, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);


