From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH] Driver for omap34xx temperature sensor.
Date: Mon, 19 May 2008 16:56:29 +0300
Message-ID: <20080519135629.GB5040@codecarver.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:17389 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760008AbYESN6t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2008 09:58:49 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4JDwIGL024104
	for <linux-omap@vger.kernel.org>; Mon, 19 May 2008 16:58:47 +0300
Received: from codecarver.research.nokia.com (esdhcp04317.research.nokia.com [172.21.43.17])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m4JDuT5J015236
	for <linux-omap@vger.kernel.org>; Mon, 19 May 2008 16:56:29 +0300
Received: from p2 by codecarver.research.nokia.com with local (Exim 4.69)
	(envelope-from <p2@codecarver.research.nokia.com>)
	id 1Jy5qn-0005ya-JT
	for linux-omap@vger.kernel.org; Mon, 19 May 2008 16:56:29 +0300
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

This patch adds a hwmon driver for the OMAP34xx internal temperature
sensor. I get unusually high values (80 degrees and more) from this
sensor though. 

Comments welcome.

Cheers,

Peter.

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 drivers/hwmon/Kconfig         |    4 +
 drivers/hwmon/Makefile        |    1 +
 drivers/hwmon/omap34xx_temp.c |  266 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 271 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hwmon/omap34xx_temp.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 90c6812..3e42df6 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -797,6 +797,10 @@ config SENSORS_TSC210X
 	  This driver can also be built as a module.  In this case
 	  the module will be called tsc210x_sensors.
 
+config SENSORS_OMAP34XX
+	tristate "TI OMAP34xx internal temperature sensor"
+	depends on ARCH_OMAP3 && HIGH_RES_TIMERS
+
 config HWMON_DEBUG_CHIP
 	bool "Hardware Monitoring Chip debugging messages"
 	default n
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 8e401f2..565303f 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_SENSORS_W83627EHF)	+= w83627ehf.o
 obj-$(CONFIG_SENSORS_W83L785TS)	+= w83l785ts.o
 obj-$(CONFIG_SENSORS_TSC210X)	+= tsc210x_sensors.o
 obj-$(CONFIG_SENSORS_W83L786NG)	+= w83l786ng.o
