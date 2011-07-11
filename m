From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 07/22] cbus: tahvo: git it a context structure
Date: Mon, 11 Jul 2011 14:17:20 +0300
Message-ID: <1310383055-20211-8-git-send-email-balbi@ti.com>
References: <1310383055-20211-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:59238 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754517Ab1GKLSU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 07:18:20 -0400
Received: by mail-yw0-f51.google.com with SMTP id 8so1762797ywa.24
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 04:18:19 -0700 (PDT)
In-Reply-To: <1310383055-20211-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, =?UTF-8?q?Michael=20B=C3=BCsch?= <mb@bu3sch.de>, Felipe Balbi <balbi@ti.com>

just moving things around. It's a lot easier
to handle a dynamically allocated structure
as it allows for multiple instances of the
same device.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/tahvo.c |  128 ++++++++++++++++++++++++++++++++------------------
 1 files changed, 82 insertions(+), 46 deletions(-)

diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index 4b062de..3a77d12 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 
+#include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/device.h>
@@ -40,12 +41,16 @@
 #define TAHVO_ID		0x02
 #define PFX			"tahvo: "
 
-static int tahvo_initialized;
-static int tahvo_is_betty;
+struct tahvo {
+	/* device lock */
+	struct mutex	mutex;
+	struct device	*dev;
 
-static struct mutex tahvo_lock;
+	unsigned int	is_betty;
+	unsigned int	wide_backlight;
+};
 
-static struct device *the_dev;
+static struct tahvo *the_tahvo;
 
 struct tahvo_irq_handler_desc {
 	int (*func)(unsigned long);
@@ -57,7 +62,7 @@ static struct tahvo_irq_handler_desc tahvo_irq_handlers[MAX_TAHVO_IRQ_HANDLERS];
 
 int tahvo_get_status(void)
 {
-	return tahvo_initialized;
+	return the_tahvo != NULL;
 }
 EXPORT_SYMBOL(tahvo_get_status);
 
@@ -69,8 +74,9 @@ EXPORT_SYMBOL(tahvo_get_status);
  */
 int tahvo_read_reg(unsigned reg)
 {
-	BUG_ON(!tahvo_initialized);
-	return cbus_read_reg(the_dev, TAHVO_ID, reg);
+	struct tahvo		*tahvo = the_tahvo;
+
+	return cbus_read_reg(tahvo->dev, TAHVO_ID, reg);
 }
 EXPORT_SYMBOL(tahvo_read_reg);
 
@@ -83,8 +89,9 @@ EXPORT_SYMBOL(tahvo_read_reg);
  */
 void tahvo_write_reg(unsigned reg, u16 val)
 {
-	BUG_ON(!tahvo_initialized);
-	cbus_write_reg(the_dev, TAHVO_ID, reg, val);
+	struct tahvo		*tahvo = the_tahvo;
+
+	cbus_write_reg(tahvo->dev, TAHVO_ID, reg, val);
 }
 EXPORT_SYMBOL(tahvo_write_reg);
 
@@ -97,37 +104,40 @@ EXPORT_SYMBOL(tahvo_write_reg);
  */
 void tahvo_set_clear_reg_bits(unsigned reg, u16 set, u16 clear)
 {
-	u16 w;
+	struct tahvo		*tahvo = the_tahvo;
+	u16			w;
 
-	mutex_lock(&tahvo_lock);
+	mutex_lock(&tahvo->mutex);
 	w = tahvo_read_reg(reg);
 	w &= ~clear;
 	w |= set;
 	tahvo_write_reg(reg, w);
-	mutex_unlock(&tahvo_lock);
+	mutex_unlock(&tahvo->mutex);
 }
 
 void tahvo_disable_irq(int id)
 {
-	u16 mask;
+	struct tahvo		*tahvo = the_tahvo;
+	u16			mask;
 
-	mutex_lock(&tahvo_lock);
+	mutex_lock(&tahvo->mutex);
 	mask = tahvo_read_reg(TAHVO_REG_IMR);
 	mask |= 1 << id;
 	tahvo_write_reg(TAHVO_REG_IMR, mask);
-	mutex_unlock(&tahvo_lock);
+	mutex_unlock(&tahvo->mutex);
 }
 EXPORT_SYMBOL(tahvo_disable_irq);
 
 void tahvo_enable_irq(int id)
 {
-	u16 mask;
+	struct tahvo		*tahvo = the_tahvo;
+	u16			mask;
 
-	mutex_lock(&tahvo_lock);
+	mutex_lock(&tahvo->mutex);
 	mask = tahvo_read_reg(TAHVO_REG_IMR);
 	mask &= ~(1 << id);
 	tahvo_write_reg(TAHVO_REG_IMR, mask);
-	mutex_unlock(&tahvo_lock);
+	mutex_unlock(&tahvo->mutex);
 }
 EXPORT_SYMBOL(tahvo_enable_irq);
 
@@ -137,13 +147,12 @@ void tahvo_ack_irq(int id)
 }
 EXPORT_SYMBOL(tahvo_ack_irq);
 
