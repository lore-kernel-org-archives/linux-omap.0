From: balajitk-l0cyMroinI0@public.gmane.org
Subject: [RFC][PATCH v2 2/4] OMAP4: PMIC: Add support for twl6030 RTC
Date: Wed, 29 Jul 2009 10:05:09 +0530
Message-ID: <1248842109-21713-1-git-send-email-balajitk@ti.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-RWuK6r/cQWRpLGFMi4vTTA@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, timo.t.kokkonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>

This version of patch series enables RUN TIME selection of TWL4030 or TWL6030.

This patch adds support for RTC in phoenix TWL6030.
Register offset addresses have changed in TWL6030
rtc-twl.c will hence forth support all twl RTC (4030, 5030, 6030 ..)

Signed-off-by: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
---
 drivers/mfd/twl-core.c |    2 +-
 drivers/rtc/Kconfig    |    8 ++--
 drivers/rtc/Makefile   |    2 +-
 drivers/rtc/rtc-twl.c  |  113 ++++++++++++++++++++++++++++++++++++------------
 4 files changed, 91 insertions(+), 34 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 4066b2f..78109ca 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -89,7 +89,7 @@
 #define twl_has_madc()	false
 #endif
 
-#if defined(CONFIG_RTC_DRV_TWL4030) || defined(CONFIG_RTC_DRV_TWL4030_MODULE)
+#if defined(CONFIG_RTC_DRV_TWL) || defined(CONFIG_RTC_DRV_TWL_MODULE)
 #define twl_has_rtc()	true
 #else
 #define twl_has_rtc()	false
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 81adbdb..bb94924 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -257,15 +257,15 @@ config RTC_DRV_TWL92330
 	  platforms. The support is integrated with the rest of
 	  the Menelaus driver; it's not separate module.
 
-config RTC_DRV_TWL4030
-	tristate "TI TWL4030/TWL5030/TPS659x0"
-	depends on RTC_CLASS && TWL4030_CORE
+config RTC_DRV_TWL
+	tristate "TI TWL4030/TWL5030/TWL6030/TPS659x0"
+	depends on RTC_CLASS && TWL_CORE
 	help
 	  If you say yes here you get support for the RTC on the
 	  TWL4030 family chips, used mostly with OMAP3 platforms.
 
 	  This driver can also be built as a module. If so, the module
-	  will be called rtc-twl4030.
+	  will be called rtc-twl.
 
 config RTC_DRV_S35390A
 	tristate "Seiko Instruments S-35390A"
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index e331b1c..c32e21d 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -70,7 +70,7 @@ obj-$(CONFIG_RTC_DRV_SA1100)	+= rtc-sa1100.o
 obj-$(CONFIG_RTC_DRV_SH)	+= rtc-sh.o
 obj-$(CONFIG_RTC_DRV_STK17TA8)	+= rtc-stk17ta8.o
 obj-$(CONFIG_RTC_DRV_TEST)	+= rtc-test.o
-obj-$(CONFIG_RTC_DRV_TWL4030)	+= rtc-twl.o
+obj-$(CONFIG_RTC_DRV_TWL)	+= rtc-twl.o
 obj-$(CONFIG_RTC_DRV_TX4939)	+= rtc-tx4939.o
 obj-$(CONFIG_RTC_DRV_V3020)	+= rtc-v3020.o
 obj-$(CONFIG_RTC_DRV_VR41XX)	+= rtc-vr41xx.o
diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
index 630acb7..1e9f90d 100644
--- a/drivers/rtc/rtc-twl.c
+++ b/drivers/rtc/rtc-twl.c
@@ -34,27 +34,75 @@
 /*
  * RTC block register offsets (use TWL_MODULE_RTC)
  */
