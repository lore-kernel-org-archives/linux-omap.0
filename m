From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/6] cbus: retu: pass the child device pointer to all retu functions
Date: Wed, 16 Feb 2011 22:01:17 +0200
Message-ID: <1297886481-26098-3-git-send-email-balbi@ti.com>
References: <1297886481-26098-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:43465 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753788Ab1BPUBd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 15:01:33 -0500
Received: by mail-ey0-f178.google.com with SMTP id 5so1065269eyh.9
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 12:01:31 -0800 (PST)
In-Reply-To: <1297886481-26098-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Throught the child device pointer, we can fetch
our needed struct retu simply by dev_get_drvdata(child->parent)

By using that trick, we can get really close to getting
rid of the global struct retu pointer.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu-headset.c   |   31 ++++++++++++++++++-------------
 drivers/cbus/retu-pwrbutton.c |    2 +-
 drivers/cbus/retu-rtc.c       |   28 ++++++++++++++--------------
 drivers/cbus/retu-wdt.c       |    7 +++----
 drivers/cbus/retu.c           |   37 +++++++++++++++++++++++++++----------
 drivers/cbus/retu.h           |    9 +++++----
 6 files changed, 68 insertions(+), 46 deletions(-)

diff --git a/drivers/cbus/retu-headset.c b/drivers/cbus/retu-headset.c
index acf5cbe7..d0b39a7 100644
--- a/drivers/cbus/retu-headset.c
+++ b/drivers/cbus/retu-headset.c
@@ -48,15 +48,16 @@ struct retu_headset {
 	int				irq;
 };
 
-static void retu_headset_set_bias(int enable)
+static void retu_headset_set_bias(struct retu_headset *hs, int enable)
 {
 	if (enable) {
-		retu_set_clear_reg_bits(RETU_REG_AUDTXR,
+		retu_set_clear_reg_bits(&hs->pdev->dev, RETU_REG_AUDTXR,
 					(1 << 0) | (1 << 1), 0);
 		msleep(2);
-		retu_set_clear_reg_bits(RETU_REG_AUDTXR, 1 << 3, 0);
+		retu_set_clear_reg_bits(&hs->pdev->dev, RETU_REG_AUDTXR,
+				1 << 3, 0);
 	} else {
-		retu_set_clear_reg_bits(RETU_REG_AUDTXR, 0,
+		retu_set_clear_reg_bits(&hs->pdev->dev, RETU_REG_AUDTXR, 0,
 					(1 << 0) | (1 << 1) | (1 << 3));
 	}
 }
@@ -66,7 +67,7 @@ static void retu_headset_enable(struct retu_headset *hs)
 	mutex_lock(&hs->mutex);
 	if (!hs->bias_enabled) {
 		hs->bias_enabled = 1;
-		retu_headset_set_bias(1);
+		retu_headset_set_bias(hs, 1);
 	}
 	mutex_unlock(&hs->mutex);
 }
@@ -76,7 +77,7 @@ static void retu_headset_disable(struct retu_headset *hs)
 	mutex_lock(&hs->mutex);
 	if (hs->bias_enabled) {
 		hs->bias_enabled = 0;
-		retu_headset_set_bias(0);
+		retu_headset_set_bias(hs, 0);
 	}
 	mutex_unlock(&hs->mutex);
 }
@@ -86,7 +87,8 @@ static void retu_headset_det_enable(struct retu_headset *hs)
 	mutex_lock(&hs->mutex);
 	if (!hs->detection_enabled) {
 		hs->detection_enabled = 1;
-		retu_set_clear_reg_bits(RETU_REG_CC1, (1 << 10) | (1 << 8), 0);
+		retu_set_clear_reg_bits(&hs->pdev->dev, RETU_REG_CC1,
+				(1 << 10) | (1 << 8), 0);
 	}
 	mutex_unlock(&hs->mutex);
 }
@@ -104,7 +106,8 @@ static void retu_headset_det_disable(struct retu_headset *hs)
 		if (hs->pressed)
 			input_report_key(hs->idev, RETU_HEADSET_KEY, 0);
 		spin_unlock_irqrestore(&hs->lock, flags);
-		retu_set_clear_reg_bits(RETU_REG_CC1, 0, (1 << 10) | (1 << 8));
+		retu_set_clear_reg_bits(&hs->pdev->dev, RETU_REG_CC1, 0,
+				(1 << 10) | (1 << 8));
 	}
 	mutex_unlock(&hs->mutex);
 }
