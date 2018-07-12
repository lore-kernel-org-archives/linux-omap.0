From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v4 4/4] rtc: interface: Add power_off_program to rtc_class_ops
Date: Thu, 12 Jul 2018 10:37:40 +0530
Message-ID: <1531372060-10532-5-git-send-email-j-keerthy@ti.com>
References: <1531372060-10532-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531372060-10532-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc: t-kristo@ti.com, j-keerthy@ti.com, linux-rtc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, johan@kernel.org
List-Id: linux-omap@vger.kernel.org

Add an interface function to set up the rtc for a power_off
mode.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/rtc/interface.c | 12 ++++++++++++
 drivers/rtc/rtc-omap.c  |  1 +
 include/linux/rtc.h     |  2 ++
 3 files changed, 15 insertions(+)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 6d4012d..c19668b9 100644
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
+int rtc_power_off_program(struct rtc_device *rtc)
+{
+	return rtc->ops->power_off_program(rtc->dev.parent);
+}
+EXPORT_SYMBOL_GPL(rtc_power_off_program);
diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 3610efd..9c9ea44 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -518,6 +518,7 @@ static void omap_rtc_power_off(void)
 	.read_alarm	= omap_rtc_read_alarm,
 	.set_alarm	= omap_rtc_set_alarm,
 	.alarm_irq_enable = omap_rtc_alarm_irq_enable,
+	.power_off_program = omap_rtc_power_off_program,
 };
 
 static const struct omap_rtc_device_type omap_rtc_default_type = {
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 6268208..3fc640c 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -85,6 +85,7 @@ struct rtc_class_ops {
 	int (*alarm_irq_enable)(struct device *, unsigned int enabled);
 	int (*read_offset)(struct device *, long *offset);
 	int (*set_offset)(struct device *, long offset);
+	int (*power_off_program)(struct device *dev);
 };
 
 typedef struct rtc_task {
@@ -229,6 +230,7 @@ int rtc_timer_start(struct rtc_device *rtc, struct rtc_timer *timer,
 int rtc_read_offset(struct rtc_device *rtc, long *offset);
 int rtc_set_offset(struct rtc_device *rtc, long offset);
 void rtc_timer_do_work(struct work_struct *work);
+int rtc_power_off_program(struct rtc_device *rtc);
 
 static inline bool is_leap_year(unsigned int year)
 {
-- 
1.9.1
