From: "Syed Rafiuddin" <rafiuddin.syed@ti.com>
Subject: [PATCH][RFC] OMAP4: Keypad Support for OMAP4430
Date: Wed, 22 Jul 2009 19:20:23 +0530 (IST)
Message-ID: <54980.192.168.10.89.1248270623.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

This patch adds OMAP4 support to the Keypad driver. This patch adds
OMAP4 register addresses and configures registers for OMAP4.

Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
---
 drivers/input/keyboard/omap-keypad.c |  109 ++++++++++++++++++++++++++++++-----
 1 files changed, 95 insertions(+), 14 deletions(-)

Index: kernel-omap4/drivers/input/keyboard/omap-keypad.c
===================================================================
--- kernel-omap4.orig/drivers/input/keyboard/omap-keypad.c
+++ kernel-omap4/drivers/input/keyboard/omap-keypad.c
@@ -44,6 +44,36 @@

 #undef NEW_BOARD_LEARNING_MODE

+#define OMAP4_KBDOCP_BASE		0x4A31C000
+#define OMAP4_KBD_REVISION		0x00
+#define OMAP4_KBD_SYSCONFIG		0x10
+#define OMAP4_KBD_SYSSTATUS		0x14
+#define OMAP4_KBD_IRQSTATUS		0x18
+#define OMAP4_KBD_IRQENABLE		0x1C
+#define OMAP4_KBD_WAKEUPENABLE		0x20
+#define OMAP4_KBD_PENDING		0x24
+#define OMAP4_KBD_CTRL			0x28
+#define OMAP4_KBD_DEBOUNCINGTIME	0x2C
+#define OMAP4_KBD_LONGKEYTIME		0x30
+#define OMAP4_KBD_TIMEOUT		0x34
+#define OMAP4_KBD_STATEMACHINE		0x38
+#define OMAP4_KBD_ROWINPUTS		0x3C
+#define OMAP4_KBD_COLUMNOUTPUTS		0x40
+#define OMAP4_KBD_FULLCODE31_0		0x44
+#define OMAP4_KBD_FULLCODE63_32		0x48
+
+#define OMAP4_KBD_SYSCONFIG_SOFTRST	(1 << 1)
+#define OMAP4_KBD_SYSCONFIG_ENAWKUP	(1 << 2)
+#define OMAP4_KBD_IRQENABLE_EVENTEN	(1 << 0)
+#define OMAP4_KBD_IRQENABLE_LONGKEY	(1 << 1)
+#define OMAP4_KBD_IRQENABLE_TIMEOUTEN	(1 << 2)
+#define OMAP4_KBD_CTRL_NOSOFTMODE	(1 << 1)
+#define OMAP4_KBD_CTRLPTVVALUE		(1 << 2)
+#define OMAP4_KBD_CTRLPTV		(1 << 1)
+#define OMAP4_KBD_IRQDISABLE		0x00
+
+#define OMAP4_KBD_IRQSTATUSDISABLE	0xffff
+
 static void omap_kp_tasklet(unsigned long);
 static void omap_kp_timer(unsigned long);

@@ -114,6 +144,13 @@ static irqreturn_t omap_kp_interrupt(int
 			else
 				disable_irq(gpio_irq);
 		}
