From: Mayuresh Janorkar <mayur@ti.com>
Subject: [PATCH v4 4/4] OMAP: DSS: Add picodlp panel driver
Date: Tue, 10 May 2011 18:55:47 +0530
Message-ID: <1305033947-4521-5-git-send-email-mayur@ti.com>
References: <1305033947-4521-1-git-send-email-mayur@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35894 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752328Ab1EJM6R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 May 2011 08:58:17 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4ACwGCk032749
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 10 May 2011 07:58:16 -0500
In-Reply-To: <1305033947-4521-1-git-send-email-mayur@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, Mayuresh Janorkar <mayur@ti.com>, Mythri P K <mythripk@ti.com>

picodlp panel driver is required for driving DLP dpp2600.
It consists of a dss driver and an i2c_client.

i2c_client is required for sending commands to dpp (DLP Pico Projector).

Based on original design from Mythri P K <mythripk@ti.com>

The power-up sequence consists of:
Setting PWRGOOD to a logic low state. Once power is stable and thus the DPP2600
is stable, then PWRGOOD should be deactivated (Set to a logic high).
The DPP2600 will then perform a power-up initialization routine that will first
configure and lock its PLL followed by loading self configuration data from
external flash. DPP2600 would be activated and the EMU_DONE signal will be
driven high. After this once internal initialization routine,
which will take approximately 510ms, i2c commands can be sent.

To know more please visit: http://www.omappedia.org/wiki/PicoDLP_projector_guide

Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
Signed-off-by: Mythri P K <mythripk@ti.com>
---
Changes since v3:
	msleep moved to appropriate place
	gpio requests moved to board file

Changes since v2:
	Merged panel picodlp patches into a single patch
	Introduced DMA_DONE polling between flash transfer
	Changed GPIO handling
	Reduced sleeps

 drivers/video/omap2/displays/Kconfig         |    7 +
 drivers/video/omap2/displays/Makefile        |    1 +
 drivers/video/omap2/displays/panel-picodlp.c |  614 ++++++++++++++++++++++++++
 3 files changed, 622 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/omap2/displays/panel-picodlp.c

diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
index 609a280..0b05593 100644
--- a/drivers/video/omap2/displays/Kconfig
+++ b/drivers/video/omap2/displays/Kconfig
@@ -30,6 +30,13 @@ config PANEL_NEC_NL8048HL11_01B
 		This NEC NL8048HL11-01B panel is TFT LCD
 		used in the Zoom2/3/3630 sdp boards.
 
+config PANEL_PICODLP
+	tristate "OMAP PICO DLP Panel"
+	depends on OMAP2_DSS
+	help
+		Projector Panel used in TI's SDP4430 and EVM boards
+		For more info please visit http://www.dlp.com/projector/
+
 config PANEL_TAAL
         tristate "Taal DSI Panel"
         depends on OMAP2_DSS_DSI
diff --git a/drivers/video/omap2/displays/Makefile b/drivers/video/omap2/displays/Makefile
index 0f601ab..d90f73c 100644
--- a/drivers/video/omap2/displays/Makefile
+++ b/drivers/video/omap2/displays/Makefile
@@ -4,5 +4,6 @@ obj-$(CONFIG_PANEL_SHARP_LS037V7DW01) += panel-sharp-ls037v7dw01.o
 obj-$(CONFIG_PANEL_NEC_NL8048HL11_01B) += panel-nec-nl8048hl11-01b.o
 
 obj-$(CONFIG_PANEL_TAAL) += panel-taal.o
+obj-$(CONFIG_PANEL_PICODLP) +=  panel-picodlp.o
 obj-$(CONFIG_PANEL_TPO_TD043MTEA1) += panel-tpo-td043mtea1.o
 obj-$(CONFIG_PANEL_ACX565AKM) += panel-acx565akm.o
