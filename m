From: David Brownell <david-b@pacbell.net>
Subject: [patch 1/2 rc8-omap-git] twl4030 "subdriver" irq tweaks
Date: Mon, 6 Oct 2008 20:37:59 -0700
Message-ID: <200810062037.59468.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:33646 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753450AbYJGDnh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 23:43:37 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Bugfixes to TWL subdriver irq handler setup ... lockdep
workarounds, remove IRQF_DISABLED.  NOPs with current code.

These changes are specific to the drivers which register
directly with the PIH irq_chip (in twl4030-core), and are 
prerequsites to a cleanup patch for that PIH infrastructure.
(Unless you don't use these drivers.)

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
I can't test any of these, but "what could go wrong" ...

 drivers/i2c/chips/twl4030-madc.c            |   10 +++++++++-
 drivers/input/keyboard/omap-twl4030keypad.c |   11 +++++++++--
 drivers/power/twl4030_bci_battery.c         |   18 +++++++++++++++++-
 3 files changed, 35 insertions(+), 4 deletions(-)

--- a/drivers/i2c/chips/twl4030-madc.c
+++ b/drivers/i2c/chips/twl4030-madc.c
@@ -148,6 +148,14 @@ static irqreturn_t twl4030_madc_irq_hand
 	u8 isr_val, imr_val;
 	int i;
 
+#ifdef CONFIG_LOCKDEP
+	/* WORKAROUND for lockdep forcing IRQF_DISABLED on us, which
+	 * we don't want and can't tolerate.  Although it might be
+	 * friendlier not to borrow this thread context...
+	 */
+	local_irq_enable();
+#endif
+
 	/* Use COR to ack interrupts since we have no shared IRQs in ISRx */
 	isr_val = twl4030_madc_read(madc, madc->isr);
 	imr_val = twl4030_madc_read(madc, madc->imr);
@@ -451,7 +459,7 @@ static int __init twl4030_madc_probe(str
 				   regval, TWL4030_BCI_BCICTL1);
 
 	ret = request_irq(TWL4030_MODIRQ_MADC, twl4030_madc_irq_handler,
-			  IRQF_DISABLED, "twl4030_madc", madc);
+			  0, "twl4030_madc", madc);
 	if (ret) {
 		dev_dbg(&pdev->dev, "could not request irq\n");
 		goto err_irq;
--- a/drivers/input/keyboard/omap-twl4030keypad.c
+++ b/drivers/input/keyboard/omap-twl4030keypad.c
@@ -208,6 +208,14 @@ static irqreturn_t do_kp_irq(int irq, vo
 	u8 reg;
 	int ret;
 
+#ifdef CONFIG_LOCKDEP
+	/* WORKAROUND for lockdep forcing IRQF_DISABLED on us, which
+	 * we don't want and can't tolerate.  Although it might be
+	 * friendlier not to borrow this thread context...
+	 */
+	local_irq_enable();
+#endif
+
 	/* Read & Clear TWL4030 pending interrupt */
 	ret = twl4030_kpread(kp, TWL4030_MODULE_KEYPAD, &reg, KEYP_ISR1, 1);
 
@@ -340,8 +348,7 @@ static int __init omap_kp_probe(struct p
 	 * This ISR will always execute in kernel thread context because of
 	 * the need to access the TWL4030 over the I2C bus.
 	 */
-	ret = request_irq(kp->irq, do_kp_irq, IRQF_DISABLED,
-			"TWL4030 Keypad", kp);
+	ret = request_irq(kp->irq, do_kp_irq, 0, pdev->name, kp);
 	if (ret < 0) {
 		dev_info(kp->dbg_dev, "request_irq failed for irq no=%d\n",
 			kp->irq);
--- a/drivers/power/twl4030_bci_battery.c
+++ b/drivers/power/twl4030_bci_battery.c
@@ -210,6 +210,14 @@ static irqreturn_t twl4030charger_interr
 {
 	struct twl4030_bci_device_info *di = _di;
 
+#ifdef CONFIG_LOCKDEP
+	/* WORKAROUND for lockdep forcing IRQF_DISABLED on us, which
+	 * we don't want and can't tolerate.  Although it might be
+	 * friendlier not to borrow this thread context...
+	 */
+	local_irq_enable();
+#endif
+
 	twl4030charger_presence_evt();
 	power_supply_changed(&di->bat);
 
@@ -310,6 +318,14 @@ static irqreturn_t twl4030battery_interr
 	u8 isr1a_val, isr2a_val, clear_2a, clear_1a;
 	int ret;
 
+#ifdef CONFIG_LOCKDEP
+	/* WORKAROUND for lockdep forcing IRQF_DISABLED on us, which
+	 * we don't want and can't tolerate.  Although it might be
+	 * friendlier not to borrow this thread context...
+	 */
+	local_irq_enable();
+#endif
+
 	ret = twl4030_i2c_read_u8(TWL4030_MODULE_INTERRUPTS, &isr1a_val,
 				REG_BCIISR1A);
 	if (ret)
@@ -943,7 +959,7 @@ static int __init twl4030_bci_battery_pr
 
 	/* request BCI interruption */
 	ret = request_irq(TWL4030_MODIRQ_BCI, twl4030battery_interrupt,
-		IRQF_DISABLED, pdev->name, NULL);
+		0, pdev->name, NULL);
 	if (ret) {
 		dev_dbg(&pdev->dev, "could not request irq %d, status %d\n",
 			TWL4030_MODIRQ_BCI, ret);
