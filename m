From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v4 1/4] rtc: omap: Cut down the shutdown time from 2 seconds to 1 sec
Date: Thu, 12 Jul 2018 10:37:37 +0530
Message-ID: <1531372060-10532-2-git-send-email-j-keerthy@ti.com>
References: <1531372060-10532-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531372060-10532-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc: t-kristo@ti.com, j-keerthy@ti.com, linux-rtc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, johan@kernel.org
List-Id: linux-omap@vger.kernel.org

Cut down the shutdown time from 2 seconds to 1 sec. In case of roll
over try again.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v4:

  * Fixed a compilation issue.
  * Extended the roll over check post interrupt programming.

 drivers/rtc/rtc-omap.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 323ff55..88da927 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -435,17 +435,23 @@ static void omap_rtc_power_off(void)
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
+	/* Clear any existing ALARM2 event */
+	rtc_writel(rtc, OMAP_RTC_STATUS_REG, OMAP_RTC_STATUS_ALARM2);
+
+	/* set alarm one second from now */
 	omap_rtc_read_time_raw(rtc, &tm);
+	seconds = tm.tm_sec;
 	bcd2tm(&tm);
 	rtc_tm_to_time(&tm, &now);
-	rtc_time_to_tm(now + 2, &tm);
+	rtc_time_to_tm(now + 1, &tm);
 
 	if (tm2bcd(&tm) < 0) {
 		dev_err(&rtc->rtc->dev, "power off failed\n");
@@ -470,6 +476,9 @@ static void omap_rtc_power_off(void)
 	val = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
 	rtc_writel(rtc, OMAP_RTC_INTERRUPTS_REG,
 			val | OMAP_RTC_INTERRUPTS_IT_ALARM2);
+	/* Our calculations started right before the rollover, try again */
+	if (seconds != rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_SECONDS_REG))
+		goto again;
 	rtc->type->lock(rtc);
 
 	/*
-- 
1.9.1
