From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v8 3/3] OMAP4:keypad: PM runtime
Date: Tue, 22 Feb 2011 22:29:00 -0800
Message-ID: <20110223062900.GB19269@core.coreip.homeip.net>
References: <1293429106-16543-1-git-send-email-shubhrajyoti@ti.com>
 <1293429106-16543-2-git-send-email-shubhrajyoti@ti.com>
 <1293429106-16543-3-git-send-email-shubhrajyoti@ti.com>
 <1293429106-16543-4-git-send-email-shubhrajyoti@ti.com>
 <4D50FF42.1070401@ti.com>
 <4D5F33E3.7000501@ti.com>
 <20110219053111.GA6991@core.coreip.homeip.net>
 <AANLkTikCmiSrOZb3WvMZHcxRsSRxd1zUsWE59aexHdeF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikCmiSrOZb3WvMZHcxRsSRxd1zUsWE59aexHdeF@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
To: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Cc: linux-input@vger.kernel.org, Abraham Arce <x0066660@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, Feb 19, 2011 at 01:44:32PM +0530, Datta, Shubhrajyoti wrote:
> On Sat, Feb 19, 2011 at 11:01 AM, Dmitry Torokhov <dmitry.torokhov@gmail.com
> > wrote:
> 
> > Hi Shubhrajyoti,
> >
> > On Sat, Feb 19, 2011 at 08:37:15AM +0530, Shubhrajyoti wrote:
> > > Hello Dmitry,
> > > If there are no further comments.
> > > Can it be queued?
> >
> > I normally try not to merge board code leaving it to arch owner. Can we
> > at least get arch/board maintainer ACKs on this?
> >
> > Also, I am wondering, what is the utility of this patch? Without it,
> > as far as I understand, runtime PM is disabled for the device. With the
> > patch we enable runtime PM but immediately bump up usage count, thus
> > ensuring that the device is always powered on. So what changed? Or am I
> > missing something?
> >
> 
> After the hwmod changes the clocks are cut. So if it is not enabled then the
> device is not usable.
> 

OK, that makes sense. So since we are wiring up runtime PM I think we
should go a strep further and do it in open/close methods. Does the
patch below still work for you?

Thanks.

-- 
Dmitry

Input: omap4-keypad - wire up runtime PM handling

From: Abraham Arce <x0066660@ti.com>

Enable Runtime PM functionality in OMAP4 driver based on the following
assumptions:

- keyboard controller in wakeup domain so it is always on and power
  impact is minimal;
- in OMAP4 the device control is at module/device level and ick/fclk
  level control is difficult so cutting of clocks will prevent
  interrupts.

Signed-off-by: Abraham Arce <x0066660@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/omap4-keypad.c |   74 +++++++++++++++++++++++++--------
 1 files changed, 55 insertions(+), 19 deletions(-)


diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index 45bd097..c51a3c4 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -29,6 +29,7 @@
 #include <linux/io.h>
 #include <linux/input.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 
 #include <plat/omap4-keypad.h>
 
@@ -80,20 +81,6 @@ struct omap4_keypad {
 	unsigned short keymap[];
 };
 