-static int tahvo_7bit_backlight;
-
 int tahvo_get_backlight_level(void)
 {
-	int mask;
+	struct tahvo		*tahvo = the_tahvo;
+	int			mask;
 
-	if (tahvo_7bit_backlight)
+	if (tahvo->wide_backlight)
 		mask = 0x7f;
 	else
 		mask = 0x0f;
@@ -153,7 +162,9 @@ EXPORT_SYMBOL(tahvo_get_backlight_level);
 
 int tahvo_get_max_backlight_level(void)
 {
-	if (tahvo_7bit_backlight)
+	struct tahvo		*tahvo = the_tahvo;
+
+	if (tahvo->wide_backlight)
 		return 0x7f;
 	else
 		return 0x0f;
@@ -162,7 +173,7 @@ EXPORT_SYMBOL(tahvo_get_max_backlight_level);
 
 void tahvo_set_backlight_level(int level)
 {
-	int max_level;
+	int			max_level;
 
 	max_level = tahvo_get_max_backlight_level();
 	if (level > max_level)
@@ -174,9 +185,11 @@ EXPORT_SYMBOL(tahvo_set_backlight_level);
 static irqreturn_t tahvo_irq_handler(int irq, void *dev_id)
 {
 	struct tahvo_irq_handler_desc *hnd;
-	u16 id;
-	u16 im;
-	int i;
+
+	struct tahvo		*tahvo = the_tahvo;
+	u16			id;
+	u16			im;
+	int			i;
 
 	for (;;) {
 		id = tahvo_read_reg(TAHVO_REG_IDR);
@@ -192,7 +205,7 @@ static irqreturn_t tahvo_irq_handler(int irq, void *dev_id)
 			hnd = &tahvo_irq_handlers[i];
 			if (hnd->func == NULL) {
 				/* Spurious tahvo interrupt - just ack it */
-				printk(KERN_INFO "Spurious Tahvo interrupt "
+				dev_err(tahvo->dev, "Spurious interrupt "
 						 "(id %d)\n", i);
 				tahvo_disable_irq(i);
 				tahvo_ack_irq(i);
@@ -215,19 +228,20 @@ static irqreturn_t tahvo_irq_handler(int irq, void *dev_id)
 int tahvo_request_irq(int id, void *irq_handler, unsigned long arg, char *name)
 {
 	struct tahvo_irq_handler_desc *hnd;
+	struct tahvo		*tahvo = the_tahvo;
 
 	if (irq_handler == NULL || id >= MAX_TAHVO_IRQ_HANDLERS ||
 	    name == NULL) {
-		printk(KERN_ERR PFX "Invalid arguments to %s\n",
+		dev_err(tahvo->dev, "Invalid arguments to %s\n",
 		       __FUNCTION__);
 		return -EINVAL;
 	}
 	hnd = &tahvo_irq_handlers[id];
 	if (hnd->func != NULL) {
-		printk(KERN_ERR PFX "IRQ %d already reserved\n", id);
+		dev_err(tahvo->dev, "IRQ %d already reserved\n", id);
 		return -EBUSY;
 	}
-	printk(KERN_INFO PFX "Registering interrupt %d for device %s\n",
+	dev_dbg(tahvo->dev, "Registering interrupt %d for device %s\n",
 	       id, name);
 	hnd->func = irq_handler;
 	hnd->arg = arg;
@@ -246,15 +260,16 @@ EXPORT_SYMBOL(tahvo_request_irq);
 void tahvo_free_irq(int id)
 {
 	struct tahvo_irq_handler_desc *hnd;
+	struct tahvo		*tahvo = the_tahvo;
 
 	if (id >= MAX_TAHVO_IRQ_HANDLERS) {
-		printk(KERN_ERR PFX "Invalid argument to %s\n",
+		dev_err(tahvo->dev, "Invalid argument to %s\n",
 		       __FUNCTION__);
 		return;
 	}
 	hnd = &tahvo_irq_handlers[id];
 	if (hnd->func == NULL) {
-		printk(KERN_ERR PFX "IRQ %d already freed\n", id);
+		dev_err(tahvo->dev, "IRQ %d already freed\n", id);
 		return;
 	}
 
@@ -265,13 +280,24 @@ EXPORT_SYMBOL(tahvo_free_irq);
 
 static int __devinit tahvo_probe(struct platform_device *pdev)
 {
-	int rev, id, ret;
-	int irq;
+	struct tahvo		*tahvo;
+	int			rev;
+	int			ret;
+	int			irq;
+	int			id;
+
+	tahvo = kzalloc(sizeof(*tahvo), GFP_KERNEL);
+	if (!tahvo) {
+		dev_err(&pdev->dev, "not enough memory\n");
+		ret = -ENOMEM;
+		goto err0;
+	}
 
-	mutex_init(&tahvo_lock);
-	the_dev = &pdev->dev;
+	the_tahvo = tahvo;
+	platform_set_drvdata(pdev, tahvo);
 
-	tahvo_initialized = 1;
+	mutex_init(&tahvo->mutex);
+	tahvo->dev = &pdev->dev;
 
 	rev = tahvo_read_reg(TAHVO_REG_ASICR);
 
@@ -280,19 +306,20 @@ static int __devinit tahvo_probe(struct platform_device *pdev)
 	switch (id) {
 	case 0x03:
 		if ((rev & 0xff) >= 0x50)
-			tahvo_7bit_backlight = 1;
+			tahvo->wide_backlight = true;
 		break;
 	case 0x0b:
-		tahvo_is_betty = 1;
-		tahvo_7bit_backlight = 1;
+		tahvo->is_betty = true;
+		tahvo->wide_backlight = true;
 		break;
 	default:
 		dev_err(&pdev->dev, "Tahvo/Betty chip not found");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err1;
 	}
 
 	dev_err(&pdev->dev, "%s v%d.%d found\n",
-			tahvo_is_betty ? "Betty" : "Tahvo",
+			tahvo->is_betty ? "Betty" : "Tahvo",
 			(rev >> 4) & 0x0f, rev & 0x0f);
 
 	irq = platform_get_irq(pdev, 0);
@@ -305,21 +332,30 @@ static int __devinit tahvo_probe(struct platform_device *pdev)
 			"tahvo", 0);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Unable to register IRQ handler\n");
-		return ret;
+		goto err1;
 	}
+
 	return 0;
+
+err1:
+	kfree(tahvo);
+
+err0:
+	return ret;
 }
 
 static int __devexit tahvo_remove(struct platform_device *pdev)
 {
-	int irq;
+	struct tahvo		*tahvo = platform_get_drvdata(pdev);
+	int			irq;
 
 	irq = platform_get_irq(pdev, 0);
 
 	/* Mask all TAHVO interrupts */
 	tahvo_write_reg(TAHVO_REG_IMR, 0xffff);
 	free_irq(irq, 0);
-	the_dev = NULL;
+	kfree(tahvo);
+	the_tahvo = NULL;
 
 	return 0;
 }
-- 
1.7.6