-#define REG_SECONDS_REG                          0x00
-#define REG_MINUTES_REG                          0x01
-#define REG_HOURS_REG                            0x02
-#define REG_DAYS_REG                             0x03
-#define REG_MONTHS_REG                           0x04
-#define REG_YEARS_REG                            0x05
-#define REG_WEEKS_REG                            0x06
-
-#define REG_ALARM_SECONDS_REG                    0x07
-#define REG_ALARM_MINUTES_REG                    0x08
-#define REG_ALARM_HOURS_REG                      0x09
-#define REG_ALARM_DAYS_REG                       0x0A
-#define REG_ALARM_MONTHS_REG                     0x0B
-#define REG_ALARM_YEARS_REG                      0x0C
-
-#define REG_RTC_CTRL_REG                         0x0D
-#define REG_RTC_STATUS_REG                       0x0E
-#define REG_RTC_INTERRUPTS_REG                   0x0F
-
-#define REG_RTC_COMP_LSB_REG                     0x10
-#define REG_RTC_COMP_MSB_REG                     0x11
+enum {
+	REG_SECONDS_REG = 0,
+	REG_MINUTES_REG,
+	REG_HOURS_REG,
+	REG_DAYS_REG,
+	REG_MONTHS_REG,
+	REG_YEARS_REG,
+	REG_WEEKS_REG,
+
+	REG_ALARM_SECONDS_REG,
+	REG_ALARM_MINUTES_REG,
+	REG_ALARM_HOURS_REG,
+	REG_ALARM_DAYS_REG,
+	REG_ALARM_MONTHS_REG,
+	REG_ALARM_YEARS_REG,
+
+	REG_RTC_CTRL_REG,
+	REG_RTC_STATUS_REG,
+	REG_RTC_INTERRUPTS_REG,
+
+	REG_RTC_COMP_LSB_REG,
+	REG_RTC_COMP_MSB_REG,
+};
+const static u8 twl4030_rtc_reg_map[] = {
+	[REG_SECONDS_REG] = 0x00,
+	[REG_MINUTES_REG] = 0x01,
+	[REG_HOURS_REG] = 0x02,
+	[REG_DAYS_REG] = 0x03,
+	[REG_MONTHS_REG] = 0x04,
+	[REG_YEARS_REG] = 0x05,
+	[REG_WEEKS_REG] = 0x06,
+
+	[REG_ALARM_SECONDS_REG] = 0x07,
+	[REG_ALARM_MINUTES_REG] = 0x08,
+	[REG_ALARM_HOURS_REG] = 0x09,
+	[REG_ALARM_DAYS_REG] = 0x0A,
+	[REG_ALARM_MONTHS_REG] = 0x0B,
+	[REG_ALARM_YEARS_REG] = 0x0C,
+
+	[REG_RTC_CTRL_REG] = 0x0D,
+	[REG_RTC_STATUS_REG] = 0x0E,
+	[REG_RTC_INTERRUPTS_REG] = 0x0F,
+
+	[REG_RTC_COMP_LSB_REG] = 0x10,
+	[REG_RTC_COMP_MSB_REG] = 0x11,
+};
+const static u8 twl6030_rtc_reg_map[] = {
+	[REG_SECONDS_REG] = 0x00,
+	[REG_MINUTES_REG] = 0x01,
+	[REG_HOURS_REG] = 0x02,
+	[REG_DAYS_REG] = 0x03,
+	[REG_MONTHS_REG] = 0x04,
+	[REG_YEARS_REG] = 0x05,
+	[REG_WEEKS_REG] = 0x06,
+
+	[REG_ALARM_SECONDS_REG] = 0x08,
+	[REG_ALARM_MINUTES_REG] = 0x09,
+	[REG_ALARM_HOURS_REG] = 0x0A,
+	[REG_ALARM_DAYS_REG] = 0x0B,
+	[REG_ALARM_MONTHS_REG] = 0x0C,
+	[REG_ALARM_YEARS_REG] = 0x0D,
+
+	[REG_RTC_CTRL_REG] = 0x10,
+	[REG_RTC_STATUS_REG] = 0x11,
+	[REG_RTC_INTERRUPTS_REG] = 0x12,
+
+	[REG_RTC_COMP_LSB_REG] = 0x13,
+	[REG_RTC_COMP_MSB_REG] = 0x14,
+};
 
 /* RTC_CTRL_REG bitfields */
 #define BIT_RTC_CTRL_REG_STOP_RTC_M              0x01
@@ -84,6 +132,7 @@
 #define ALL_TIME_REGS		6
 
 /*----------------------------------------------------------------------*/
