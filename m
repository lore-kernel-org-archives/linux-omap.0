From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 2/5] rtc: interface: Add power_off_program to rtc_class_ops
Date: Tue, 2 Apr 2019 09:12:50 +0530
Message-ID: <20190402034253.4928-3-j-keerthy@ti.com>
References: <20190402034253.4928-1-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190402034253.4928-1-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, alexandre.belloni@bootlin.com, a.zummo@towertech.it, t-kristo@ti.com
Cc: linux-rtc@vger.kernel.org, d-gerlach@ti.com, j-keerthy@ti.com, ssantosh@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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
index ccb7d6b4da3b..4846ec897067 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -1070,3 +1070,15 @@ int rtc_set_offset(struct rtc_device *rtc, long offset)
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
index b467154443a4..0e7a65c105e7 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -507,6 +507,7 @@ static const struct rtc_class_ops omap_rtc_ops = {
 	.read_alarm	= omap_rtc_read_alarm,
 	.set_alarm	= omap_rtc_set_alarm,
 	.alarm_irq_enable = omap_rtc_alarm_irq_enable,
+	.power_off_program = omap_rtc_power_off_program,
 };
 
 static const struct omap_rtc_device_type omap_rtc_default_type = {
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 48d3f8e0b64f..430e038a2374 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -84,6 +84,7 @@ struct rtc_class_ops {
 	int (*alarm_irq_enable)(struct device *, unsigned int enabled);
 	int (*read_offset)(struct device *, long *offset);
 	int (*set_offset)(struct device *, long offset);
+	int (*power_off_program)(struct device *dev);
 };
 
 struct rtc_device;
@@ -211,6 +212,7 @@ void rtc_timer_cancel(struct rtc_device *rtc, struct rtc_timer *timer);
 int rtc_read_offset(struct rtc_device *rtc, long *offset);
 int rtc_set_offset(struct rtc_device *rtc, long offset);
 void rtc_timer_do_work(struct work_struct *work);
+int rtc_power_off_program(struct rtc_device *rtc);
 
 static inline bool is_leap_year(unsigned int year)
 {
-- 
2.17.1
