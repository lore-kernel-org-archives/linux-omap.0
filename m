From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v3 1/3] rtc: omap: Unlock and Lock rtc registers before and after register writes
Date: Thu, 2 Apr 2015 18:28:53 +0530
Message-ID: <1427979533-21784-1-git-send-email-lokeshvutla@ti.com>
References: <1427972751-18909-2-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41988 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752058AbbDBM70 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Apr 2015 08:59:26 -0400
In-Reply-To: <1427972751-18909-2-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: a.zummo@towertech.it, rtc-linux@googlegroups.com
Cc: t-kristo@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, lokeshvutla@ti.com, alexandre.belloni@free-electrons.com

RTC module contains a kicker mechanism to prevent any spurious writes
from changing the register values. This mechanism requires two MMR
writes to the KICK0 and KICK1 registers with exact data values
before the kicker lock mechanism is released.

Currently the driver release the lock in the probe and leaves it enabled
until the rtc driver removal. This eliminates the idea of preventing
spurious writes when RTC driver is loaded.
So implement rtc lock and unlock functions before and after register writes.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
-- This is as advised by Paul to implement lock and unlock functions in
  the driver and not to unlock and leave it in probe.
  The same discussion can be seen here:
  http://www.mail-archive.com/linux-omap%40vger.kernel.org/msg111588.html
- Changes since v1:
  -Instead of testing for has_kicker each time, added .lock and
   .unlock to omap_rtc_device_type.
- Changes since v2:
  -Removed inline for lock and unlock functions.

 drivers/rtc/rtc-omap.c | 63 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 52 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 8e5851a..935212c 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -118,12 +118,15 @@
 #define	KICK0_VALUE			0x83e70b13
 #define	KICK1_VALUE			0x95a4f1e0
 
+struct omap_rtc;
+
 struct omap_rtc_device_type {
 	bool has_32kclk_en;
-	bool has_kicker;
 	bool has_irqwakeen;
 	bool has_pmic_mode;
 	bool has_power_up_reset;
+	void (*lock)(struct omap_rtc *rtc);
+	void (*unlock)(struct omap_rtc *rtc);
 };
 
 struct omap_rtc {
@@ -156,6 +159,26 @@ static inline void rtc_writel(struct omap_rtc *rtc, unsigned int reg, u32 val)
 	writel(val, rtc->base + reg);
 }
 
+static void am3352_rtc_unlock(struct omap_rtc *rtc)
+{
+	rtc_writel(rtc, OMAP_RTC_KICK0_REG, KICK0_VALUE);
+	rtc_writel(rtc, OMAP_RTC_KICK1_REG, KICK1_VALUE);
+}
+
+static void am3352_rtc_lock(struct omap_rtc *rtc)
+{
+	rtc_writel(rtc, OMAP_RTC_KICK0_REG, 0);
+	rtc_writel(rtc, OMAP_RTC_KICK1_REG, 0);
+}
+
+static void default_rtc_unlock(struct omap_rtc *rtc)
+{
+}
+
+static void default_rtc_lock(struct omap_rtc *rtc)
+{
+}
+
 /*
  * We rely on the rtc framework to handle locking (rtc->ops_lock),
  * so the only other requirement is that register accesses which
@@ -186,7 +209,9 @@ static irqreturn_t rtc_irq(int irq, void *dev_id)
 
 	/* alarm irq? */
 	if (irq_data & OMAP_RTC_STATUS_ALARM) {
+		rtc->type->unlock(rtc);
 		rtc_write(rtc, OMAP_RTC_STATUS_REG, OMAP_RTC_STATUS_ALARM);
+		rtc->type->lock(rtc);
 		events |= RTC_IRQF | RTC_AF;
 	}
 
@@ -218,9 +243,11 @@ static int omap_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 		irqwake_reg &= ~OMAP_RTC_IRQWAKEEN_ALARM_WAKEEN;
 	}
 	rtc_wait_not_busy(rtc);
+	rtc->type->unlock(rtc);
 	rtc_write(rtc, OMAP_RTC_INTERRUPTS_REG, reg);
 	if (rtc->type->has_irqwakeen)
 		rtc_write(rtc, OMAP_RTC_IRQWAKEEN, irqwake_reg);
+	rtc->type->lock(rtc);
 	local_irq_enable();
 
 	return 0;
@@ -293,12 +320,14 @@ static int omap_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	local_irq_disable();
 	rtc_wait_not_busy(rtc);
 
+	rtc->type->unlock(rtc);
 	rtc_write(rtc, OMAP_RTC_YEARS_REG, tm->tm_year);
 	rtc_write(rtc, OMAP_RTC_MONTHS_REG, tm->tm_mon);
 	rtc_write(rtc, OMAP_RTC_DAYS_REG, tm->tm_mday);
 	rtc_write(rtc, OMAP_RTC_HOURS_REG, tm->tm_hour);
 	rtc_write(rtc, OMAP_RTC_MINUTES_REG, tm->tm_min);
 	rtc_write(rtc, OMAP_RTC_SECONDS_REG, tm->tm_sec);
+	rtc->type->lock(rtc);
 
 	local_irq_enable();
 
@@ -341,6 +370,7 @@ static int omap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	local_irq_disable();
 	rtc_wait_not_busy(rtc);
 
+	rtc->type->unlock(rtc);
 	rtc_write(rtc, OMAP_RTC_ALARM_YEARS_REG, alm->time.tm_year);
 	rtc_write(rtc, OMAP_RTC_ALARM_MONTHS_REG, alm->time.tm_mon);
 	rtc_write(rtc, OMAP_RTC_ALARM_DAYS_REG, alm->time.tm_mday);
