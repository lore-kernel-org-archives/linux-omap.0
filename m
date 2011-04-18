From: Mayuresh Janorkar <mayur@ti.com>
Subject: [PATCH 5/7] OMAP: DSS: Adding initialization routine to picodlp panel
Date: Mon, 18 Apr 2011 11:45:48 +0530
Message-ID: <1303107350-22747-6-git-send-email-mayur@ti.com>
References: <1303107350-22747-1-git-send-email-mayur@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42348 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751911Ab1DRF7S (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Apr 2011 01:59:18 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p3I5xI5X023240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 18 Apr 2011 00:59:18 -0500
In-Reply-To: <1303107350-22747-1-git-send-email-mayur@ti.com>
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
 drivers/video/omap2/displays/panel-picodlp.c |  317 ++++++++++++++++++++++++++
 1 files changed, 317 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-picodlp.c b/drivers/video/omap2/displays/panel-picodlp.c
index e361674..785e406 100644
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
@@ -70,6 +83,305 @@ static inline struct picodlp_panel_data
 	return (struct picodlp_panel_data *) dssdev->data;
 }
 
+static int picodlp_i2c_write_block(struct i2c_client *client,
+					u8 *data, int len)
+{
+	struct i2c_msg msg;
+	int i, r;
+
+	struct picodlp_i2c_data *picodlp_i2c_data = i2c_get_clientdata(client);
+
+	if (len < 1 || len > MAX_I2C_WRITE_BLOCK_SIZE) {
+		dev_err(&client->dev,
+			"too long syn_write_block len %d\n", len);
+		return -EIO;
+	}
+
+	mutex_lock(&picodlp_i2c_data->xfer_lock);
+
+	msg.addr = client->addr;
+	msg.flags = 0;
+	msg.len = len;
+	msg.buf = data;
+
+	r = i2c_transfer(client->adapter, &msg, 1);
+	mutex_unlock(&picodlp_i2c_data->xfer_lock);
+
+	if (r == 1) {
+		for (i = 0; i < len; i++)
+			dev_dbg(&client->dev,
+				"addr %x bw 0x%02x[%d]: 0x%02x\n",
+				client->addr, data[0] + i, i, data[i]);
+		return 0;
+	}
+
+	dev_err(&client->dev, " picodlp_i2c_write error\n");
+	return r;
+}
+
+static int picodlp_i2c_write(struct i2c_client *client, u8 reg, u32 value)
+{
+	u8 data[5];
+
+	data[0] = reg;
+	data[1] = (value & 0xFF000000) >> 24;
+	data[2] = (value & 0x00FF0000) >> 16;
+	data[3] = (value & 0x0000FF00) >> 8;
+	data[4] = (value & 0x000000FF);
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
+/**
+ * picodlp_dpp2600_flash_dma - return parameter as 0 on success or error code
+ * Configure datapath for splash image operation
+ * dpp2600 : digitally programmable potentiometer
+ * It is a system controller used for picodlp
+ *
+ * @client:		i2c_client required for operations
+ * @flash_address:	splash image to be loaded from flash
+ * @flash_num_bytes:	size in bytes for flash
+ * @cmt_seqz:		select mailbox to load data to
+ *			0 = sequence/DRC,
+ *			1 = CMT/splash
+ * @table_number:	table_number to load flash
+ *
+ * @return
+ *		0	-	no errors
+ *		-ENXIO	- invalid flash address specified
+ *		-EINVAL - invalid mailbox specified OR invalid table_number
+ *				OR mailbox combination
+ */
+static int picodlp_dpp2600_flash_dma(struct i2c_client *client,
+		int flash_address, int flash_num_bytes, int cmt_seqz,
+		int table_number)
+{
+	int mailbox_address, mailbox_select;
+	int r = 0;
+
+	/* check argument validity */
+	if (flash_address > 0x1fffff)
+		return -ENXIO;
+
+	if ((cmt_seqz > 1) || (cmt_seqz == 0 && table_number > 6) ||
+				(cmt_seqz == 1 && table_number > 5))
+		return -EINVAL;
+
+	/* set mailbox parameters */
+	if (cmt_seqz) {
+		mailbox_address = CMT_SPLASH_LUT_START_ADDR;
+		mailbox_select = CMT_SPLASH_LUT_DEST_SELECT;
+	} else {
+		mailbox_address = SEQ_RESET_LUT_START_ADDR;
+		mailbox_select = SEQ_RESET_LUT_DEST_SELECT;
+	}
+
+	/* configure DMA from flash to LUT */
+	r = picodlp_i2c_write(client, PBC_CONTROL, 0);
+	if (r)
+		return r;
+
+	 r = picodlp_i2c_write(client, FLASH_START_ADDR, flash_address);
+	 if (r)
+		return r;
+
+	 r = picodlp_i2c_write(client, FLASH_READ_BYTES, flash_num_bytes);
+	if (r)
+		return r;
+
+	r = picodlp_i2c_write(client, mailbox_address, 0);
+	if (r)
+		return r;
+
+	r = picodlp_i2c_write(client, mailbox_select, table_number);
+	if (r)
+		return r;
+
+	/* transfer control to flash controller */
+	r = picodlp_i2c_write(client, PBC_CONTROL, 1);
+	if (r)
+		return r;
+
+	/**
+	 * wait for control transfer
+	 * this usually takes close to 5ms
+	 */
+	msleep(5);
+
+	/* return register access to i2c client */
+	 r = picodlp_i2c_write(client, PBC_CONTROL, 0);
+	 if (r)
+		return r;
+
+	/* close LUT access */
+	 r = picodlp_i2c_write(client, mailbox_select, 0);
+	 if (r)
+		return r;
+
+	return 0;
+}
+
+/**
+ * picodlp_dpp2600_config_rgb: returns 0 on success and error code on failure
+ * Configure datapath for parallel RGB operation
+ * dpp2600 : digitally programmable potentiometer
+ * It is a system controller used for picodlp
+ *
+ * @client: i2c_client:		i2c_client required for communication
+ * @return:
+ *			0	: Success, no error
+ *		 error code	: Failure
+ */
+static int picodlp_dpp2600_config_rgb(struct i2c_client *client)
+{
+	int r = 0;
+
+	static const struct picodlp_i2c_command config_commands[] = {
+		{SEQ_CONTROL, 0}, {ACTGEN_CONTROL, 0x10},
+		{SEQUENCE_MODE, SEQ_LOCK}, {DATA_FORMAT, RGB888},
+		{INPUT_RESOLUTION, WVGA_864_LANDSCAPE},
+		{INPUT_SOURCE, PARALLEL_RGB}, {CPU_IF_SYNC_METHOD, 1},
+		{SEQ_CONTROL, 1}
+	};
+
+	r = picodlp_i2c_write_array(client, config_commands,
+					ARRAY_SIZE(config_commands));
+	return r;
+}
+
+/**
+ * picodlp_dpp2600_config_splash returns 0 on success and
+ *					error code in case of failure
+ * Configure datapath for splash image operation
+ * dpp2600 : digitally programmable potentiometer
+ * It is a system controller used for picodlp
+ *
+ * @return
+ *		0	- no errors
+ *		-EINVAL - invalid image_number specified
+ */
+static int picodlp_dpp2600_config_splash(struct i2c_client *client)
+{
+	int r;
+
+	static const struct picodlp_i2c_command splash_cmd[] = {
+		{SEQ_CONTROL, 0}, {SEQUENCE_MODE, SEQ_FREE_RUN},
+		{DATA_FORMAT, RGB565}, {INPUT_RESOLUTION, QWVGA_LANDSCAPE},
+		{INPUT_SOURCE, SPLASH_SCREEN}
+	};
+
+	r = picodlp_i2c_write_array(client, splash_cmd,
+					ARRAY_SIZE(splash_cmd));
+	if (r)
+		return r;
+
+	r = picodlp_dpp2600_flash_dma(client, SPLASH_1_START_ADDR,
+					SPLASH_1_SIZE, 1, SPLASH_LUT);
+	if (r)
+		return r;
+
+	/* turn image back on */
+	r = picodlp_i2c_write(client, SEQ_CONTROL, 1);
+	if (r)
+		return r;
+
+	return 0;
+}
+
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
+		{SOFT_RESET, 1}, {DMD_PARK_TRIGGER, 1},
+		{MISC_REG, (PICO_MAJOR << 2 | PICO_MINOR)}, {SEQ_CONTROL, 0},
+		{SEQ_VECTOR, 0x100}, {DMD_BLOCK_COUNT, 7},
+		{DMD_VCC_CONTROL, 0x109}, {DMD_PARK_PULSE_COUNT, 0xA},
+		{DMD_PARK_PULSE_WIDTH, 0xB}, {DMD_PARK_DELAY, 0x2ED},
+		{DMD_SHADOW_ENABLE, 0}, {FLASH_OPCODE, 0xB},
+		{FLASH_DUMMY_BYTES, 1}, {FLASH_ADDR_BYTES, 3},
+	};
+
+	static const struct picodlp_i2c_command init_cmd_set2[] = {
+		{SDC_ENABLE, 1}, {AGC_CTRL, 7},	{CCA_C1A, 0x100},
+		{CCA_C1B, 0x0},	{CCA_C1C, 0x0},	{CCA_C2A, 0x0},
+		{CCA_C2B, 0x100}, {CCA_C2C, 0x0}, {CCA_C3A, 0x0},
+		{CCA_C3B, 0x0},	{CCA_C3C, 0x100}, {CCA_C7A, 0x100},
+		{CCA_C7B, 0x100}, {CCA_C7C, 0x100}, {CCA_ENABLE, 1},
+		{CPU_IF_MODE, 1}, {SHORT_FLIP, 1}, {CURTAIN_CONTROL, 0},
+	};
+
+	static const struct picodlp_i2c_command init_cmd_set3[] = {
+		{DMD_PARK_TRIGGER, 0}, {R_DRIVE_CURRENT, 0x298},
+		{G_DRIVE_CURRENT, 0x298}, {B_DRIVE_CURRENT, 0x298},
+		{RGB_DRIVER_ENABLE, 7},
+	};
+
+	r = picodlp_i2c_write_array(client, init_cmd_set1,
+						ARRAY_SIZE(init_cmd_set1));
+	if (r)
+		return r;
+
+	/* configure DMA from flash to LUT */
+	r = picodlp_dpp2600_flash_dma(client, CMT_LUT_0_START_ADDR,
+					CMT_LUT_0_SIZE, 1, CMT_LUT_ALL);
+	if (r)
+		return r;
+
+	/* SEQ and DRC look-up tables */
+	r = picodlp_dpp2600_flash_dma(client, SEQUENCE_0_START_ADDR,
+					SEQUENCE_0_SIZE, 0, SEQ_SEQ_LUT);
+	if (r)
+		return r;
+
+	r = picodlp_dpp2600_flash_dma(client, DRC_TABLE_0_START_ADDR,
+					DRC_TABLE_0_SIZE, 0, SEQ_DRC_LUT_ALL);
+	if (r)
+		return r;
+
+	r = picodlp_i2c_write_array(client, init_cmd_set2,
+					ARRAY_SIZE(init_cmd_set2));
+	if (r)
+		return r;
+
+	/* display logo splash image */
+	r = picodlp_dpp2600_config_splash(client);
+	if (r)
+		return r;
+
+	r = picodlp_i2c_write_array(client, init_cmd_set3,
+					ARRAY_SIZE(init_cmd_set3));
+	if (r)
+		return r;
+
+	r = picodlp_dpp2600_config_rgb(client);
+	if (r)
+		return r;
+
+	return 0;
+}
+
 static int picodlp_i2c_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
@@ -134,6 +446,11 @@ static int picodlp_panel_power_on(struct omap_dss_device *dssdev)
 	picodlp_i2c_data =
 		i2c_get_clientdata(picod->picodlp_i2c_client);
 
+	msleep(700); /* sleep till panel is settled */
+	r = picodlp_i2c_init(picod->picodlp_i2c_client);
+	if (r)
+		goto err;
+
 	return r;
 err:
 	if (dssdev->platform_disable)
-- 
1.7.1

