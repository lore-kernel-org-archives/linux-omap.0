From: chudson@kionix.com
Subject: [RFC PATCH v3 1/3] input:misc:driver support for Kionix kxte9 accelerometer
Date: Mon, 30 Nov 2009 09:42:54 -0500
Message-ID: <1259592176-18634-1-git-send-email-chudson@kionix.com>
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-omap@vger.kernel.org, dmitry.torokhov@gmail.com, jic23@cam.ac.uk, Chris Hudson <chudson@kionix.com>
List-Id: linux-omap@vger.kernel.org

From: Chris Hudson <chudson@kionix.com>

This is a request for comments regarding adding driver support for the Kionix 
KXTE9 digital tri-axis accelerometer.  This part features built-in tilt 
position (orientation), wake-up and back-to-sleep algorithms, which can trigger 
a user-configurable physical interrupt.  The driver uses i2c for device 
communication, input nodes for reporting acceleration data and interrupt status
information, and sysfs for userspace communication.

Changes in this version:
*added odr_table description
*removed global misc structure
*removed extraneous retries from i2c read and write functions
*removed extraneous variable assignments
*removed extraneous gpio_get_value conditional in irq_work function
*combined data formatting lines in get_acceleration_data
*migrated all ioctls to sysfs
*removed validate_pdata function
*renamed input_dev from "accelerometer" to "kxte9_accel"
*switched to use kernel workqueue instead of creating a new one
*added some documentation to kxte9.h

Signed-off-by: Chris Hudson <chudson@kionix.com>
---
 drivers/input/misc/Kconfig  |   10 +
 drivers/input/misc/Makefile |    1 +
 drivers/input/misc/kxte9.c  |  910 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/kxte9.h       |   95 +++++
 4 files changed, 1016 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/misc/kxte9.c
 create mode 100644 include/linux/kxte9.h

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index a9bb254..a1afad1 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -317,4 +317,14 @@ config INPUT_PCAP
 	  To compile this driver as a module, choose M here: the
 	  module will be called pcap_keys.
 
+config INPUT_KXTE9
+	tristate "Kionix KXTE9 digital tri-axis accelerometer"
+	depends on I2C
+	help
+	  If you say yes here you get support for the Kionix KXTE9 digital
+	  tri-axis accelerometer.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called kxte9.
+
 endif
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index a8b8485..67cae95 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_INPUT_DM355EVM)		+= dm355evm_keys.o
 obj-$(CONFIG_HP_SDC_RTC)		+= hp_sdc_rtc.o
 obj-$(CONFIG_INPUT_IXP4XX_BEEPER)	+= ixp4xx-beeper.o
 obj-$(CONFIG_INPUT_KEYSPAN_REMOTE)	+= keyspan_remote.o
+obj-$(CONFIG_INPUT_KXTE9)		+= kxte9.o
 obj-$(CONFIG_INPUT_M68K_BEEP)		+= m68kspkr.o
 obj-$(CONFIG_INPUT_PCAP)		+= pcap_keys.o
 obj-$(CONFIG_INPUT_PCF50633_PMU)	+= pcf50633-input.o
