From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 07/17] Input: omap-keypad: Remove dependencies to mach
 includes
Date: Tue, 11 Sep 2012 10:56:34 -0700
Message-ID: <20120911175633.GG23092@atomide.com>
References: <20120911052934.29637.9190.stgit@muffinssi.local>
 <20120911053059.29637.22108.stgit@muffinssi.local>
 <20120911055709.GB17865@arwen.pp.htv.fi>
 <20120911061652.GA23092@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120911061652.GA23092@atomide.com>
Sender: linux-input-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Sourav Poddar <sourav.poddar@ti.com>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [120910 23:17]:
> * Felipe Balbi <balbi@ti.com> [120910 23:02]:
>  
> > >  static int __devinit omap_kp_probe(struct platform_device *pdev)
> > >  {
> > > -	struct omap_kp *omap_kp;
> > 
> > ???? I don't see the point for that global omap_kp, actually ...
> 
> Yes you're right. Will send an updated one tomorrow.

Here's the updated patch that just removes all omap2+ code,
and does not use the global omap_kp.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Fri, 7 Sep 2012 13:27:58 -0700
Subject: [PATCH] Input: omap-keypad: Remove dependencies to mach includes

Remove support for omap2+ as it's no longer needed since
it's using matrix-keypad. This way we can remove depency
to plat and mach headers which is needed for ARM common
zImage support.

Also remove INT_KEYBOARD by using omap_kp->irq.

Note that this patch depends on an earlier patch
"ARM: OMAP: Move gpio.h to include/linux/platform_data".

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -533,7 +533,7 @@ config KEYBOARD_DAVINCI
 
 config KEYBOARD_OMAP
 	tristate "TI OMAP keypad support"
-	depends on (ARCH_OMAP1 || ARCH_OMAP2)
+	depends on ARCH_OMAP1
 	select INPUT_MATRIXKMAP
 	help
 	  Say Y here if you want to use the OMAP keypad.
diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index a0222db..2bda5f0b 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -35,13 +35,9 @@
 #include <linux/mutex.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
-#include <asm/gpio.h>
+#include <linux/gpio.h>
+#include <linux/platform_data/gpio-omap.h>
 #include <plat/keypad.h>
-#include <plat/menelaus.h>
-#include <asm/irq.h>
-#include <mach/hardware.h>
-#include <asm/io.h>
-#include <plat/mux.h>
 
 #undef NEW_BOARD_LEARNING_MODE
 
@@ -96,28 +92,8 @@ static u8 get_row_gpio_val(struct omap_kp *omap_kp)
 
 static irqreturn_t omap_kp_interrupt(int irq, void *dev_id)
 {
-	struct omap_kp *omap_kp = dev_id;
-
 	/* disable keyboard interrupt and schedule for handling */
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
-	} else
-		/* disable keyboard interrupt and schedule for handling */
-		omap_writew(1, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
+	omap_writew(1, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
 
 	tasklet_schedule(&kp_tasklet);
 
@@ -133,33 +109,22 @@ static void omap_kp_scan_keypad(struct omap_kp *omap_kp, unsigned char *state)
 {
 	int col = 0;
 
-	/* read the keypad status */
-	if (cpu_is_omap24xx()) {
-		/* read the keypad status */
-		for (col = 0; col < omap_kp->cols; col++) {
-			set_col_gpio_val(omap_kp, ~(1 << col));
-			state[col] = ~(get_row_gpio_val(omap_kp)) & 0xff;
-		}
-		set_col_gpio_val(omap_kp, 0);
-
-	} else {
-		/* disable keyboard interrupt and schedule for handling */
-		omap_writew(1, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
+	/* disable keyboard interrupt and schedule for handling */
+	omap_writew(1, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
 
-		/* read the keypad status */
-		omap_writew(0xff, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBC);
-		for (col = 0; col < omap_kp->cols; col++) {
-			omap_writew(~(1 << col) & 0xff,
-				    OMAP1_MPUIO_BASE + OMAP_MPUIO_KBC);
+	/* read the keypad status */
+	omap_writew(0xff, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBC);
+	for (col = 0; col < omap_kp->cols; col++) {
+		omap_writew(~(1 << col) & 0xff,
+			    OMAP1_MPUIO_BASE + OMAP_MPUIO_KBC);
 
-			udelay(omap_kp->delay);
+		udelay(omap_kp->delay);
 
-			state[col] = ~omap_readw(OMAP1_MPUIO_BASE +
-						 OMAP_MPUIO_KBR_LATCH) & 0xff;
-		}
-		omap_writew(0x00, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBC);
-		udelay(2);
+		state[col] = ~omap_readw(OMAP1_MPUIO_BASE +
+					 OMAP_MPUIO_KBR_LATCH) & 0xff;
 	}
+	omap_writew(0x00, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBC);
+	udelay(2);
 }
 
 static void omap_kp_tasklet(unsigned long data)
@@ -222,14 +187,8 @@ static void omap_kp_tasklet(unsigned long data)
 		mod_timer(&omap_kp_data->timer, jiffies + delay);
 	} else {
 		/* enable interrupts */
-		if (cpu_is_omap24xx()) {
-			int i;
-			for (i = 0; i < omap_kp_data->rows; i++)
-				enable_irq(gpio_to_irq(row_gpios[i]));
-		} else {
-			omap_writew(0, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
-			kp_cur_group = -1;
-		}
+		omap_writew(0, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
+		kp_cur_group = -1;
 	}
 }
 
@@ -242,6 +201,7 @@ static ssize_t omap_kp_enable_show(struct device *dev,
 static ssize_t omap_kp_enable_store(struct device *dev, struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
+	struct omap_kp *omap_kp = dev_get_drvdata(dev);
 	int state;
 
 	if (sscanf(buf, "%u", &state) != 1)
@@ -253,9 +213,9 @@ static ssize_t omap_kp_enable_store(struct device *dev, struct device_attribute
 	mutex_lock(&kp_enable_mutex);
 	if (state != kp_enable) {
 		if (state)
-			enable_irq(INT_KEYBOARD);
+			enable_irq(omap_kp->irq);
 		else
-			disable_irq(INT_KEYBOARD);
+			disable_irq(omap_kp->irq);
 		kp_enable = state;
 	}
 	mutex_unlock(&kp_enable_mutex);
@@ -289,7 +249,7 @@ static int __devinit omap_kp_probe(struct platform_device *pdev)
 	struct omap_kp *omap_kp;
 	struct input_dev *input_dev;
 	struct omap_kp_platform_data *pdata =  pdev->dev.platform_data;
-	int i, col_idx, row_idx, irq_idx, ret;
+	int i, col_idx, row_idx, ret;
 	unsigned int row_shift, keycodemax;
 
 	if (!pdata->rows || !pdata->cols || !pdata->keymap_data) {
@@ -314,8 +274,7 @@ static int __devinit omap_kp_probe(struct platform_device *pdev)
 	omap_kp->input = input_dev;
 
 	/* Disable the interrupt for the MPUIO keyboard */
-	if (!cpu_is_omap24xx())
-		omap_writew(1, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
+	omap_writew(1, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
 
 	if (pdata->delay)
 		omap_kp->delay = pdata->delay;
@@ -328,31 +287,8 @@ static int __devinit omap_kp_probe(struct platform_device *pdev)
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
 
@@ -394,27 +330,16 @@ static int __devinit omap_kp_probe(struct platform_device *pdev)
 
 	/* scan current status and enable interrupt */
 	omap_kp_scan_keypad(omap_kp, keypad_state);
-	if (!cpu_is_omap24xx()) {
-		omap_kp->irq = platform_get_irq(pdev, 0);
-		if (omap_kp->irq >= 0) {
-			if (request_irq(omap_kp->irq, omap_kp_interrupt, 0,
-					"omap-keypad", omap_kp) < 0)
-				goto err4;
-		}
-		omap_writew(0, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
-	} else {
-		for (irq_idx = 0; irq_idx < omap_kp->rows; irq_idx++) {
-			if (request_irq(gpio_to_irq(row_gpios[irq_idx]),
-					omap_kp_interrupt,
-					IRQF_TRIGGER_FALLING,
-					"omap-keypad", omap_kp) < 0)
-				goto err5;
-		}
+	omap_kp->irq = platform_get_irq(pdev, 0);
+	if (omap_kp->irq >= 0) {
+		if (request_irq(omap_kp->irq, omap_kp_interrupt, 0,
+				"omap-keypad", omap_kp) < 0)
+			goto err4;
 	}
+	omap_writew(0, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
+
 	return 0;
-err5:
-	for (i = irq_idx - 1; i >=0; i--)
-		free_irq(row_gpios[i], omap_kp);
+
 err4:
 	input_unregister_device(omap_kp->input);
 	input_dev = NULL;
@@ -423,7 +348,6 @@ err3:
 err2:
 	for (i = row_idx - 1; i >=0; i--)
 		gpio_free(row_gpios[i]);
-err1:
 	for (i = col_idx - 1; i >=0; i--)
 		gpio_free(col_gpios[i]);
 
@@ -439,18 +363,8 @@ static int __devexit omap_kp_remove(struct platform_device *pdev)
 
 	/* disable keypad interrupt handling */
 	tasklet_disable(&kp_tasklet);
-	if (cpu_is_omap24xx()) {
-		int i;
-		for (i = 0; i < omap_kp->cols; i++)
-			gpio_free(col_gpios[i]);
-		for (i = 0; i < omap_kp->rows; i++) {
-			gpio_free(row_gpios[i]);
-			free_irq(gpio_to_irq(row_gpios[i]), omap_kp);
-		}
-	} else {
-		omap_writew(1, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
-		free_irq(omap_kp->irq, omap_kp);
-	}
+	omap_writew(1, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
+	free_irq(omap_kp->irq, omap_kp);
 
 	del_timer_sync(&omap_kp->timer);
 	tasklet_kill(&kp_tasklet);
