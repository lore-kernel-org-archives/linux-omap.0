From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v5 2/2] rtc: omap: Cut down the shutdown time from 2 seconds to 1 sec
Date: Wed, 25 Jul 2018 11:21:22 +0530
Message-ID: <1532497882-8828-2-git-send-email-j-keerthy@ti.com>
References: <1532497882-8828-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532497882-8828-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc: t-kristo@ti.com, j-keerthy@ti.com, linux-rtc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, johan@kernel.org
List-Id: linux-omap@vger.kernel.org

Cut down the shutdown time from 2 seconds to 1 sec. In case of roll
over try again.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v5:

  * Added an additional check to see if ALARM2 status is not set
    before retrying.
  * Cleaned up comments
  * Also reduced mdelay to 1S lesser as per this commit

 drivers/rtc/rtc-omap.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 44ff4cc..caa6da6 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -421,12 +421,6 @@ static int omap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
  * The RTC can be used to control an external PMIC via the pmic_power_en pin,
  * which can be configured to transition to OFF on ALARM2 events.
  *
- * Notes:
- * The two-second alarm offset is the shortest offset possible as the alarm
- * registers must be set before the next timer update and the offset
- * calculation is too heavy for everything to be done within a single access
- * period (~15 us).
- *
  * Called with local interrupts disabled.
  */
 static void omap_rtc_power_off(void)
@@ -435,17 +429,20 @@ static void omap_rtc_power_off(void)
 	struct rtc_time tm;
 	unsigned long now;
 	u32 val;
+	int seconds;
 
 	rtc->type->unlock(rtc);
 	/* enable pmic_power_en control */
 	val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
 	rtc_writel(rtc, OMAP_RTC_PMIC_REG, val | OMAP_RTC_PMIC_POWER_EN_EN);
 
-	/* set alarm two seconds from now */
+again:
+	/* set alarm one second from now */
 	omap_rtc_read_time_raw(rtc, &tm);
+	seconds = tm.tm_sec;
 	bcd2tm(&tm);
 	rtc_tm_to_time(&tm, &now);
-	rtc_time_to_tm(now + 2, &tm);
+	rtc_time_to_tm(now + 1, &tm);
 
 	if (tm2bcd(&tm) < 0) {
 		dev_err(&rtc->rtc->dev, "power off failed\n");
@@ -470,14 +467,25 @@ static void omap_rtc_power_off(void)
 	val = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
 	rtc_writel(rtc, OMAP_RTC_INTERRUPTS_REG,
 			val | OMAP_RTC_INTERRUPTS_IT_ALARM2);
+
+	/*
+	 * first check if ALARM2 has fired, if not then check if
+	 * our calculations started right before the rollover, try again
+	 * in case of rollover
+	 */
+	if (!(OMAP_RTC_STATUS_ALARM2 && rtc_read(omap_rtc_power_off_rtc,
+						 OMAP_RTC_STATUS_REG)) &&
+	    seconds != rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_SECONDS_REG))
+		goto again;
+
 	rtc->type->lock(rtc);
 
 	/*
-	 * Wait for alarm to trigger (within two seconds) and external PMIC to
+	 * Wait for alarm to trigger (within one second) and external PMIC to
 	 * power off the system. Add a 500 ms margin for external latencies
 	 * (e.g. debounce circuits).
 	 */
-	mdelay(2500);
+	mdelay(1500);
 }
 
 static const struct rtc_class_ops omap_rtc_ops = {
-- 
1.9.1
