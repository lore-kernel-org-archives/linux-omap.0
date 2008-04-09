From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 3/5] INPUT: TOUCHSCREEN: Introduce tsc2005 driver
Date: Wed,  9 Apr 2008 13:09:23 +0300
Message-ID: <1207735765-1356-4-git-send-email-felipe.balbi@nokia.com>
References: <1207735765-1356-1-git-send-email-felipe.balbi@nokia.com>
 <1207735765-1356-2-git-send-email-felipe.balbi@nokia.com>
 <1207735765-1356-3-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:48825 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783AbYDIKK3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Apr 2008 06:10:29 -0400
In-Reply-To: <1207735765-1356-3-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Lauri Leukkunen <lauri.leukkunen@nokia.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Lauri Leukkunen <lauri.leukkunen@nokia.com>

Introduce n810's tsc2005 driver

Signed-off-by: Lauri Leukkunen <lauri.leukkunen@nokia.com>

Updated to build with current linux-omap.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/board-n800.c    |   95 +++++-
 drivers/input/touchscreen/Kconfig   |    5 +
 drivers/input/touchscreen/Makefile  |    1 +
 drivers/input/touchscreen/tsc2005.c |  737 +++++++++++++++++++++++++++++++++++
 include/linux/spi/tsc2005.h         |   29 ++
 5 files changed, 863 insertions(+), 4 deletions(-)
 create mode 100644 drivers/input/touchscreen/tsc2005.c
 create mode 100644 include/linux/spi/tsc2005.h

diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
index 7a41245..7606870 100644
--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/tsc2301.h>
+#include <linux/spi/tsc2005.h>
 #include <linux/input.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
@@ -371,21 +372,34 @@ static struct omap2_mcspi_device_config cx3110x_mcspi_config = {
 	.single_channel = 1,
 };
 
