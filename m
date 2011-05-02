From: Mayuresh Janorkar <mayur@ti.com>
Subject: [PATCH v2 5/7] OMAP: DSS: Adding initialization routine to picodlp panel
Date: Mon,  2 May 2011 20:22:49 +0530
Message-ID: <1304347971-1504-6-git-send-email-mayur@ti.com>
References: <1304347971-1504-1-git-send-email-mayur@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56534 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757909Ab1EBOoa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 May 2011 10:44:30 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p42EiUKj021937
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 2 May 2011 09:44:30 -0500
In-Reply-To: <1304347971-1504-1-git-send-email-mayur@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, Mythri P K <mythripk@ti.com>, Mayuresh Janorkar <mayur@ti.com>

From: Mythri P K <mythripk@ti.com>

picodlp_i2c_client needs to send commands over i2c as a part of initialiazation.
system controller dlp pico processor dpp2600 is used.
It configures the splash screen of picodlp using a sequence of commands.
A programmer's guide is available at:
http://focus.ti.com/lit/ug/dlpu002a/dlpu002a.pdf

API is defined for sending command over i2c as an i2c_write operation.

Signed-off-by: Mythri P K <mythripk@ti.com>
Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
---
Changes since v1:
	1. Removed initial splash screen
	2. i2c_commands regrouped
	3. Removed long msleep
	4. Added try-after-sleep in i2c_write

 drivers/video/omap2/displays/panel-picodlp.c |  212 ++++++++++++++++++++++++++
 1 files changed, 212 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-picodlp.c b/drivers/video/omap2/displays/panel-picodlp.c
index fdbfdcf..493a411 100644
--- a/drivers/video/omap2/displays/panel-picodlp.c
+++ b/drivers/video/omap2/displays/panel-picodlp.c
@@ -32,7 +32,15 @@
 #include <plat/display.h>
 #include <plat/panel-picodlp.h>
 
+#include "panel-picodlp.h"
+
 #define DRIVER_NAME	"picodlp_i2c_driver"
+
+/* This defines the minit of data which is allowed into single write block */
+#define MAX_I2C_WRITE_BLOCK_SIZE	32
+#define PICO_MAJOR			1 /* 2 bits */
+#define PICO_MINOR			1 /* 2 bits */
+
 struct picodlp_data {
 	struct mutex lock;
 	struct i2c_client *picodlp_i2c_client;
@@ -50,6 +58,11 @@ struct i2c_device_id picodlp_i2c_id[] = {
 	{ "picodlp_i2c_driver", 0 },
 };
 
+struct picodlp_i2c_command {
+	u8 reg;
+	u32 value;
+};
+
 static struct omap_video_timings pico_ls_timings = {
 	.x_res		= 864,
 	.y_res		= 480,
@@ -70,6 +83,197 @@ static inline struct picodlp_panel_data
 	return (struct picodlp_panel_data *) dssdev->data;
 }
 
+static int picodlp_i2c_write_block(struct i2c_client *client,
+					u8 *data, int len)
+{
+	struct i2c_msg msg;
+	int i, r, msg_count = 1, trial = 4;
+
+	struct picodlp_i2c_data *picodlp_i2c_data = i2c_get_clientdata(client);
+
+	if (len < 1 || len > MAX_I2C_WRITE_BLOCK_SIZE) {
+		dev_err(&client->dev,
+			"too long syn_write_block len %d\n", len);
+		return -EIO;
+	}
+retry:
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
+	 * i2c controller might timeout, in such a case sleep for sometime
+	 * and then retry
+	 */
+	if (r != msg_count) {
+		msleep(2);
+		if (trial--)
+			goto retry;
+
+		dev_err(&client->dev, " picodlp_i2c_write error\n");
+		return r;
+	}
+
+	/* In case of success */
+	for (i = 0; i < len; i++)
+		dev_dbg(&client->dev,
+			"addr %x bw 0x%02x[%d]: 0x%02x\n",
+			client->addr, data[0] + i, i, data[i]);
+
+	return 0;
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
+/**
+ * picodlp_i2c_init:	i2c_initialization routine
+ * client:	i2c_client for communication
+ *
+ * @return
+ *		0	: Success, no error
+ *	error code	: Failure
+ */
+static int picodlp_i2c_init(struct i2c_client *client)
+{
+	int r;
+	static const struct picodlp_i2c_command init_cmd_set1[] = {
+		{SOFT_RESET, 1},
+		{DMD_PARK_TRIGGER, 1},
+		{MISC_REG, (PICO_MAJOR << 2 | PICO_MINOR)},
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
+	msleep(2);
+
+	r = picodlp_i2c_write_array(client, init_cmd_set2,
+					ARRAY_SIZE(init_cmd_set2));
+	if (r)
+		return r;
+	msleep(2);
+
+	r = picodlp_i2c_write_array(client, init_cmd_set3,
+					ARRAY_SIZE(init_cmd_set3));
+	if (r)
+		return r;
+	msleep(2);
+
+	r = picodlp_i2c_write_array(client, init_cmd_set4,
+					ARRAY_SIZE(init_cmd_set4));
+	if (r)
+		return r;
+
+	return 0;
+}
+
 static int picodlp_i2c_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
@@ -109,6 +313,7 @@ static int picodlp_panel_power_on(struct omap_dss_device *dssdev)
 	int r = 0;
 	struct picodlp_data *picod = dev_get_drvdata(&dssdev->dev);
 	struct picodlp_panel_data *picodlp_pdata;
+	struct picodlp_i2c_data *picodlp_i2c_data;
 
 	picodlp_pdata = get_panel_data(dssdev);
 	gpio_set_value(picodlp_pdata->display_sel_gpio, 1);
@@ -128,6 +333,13 @@ static int picodlp_panel_power_on(struct omap_dss_device *dssdev)
 	}
 	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
 
+	picodlp_i2c_data =
+		i2c_get_clientdata(picod->picodlp_i2c_client);
+
+	r = picodlp_i2c_init(picod->picodlp_i2c_client);
+	if (r)
+		goto err;
+
 	return r;
 err:
 	if (dssdev->platform_disable)
-- 
1.7.1

