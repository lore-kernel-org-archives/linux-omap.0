From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/17] Input: omap-keypad: Remove dependencies to mach
 includes
Date: Mon, 10 Sep 2012 22:30:59 -0700
Message-ID: <20120911053059.29637.22108.stgit@muffinssi.local>
References: <20120911052934.29637.9190.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20120911052934.29637.9190.stgit@muffinssi.local>
Sender: linux-input-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

We can't build CONFIG_ARCH_OMAP1 set with ARCH_OMAP2PLUS because
of different compiler flags needed, so we can define omap_kp_24xx()
instead of using cpu_is_omap24xx(). This way we can remove
depency to plat and mach headers which is needed for ARM common
zImage support.

Also remove INT_KEYBOARD by using omap_kp->irq.

Note that this patch depends on an earlier patch
"ARM: OMAP: Move gpio.h to include/linux/platform_data".

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/input/keyboard/omap-keypad.c |   34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index a0222db..171d739 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -35,16 +35,19 @@
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
 
+#ifdef CONFIG_ARCH_OMAP1
+#define omap_kp_24xx()		0
+#else
+#define omap_kp_24xx()		1
+#endif
+
+static struct omap_kp *omap_kp;
 static void omap_kp_tasklet(unsigned long);
 static void omap_kp_timer(unsigned long);
 
@@ -99,7 +102,7 @@ static irqreturn_t omap_kp_interrupt(int irq, void *dev_id)
 	struct omap_kp *omap_kp = dev_id;
 
 	/* disable keyboard interrupt and schedule for handling */
-	if (cpu_is_omap24xx()) {
+	if (omap_kp_24xx()) {
 		int i;
 
 		for (i = 0; i < omap_kp->rows; i++) {
@@ -134,7 +137,7 @@ static void omap_kp_scan_keypad(struct omap_kp *omap_kp, unsigned char *state)
 	int col = 0;
 
 	/* read the keypad status */
-	if (cpu_is_omap24xx()) {
+	if (omap_kp_24xx()) {
 		/* read the keypad status */
 		for (col = 0; col < omap_kp->cols; col++) {
 			set_col_gpio_val(omap_kp, ~(1 << col));
@@ -222,7 +225,7 @@ static void omap_kp_tasklet(unsigned long data)
 		mod_timer(&omap_kp_data->timer, jiffies + delay);
 	} else {
 		/* enable interrupts */
-		if (cpu_is_omap24xx()) {
+		if (omap_kp_24xx()) {
 			int i;
 			for (i = 0; i < omap_kp_data->rows; i++)
 				enable_irq(gpio_to_irq(row_gpios[i]));
@@ -253,9 +256,9 @@ static ssize_t omap_kp_enable_store(struct device *dev, struct device_attribute
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
@@ -286,7 +289,6 @@ static int omap_kp_resume(struct platform_device *dev)
 
 static int __devinit omap_kp_probe(struct platform_device *pdev)
 {
-	struct omap_kp *omap_kp;
 	struct input_dev *input_dev;
 	struct omap_kp_platform_data *pdata =  pdev->dev.platform_data;
 	int i, col_idx, row_idx, irq_idx, ret;
@@ -314,7 +316,7 @@ static int __devinit omap_kp_probe(struct platform_device *pdev)
 	omap_kp->input = input_dev;
 
 	/* Disable the interrupt for the MPUIO keyboard */
-	if (!cpu_is_omap24xx())
+	if (!omap_kp_24xx())
 		omap_writew(1, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
 
 	if (pdata->delay)
@@ -328,7 +330,7 @@ static int __devinit omap_kp_probe(struct platform_device *pdev)
 	omap_kp->rows = pdata->rows;
 	omap_kp->cols = pdata->cols;
 
-	if (cpu_is_omap24xx()) {
+	if (omap_kp_24xx()) {
 		/* Cols: outputs */
 		for (col_idx = 0; col_idx < omap_kp->cols; col_idx++) {
 			if (gpio_request(col_gpios[col_idx], "omap_kp_col") < 0) {
@@ -394,7 +396,7 @@ static int __devinit omap_kp_probe(struct platform_device *pdev)
 
 	/* scan current status and enable interrupt */
 	omap_kp_scan_keypad(omap_kp, keypad_state);
-	if (!cpu_is_omap24xx()) {
+	if (!omap_kp_24xx()) {
 		omap_kp->irq = platform_get_irq(pdev, 0);
 		if (omap_kp->irq >= 0) {
 			if (request_irq(omap_kp->irq, omap_kp_interrupt, 0,
@@ -439,7 +441,7 @@ static int __devexit omap_kp_remove(struct platform_device *pdev)
 
 	/* disable keypad interrupt handling */
 	tasklet_disable(&kp_tasklet);
-	if (cpu_is_omap24xx()) {
+	if (omap_kp_24xx()) {
 		int i;
 		for (i = 0; i < omap_kp->cols; i++)
 			gpio_free(col_gpios[i]);

