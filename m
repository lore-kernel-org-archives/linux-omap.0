From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 4/4] OMAP: DSS: Add picodlp panel driver
Date: Tue, 10 May 2011 12:33:20 +0300
Message-ID: <1305020000.3237.16.camel@lappyti>
References: <1304954319-8386-1-git-send-email-mayur@ti.com>
	 <1304954319-8386-5-git-send-email-mayur@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:53735 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751664Ab1EJJd0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 May 2011 05:33:26 -0400
Received: by mail-ew0-f44.google.com with SMTP id 19so2636868ewy.17
        for <linux-omap@vger.kernel.org>; Tue, 10 May 2011 02:33:25 -0700 (PDT)
In-Reply-To: <1304954319-8386-5-git-send-email-mayur@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mayuresh Janorkar <mayur@ti.com>
Cc: linux-omap@vger.kernel.org

On Mon, 2011-05-09 at 20:48 +0530, Mayuresh Janorkar wrote:
> picodlp panel driver is required for driving DLP dpp2600.
> It consists of a dss driver and an i2c_client.
> 
> i2c_client is required for sending commands to dpp (DLP Pico Projector).
> 
> The power-up sequence consists of:
> Setting PWRGOOD to a logic low state. Once power is stable and thus the DPP2600
> is stable, then PWRGOOD should be deactivated (Set to a logic high).
> The DPP2600 will then perform a power-up initialization routine that will first
> configure and lock its PLL followed by loading self configuration data from
> external flash. DPP2600 would be activated and the EMU_DONE signal will be
> driven high. After this once internal initialization routine,
> which will take approximately 510ms, i2c commands can be sent.
> 
> To know more please visit: http://www.omappedia.org/wiki/PicoDLP_projector_guide
> 
> Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
> ---
> Changes since v2:
> 	Merged panel picodlp patches into a single patch
> 	Introduced DMA_DONE polling between flash transfer
> 	Changed GPIO handling
> 	Reduced sleeps
> 
>  drivers/video/omap2/displays/Kconfig         |    7 +
>  drivers/video/omap2/displays/Makefile        |    1 +
>  drivers/video/omap2/displays/panel-picodlp.c |  627 ++++++++++++++++++++++++++
>  3 files changed, 635 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/omap2/displays/panel-picodlp.c
> 
> diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
> index 609a280..0b05593 100644
> --- a/drivers/video/omap2/displays/Kconfig
> +++ b/drivers/video/omap2/displays/Kconfig
> @@ -30,6 +30,13 @@ config PANEL_NEC_NL8048HL11_01B
>  		This NEC NL8048HL11-01B panel is TFT LCD
>  		used in the Zoom2/3/3630 sdp boards.
>  
> +config PANEL_PICODLP
> +	tristate "OMAP PICO DLP Panel"
> +	depends on OMAP2_DSS
> +	help
> +		Projector Panel used in TI's SDP4430 and EVM boards
> +		For more info please visit http://www.dlp.com/projector/
> +
>  config PANEL_TAAL
>          tristate "Taal DSI Panel"
>          depends on OMAP2_DSS_DSI
> diff --git a/drivers/video/omap2/displays/Makefile b/drivers/video/omap2/displays/Makefile
> index 0f601ab..d90f73c 100644
> --- a/drivers/video/omap2/displays/Makefile
> +++ b/drivers/video/omap2/displays/Makefile
> @@ -4,5 +4,6 @@ obj-$(CONFIG_PANEL_SHARP_LS037V7DW01) += panel-sharp-ls037v7dw01.o
>  obj-$(CONFIG_PANEL_NEC_NL8048HL11_01B) += panel-nec-nl8048hl11-01b.o
>  
>  obj-$(CONFIG_PANEL_TAAL) += panel-taal.o
> +obj-$(CONFIG_PANEL_PICODLP) +=  panel-picodlp.o
>  obj-$(CONFIG_PANEL_TPO_TD043MTEA1) += panel-tpo-td043mtea1.o
>  obj-$(CONFIG_PANEL_ACX565AKM) += panel-acx565akm.o
> diff --git a/drivers/video/omap2/displays/panel-picodlp.c b/drivers/video/omap2/displays/panel-picodlp.c
> new file mode 100644
> index 0000000..432f987
> --- /dev/null
> +++ b/drivers/video/omap2/displays/panel-picodlp.c
> @@ -0,0 +1,627 @@
> +/*
> +
> + * picodlp panel driver
> + * picodlp_i2c_driver: i2c_client driver
> + *
> + * Copyright (C) 2009-2011 Texas Instruments
> + * Author: Mythri P K <mythripk@ti.com>
> + * Mayuresh Janorkar <mayur@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/input.h>
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/firmware.h>
> +#include <linux/slab.h>
> +#include <linux/mutex.h>
> +#include <linux/i2c.h>
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +
> +#include <plat/display.h>
> +#include <plat/panel-picodlp.h>
> +
> +#include "panel-picodlp.h"
> +
> +#define DRIVER_NAME	"picodlp_i2c_driver"
> +
> +/* This defines the minit of data which is allowed into single write block */
> +#define MAX_I2C_WRITE_BLOCK_SIZE	32
> +#define PICO_MAJOR			1 /* 2 bits */
> +#define PICO_MINOR			1 /* 2 bits */
> +#define MAX_TRIAL_VALUE		50

