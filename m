From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 03/15] cbus: retu: drop the unnecessary spinlock_t
Date: Tue, 15 Feb 2011 10:45:50 +0200
Message-ID: <1297759562-25682-4-git-send-email-balbi@ti.com>
References: <1297759562-25682-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:43541 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751178Ab1BOIqa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 03:46:30 -0500
Received: by mail-yx0-f169.google.com with SMTP id 31so2749101yxl.0
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 00:46:29 -0800 (PST)
In-Reply-To: <1297759562-25682-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

gpiolib functions can sleep, and we already
have a mutex on the driver, so drop the
spinlock_t and use the mutex.

While at that, also rename irq_lock to
mutex since that's not used only for the
IRQ path anymore.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu.c |   21 ++++++++-------------
 1 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index 032864a..82d22b8 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -54,8 +54,7 @@
 
 struct retu {
 	/* Device lock */
-	spinlock_t		lock;
-	struct mutex		irq_lock;
+	struct mutex		mutex;
 	struct device		*dev;
 
 	int			irq_base;
@@ -104,15 +103,14 @@ EXPORT_SYMBOL(retu_write_reg);
 void retu_set_clear_reg_bits(unsigned reg, u16 set, u16 clear)
 {
 	struct retu		*retu = the_retu;
-	unsigned long		flags;
 	u16			w;
 
-	spin_lock_irqsave(&retu->lock, flags);
+	mutex_lock(&retu->mutex);
 	w = retu_read_reg(reg);
 	w &= ~clear;
 	w |= set;
 	retu_write_reg(reg, w);
-	spin_unlock_irqrestore(&retu->lock, flags);
+	mutex_unlock(&retu->mutex);
 }
 EXPORT_SYMBOL_GPL(retu_set_clear_reg_bits);
 
@@ -121,7 +119,6 @@ EXPORT_SYMBOL_GPL(retu_set_clear_reg_bits);
 int retu_read_adc(int channel)
 {
 	struct retu		*retu = the_retu;
-	unsigned long		flags;
 	int			res;
 
 	if (!retu)
@@ -130,7 +127,7 @@ int retu_read_adc(int channel)
 	if (channel < 0 || channel > ADC_MAX_CHAN_NUMBER)
 		return -EINVAL;
 
-	spin_lock_irqsave(&retu->lock, flags);
+	mutex_lock(&retu->mutex);
 
 	if ((channel == 8) && retu->is_vilma) {
 		int scr = retu_read_reg(RETU_REG_ADCSCR);
@@ -147,7 +144,7 @@ int retu_read_adc(int channel)
 		retu_write_reg(RETU_REG_ADCR, (1 << 13));
 
 	/* Unlock retu */
-	spin_unlock_irqrestore(&retu->lock, flags);
+	mutex_unlock(&retu->mutex);
 
 	return res;
 }
@@ -215,7 +212,7 @@ static void retu_bus_lock(struct irq_data *data)
 {
 	struct retu		*retu = irq_data_get_irq_chip_data(data);
 
-	mutex_lock(&retu->irq_lock);
+	mutex_lock(&retu->mutex);
 }
 
 static void retu_bus_sync_unlock(struct irq_data *data)
@@ -232,7 +229,7 @@ static void retu_bus_sync_unlock(struct irq_data *data)
 		retu->ack_pending = false;
 	}
 
-	mutex_unlock(&retu->irq_lock);
+	mutex_unlock(&retu->mutex);
 }
 
 static struct irq_chip retu_irq_chip = {
@@ -410,9 +407,7 @@ static int __init retu_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, retu);
 	the_retu = retu;
 
-	/* Prepare tasklet */
-	spin_lock_init(&retu->lock);
-	mutex_init(&retu->irq_lock);
+	mutex_init(&retu->mutex);
 
 	irq = platform_get_irq(pdev, 0);
 
-- 
1.7.4.rc2