+static u8  *rtc_reg_map;
 
 /*
  * Supports 1 byte read from TWL4030 RTC register.
@@ -92,7 +141,7 @@ static int twl_rtc_read_u8(u8 *data, u8 reg)
 {
 	int ret;
 
-	ret = twl_i2c_read_u8(TWL_MODULE_RTC, data, reg);
+	ret = twl_i2c_read_u8(TWL_MODULE_RTC, data, (rtc_reg_map[reg]));
 	if (ret < 0)
 		pr_err("twl_rtc: Could not read TWL4030"
 		       "register %X - error %d\n", reg, ret);
@@ -106,7 +155,7 @@ static int twl_rtc_write_u8(u8 data, u8 reg)
 {
 	int ret;
 
-	ret = twl_i2c_write_u8(TWL_MODULE_RTC, data, reg);
+	ret = twl_i2c_write_u8(TWL_MODULE_RTC, data, (rtc_reg_map[reg]));
 	if (ret < 0)
 		pr_err("twl_rtc: Could not write TWL4030"
 		       "register %X - error %d\n", reg, ret);
@@ -202,7 +251,7 @@ static int twl_rtc_read_time(struct device *dev, struct rtc_time *tm)
 		return ret;
 
 	ret = twl_i2c_read(TWL_MODULE_RTC, rtc_data,
-			       REG_SECONDS_REG, ALL_TIME_REGS);
+			(rtc_reg_map[REG_SECONDS_REG]), ALL_TIME_REGS);
 
 	if (ret < 0) {
 		dev_err(dev, "rtc_read_time error %d\n", ret);
@@ -244,7 +293,7 @@ static int twl_rtc_set_time(struct device *dev, struct rtc_time *tm)
 
 	/* update all the time registers in one shot */
 	ret = twl_i2c_write(TWL_MODULE_RTC, rtc_data,
-			REG_SECONDS_REG, ALL_TIME_REGS);
+		(rtc_reg_map[REG_SECONDS_REG]), ALL_TIME_REGS);
 	if (ret < 0) {
 		dev_err(dev, "rtc_set_time error %d\n", ret);
 		goto out;
@@ -267,7 +316,7 @@ static int twl_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	int ret;
 
 	ret = twl_i2c_read(TWL_MODULE_RTC, rtc_data,
-			       REG_ALARM_SECONDS_REG, ALL_TIME_REGS);
+			(rtc_reg_map[REG_ALARM_SECONDS_REG]), ALL_TIME_REGS);
 	if (ret < 0) {
 		dev_err(dev, "rtc_read_alarm error %d\n", ret);
 		return ret;
@@ -306,7 +355,7 @@ static int twl_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 
 	/* update all the alarm registers in one shot */
 	ret = twl_i2c_write(TWL_MODULE_RTC, alarm_data,
-			REG_ALARM_SECONDS_REG, ALL_TIME_REGS);
+		(rtc_reg_map[REG_ALARM_SECONDS_REG]), ALL_TIME_REGS);
 	if (ret) {
 		dev_err(dev, "rtc_set_alarm error %d\n", ret);
 		goto out;
@@ -352,6 +401,7 @@ static irqreturn_t twl_rtc_interrupt(int irq, void *rtc)
 	if (res)
 		goto out;
 
+if (is_class_twl4030()) {
 	/* Clear on Read enabled. RTC_IT bit of TWL4030_INT_PWR_ISR1
 	 * needs 2 reads to clear the interrupt. One read is done in
 	 * do_twl_pwrirq(). Doing the second read, to clear
@@ -367,6 +417,8 @@ static irqreturn_t twl_rtc_interrupt(int irq, void *rtc)
 			&rd_reg, TWL4030_INT_PWR_ISR1);
 	if (res)
 		goto out;
+}
+
 
 	/* Notify RTC core on event */
 	rtc_update_irq(rtc, 1, events);
@@ -438,7 +490,7 @@ static int __devinit twl_rtc_probe(struct platform_device *pdev)
 		goto out2;
 
 	if (!(rd_reg & BIT_RTC_CTRL_REG_STOP_RTC_M)) {
-		dev_info(&pdev->dev, "Enabling TWL4030-RTC.\n");
+		dev_info(&pdev->dev, "Enabling TWL-RTC.\n");
 		rd_reg = BIT_RTC_CTRL_REG_STOP_RTC_M;
 		ret = twl_rtc_write_u8(rd_reg, REG_RTC_CTRL_REG);
 		if (ret < 0)
@@ -526,6 +578,11 @@ static struct platform_driver twl4030rtc_driver = {
 
 static int __init twl_rtc_init(void)
 {
+	if (is_class_twl4030())
+		rtc_reg_map = (u8 *) twl4030_rtc_reg_map;
+	else
+		rtc_reg_map = (u8 *) twl6030_rtc_reg_map;
+
 	return platform_driver_register(&twl4030rtc_driver);
 }
 module_init(twl_rtc_init);
-- 
1.5.4.7
