From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 09/11] cbus: tahvo: introduce __tahvo_(read/write)_reg
Date: Sat,  9 Jul 2011 01:52:37 +0300
Message-ID: <1310165559-31037-10-git-send-email-balbi@ti.com>
References: <1310165559-31037-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:52260 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752429Ab1GHWxN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 18:53:13 -0400
Received: by mail-bw0-f44.google.com with SMTP id 17so2051598bwb.3
        for <linux-omap@vger.kernel.org>; Fri, 08 Jul 2011 15:53:12 -0700 (PDT)
In-Reply-To: <1310165559-31037-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

those two functions are local to tahvo.c and
should be used to read/write Tahvo's registers.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/tahvo.c |   56 +++++++++++++++++++++++++++++++++++--------------
 1 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index 740bb05..04b8203 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -67,6 +67,27 @@ int tahvo_get_status(void)
 EXPORT_SYMBOL(tahvo_get_status);
 
 /**
+ * __tahvo_read_reg - Reads a value from a register in Tahvo
+ * @tahvo: pointer to tahvo structure
+ * @reg: the register address to read from
+ */
+static int __tahvo_read_reg(struct tahvo *tahvo, unsigned reg)
+{
+	return cbus_read_reg(tahvo->dev, TAHVO_ID, reg);
+}
+
+/**
+ * __tahvo_write_reg - Writes a value to a register in Tahvo
+ * @tahvo: pointer to tahvo structure
+ * @reg: register address to write to
+ * @val: the value to be written to @reg
+ */
+static void __tahvo_write_reg(struct tahvo *tahvo, unsigned reg, u16 val)
+{
+	cbus_write_reg(tahvo->dev, TAHVO_ID, reg, val);
+}
+
+/**
  * tahvo_read_reg - Read a value from a register in Tahvo
  * @reg: the register to read from
  *
@@ -76,7 +97,7 @@ int tahvo_read_reg(unsigned reg)
 {
 	struct tahvo		*tahvo = the_tahvo;
 
-	return cbus_read_reg(tahvo->dev, TAHVO_ID, reg);
+	return __tahvo_read_reg(tahvo, reg);
 }
 EXPORT_SYMBOL(tahvo_read_reg);
 
@@ -91,7 +112,7 @@ void tahvo_write_reg(unsigned reg, u16 val)
 {
 	struct tahvo		*tahvo = the_tahvo;
 
-	cbus_write_reg(tahvo->dev, TAHVO_ID, reg, val);
+	__tahvo_write_reg(tahvo, reg, val);
 }
 EXPORT_SYMBOL(tahvo_write_reg);
 
@@ -108,10 +129,10 @@ void tahvo_set_clear_reg_bits(unsigned reg, u16 set, u16 clear)
 	u16			w;
 
 	mutex_lock(&tahvo->mutex);
-	w = tahvo_read_reg(reg);
+	w = __tahvo_read_reg(tahvo, reg);
 	w &= ~clear;
 	w |= set;
-	tahvo_write_reg(reg, w);
+	__tahvo_write_reg(tahvo, reg, w);
 	mutex_unlock(&tahvo->mutex);
 }
 
@@ -121,9 +142,9 @@ void tahvo_disable_irq(int id)
 	u16			mask;
 
 	mutex_lock(&tahvo->mutex);
-	mask = tahvo_read_reg(TAHVO_REG_IMR);
+	mask = __tahvo_read_reg(tahvo, TAHVO_REG_IMR);
 	mask |= 1 << id;
-	tahvo_write_reg(TAHVO_REG_IMR, mask);
+	__tahvo_write_reg(tahvo, TAHVO_REG_IMR, mask);
 	mutex_unlock(&tahvo->mutex);
 }
 EXPORT_SYMBOL(tahvo_disable_irq);
@@ -134,16 +155,18 @@ void tahvo_enable_irq(int id)
 	u16			mask;
 
 	mutex_lock(&tahvo->mutex);
-	mask = tahvo_read_reg(TAHVO_REG_IMR);
+	mask = __tahvo_read_reg(tahvo, TAHVO_REG_IMR);
 	mask &= ~(1 << id);
-	tahvo_write_reg(TAHVO_REG_IMR, mask);
+	__tahvo_write_reg(tahvo, TAHVO_REG_IMR, mask);
 	mutex_unlock(&tahvo->mutex);
 }
 EXPORT_SYMBOL(tahvo_enable_irq);
 
 void tahvo_ack_irq(int id)
 {
-	tahvo_write_reg(TAHVO_REG_IDR, 1 << id);
+	struct tahvo		*tahvo = the_tahvo;
+
+	__tahvo_write_reg(tahvo, TAHVO_REG_IDR, 1 << id);
 }
 EXPORT_SYMBOL(tahvo_ack_irq);
 
@@ -156,7 +179,7 @@ int tahvo_get_backlight_level(void)
 		mask = 0x7f;
 	else
 		mask = 0x0f;
-	return tahvo_read_reg(TAHVO_REG_LEDPWMR) & mask;
+	return __tahvo_read_reg(tahvo, TAHVO_REG_LEDPWMR) & mask;
 }
 EXPORT_SYMBOL(tahvo_get_backlight_level);
 
@@ -173,12 +196,13 @@ EXPORT_SYMBOL(tahvo_get_max_backlight_level);
 
 void tahvo_set_backlight_level(int level)
 {
+	struct tahvo		*tahvo = the_tahvo;
 	int			max_level;
 
 	max_level = tahvo_get_max_backlight_level();
 	if (level > max_level)
 		level = max_level;
-	tahvo_write_reg(TAHVO_REG_LEDPWMR, level);
+	__tahvo_write_reg(tahvo, TAHVO_REG_LEDPWMR, level);
 }
 EXPORT_SYMBOL(tahvo_set_backlight_level);
 
@@ -192,8 +216,8 @@ static irqreturn_t tahvo_irq_handler(int irq, void *_tahvo)
 	int			i;
 
 	for (;;) {
-		id = tahvo_read_reg(TAHVO_REG_IDR);
-		im = ~tahvo_read_reg(TAHVO_REG_IMR);
+		id = __tahvo_read_reg(tahvo, TAHVO_REG_IDR);
+		im = ~__tahvo_read_reg(tahvo, TAHVO_REG_IMR);
 		id &= im;
 
 		if (!id)
@@ -299,7 +323,7 @@ static int __devinit tahvo_probe(struct platform_device *pdev)
 	mutex_init(&tahvo->mutex);
 	tahvo->dev = &pdev->dev;
 
-	rev = tahvo_read_reg(TAHVO_REG_ASICR);
+	rev = __tahvo_read_reg(tahvo, TAHVO_REG_ASICR);
 
 	id = (rev >> 8) & 0xff;
 
@@ -325,7 +349,7 @@ static int __devinit tahvo_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 
 	/* Mask all TAHVO interrupts */
-	tahvo_write_reg(TAHVO_REG_IMR, 0xffff);
+	__tahvo_write_reg(tahvo, TAHVO_REG_IMR, 0xffff);
 
 	ret = request_threaded_irq(irq, NULL, tahvo_irq_handler,
 			IRQF_TRIGGER_RISING | IRQF_ONESHOT,
@@ -352,7 +376,7 @@ static int __devexit tahvo_remove(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 
 	/* Mask all TAHVO interrupts */
-	tahvo_write_reg(TAHVO_REG_IMR, 0xffff);
+	__tahvo_write_reg(tahvo, TAHVO_REG_IMR, 0xffff);
 	free_irq(irq, 0);
 	kfree(tahvo);
 	the_tahvo = NULL;
-- 
1.7.6

