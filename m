From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 09/15] cbus: retu: search and replace
Date: Tue, 15 Feb 2011 10:45:56 +0200
Message-ID: <1297759562-25682-10-git-send-email-balbi@ti.com>
References: <1297759562-25682-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:58615 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754140Ab1BOIrA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 03:47:00 -0500
Received: by mail-gx0-f169.google.com with SMTP id 5so2484753gxk.28
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 00:46:59 -0800 (PST)
In-Reply-To: <1297759562-25682-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

replace all occurrences of retu_read_reg
and retu_write_reg with the internal functions
__retu_read_reg and __retu_write_reg on retu.c

Achieved with the following vim command:

:%s/\<retu_\(read\|write\)_reg(/__retu_\1_reg(retu, /gc

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu.c |   41 +++++++++++++++++++++++------------------
 1 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index 7e4b7e5..c798b58 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -126,10 +126,10 @@ void retu_set_clear_reg_bits(unsigned reg, u16 set, u16 clear)
 	u16			w;
 
 	mutex_lock(&retu->mutex);
-	w = retu_read_reg(reg);
+	w = __retu_read_reg(retu, reg);
 	w &= ~clear;
 	w |= set;
-	retu_write_reg(reg, w);
+	__retu_write_reg(retu, reg, w);
 	mutex_unlock(&retu->mutex);
 }
 EXPORT_SYMBOL_GPL(retu_set_clear_reg_bits);
@@ -150,18 +150,18 @@ int retu_read_adc(int channel)
 	mutex_lock(&retu->mutex);
 
 	if ((channel == 8) && retu->is_vilma) {
-		int scr = retu_read_reg(RETU_REG_ADCSCR);
-		int ch = (retu_read_reg(RETU_REG_ADCR) >> 10) & 0xf;
+		int scr = __retu_read_reg(retu, RETU_REG_ADCSCR);
+		int ch = (__retu_read_reg(retu, RETU_REG_ADCR) >> 10) & 0xf;
 		if (((scr & 0xff) != 0) && (ch != 8))
-			retu_write_reg (RETU_REG_ADCSCR, (scr & ~0xff));
+			__retu_write_reg(retu, RETU_REG_ADCSCR, (scr & ~0xff));
 	}
 
 	/* Select the channel and read result */
-	retu_write_reg(RETU_REG_ADCR, channel << 10);
-	res = retu_read_reg(RETU_REG_ADCR) & 0x3ff;
+	__retu_write_reg(retu, RETU_REG_ADCR, channel << 10);
+	res = __retu_read_reg(retu, RETU_REG_ADCR) & 0x3ff;
 
 	if (retu->is_vilma)
-		retu_write_reg(RETU_REG_ADCR, (1 << 13));
+		__retu_write_reg(retu, RETU_REG_ADCR, (1 << 13));
 
 	/* Unlock retu */
 	mutex_unlock(&retu->mutex);
@@ -179,8 +179,8 @@ static irqreturn_t retu_irq_handler(int irq, void *_retu)
 	u16			idr;
 	u16			imr;
 
-	idr = retu_read_reg(RETU_REG_IDR);
-	imr = retu_read_reg(RETU_REG_IMR);
+	idr = __retu_read_reg(retu, RETU_REG_IDR);
+	imr = __retu_read_reg(retu, RETU_REG_IMR);
 	idr &= ~imr;
 
 	if (!idr) {
@@ -240,12 +240,12 @@ static void retu_bus_sync_unlock(struct irq_data *data)
 	struct retu		*retu = irq_data_get_irq_chip_data(data);
 
 	if (retu->mask_pending) {
-		retu_write_reg(RETU_REG_IMR, retu->mask);
+		__retu_write_reg(retu, RETU_REG_IMR, retu->mask);
 		retu->mask_pending = false;
 	}
 
 	if (retu->ack_pending) {
-		retu_write_reg(RETU_REG_IDR, retu->ack);
+		__retu_write_reg(retu, RETU_REG_IDR, retu->ack);
 		retu->ack_pending = false;
 	}
 
@@ -309,10 +309,15 @@ static void retu_irq_exit(struct retu *retu)
  */
 static void retu_power_off(void)
 {
+	struct retu		*retu = the_retu;
+	unsigned		reg;
+
+	reg = __retu_read_reg(retu, RETU_REG_CC1);
+
 	/* Ignore power button state */
-	retu_write_reg(RETU_REG_CC1, retu_read_reg(RETU_REG_CC1) | 2);
+	__retu_write_reg(retu, RETU_REG_CC1, reg | 2);
 	/* Expire watchdog immediately */
-	retu_write_reg(RETU_REG_WATCHDOG, 0);
+	__retu_write_reg(retu, RETU_REG_WATCHDOG, 0);
 	/* Wait for poweroff*/
 	for (;;);
 }
@@ -438,7 +443,7 @@ static int __init retu_probe(struct platform_device *pdev)
 
 	retu_irq_init(retu);
 
-	rev = retu_read_reg(RETU_REG_ASICR) & 0xff;
+	rev = __retu_read_reg(retu, RETU_REG_ASICR) & 0xff;
 	if (rev & (1 << 7))
 		retu->is_vilma = true;
 
@@ -447,7 +452,7 @@ static int __init retu_probe(struct platform_device *pdev)
 			(rev >> 4) & 0x07, rev & 0x0f);
 
 	/* Mask all RETU interrupts */
-	retu_write_reg(RETU_REG_IMR, 0xffff);
+	__retu_write_reg(retu, RETU_REG_IMR, 0xffff);
 
 	ret = request_threaded_irq(irq, NULL, retu_irq_handler, 0,
 			  "retu", retu);
@@ -470,7 +475,7 @@ static int __init retu_probe(struct platform_device *pdev)
 	return 0;
 
 err2:
-	retu_write_reg(RETU_REG_IMR, 0xffff);
+	__retu_write_reg(retu, RETU_REG_IMR, 0xffff);
 	free_irq(irq, retu);
 
 err1:
@@ -489,7 +494,7 @@ static int __exit retu_remove(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 
 	/* Mask all RETU interrupts */
-	retu_write_reg(RETU_REG_IMR, 0xffff);
+	__retu_write_reg(retu, RETU_REG_IMR, 0xffff);
 	free_irq(irq, retu);
 	retu_irq_exit(retu);
 	kfree(retu);
-- 
1.7.4.rc2

