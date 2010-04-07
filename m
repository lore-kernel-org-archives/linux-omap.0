From: felipe.balbi@nokia.com
Subject: [RFC PATCH 26/37] cbus: retu-pwrbutton: convert to platform_driver
Date: Wed,  7 Apr 2010 19:04:17 +0300
Message-ID: <1270656268-7034-27-git-send-email-felipe.balbi@nokia.com>
References: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58497 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932851Ab0DGQFX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:05:23 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o37G58es004996
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 19:05:20 +0300
In-Reply-To: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

=46rom: Felipe Balbi <felipe.balbi@nokia.com>

now that we allocate the platform_devices in retu.c
we can convert this driver to platform_driver.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/retu-pwrbutton.c |  126 +++++++++++++++++++++++++++++++--=
--------
 1 files changed, 95 insertions(+), 31 deletions(-)

diff --git a/drivers/cbus/retu-pwrbutton.c b/drivers/cbus/retu-pwrbutto=
n.c
index 38d7aa4..2d8cf40 100644
--- a/drivers/cbus/retu-pwrbutton.c
+++ b/drivers/cbus/retu-pwrbutton.c
@@ -3,11 +3,13 @@
  *
  * Driver for sending retu power button event to input-layer
  *
- * Copyright (C) 2004 Nokia Corporation
+ * Copyright (C) 2004-2010 Nokia Corporation
  *
- * Written by Ari Saastamoinen <ari.saastamoinen@elektrobit.com>
+ * Written by
+ *	Ari Saastamoinen <ari.saastamoinen@elektrobit.com>
+ *	Juha Yrjola <juha.yrjola@solidboot.com>
  *
- * Contact Juha Yrj=F6l=E4 <juha.yrjola@nokia.com>
+ * Contact: Felipe Balbi <felipe.balbi@nokia.com>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License. See the file "COPYING" in the main directory of thi=
s
@@ -31,6 +33,7 @@
 #include <linux/timer.h>
 #include <linux/jiffies.h>
 #include <linux/bitops.h>
+#include <linux/platform_device.h>
=20
 #include "retu.h"
=20
@@ -40,12 +43,17 @@
 #define PWRBTN_UP		0
 #define PWRBTN_PRESSED		1