@@ -362,6 +392,7 @@ static int omap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	rtc_write(rtc, OMAP_RTC_INTERRUPTS_REG, reg);
 	if (rtc->type->has_irqwakeen)
 		rtc_write(rtc, OMAP_RTC_IRQWAKEEN, irqwake_reg);
+	rtc->type->lock(rtc);
 
 	local_irq_enable();
 
@@ -391,6 +422,7 @@ static void omap_rtc_power_off(void)
 	unsigned long now;
 	u32 val;
 
+	rtc->type->unlock(rtc);
 	/* enable pmic_power_en control */
 	val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
 	rtc_writel(rtc, OMAP_RTC_PMIC_REG, val | OMAP_RTC_PMIC_POWER_EN_EN);
@@ -423,6 +455,7 @@ static void omap_rtc_power_off(void)
 	val = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
 	rtc_writel(rtc, OMAP_RTC_INTERRUPTS_REG,
 			val | OMAP_RTC_INTERRUPTS_IT_ALARM2);
+	rtc->type->lock(rtc);
 
 	/*
 	 * Wait for alarm to trigger (within two seconds) and external PMIC to
@@ -442,17 +475,21 @@ static struct rtc_class_ops omap_rtc_ops = {
 
 static const struct omap_rtc_device_type omap_rtc_default_type = {
 	.has_power_up_reset = true,
+	.lock		= default_rtc_lock,
+	.unlock		= default_rtc_unlock,
 };
 
 static const struct omap_rtc_device_type omap_rtc_am3352_type = {
 	.has_32kclk_en	= true,
-	.has_kicker	= true,
 	.has_irqwakeen	= true,
 	.has_pmic_mode	= true,
+	.lock		= am3352_rtc_lock,
+	.unlock		= am3352_rtc_unlock,
 };
 
 static const struct omap_rtc_device_type omap_rtc_da830_type = {
-	.has_kicker	= true,
+	.lock		= am3352_rtc_lock,
+	.unlock		= am3352_rtc_unlock,
 };
 
 static const struct platform_device_id omap_rtc_id_table[] = {
@@ -527,10 +564,7 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
-	if (rtc->type->has_kicker) {
-		rtc_writel(rtc, OMAP_RTC_KICK0_REG, KICK0_VALUE);
-		rtc_writel(rtc, OMAP_RTC_KICK1_REG, KICK1_VALUE);
-	}
+	rtc->type->unlock(rtc);
 
 	/*
 	 * disable interrupts
@@ -593,6 +627,8 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
 	if (reg != new_ctrl)
 		rtc_write(rtc, OMAP_RTC_CTRL_REG, new_ctrl);
 
+	rtc->type->lock(rtc);
+
 	device_init_wakeup(&pdev->dev, true);
 
 	rtc->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
@@ -626,8 +662,7 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
 
 err:
 	device_init_wakeup(&pdev->dev, false);
-	if (rtc->type->has_kicker)
-		rtc_writel(rtc, OMAP_RTC_KICK0_REG, 0);
+	rtc->type->lock(rtc);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
@@ -646,11 +681,11 @@ static int __exit omap_rtc_remove(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, 0);
 
+	rtc->type->unlock(rtc);
 	/* leave rtc running, but disable irqs */
 	rtc_write(rtc, OMAP_RTC_INTERRUPTS_REG, 0);
 
-	if (rtc->type->has_kicker)
-		rtc_writel(rtc, OMAP_RTC_KICK0_REG, 0);
+	rtc->type->lock(rtc);
 
 	/* Disable the clock/module */
 	pm_runtime_put_sync(&pdev->dev);
@@ -666,6 +701,7 @@ static int omap_rtc_suspend(struct device *dev)
 
 	rtc->interrupts_reg = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
 
+	rtc->type->unlock(rtc);
 	/*
 	 * FIXME: the RTC alarm is not currently acting as a wakeup event
 	 * source on some platforms, and in fact this enable() call is just
@@ -675,6 +711,7 @@ static int omap_rtc_suspend(struct device *dev)
 		enable_irq_wake(rtc->irq_alarm);
 	else
 		rtc_write(rtc, OMAP_RTC_INTERRUPTS_REG, 0);
+	rtc->type->lock(rtc);
 
 	/* Disable the clock/module */
 	pm_runtime_put_sync(dev);
@@ -689,10 +726,12 @@ static int omap_rtc_resume(struct device *dev)
 	/* Enable the clock/module so that we can access the registers */
 	pm_runtime_get_sync(dev);
 
+	rtc->type->unlock(rtc);
 	if (device_may_wakeup(dev))
 		disable_irq_wake(rtc->irq_alarm);
 	else
 		rtc_write(rtc, OMAP_RTC_INTERRUPTS_REG, rtc->interrupts_reg);
+	rtc->type->lock(rtc);
 
 	return 0;
 }
@@ -709,9 +748,11 @@ static void omap_rtc_shutdown(struct platform_device *pdev)
 	 * Keep the ALARM interrupt enabled to allow the system to power up on
 	 * alarm events.
 	 */
+	rtc->type->unlock(rtc);
 	mask = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
 	mask &= OMAP_RTC_INTERRUPTS_IT_ALARM;
 	rtc_write(rtc, OMAP_RTC_INTERRUPTS_REG, mask);
+	rtc->type->lock(rtc);
 }
 
 static struct platform_driver omap_rtc_driver = {
-- 
1.9.1