@@ -115,7 +118,7 @@ static ssize_t retu_headset_hookdet_show(struct device *dev,
 {
 	int val;
 
-	val = retu_read_adc(RETU_ADC_CHANNEL_HOOKDET);
+	val = retu_read_adc(dev, RETU_ADC_CHANNEL_HOOKDET);
 	return sprintf(buf, "%d\n", val);
 }
 
@@ -190,7 +193,8 @@ static irqreturn_t retu_headset_hook_interrupt(int irq, void *_hs)
 		input_report_key(hs->idev, RETU_HEADSET_KEY, 1);
 	}
 	spin_unlock_irqrestore(&hs->lock, flags);
-	retu_set_clear_reg_bits(RETU_REG_CC1, 0, (1 << 10) | (1 << 8));
+	retu_set_clear_reg_bits(&hs->pdev->dev, RETU_REG_CC1, 0,
+			(1 << 10) | (1 << 8));
 	mod_timer(&hs->enable_timer, jiffies + msecs_to_jiffies(50));
 
 	return IRQ_HANDLED;
@@ -200,7 +204,8 @@ static void retu_headset_enable_timer(unsigned long arg)
 {
 	struct retu_headset *hs = (struct retu_headset *) arg;
 
-	retu_set_clear_reg_bits(RETU_REG_CC1, (1 << 10) | (1 << 8), 0);
+	retu_set_clear_reg_bits(&hs->pdev->dev, RETU_REG_CC1,
+			(1 << 10) | (1 << 8), 0);
 	mod_timer(&hs->detect_timer, jiffies + msecs_to_jiffies(350));
 }
 
