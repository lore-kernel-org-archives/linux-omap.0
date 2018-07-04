From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH] rtc: OMAP: Add support for rtc-only mode
Date: Wed, 4 Jul 2018 12:03:45 +0530
Message-ID: <1530686025-546-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc: t-kristo@ti.com, j-keerthy@ti.com, linux-rtc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Prepare rtc driver for rtc-only mode. This involes splitting the power-off
function so that an external driver can initiate the programming of
setting the power_off to be triggered in the next second.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/rtc/interface.c |  12 ++++
 drivers/rtc/rtc-omap.c  | 164 ++++++++++++++++++++++++++++++++++--------------
 include/linux/rtc.h     |   2 +
 3 files changed, 130 insertions(+), 48 deletions(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 6d4012d..d8b70f0 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -1139,3 +1139,15 @@ int rtc_set_offset(struct rtc_device *rtc, long offset)
 	trace_rtc_set_offset(offset, ret);
 	return ret;
 }
+
+/**
+ * rtc_power_off_program - Some of the rtc are hooked on to PMIC_EN
+ * line and can be used to power off the SoC.
+ *
+ * Kernel interface to program rtc to power off
+ */
+void rtc_power_off_program(struct rtc_device *rtc)
+{
+	rtc->ops->power_off_program(rtc->dev.parent);
+}
+EXPORT_SYMBOL_GPL(rtc_power_off_program);
diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 3908639..4dcee1c 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -29,6 +29,7 @@
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/machine.h>
 #include <linux/rtc.h>
 
 /*
@@ -131,6 +132,8 @@
 #define	KICK0_VALUE			0x83e70b13
 #define	KICK1_VALUE			0x95a4f1e0
 
+#define SHUTDOWN_TIME_SEC		1
+
 struct omap_rtc;
 
 struct omap_rtc_device_type {
@@ -415,6 +418,77 @@ static int omap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 
 static struct omap_rtc *omap_rtc_power_off_rtc;
 
+/**
+ * omap_rtc_power_off_program: Set the pmic power off sequence. The RTC
+ * generates pmic_pwr_enable control, which can be used to control an external
+ * PMIC.
+ */
+void omap_rtc_power_off_program(struct device *dev)
+{
+	u32 val;
+	struct rtc_time tm;
+	unsigned long time;
+	int seconds;
+
+	omap_rtc_power_off_rtc->type->unlock(omap_rtc_power_off_rtc);
+
+	/* Clear any existing ALARM2 event */
+	rtc_writel(omap_rtc_power_off_rtc, OMAP_RTC_STATUS_REG,
+		   OMAP_RTC_STATUS_ALARM2);
+
+	pr_info("System will go to power_off state in approx. %d second\n",
+		SHUTDOWN_TIME_SEC);
+
+again:
+	/* Read rtc time */
+	tm.tm_sec = rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_SECONDS_REG);
+	seconds = tm.tm_sec;
+	tm.tm_min = rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_MINUTES_REG);
+	tm.tm_hour = rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_HOURS_REG);
+	tm.tm_mday = rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_DAYS_REG);
+	tm.tm_mon = rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_MONTHS_REG);
+	tm.tm_year = rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_YEARS_REG);
+	bcd2tm(&tm);
+
+	/* Convert Gregorian date to seconds since 01-01-1970 00:00:00 */
+	rtc_tm_to_time(&tm, &time);
+
+	/* Convert seconds since 01-01-1970 00:00:00 to Gregorian date */
+	rtc_time_to_tm(time + SHUTDOWN_TIME_SEC, &tm);
+
+	if (tm2bcd(&tm) < 0)
+		return;
+
+	/* After wait_not_busy, we have at least 15us until the next second. */
+	rtc_wait_not_busy(omap_rtc_power_off_rtc);
+
+	/* Our calculations started right before the rollover, try again */
+	if (seconds != rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_SECONDS_REG))
+		goto again;
+
+	/*
+	 * pmic_pwr_enable is controlled by means of ALARM2 event. So here
+	 * programming alarm2 expiry time and enabling alarm2 interrupt
+	 */
+	rtc_write(omap_rtc_power_off_rtc, OMAP_RTC_ALARM2_SECONDS_REG,
+		  tm.tm_sec);
+	rtc_write(omap_rtc_power_off_rtc, OMAP_RTC_ALARM2_MINUTES_REG,
+		  tm.tm_min);
+	rtc_write(omap_rtc_power_off_rtc, OMAP_RTC_ALARM2_HOURS_REG,
+		  tm.tm_hour);
+	rtc_write(omap_rtc_power_off_rtc, OMAP_RTC_ALARM2_DAYS_REG,
+		  tm.tm_mday);
+	rtc_write(omap_rtc_power_off_rtc, OMAP_RTC_ALARM2_MONTHS_REG,
+		  tm.tm_mon);
+	rtc_write(omap_rtc_power_off_rtc, OMAP_RTC_ALARM2_YEARS_REG,
+		  tm.tm_year);
+
+	/* Enable alarm2 interrupt */
+	val = rtc_readl(omap_rtc_power_off_rtc, OMAP_RTC_INTERRUPTS_REG);
+	rtc_writel(omap_rtc_power_off_rtc, OMAP_RTC_INTERRUPTS_REG, val |
+		   OMAP_RTC_INTERRUPTS_IT_ALARM2);
+}
+
 /*
  * omap_rtc_poweroff: RTC-controlled power off
  *
@@ -431,45 +505,19 @@ static int omap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
  */
 static void omap_rtc_power_off(void)
 {
-	struct omap_rtc *rtc = omap_rtc_power_off_rtc;
-	struct rtc_time tm;
-	unsigned long now;
+	struct rtc_device *rtc = omap_rtc_power_off_rtc->rtc;
 	u32 val;
 
-	rtc->type->unlock(rtc);
-	/* enable pmic_power_en control */
-	val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
-	rtc_writel(rtc, OMAP_RTC_PMIC_REG, val | OMAP_RTC_PMIC_POWER_EN_EN);
-
-	/* set alarm two seconds from now */
-	omap_rtc_read_time_raw(rtc, &tm);
-	bcd2tm(&tm);
-	rtc_tm_to_time(&tm, &now);
-	rtc_time_to_tm(now + 2, &tm);
-
-	if (tm2bcd(&tm) < 0) {
-		dev_err(&rtc->rtc->dev, "power off failed\n");
-		return;
-	}
-
-	rtc_wait_not_busy(rtc);
+	regulator_suspend_prepare(PM_SUSPEND_MAX);
+	omap_rtc_power_off_rtc->type->unlock(omap_rtc_power_off_rtc);
+	omap_rtc_power_off_program(rtc->dev.parent);
 
-	rtc_write(rtc, OMAP_RTC_ALARM2_SECONDS_REG, tm.tm_sec);
-	rtc_write(rtc, OMAP_RTC_ALARM2_MINUTES_REG, tm.tm_min);
-	rtc_write(rtc, OMAP_RTC_ALARM2_HOURS_REG, tm.tm_hour);
-	rtc_write(rtc, OMAP_RTC_ALARM2_DAYS_REG, tm.tm_mday);
-	rtc_write(rtc, OMAP_RTC_ALARM2_MONTHS_REG, tm.tm_mon);
-	rtc_write(rtc, OMAP_RTC_ALARM2_YEARS_REG, tm.tm_year);
-
-	/*
-	 * enable ALARM2 interrupt
-	 *
-	 * NOTE: this fails on AM3352 if rtc_write (writeb) is used
-	 */
-	val = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
-	rtc_writel(rtc, OMAP_RTC_INTERRUPTS_REG,
-			val | OMAP_RTC_INTERRUPTS_IT_ALARM2);
-	rtc->type->lock(rtc);
+	/* Set PMIC power enable and EXT_WAKEUP in case PB power on is used */
+	val = rtc_readl(omap_rtc_power_off_rtc, OMAP_RTC_PMIC_REG);
+	val |= OMAP_RTC_PMIC_POWER_EN_EN | OMAP_RTC_PMIC_EXT_WKUP_POL(0) |
+	       OMAP_RTC_PMIC_EXT_WKUP_EN(0);
+	rtc_writel(omap_rtc_power_off_rtc, OMAP_RTC_PMIC_REG, val);
+	omap_rtc_power_off_rtc->type->lock(omap_rtc_power_off_rtc);
 
 	/*
 	 * Wait for alarm to trigger (within two seconds) and external PMIC to
@@ -477,6 +525,17 @@ static void omap_rtc_power_off(void)
 	 * (e.g. debounce circuits).
 	 */
 	mdelay(2500);
+
+	pr_err("rtc_power_off failed, bailing out.\n");
+}
+
+static void omap_rtc_cleanup_pm_power_off(struct omap_rtc *rtc)
+{
+	if (pm_power_off == omap_rtc_power_off &&
+	    omap_rtc_power_off_rtc == rtc) {
+		pm_power_off = NULL;
+		omap_rtc_power_off_rtc = NULL;
+	}
 }
 
 static const struct rtc_class_ops omap_rtc_ops = {
@@ -485,6 +544,7 @@ static void omap_rtc_power_off(void)
 	.read_alarm	= omap_rtc_read_alarm,
 	.set_alarm	= omap_rtc_set_alarm,
 	.alarm_irq_enable = omap_rtc_alarm_irq_enable,
+	.power_off_program = omap_rtc_power_off_program,
 };
 
 static const struct omap_rtc_device_type omap_rtc_default_type = {
@@ -838,6 +898,11 @@ static int omap_rtc_probe(struct platform_device *pdev)
 	rtc->type->lock(rtc);
 
 	device_init_wakeup(&pdev->dev, true);
+	omap_rtc_power_off_rtc = rtc;
+
+	if (rtc->is_pmic_controller)
+		if (!pm_power_off)
+			pm_power_off = omap_rtc_power_off;
 
 	rtc->rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(rtc->rtc)) {
@@ -887,6 +952,7 @@ static int omap_rtc_probe(struct platform_device *pdev)
 	return 0;
 
 err:
+	omap_rtc_cleanup_pm_power_off(rtc);
 	clk_disable_unprepare(rtc->clk);
 	device_init_wakeup(&pdev->dev, false);
 	rtc->type->lock(rtc);
@@ -901,11 +967,7 @@ static int omap_rtc_remove(struct platform_device *pdev)
 	struct omap_rtc *rtc = platform_get_drvdata(pdev);
 	u8 reg;
 
-	if (pm_power_off == omap_rtc_power_off &&
-			omap_rtc_power_off_rtc == rtc) {
-		pm_power_off = NULL;
-		omap_rtc_power_off_rtc = NULL;
-	}
+	omap_rtc_cleanup_pm_power_off(rtc);
 
 	device_init_wakeup(&pdev->dev, 0);
 
@@ -993,14 +1055,20 @@ static void omap_rtc_shutdown(struct platform_device *pdev)
 	struct omap_rtc *rtc = platform_get_drvdata(pdev);
 	u8 mask;
 
-	/*
-	 * Keep the ALARM interrupt enabled to allow the system to power up on
-	 * alarm events.
-	 */
 	rtc->type->unlock(rtc);
-	mask = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
-	mask &= OMAP_RTC_INTERRUPTS_IT_ALARM;
-	rtc_write(rtc, OMAP_RTC_INTERRUPTS_REG, mask);
+	/* If rtc does not control PMIC then no need to enable ALARM */
+	if (!rtc->is_pmic_controller) {
+		rtc_write(rtc, OMAP_RTC_INTERRUPTS_REG, 0);
+	} else {
+		/*
+		 * Keep the ALARM interrupt enabled to allow the system to
+		 * power up on alarm events.
+		 */
+		mask = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
+		mask &= OMAP_RTC_INTERRUPTS_IT_ALARM;
+		rtc_write(rtc, OMAP_RTC_INTERRUPTS_REG, mask);
+	}
+
 	rtc->type->lock(rtc);
 }
 
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 6268208..f17bc6a 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -85,6 +85,7 @@ struct rtc_class_ops {
 	int (*alarm_irq_enable)(struct device *, unsigned int enabled);
 	int (*read_offset)(struct device *, long *offset);
 	int (*set_offset)(struct device *, long offset);
+	void (*power_off_program)(struct device *dev);
 };
 
 typedef struct rtc_task {
@@ -229,6 +230,7 @@ int rtc_timer_start(struct rtc_device *rtc, struct rtc_timer *timer,
 int rtc_read_offset(struct rtc_device *rtc, long *offset);
 int rtc_set_offset(struct rtc_device *rtc, long offset);
 void rtc_timer_do_work(struct work_struct *work);
+void rtc_power_off_program(struct rtc_device *rtc);
 
 static inline bool is_leap_year(unsigned int year)
 {
-- 
1.9.1