+	} else if (cpu_is_omap44xx()) {
+		/* disable keyboard interrupt and schedule for handling */
+		omap_writel(OMAP4_KBD_IRQDISABLE, OMAP4_KBDOCP_BASE +
+				OMAP4_KBD_IRQENABLE);
+
+		omap_writel(omap_readl(OMAP4_KBDOCP_BASE + OMAP4_KBD_IRQSTATUS),
+				OMAP4_KBDOCP_BASE + OMAP4_KBD_IRQSTATUS);
 	} else
 		/* disable keyboard interrupt and schedule for handling */
 		omap_writew(1, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
@@ -131,7 +168,7 @@ static void omap_kp_timer(unsigned long
 static void omap_kp_scan_keypad(struct omap_kp *omap_kp, unsigned char *state)
 {
 	int col = 0;
-
+	u32 *p = (u32 *) state;
 	/* read the keypad status */
 	if (cpu_is_omap24xx()) {
 		/* read the keypad status */
@@ -141,6 +178,10 @@ static void omap_kp_scan_keypad(struct o
 		}
 		set_col_gpio_val(omap_kp, 0);

+	} else if (cpu_is_omap44xx()) {
+		*p = omap_readl(OMAP4_KBDOCP_BASE + OMAP4_KBD_FULLCODE31_0);
+		*(p + 1) = omap_readl(OMAP4_KBDOCP_BASE +
+					OMAP4_KBD_FULLCODE63_32);
 	} else {
 		/* disable keyboard interrupt and schedule for handling */
 		omap_writew(1, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
@@ -198,7 +239,12 @@ static void omap_kp_tasklet(unsigned lon
 			       row, (new_state[col] & (1 << row)) ?
 			       "pressed" : "released");
 #else
-			key = omap_kp_find_key(col, row);
+			/* Keymappings have changed in omap4.*/
+			if (cpu_is_omap44xx())
+				key = omap_kp_find_key(row, col);
+			else
+				key = omap_kp_find_key(col, row);
+
 			if (key < 0) {
 				printk(KERN_WARNING
 				      "omap-keypad: Spurious key event %d-%d\n",
@@ -213,8 +259,14 @@ static void omap_kp_tasklet(unsigned lon
 				continue;

 			kp_cur_group = key & GROUP_MASK;
-			input_report_key(omap_kp_data->input, key & ~GROUP_MASK,
-					 new_state[col] & (1 << row));
+			if (cpu_is_omap44xx())
+				input_report_key(omap_kp_data->input,
+					key & ~GROUP_MASK, new_state[row]
+						 & (1 << col));
+			else
+				input_report_key(omap_kp_data->input,
+					 key & ~GROUP_MASK, new_state[col]
+						 & (1 << row));
 #endif
 		}
 	}
@@ -233,10 +285,18 @@ static void omap_kp_tasklet(unsigned lon
 			int i;
 			for (i = 0; i < omap_kp_data->rows; i++)
 				enable_irq(gpio_to_irq(row_gpios[i]));
-		} else {
-			omap_writew(0, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
-			kp_cur_group = -1;
-		}
+
+		} else if (cpu_is_omap44xx()) {
+				omap_writew(OMAP4_KBD_IRQENABLE_EVENTEN |
+					OMAP4_KBD_IRQENABLE_LONGKEY,
+					OMAP4_KBDOCP_BASE +
+					OMAP4_KBD_IRQENABLE);
+				kp_cur_group = -1;
+			} else {
+				omap_writew(0, OMAP_MPUIO_BASE +
+						OMAP_MPUIO_KBD_MASKIT);
+				kp_cur_group = -1;
+			}
 	}
 }

@@ -316,7 +376,7 @@ static int __devinit omap_kp_probe(struc
 	omap_kp->input = input_dev;

 	/* Disable the interrupt for the MPUIO keyboard */
-	if (!cpu_is_omap24xx())
+	if (!cpu_is_omap24xx() && !cpu_is_omap44xx())
 		omap_writew(1, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);

 	keymap = pdata->keymap;
@@ -390,19 +450,35 @@ static int __devinit omap_kp_probe(struc
 		goto err3;
 	}

-	if (pdata->dbounce)
-		omap_writew(0xff, OMAP_MPUIO_BASE + OMAP_MPUIO_GPIO_DEBOUNCING);
-
+	if (pdata->dbounce) {
+		if (cpu_is_omap44xx())
+			omap_writew(0xff, OMAP_MPUIO_BASE +
+					OMAP4_KBD_DEBOUNCINGTIME);
+		else
+			omap_writew(0xff, OMAP_MPUIO_BASE +
+					OMAP_MPUIO_GPIO_DEBOUNCING);
+	}
 	/* scan current status and enable interrupt */
 	omap_kp_scan_keypad(omap_kp, keypad_state);
+
+	/* Configuring OMAP4 keypad registers */
+	if (cpu_is_omap44xx()) {
+		omap_writew(OMAP4_KBD_SYSCONFIG_SOFTRST |
+			 OMAP4_KBD_SYSCONFIG_ENAWKUP, OMAP4_KBDOCP_BASE
+					+ OMAP4_KBD_SYSCONFIG);
+		omap_writew((OMAP4_KBD_CTRLPTVVALUE << OMAP4_KBD_CTRLPTV) |
+					OMAP4_KBD_CTRL_NOSOFTMODE,
+					OMAP4_KBDOCP_BASE + OMAP4_KBD_CTRL);
+	}
 	if (!cpu_is_omap24xx()) {
 		omap_kp->irq = platform_get_irq(pdev, 0);
 		if (omap_kp->irq >= 0) {
-			if (request_irq(omap_kp->irq, omap_kp_interrupt, 0,
+			if (request_irq(152, omap_kp_interrupt, 0,
 					"omap-keypad", omap_kp) < 0)
 				goto err4;
 		}
-		omap_writew(0, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
+		if (!cpu_is_omap44xx())
+			omap_writew(0, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
 	} else {
 		for (irq_idx = 0; irq_idx < omap_kp->rows; irq_idx++) {
 			if (request_irq(gpio_to_irq(row_gpios[irq_idx]),
@@ -412,6 +488,11 @@ static int __devinit omap_kp_probe(struc
 				goto err5;
 		}
 	}
+	if (cpu_is_omap44xx()) {
+		omap_writew(OMAP4_KBD_IRQENABLE_EVENTEN |
+			OMAP4_KBD_IRQENABLE_LONGKEY, OMAP4_KBDOCP_BASE +
+				OMAP4_KBD_IRQENABLE);
+	}
 	return 0;
 err5:
 	for (i = irq_idx - 1; i >=0; i--)