The name of this define is not descriptive and you use this define in
two places which have nothing to do with each other. I think it's better
just to use the value where it's needed.

> +struct picodlp_data {
> +	struct mutex lock;
> +	struct i2c_client *picodlp_i2c_client;
> +};
> +
> +static struct i2c_board_info picodlp_i2c_board_info = {
> +	I2C_BOARD_INFO("picodlp_i2c_driver", 0x1b),
> +};
> +
> +struct picodlp_i2c_data {
> +	struct mutex xfer_lock;
> +};
> +
> +struct i2c_device_id picodlp_i2c_id[] = {
> +	{ "picodlp_i2c_driver", 0 },
> +};
> +
> +struct picodlp_i2c_command {
> +	u8 reg;
> +	u32 value;
> +};
> +
> +static struct omap_video_timings pico_ls_timings = {
> +	.x_res		= 864,
> +	.y_res		= 480,
> +	.hsw		= 7,
> +	.hfp		= 11,
> +	.hbp		= 7,
> +
> +	.pixel_clock	= 19200,
> +
> +	.vsw		= 2,
> +	.vfp		= 3,
> +	.vbp		= 14,
> +};
> +
> +static inline struct picodlp_panel_data
> +		*get_panel_data(const struct omap_dss_device *dssdev)
> +{
> +	return (struct picodlp_panel_data *) dssdev->data;
> +}
> +
> +static u32 picodlp_i2c_read(struct i2c_client *client, u8 reg)
> +{
> +	u8 read_cmd[] = {READ_REG_SELECT, reg}, data[4];
> +	struct picodlp_i2c_data *picodlp_i2c_data = i2c_get_clientdata(client);
> +	struct i2c_msg msg[2];
> +
> +	mutex_lock(&picodlp_i2c_data->xfer_lock);
> +
> +	msg[0].addr = client->addr;
> +	msg[0].flags = 0;
> +	msg[0].len = 2;
> +	msg[0].buf = read_cmd;
> +
> +	msg[1].addr = client->addr;
> +	msg[1].flags = I2C_M_RD;
> +	msg[1].len = 4;
> +	msg[1].buf = data;
> +
> +	i2c_transfer(client->adapter, msg, 2);
> +	mutex_unlock(&picodlp_i2c_data->xfer_lock);
> +	return (data[3] | (data[2] << 8) | (data[1] << 16) | (data[0] << 24));
> +}
> +
> +static int picodlp_i2c_write_block(struct i2c_client *client,
> +					u8 *data, int len)
> +{
> +	struct i2c_msg msg;
> +	int i, r, msg_count = 1;
> +
> +	struct picodlp_i2c_data *picodlp_i2c_data = i2c_get_clientdata(client);
> +
> +	if (len < 1 || len > MAX_I2C_WRITE_BLOCK_SIZE) {
> +		dev_err(&client->dev,
> +			"too long syn_write_block len %d\n", len);
> +		return -EIO;
> +	}
> +	mutex_lock(&picodlp_i2c_data->xfer_lock);
> +
> +	msg.addr = client->addr;
> +	msg.flags = 0;
> +	msg.len = len;
> +	msg.buf = data;
> +	r = i2c_transfer(client->adapter, &msg, msg_count);
> +	mutex_unlock(&picodlp_i2c_data->xfer_lock);
> +
> +	/*
> +	 * i2c_transfer returns:
> +	 * number of messages sent in case of success
> +	 * a negative error number in case of failure
> +	 * i2c controller might timeout, in such a case sleep for sometime
> +	 * and then retry
> +	 */

The comment here doesn't look right, there's no retry.

> +	if (r != msg_count)
> +		goto err;
> +
> +	/* In case of success */
> +	for (i = 0; i < len; i++)
> +		dev_dbg(&client->dev,
> +			"addr %x bw 0x%02x[%d]: 0x%02x\n",
> +			client->addr, data[0] + i, i, data[i]);
> +
> +	return 0;
> +err:
> +	dev_err(&client->dev, "picodlp_i2c_write error\n");
> +	return r;
> +}
> +
> +static int picodlp_i2c_write(struct i2c_client *client, u8 reg, u32 value)
> +{
> +	u8 data[5];
> +	int i;
> +
> +	data[0] = reg;
> +	for (i = 1; i < 5; i++)
> +		data[i] = (value >> (32 - (i) * 8)) & 0xFF;
> +
> +	return picodlp_i2c_write_block(client, data, 5);
> +}
> +
> +static int picodlp_i2c_write_array(struct i2c_client *client,
> +			const struct picodlp_i2c_command commands[],
> +			int count)
> +{
> +	int i, r = 0;
> +	for (i = 0; i < count; i++) {
> +		r = picodlp_i2c_write(client, commands[i].reg,
> +						commands[i].value);
> +		if (r)
> +			return r;
> +	}
> +	return r;
> +}
> +
> +static bool picodlp_wait_for_dma_done(struct i2c_client *client)
> +{
> +	u8 trial = MAX_TRIAL_VALUE;
> +
> +	do {
> +		msleep(1);
> +		if (!trial--)
> +			return -ETIMEDOUT;
> +	} while (picodlp_i2c_read(client, MAIN_STATUS) & DMA_STATUS);
> +
> +	return 0;
> +}
> +
> +/**
> + * picodlp_i2c_init:	i2c_initialization routine
> + * client:	i2c_client for communication
> + *
> + * @return
> + *		0	: Success, no error
> + *	error code	: Failure
> + */
> +static int picodlp_i2c_init(struct i2c_client *client)
> +{
> +	int r;
> +	static const struct picodlp_i2c_command init_cmd_set1[] = {
> +		{SOFT_RESET, 1},
> +		{DMD_PARK_TRIGGER, 1},
> +		{MISC_REG, (PICO_MAJOR << 2 | PICO_MINOR)},
> +		{SEQ_CONTROL, 0},
> +		{SEQ_VECTOR, 0x100},
> +		{DMD_BLOCK_COUNT, 7},
> +		{DMD_VCC_CONTROL, 0x109},
> +		{DMD_PARK_PULSE_COUNT, 0xA},
> +		{DMD_PARK_PULSE_WIDTH, 0xB},
> +		{DMD_PARK_DELAY, 0x2ED},
> +		{DMD_SHADOW_ENABLE, 0},
> +		{FLASH_OPCODE, 0xB},
> +		{FLASH_DUMMY_BYTES, 1},
> +		{FLASH_ADDR_BYTES, 3},
> +		{PBC_CONTROL, 0},
> +		{FLASH_START_ADDR, CMT_LUT_0_START_ADDR},
> +		{FLASH_READ_BYTES, CMT_LUT_0_SIZE},
> +		{CMT_SPLASH_LUT_START_ADDR, 0},
> +		{CMT_SPLASH_LUT_DEST_SELECT, CMT_LUT_ALL},
> +		{PBC_CONTROL, 1},
> +	};
> +
> +	static const struct picodlp_i2c_command init_cmd_set2[] = {
> +		{PBC_CONTROL, 0},
> +		{CMT_SPLASH_LUT_DEST_SELECT, 0},
> +		{PBC_CONTROL, 0},
> +		{FLASH_START_ADDR, SEQUENCE_0_START_ADDR},
> +		{FLASH_READ_BYTES, SEQUENCE_0_SIZE},
> +		{SEQ_RESET_LUT_START_ADDR, 0},
> +		{SEQ_RESET_LUT_DEST_SELECT, SEQ_SEQ_LUT},
> +		{PBC_CONTROL, 1},
> +	};
> +
> +	static const struct picodlp_i2c_command init_cmd_set3[] = {
> +		{PBC_CONTROL, 0},
> +		{SEQ_RESET_LUT_DEST_SELECT, 0},
> +		{PBC_CONTROL, 0},
> +		{FLASH_START_ADDR, DRC_TABLE_0_START_ADDR},
> +		{FLASH_READ_BYTES, DRC_TABLE_0_SIZE},
> +		{SEQ_RESET_LUT_START_ADDR, 0},
> +		{SEQ_RESET_LUT_DEST_SELECT, SEQ_DRC_LUT_ALL},
> +		{PBC_CONTROL, 1},
> +	};
> +
> +	static const struct picodlp_i2c_command init_cmd_set4[] = {
> +		{PBC_CONTROL, 0},
> +		{SEQ_RESET_LUT_DEST_SELECT, 0},
> +		{SDC_ENABLE, 1},
> +		{AGC_CTRL, 7},
> +		{CCA_C1A, 0x100},
> +		{CCA_C1B, 0x0},
> +		{CCA_C1C, 0x0},
> +		{CCA_C2A, 0x0},
> +		{CCA_C2B, 0x100},
> +		{CCA_C2C, 0x0},
> +		{CCA_C3A, 0x0},
> +		{CCA_C3B, 0x0},
> +		{CCA_C3C, 0x100},
> +		{CCA_C7A, 0x100},
> +		{CCA_C7B, 0x100},
> +		{CCA_C7C, 0x100},
> +		{CCA_ENABLE, 1},
> +		{CPU_IF_MODE, 1},
> +		{SHORT_FLIP, 1},
> +		{CURTAIN_CONTROL, 0},
> +		{DMD_PARK_TRIGGER, 0},
> +		{R_DRIVE_CURRENT, 0x298},
> +		{G_DRIVE_CURRENT, 0x298},
> +		{B_DRIVE_CURRENT, 0x298},
> +		{RGB_DRIVER_ENABLE, 7},
> +		{SEQ_CONTROL, 0},
> +		{ACTGEN_CONTROL, 0x10},
> +		{SEQUENCE_MODE, SEQ_LOCK},
> +		{DATA_FORMAT, RGB888},
> +		{INPUT_RESOLUTION, WVGA_864_LANDSCAPE},
> +		{INPUT_SOURCE, PARALLEL_RGB},
> +		{CPU_IF_SYNC_METHOD, 1},
> +		{SEQ_CONTROL, 1}
> +	};
> +
> +	msleep(510);

You are again sleeping in a place where there are no clear actions after
and before the sleep. You should always sleep between two well defined
actions. In this case it's the emu_done going up and the first i2c
transaction, so a better place for this sleep is in the power_on
function, before calling this function. With a comment saying what we
are waiting for.

> +	r = picodlp_i2c_write_array(client, init_cmd_set1,
> +						ARRAY_SIZE(init_cmd_set1));
> +	if (r)
> +		return r;
> +
> +	r = picodlp_wait_for_dma_done(client);
> +	if (r)
> +		return r;
> +
> +	r = picodlp_i2c_write_array(client, init_cmd_set2,
> +					ARRAY_SIZE(init_cmd_set2));
> +	if (r)
> +		return r;
> +
> +	r = picodlp_wait_for_dma_done(client);
> +	if (r)
> +		return r;
> +
> +	r = picodlp_i2c_write_array(client, init_cmd_set3,
> +					ARRAY_SIZE(init_cmd_set3));
> +	if (r)
> +		return r;
> +
> +	r = picodlp_wait_for_dma_done(client);
> +	if (r)
> +		return r;
> +
> +	r = picodlp_i2c_write_array(client, init_cmd_set4,
> +					ARRAY_SIZE(init_cmd_set4));
> +	if (r)
> +		return r;
> +
> +	return 0;
> +}
> +
> +static int picodlp_i2c_probe(struct i2c_client *client,
> +		const struct i2c_device_id *id)
> +{
> +	struct picodlp_i2c_data *picodlp_i2c_data;
> +
> +	picodlp_i2c_data = kzalloc(sizeof(struct picodlp_i2c_data), GFP_KERNEL);
> +
> +	if (!picodlp_i2c_data)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, picodlp_i2c_data);
> +
> +	return 0;
> +}
> +
> +static int picodlp_i2c_remove(struct i2c_client *client)
> +{
> +	struct picodlp_i2c_data *picodlp_i2c_data =
> +					i2c_get_clientdata(client);
> +
> +	kfree(picodlp_i2c_data);
> +	i2c_unregister_device(client);
> +	return 0;
> +}
> +
> +static struct i2c_driver picodlp_i2c_driver = {
> +	.driver = {
> +		.name	= "picodlp_i2c_driver",
> +	},
> +	.probe		= picodlp_i2c_probe,
> +	.remove		= picodlp_i2c_remove,
> +	.id_table	= picodlp_i2c_id,
> +};
> +
> +static int picodlp_panel_power_on(struct omap_dss_device *dssdev)
> +{
> +	int r = 0, trial = MAX_TRIAL_VALUE;
> +	struct picodlp_data *picod = dev_get_drvdata(&dssdev->dev);
> +	struct picodlp_panel_data *picodlp_pdata;
> +	struct picodlp_i2c_data *picodlp_i2c_data;
> +
> +	picodlp_pdata = get_panel_data(dssdev);
> +	if (dssdev->platform_enable) {
> +		r = dssdev->platform_enable(dssdev);
> +		if (r)
> +			return r;
> +	}
> +
> +	gpio_set_value(picodlp_pdata->pwrgood_gpio, 0);
> +	msleep(1);
> +	gpio_set_value(picodlp_pdata->pwrgood_gpio, 1);
> +
> +	while (!gpio_get_value(picodlp_pdata->emu_done_gpio)) {
> +		if (!trial--) {
> +			dev_err(&dssdev->dev, "emu_done signal not"
> +						" going down\n");
> +			return -ETIMEDOUT;
> +		}
> +		msleep(5);
> +	}

You defined the trial value to 50, which means this could timeout after
250ms. If I remember right, it could take 500ms until emu_done changes.
And your error says "going down", doesn't the emu_done gpio go up when
it's ready?

> +
> +	r = omapdss_dpi_display_enable(dssdev);
> +	if (r) {
> +		dev_err(&dssdev->dev, "failed to enable DPI\n");
> +		goto err;
> +	}
> +	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
> +
> +	picodlp_i2c_data =
> +		i2c_get_clientdata(picod->picodlp_i2c_client);
> +
> +	r = picodlp_i2c_init(picod->picodlp_i2c_client);
> +	if (r)
> +		goto err;
> +
> +	return r;
> +err:
> +	if (dssdev->platform_disable)
> +		dssdev->platform_disable(dssdev);
> +
> +	return r;
> +}
> +
> +static void picodlp_panel_power_off(struct omap_dss_device *dssdev)
> +{
> +	struct picodlp_panel_data *picodlp_pdata = get_panel_data(dssdev);
> +
> +	omapdss_dpi_display_disable(dssdev);
> +
> +	gpio_set_value(picodlp_pdata->emu_done_gpio, 0);

emu_done is an input pin, you can't set its value.

> +	gpio_set_value(picodlp_pdata->pwrgood_gpio, 0);
> +
> +	if (dssdev->platform_disable)
> +		dssdev->platform_disable(dssdev);
> +}
> +
> +static int picodlp_panel_probe(struct omap_dss_device *dssdev)
> +{
> +	struct picodlp_data *picod;
> +	struct picodlp_panel_data *picodlp_pdata = get_panel_data(dssdev);
> +	struct i2c_adapter *adapter;
> +	struct i2c_client *picodlp_i2c_client;
> +	struct picodlp_i2c_data *picodlp_i2c_data;
> +	struct gpio picodlp_gpios[] = {
> +		{picodlp_pdata->emu_done_gpio, GPIOF_IN, "DLP EMU DONE"},
> +		{picodlp_pdata->pwrgood_gpio, GPIOF_INIT_LOW, "DLP PWRGOOD"},
> +	};

pwrgood_gpio should be GPIOF_OUT_INIT_LOW.

It is better to request and initialize the GPIOs in the board file. The
reason for this is that the PicoDLP device should be off if it's not
used, or if the driver is not even compiled in. So the board file should
make sure that the GPIOs are in such state that the device is off.

> +
> +	int r = 0, picodlp_adapter_id;
> +
> +	dssdev->panel.config = OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_ONOFF |
> +				OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IVS;
> +	dssdev->panel.acb = 0x0;
> +	dssdev->panel.timings = pico_ls_timings;
> +
> +	picod =  kzalloc(sizeof(struct picodlp_data), GFP_KERNEL);
> +	if (!picod)
> +		return -ENOMEM;
> +
> +	mutex_init(&picod->lock);
> +
> +	r = gpio_request_array(picodlp_gpios, ARRAY_SIZE(picodlp_gpios));
> +	if (r) {
> +		dev_err(&dssdev->dev, "can't get dlp gpios\n");
> +		goto err;
> +	}
> +
> +	picodlp_adapter_id = picodlp_pdata->picodlp_adapter_id;
> +
> +	adapter = i2c_get_adapter(picodlp_adapter_id);
> +	if (!adapter) {
> +		dev_err(&dssdev->dev, "can't get i2c adapter\n");
> +		r = -ENODEV;
> +		goto err;
> +	}
> +
> +	picodlp_i2c_client = i2c_new_device(adapter, &picodlp_i2c_board_info);
> +	if (!picodlp_i2c_client) {
> +		dev_err(&dssdev->dev, "can't add i2c device::"
> +					 " picodlp_i2c_client is NULL\n");
> +		r = -ENODEV;
> +		goto err;
> +	}
> +
> +	picod->picodlp_i2c_client = picodlp_i2c_client;
> +
> +	picodlp_i2c_data =
> +		i2c_get_clientdata(picod->picodlp_i2c_client);
> +
> +	mutex_init(&picodlp_i2c_data->xfer_lock);

I don't think this is right. You have no guarantees that the i2c device
probe would have been called when the execution reaches here. So
picodlp_i2c_data could be NULL.

And anyway, why would you initialize the mutex here, as the mutex
belongs to the i2c side. The i2c probe would be more logical choice in
any case.

 Tomi


