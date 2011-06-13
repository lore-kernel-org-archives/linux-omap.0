From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/2] cbus: pass device as argument
Date: Mon, 13 Jun 2011 22:40:58 +0300
Message-ID: <1307994058-25486-3-git-send-email-balbi@ti.com>
References: <1307994058-25486-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:34092 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752045Ab1FMTlK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Jun 2011 15:41:10 -0400
Received: by mail-fx0-f43.google.com with SMTP id 3so4002924fxm.2
        for <linux-omap@vger.kernel.org>; Mon, 13 Jun 2011 12:41:09 -0700 (PDT)
In-Reply-To: <1307994058-25486-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

that way we can fetch struct cbus_host
via dev_get_platform_data(child->parent).

This also allows us to remove the static
global variable holding cbus_host pointer.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/cbus.c  |   20 +++++++++++---------
 drivers/cbus/cbus.h  |    5 +++--
 drivers/cbus/retu.c  |    4 ++--
 drivers/cbus/tahvo.c |    9 +++++++--
 4 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/cbus/cbus.c b/drivers/cbus/cbus.c
index a8bbf42..fb524cb 100644
--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c
@@ -52,8 +52,6 @@ struct cbus_host {
 	int		sel_gpio;
 };
 
-static struct cbus_host *cbus_host;
-
 /**
  * cbus_send_bit - sends one bit over the bus
  * @host: the host we're using
@@ -220,24 +218,31 @@ out:
 
 /**
  * cbus_read_reg - reads a given register from the device
+ * @child: the child device
  * @dev: device address
  * @reg: register address
  */
-int cbus_read_reg(unsigned dev, unsigned reg)
+int cbus_read_reg(struct device *child, unsigned dev, unsigned reg)
 {
-	return cbus_transfer(cbus_host, CBUS_XFER_READ, dev, reg, 0);
+	struct cbus_host	*host = dev_get_drvdata(child->parent);
+
+	return cbus_transfer(host, CBUS_XFER_READ, dev, reg, 0);
 }
 EXPORT_SYMBOL(cbus_read_reg);
 
 /**
  * cbus_write_reg - writes to a given register of the device
+ * @child: the child device
  * @dev: device address
  * @reg: register address
  * @val: data to be written to @reg
  */
-int cbus_write_reg(unsigned dev, unsigned reg, unsigned val)
+int cbus_write_reg(struct device *child, unsigned dev, unsigned reg,
+		unsigned val)
 {
-	return cbus_transfer(cbus_host, CBUS_XFER_WRITE, dev, reg, val);
+	struct cbus_host	*host = dev_get_drvdata(child->parent);
+
+	return cbus_transfer(host, CBUS_XFER_WRITE, dev, reg, val);
 }
 EXPORT_SYMBOL(cbus_write_reg);
 
@@ -279,8 +284,6 @@ static int __init cbus_bus_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, chost);
 
-	cbus_host = chost;
-
 	return 0;
 exit3:
 	gpio_free(chost->dat_gpio);
@@ -301,7 +304,6 @@ static void __exit cbus_bus_remove(struct platform_device *pdev)
 	gpio_free(chost->clk_gpio);
 
 	kfree(chost);
-	cbus_host = NULL;
 }
 
 static struct platform_driver cbus_driver = {
diff --git a/drivers/cbus/cbus.h b/drivers/cbus/cbus.h
index d53bb70..c1c3bd6 100644
--- a/drivers/cbus/cbus.h
+++ b/drivers/cbus/cbus.h
@@ -23,7 +23,8 @@
 #ifndef __DRIVERS_CBUS_CBUS_H
 #define __DRIVERS_CBUS_CBUS_H
 
-extern int cbus_read_reg(unsigned dev, unsigned reg);
-extern int cbus_write_reg(unsigned dev, unsigned reg, unsigned val);
+extern int cbus_read_reg(struct device *, unsigned dev, unsigned reg);
+extern int cbus_write_reg(struct device *, unsigned dev, unsigned reg,
+		unsigned val);
 
 #endif /* __DRIVERS_CBUS_CBUS_H */
diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index ec108f3..4b5af58 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -79,7 +79,7 @@ static struct retu *the_retu;
  */
 static int __retu_read_reg(struct retu *retu, unsigned reg)
 {
-	return cbus_read_reg(retu->devid, reg);
+	return cbus_read_reg(retu->dev, retu->devid, reg);
 }
 
 /**
@@ -90,7 +90,7 @@ static int __retu_read_reg(struct retu *retu, unsigned reg)
  */
 static void __retu_write_reg(struct retu *retu, unsigned reg, u16 val)
 {
-	cbus_write_reg(retu->devid, reg, val);
+	cbus_write_reg(retu->dev, retu->devid, reg, val);
 }
 
 /**
diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index 45318d9..bc440bc 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -55,6 +55,8 @@ static int tahvo_is_betty;
 static struct tasklet_struct tahvo_tasklet;
 static DEFINE_SPINLOCK(tahvo_lock);
 
+static struct device *the_dev;
+
 struct tahvo_irq_handler_desc {
 	int (*func)(unsigned long);
 	unsigned long arg;
@@ -78,7 +80,7 @@ EXPORT_SYMBOL(tahvo_get_status);
 int tahvo_read_reg(unsigned reg)
 {
 	BUG_ON(!tahvo_initialized);
-	return cbus_read_reg(TAHVO_ID, reg);
+	return cbus_read_reg(the_dev, TAHVO_ID, reg);
 }
 EXPORT_SYMBOL(tahvo_read_reg);
 
@@ -92,7 +94,7 @@ EXPORT_SYMBOL(tahvo_read_reg);
 void tahvo_write_reg(unsigned reg, u16 val)
 {
 	BUG_ON(!tahvo_initialized);
-	cbus_write_reg(TAHVO_ID, reg, val);
+	cbus_write_reg(the_dev, TAHVO_ID, reg, val);
 }
 EXPORT_SYMBOL(tahvo_write_reg);
 
@@ -305,6 +307,8 @@ static int __init tahvo_probe(struct platform_device *pdev)
 	int rev, id, ret;
 	int irq;
 
+	the_dev = &pdev->dev;
+
 	/* Prepare tasklet */
 	tasklet_init(&tahvo_tasklet, tahvo_tasklet_handler, 0);
 
@@ -351,6 +355,7 @@ static int __exit tahvo_remove(struct platform_device *pdev)
 	tahvo_write_reg(TAHVO_REG_IMR, 0xffff);
 	free_irq(irq, 0);
 	tasklet_kill(&tahvo_tasklet);
+	the_dev = NULL;
 
 	return 0;
 }
-- 
1.7.6.rc1