diff --git a/drivers/video/omap2/displays/panel-picodlp.c b/drivers/video/omap2/displays/panel-picodlp.c
new file mode 100644
index 0000000..8dd8651
--- /dev/null
+++ b/drivers/video/omap2/displays/panel-picodlp.c
@@ -0,0 +1,614 @@
+/*
+ * picodlp panel driver
+ * picodlp_i2c_driver: i2c_client driver
+ *
+ * Copyright (C) 2009-2011 Texas Instruments
+ * Author: Mythri P K <mythripk@ti.com>
+ * Mayuresh Janorkar <mayur@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/input.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/firmware.h>
+#include <linux/slab.h>
+#include <linux/mutex.h>
+#include <linux/i2c.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+
+#include <plat/display.h>
+#include <plat/panel-picodlp.h>
+
+#include "panel-picodlp.h"
+
+#define DRIVER_NAME	"picodlp_i2c_driver"
+
+#define MAX_TRIAL_VALUE			100
+
+struct picodlp_data {
+	struct mutex lock;
+	struct i2c_client *picodlp_i2c_client;
+};
+
+static struct i2c_board_info picodlp_i2c_board_info = {
+	I2C_BOARD_INFO("picodlp_i2c_driver", 0x1b),
+};
+
+struct picodlp_i2c_data {
+	struct mutex xfer_lock;
+};
+
+struct i2c_device_id picodlp_i2c_id[] = {
+	{ "picodlp_i2c_driver", 0 },
+};
+
+struct picodlp_i2c_command {
+	u8 reg;
+	u32 value;
+};
+
+static struct omap_video_timings pico_ls_timings = {
+	.x_res		= 864,
+	.y_res		= 480,
+	.hsw		= 7,
+	.hfp		= 11,
+	.hbp		= 7,
+
+	.pixel_clock	= 19200,
+
+	.vsw		= 2,
+	.vfp		= 3,
+	.vbp		= 14,
+};
+
+static inline struct picodlp_panel_data
+		*get_panel_data(const struct omap_dss_device *dssdev)
+{
+	return (struct picodlp_panel_data *) dssdev->data;
+}
+
+static u32 picodlp_i2c_read(struct i2c_client *client, u8 reg)
+{
+	u8 read_cmd[] = {READ_REG_SELECT, reg}, data[4];
+	struct picodlp_i2c_data *picodlp_i2c_data = i2c_get_clientdata(client);
+	struct i2c_msg msg[2];
+
+	mutex_lock(&picodlp_i2c_data->xfer_lock);
+
+	msg[0].addr = client->addr;
+	msg[0].flags = 0;
+	msg[0].len = 2;
+	msg[0].buf = read_cmd;
+
+	msg[1].addr = client->addr;
+	msg[1].flags = I2C_M_RD;
+	msg[1].len = 4;
+	msg[1].buf = data;
+
+	i2c_transfer(client->adapter, msg, 2);
+	mutex_unlock(&picodlp_i2c_data->xfer_lock);
+	return (data[3] | (data[2] << 8) | (data[1] << 16) | (data[0] << 24));
+}
+
+static int picodlp_i2c_write_block(struct i2c_client *client,
+					u8 *data, int len)
+{
+	struct i2c_msg msg;
+	int i, r, msg_count = 1;
+
+	struct picodlp_i2c_data *picodlp_i2c_data = i2c_get_clientdata(client);
+
+	if (len < 1 || len > 32) {
+		dev_err(&client->dev,
+			"too long syn_write_block len %d\n", len);
+		return -EIO;
+	}
+	mutex_lock(&picodlp_i2c_data->xfer_lock);
+
+	msg.addr = client->addr;
+	msg.flags = 0;
+	msg.len = len;
+	msg.buf = data;
+	r = i2c_transfer(client->adapter, &msg, msg_count);
+	mutex_unlock(&picodlp_i2c_data->xfer_lock);
+
+	/*
+	 * i2c_transfer returns:
+	 * number of messages sent in case of success
+	 * a negative error number in case of failure
+	 */
+	if (r != msg_count)
+		goto err;
+
+	/* In case of success */
+	for (i = 0; i < len; i++)
+		dev_dbg(&client->dev,
+			"addr %x bw 0x%02x[%d]: 0x%02x\n",
+			client->addr, data[0] + i, i, data[i]);
+
+	return 0;
+err:
+	dev_err(&client->dev, "picodlp_i2c_write error\n");
+	return r;
+}
+
+static int picodlp_i2c_write(struct i2c_client *client, u8 reg, u32 value)
+{
+	u8 data[5];
+	int i;
+
+	data[0] = reg;
+	for (i = 1; i < 5; i++)
+		data[i] = (value >> (32 - (i) * 8)) & 0xFF;
+
+	return picodlp_i2c_write_block(client, data, 5);
+}
+
+static int picodlp_i2c_write_array(struct i2c_client *client,
+			const struct picodlp_i2c_command commands[],
+			int count)
+{
+	int i, r = 0;
+	for (i = 0; i < count; i++) {
+		r = picodlp_i2c_write(client, commands[i].reg,
+						commands[i].value);
+		if (r)
+			return r;
+	}
+	return r;
+}
+
+static bool picodlp_wait_for_dma_done(struct i2c_client *client)
+{
+	u8 trial = MAX_TRIAL_VALUE;
+
+	do {
+		msleep(1);
+		if (!trial--)
+			return -ETIMEDOUT;
+	} while (picodlp_i2c_read(client, MAIN_STATUS) & DMA_STATUS);
+
+	return 0;
+}
+
+/**
+ * picodlp_i2c_init:	i2c_initialization routine
+ * client:	i2c_client for communication
+ *
+ * return
+ *		0	: Success, no error
+ *	error code	: Failure
+ */
+static int picodlp_i2c_init(struct i2c_client *client)
+{
+	int r;
+	static const struct picodlp_i2c_command init_cmd_set1[] = {
+		{SOFT_RESET, 1},
+		{DMD_PARK_TRIGGER, 1},
+		{MISC_REG, 5},
+		{SEQ_CONTROL, 0},
+		{SEQ_VECTOR, 0x100},
+		{DMD_BLOCK_COUNT, 7},
+		{DMD_VCC_CONTROL, 0x109},
+		{DMD_PARK_PULSE_COUNT, 0xA},
+		{DMD_PARK_PULSE_WIDTH, 0xB},
+		{DMD_PARK_DELAY, 0x2ED},
+		{DMD_SHADOW_ENABLE, 0},
+		{FLASH_OPCODE, 0xB},
+		{FLASH_DUMMY_BYTES, 1},
+		{FLASH_ADDR_BYTES, 3},
+		{PBC_CONTROL, 0},
+		{FLASH_START_ADDR, CMT_LUT_0_START_ADDR},
+		{FLASH_READ_BYTES, CMT_LUT_0_SIZE},
+		{CMT_SPLASH_LUT_START_ADDR, 0},
+		{CMT_SPLASH_LUT_DEST_SELECT, CMT_LUT_ALL},
+		{PBC_CONTROL, 1},
+	};
+
+	static const struct picodlp_i2c_command init_cmd_set2[] = {
+		{PBC_CONTROL, 0},
+		{CMT_SPLASH_LUT_DEST_SELECT, 0},
+		{PBC_CONTROL, 0},
+		{FLASH_START_ADDR, SEQUENCE_0_START_ADDR},
+		{FLASH_READ_BYTES, SEQUENCE_0_SIZE},
+		{SEQ_RESET_LUT_START_ADDR, 0},
+		{SEQ_RESET_LUT_DEST_SELECT, SEQ_SEQ_LUT},
+		{PBC_CONTROL, 1},
+	};
+
+	static const struct picodlp_i2c_command init_cmd_set3[] = {
+		{PBC_CONTROL, 0},
+		{SEQ_RESET_LUT_DEST_SELECT, 0},
+		{PBC_CONTROL, 0},
+		{FLASH_START_ADDR, DRC_TABLE_0_START_ADDR},
+		{FLASH_READ_BYTES, DRC_TABLE_0_SIZE},
+		{SEQ_RESET_LUT_START_ADDR, 0},
+		{SEQ_RESET_LUT_DEST_SELECT, SEQ_DRC_LUT_ALL},
+		{PBC_CONTROL, 1},
+	};
+
+	static const struct picodlp_i2c_command init_cmd_set4[] = {
+		{PBC_CONTROL, 0},
+		{SEQ_RESET_LUT_DEST_SELECT, 0},
+		{SDC_ENABLE, 1},
+		{AGC_CTRL, 7},
+		{CCA_C1A, 0x100},
+		{CCA_C1B, 0x0},
+		{CCA_C1C, 0x0},
+		{CCA_C2A, 0x0},
+		{CCA_C2B, 0x100},
+		{CCA_C2C, 0x0},
+		{CCA_C3A, 0x0},
+		{CCA_C3B, 0x0},
+		{CCA_C3C, 0x100},
+		{CCA_C7A, 0x100},
+		{CCA_C7B, 0x100},
+		{CCA_C7C, 0x100},
+		{CCA_ENABLE, 1},
+		{CPU_IF_MODE, 1},
+		{SHORT_FLIP, 1},
+		{CURTAIN_CONTROL, 0},
+		{DMD_PARK_TRIGGER, 0},
+		{R_DRIVE_CURRENT, 0x298},
+		{G_DRIVE_CURRENT, 0x298},
+		{B_DRIVE_CURRENT, 0x298},
+		{RGB_DRIVER_ENABLE, 7},
+		{SEQ_CONTROL, 0},
+		{ACTGEN_CONTROL, 0x10},
+		{SEQUENCE_MODE, SEQ_LOCK},
+		{DATA_FORMAT, RGB888},
+		{INPUT_RESOLUTION, WVGA_864_LANDSCAPE},
+		{INPUT_SOURCE, PARALLEL_RGB},
+		{CPU_IF_SYNC_METHOD, 1},
+		{SEQ_CONTROL, 1}
+	};
+
+	r = picodlp_i2c_write_array(client, init_cmd_set1,
+						ARRAY_SIZE(init_cmd_set1));
+	if (r)
+		return r;
+
+	r = picodlp_wait_for_dma_done(client);
+	if (r)
+		return r;
+
+	r = picodlp_i2c_write_array(client, init_cmd_set2,
+					ARRAY_SIZE(init_cmd_set2));
+	if (r)
+		return r;
+
+	r = picodlp_wait_for_dma_done(client);
+	if (r)
+		return r;
+
+	r = picodlp_i2c_write_array(client, init_cmd_set3,
+					ARRAY_SIZE(init_cmd_set3));
+	if (r)
+		return r;
+
+	r = picodlp_wait_for_dma_done(client);
+	if (r)
+		return r;
+
+	r = picodlp_i2c_write_array(client, init_cmd_set4,
+					ARRAY_SIZE(init_cmd_set4));
+	if (r)
+		return r;
+
+	return 0;
+}
+
+static int picodlp_i2c_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	struct picodlp_i2c_data *picodlp_i2c_data;
+
+	picodlp_i2c_data = kzalloc(sizeof(struct picodlp_i2c_data), GFP_KERNEL);
+
+	if (!picodlp_i2c_data)
+		return -ENOMEM;
+
+	mutex_init(&picodlp_i2c_data->xfer_lock);
+	i2c_set_clientdata(client, picodlp_i2c_data);
+
+	return 0;
+}
+
+static int picodlp_i2c_remove(struct i2c_client *client)
+{
+	struct picodlp_i2c_data *picodlp_i2c_data =
+					i2c_get_clientdata(client);
+
+	kfree(picodlp_i2c_data);
+	i2c_unregister_device(client);
+	return 0;
+}
+
+static struct i2c_driver picodlp_i2c_driver = {
+	.driver = {
+		.name	= "picodlp_i2c_driver",
+	},
+	.probe		= picodlp_i2c_probe,
+	.remove		= picodlp_i2c_remove,
+	.id_table	= picodlp_i2c_id,
+};
+
+static int picodlp_panel_power_on(struct omap_dss_device *dssdev)
+{
+	int r, trial = MAX_TRIAL_VALUE;
+	struct picodlp_data *picod = dev_get_drvdata(&dssdev->dev);
+	struct picodlp_panel_data *picodlp_pdata = get_panel_data(dssdev);
+	struct picodlp_i2c_data *picodlp_i2c_data;
+
+	if (dssdev->platform_enable) {
+		r = dssdev->platform_enable(dssdev);
+		if (r)
+			return r;
+	}
+
+	gpio_set_value(picodlp_pdata->pwrgood_gpio, 0);
+	msleep(1);
+	gpio_set_value(picodlp_pdata->pwrgood_gpio, 1);
+
+	while (!gpio_get_value(picodlp_pdata->emu_done_gpio)) {
+		if (!trial--) {
+			dev_err(&dssdev->dev, "emu_done signal not"
+						" going high\n");
+			return -ETIMEDOUT;
+		}
+		msleep(5);
+	}
+
+	/*
+	 * As per dpp2600 programming guide,
+	 * it is required to sleep for 510ms after emu_done signal goes high
+	 * then only i2c commands can be successfully sent to dpp2600
+	 */
+	msleep(510);
+	if (omapdss_dpi_display_enable(dssdev)) {
+		dev_err(&dssdev->dev, "failed to enable DPI\n");
+		goto err;
+	}
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	picodlp_i2c_data =
+		i2c_get_clientdata(picod->picodlp_i2c_client);
+
+	if (!picodlp_i2c_data) {
+		dev_err(&dssdev->dev, "could not find picodlp i2c data\n");
+		goto err;
+	}
+	r = picodlp_i2c_init(picod->picodlp_i2c_client);
+	if (r)
+		goto err;
+
+	return r;
+err:
+	if (dssdev->platform_disable)
+		dssdev->platform_disable(dssdev);
+
+	return r;
+}
+
+static void picodlp_panel_power_off(struct omap_dss_device *dssdev)
+{
+	struct picodlp_panel_data *picodlp_pdata = get_panel_data(dssdev);
+
+	omapdss_dpi_display_disable(dssdev);
+
+	gpio_set_value(picodlp_pdata->emu_done_gpio, 0);
+	gpio_set_value(picodlp_pdata->pwrgood_gpio, 0);
+
+	if (dssdev->platform_disable)
+		dssdev->platform_disable(dssdev);
+}
+
+static int picodlp_panel_probe(struct omap_dss_device *dssdev)
+{
+	struct picodlp_data *picod;
+	struct picodlp_panel_data *picodlp_pdata = get_panel_data(dssdev);
+	struct i2c_adapter *adapter;
+	struct i2c_client *picodlp_i2c_client;
+	struct picodlp_i2c_data *picodlp_i2c_data;
+	int r = 0, picodlp_adapter_id;
+
+	dssdev->panel.config = OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_ONOFF |
+				OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IVS;
+	dssdev->panel.acb = 0x0;
+	dssdev->panel.timings = pico_ls_timings;
+
+	picod =  kzalloc(sizeof(struct picodlp_data), GFP_KERNEL);
+	if (!picod)
+		return -ENOMEM;
+
+	mutex_init(&picod->lock);
+
+	picodlp_adapter_id = picodlp_pdata->picodlp_adapter_id;
+
+	adapter = i2c_get_adapter(picodlp_adapter_id);
+	if (!adapter) {
+		dev_err(&dssdev->dev, "can't get i2c adapter\n");
+		r = -ENODEV;
+		goto err;
+	}
+
+	picodlp_i2c_client = i2c_new_device(adapter, &picodlp_i2c_board_info);
+	if (!picodlp_i2c_client) {
+		dev_err(&dssdev->dev, "can't add i2c device::"
+					 " picodlp_i2c_client is NULL\n");
+		r = -ENODEV;
+		goto err;
+	}
+
+	picod->picodlp_i2c_client = picodlp_i2c_client;
+
+	picodlp_i2c_data =
+		i2c_get_clientdata(picod->picodlp_i2c_client);
+
+	if (!picodlp_i2c_data) {
+		dev_err(&dssdev->dev, "could not fine picodlp i2c data");
+		r = -ENODEV;
+		goto err;
+	}
+
+	dev_set_drvdata(&dssdev->dev, picod);
+	return r;
+
+err:
+	kfree(picod);
+	return r;
+}
+
+static void picodlp_panel_remove(struct omap_dss_device *dssdev)
+{
+	struct picodlp_data *picod = dev_get_drvdata(&dssdev->dev);
+
+	dev_set_drvdata(&dssdev->dev, NULL);
+	dev_dbg(&dssdev->dev, "removing picodlp panel\n");
+
+	kfree(picod);
+}
+
+static int picodlp_panel_enable(struct omap_dss_device *dssdev)
+{
+	struct picodlp_data *picod = dev_get_drvdata(&dssdev->dev);
+	int r;
+
+	dev_dbg(&dssdev->dev, "enabling picodlp panel\n");
+
+	mutex_lock(&picod->lock);
+	if (dssdev->state != OMAP_DSS_DISPLAY_DISABLED) {
+		mutex_unlock(&picod->lock);
+		return -EINVAL;
+	}
+
+	r = picodlp_panel_power_on(dssdev);
+	mutex_unlock(&picod->lock);
+
+	return r;
+}
+
+static void picodlp_panel_disable(struct omap_dss_device *dssdev)
+{
+	struct picodlp_data *picod = dev_get_drvdata(&dssdev->dev);
+
+	mutex_lock(&picod->lock);
+	/* Turn off DLP Power */
+	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
+		picodlp_panel_power_off(dssdev);
+
+	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
+	mutex_unlock(&picod->lock);
+
+	dev_dbg(&dssdev->dev, "disabling picodlp panel\n");
+}
+
+static int picodlp_panel_suspend(struct omap_dss_device *dssdev)
+{
+	struct picodlp_data *picod = dev_get_drvdata(&dssdev->dev);
+
+	mutex_lock(&picod->lock);
+	/* Turn off DLP Power */
+	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE) {
+		mutex_unlock(&picod->lock);
+		dev_err(&dssdev->dev, "unable to suspend picodlp panel,"
+					" panel is not ACTIVE\n");
+		return -EINVAL;
+	}
+
+	picodlp_panel_power_off(dssdev);
+
+	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
+	mutex_unlock(&picod->lock);
+
+	dev_dbg(&dssdev->dev, "suspending picodlp panel\n");
+	return 0;
+}
+
+static int picodlp_panel_resume(struct omap_dss_device *dssdev)
+{
+	struct picodlp_data *picod = dev_get_drvdata(&dssdev->dev);
+	int r;
+
+	mutex_lock(&picod->lock);
+	if (dssdev->state != OMAP_DSS_DISPLAY_SUSPENDED) {
+		mutex_unlock(&picod->lock);
+		dev_err(&dssdev->dev, "unable to resume picodlp panel,"
+			" panel is not ACTIVE\n");
+		return -EINVAL;
+	}
+
+	r = picodlp_panel_power_on(dssdev);
+	mutex_unlock(&picod->lock);
+	dev_dbg(&dssdev->dev, "resuming picodlp panel\n");
+	return r;
+}
+
+static void picodlp_get_resolution(struct omap_dss_device *dssdev,
+					u16 *xres, u16 *yres)
+{
+	*xres = dssdev->panel.timings.x_res;
+	*yres = dssdev->panel.timings.y_res;
+}
+
+static struct omap_dss_driver picodlp_driver = {
+	.probe		= picodlp_panel_probe,
+	.remove		= picodlp_panel_remove,
+
+	.enable		= picodlp_panel_enable,
+	.disable	= picodlp_panel_disable,
+
+	.get_resolution	= picodlp_get_resolution,
+
+	.suspend	= picodlp_panel_suspend,
+	.resume		= picodlp_panel_resume,
+
+	.driver		= {
+		.name	= "picodlp_panel",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init picodlp_init(void)
+{
+	int r = 0;
+
+	r = i2c_add_driver(&picodlp_i2c_driver);
+	if (r) {
+		printk(KERN_WARNING DRIVER_NAME
+			"driver registration failed\n");
+		return r;
+	}
+
+	r = omap_dss_register_driver(&picodlp_driver);
+	if (r)
+		i2c_del_driver(&picodlp_i2c_driver);
+
+	return r;
+}
+
+static void __exit picodlp_exit(void)
+{
+	i2c_del_driver(&picodlp_i2c_driver);
+	omap_dss_unregister_driver(&picodlp_driver);
+}
+
+module_init(picodlp_init);
+module_exit(picodlp_exit);
+
+MODULE_AUTHOR("Mythri P K <mythripk@ti.com>");
+MODULE_DESCRIPTION("picodlp driver");
+MODULE_LICENSE("GPL");
-- 
1.7.1