@@ -309,7 +314,7 @@ static int retu_headset_suspend(struct platform_device *pdev,
 
 	mutex_lock(&hs->mutex);
 	if (hs->bias_enabled)
-		retu_headset_set_bias(0);
+		retu_headset_set_bias(hs, 0);
 	mutex_unlock(&hs->mutex);
 
 	return 0;
@@ -321,7 +326,7 @@ static int retu_headset_resume(struct platform_device *pdev)
 
 	mutex_lock(&hs->mutex);
 	if (hs->bias_enabled)
-		retu_headset_set_bias(1);
+		retu_headset_set_bias(hs, 1);
 	mutex_unlock(&hs->mutex);
 
 	return 0;
diff --git a/drivers/cbus/retu-pwrbutton.c b/drivers/cbus/retu-pwrbutton.c
index 77c655d..a5a3069 100644
--- a/drivers/cbus/retu-pwrbutton.c
+++ b/drivers/cbus/retu-pwrbutton.c
@@ -58,7 +58,7 @@ static irqreturn_t retubutton_irq(int irq, void *_pwr)
 	struct retu_pwrbutton *pwr = _pwr;
 	int state;
 
-	if (retu_read_reg(RETU_REG_STATUS) & RETU_STATUS_PWRONX)
+	if (retu_read_reg(pwr->dev, RETU_REG_STATUS) & RETU_STATUS_PWRONX)
 		state = PWRBTN_UP;
 	else
 		state = PWRBTN_PRESSED;
diff --git a/drivers/cbus/retu-rtc.c b/drivers/cbus/retu-rtc.c
index 303a4a6..488849c 100644
--- a/drivers/cbus/retu-rtc.c
+++ b/drivers/cbus/retu-rtc.c
@@ -60,16 +60,16 @@ static void retu_rtc_do_reset(struct retu_rtc *rtc)
 {
 	u16 ccr1;
 
-	ccr1 = retu_read_reg(RETU_REG_CC1);
+	ccr1 = retu_read_reg(rtc->dev, RETU_REG_CC1);
 	/* RTC in reset */
-	retu_write_reg(RETU_REG_CC1, ccr1 | 0x0001);
+	retu_write_reg(rtc->dev, RETU_REG_CC1, ccr1 | 0x0001);
 	/* RTC in normal operating mode */
-	retu_write_reg(RETU_REG_CC1, ccr1 & ~0x0001);
+	retu_write_reg(rtc->dev, RETU_REG_CC1, ccr1 & ~0x0001);
 
 	/* Disable alarm and RTC WD */
-	retu_write_reg(RETU_REG_RTCHMAR, 0x7f3f);
+	retu_write_reg(rtc->dev, RETU_REG_RTCHMAR, 0x7f3f);
 	/* Set Calibration register to default value */
-	retu_write_reg(RETU_REG_RTCCALR, 0x00c0);
+	retu_write_reg(rtc->dev, RETU_REG_RTCCALR, 0x00c0);
 
 	rtc->alarm_expired = 0;
 }
@@ -80,7 +80,7 @@ static irqreturn_t retu_rtc_interrupt(int irq, void *_rtc)
 
 	mutex_lock(&rtc->mutex);
 	rtc->alarm_expired = 1;
-	retu_write_reg(RETU_REG_RTCHMAR, (24 << 8) | 60);
+	retu_write_reg(rtc->dev, RETU_REG_RTCHMAR, (24 << 8) | 60);
 	mutex_unlock(&rtc->mutex);
 
 	return IRQ_HANDLED;
@@ -120,7 +120,7 @@ static int retu_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	mutex_lock(&rtc->mutex);
 
 	chmar = ((alm->time.tm_hour & 0x1f) << 8) | (alm->time.tm_min & 0x3f);
-	retu_write_reg(RETU_REG_RTCHMAR, chmar);
+	retu_write_reg(rtc->dev, RETU_REG_RTCHMAR, chmar);
 
 	mutex_unlock(&rtc->mutex);
 
@@ -134,7 +134,7 @@ static int retu_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 
 	mutex_lock(&rtc->mutex);
 
-	chmar = retu_read_reg(RETU_REG_RTCHMAR);
+	chmar = retu_read_reg(rtc->dev, RETU_REG_RTCHMAR);
 
 	alm->time.tm_hour	= (chmar >> 8) & 0x1f;
 	alm->time.tm_min	= chmar & 0x3f;
@@ -156,8 +156,8 @@ static int retu_rtc_set_time(struct device *dev, struct rtc_time *tm)
 
 	mutex_lock(&rtc->mutex);
 
-	retu_write_reg(RETU_REG_RTCDSR, dsr);
-	retu_write_reg(RETU_REG_RTCHMR, hmr);
+	retu_write_reg(rtc->dev, RETU_REG_RTCDSR, dsr);
+	retu_write_reg(rtc->dev, RETU_REG_RTCHMR, hmr);
 
 	mutex_unlock(&rtc->mutex);
 
@@ -179,8 +179,8 @@ static int retu_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 	mutex_lock(&rtc->mutex);
 
-	dsr	= retu_read_reg(RETU_REG_RTCDSR);
-	hmr	= retu_read_reg(RETU_REG_RTCHMR);
+	dsr	= retu_read_reg(rtc->dev, RETU_REG_RTCDSR);
+	hmr	= retu_read_reg(rtc->dev, RETU_REG_RTCHMR);
 
 	tm->tm_sec	= hmr & 0xff;
 	tm->tm_min	= hmr >> 8;
@@ -215,7 +215,7 @@ static int __init retu_rtc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, rtc);
 	mutex_init(&rtc->mutex);
 
-	rtc->alarm_expired = retu_read_reg(RETU_REG_IDR) &
+	rtc->alarm_expired = retu_read_reg(rtc->dev, RETU_REG_IDR) &
 		(0x1 << RETU_INT_RTCA);
 
 	r = retu_rtc_init_irq(rtc);
@@ -225,7 +225,7 @@ static int __init retu_rtc_probe(struct platform_device *pdev)
 	}
 
 	/* If the calibration register is zero, we've probably lost power */