diff --git a/drivers/input/misc/kxte9.c b/drivers/input/misc/kxte9.c
new file mode 100644
index 0000000..6e1962e
--- /dev/null
+++ b/drivers/input/misc/kxte9.c
@@ -0,0 +1,910 @@
+/*
+ * Copyright (C) 2009 Kionix, Inc.
+ * Written by Chris Hudson <chudson@kionix.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+ * 02111-1307, USA
+ */
+
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/fs.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/uaccess.h>
+#include <linux/workqueue.h>
+#include <linux/irq.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/kxte9.h>
+
+#define NAME			"kxte9"
+#define G_MAX			2000
+/* OUTPUT REGISTERS */
+#define XOUT			0x12
+#define INT_STATUS_REG		0x16
+#define INT_SRC_REG2		0x17
+#define TILT_POS_CUR		0x10
+#define TILT_POS_PRE		0x11
+#define INT_REL			0x1A
+/* CONTROL REGISTERS */
+#define CTRL_REG1		0x1B
+#define CTRL_REG3		0x1D
+#define INT_CTRL1		0x1E
+#define TILT_TIMER		0x28
+#define WUF_TIMER		0x29
+#define B2S_TIMER		0x2A
+#define WUF_THRESH		0x5A
+#define B2S_THRESH		0x5B
+/* CONTROL REGISTER 1 BITS */
+#define PC1_OFF			0x00
+#define PC1_ON			0x80
+/* INTERRUPT SOURCE 1 BITS */
+#define TPS			0x01
+#define WUFS			0x02
+#define B2SS			0x04
+/* INPUT_ABS CONSTANTS */
+#define FUZZ			32
+#define FLAT			32
+/* RESUME STATE INDICES */
+#define RES_CTRL_REG1		0
+#define RES_CTRL_REG3		1
+#define RES_INT_CTRL1		2
+#define RES_TILT_TIMER		3
+#define RES_WUF_TIMER		4
+#define RES_B2S_TIMER		5
+#define RES_WUF_THRESH		6
+#define RES_B2S_THRESH		7
+#define RES_CURRENT_ODR		8
+#define RESUME_ENTRIES		9
+
+/*
+ * The following table lists the maximum appropriate poll interval for each
+ * available output data rate.
+ */
+static struct {
+	unsigned int cutoff;
+	u8 mask;
+} kxte9_odr_table[] = {
+	{
+	25,	ODR125}, {
+	100,	ODR40}, {
+	334,	ODR10}, {
+	1000,	ODR3}, {
+	0,	ODR1},};
+
+struct kxte9_data {
+	struct i2c_client *client;
+	struct kxte9_platform_data *pdata;
+	struct mutex lock;
+	struct delayed_work input_work;
+	struct input_dev *input_dev;
+	struct work_struct irq_work;
+
+	int hw_initialized;
+	atomic_t enabled;
+	u8 resume_state[RESUME_ENTRIES];
+	int res_interval;
+	int irq;
+};
+
+static int kxte9_i2c_read(struct kxte9_data *te9, u8 *buf, int len)
+{
+	int err;
+
+	struct i2c_msg msgs[] = {
+		{
+		 .addr = te9->client->addr,
+		 .flags = te9->client->flags & I2C_M_TEN,
+		 .len = 1,
+		 .buf = buf,
+		 },
+		{
+		 .addr = te9->client->addr,
+		 .flags = (te9->client->flags & I2C_M_TEN) | I2C_M_RD,
+		 .len = len,
+		 .buf = buf,
+		 },
+	};
+	err = i2c_transfer(te9->client->adapter, msgs, 2);
+
+	if (err != 2)
+		dev_err(&te9->client->dev, "read transfer error\n");
+	else
+		err = 0;
+
+	return err;
+}
+
+static int kxte9_i2c_write(struct kxte9_data *te9, u8 * buf, int len)
+{
+	int err;
+
+	struct i2c_msg msgs[] = {
+		{
+		 .addr = te9->client->addr,
+		 .flags = te9->client->flags & I2C_M_TEN,
+		 .len = len + 1,
+		 .buf = buf,
+		 },
+	};
+	err = i2c_transfer(te9->client->adapter, msgs, 1);
+
+	if (err != 1)
+		dev_err(&te9->client->dev, "write transfer error\n");
+	else
+		err = 0;
+
+	return err;
+}
+
+static int kxte9_hw_init(struct kxte9_data *te9)
+{
+	int err;
+	u8 buf[2] = { CTRL_REG1, PC1_OFF };
+
+	err = kxte9_i2c_write(te9, buf, 1);
+	if (err < 0)
+		return err;
+	buf[0] = CTRL_REG3;
+	buf[1] = te9->resume_state[RES_CTRL_REG3];
+	err = kxte9_i2c_write(te9, buf, 1);
+	if (err < 0)
+		return err;
+	buf[0] = INT_CTRL1;
+	buf[1] = te9->resume_state[RES_INT_CTRL1];
+	err = kxte9_i2c_write(te9, buf, 1);
+	if (err < 0)
+		return err;
+	buf[0] = TILT_TIMER;
+	buf[1] = te9->resume_state[RES_TILT_TIMER];
+	err = kxte9_i2c_write(te9, buf, 1);
+	if (err < 0)
+		return err;
+	buf[0] = WUF_TIMER;
+	buf[1] = te9->resume_state[RES_WUF_TIMER];
+	err = kxte9_i2c_write(te9, buf, 1);
+	if (err < 0)
+		return err;
+	buf[0] = B2S_TIMER;
+	buf[1] = te9->resume_state[RES_B2S_TIMER];
+	err = kxte9_i2c_write(te9, buf, 1);
+	if (err < 0)
+		return err;
+	buf[0] = WUF_THRESH;
+	buf[1] = te9->resume_state[RES_WUF_THRESH];
+	err = kxte9_i2c_write(te9, buf, 1);
+	if (err < 0)
+		return err;
+	buf[0] = B2S_THRESH;
+	buf[1] = te9->resume_state[RES_B2S_THRESH];
+	err = kxte9_i2c_write(te9, buf, 1);
+	if (err < 0)
+		return err;
+	buf[0] = CTRL_REG1;
+	buf[1] = (te9->resume_state[RES_CTRL_REG1] | PC1_ON);
+	err = kxte9_i2c_write(te9, buf, 1);
+	if (err < 0)
+		return err;
+	te9->resume_state[RES_CTRL_REG1] = buf[1];
+	te9->hw_initialized = 1;
+
+	return 0;
+}
+
+static void kxte9_device_power_off(struct kxte9_data *te9)
+{
+	int err;
+	u8 buf[2] = { CTRL_REG1, PC1_OFF };
+
+	err = kxte9_i2c_write(te9, buf, 1);
+	if (err < 0)
+		dev_err(&te9->client->dev, "soft power off failed\n");
+	disable_irq(te9->irq);
+	if (te9->pdata->power_off)
+		te9->pdata->power_off();
+	te9->hw_initialized = 0;
+}
+
+static int kxte9_device_power_on(struct kxte9_data *te9)
+{
+	int err;
+
+	if (te9->pdata->power_on) {
+		err = te9->pdata->power_on();
+		if (err < 0)
+			return err;
+	}
+	enable_irq(te9->irq);
+	if (!te9->hw_initialized) {
+		mdelay(110);
+		err = kxte9_hw_init(te9);
+		if (err < 0) {
+			kxte9_device_power_off(te9);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static irqreturn_t kxte9_isr(int irq, void *dev)
+{
+	struct kxte9_data *te9 = dev;
+
+	disable_irq_nosync(irq);
+	schedule_work(&te9->irq_work);
+
+	return IRQ_HANDLED;
+}
+
+static u8 kxte9_resolve_dir(struct kxte9_data *te9, u8 dir)
+{
+	switch (dir) {
+	case 0x20:	/* -X */
+		if (te9->pdata->negate_x)
+			dir = 0x10;
+		if (te9->pdata->axis_map_y == 0)
+			dir >>= 2;
+		if (te9->pdata->axis_map_z == 0)
+			dir >>= 4;
+		break;
+	case 0x10:	/* +X */
+		if (te9->pdata->negate_x)
+			dir = 0x20;
+		if (te9->pdata->axis_map_y == 0)
+			dir >>= 2;
+		if (te9->pdata->axis_map_z == 0)
+			dir >>= 4;
+		break;
+	case 0x08:	/* -Y */
+		if (te9->pdata->negate_y)
+			dir = 0x04;
+		if (te9->pdata->axis_map_x == 1)
+			dir <<= 2;
+		if (te9->pdata->axis_map_z == 1)
+			dir >>= 2;
+		break;
+	case 0x04:	/* +Y */
+		if (te9->pdata->negate_y)
+			dir = 0x08;
+		if (te9->pdata->axis_map_x == 1)
+			dir <<= 2;
+		if (te9->pdata->axis_map_z == 1)
+			dir >>= 2;
+		break;
+	case 0x02:	/* -Z */
+		if (te9->pdata->negate_z)
+			dir = 0x01;
+		if (te9->pdata->axis_map_x == 2)
+			dir <<= 4;
+		if (te9->pdata->axis_map_y == 2)
+			dir <<= 2;
+		break;
+	case 0x01:	/* +Z */
+		if (te9->pdata->negate_z)
+			dir = 0x02;
+		if (te9->pdata->axis_map_x == 2)
+			dir <<= 4;
+		if (te9->pdata->axis_map_y == 2)
+			dir <<= 2;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return dir;
+}
+
+static void kxte9_irq_work_func(struct work_struct *work)
+{
+/*
+ *	int_status output:
+ *	[INT_SRC_REG1][INT_SRC_REG2][TILT_POS_PRE][TILT_POS_CUR]
+ *	INT_SRC_REG2, TILT_POS_PRE, and TILT_POS_CUR directions are translated
+ *	based on platform data variables.
+ */
+
+	int err;
+	int i;
+	int int_status = 0;
+	u8 status;
+	u8 b2s_comp;
+	u8 wuf_comp;
+	u8 buf[2];
+
+	struct kxte9_data *te9
+			= container_of(work, struct kxte9_data, irq_work);
+
+	status = INT_STATUS_REG;
+	err = kxte9_i2c_read(te9, &status, 1);
+	if (err < 0)
+		dev_err(&te9->client->dev, "read err int source\n");
+	int_status = status << 24;
+	if ((status & TPS) > 0) {
+		buf[0] = TILT_POS_CUR;
+		err = kxte9_i2c_read(te9, buf, 2);
+		if (err < 0)
+			dev_err(&te9->client->dev, "read err tilt dir\n");
+		int_status |= kxte9_resolve_dir(te9, buf[0]);
+		int_status |= (kxte9_resolve_dir(te9, buf[1])) << 8;
+	}
+	if ((status & WUFS) > 0) {
+		buf[0] = INT_SRC_REG2;
+		err = kxte9_i2c_read(te9, buf, 1);
+		if (err < 0)
+			dev_err(&te9->client->dev, "reading err wuf dir\n");
+		int_status |= (kxte9_resolve_dir(te9, buf[0])) << 16;
+		b2s_comp = (te9->resume_state[RES_CTRL_REG3] & 0x0C) >> 2;
+		wuf_comp = te9->resume_state[RES_CTRL_REG3] & 0x03;
+		if (!te9->resume_state[RES_CURRENT_ODR] &&
+				!(te9->resume_state[RES_CTRL_REG1] & ODR125) &&
+						!(b2s_comp & wuf_comp)) {
+			/* set the new poll interval based on wuf odr */
+			for (i = 1; i < ARRAY_SIZE(kxte9_odr_table); i++) {
+				te9->res_interval =
+						kxte9_odr_table[i - 1].cutoff;
+				if (kxte9_odr_table[i].mask ==	wuf_comp << 3)
+					break;
+			}
+			if (te9->input_dev) {
+				cancel_delayed_work_sync(&te9->input_work);
+				schedule_delayed_work(&te9->input_work,
+						msecs_to_jiffies(te9->
+						res_interval));
+			}
+		}
+	}
+	if ((status & B2SS) > 0) {
+		b2s_comp = (te9->resume_state[RES_CTRL_REG3] & 0x0C) >> 2;
+		wuf_comp = te9->resume_state[RES_CTRL_REG3] & 0x03;
+		if (!te9->resume_state[RES_CURRENT_ODR] &&
+				!(te9->resume_state[RES_CTRL_REG1] & ODR125) &&
+						!(b2s_comp & wuf_comp)) {
+			/* set the new poll interval based on b2s odr */
+			for (i = 1; i < ARRAY_SIZE(kxte9_odr_table); i++) {
+				te9->res_interval =
+						kxte9_odr_table[i - 1].cutoff;
+				if (kxte9_odr_table[i].mask == b2s_comp << 3)
+						break;
+			}
+			if (te9->input_dev) {
+				cancel_delayed_work_sync(&te9->input_work);
+				schedule_delayed_work(&te9->input_work,
+						msecs_to_jiffies(te9->
+						res_interval));
+			}
+		}
+	}
+	input_report_abs(te9->input_dev, ABS_MISC, int_status);
+	input_sync(te9->input_dev);
+	buf[0] = INT_REL;
+	err = kxte9_i2c_read(te9, buf, 1);
+	if (err < 0)
+		dev_err(&te9->client->dev, "error clearing interrupt\n");
+	enable_irq(te9->irq);
+}
+
+static int kxte9_update_odr(struct kxte9_data *te9, int poll_interval)
+{
+	int err = -1;
+	int i;
+	u8 config[2];
+
+	/*
+	 *  Convert the poll interval into an output data rate configuration
+	 *  that is as low as possible.  The ordering of these checks must be
+	 *  maintained due to the cascading cut off values - poll intervals are
+	 *  checked from shortest to longest.  At each check, if the next lower
+	 *  ODR cannot support the current poll interval, we stop searching
+	 */
+	for (i = 0; i < ARRAY_SIZE(kxte9_odr_table); i++) {
+		config[1] = kxte9_odr_table[i].mask;
+		if (poll_interval < kxte9_odr_table[i].cutoff)
+			break;
+	}
+
+	if (atomic_read(&te9->enabled)) {
+		config[0] = CTRL_REG1;
+		config[1] |= (te9->resume_state[RES_CTRL_REG1] & ~ODR40);
+		err = kxte9_i2c_write(te9, config, 1);
+		if (err < 0)
+			return err;
+		/*
+		 *  Latch on input_dev - indicates that kxte9_input_init passed
+		 *  and this workqueue is available
+		 */
+		if (te9->input_dev) {
+			cancel_delayed_work_sync(&te9->input_work);
+			schedule_delayed_work(&te9->input_work,
+					msecs_to_jiffies(poll_interval));
+		}
+	}
+	te9->resume_state[RES_CTRL_REG1] = config[1];
+
+	return 0;
+}
+
+static int kxte9_get_acceleration_data(struct kxte9_data *te9, int *xyz)
+{
+	int err;
+	/* Data bytes from hardware x, y, z */
+	u8 acc_data[3] = { XOUT };
+	/* x,y,z hardware values */
+	int hw_d[3];
+
+	err = kxte9_i2c_read(te9, acc_data, 3);
+	if (err < 0)
+		return err;
+
+	hw_d[0] = ((int)(acc_data[0] >> 2) - 32) << 6;
+	hw_d[1] = ((int)(acc_data[1] >> 2) - 32) << 6;
+	hw_d[2] = ((int)(acc_data[2] >> 2) - 32) << 6;
+
+	xyz[0] = ((te9->pdata->negate_x) ? (-hw_d[te9->pdata->axis_map_x])
+		  : (hw_d[te9->pdata->axis_map_x]));
+	xyz[1] = ((te9->pdata->negate_y) ? (-hw_d[te9->pdata->axis_map_y])
+		  : (hw_d[te9->pdata->axis_map_y]));
+	xyz[2] = ((te9->pdata->negate_z) ? (-hw_d[te9->pdata->axis_map_z])
+		  : (hw_d[te9->pdata->axis_map_z]));
+
+	return err;
+}
+
+static void kxte9_report_values(struct kxte9_data *te9, int *xyz)
+{
+	input_report_abs(te9->input_dev, ABS_X, xyz[0]);
+	input_report_abs(te9->input_dev, ABS_Y, xyz[1]);
+	input_report_abs(te9->input_dev, ABS_Z, xyz[2]);
+	input_sync(te9->input_dev);
+}
+
+static int kxte9_enable(struct kxte9_data *te9)
+{
+	int err;
+	int int_status = 0;
+	u8 buf;
+
+	if (!atomic_cmpxchg(&te9->enabled, 0, 1)) {
+		err = kxte9_device_power_on(te9);
+		buf = INT_REL;
+		err = kxte9_i2c_read(te9, &buf, 1);
+		if (err < 0) {
+			dev_err(&te9->client->dev,
+					"error clearing interrupt: %d\n", err);
+			atomic_set(&te9->enabled, 0);
+			return err;
+		}
+		if ((te9->resume_state[RES_CTRL_REG1] & TPS) > 0) {
+			buf = TILT_POS_CUR;
+			err = kxte9_i2c_read(te9, &buf, 1);
+			if (err < 0)
+				dev_err(&te9->client->dev,
+					"kxte9 error reading current tilt\n");
+			int_status |= kxte9_resolve_dir(te9, buf);
+			input_report_abs(te9->input_dev, ABS_MISC, int_status);
+			input_sync(te9->input_dev);
+		}
+
+		schedule_delayed_work(&te9->input_work, msecs_to_jiffies(te9->
+						res_interval));
+	}
+
+	return 0;
+}
+
+static int kxte9_disable(struct kxte9_data *te9)
+{
+	if (atomic_cmpxchg(&te9->enabled, 1, 0)) {
+		cancel_delayed_work_sync(&te9->input_work);
+		kxte9_device_power_off(te9);
+	}
+
+	return 0;
+}
+
+static void kxte9_input_work_func(struct work_struct *work)
+{
+	struct kxte9_data *te9 = container_of((struct delayed_work *)work,
+						struct kxte9_data, input_work);
+	int xyz[3];
+	int err;
+
+	mutex_lock(&te9->lock);
+	err = kxte9_get_acceleration_data(te9, xyz);
+	if (err < 0)
+		dev_err(&te9->client->dev, "get_acceleration_data failed\n");
+	else
+		kxte9_report_values(te9, xyz);
+	schedule_delayed_work(&te9->input_work,
+			      msecs_to_jiffies(te9->res_interval));
+	mutex_unlock(&te9->lock);
+}
+
+static int kxte9_input_open(struct input_dev *input)
+{
+	struct kxte9_data *te9 = input_get_drvdata(input);
+
+	return kxte9_enable(te9);
+}
+
+static void kxte9_input_close(struct input_dev *dev)
+{
+	struct kxte9_data *te9 = input_get_drvdata(dev);
+
+	kxte9_disable(te9);
+}
+
+static int kxte9_input_init(struct kxte9_data *te9)
+{
+	int err;
+
+	INIT_DELAYED_WORK(&te9->input_work, kxte9_input_work_func);
+	te9->input_dev = input_allocate_device();
+	if (!te9->input_dev) {
+		err = -ENOMEM;
+		dev_err(&te9->client->dev, "input device allocate failed\n");
+		goto err0;
+	}
+	te9->input_dev->open = kxte9_input_open;
+	te9->input_dev->close = kxte9_input_close;
+
+	input_set_drvdata(te9->input_dev, te9);
+
+	set_bit(EV_ABS, te9->input_dev->evbit);
+	set_bit(ABS_MISC, te9->input_dev->absbit);
+
+	input_set_abs_params(te9->input_dev, ABS_X, -G_MAX, G_MAX, FUZZ, FLAT);
+	input_set_abs_params(te9->input_dev, ABS_Y, -G_MAX, G_MAX, FUZZ, FLAT);
+	input_set_abs_params(te9->input_dev, ABS_Z, -G_MAX, G_MAX, FUZZ, FLAT);
+
+	te9->input_dev->name = "kxte9_accel";
+
+	err = input_register_device(te9->input_dev);
+	if (err) {
+		dev_err(&te9->client->dev,
+			"unable to register input polled device %s\n",
+			te9->input_dev->name);
+		goto err1;
+	}
+
+	return 0;
+err1:
+	input_free_device(te9->input_dev);
+err0:
+	return err;
+}
+
+static void kxte9_input_cleanup(struct kxte9_data *te9)
+{
+	input_unregister_device(te9->input_dev);
+}
+
+/* sysfs */
+static ssize_t kxte9_delay_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct kxte9_data *te9 = i2c_get_clientdata(client);
+	return sprintf(buf, "%d\n", te9->res_interval);
+}
+
+static ssize_t kxte9_delay_store(struct device *dev,
+					struct device_attribute *attr,
+						const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct kxte9_data *te9 = i2c_get_clientdata(client);
+	int val = simple_strtoul(buf, NULL, 10);
+	u8 ctrl[2];
+
+	te9->res_interval = max(val, te9->pdata->min_interval);
+	kxte9_update_odr(te9, te9->res_interval);
+	ctrl[0] = CTRL_REG3;
+	ctrl[1] = te9->resume_state[RES_CTRL_REG1] & 0x18;
+	te9->resume_state[RES_CURRENT_ODR] = ctrl[1];
+	/* All ODRs are changed when this method is used. */
+	ctrl[1] = (ctrl[1] >> 1) | (ctrl[1] >> 3);
+	kxte9_i2c_write(te9, ctrl, 1);
+	te9->resume_state[RES_CTRL_REG3] = ctrl[1];
+	return count;
+}
+
+static ssize_t kxte9_enable_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct kxte9_data *te9 = i2c_get_clientdata(client);
+	return sprintf(buf, "%d\n", atomic_read(&te9->enabled));
+}
+
+static ssize_t kxte9_enable_store(struct device *dev,
+					struct device_attribute *attr,
+						const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct kxte9_data *te9 = i2c_get_clientdata(client);
+	int val = simple_strtoul(buf, NULL, 10);
+	if (val)
+		kxte9_enable(te9);
+	else
+		kxte9_disable(te9);
+	return count;
+}
+
+static ssize_t kxte9_tilt_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct kxte9_data *te9 = i2c_get_clientdata(client);
+	u8 ctrl = TILT_POS_CUR;
+
+	if (te9->resume_state[RES_CTRL_REG1] & TPE) {
+		kxte9_i2c_read(te9, &ctrl, 1);
+		return sprintf(buf, "%d\n", kxte9_resolve_dir(te9, ctrl));
+	} else {
+		return sprintf(buf, "%d\n", 0);
+	}
+}
+
+static ssize_t kxte9_tilt_store(struct device *dev,
+					struct device_attribute *attr,
+						const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct kxte9_data *te9 = i2c_get_clientdata(client);
+	int val = simple_strtoul(buf, NULL, 10);
+	u8 ctrl[2] = { CTRL_REG1 };
+	if (val)
+		te9->resume_state[RES_CTRL_REG1] |= TPE;
+	else
+		te9->resume_state[RES_CTRL_REG1] &= (~TPE);
+	ctrl[1] = te9->resume_state[RES_CTRL_REG1];
+	kxte9_i2c_write(te9, ctrl, 1);
+	return count;
+}
+
+static ssize_t kxte9_wake_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct kxte9_data *te9 = i2c_get_clientdata(client);
+	u8 val = te9->resume_state[RES_CTRL_REG1] & WUFE;
+	if (val)
+		return sprintf(buf, "%d\n", 1);
+	else
+		return sprintf(buf, "%d\n", 0);
+}
+
+static ssize_t kxte9_wake_store(struct device *dev,
+					struct device_attribute *attr,
+						const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct kxte9_data *te9 = i2c_get_clientdata(client);
+	int val = simple_strtoul(buf, NULL, 10);
+	u8 ctrl[2] = { CTRL_REG1 };
+	if (val)
+		te9->resume_state[RES_CTRL_REG1] |= (WUFE | B2SE);
+	else
+		te9->resume_state[RES_CTRL_REG1] &= (~WUFE & ~B2SE);
+	ctrl[1] = te9->resume_state[RES_CTRL_REG1];
+	kxte9_i2c_write(te9, ctrl, 1);
+	return count;
+}
+
+static ssize_t kxte9_selftest_store(struct device *dev,
+					struct device_attribute *attr,
+						const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct kxte9_data *te9 = i2c_get_clientdata(client);
+	int val = simple_strtoul(buf, NULL, 10);
+	u8 ctrl[2] = { 0x3A };
+	if (val)
+		ctrl[1] = 0xCA;
+	else
+		ctrl[1] = 0x00;
+	kxte9_i2c_write(te9, ctrl, 1);
+	return count;
+}
+
+static DEVICE_ATTR(delay, S_IRUGO|S_IWUSR, kxte9_delay_show, kxte9_delay_store);
+static DEVICE_ATTR(enable, S_IRUGO|S_IWUSR, kxte9_enable_show,
+						kxte9_enable_store);
+static DEVICE_ATTR(tilt, S_IRUGO|S_IWUSR, kxte9_tilt_show, kxte9_tilt_store);
+static DEVICE_ATTR(wake, S_IRUGO|S_IWUSR, kxte9_wake_show, kxte9_wake_store);
+static DEVICE_ATTR(selftest, S_IWUSR, NULL, kxte9_selftest_store);
+
+static struct attribute *kxte9_attributes[] = {
+	&dev_attr_delay.attr,
+	&dev_attr_enable.attr,
+	&dev_attr_tilt.attr,
+	&dev_attr_wake.attr,
+	&dev_attr_selftest.attr,
+	NULL
+};
+
+static struct attribute_group kxte9_attribute_group = {
+	.attrs = kxte9_attributes
+};
+/* /sysfs */
+
+static int __devinit kxte9_probe(struct i2c_client *client,
+						const struct i2c_device_id *id)
+{
+	int err = -1;
+	struct kxte9_data *te9 = kzalloc(sizeof(*te9), GFP_KERNEL);
+	if (te9 == NULL) {
+		dev_err(&client->dev,
+			"failed to allocate memory for module data\n");
+		err = -ENOMEM;
+		goto err0;
+	}
+	if (client->dev.platform_data == NULL) {
+		dev_err(&client->dev, "platform data is NULL. exiting.\n");
+		err = -ENODEV;
+		goto err0;
+	}
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+		dev_err(&client->dev, "client not i2c capable\n");
+		err = -ENODEV;
+		goto err0;
+	}
+	mutex_init(&te9->lock);
+	mutex_lock(&te9->lock);
+	te9->client = client;
+	i2c_set_clientdata(client, te9);
+
+	INIT_WORK(&te9->irq_work, kxte9_irq_work_func);
+	te9->pdata = kmalloc(sizeof(*te9->pdata), GFP_KERNEL);
+	if (te9->pdata == NULL)
+		goto err1;
+
+	err = sysfs_create_group(&client->dev.kobj, &kxte9_attribute_group);
+	if (err)
+		goto err1;
+
+	memcpy(te9->pdata, client->dev.platform_data, sizeof(*te9->pdata));
+	if (te9->pdata->init) {
+		err = te9->pdata->init();
+		if (err < 0)
+			goto err2;
+	}
+
+	te9->irq = gpio_to_irq(te9->pdata->gpio);
+
+	memset(te9->resume_state, 0, ARRAY_SIZE(te9->resume_state));
+	te9->resume_state[RES_CTRL_REG1]    = te9->pdata->ctrl_reg1_init;
+	te9->resume_state[RES_CTRL_REG3]    = te9->pdata->engine_odr_init;
+	te9->resume_state[RES_INT_CTRL1]    = te9->pdata->int_ctrl_init;
+	te9->resume_state[RES_TILT_TIMER]   = te9->pdata->tilt_timer_init;
+	te9->resume_state[RES_WUF_TIMER]    = te9->pdata->wuf_timer_init;
+	te9->resume_state[RES_B2S_TIMER]    = te9->pdata->b2s_timer_init;
+	te9->resume_state[RES_WUF_THRESH]   = te9->pdata->wuf_thresh_init;
+	te9->resume_state[RES_B2S_THRESH]   = te9->pdata->b2s_thresh_init;
+	te9->res_interval		    = te9->pdata->poll_interval;
+
+	err = kxte9_device_power_on(te9);
+	if (err < 0)
+		goto err3;
+	atomic_set(&te9->enabled, 1);
+	err = kxte9_update_odr(te9, te9->res_interval);
+	if (err < 0) {
+		dev_err(&client->dev, "update_odr failed\n");
+		goto err4;
+	}
+	err = kxte9_input_init(te9);
+	if (err < 0)
+		goto err4;
+
+	kxte9_device_power_off(te9);
+	atomic_set(&te9->enabled, 0);
+	err = request_irq(te9->irq, kxte9_isr,
+			IRQF_TRIGGER_RISING | IRQF_DISABLED, "kxte9_irq", te9);
+	if (err < 0) {
+		pr_err("%s: request irq failed: %d\n", __func__, err);
+		goto err5;
+	}
+	disable_irq_nosync(te9->irq);
+
+	mutex_unlock(&te9->lock);
+
+	return 0;
+
+err5:
+	kxte9_input_cleanup(te9);
+err4:
+	kxte9_device_power_off(te9);
+err3:
+	if (te9->pdata->exit)
+		te9->pdata->exit();
+err2:
+	kfree(te9->pdata);
+	sysfs_remove_group(&client->dev.kobj, &kxte9_attribute_group);
+err1:
+	mutex_unlock(&te9->lock);
+	kfree(te9);
+err0:
+	return err;
+}
+
+static int __devexit kxte9_remove(struct i2c_client *client)
+{
+	struct kxte9_data *te9 = i2c_get_clientdata(client);
+
+	free_irq(te9->irq, te9);
+	gpio_free(te9->pdata->gpio);
+	kxte9_input_cleanup(te9);
+	kxte9_device_power_off(te9);
+	if (te9->pdata->exit)
+		te9->pdata->exit();
+	kfree(te9->pdata);
+	sysfs_remove_group(&client->dev.kobj, &kxte9_attribute_group);
+	kfree(te9);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int kxte9_resume(struct i2c_client *client)
+{
+	struct kxte9_data *te9 = i2c_get_clientdata(client);
+
+	return kxte9_enable(te9);
+}
+
+static int kxte9_suspend(struct i2c_client *client, pm_message_t mesg)
+{
+	struct kxte9_data *te9 = i2c_get_clientdata(client);
+
+	return kxte9_disable(te9);
+}
+#endif
+
+static const struct i2c_device_id kxte9_id[] = {
+	{NAME, 0},
+	{},
+};
+
+MODULE_DEVICE_TABLE(i2c, kxte9_id);
+
+static struct i2c_driver kxte9_driver = {
+	.driver = {
+		   .name = NAME,
+		   },
+	.probe = kxte9_probe,
+	.remove = __devexit_p(kxte9_remove),
+	.resume = kxte9_resume,
+	.suspend = kxte9_suspend,
+	.id_table = kxte9_id,
+};
+
+static int __init kxte9_init(void)
+{
+	return i2c_add_driver(&kxte9_driver);
+}
+
+static void __exit kxte9_exit(void)
+{
+	i2c_del_driver(&kxte9_driver);
+}
+
+module_init(kxte9_init);
+module_exit(kxte9_exit);
+
+MODULE_DESCRIPTION("KXTE9 accelerometer driver");
+MODULE_AUTHOR("Chris Hudson <chudson@kionix.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/kxte9.h b/include/linux/kxte9.h
new file mode 100644
index 0000000..77b1a69
--- /dev/null
+++ b/include/linux/kxte9.h
@@ -0,0 +1,95 @@
+/*
+ * Copyright (c) 2009, Kionix, Inc. All Rights Reserved.
+ * Written by Chris Hudson <chudson@kionix.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 3 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <linux/ioctl.h>  /* For IOCTL macros */
+
+#ifndef __KXTE9_H__
+#define __KXTE9_H__
+
+#define KXTE9_IOCTL_BASE 77
+/** The following define the IOCTL command values via the ioctl macros */
+#define KXTE9_IOCTL_SET_DELAY		_IOW(KXTE9_IOCTL_BASE, 0, int)
+#define KXTE9_IOCTL_GET_DELAY		_IOR(KXTE9_IOCTL_BASE, 1, int)
+#define KXTE9_IOCTL_SET_ENABLE		_IOW(KXTE9_IOCTL_BASE, 2, int)
+#define KXTE9_IOCTL_GET_ENABLE		_IOR(KXTE9_IOCTL_BASE, 3, int)
+#define KXTE9_IOCTL_SET_TILT_ENABLE	_IOW(KXTE9_IOCTL_BASE, 5, int)
+#define KXTE9_IOCTL_SET_B2S_ENABLE	_IOW(KXTE9_IOCTL_BASE, 6, int)
+#define KXTE9_IOCTL_SET_WAKE_ENABLE	_IOW(KXTE9_IOCTL_BASE, 7, int)
+#define KXTE9_IOCTL_SELF_TEST		_IOW(KXTE9_IOCTL_BASE, 8, int)
+
+#define KXTE9_I2C_ADDR		0x0F
+/* CONTROL REGISTER 1 BITS */
+#define TPE			0x01	/* tilt position function enable bit */
+#define WUFE			0x02	/* wake-up function enable bit */
+#define B2SE			0x04	/* back-to-sleep function enable bit */
+#define ODR125			0x20	/* 125Hz ODR mode */
+#define ODR40			0x18	/* initial ODR masks */
+#define ODR10			0x10
+#define ODR3			0x08
+#define ODR1			0x00
+/* CONTROL REGISTER 3 BITS */
+#define OB2S40			0x0C	/* back-to-sleep ODR masks */
+#define OB2S10			0x08
+#define OB2S3			0x04
+#define OB2S1			0x00
+#define OWUF40			0x03	/* wake-up ODR masks */
+#define OWUF10			0x02
+#define OWUF3			0x01
+#define OWUF1			0x00
+/* INTERRUPT CONTROL REGISTER 1 BITS */
+#define KXTE9_IEN		0x10	/* interrupt enable */
+#define KXTE9_IEA		0x08	/* interrupt polarity */
+#define KXTE9_IEL		0x04	/* interrupt response */
+
+#ifdef __KERNEL__
+struct kxte9_platform_data {
+	int poll_interval;
+	int min_interval;
+	/* the desired g-range, in milli-g (always 2000 for kxte9) */
+	u8 g_range;
+	/* used to compensate for alternate device placement within the host */
+	u8 axis_map_x;
+	u8 axis_map_y;
+	u8 axis_map_z;
+	/* used to compensate for alternate device placement within the host */
+	u8 negate_x;
+	u8 negate_y;
+	u8 negate_z;
+
+	/* initial configuration values, set during board configuration */
+	u8 ctrl_reg1_init;
+	u8 engine_odr_init;
+	u8 int_ctrl_init;
+	u8 tilt_timer_init;
+	u8 wuf_timer_init;
+	u8 b2s_timer_init;
+	u8 wuf_thresh_init;
+	u8 b2s_thresh_init;
+
+	int (*init)(void);
+	void (*exit)(void);
+	int (*power_on)(void);
+	int (*power_off)(void);
+
+	int gpio;
+};
+#endif /* __KERNEL__ */
+
+#endif  /* __KXTE9_H__ */
+
-- 
1.5.4.3

