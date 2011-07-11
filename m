From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 20/22] cbus: tahvo: pass child device pointer
Date: Mon, 11 Jul 2011 14:17:33 +0300
Message-ID: <1310383055-20211-21-git-send-email-balbi@ti.com>
References: <1310383055-20211-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:41524 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754477Ab1GKLT0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 07:19:26 -0400
Received: by gwb15 with SMTP id 15so1802761gwb.13
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 04:19:25 -0700 (PDT)
In-Reply-To: <1310383055-20211-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, =?UTF-8?q?Michael=20B=C3=BCsch?= <mb@bu3sch.de>, Felipe Balbi <balbi@ti.com>

on read/write register operations, if we pass
the child device pointer, it becomes really easy
to access our device structure. Let's do so.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/tahvo-usb.c |   18 ++++++++++--------
 drivers/cbus/tahvo.c     |   18 +++++++++++-------
 drivers/cbus/tahvo.h     |    7 ++++---
 3 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/cbus/tahvo-usb.c b/drivers/cbus/tahvo-usb.c
index 04fe770..41e39ca 100644
--- a/drivers/cbus/tahvo-usb.c
+++ b/drivers/cbus/tahvo-usb.c
@@ -90,6 +90,7 @@
 #endif
 
 struct tahvo_usb {
+	struct device		*dev;
 	struct platform_device *pt_dev;
 	struct otg_transceiver otg;
 	int vbus_state;
@@ -240,7 +241,7 @@ static void check_vbus_state(struct tahvo_usb *tu)
 {
 	int reg, prev_state;
 
-	reg = tahvo_read_reg(TAHVO_REG_IDSR);
+	reg = tahvo_read_reg(tu->dev, TAHVO_REG_IDSR);
 	if (reg & 0x01) {
 		u32 l;
 
@@ -304,7 +305,7 @@ static void tahvo_usb_become_host(struct tahvo_usb *tu)
 	omap_writel(l, OTG_CTRL);
 
 	/* Power up the transceiver in USB host mode */
-	tahvo_write_reg(TAHVO_REG_USBR, USBR_REGOUT | USBR_NSUSPEND |
+	tahvo_write_reg(tu->dev, TAHVO_REG_USBR, USBR_REGOUT | USBR_NSUSPEND |
 			USBR_MASTER_SW2 | USBR_MASTER_SW1);
 	tu->otg.state = OTG_STATE_A_IDLE;
 
@@ -330,7 +331,7 @@ static void tahvo_usb_become_peripheral(struct tahvo_usb *tu)
 	omap_writel(l, OTG_CTRL);
 
 	/* Power up transceiver and set it in USB perhiperal mode */
-	tahvo_write_reg(TAHVO_REG_USBR, USBR_SLAVE_CONTROL | USBR_REGOUT | USBR_NSUSPEND | USBR_SLAVE_SW);
+	tahvo_write_reg(tu->dev, TAHVO_REG_USBR, USBR_SLAVE_CONTROL | USBR_REGOUT | USBR_NSUSPEND | USBR_SLAVE_SW);
 	tu->otg.state = OTG_STATE_B_IDLE;
 
 	check_vbus_state(tu);
@@ -380,7 +381,7 @@ static void tahvo_usb_power_off(struct tahvo_usb *tu)
 	omap_writel(l, OTG_SYSCON_1);
 
 	/* Power off transceiver */
-	tahvo_write_reg(TAHVO_REG_USBR, 0);
+	tahvo_write_reg(tu->dev, TAHVO_REG_USBR, 0);
 	tu->otg.state = OTG_STATE_UNDEFINED;
 }
 
@@ -404,12 +405,12 @@ static int tahvo_usb_set_suspend(struct otg_transceiver *dev, int suspend)
 
 	dev_dbg(&tu->pt_dev->dev, "set_suspend\n");
 
-	w = tahvo_read_reg(TAHVO_REG_USBR);
+	w = tahvo_read_reg(tu->dev, TAHVO_REG_USBR);
 	if (suspend)
 		w &= ~USBR_NSUSPEND;
 	else
 		w |= USBR_NSUSPEND;
-	tahvo_write_reg(TAHVO_REG_USBR, w);
+	tahvo_write_reg(tu->dev, TAHVO_REG_USBR, w);
 
 	return 0;
 }
@@ -602,7 +603,8 @@ static int __init tahvo_usb_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	tahvo_usb_device = tu;
 
-	tu->pt_dev = container_of(dev, struct platform_device, dev);
+	tu->dev = dev;
+	tu->pt_dev = pdev;
 #ifdef CONFIG_USB_OTG
 	/* Default mode */
 #ifdef CONFIG_CBUS_TAHVO_USB_HOST_BY_DEFAULT
@@ -624,7 +626,7 @@ static int __init tahvo_usb_probe(struct platform_device *pdev)
 
 	/* Set initial state, so that we generate kevents only on
 	 * state changes */
-	tu->vbus_state = tahvo_read_reg(TAHVO_REG_IDSR) & 0x01;
+	tu->vbus_state = tahvo_read_reg(tu->dev, TAHVO_REG_IDSR) & 0x01;
 
 	irq = platform_get_irq(pdev, 0);
 	tu->irq = irq;
diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index 8192a24..12d95ac 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -82,13 +82,14 @@ static void __tahvo_write_reg(struct tahvo *tahvo, unsigned reg, u16 val)
 
 /**
  * tahvo_read_reg - Read a value from a register in Tahvo
+ * @child: device pointer from the calling child
  * @reg: the register to read from
  *
  * This function returns the contents of the specified register
  */
-int tahvo_read_reg(unsigned reg)
+int tahvo_read_reg(struct device *child, unsigned reg)
 {
-	struct tahvo		*tahvo = the_tahvo;
+	struct tahvo		*tahvo = dev_get_drvdata(child->parent);
 
 	return __tahvo_read_reg(tahvo, reg);
 }
@@ -96,14 +97,15 @@ EXPORT_SYMBOL(tahvo_read_reg);
 
 /**
  * tahvo_write_reg - Write a value to a register in Tahvo
+ * @child: device pointer from the calling child
  * @reg: the register to write to
- * @reg: the value to write to the register
+ * @val : the value to write to the register
  *
  * This function writes a value to the specified register
  */
-void tahvo_write_reg(unsigned reg, u16 val)
+void tahvo_write_reg(struct device *child, unsigned reg, u16 val)
 {
-	struct tahvo		*tahvo = the_tahvo;
+	struct tahvo		*tahvo = dev_get_drvdata(child->parent);
 
 	__tahvo_write_reg(tahvo, reg, val);
 }
@@ -111,14 +113,16 @@ EXPORT_SYMBOL(tahvo_write_reg);
 
 /**
  * tahvo_set_clear_reg_bits - set and clear register bits atomically
+ * @child: device pointer from the calling child
  * @reg: the register to write to
  * @bits: the bits to set
  *
  * This function sets and clears the specified Tahvo register bits atomically
  */
-void tahvo_set_clear_reg_bits(unsigned reg, u16 set, u16 clear)
+void tahvo_set_clear_reg_bits(struct device *child, unsigned reg, u16 set,
+		u16 clear)
 {
-	struct tahvo		*tahvo = the_tahvo;
+	struct tahvo		*tahvo = dev_get_drvdata(child->parent);
 	u16			w;
 
 	mutex_lock(&tahvo->mutex);
diff --git a/drivers/cbus/tahvo.h b/drivers/cbus/tahvo.h
index 3c0b381..1281710 100644
--- a/drivers/cbus/tahvo.h
+++ b/drivers/cbus/tahvo.h
@@ -50,9 +50,10 @@
 
 #define MAX_TAHVO_IRQ_HANDLERS	8
 
-int tahvo_read_reg(unsigned reg);
-void tahvo_write_reg(unsigned reg, u16 val);
-void tahvo_set_clear_reg_bits(unsigned reg, u16 set, u16 clear);
+int tahvo_read_reg(struct device *child, unsigned reg);
+void tahvo_write_reg(struct device *child, unsigned reg, u16 val);
+void tahvo_set_clear_reg_bits(struct device *child, unsigned reg, u16 set,
+		u16 clear);
 int tahvo_get_backlight_level(void);
 int tahvo_get_max_backlight_level(void);
 void tahvo_set_backlight_level(int level);
-- 
1.7.6