=20
-static int pwrbtn_state;
-static struct input_dev *pwrbtn_dev;
-static struct timer_list pwrbtn_timer;
+struct retu_pwrbutton {
+	struct input_dev	*idev;
+	struct timer_list	timer;
+
+	int			state;
+	int			irq;
+};
=20
 static void retubutton_timer_func(unsigned long arg)
 {
+	struct retu_pwrbutton *pwr =3D (struct retu_pwrbutton *) arg;
 	int state;
=20
 	if (retu_read_reg(RETU_REG_STATUS) & RETU_STATUS_PWRONX)
@@ -53,9 +61,10 @@ static void retubutton_timer_func(unsigned long arg)
 	else
 		state =3D PWRBTN_PRESSED;
=20
-	if (pwrbtn_state !=3D state) {
-		input_report_key(pwrbtn_dev, KEY_POWER, state);
-		pwrbtn_state =3D state;
+	if (pwr->state !=3D state) {
+		input_report_key(pwr->idev, KEY_POWER, state);
+		input_sync(pwr->idev);
+		pwr->state =3D state;
 	}
 }
=20
@@ -65,54 +74,109 @@ static void retubutton_timer_func(unsigned long ar=
g)
  */
 static void retubutton_irq(unsigned long arg)
 {
+	struct retu_pwrbutton *pwr =3D (struct retu_pwrbutton *) arg;
+
 	retu_ack_irq(RETU_INT_PWR);
-	mod_timer(&pwrbtn_timer, jiffies + msecs_to_jiffies(PWRBTN_DELAY));
+	mod_timer(&pwr->timer, jiffies + msecs_to_jiffies(PWRBTN_DELAY));
 }
=20
 /**
  * Init function.
  * Allocates interrupt for power button and registers itself to input =
layer.
  */
-static int __init retubutton_init(void)
+static int __devinit retubutton_probe(struct platform_device *pdev)
 {
-	int irq;
+	struct retu_pwrbutton		*pwr;
+	int				ret =3D 0;
+
+	pwr =3D kzalloc(sizeof(*pwr), GFP_KERNEL);
+	if (!pwr) {
+		dev_err(&pdev->dev, "not enough memory\n");
+		ret =3D -ENOMEM;
+		goto err0;
+	}
=20
-	printk(KERN_INFO "Retu power button driver initialized\n");
-	irq =3D RETU_INT_PWR;
+	pwr->irq =3D RETU_INT_PWR;
+	platform_set_drvdata(pdev, pwr);
+	setup_timer(&pwr->timer, retubutton_timer_func, (unsigned long) pwr);
=20
-	init_timer(&pwrbtn_timer);
-	pwrbtn_timer.function =3D retubutton_timer_func;
+	ret =3D retu_request_irq(pwr->irq, retubutton_irq, (unsigned long) pw=
r,
+			"PwrOnX");
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Cannot allocate irq\n");
+		goto err1;
+	}
=20
-	if (retu_request_irq(irq, &retubutton_irq, 0, "PwrOnX") < 0) {
-		printk(KERN_ERR "%s@%s: Cannot allocate irq\n",
-		       __FUNCTION__, __FILE__);
-		return -EBUSY;
+	pwr->idev =3D input_allocate_device();
+	if (!pwr->idev) {
+		dev_err(&pdev->dev, "can't allocate input device\n");
+		ret =3D -ENOMEM;
+		goto err2;
 	}
=20
-	pwrbtn_dev =3D input_allocate_device();
-	if (!pwrbtn_dev)
-		return -ENOMEM;
+	pwr->idev->evbit[0] =3D BIT_MASK(EV_KEY);
+	pwr->idev->keybit[BIT_WORD(KEY_POWER)] =3D BIT_MASK(KEY_POWER);
+	pwr->idev->name =3D "retu-pwrbutton";
=20
-	pwrbtn_dev->evbit[0] =3D BIT_MASK(EV_KEY);
-	pwrbtn_dev->keybit[BIT_WORD(KEY_POWER)] =3D BIT_MASK(KEY_POWER);
-	pwrbtn_dev->name =3D "retu-pwrbutton";
+	ret =3D input_register_device(pwr->idev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to register input device\n");
+		goto err3;
+	}
=20
-	return input_register_device(pwrbtn_dev);
+	return 0;
+
+err3:
+	input_free_device(pwr->idev);
+
+err2:
+	retu_free_irq(pwr->irq);
+
+err1:
+	kfree(pwr);
+
+err0:
+	return ret;
 }
=20
 /**
  * Cleanup function which is called when driver is unloaded
  */
-static void __exit retubutton_exit(void)
+static int __devexit retubutton_remove(struct platform_device *pdev)
 {
-	retu_free_irq(RETU_INT_PWR);
-	del_timer_sync(&pwrbtn_timer);
-	input_unregister_device(pwrbtn_dev);
+	struct retu_pwrbutton		*pwr =3D platform_get_drvdata(pdev);
+
+	retu_free_irq(pwr->irq);
+	del_timer_sync(&pwr->timer);
+	input_unregister_device(pwr->idev);
+	input_free_device(pwr->idev);
+	kfree(pwr);
+
+	return 0;
 }
=20
+static struct platform_driver retu_pwrbutton_driver =3D {
+	.probe		=3D retubutton_probe,
+	.remove		=3D __devexit_p(retubutton_remove),
+	.driver		=3D {
+		.name	=3D "retu-pwrbutton",
+	},
+};
+
+static int __init retubutton_init(void)
+{
+	return platform_driver_register(&retu_pwrbutton_driver);
+}
 module_init(retubutton_init);
+
+static void __exit retubutton_exit(void)
+{
+	platform_driver_unregister(&retu_pwrbutton_driver);
+}
 module_exit(retubutton_exit);
=20
 MODULE_DESCRIPTION("Retu Power Button");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Ari Saastamoinen");
+MODULE_AUTHOR("Felipe Balbi <felipe.balbi@nokia.com>");
+
--=20
1.7.0.rc0.33.g7c3932

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