-	if (!(retu_read_reg(RETU_REG_RTCCALR) & 0x00ff))
+	if (!(retu_read_reg(rtc->dev, RETU_REG_RTCCALR) & 0x00ff))
 		retu_rtc_do_reset(rtc);
 
 	rtc->rtc = rtc_device_register(pdev->name, &pdev->dev, &
diff --git a/drivers/cbus/retu-wdt.c b/drivers/cbus/retu-wdt.c
index f6ff9ad..58449e3 100644
--- a/drivers/cbus/retu-wdt.c
+++ b/drivers/cbus/retu-wdt.c
@@ -67,7 +67,8 @@ static void retu_wdt_set_ping_timer(unsigned long enable);
 
 static int _retu_modify_counter(unsigned int new)
 {
-	retu_write_reg(RETU_REG_WATCHDOG, (u16)new);
+	if (retu_wdt)
+		retu_write_reg(retu_wdt->dev, RETU_REG_WATCHDOG, (u16)new);
 
 	return 0;
 }
@@ -125,7 +126,7 @@ static ssize_t retu_wdt_counter_show(struct device *dev,
 	u16 counter;
 
 	/* Show current value in watchdog counter */
-	counter = retu_read_reg(RETU_REG_WATCHDOG);
+	counter = retu_read_reg(dev, RETU_REG_WATCHDOG);
 
 	/* Only the 5 LSB are important */
 	return snprintf(buf, PAGE_SIZE, "%u\n", (counter & 0x3F));
@@ -228,8 +229,6 @@ static long retu_wdt_ioctl(struct file *file, unsigned int cmd,
 /* Start kicking retu watchdog until user space starts doing the kicking */
 static int __devinit retu_wdt_ping(void)
 {
-	int r;
-
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
 	retu_modify_counter(RETU_WDT_MAX_TIMER);
 #else
diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index c798b58..af4d96a 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -95,34 +95,46 @@ static void __retu_write_reg(struct retu *retu, unsigned reg, u16 val)
 
 /**
  * retu_read_reg - Read a value from a register in Retu
+ * @child: device pointer for the calling child
  * @reg: the register to read from
  *
  * This function returns the contents of the specified register
  */
-int retu_read_reg(unsigned reg)
+int retu_read_reg(struct device *child, unsigned reg)
 {
-	WARN(!the_retu, "Retu not initialized\n");
-	return __retu_read_reg(the_retu, reg);
+	struct retu		*retu = dev_get_drvdata(child->parent);
+
+	return __retu_read_reg(retu, reg);
 }
 EXPORT_SYMBOL(retu_read_reg);
 
 /**
  * retu_write_reg - Write a value to a register in Retu
+ * @child: the pointer to our calling child
  * @reg: the register to write to
  * @val: the value to write to the register
  *
  * This function writes a value to the specified register
  */
-void retu_write_reg(unsigned reg, u16 val)
+void retu_write_reg(struct device *child, unsigned reg, u16 val)
 {
-	WARN(!the_retu, "Retu not initialized\n");
-	__retu_write_reg(the_retu, reg, val);
+	struct retu		*retu = dev_get_drvdata(child->parent);
+
+	__retu_write_reg(retu, reg, val);
 }
 EXPORT_SYMBOL(retu_write_reg);
 
-void retu_set_clear_reg_bits(unsigned reg, u16 set, u16 clear)
+/**
+ * retu_set_clear_reg_bits - helper function to read/set/clear bits
+ * @child: device pointer to calling child
+ * @reg: the register address
+ * @set: mask for setting bits
+ * @clear: mask for clearing bits
+ */
+void retu_set_clear_reg_bits(struct device *child, unsigned reg, u16 set,
+		u16 clear)
 {
-	struct retu		*retu = the_retu;
+	struct retu		*retu = dev_get_drvdata(child->parent);
 	u16			w;
 
 	mutex_lock(&retu->mutex);
@@ -136,9 +148,14 @@ EXPORT_SYMBOL_GPL(retu_set_clear_reg_bits);
 
 #define ADC_MAX_CHAN_NUMBER	13
 
-int retu_read_adc(int channel)
+/**
+ * retu_read_adc - Reads AD conversion result
+ * @child: device pointer to calling child
+ * @channel: the ADC channel to read from
+ */
+int retu_read_adc(struct device *child, int channel)
 {
-	struct retu		*retu = the_retu;
+	struct retu		*retu = dev_get_drvdata(child->parent);
 	int			res;
 
 	if (!retu)
diff --git a/drivers/cbus/retu.h b/drivers/cbus/retu.h
index f2357a9..9880f2e 100644
--- a/drivers/cbus/retu.h
+++ b/drivers/cbus/retu.h
@@ -57,9 +57,10 @@
 
 #define	MAX_RETU_IRQ_HANDLERS	16
 
-int retu_read_reg(unsigned reg);
-void retu_write_reg(unsigned reg, u16 val);
-void retu_set_clear_reg_bits(unsigned reg, u16 set, u16 clear);
-int retu_read_adc(int channel);
+int retu_read_reg(struct device *child, unsigned reg);
+void retu_write_reg(struct device *child, unsigned reg, u16 val);
+void retu_set_clear_reg_bits(struct device *child, unsigned reg, u16 set,
+		u16 clear);
+int retu_read_adc(struct device *child, int channel);
 
 #endif /* __DRIVERS_CBUS_RETU_H */
-- 
1.7.4.rc2