+#ifdef CONFIG_TOUCHSCREEN_TSC2005
+static struct tsc2005_platform_data tsc2005_config = {
+	.reset_gpio = 94,
+	.dav_gpio = 106
+};
+
+static struct omap2_mcspi_device_config tsc2005_mcspi_config = {
+	.turbo_mode	= 0,
+	.single_channel = 1,
+};
+#endif
+
 static struct spi_board_info n800_spi_board_info[] __initdata = {
-	[0] = {
+	{
 		.modalias	= "lcd_mipid",
 		.bus_num	= 1,
 		.chip_select	= 1,
 		.max_speed_hz	= 4000000,
 		.controller_data= &mipid_mcspi_config,
 		.platform_data	= &n800_mipid_platform_data,
-	}, [1] = {
+	}, {
 		.modalias	= "cx3110x",
 		.bus_num	= 2,
 		.chip_select	= 0,
 		.max_speed_hz   = 48000000,
 		.controller_data= &cx3110x_mcspi_config,
-	}, [2] = {
+	},
+	{
 		.modalias	= "tsc2301",
 		.bus_num	= 1,
 		.chip_select	= 0,
@@ -395,6 +409,73 @@ static struct spi_board_info n800_spi_board_info[] __initdata = {
 	},
 };
 
+static struct spi_board_info n810_spi_board_info[] __initdata = {
+	{
+		.modalias	= "lcd_mipid",
+		.bus_num	= 1,
+		.chip_select	= 1,
+		.max_speed_hz	= 4000000,
+		.controller_data= &mipid_mcspi_config,
+		.platform_data	= &n800_mipid_platform_data,
+	},
+	{
+		.modalias	= "cx3110x",
+		.bus_num	= 2,
+		.chip_select	= 0,
+		.max_speed_hz   = 48000000,
+		.controller_data= &cx3110x_mcspi_config,
+	},
+	{
+		.modalias	= "tsc2005",
+		.bus_num	= 1,
+		.chip_select	= 0,
+		.max_speed_hz   = 6000000,
+		.controller_data= &tsc2005_mcspi_config,
+		.platform_data  = &tsc2005_config,
+	},
+};
+
+static void __init tsc2005_set_config(void)
+{
+	const struct omap_lcd_config *conf;
+
+	conf = omap_get_config(OMAP_TAG_LCD, struct omap_lcd_config);
+	if (conf != NULL) {
+#ifdef CONFIG_TOUCHSCREEN_TSC2005
+		if (strcmp(conf->panel_name, "lph8923") == 0) {
+			tsc2005_config.ts_x_plate_ohm	= 180;
+			tsc2005_config.ts_hw_avg	= 0;
+			tsc2005_config.ts_ignore_last	= 0;
+			tsc2005_config.ts_touch_pressure= 1500;
+			tsc2005_config.ts_stab_time	= 100;
+			tsc2005_config.ts_pressure_max	= 2048;
+			tsc2005_config.ts_pressure_fudge= 2;
+			tsc2005_config.ts_x_max		= 4096;
+			tsc2005_config.ts_x_fudge	= 4;
+			tsc2005_config.ts_y_max		= 4096;
+			tsc2005_config.ts_y_fudge	= 7;
+		} else if (strcmp(conf->panel_name, "ls041y3") == 0) {
+			tsc2005_config.ts_x_plate_ohm	= 280;
+			tsc2005_config.ts_hw_avg	= 0;
+			tsc2005_config.ts_ignore_last	= 0;
+			tsc2005_config.ts_touch_pressure= 1500;
+			tsc2005_config.ts_stab_time	= 1000;
+			tsc2005_config.ts_pressure_max	= 2048;
+			tsc2005_config.ts_pressure_fudge= 2;
+			tsc2005_config.ts_x_max		= 4096;
+			tsc2005_config.ts_x_fudge	= 4;
+			tsc2005_config.ts_y_max		= 4096;
+			tsc2005_config.ts_y_fudge	= 7;
+		} else {
+			printk(KERN_ERR "Unknown panel type, set default "
+			       "touchscreen configuration\n");
+			tsc2005_config.ts_x_plate_ohm	= 200;
+			tsc2005_config.ts_stab_time	= 100;
+		}
+#endif
+	}
+}
+
 #if defined(CONFIG_CBUS_RETU) && defined(CONFIG_LEDS_OMAP_PWM)
 
 void retu_keypad_led_set_power(struct omap_pwm_led_platform_data *self,
@@ -595,8 +676,14 @@ void __init nokia_n800_common_init(void)
 	n800_dsp_init();
 	n800_usb_init();
 	n800_cam_init();
-	spi_register_board_info(n800_spi_board_info,
+	if (machine_is_nokia_n800())
+		spi_register_board_info(n800_spi_board_info,
 				ARRAY_SIZE(n800_spi_board_info));
+	if (machine_is_nokia_n810()) {
+		tsc2005_set_config();
+		spi_register_board_info(n810_spi_board_info,
+				ARRAY_SIZE(n810_spi_board_info));
+	}
 	omap_serial_init();
 	omap_register_i2c_bus(1, 400, n800_i2c_board_info_1,
 			      ARRAY_SIZE(n800_i2c_board_info_1));
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index f3c45b6..1542e16 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -185,6 +185,11 @@ config TOUCHSCREEN_UCB1400
 	  To compile this driver as a module, choose M here: the
 	  module will be called ucb1400_ts.
 
+config TOUCHSCREEN_TSC2005
+	tristate "TSC2005 touchscreen support"
+	help
+	  Say Y here for if you are using the touchscreen features of TSC2301.
+
 config TOUCHSCREEN_TSC2102
 	tristate "TSC 2102 based touchscreens"
 	depends on SPI_MASTER
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index bdd2571..51d3a23 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_TOUCHSCREEN_PENMOUNT)	+= penmount.o
 obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT)	+= touchright.o
 obj-$(CONFIG_TOUCHSCREEN_TOUCHWIN)	+= touchwin.o
 obj-$(CONFIG_TOUCHSCREEN_UCB1400)	+= ucb1400_ts.o
+obj-$(CONFIG_TOUCHSCREEN_TSC2005)	+= tsc2005.o
 obj-$(CONFIG_TOUCHSCREEN_TSC2102)	+= tsc2102_ts.o
 obj-$(CONFIG_TOUCHSCREEN_OMAP)	+= omap/
 obj-$(CONFIG_TOUCHSCREEN_TSC210X)	+= tsc210x_ts.o
diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
new file mode 100644
index 0000000..2ef7309
--- /dev/null
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -0,0 +1,737 @@
+/*
+ * TSC2005 touchscreen driver
+ *
+ * Copyright (C) 2006-2008 Nokia Corporation
+ *
+ * Author: Lauri Leukkunen <lauri.leukkunen@nokia.com>
+ * based on TSC2301 driver by Klaus K. Pedersen <klaus.k.pedersen@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/spi/spi.h>
+
+#ifdef CONFIG_ARCH_OMAP
+#include <asm/arch/gpio.h>
+#endif
+
+#include <linux/spi/tsc2005.h>
+
+/**
+ * The touchscreen interface operates as follows:
+ *
+ * Initialize:
+ *    Request access to GPIO103 (DAV)
+ *    tsc2005_dav_irq_handler will trigger when DAV line goes down
+ *
+ *  1) Pen is pressed against touchscreeen
+ *  2) TSC2005 performs AD conversion
+ *  3) After the conversion is done TSC2005 drives DAV line down
+ *  4) GPIO IRQ is received and tsc2005_dav_irq_handler is called
+ *  5) tsc2005_ts_irq_handler queues up an spi transfer to fetch
+ *     the x, y, z1, z2 values
+ *  6) tsc2005_ts_rx() reports coordinates to input layer and
+ *     sets up tsc2005_ts_timer() to be called after TSC2005_TS_SCAN_TIME
+ *  7)  When the penup_timer expires, there have not been DAV interrupts
+ *     during the last 20ms which means the pen has been lifted.
+ */
+
+#define TSC2005_HZ	(14000000)
+
+#define TSC2005_CMD	(0x80)
+#define TSC2005_REG	(0x00)
+
+#define TSC2005_CMD_STOP	(1)
+#define TSC2005_CMD_10BIT	(0 << 2)
+#define TSC2005_CMD_12BIT	(1 << 2)
+
+#define TSC2005_CMD_SCAN_XYZZ	(0 << 3)
+#define TSC2005_CMD_SCAN_XY	(1 << 3)
+#define TSC2005_CMD_SCAN_X	(2 << 3)
+#define TSC2005_CMD_SCAN_Y	(3 << 3)
+#define TSC2005_CMD_SCAN_ZZ	(4 << 3)
+#define TSC2005_CMD_AUX_SINGLE	(5 << 3)
+#define TSC2005_CMD_TEMP1	(6 << 3)
+#define TSC2005_CMD_TEMP2	(7 << 3)
+#define TSC2005_CMD_AUX_CONT	(8 << 3)
+#define TSC2005_CMD_TEST_X_CONN	(9 << 3)
+#define TSC2005_CMD_TEST_Y_CONN	(10 << 3)
+/* command 11 reserved */
+#define TSC2005_CMD_TEST_SHORT	(12 << 3)
+#define TSC2005_CMD_DRIVE_XX	(13 << 3)
+#define TSC2005_CMD_DRIVE_YY	(14 << 3)
+#define TSC2005_CMD_DRIVE_YX	(15 << 3)
+
+#define TSC2005_REG_X		(0 << 3)
+#define TSC2005_REG_Y		(1 << 3)
+#define TSC2005_REG_Z1		(2 << 3)
+#define TSC2005_REG_Z2		(3 << 3)
+#define TSC2005_REG_AUX		(4 << 3)
+#define TSC2005_REG_TEMP1	(5 << 3)
+#define TSC2005_REG_TEMP2	(6 << 3)
+#define TSC2005_REG_STATUS	(7 << 3)
+#define TSC2005_REG_AUX_HIGH	(8 << 3)
+#define TSC2005_REG_AUX_LOW	(9 << 3)
+#define TSC2005_REG_TEMP_HIGH	(10 << 3)
+#define TSC2005_REG_TEMP_LOW	(11 << 3)
+#define TSC2005_REG_CFR0	(12 << 3)
+#define TSC2005_REG_CFR1	(13 << 3)
+#define TSC2005_REG_CFR2	(14 << 3)
+#define TSC2005_REG_FUNCTION	(15 << 3)
+
+#define TSC2005_REG_PND0	(1 << 1)
+#define TSC2005_REG_READ	(0x01)
+#define TSC2005_REG_WRITE	(0x00)
+
+
+#define TSC2005_CFR0_LONGSAMPLING	(1)
+#define TSC2005_CFR0_DETECTINWAIT	(1 << 1)
+#define TSC2005_CFR0_SENSETIME_32US	(0)
+#define TSC2005_CFR0_SENSETIME_96US	(1 << 2)
+#define TSC2005_CFR0_SENSETIME_544US	(1 << 3)
+#define TSC2005_CFR0_SENSETIME_2080US	(1 << 4)
+#define TSC2005_CFR0_SENSETIME_2656US	(0x001C)
+#define TSC2005_CFR0_PRECHARGE_20US	(0x0000)
+#define TSC2005_CFR0_PRECHARGE_84US	(0x0020)
+#define TSC2005_CFR0_PRECHARGE_276US	(0x0040)
+#define TSC2005_CFR0_PRECHARGE_1044US	(0x0080)
+#define TSC2005_CFR0_PRECHARGE_1364US	(0x00E0)
+#define TSC2005_CFR0_STABTIME_0US	(0x0000)
+#define TSC2005_CFR0_STABTIME_100US	(0x0100)
+#define TSC2005_CFR0_STABTIME_500US	(0x0200)
+#define TSC2005_CFR0_STABTIME_1MS	(0x0300)
+#define TSC2005_CFR0_STABTIME_5MS	(0x0400)
+#define TSC2005_CFR0_STABTIME_100MS	(0x0700)
+#define TSC2005_CFR0_CLOCK_4MHZ		(0x0000)
+#define TSC2005_CFR0_CLOCK_2MHZ		(0x0800)
+#define TSC2005_CFR0_CLOCK_1MHZ		(0x1000)
+#define TSC2005_CFR0_RESOLUTION12	(0x2000)
+#define TSC2005_CFR0_STATUS		(0x4000)
+#define TSC2005_CFR0_PENMODE		(0x8000)
+
+#define TSC2005_CFR0_INITVALUE	(TSC2005_CFR0_STABTIME_1MS  |	\
+				 TSC2005_CFR0_CLOCK_1MHZ    |	\
+				 TSC2005_CFR0_RESOLUTION12  |	\
+				 TSC2005_CFR0_PRECHARGE_276US | \
+				 TSC2005_CFR0_PENMODE)
+
+#define TSC2005_CFR1_BATCHDELAY_0MS	(0x0000)
+#define TSC2005_CFR1_BATCHDELAY_1MS	(0x0001)
+#define TSC2005_CFR1_BATCHDELAY_2MS	(0x0002)
+#define TSC2005_CFR1_BATCHDELAY_4MS	(0x0003)
+#define TSC2005_CFR1_BATCHDELAY_10MS	(0x0004)
+#define TSC2005_CFR1_BATCHDELAY_20MS	(0x0005)
+#define TSC2005_CFR1_BATCHDELAY_40MS	(0x0006)
+#define TSC2005_CFR1_BATCHDELAY_100MS	(0x0007)
+
+#define TSC2005_CFR1_INITVALUE	(TSC2005_CFR1_BATCHDELAY_2MS)
+
+#define TSC2005_CFR2_MAVE_TEMP	(0x0001)
+#define TSC2005_CFR2_MAVE_AUX	(0x0002)
+#define TSC2005_CFR2_MAVE_Z	(0x0004)
+#define TSC2005_CFR2_MAVE_Y	(0x0008)
+#define TSC2005_CFR2_MAVE_X	(0x0010)
+#define TSC2005_CFR2_AVG_1	(0x0000)
+#define TSC2005_CFR2_AVG_3	(0x0400)
+#define TSC2005_CFR2_AVG_7	(0x0800)
+#define TSC2005_CFR2_MEDIUM_1	(0x0000)
+#define TSC2005_CFR2_MEDIUM_3	(0x1000)
+#define TSC2005_CFR2_MEDIUM_7	(0x2000)
+#define TSC2005_CFR2_MEDIUM_15	(0x3000)
+
+#define TSC2005_CFR2_IRQ_DAV	(0x4000)
+#define TSC2005_CFR2_IRQ_PEN	(0x8000)
+#define TSC2005_CFR2_IRQ_PENDAV	(0x0000)
+
+#define TSC2005_CFR2_INITVALUE	(TSC2005_CFR2_IRQ_DAV   |	\
+				 TSC2005_CFR2_MAVE_X    |	\
+				 TSC2005_CFR2_MAVE_Y    |	\
+				 TSC2005_CFR2_MAVE_Z    |	\
+				 TSC2005_CFR2_MEDIUM_15 |	\
+				 TSC2005_CFR2_AVG_7)
+
+#define MAX_12BIT					((1 << 12) - 1)
+#define TS_SAMPLES					4
+#define TS_RECT_SIZE					8
+#define TSC2005_TS_PENUP_TIME				20
+
+static const u32 tsc2005_read_reg[] = {
+	(TSC2005_REG | TSC2005_REG_X | TSC2005_REG_READ) << 16,
+	(TSC2005_REG | TSC2005_REG_Y | TSC2005_REG_READ) << 16,
+	(TSC2005_REG | TSC2005_REG_Z1 | TSC2005_REG_READ) << 16,
+	(TSC2005_REG | TSC2005_REG_Z2 | TSC2005_REG_READ) << 16,
+};
+#define NUM_READ_REGS	(sizeof(tsc2005_read_reg)/sizeof(tsc2005_read_reg[0]))
+
+struct tsc2005 {
+	struct spi_device	*spi;
+
+	struct input_dev	*idev;
+	char			phys[32];
+	struct timer_list	penup_timer;
+	spinlock_t		lock;
+	struct mutex		mutex;
+
+	struct spi_message	read_msg;
+	struct spi_transfer	read_xfer[NUM_READ_REGS];
+	u32                     data[NUM_READ_REGS];
+
+	/* previous x,y,z */
+	int			x;
+	int			y;
+	int			p;
+	/* average accumulators for each component */
+	int			sample_cnt;
+	int			avg_x;
+	int			avg_y;
+	int			avg_z1;
+	int			avg_z2;
+	/* configuration */
+	int			x_plate_ohm;
+	int			hw_avg_max;
+	int			stab_time;
+	int			p_max;
+	int			touch_pressure;
+	int			irq;
+	s16			dav_gpio;
+	/* status */
+	u8			sample_sent;
+	u8			pen_down;
+	u8			disabled;
+	u8			disable_depth;
+	u8			spi_active;
+};
+
+static void tsc2005_cmd(struct tsc2005 *ts, u8 cmd)
+{
+	u16 data = TSC2005_CMD | TSC2005_CMD_12BIT | cmd;
+	struct spi_message msg;
+	struct spi_transfer xfer = { 0 };
+
+	spi_message_init(&msg);
+	msg.spi = ts->spi;
+	xfer.tx_buf = &data;
+	xfer.rx_buf = NULL;
+	xfer.len = 2;
+	xfer.bits_per_word = 8;
+
+	spi_message_add_tail(&xfer, &msg);
+	spi_sync(ts->spi, &msg);
+}
+
+static void tsc2005_write(struct tsc2005 *ts, u8 reg, u16 value)
+{
+	u32 tx;
+	struct spi_message msg;
+	struct spi_transfer xfer = { 0 };
+
+	tx = (TSC2005_REG | reg | TSC2005_REG_PND0 |
+	       TSC2005_REG_WRITE) << (2 * 8);
+	tx |= value;
+
+	spi_message_init(&msg);
+	msg.spi = ts->spi;
+	xfer.tx_buf = &tx;
+	xfer.rx_buf = NULL;
+	xfer.len = 4;
+	xfer.bits_per_word = 3 * 8;
+
+	spi_message_add_tail(&xfer, &msg);
+	spi_sync(ts->spi, &msg);
+}
+
+static void tsc2005_ts_update_pen_state(struct tsc2005 *ts,
+					int x, int y, int pressure)
+{
+	if (pressure) {
+		input_report_abs(ts->idev, ABS_X, x);
+		input_report_abs(ts->idev, ABS_Y, y);
+		input_report_abs(ts->idev, ABS_PRESSURE, pressure);
+		if (!ts->pen_down) {
+			input_report_key(ts->idev, BTN_TOUCH, 1);
+			ts->pen_down = 1;
+		}
+	} else {
+		input_report_abs(ts->idev, ABS_PRESSURE, 0);
+		if (ts->pen_down) {
+			input_report_key(ts->idev, BTN_TOUCH, 0);
+		}
+		ts->pen_down = 0;
+	}
+
+	input_sync(ts->idev);
+}
+
+/*
+ * This function is called by the SPI framework after the coordinates
+ * have been read from TSC2005
+ */
+static void tsc2005_ts_rx(void *arg)
+{
+	struct tsc2005 *ts = arg;
+	unsigned long flags;
+	int inside_rect, pressure_limit;
+	int x, y, z1, z2, pressure;
+
+	spin_lock_irqsave(&ts->lock, flags);
+
+	x = ts->data[0];
+	y = ts->data[1];
+	z1 = ts->data[2];
+	z2 = ts->data[3];
+
+	/* validate pressure and position */
+	if (x > MAX_12BIT || y > MAX_12BIT)
+		goto out;
+
+	/* skip coords if the pressure-components are out of range */
+	if (z1 < 100 || z2 > 4000)
+		goto out;
+
+	/* don't run average on the "pen down" event */
+	if (ts->sample_sent) {
+		ts->avg_x += x;
+		ts->avg_y += y;
+		ts->avg_z1 += z1;
+		ts->avg_z2 += z2;
+
+		if (++ts->sample_cnt < TS_SAMPLES)
+			goto out;
+
+		x = ts->avg_x / TS_SAMPLES;
+		y = ts->avg_y / TS_SAMPLES;
+		z1 = ts->avg_z1 / TS_SAMPLES;
+		z2 = ts->avg_z2 / TS_SAMPLES;
+	}
+
+	ts->sample_cnt = 0;
+	ts->avg_x = 0;
+	ts->avg_y = 0;
+	ts->avg_z1 = 0;
+	ts->avg_z2 = 0;
+
+	if (z1) {
+		pressure = x * (z2 - z1) / z1;
+		pressure = pressure * ts->x_plate_ohm / 4096;
+	} else
+		goto out;
+
+	pressure_limit = ts->sample_sent? ts->p_max: ts->touch_pressure;
+	if (pressure > pressure_limit)
+		goto out;
+
+	/* discard the event if it still is within the previous rect - unless
+	 * if the pressure is harder, but then use previous x,y position */
+	inside_rect = (ts->sample_sent &&
+		x > (int)ts->x - TS_RECT_SIZE &&
+		x < (int)ts->x + TS_RECT_SIZE &&
+		y > (int)ts->y - TS_RECT_SIZE &&
+		y < (int)ts->y + TS_RECT_SIZE);
+	if (inside_rect)
+		x = ts->x, y = ts->y;
+
+	if (!inside_rect || pressure < ts->p) {
+		tsc2005_ts_update_pen_state(ts, x, y, pressure);
+		ts->sample_sent = 1;
+		ts->x = x;
+		ts->y = y;
+		ts->p = pressure;
+	}
+out:
+	ts->spi_active = 0;
+	spin_unlock_irqrestore(&ts->lock, flags);
+
+	/* kick pen up timer - to make sure it expires again(!) */
+	if (ts->sample_sent)
+		mod_timer(&ts->penup_timer,
+			  jiffies + msecs_to_jiffies(TSC2005_TS_PENUP_TIME));
+}
+
+static void tsc2005_ts_penup_timer_handler(unsigned long data)
+{
+	struct tsc2005 *ts = (struct tsc2005 *)data;
+
+	if (ts->sample_sent) {
+		tsc2005_ts_update_pen_state(ts, 0, 0, 0);
+		ts->sample_sent = 0;
+	}
+}
+
+/*
+ * This interrupt is called when pen is down and coordinates are
+ * available. That is indicated by a falling edge on DEV line.
+ */
+static irqreturn_t tsc2005_ts_irq_handler(int irq, void *dev_id)
+{
+	struct tsc2005 *ts = dev_id;
+	int r;
+
+	if (ts->spi_active) return IRQ_HANDLED;
+
+	ts->spi_active = 1;
+	r = spi_async(ts->spi, &ts->read_msg);
+	if (r)
+		dev_err(&ts->spi->dev, "ts: spi_async() failed");
+
+	/* kick pen up timer */
+	mod_timer(&ts->penup_timer,
+		  jiffies + msecs_to_jiffies(TSC2005_TS_PENUP_TIME));
+
+	return IRQ_HANDLED;
+}
+
+static void tsc2005_ts_setup_spi_xfer(struct tsc2005 *ts)
+{
+	struct spi_message *m = &ts->read_msg;
+	struct spi_transfer *x = &ts->read_xfer[0];
+	int i;
+
+	spi_message_init(m);
+	m->spi = ts->spi;
+
+	for (i = 0; i < NUM_READ_REGS; i++, x++ ) {
+		x->tx_buf = &tsc2005_read_reg[i];
+		x->rx_buf = &ts->data[i];
+		x->len = 4;
+		x->bits_per_word = 24;
+		x->cs_change = i < (NUM_READ_REGS - 1);
+		spi_message_add_tail(x, m);
+	}
+
+	m->complete = tsc2005_ts_rx;
+	m->context = ts;
+}
+
+static ssize_t tsc2005_ts_pen_down_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct tsc2005 *tsc = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", tsc->pen_down);
+}
+
+static DEVICE_ATTR(pen_down, S_IRUGO, tsc2005_ts_pen_down_show, NULL);
+
+static int tsc2005_configure(struct tsc2005 *tsc, int flags)
+{
+	tsc2005_write(tsc, TSC2005_REG_CFR0, TSC2005_CFR0_INITVALUE);
+	tsc2005_write(tsc, TSC2005_REG_CFR1, TSC2005_CFR1_INITVALUE);
+	tsc2005_write(tsc, TSC2005_REG_CFR2, TSC2005_CFR2_INITVALUE);
+	tsc2005_cmd(tsc, flags);
+
+	return 0;
+}
+
+static void tsc2005_start_scan(struct tsc2005 *tsc)
+{
+	tsc2005_configure(tsc, TSC2005_CMD_SCAN_XYZZ);
+}
+
+static void tsc2005_stop_scan(struct tsc2005 *tsc)
+{
+	tsc2005_cmd(tsc, TSC2005_CMD_STOP);
+}
+
+/* Must be called with mutex held */
+static void tsc2005_disable(struct tsc2005 *ts)
+{
+	if (ts->disable_depth++ != 0) {
+		return;
+	}
+	disable_irq(ts->irq);
+
+	/* wait until penup timer expire normally */
+	do {
+		msleep(4);
+	} while (ts->sample_sent);
+
+	tsc2005_stop_scan(ts);
+}
+
+static void tsc2005_enable(struct tsc2005 *ts)
+{
+	if (--ts->disable_depth != 0) {
+		return;
+	}
+	enable_irq(ts->irq);
+
+	tsc2005_start_scan(ts);
+}
+
+static ssize_t tsc2005_disable_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct tsc2005 *ts = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", ts->disabled);
+}
+
+static ssize_t tsc2005_disable_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct tsc2005		*tsc = dev_get_drvdata(dev);
+	char *endp;
+	int i;
+
+	i = simple_strtoul(buf, &endp, 10);
+	i = i ? 1 : 0;
+
+	mutex_lock(&tsc->mutex);
+	if (i == tsc->disabled) goto out;
+	tsc->disabled = i;
+
+	if (i)
+		tsc2005_disable(tsc);
+	else
+		tsc2005_enable(tsc);
+out:
+	mutex_unlock(&tsc->mutex);
+	return count;
+}
+
+static DEVICE_ATTR(disable_ts, 0664, tsc2005_disable_show,
+		   tsc2005_disable_store);
+
+
+static int __devinit tsc2005_ts_init(struct tsc2005 *ts,
+				     struct tsc2005_platform_data *pdata)
+{
+	struct input_dev *idev;
+	int dav_gpio, r;
+	int x_max, y_max;
+	int x_fudge, y_fudge, p_fudge;
+
+	if (pdata->dav_gpio < 0) {
+		dev_err(&ts->spi->dev, "need DAV GPIO");
+		return -EINVAL;
+	}
+	dav_gpio = pdata->dav_gpio;
+	ts->dav_gpio = dav_gpio;
+	dev_dbg(&ts->spi->dev, "TSC2005: DAV GPIO = %d\n", dav_gpio);
+
+#ifdef CONFIG_ARCH_OMAP
+	r = omap_request_gpio(dav_gpio);
+	if (r < 0) {
+		dev_err(&ts->spi->dev, "unable to get DAV GPIO");
+		goto err1;
+	}
+	omap_set_gpio_direction(dav_gpio, 1);
+	ts->irq = OMAP_GPIO_IRQ(dav_gpio);
+	dev_dbg(&ts->spi->dev, "TSC2005: DAV IRQ = %d\n", ts->irq);
+#endif
+	init_timer(&ts->penup_timer);
+	setup_timer(&ts->penup_timer, tsc2005_ts_penup_timer_handler,
+			(unsigned long)ts);
+
+	spin_lock_init(&ts->lock);
+	mutex_init(&ts->mutex);
+
+	ts->x_plate_ohm		= pdata->ts_x_plate_ohm ? : 280;
+	ts->hw_avg_max		= pdata->ts_hw_avg;
+	ts->stab_time		= pdata->ts_stab_time;
+	x_max			= pdata->ts_x_max ? : 4096;
+	x_fudge			= pdata->ts_x_fudge ? : 4;
+	y_max			= pdata->ts_y_max ? : 4096;
+	y_fudge			= pdata->ts_y_fudge ? : 8;
+	ts->p_max		= pdata->ts_pressure_max ? : MAX_12BIT;
+	ts->touch_pressure	= pdata->ts_touch_pressure ? : ts->p_max;
+	p_fudge			= pdata->ts_pressure_fudge ? : 2;
+
+	idev = input_allocate_device();
+	if (idev == NULL) {
+		r = -ENOMEM;
+		goto err2;
+	}
+
+	/*
+	 * TODO: should be "TSC2005 touchscreen", but X has hardcoded these
+	 * strings and doesn't accept TSC2005 yet...
+	 */
+	idev->name = "TSC2301 touchscreen";
+	snprintf(ts->phys, sizeof(ts->phys), "%s/input-ts",
+		 ts->spi->dev.bus_id);
+	idev->phys = ts->phys;
+
+	idev->evbit[0] = BIT(EV_ABS) | BIT(EV_KEY);
+	idev->absbit[0] = BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE);
+	ts->idev = idev;
+
+	tsc2005_ts_setup_spi_xfer(ts);
+
+	input_set_abs_params(idev, ABS_X, 0, x_max, x_fudge, 0);
+	input_set_abs_params(idev, ABS_Y, 0, y_max, y_fudge, 0);
+	input_set_abs_params(idev, ABS_PRESSURE, 0, ts->p_max, p_fudge, 0);
+
+	tsc2005_start_scan(ts);
+
+	r = request_irq(ts->irq, tsc2005_ts_irq_handler,
+			IRQF_TRIGGER_FALLING | IRQF_DISABLED |
+			IRQF_SAMPLE_RANDOM, "tsc2005", ts);
+	if (r < 0) {
+		dev_err(&ts->spi->dev, "unable to get DAV IRQ");
+		goto err3;
+	}
+
+	set_irq_wake(ts->irq, 1);
+
+	r = input_register_device(idev);
+	if (r < 0) {
+		dev_err(&ts->spi->dev, "can't register touchscreen device\n");
+		goto err4;
+	}
+
+	/* We can tolerate these failing */
+	if (device_create_file(&ts->spi->dev, &dev_attr_pen_down));
+	if (device_create_file(&ts->spi->dev, &dev_attr_disable_ts));
+
+	return 0;
+err4:
+	free_irq(ts->irq, ts);
+err3:
+	tsc2005_stop_scan(ts);
+	input_free_device(idev);
+err2:
+#ifdef CONFIG_ARCH_OMAP
+	omap_free_gpio(dav_gpio);
+#endif
+err1:
+	return r;
+}
+
+static int __devinit tsc2005_probe(struct spi_device *spi)
+{
+	struct tsc2005			*tsc;
+	struct tsc2005_platform_data	*pdata = spi->dev.platform_data;
+	int r;
+
+	if (!pdata) {
+		dev_dbg(&spi->dev, "no platform data?\n");
+		return -ENODEV;
+	}
+
+	tsc = kzalloc(sizeof(*tsc), GFP_KERNEL);
+	if (tsc == NULL)
+		return -ENOMEM;
+
+	dev_set_drvdata(&spi->dev, tsc);
+	tsc->spi = spi;
+	spi->dev.power.power_state = PMSG_ON;
+
+	spi->mode = SPI_MODE_0;
+	spi->bits_per_word = 8;
+	/* The max speed might've been defined by the board-specific
+	 * struct */
+	if (!spi->max_speed_hz)
+		spi->max_speed_hz = TSC2005_HZ;
+
+	spi_setup(spi);
+
+	r = tsc2005_ts_init(tsc, pdata);
+	if (r)
+		goto err1;
+
+	return 0;
+
+err1:
+	kfree(tsc);
+	return r;
+}
+
+static int __devexit tsc2005_remove(struct spi_device *spi)
+{
+	struct tsc2005 *ts = dev_get_drvdata(&spi->dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&ts->lock, flags);
+	tsc2005_disable(ts);
+	spin_unlock_irqrestore(&ts->lock, flags);
+
+	device_remove_file(&ts->spi->dev, &dev_attr_disable_ts);
+	device_remove_file(&ts->spi->dev, &dev_attr_pen_down);
+
+	free_irq(ts->irq, ts);
+	input_unregister_device(ts->idev);
+
+#ifdef CONFIG_ARCH_OMAP
+	omap_free_gpio(ts->dav_gpio);
+#endif
+	kfree(ts);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int tsc2005_suspend(struct spi_device *spi, pm_message_t mesg)
+{
+	struct tsc2005 *ts = dev_get_drvdata(&spi->dev);
+
+	mutex_lock(&ts->mutex);
+	tsc2005_disable(ts);
+	mutex_unlock(&ts->mutex);
+
+	return 0;
+}
+
+static int tsc2005_resume(struct spi_device *spi)
+{
+	struct tsc2005 *ts = dev_get_drvdata(&spi->dev);
+
+	mutex_lock(&ts->mutex);
+	tsc2005_enable(ts);
+	mutex_unlock(&ts->mutex);
+
+	return 0;
+}
+#endif
+
+static struct spi_driver tsc2005_driver = {
+	.driver = {
+		.name = "tsc2005",
+		.bus = &spi_bus_type,
+		.owner = THIS_MODULE,
+	},
+#ifdef CONFIG_PM
+	.suspend = tsc2005_suspend,
+	.resume = tsc2005_resume,
+#endif
+	.probe = tsc2005_probe,
+	.remove = __devexit_p(tsc2005_remove),
+};
+
+static int __init tsc2005_init(void)
+{
+	printk("TSC2005 driver initializing\n");
+
+	return spi_register_driver(&tsc2005_driver);
+}
+module_init(tsc2005_init);
+
+static void __exit tsc2005_exit(void)
+{
+	spi_unregister_driver(&tsc2005_driver);
+}
+module_exit(tsc2005_exit);
+
+MODULE_AUTHOR("Lauri Leukkunen <lauri.leukkunen@nokia.com>");
+MODULE_LICENSE("GPL");
+
diff --git a/include/linux/spi/tsc2005.h b/include/linux/spi/tsc2005.h
new file mode 100644
index 0000000..dbc01f7
--- /dev/null
+++ b/include/linux/spi/tsc2005.h
@@ -0,0 +1,29 @@
+#ifndef _LINUX_SPI_TSC2005_H
+#define _LINUX_SPI_TSC2005_H
+
+#include <linux/types.h>
+
+struct tsc2005_platform_data {
+	s16	reset_gpio;
+	s16	dav_gpio;
+	s16	pen_int_gpio;
+	u16	ts_x_plate_ohm;
+	u32	ts_stab_time;	/* voltage settling time */
+	u8	ts_hw_avg;	/* HW assiseted averaging. Can be
+				   0, 4, 8, 16 samples per reading */
+	u32	ts_touch_pressure;	/* Pressure limit until we report a
+					   touch event. After that we switch
+					   to ts_max_pressure. */
+	u32	ts_pressure_max;/* Samples with bigger pressure value will
+				   be ignored, since the corresponding X, Y
+				   values are unreliable */
+	u32	ts_pressure_fudge;
+	u32	ts_x_max;
+	u32	ts_x_fudge;
+	u32	ts_y_max;
+	u32	ts_y_fudge;
+
+	unsigned ts_ignore_last : 1;
+};
+
+#endif
-- 
1.5.5.rc3