-static void __devinit omap4_keypad_config(struct omap4_keypad *keypad_data)
-{
-	__raw_writel(OMAP4_VAL_FUNCTIONALCFG,
-			keypad_data->base + OMAP4_KBD_CTRL);
-	__raw_writel(OMAP4_VAL_DEBOUNCINGTIME,
-			keypad_data->base + OMAP4_KBD_DEBOUNCINGTIME);
-	__raw_writel(OMAP4_VAL_IRQDISABLE,
-			keypad_data->base + OMAP4_KBD_IRQSTATUS);
-	__raw_writel(OMAP4_DEF_IRQENABLE_EVENTEN | OMAP4_DEF_IRQENABLE_LONGKEY,
-			keypad_data->base + OMAP4_KBD_IRQENABLE);
-	__raw_writel(OMAP4_DEF_WUP_EVENT_ENA | OMAP4_DEF_WUP_LONG_KEY_ENA,
-			keypad_data->base + OMAP4_KBD_WAKEUPENABLE);
-}
-
 /* Interrupt handler */
 static irqreturn_t omap4_keypad_interrupt(int irq, void *dev_id)
 {
@@ -144,6 +131,49 @@ static irqreturn_t omap4_keypad_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int omap4_keypad_open(struct input_dev *input)
+{
+	struct omap4_keypad *keypad_data = input_get_drvdata(input);
+
+	pm_runtime_get_sync(input->dev.parent);
+
+	disable_irq(keypad_data->irq);
+
+	__raw_writel(OMAP4_VAL_FUNCTIONALCFG,
+			keypad_data->base + OMAP4_KBD_CTRL);
+	__raw_writel(OMAP4_VAL_DEBOUNCINGTIME,
+			keypad_data->base + OMAP4_KBD_DEBOUNCINGTIME);
+	__raw_writel(OMAP4_VAL_IRQDISABLE,
+			keypad_data->base + OMAP4_KBD_IRQSTATUS);
+	__raw_writel(OMAP4_DEF_IRQENABLE_EVENTEN | OMAP4_DEF_IRQENABLE_LONGKEY,
+			keypad_data->base + OMAP4_KBD_IRQENABLE);
+	__raw_writel(OMAP4_DEF_WUP_EVENT_ENA | OMAP4_DEF_WUP_LONG_KEY_ENA,
+			keypad_data->base + OMAP4_KBD_WAKEUPENABLE);
+
+	enable_irq(keypad_data->irq);
+
+	return 0;
+}
+
+static void omap4_keypad_close(struct input_dev *input)
+{
+	struct omap4_keypad *keypad_data = input_get_drvdata(input);
+
+	disable_irq(keypad_data->irq);
+
+	/* Disable interrupts */
+	__raw_writel(OMAP4_VAL_IRQDISABLE,
+		     keypad_data->base + OMAP4_KBD_IRQENABLE);
+
+	/* clear pending interrupts */
+	__raw_writel(__raw_readl(keypad_data->base + OMAP4_KBD_IRQSTATUS),
+			keypad_data->base + OMAP4_KBD_IRQSTATUS);
+
+	enable_irq(keypad_data->irq);
+
+	pm_runtime_put_sync(input->dev.parent);
+}
+
 static int __devinit omap4_keypad_probe(struct platform_device *pdev)
 {
 	const struct omap4_keypad_platform_data *pdata;
@@ -225,6 +255,9 @@ static int __devinit omap4_keypad_probe(struct platform_device *pdev)
 	input_dev->id.product = 0x0001;
 	input_dev->id.version = 0x0001;
 
+	input_dev->open = omap4_keypad_open;
+	input_dev->close = omap4_keypad_close;
+
 	input_dev->keycode	= keypad_data->keymap;
 	input_dev->keycodesize	= sizeof(keypad_data->keymap[0]);
 	input_dev->keycodemax	= max_keys;
@@ -239,8 +272,6 @@ static int __devinit omap4_keypad_probe(struct platform_device *pdev)
 	matrix_keypad_build_keymap(pdata->keymap_data, row_shift,
 			input_dev->keycode, input_dev->keybit);
 
-	omap4_keypad_config(keypad_data);
-
 	error = request_irq(keypad_data->irq, omap4_keypad_interrupt,
 			     IRQF_TRIGGER_RISING,
 			     "omap4-keypad", keypad_data);
@@ -249,17 +280,19 @@ static int __devinit omap4_keypad_probe(struct platform_device *pdev)
 		goto err_free_input;
 	}
 
+	pm_runtime_enable(&pdev->dev);
+
 	error = input_register_device(keypad_data->input);
 	if (error < 0) {
 		dev_err(&pdev->dev, "failed to register input device\n");
-		goto err_free_irq;
+		goto err_pm_disable;
 	}
 
-
 	platform_set_drvdata(pdev, keypad_data);
 	return 0;
 
-err_free_irq:
+err_pm_disable:
+	pm_runtime_disable(&pdev->dev);
 	free_irq(keypad_data->irq, keypad_data);
 err_free_input:
 	input_free_device(input_dev);
@@ -278,6 +311,9 @@ static int __devexit omap4_keypad_remove(struct platform_device *pdev)
 	struct resource *res;
 
 	free_irq(keypad_data->irq, keypad_data);
+
+	pm_runtime_disable(&pdev->dev);
+
 	input_unregister_device(keypad_data->input);
 
 	iounmap(keypad_data->base);