+obj-$(CONFIG_SENSORS_OMAP34XX)  += omap34xx_temp.o
 
 ifeq ($(CONFIG_HWMON_DEBUG_CHIP),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/drivers/hwmon/omap34xx_temp.c b/drivers/hwmon/omap34xx_temp.c
new file mode 100644
index 0000000..8cd2f8c
--- /dev/null
+++ b/drivers/hwmon/omap34xx_temp.c
@@ -0,0 +1,266 @@
+/*
+ * omap34xx_temp.c - Linux kernem module for OMAP34xx hardware monitoring
+ *
+ * Copyright (C) 2008 Nokia Corporation
+ *
+ * Written by Peter De Schrijver <peter.de-schrijver@nokia.com>
+ *
+ * Inspired by k8temp.c
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License. See the file "COPYING" in the main directory of this
+ * archive for more details.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/clk.h>
+#include <linux/hrtimer.h>
+#include <linux/module.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <asm/arch/omap34xx.h>
+
+#define SCM_CONTROL_TEMP_SENSOR	(OMAP343X_SCM_BASE + 0x524)
+#define CM_FCLKEN3_CORE (OMAP3430_CM_BASE + 0x200 + 0x8)
+#define TEMP_SENSOR_SOC (1<<8)
+#define TEMP_SENSOR_EOCZ (1<<7)
+
+/* minimum delay for EOCZ rise after SOC rise is
+ * 11 cycles of the 32Khz clock */
+#define EOCZ_MIN_RISING_DELAY (11 * 31250)
+
+/* maximum delay for EOCZ rise after SOC rise is
+ * 16 cycles of the 32Khz clock */
+#define EOCZ_MAX_RISING_DELAY (16 * 31250)
+
+/* minimum delay for EOCZ falling is
+ * 36 cycles of the 32Khz clock */
+#define EOCZ_MIN_FALLING_DELAY (36 * 31250)
+
+/* maximum delay for EOCZ falling is
+ * 42 cycles of the 32Khz clock */
+#define EOCZ_MAX_FALLING_DELAY (42 * 31250)
+
+struct omap34xx_data {
+	struct device *hwmon_dev;
+	struct clk *clk_32k;
+	struct mutex update_lock;
+	const char *name;
+	char valid;
+	unsigned long last_updated;
+
+	u32 temp;
+};
+
+static struct platform_device omap34xx_temp_device = {
+	.name 	= "omap34xx_temp",
+	.id	= -1,
+};
+
+static int adc_to_temp[] = {
+	-40, -40, -40, -40, -40, -39, -38, -36, -34, -32, -31, -29, -28, -26,
+	-25, -24, -22, -21, -19, -18, -17, -15, -14, -12, -11, -9, -8, -7, -5,
+	-4, -2, -1, 0, 1, 3, 4, 5, 7, 8, 10, 11, 13, 14, 15, 17, 18, 20, 21,
+	22, 24, 25, 27, 28, 30, 31, 32, 34, 35, 37, 38, 39, 41, 42, 44, 45,
+	47, 48, 49, 51, 52, 53, 55, 56, 58, 59, 60, 62, 63, 65, 66, 67, 69,
+	70, 72, 73, 74, 76, 77, 79, 80, 81, 83, 84, 85, 87, 88, 89, 91, 92,
+	94, 95, 96, 98, 99, 100, 102, 103, 105, 106, 107, 109, 110, 111, 113,
+	114, 116, 117, 118, 120, 121, 122, 124, 124, 125, 125, 125, 125, 125};
+
+static void omap34xx_update(struct omap34xx_data *data)
+{
+	u32 temp_sensor_reg;
+	struct timespec timeout;
+
+	mutex_lock(&data->update_lock);
+
+	if (!data->valid
+	    || time_after(jiffies, data->last_updated + HZ)) {
+
+		ktime_t expire;
+
+		clk_enable(data->clk_32k);
+
+		temp_sensor_reg = omap_readl(SCM_CONTROL_TEMP_SENSOR);
+		temp_sensor_reg |= TEMP_SENSOR_SOC;
+		omap_writel(temp_sensor_reg, SCM_CONTROL_TEMP_SENSOR);
+
+		expire = ktime_add_ns(ktime_get(), EOCZ_MAX_RISING_DELAY);
+		timeout = ns_to_timespec(EOCZ_MIN_RISING_DELAY);
+		hrtimer_nanosleep(&timeout, NULL, HRTIMER_MODE_REL,
+					CLOCK_MONOTONIC);
+		do {
+			temp_sensor_reg = omap_readl(SCM_CONTROL_TEMP_SENSOR);
+			if (temp_sensor_reg & TEMP_SENSOR_EOCZ)
+				break;
+		} while (ktime_us_delta(expire, ktime_get()) > 0);
+
+		if (!(temp_sensor_reg & TEMP_SENSOR_EOCZ))
+			goto err;
+
+		temp_sensor_reg &= ~TEMP_SENSOR_SOC;
+		omap_writel(temp_sensor_reg, SCM_CONTROL_TEMP_SENSOR);
+
+		expire = ktime_add_ns(ktime_get(), EOCZ_MAX_FALLING_DELAY);
+		timeout = ns_to_timespec(EOCZ_MIN_FALLING_DELAY);
+		hrtimer_nanosleep(&timeout, NULL, HRTIMER_MODE_REL,
+					CLOCK_MONOTONIC);
+
+		do {
+			temp_sensor_reg = omap_readl(SCM_CONTROL_TEMP_SENSOR);
+			if (!(temp_sensor_reg & TEMP_SENSOR_EOCZ))
+				break;
+		} while (ktime_us_delta(expire, ktime_get()) > 0);
+
+		if (temp_sensor_reg & TEMP_SENSOR_EOCZ)
+			goto err;
+
+		data->temp = omap_readl(SCM_CONTROL_TEMP_SENSOR) & ((1<<7) - 1);
+		data->last_updated = jiffies;
+		data->valid = 1;
+
+err:
+		clk_disable(data->clk_32k);
+	}
+
+	mutex_unlock(&data->update_lock);
+}
+
+static ssize_t show_name(struct device *dev,
+			struct device_attribute *devattr, char *buf)
+{
+	struct omap34xx_data *data = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n", data->name);
+}
+
+static ssize_t show_temp_raw(struct device *dev,
+			 struct device_attribute *devattr, char *buf)
+{
+	struct omap34xx_data *data = dev_get_drvdata(dev);
+
+	omap34xx_update(data);
+
+	return sprintf(buf, "%d\n", data->temp);
+}
+
+static ssize_t show_temp(struct device *dev,
+			 struct device_attribute *devattr, char *buf)
+{
+	struct omap34xx_data *data = dev_get_drvdata(dev);
+
+	omap34xx_update(data);
+
+	return sprintf(buf, "%d\n", adc_to_temp[data->temp]);
+}
+
+static SENSOR_DEVICE_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 0);
+static SENSOR_DEVICE_ATTR_2(temp1_input_raw, S_IRUGO, show_temp_raw,
+				NULL, 0, 0);
+static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+
+static int __devinit omap34xx_temp_probe(void)
+{
+	int err;
+	struct omap34xx_data *data;
+
+	err = platform_device_register(&omap34xx_temp_device);
+	if (err) {
+		printk(KERN_ERR
+			"Unable to register omap34xx temperature device\n");
+		goto exit;
+	}
+
+	data = kzalloc(sizeof(struct omap34xx_data), GFP_KERNEL);
+	if (!data) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	dev_set_drvdata(&omap34xx_temp_device.dev, data);
+	mutex_init(&data->update_lock);
+	data->name = "omap34xx_temp";
+
+	data->clk_32k = clk_get(&omap34xx_temp_device.dev, "omap_32ksync_ick");
+	if (IS_ERR(data->clk_32k)) {
+		err = PTR_ERR(data->clk_32k);
+		goto exit_free;
+	}
+
+	err = device_create_file(&omap34xx_temp_device.dev,
+				 &sensor_dev_attr_temp1_input.dev_attr);
+	if (err)
+		goto clock_free;
+
+	err = device_create_file(&omap34xx_temp_device.dev,
+				 &sensor_dev_attr_temp1_input_raw.dev_attr);
+	if (err)
+		goto exit_remove;
+
+	err = device_create_file(&omap34xx_temp_device.dev, &dev_attr_name);
+	if (err)
+		goto exit_remove_raw;
+
+	data->hwmon_dev = hwmon_device_register(&omap34xx_temp_device.dev);
+
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
+		goto exit_remove_all;
+	}
+
+	return 0;
+
+exit_remove_all:
+	device_remove_file(&omap34xx_temp_device.dev,
+			   &dev_attr_name);
+exit_remove_raw:
+	device_remove_file(&omap34xx_temp_device.dev,
+			   &sensor_dev_attr_temp1_input_raw.dev_attr);
+exit_remove:
+	device_remove_file(&omap34xx_temp_device.dev,
+			   &sensor_dev_attr_temp1_input.dev_attr);
+clock_free:
+	clk_put(data->clk_32k);
+
+exit_free:
+	kfree(data);
+exit:
+	return err;
+}
+
+static int __init omap34xx_temp_init(void)
+{
+	return omap34xx_temp_probe();
+}
+
+static void __exit omap34xx_temp_exit(void)
+{
+	struct omap34xx_data *data =
+			dev_get_drvdata(&omap34xx_temp_device.dev);
+
+	clk_put(data->clk_32k);
+	hwmon_device_unregister(data->hwmon_dev);
+	device_remove_file(&omap34xx_temp_device.dev,
+			   &sensor_dev_attr_temp1_input.dev_attr);
+	device_remove_file(&omap34xx_temp_device.dev, &dev_attr_name);
+	kfree(data);
+}
+
+MODULE_AUTHOR("Peter De Schrijver");
+MODULE_DESCRIPTION("Omap34xx temperature sensor");
+MODULE_LICENSE("GPL");
+
+module_init(omap34xx_temp_init)
+module_exit(omap34xx_temp_exit)
+
-- 
1.5.3.4

-- 
goa is a state of mind
