From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] omap-keypad: Added driver model
Date: Sat, 26 Nov 2005 01:47:10 -0800 (PST)
Message-ID: <20051126094710.90489.qmail@web32911.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2081946582-1132998430=:88978"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

--0-2081946582-1132998430=:88978
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Tony,

Attached patch adds the driver model support for omap-keypad.c. Moved
muxing to plat-omap/devices.c.

Could you please test it on any of omap1 boards?


---Komal Shah
http://komalshah.blogspot.com/


		
__________________________________ 
Start your day with Yahoo! - Make it your home page! 
http://www.yahoo.com/r/hs
--0-2081946582-1132998430=:88978
Content-Type: text/plain; name="kpplatform.patch"
Content-Description: 1911451890-kpplatform.patch
Content-Disposition: inline; filename="kpplatform.patch"

diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 9dcce90..1bb1058 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -98,6 +98,41 @@ static inline void omap_init_i2c(void) {
 #endif
 
 /*-------------------------------------------------------------------------*/
+#if	defined(CONFIG_KEYBOARD_OMAP) || defined(CONFIG_KEYBOARD_OMAP_MODULE)
+static void omap_init_kp(void)
+{
+	if (machine_is_omap_h2() || machine_is_omap_h3()) {
+		omap_cfg_reg(F18_1610_KBC0);
+		omap_cfg_reg(D20_1610_KBC1);
+		omap_cfg_reg(D19_1610_KBC2);
+		omap_cfg_reg(E18_1610_KBC3);
+		omap_cfg_reg(C21_1610_KBC4);
+
+		omap_cfg_reg(G18_1610_KBR0);
+		omap_cfg_reg(F19_1610_KBR1);
+		omap_cfg_reg(H14_1610_KBR2);
+		omap_cfg_reg(E20_1610_KBR3);
+		omap_cfg_reg(E19_1610_KBR4);
+		omap_cfg_reg(N19_1610_KBR5);
+	} else if (machine_is_omap_perseus2()) {
+		omap_cfg_reg(E2_730_KBR0);
+		omap_cfg_reg(J7_730_KBR1);
+		omap_cfg_reg(E1_730_KBR2);
+		omap_cfg_reg(F3_730_KBR3);
+		omap_cfg_reg(D2_730_KBR4);
+
+		omap_cfg_reg(C2_730_KBC0);
+		omap_cfg_reg(D3_730_KBC1);
+		omap_cfg_reg(E4_730_KBC2);
+		omap_cfg_reg(F4_730_KBC3);
+		omap_cfg_reg(E3_730_KBC4);
+	}
+}
+#else
+static inline void omap_init_kp(void) {}
+#endif
+
+/*-------------------------------------------------------------------------*/
 
 #if	defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
 
@@ -371,6 +406,7 @@ static int __init omap_init_devices(void
 	 */
 	omap_init_fb();
 	omap_init_i2c();
+	omap_init_kp();
 	omap_init_mmc();
 	omap_init_wdt();
 	omap_init_rng();
diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index 5fe8e7a..15351bb 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -31,6 +31,7 @@
 #include <linux/input.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
+#include <linux/platform_device.h>
 #include <asm/arch/irqs.h>
 #include <asm/arch/gpio.h>
 #include <asm/arch/hardware.h>
@@ -44,11 +45,14 @@
 static void omap_kp_tasklet(unsigned long);
 static void omap_kp_timer(unsigned long);
 
-static struct input_dev omap_kp_dev;
 static unsigned char keypad_state[8];
 static unsigned int keypad_irq = INT_KEYBOARD;
 
-static struct timer_list kp_timer;
+struct omap_kp {
+	struct input_dev *input;
+	struct timer_list timer;
+};
+
 DECLARE_TASKLET_DISABLED(kp_tasklet, omap_kp_tasklet, 0);
 
 #define KEY(col, row, val) (((col) << 28) | ((row) << 24) | (val))
@@ -216,6 +220,7 @@ static inline int omap_kp_find_key(int c
 
 static void omap_kp_tasklet(unsigned long data)
 {
+	struct omap_kp *omap_kp_data = (struct omap_kp *) data;
 	unsigned char new_state[8], changed, key_down = 0;
 	int col, row;
 	int spurious = 0;
@@ -246,7 +251,7 @@ static void omap_kp_tasklet(unsigned lon
 				continue;
 			}
 
-			input_report_key(&omap_kp_dev, key,
+			input_report_key(omap_kp_data->input, key,
 					 new_state[col] & (1 << row));
 #endif
 		}
@@ -259,25 +264,56 @@ static void omap_kp_tasklet(unsigned lon
 		 * to poll the keypad */
 		if (spurious)
 			delay = 2 * HZ;
-		mod_timer(&kp_timer, jiffies + delay);
+		mod_timer(&omap_kp_data->timer, jiffies + delay);
 	} else {
 		/* enable interrupts */
 		omap_writew(0, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
 	}
 }
 
-static int __init omap_kp_init(void)
+#ifdef CONFIG_PM
+static int omap_kp_suspend(struct platform_device *dev, pm_message_t state)
+{
+	/* Nothing yet */
+
+	return 0;
+}
+
+static int omap_kp_resume(struct platform_device *dev)
+{
+	/* Nothing yet */
+
+	return 0;
+}
+#else
+#define omap_kp_suspend	NULL
+#define omap_kp_resume	NULL
+#endif
+
+static int __init omap_kp_probe(struct platform_device *pdev)
 {
+	struct omap_kp *omap_kp;
+	struct input_dev *input_dev;
 	int i;
 
-	printk(KERN_INFO "OMAP Keypad Driver\n");
+	omap_kp = kzalloc(sizeof(struct omap_kp), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!omap_kp || !input_dev) {
+		kfree(omap_kp);
+		input_free_device(input_dev);
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(pdev, omap_kp);
+
+	omap_kp->input = input_dev;
 
 	/* Disable the interrupt for the MPUIO keyboard */
 	omap_writew(1, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
 
 	if (machine_is_omap_h2() || machine_is_omap_h3()) {
 		keymap = h2_keymap;
-		set_bit(EV_REP, omap_kp_dev.evbit);
+		set_bit(EV_REP, input_dev->evbit);
 	} else if (machine_is_omap_innovator()) {
 		keymap = innovator_keymap;
 	} else if (machine_is_omap_osk()) {
@@ -289,8 +325,9 @@ static int __init omap_kp_init(void)
 		keymap = test_keymap;
 	}
 
-	init_timer(&kp_timer);
-	kp_timer.function = omap_kp_timer;
+	init_timer(&omap_kp->timer);
+	omap_kp->timer.function = omap_kp_timer;
+	omap_kp->timer.data = (unsigned long) omap_kp;
 
 	/* get the irq and init timer*/
 	tasklet_enable(&kp_tasklet);
@@ -299,43 +336,18 @@ static int __init omap_kp_init(void)
 		return -EINVAL;
 
 	/* setup input device */
-	set_bit(EV_KEY, omap_kp_dev.evbit);
+	set_bit(EV_KEY, input_dev->evbit);
 	for (i = 0; keymap[i] != 0; i++)
-		set_bit(keymap[i] & 0x00ffffff, omap_kp_dev.keybit);
-	omap_kp_dev.name = "omap-keypad";
-	input_register_device(&omap_kp_dev);
-
-	if (machine_is_omap_h2() || machine_is_omap_h3()) {
-		omap_cfg_reg(F18_1610_KBC0);
-		omap_cfg_reg(D20_1610_KBC1);
-		omap_cfg_reg(D19_1610_KBC2);
-		omap_cfg_reg(E18_1610_KBC3);
-		omap_cfg_reg(C21_1610_KBC4);
-
-		omap_cfg_reg(G18_1610_KBR0);
-		omap_cfg_reg(F19_1610_KBR1);
-		omap_cfg_reg(H14_1610_KBR2);
-		omap_cfg_reg(E20_1610_KBR3);
-		omap_cfg_reg(E19_1610_KBR4);
-		omap_cfg_reg(N19_1610_KBR5);
-
-		omap_writew(0xff, OMAP_MPUIO_BASE + OMAP_MPUIO_GPIO_DEBOUNCING);
-	} else if (machine_is_omap_perseus2()) {
-		omap_cfg_reg(E2_730_KBR0);
-		omap_cfg_reg(J7_730_KBR1);
-		omap_cfg_reg(E1_730_KBR2);
-		omap_cfg_reg(F3_730_KBR3);
-		omap_cfg_reg(D2_730_KBR4);
-
-		omap_cfg_reg(C2_730_KBC0);
-		omap_cfg_reg(D3_730_KBC1);
-		omap_cfg_reg(E4_730_KBC2);
-		omap_cfg_reg(F4_730_KBC3);
-		omap_cfg_reg(E3_730_KBC4);
+		set_bit(keymap[i] & 0x00ffffff, input_dev->keybit);
+	input_dev->name = "omap-keypad";
+	input_dev->cdev.dev = &pdev->dev;
+	input_dev->private = omap_kp;
+	input_register_device(omap_kp->input);
 
+	if (machine_is_omap_h2() || machine_is_omap_h3() ||
+	    machine_is_omap_perseus2()) {
 		omap_writew(0xff, OMAP_MPUIO_BASE + OMAP_MPUIO_GPIO_DEBOUNCING);
 	}
-
 	/* scan current status and enable interrupt */
 	omap_kp_scan_keypad(keypad_state);
 	omap_writew(0, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
@@ -343,17 +355,44 @@ static int __init omap_kp_init(void)
 	return 0;
 }
 
-static void __exit omap_kp_exit(void)
+static int omap_kp_remove(struct platform_device *pdev)
 {
+	struct omap_kp *omap_kp = platform_get_drvdata(pdev);
+
 	/* disable keypad interrupt handling */
 	tasklet_disable(&kp_tasklet);
 	omap_writew(1, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
 
 	free_irq(keypad_irq, 0);
-	del_timer_sync(&kp_timer);
+	del_timer_sync(&omap_kp->timer);
 
 	/* unregister everything */
-	input_unregister_device(&omap_kp_dev);
+	input_unregister_device(omap_kp->input);
+
+	kfree(omap_kp);
+
+	return 0;
+}
+
+static struct platform_driver omap_kp_driver = {
+	.probe		= omap_kp_probe,
+	.remove		= omap_kp_remove,
+	.suspend	= omap_kp_suspend,
+	.resume		= omap_kp_resume,
+	.driver		= {
+		.name	= "omap-keypad",
+	},
+};
+
+static int __devinit omap_kp_init(void)
+{
+	printk(KERN_INFO "OMAP Keypad Driver\n");
+	return platform_driver_register(&omap_kp_driver);
+}
+
+static void __exit omap_kp_exit(void)
+{
+	platform_driver_unregister(&omap_kp_driver);
 }
 
 module_init(omap_kp_init);

--0-2081946582-1132998430=:88978
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source

--0-2081946582-1132998430=:88978--
