From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH 1/1] OMAPDSS: Add sil9022 driver
Date: Tue, 9 Jul 2013 15:40:33 +0200
Message-ID: <20130709134033.GD18477@ns203013.ovh.net>
References: <1373360825-25170-1-git-send-email-sathyap@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 11.mo1.mail-out.ovh.net ([188.165.48.29]:39992 "EHLO
	mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751942Ab3GIQGI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Jul 2013 12:06:08 -0400
Received: from mail645.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo1.mail-out.ovh.net (Postfix) with SMTP id 9782DFFCAE0
	for <linux-omap@vger.kernel.org>; Tue,  9 Jul 2013 15:40:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1373360825-25170-1-git-send-email-sathyap@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sathya Prakash M R <sathyap@ti.com>
Cc: tomi.valkeinen@ti.com, archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Srinivas Pulukuru <srinivas.pulukuru@ti.com>

HI,

	Tomi can you take a look at this one your are back

Best Regards,
J.
On 14:37 Tue 09 Jul     , Sathya Prakash M R wrote:
> From: Srinivas Pulukuru <srinivas.pulukuru@ti.com>
> 
> Add driver for SIL9022 DPI-to-HDMI chip.
> 
> Signed-off-by: Srinivas Pulukuru <srinivas.pulukuru@ti.com>
> [sathyap@ti.com: Ported the driver from 2.6.32 based internal
> kernel to v3.10 kernel]
> Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
> ---
> This patch was tested using the legacy OMAP3630 based Zoom3 platform.
> There is no DT support for Zoom , hence board file changes
> made locally were used for validation purpose. 
> Further, DT support will be added for a newer SOC which uses
> the sil9022 HDMI interface chip.
> 
>  drivers/video/omap2/displays/Kconfig         |    8 +
>  drivers/video/omap2/displays/Makefile        |    1 +
>  drivers/video/omap2/displays/panel-sil9022.c | 1274 ++++++++++++++++++++++++++
>  drivers/video/omap2/displays/panel-sil9022.h |  527 +++++++++++
>  4 files changed, 1810 insertions(+)
>  create mode 100644 drivers/video/omap2/displays/panel-sil9022.c
>  create mode 100644 drivers/video/omap2/displays/panel-sil9022.h
> 
> diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
> index c3853c9..53d8bb7 100644
> --- a/drivers/video/omap2/displays/Kconfig
> +++ b/drivers/video/omap2/displays/Kconfig
> @@ -39,6 +39,14 @@ config PANEL_NEC_NL8048HL11_01B
>  		This NEC NL8048HL11-01B panel is TFT LCD
>  		used in the Zoom2/3/3630 sdp boards.
>  
> +config PANEL_SIL9022
> +	tristate "HDMI interface"
> +        depends on OMAP2_DSS_DPI
> +	depends on I2C
> +	help
> +		Driver for SIL9022 DPI-to-HDMI chip
> +		Driver uses i2c to read EDID information.
> +
>  config PANEL_PICODLP
>  	tristate "TI PICO DLP mini-projector"
>  	depends on OMAP2_DSS_DPI && I2C
> diff --git a/drivers/video/omap2/displays/Makefile b/drivers/video/omap2/displays/Makefile
> index 58a5176..34cfa8e 100644
> --- a/drivers/video/omap2/displays/Makefile
> +++ b/drivers/video/omap2/displays/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_PANEL_TFP410) += panel-tfp410.o
>  obj-$(CONFIG_PANEL_LGPHILIPS_LB035Q02) += panel-lgphilips-lb035q02.o
>  obj-$(CONFIG_PANEL_SHARP_LS037V7DW01) += panel-sharp-ls037v7dw01.o
>  obj-$(CONFIG_PANEL_NEC_NL8048HL11_01B) += panel-nec-nl8048hl11-01b.o
> +obj-$(CONFIG_PANEL_SIL9022) += panel-sil9022.o
>  
>  obj-$(CONFIG_PANEL_TAAL) += panel-taal.o
>  obj-$(CONFIG_PANEL_PICODLP) +=  panel-picodlp.o
> diff --git a/drivers/video/omap2/displays/panel-sil9022.c b/drivers/video/omap2/displays/panel-sil9022.c
> new file mode 100644
> index 0000000..3b5cb17
> --- /dev/null
> +++ b/drivers/video/omap2/displays/panel-sil9022.c
> @@ -0,0 +1,1274 @@
> +/*
> + * drivers/video/omap2/panel-sil9022.c
> + *
> + * Copyright (C) 2009 Texas Instruments
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2. This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + *
> + * SIL9022 hdmi driver
> + * Owner: kiran Chitriki
> + *
> + */
> +
> +/***********************************/
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/i2c.h>
> +#include <linux/device.h>
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/platform_device.h>
> +
> +#include <video/omapdss.h>
> +#include <video/omap-panel-data.h>
> +#include "panel-sil9022.h"
> +
> +u16 current_descriptor_addrs;
> +
> +static struct i2c_client *sil9022_client;
> +
> +static struct omap_video_timings omap_dss_hdmi_timings = {
> +	.x_res          = HDMI_XRES,
> +	.y_res          = HDMI_YRES,
> +	.pixel_clock    = HDMI_PIXCLOCK_MAX,
> +	.hfp            = 110,
> +	.hbp            = 220,
> +	.hsw            = 40,
> +	.vfp            = 5,
> +	.vbp            = 20,
> +	.vsw            = 5,
> +	.vsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
> +	.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
> +	.data_pclk_edge	= OMAPDSS_DRIVE_SIG_RISING_EDGE,
> +	.de_level	= OMAPDSS_SIG_ACTIVE_HIGH,
> +	.sync_pclk_edge	= OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES,
> +};
> +
> +static struct hdmi_reg_data  hdmi_tpi_audio_config_data[] = {
> +	/* Transmitter is brought to Full operation when value of power
> +	 * state register is 0x0 */
> +	{ HDMI_TPI_POWER_STATE_CTRL_REG, TPI_AVI_POWER_STATE_D0		 },
> +	/* TMDS output lines active. bit 3 1:TMDS inactive, 0: TMDS active */
> +	{ HDMI_SYS_CTRL_DATA_REG,  0x01					 },
> +	/*HDCP Enable - Disable */
> +	{ HDMI_TPI_HDCP_CONTROLDATA_REG, 0				 },
> +	/* I2S mode , Mute Enabled , PCM */
> +	{ HDMI_TPI_AUDIO_CONFIG_BYTE2_REG, TPI_AUDIO_INTERFACE_I2S |
> +					    TPI_AUDIO_MUTE_ENABLE |
> +					    TPI_AUDIO_CODING_PCM	 },
> +	/* I2S Input configuration register */
> +	{ HDMI_TPI_I2S_INPUT_CONFIG_REG, TPI_I2S_SCK_EDGE_RISING |
> +					TPI_I2S_MCLK_MULTIPLIER_256 |
> +					TPI_I2S_WS_POLARITY_HIGH |
> +					TPI_I2S_SD_JUSTIFY_LEFT |
> +					TPI_I2S_SD_DIRECTION_MSB_FIRST |
> +					TPI_I2S_FIRST_BIT_SHIFT_YES	 },
> +	/* I2S Enable ad Mapping Register */
> +	{ HDMI_TPI_I2S_ENABLE_MAPPING_REG, TPI_I2S_SD_CHANNEL_ENABLE |
> +					    TPI_I2S_SD_FIFO_0 |
> +					    TPI_I2S_DOWNSAMPLE_DISABLE |
> +					    TPI_I2S_LF_RT_SWAP_NO |
> +					    TPI_I2S_SD_CONFIG_SELECT_SD0 },
> +	{ HDMI_TPI_I2S_ENABLE_MAPPING_REG, TPI_I2S_SD_CHANNEL_DISABLE |
> +					    TPI_I2S_SD_FIFO_1 |
> +					    TPI_I2S_DOWNSAMPLE_DISABLE |
> +					    TPI_I2S_LF_RT_SWAP_NO |
> +					    TPI_I2S_SD_CONFIG_SELECT_SD1 },
> +	{ HDMI_TPI_I2S_ENABLE_MAPPING_REG, TPI_I2S_SD_CHANNEL_DISABLE |
> +					    TPI_I2S_SD_FIFO_2 |
> +					    TPI_I2S_DOWNSAMPLE_DISABLE |
> +					    TPI_I2S_LF_RT_SWAP_NO |
> +					    TPI_I2S_SD_CONFIG_SELECT_SD2 },
> +	{ HDMI_TPI_I2S_ENABLE_MAPPING_REG, TPI_I2S_SD_CHANNEL_DISABLE |
> +					    TPI_I2S_SD_FIFO_3 |
> +					    TPI_I2S_DOWNSAMPLE_DISABLE |
> +					    TPI_I2S_LF_RT_SWAP_NO |
> +					    TPI_I2S_SD_CONFIG_SELECT_SD3 },
> +	{ HDMI_TPI_AUDIO_CONFIG_BYTE3_REG, TPI_AUDIO_SAMPLE_SIZE_16 |
> +					     TPI_AUDIO_FREQ_44KHZ |
> +					     TPI_AUDIO_2_CHANNEL	 },
> +	/* Speaker Configuration  refer CEA Specification*/
> +	{ HDMI_TPI_AUDIO_CONFIG_BYTE4_REG, (0x0 << 0)},
> +	/* Stream Header Settings */
> +	{ HDMI_TPI_I2S_STRM_HDR_0_REG, I2S_CHAN_STATUS_MODE		 },
> +	{ HDMI_TPI_I2S_STRM_HDR_1_REG, I2S_CHAN_STATUS_CAT_CODE	},
> +	{ HDMI_TPI_I2S_STRM_HDR_2_REG, I2S_CHAN_SOURCE_CHANNEL_NUM	 },
> +	{ HDMI_TPI_I2S_STRM_HDR_3_REG, I2S_CHAN_ACCURACY_N_44_SAMPLING_FS },
> +	{ HDMI_TPI_I2S_STRM_HDR_4_REG, I2S_CHAN_ORIGIN_FS_N_SAMP_LENGTH  },
> +	/*     Infoframe data Select  */
> +	{ HDMI_CPI_MISC_IF_SELECT_REG, HDMI_INFOFRAME_TX_ENABLE |
> +					HDMI_INFOFRAME_TX_REPEAT |
> +					HDMI_AUDIO_INFOFRAME		 },
> +};
> +
> +static u8 misc_audio_info_frame_data[] = {
> +	MISC_INFOFRAME_TYPE | MISC_INFOFRAME_ALWAYS_SET,
> +	MISC_INFOFRAME_VERSION,
> +	MISC_INFOFRAME_LENGTH,
> +	0,				/* Checksum byte*/
> +	HDMI_SH_PCM | HDMI_SH_TWO_CHANNELS,
> +	HDMI_SH_44KHz | HDMI_SH_16BIT,	/* 44.1 KHz*/
> +	0x0,   /* Default 0*/
> +	HDMI_SH_SPKR_FLFR,
> +	HDMI_SH_0dB_ATUN | 0x1,		/* 0 dB  Attenuation*/
> +	0x0,
> +	0x0,
> +	0x0,
> +	0x0,
> +	0x0
> +};
> +
> +static u8 avi_info_frame_data[] = {
> +	0x00,
> +	0x00,
> +	0xA8,
> +	0x00,
> +	0x04,
> +	0x00,
> +	0x00,
> +	0x00,
> +	0x00,
> +	0x00,
> +	0x00,
> +	0x00,
> +	0x00,
> +	0x00
> +};
> +
> +void get_horz_vert_timing_info(u8 *edid)
> +{
> +	/*HORIZONTAL FRONT PORCH */
> +	omap_dss_hdmi_timings.hfp = edid[current_descriptor_addrs + 8];
> +	/*HORIZONTAL SYNC WIDTH */
> +	omap_dss_hdmi_timings.hsw = edid[current_descriptor_addrs + 9];
> +	/*HORIZONTAL BACK PORCH */
> +	omap_dss_hdmi_timings.hbp = (((edid[current_descriptor_addrs + 4]
> +					  & 0x0F) << 8) |
> +					edid[current_descriptor_addrs + 3]) -
> +		(omap_dss_hdmi_timings.hfp + omap_dss_hdmi_timings.hsw);
> +	/*VERTICAL FRONT PORCH */
> +	omap_dss_hdmi_timings.vfp = ((edid[current_descriptor_addrs + 10] &
> +				       0xF0) >> 4);
> +	/*VERTICAL SYNC WIDTH */
> +	omap_dss_hdmi_timings.vsw = (edid[current_descriptor_addrs + 10] &
> +				      0x0F);
> +	/*VERTICAL BACK PORCH */
> +	omap_dss_hdmi_timings.vbp = (((edid[current_descriptor_addrs + 7] &
> +					0x0F) << 8) |
> +				      edid[current_descriptor_addrs + 6]) -
> +		(omap_dss_hdmi_timings.vfp + omap_dss_hdmi_timings.vsw);
> +
> +	dev_dbg(&sil9022_client->dev, "<%s>\n"
> +				       "hfp			= %d\n"
> +				       "hsw			= %d\n"
> +				       "hbp			= %d\n"
> +				       "vfp			= %d\n"
> +				       "vsw			= %d\n"
> +				       "vbp			= %d\n",
> +		 __func__,
> +		 omap_dss_hdmi_timings.hfp,
> +		 omap_dss_hdmi_timings.hsw,
> +		 omap_dss_hdmi_timings.hbp,
> +		 omap_dss_hdmi_timings.vfp,
> +		 omap_dss_hdmi_timings.vsw,
> +		 omap_dss_hdmi_timings.vbp
> +		 );
> +
> +}
> +
> +void get_edid_timing_data(u8 *edid, u16 *pixel_clk, u16 *horizontal_res,
> +			  u16 *vertical_res)
> +{
> +	u8 offset, effective_addrs;
> +	u8 count;
> +	u8 i;
> +	u8 flag = false;
> +	/*check for 720P timing in block0 */
> +	for (count = 0; count < EDID_SIZE_BLOCK0_TIMING_DESCRIPTOR; count++) {
> +		current_descriptor_addrs =
> +			EDID_DESCRIPTOR_BLOCK0_ADDRESS +
> +			count * EDID_TIMING_DESCRIPTOR_SIZE;
> +		*horizontal_res =
> +			(((edid[EDID_DESCRIPTOR_BLOCK0_ADDRESS + 4 +
> +			   count * EDID_TIMING_DESCRIPTOR_SIZE] & 0xF0) << 4) |
> +			 edid[EDID_DESCRIPTOR_BLOCK0_ADDRESS + 2 +
> +			 count * EDID_TIMING_DESCRIPTOR_SIZE]);
> +		*vertical_res =
> +			(((edid[EDID_DESCRIPTOR_BLOCK0_ADDRESS + 7 +
> +			   count * EDID_TIMING_DESCRIPTOR_SIZE] & 0xF0) << 4) |
> +			 edid[EDID_DESCRIPTOR_BLOCK0_ADDRESS + 5 +
> +			 count * EDID_TIMING_DESCRIPTOR_SIZE]);
> +
> +		dev_dbg(&sil9022_client->dev,
> +			"<%s> ***Block-0-Timing-descriptor[%d]***\n",
> +			__func__, count);
> +		for (i = current_descriptor_addrs;
> +		      i <
> +		      (current_descriptor_addrs+EDID_TIMING_DESCRIPTOR_SIZE);
> +		      i++)
> +			dev_dbg(&sil9022_client->dev,
> +				"%x ==>		%x\n", i, edid[i]);
> +
> +			dev_dbg(&sil9022_client->dev,
> +				 "<%s>\n"
> +				 "E-EDID Buffer Index	= %d\n"
> +				 "horizontal_res	= %d\n"
> +				 "vertical_res		= %d\n",
> +				 __func__,
> +				 current_descriptor_addrs,
> +				 *horizontal_res,
> +				 *vertical_res
> +				 );
> +
> +		if (*horizontal_res == HDMI_XRES &&
> +		    *vertical_res == HDMI_YRES) {
> +			dev_info(&sil9022_client->dev,
> +				"<%s>\nFound EDID Data for %d x %dp\n",
> +				 __func__, *horizontal_res, *vertical_res);
> +			flag = true;
> +			break;
> +			}
> +	}
> +
> +	/*check for the Timing in block1 */
> +	if (flag != true) {
> +		offset = edid[EDID_DESCRIPTOR_BLOCK1_ADDRESS + 2];
> +		if (offset != 0) {
> +			effective_addrs = EDID_DESCRIPTOR_BLOCK1_ADDRESS
> +				+ offset;
> +			/*to determine the number of descriptor blocks */
> +			for (count = 0;
> +			      count < EDID_SIZE_BLOCK1_TIMING_DESCRIPTOR;
> +			      count++) {
> +				current_descriptor_addrs = effective_addrs +
> +					count * EDID_TIMING_DESCRIPTOR_SIZE;
> +				*horizontal_res =
> +					(((edid[effective_addrs + 4 +
> +					   count*EDID_TIMING_DESCRIPTOR_SIZE] &
> +					   0xF0) << 4) |
> +					 edid[effective_addrs + 2 +
> +					 count * EDID_TIMING_DESCRIPTOR_SIZE]);
> +				*vertical_res =
> +					(((edid[effective_addrs + 7 +
> +					   count*EDID_TIMING_DESCRIPTOR_SIZE] &
> +					   0xF0) << 4) |
> +					 edid[effective_addrs + 5 +
> +					 count * EDID_TIMING_DESCRIPTOR_SIZE]);
> +
> +				dev_dbg(&sil9022_client->dev,
> +					 "<%s> Block1-Timing-descriptor[%d]\n",
> +					 __func__, count);
> +
> +				for (i = current_descriptor_addrs;
> +				      i < (current_descriptor_addrs+
> +					   EDID_TIMING_DESCRIPTOR_SIZE); i++)
> +					dev_dbg(&sil9022_client->dev,
> +						"%x ==>		%x\n",
> +						   i, edid[i]);
> +
> +				dev_dbg(&sil9022_client->dev, "<%s>\n"
> +						"current_descriptor	= %d\n"
> +						"horizontal_res		= %d\n"
> +						"vertical_res		= %d\n",
> +					 __func__, current_descriptor_addrs,
> +					 *horizontal_res, *vertical_res);
> +
> +				if (*horizontal_res == HDMI_XRES &&
> +				    *vertical_res == HDMI_YRES) {
> +					dev_info(&sil9022_client->dev,
> +						 "<%s> Found EDID Data for "
> +						 "%d x %dp\n",
> +						 __func__,
> +						 *horizontal_res,
> +						 *vertical_res
> +						 );
> +					flag = true;
> +					break;
> +					}
> +			}
> +		}
> +	}
> +
> +	if (flag == true) {
> +		*pixel_clk = ((edid[current_descriptor_addrs + 1] << 8) |
> +			     edid[current_descriptor_addrs]);
> +
> +		omap_dss_hdmi_timings.x_res = *horizontal_res;
> +		omap_dss_hdmi_timings.y_res = *vertical_res;
> +		omap_dss_hdmi_timings.pixel_clock = *pixel_clk*10;
> +		dev_dbg(&sil9022_client->dev,
> +			 "EDID TIMING DATA supported by zoom2 FOUND\n"
> +			 "EDID DTD block address	= %d\n"
> +			 "pixel_clk			= %d\n"
> +			 "horizontal res		= %d\n"
> +			 "vertical res			= %d\n",
> +			 current_descriptor_addrs,
> +			 omap_dss_hdmi_timings.pixel_clock,
> +			 omap_dss_hdmi_timings.x_res,
> +			 omap_dss_hdmi_timings.y_res
> +			 );
> +
> +		get_horz_vert_timing_info(edid);
> +	} else {
> +
> +		dev_info(&sil9022_client->dev,
> +			 "<%s>\n"
> +			 "EDID TIMING DATA supported by zoom2 NOT FOUND\n"
> +			 "setting default timing values for 720p\n"
> +			 "pixel_clk		= %d\n"
> +			 "horizontal res	= %d\n"
> +			 "vertical res		= %d\n",
> +			 __func__,
> +			 omap_dss_hdmi_timings.pixel_clock,
> +			 omap_dss_hdmi_timings.x_res,
> +			 omap_dss_hdmi_timings.y_res
> +			 );
> +
> +		*pixel_clk = omap_dss_hdmi_timings.pixel_clock;
> +		*horizontal_res = omap_dss_hdmi_timings.x_res;
> +		*vertical_res = omap_dss_hdmi_timings.y_res;
> +	}
> +
> +
> +}
> +
> +
> +static int
> +sil9022_blockwrite_reg(struct i2c_client *client,
> +				  u8 reg, u16 alength, u8 *val, u16 *out_len)
> +{
> +	int err = 0, i;
> +	struct i2c_msg msg[1];
> +	u8 data[2];
> +
> +	if (!client->adapter) {
> +		dev_err(&client->dev, "<%s> ERROR: No HDMI Device\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	msg->addr = client->addr;
> +	msg->flags = I2C_M_WR;
> +	msg->len = 2;
> +	msg->buf = data;
> +
> +	/* high byte goes out first */
> +	data[0] = reg >> 8;
> +
> +	for (i = 0; i < alength - 1; i++) {
> +		data[1] = val[i];
> +		err = i2c_transfer(client->adapter, msg, 1);
> +		udelay(50);
> +		dev_dbg(&client->dev, "<%s> i2c Block write at 0x%x, "
> +				      "*val=%d flags=%d byte[%d] err=%d\n",
> +			__func__, data[0], data[1], msg->flags, i, err);
> +		if (err < 0)
> +			break;
> +	}
> +	/* set the number of bytes written*/
> +	*out_len = i;
> +
> +	if (err < 0) {
> +		dev_err(&client->dev, "<%s> ERROR:  i2c Block Write at 0x%x, "
> +				      "*val=%d flags=%d bytes written=%d "
> +				      "err=%d\n",
> +			__func__, data[0], data[1], msg->flags, i, err);
> +		return err;
> +	}
> +	return 0;
> +}
> +
> +static int
> +sil9022_blockread_reg(struct i2c_client *client,
> +		      u16 data_length, u16 alength,
> +		      u8 reg, u8 *val, u16 *out_len)
> +{
> +	int err = 0, i;
> +	struct i2c_msg msg[1];
> +	u8 data[2];
> +
> +	if (!client->adapter) {
> +		dev_err(&client->dev, "<%s> ERROR: No HDMI Device\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	msg->addr = client->addr;
> +	msg->flags = I2C_M_WR;
> +	msg->len = 1;
> +	msg->buf = data;
> +
> +	/* High byte goes out first */
> +	data[0] = reg;
> +	err = i2c_transfer(client->adapter, msg, 1);
> +	dev_dbg(&client->dev, "<%s> i2c Block Read1 at 0x%x, "
> +			       "*val=%d flags=%d err=%d\n",
> +		 __func__, data[0], data[1], msg->flags, err);
> +
> +	for (i = 0; i < alength; i++) {
> +		if (err >= 0) {
> +			mdelay(3);
> +			msg->flags = I2C_M_RD;
> +			msg->len = data_length;
> +			err = i2c_transfer(client->adapter, msg, 1);
> +		} else
> +			break;
> +		if (err >= 0) {
> +			val[i] = 0;
> +			/* High byte comes first */
> +			if (data_length == 1)
> +				val[i] = data[0];
> +			else if (data_length == 2)
> +				val[i] = data[1] + (data[0] << 8);
> +			dev_dbg(&client->dev, "<%s> i2c Block Read2 at 0x%x, "
> +					       "*val=%d flags=%d byte=%d "
> +					       "err=%d\n",
> +				 __func__, reg, val[i], msg->flags, i, err);
> +		} else
> +			break;
> +	}
> +	*out_len = i;
> +	dev_dbg(&client->dev, "<%s> i2c Block Read at 0x%x, bytes read = %d\n",
> +		__func__, client->addr, *out_len);
> +
> +	if (err < 0) {
> +		dev_err(&client->dev, "<%s> ERROR:  i2c Read at 0x%x, "
> +				      "*val=%d flags=%d bytes read=%d err=%d\n",
> +			__func__, reg, *val, msg->flags, i, err);
> +		return err;
> +	}
> +	return 0;
> +}
> +
> +
> +/* Write a value to a register in sil9022 device.
> + * @client: i2c driver client structure.
> + * @reg: Address of the register to read value from.
> + * @val: Value to be written to a specific register.
> + * Returns zero if successful, or non-zero otherwise.
> + */
> +static int
> +sil9022_write_reg(struct i2c_client *client, u8 reg, u8 val)
> +{
> +	int err = 0;
> +	struct i2c_msg msg[1];
> +	u8 data[2];
> +	int retries = 0;
> +
> +	if (!client->adapter) {
> +		dev_err(&client->dev, "<%s> ERROR: No HDMI Device\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +retry:
> +	msg->addr = client->addr;
> +	msg->flags = I2C_M_WR;
> +	msg->len = 2;
> +	msg->buf = data;
> +
> +	data[0] = reg;
> +	data[1] = val;
> +
> +	err = i2c_transfer(client->adapter, msg, 1);
> +	dev_dbg(&client->dev, "<%s> i2c write at=%x "
> +			       "val=%x flags=%d err=%d\n",
> +		__func__, data[0], data[1], msg->flags, err);
> +	udelay(50);
> +
> +	if (err >= 0)
> +		return 0;
> +
> +	dev_err(&client->dev, "<%s> ERROR: i2c write at=%x "
> +			       "val=%x flags=%d err=%d\n",
> +		__func__, data[0], data[1], msg->flags, err);
> +	if (retries <= 5) {
> +		dev_info(&client->dev, "Retrying I2C... %d\n", retries);
> +		retries++;
> +		set_current_state(TASK_UNINTERRUPTIBLE);
> +		schedule_timeout(msecs_to_jiffies(20));
> +		goto retry;
> +	}
> +	return err;
> +}
> +
> +/*
> + * Read a value from a register in sil9022 device.
> + * The value is returned in 'val'.
> + * Returns zero if successful, or non-zero otherwise.
> + */
> +static int
> +sil9022_read_reg(struct i2c_client *client, u16 data_length, u8 reg, u8 *val)
> +{
> +	int err = 0;
> +	struct i2c_msg msg[1];
> +	u8 data[2];
> +
> +	if (!client->adapter) {
> +		dev_err(&client->dev, "<%s> ERROR: No HDMI Device\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	msg->addr = client->addr;
> +	msg->flags = I2C_M_WR;
> +	msg->len = 1;
> +	msg->buf = data;
> +
> +	data[0] = reg;
> +	err = i2c_transfer(client->adapter, msg, 1);
> +	dev_dbg(&client->dev, "<%s> i2c Read1 reg=%x val=%d "
> +			       "flags=%d err=%d\n",
> +		__func__, reg, data[1], msg->flags, err);
> +
> +	if (err >= 0) {
> +		mdelay(3);
> +		msg->flags = I2C_M_RD;
> +		msg->len = data_length;
> +		err = i2c_transfer(client->adapter, msg, 1);
> +	}
> +
> +	if (err >= 0) {
> +		*val = 0;
> +		if (data_length == 1)
> +			*val = data[0];
> +		else if (data_length == 2)
> +			*val = data[1] + (data[0] << 8);
> +		dev_dbg(&client->dev, "<%s> i2c Read2 at 0x%x, *val=%d "
> +				       "flags=%d err=%d\n",
> +			 __func__, reg, *val, msg->flags, err);
> +		return 0;
> +	}
> +
> +	dev_err(&client->dev, "<%s> ERROR: i2c Read at 0x%x, "
> +			      "*val=%d flags=%d err=%d\n",
> +		__func__, reg, *val, msg->flags, err);
> +	return err;
> +}
> +
> +static int
> +sil9022_read_edid(struct i2c_client *client, u16 len,
> +	       char *p_buffer, u16 *out_len)
> +{
> +	int err =  0;
> +	u8 val = 0;
> +	int retries = 0;
> +	int i = 0;
> +	int k = 0;
> +
> +	len = (len < HDMI_EDID_MAX_LENGTH) ? len : HDMI_EDID_MAX_LENGTH;
> +
> +	/* Request DDC bus access to read EDID info from HDTV */
> +	dev_info(&client->dev, "<%s> Reading HDMI EDID\n", __func__);
> +
> +	/* Bring transmitter to low-Power state */
> +	val = TPI_AVI_POWER_STATE_D2;
> +	err = sil9022_write_reg(client, HDMI_TPI_DEVICE_POWER_STATE_DATA, val);
> +	if (err < 0) {
> +		dev_err(&client->dev,
> +			"<%s> ERROR: Failed during bring power state - low.\n",
> +			 __func__);
> +		return err;
> +	}
> +
> +	/* Disable TMDS clock */
> +	val = 0x11;
> +	err = sil9022_write_reg(client, HDMI_SYS_CTRL_DATA_REG, val);
> +	if (err < 0) {
> +		dev_err(&client->dev,
> +			"<%s> ERROR: Failed during bring power state - low.\n",
> +			 __func__);
> +		return err;
> +	}
> +
> +	val = 0;
> +	/* Read TPI system control register*/
> +	err = sil9022_read_reg(client, 1, HDMI_SYS_CTRL_DATA_REG, &val);
> +	if (err < 0) {
> +		dev_err(&client->dev,
> +			"<%s> ERROR: Reading DDC BUS REQUEST\n", __func__);
> +		return err;
> +	}
> +
> +	/* The host writes 0x1A[2]=1 to request the
> +	 * DDC(Display Data Channel) bus
> +	 */
> +	val |= TPI_SYS_CTRL_DDC_BUS_REQUEST;
> +	err = sil9022_write_reg(client, HDMI_SYS_CTRL_DATA_REG, val);
> +	if (err < 0) {
> +		dev_err(&client->dev,
> +			"<%s> ERROR: Writing DDC BUS REQUEST\n", __func__);
> +		return err;
> +	}
> +
> +	 /*  Poll for bus DDC Bus control to be granted */
> +	dev_info(&client->dev, "<%s> Poll for DDC bus access\n", __func__);
> +	val = 0;
> +	do {
> +		err = sil9022_read_reg(client, 1, HDMI_SYS_CTRL_DATA_REG, &val);
> +		if (retries++ > 100)
> +			return err;
> +
> +	} while ((val & TPI_SYS_CTRL_DDC_BUS_GRANTED) == 0);
> +
> +	/*  Close the switch to the DDC */
> +	val |= TPI_SYS_CTRL_DDC_BUS_REQUEST | TPI_SYS_CTRL_DDC_BUS_GRANTED;
> +	err = sil9022_write_reg(client, HDMI_SYS_CTRL_DATA_REG, val);
> +	if (err < 0) {
> +		dev_err(&client->dev,
> +			"<%s> ERROR: Close switch to DDC BUS REQUEST\n",
> +			__func__);
> +		return err;
> +	}
> +
> +	memset(p_buffer, 0, len);
> +	/* change I2C SetSlaveAddress to HDMI_I2C_MONITOR_ADDRESS */
> +	/*  Read the EDID structure from the monitor I2C address  */
> +	client->addr = HDMI_I2C_MONITOR_ADDRESS;
> +	err = sil9022_blockread_reg(client, 1, len,
> +				    0x00, p_buffer, out_len);
> +	if (err < 0 || *out_len <= 0) {
> +		dev_err(&client->dev,
> +			"<%s> ERROR: Reading EDID from "
> +			"HDMI_I2C_MONITOR_ADDRESS\n", __func__);
> +		return err;
> +	}
> +
> +	for (i = 0; i < *out_len; i++) {
> +		if ((i / 18) < 3) {
> +			dev_dbg(&client->dev, "byte->%02x	%x\n",
> +				i, p_buffer[i]);
> +			continue;
> +		}
> +		if ((i/18 >= 3 && i/18 <= 6) && (i%18 == 0))
> +			dev_dbg(&client->dev, "\n DTD Block %d\n", k++);
> +
> +		if ((i/18 == 7) && (i%18 == 0))
> +			dev_dbg(&client->dev, "\n");
> +
> +		dev_dbg(&client->dev, "byte->%02x	%x\n", i, p_buffer[i]);
> +	}
> +
> +	/* Release DDC bus access */
> +	client->addr = SI9022_I2CSLAVEADDRESS;
> +	val &= ~(TPI_SYS_CTRL_DDC_BUS_REQUEST | TPI_SYS_CTRL_DDC_BUS_GRANTED);
> +	err = sil9022_write_reg(client, HDMI_SYS_CTRL_DATA_REG, val);
> +
> +	if (err < 0) {
> +		dev_err(&client->dev,
> +			"<%s> ERROR: Releasing DDC  Bus Access\n",
> +			__func__);
> +		return err;
> +		}
> +
> +	/*  Success */
> +	return 0;
> +}
> +
> +static int
> +sil9022_enable_audio(struct i2c_client *client)
> +{
> +	int err = 0;
> +	u8  val = 0;
> +	u8  crc = 0;
> +	u32 count = 0;
> +	int index = 0;
> +
> +	for (index = 0;
> +	      index < sizeof(hdmi_tpi_audio_config_data) /
> +	      sizeof(struct hdmi_reg_data);
> +	      index++) {
> +		err = sil9022_write_reg(
> +			client,
> +			hdmi_tpi_audio_config_data[index].reg_offset,
> +			hdmi_tpi_audio_config_data[index].value);
> +		if (err != 0) {
> +			dev_err(&client->dev,
> +				"<%s> ERROR: Writing "
> +				"tpi_audio_config_data[%d]={ %d, %d }\n",
> +				__func__, index,
> +				hdmi_tpi_audio_config_data[index].reg_offset,
> +				hdmi_tpi_audio_config_data[index].value);
> +			return err;
> +			}
> +		}
> +
> +	/* Fill the checksum byte for Infoframe data*/
> +	count = 0;
> +	while (count < MISC_INFOFRAME_SIZE_MEMORY) {
> +		crc += misc_audio_info_frame_data[count];
> +		count++;
> +	}
> +	crc = 0x100 - crc;
> +
> +	/* Fill CRC Byte*/
> +	misc_audio_info_frame_data[0x3] = crc;
> +
> +	for (count = 0; count < MISC_INFOFRAME_SIZE_MEMORY; count++) {
> +		err = sil9022_write_reg(client,
> +					(HDMI_CPI_MISC_IF_OFFSET + count),
> +					misc_audio_info_frame_data[count]);
> +		if (err < 0) {
> +			dev_err(&client->dev,
> +				"<%s> ERROR: writing audio info frame"
> +				" CRC data: %d\n", __func__, count);
> +			return err;
> +		}
> +	}
> +
> +	/* Decode Level 0 Packets */
> +	val = 0x2;
> +	sil9022_write_reg(client, 0xBC, val);
> +	if (err < 0) {
> +		dev_err(&client->dev,
> +			"<%s> ERROR: writing level 0 packets to 0xBC\n",
> +			__func__);
> +		return err;
> +	}
> +
> +	val = 0x24;
> +	err = sil9022_write_reg(client, 0xBD, val);
> +	if (err < 0) {
> +		dev_err(&client->dev,
> +			"<%s> ERROR: writing level 0 packets to 0xBD\n",
> +			__func__);
> +		return err;
> +	}
> +
> +	val = 0x2;
> +	err = sil9022_write_reg(client, 0xBE, val);
> +	if (err < 0) {
> +		dev_err(&client->dev,
> +			"<%s> ERROR: writing level 0 packets to 0xBE\n",
> +			__func__);
> +		return err;
> +	}
> +
> +	/* Disable Mute */
> +	val = TPI_AUDIO_INTERFACE_I2S |
> +		  TPI_AUDIO_MUTE_DISABLE |
> +		  TPI_AUDIO_CODING_PCM;
> +	err = sil9022_write_reg(client, HDMI_TPI_AUDIO_CONFIG_BYTE2_REG, val);
> +	if (err < 0) {
> +		dev_err(&client->dev,
> +			"<%s> ERROR: Disabling mute\n",
> +			__func__);
> +		return err;
> +	}
> +
> +	dev_info(&client->dev, "<%s> hdmi audio enabled\n",
> +		__func__);
> +	return 0;
> +
> +}
> +
> +static int
> +sil9022_disable_audio(struct i2c_client *client)
> +{
> +	u8 val = 0;
> +	int err = 0;
> +	/* Disable Audio */
> +	val = TPI_AUDIO_INTERFACE_DISABLE;
> +	err = sil9022_write_reg(client, HDMI_TPI_AUDIO_CONFIG_BYTE2_REG, val);
> +	if (err < 0)
> +		dev_err(&client->dev,
> +			"<%s> ERROR: Disisable audio interface", __func__);
> +
> +	dev_info(&client->dev, "<%s> hdmi audio disabled\n", __func__);
> +	return err;
> +}
> +
> +static int
> +sil9022_enable(struct omap_dss_device *dssdev)
> +{
> +	int		err;
> +	u8		val, vals[14];
> +	int		i;
> +	u16		out_len = 0;
> +	u8		edid[HDMI_EDID_MAX_LENGTH];
> +	u16		horizontal_res;
> +	u16		vertical_res;
> +	u16		pixel_clk;
> +
> +	memset(edid, 0, HDMI_EDID_MAX_LENGTH);
> +	memset(vals, 0, 14);
> +
> +	err = sil9022_read_edid(sil9022_client, HDMI_EDID_MAX_LENGTH,
> +			     edid, &out_len);
> +	if (err < 0 || out_len == 0) {
> +		dev_err(&sil9022_client->dev,
> +			"<%s> Unable to read EDID for monitor\n", __func__);
> +		return err;
> +	}
> +
> +	get_edid_timing_data(edid,
> +			     &pixel_clk,
> +			     &horizontal_res,
> +			     &vertical_res
> +			     );
> +
> +	/*  Fill the TPI Video Mode Data structure */
> +	vals[0] = (pixel_clk & 0xFF);                  /* Pixel clock */
> +	vals[1] = ((pixel_clk & 0xFF00) >> 8);
> +	vals[2] = VERTICAL_FREQ;                    /* Vertical freq */
> +	vals[3] = 0x00;
> +	vals[4] = (horizontal_res & 0xFF);         /* Horizontal pixels*/
> +	vals[5] = ((horizontal_res & 0xFF00) >> 8);
> +	vals[6] = (vertical_res & 0xFF);           /* Vertical pixels */
> +	vals[7] = ((vertical_res & 0xFF00) >> 8);
> +
> +	dev_info(&sil9022_client->dev, "<%s>\nHDMI Monitor E-EDID Timing Data\n"
> +				       "horizontal_res	= %d\n"
> +				       "vertical_res	= %d\n"
> +				       "pixel_clk	= %d\n"
> +				       "hfp		= %d\n"
> +				       "hsw		= %d\n"
> +				       "hbp		= %d\n"
> +				       "vfp		= %d\n"
> +				       "vsw		= %d\n"
> +				       "vbp		= %d\n",
> +		 __func__,
> +		 omap_dss_hdmi_timings.x_res,
> +		 omap_dss_hdmi_timings.y_res,
> +		 omap_dss_hdmi_timings.pixel_clock,
> +		 omap_dss_hdmi_timings.hfp,
> +		 omap_dss_hdmi_timings.hsw,
> +		 omap_dss_hdmi_timings.hbp,
> +		 omap_dss_hdmi_timings.vfp,
> +		 omap_dss_hdmi_timings.vsw,
> +		 omap_dss_hdmi_timings.vbp
> +		 );
> +
> +	dssdev->panel.timings = omap_dss_hdmi_timings;
> +	/*  Write out the TPI Video Mode Data */
> +	out_len = 0;
> +	err = sil9022_blockwrite_reg(sil9022_client,
> +				     HDMI_TPI_VIDEO_DATA_BASE_REG,
> +				     8, vals, &out_len);
> +	if (err < 0) {
> +		dev_err(&sil9022_client->dev,
> +			"<%s> ERROR: writing TPI video mode data\n", __func__);
> +		return err;
> +	}
> +
> +	/* Write out the TPI Pixel Repetition Data (24 bit wide bus,
> +	falling edge, no pixel replication) */
> +	val = TPI_AVI_PIXEL_REP_BUS_24BIT |
> +		TPI_AVI_PIXEL_REP_FALLING_EDGE |
> +		TPI_AVI_PIXEL_REP_NONE;
> +	err = sil9022_write_reg(sil9022_client,
> +				HDMI_TPI_PIXEL_REPETITION_REG,
> +				val);
> +	if (err < 0) {
> +		dev_err(&sil9022_client->dev,
> +			"<%s> ERROR: writing TPI pixel repetition data\n",
> +			__func__);
> +		return err;
> +	}
> +
> +	 /*  Write out the TPI AVI Input Format */
> +	val = TPI_AVI_INPUT_BITMODE_8BIT |
> +		TPI_AVI_INPUT_RANGE_AUTO |
> +		TPI_AVI_INPUT_COLORSPACE_RGB;
> +	err = sil9022_write_reg(sil9022_client,
> +				HDMI_TPI_AVI_IN_FORMAT_REG,
> +				val);
> +	if (err < 0) {
> +		dev_err(&sil9022_client->dev,
> +			"<%s> ERROR: writing TPI AVI Input format\n", __func__);
> +		return err;
> +	}
> +
> +	/*  Write out the TPI AVI Output Format */
> +	val = TPI_AVI_OUTPUT_CONV_BT709 |
> +		TPI_AVI_OUTPUT_RANGE_AUTO |
> +		TPI_AVI_OUTPUT_COLORSPACE_RGBHDMI;
> +	err = sil9022_write_reg(sil9022_client,
> +				HDMI_TPI_AVI_OUT_FORMAT_REG, val);
> +	if (err < 0) {
> +		dev_err(&sil9022_client->dev,
> +			"<%s> ERROR: writing TPI AVI output format\n",
> +			__func__);
> +		return err;
> +	}
> +
> +	/* Write out the TPI System Control Data to power down */
> +	val = TPI_SYS_CTRL_POWER_DOWN;
> +	err = sil9022_write_reg(sil9022_client, HDMI_SYS_CTRL_DATA_REG, val);
> +	if (err < 0) {
> +		dev_err(&sil9022_client->dev,
> +			"<%s> ERROR: writing TPI power down control data\n",
> +			__func__);
> +		return err;
> +	}
> +
> +	/* Write out the TPI AVI InfoFrame Data (all defaults) */
> +	/* Compute CRC*/
> +	val = 0x82 + 0x02 + 13;
> +
> +	for (i = 0; i < sizeof(avi_info_frame_data); i++)
> +		val += avi_info_frame_data[i];
> +
> +	avi_info_frame_data[0] = 0x100 - val;
> +
> +	out_len = 0;
> +	err = sil9022_blockwrite_reg(sil9022_client,
> +				     HDMI_TPI_AVI_DBYTE_BASE_REG,
> +				     sizeof(avi_info_frame_data),
> +				     avi_info_frame_data, &out_len);
> +	if (err < 0) {
> +		dev_err(&sil9022_client->dev,
> +			"<%s> ERROR: writing TPI AVI infoframe data\n",
> +			__func__);
> +		return err;
> +	}
> +
> +	/*  Audio Configuration  */
> +	err = sil9022_enable_audio(sil9022_client);
> +	if (err < 0) {
> +		dev_err(&sil9022_client->dev,
> +			"<%s> ERROR: Unable set audio configuration\n",
> +			__func__);
> +		return err;
> +	}
> +
> +	/*  Write out the TPI Device Power State (D0) */
> +	val = TPI_AVI_POWER_STATE_D0;
> +	err = sil9022_write_reg(sil9022_client,
> +				HDMI_TPI_POWER_STATE_CTRL_REG, val);
> +	if (err < 0) {
> +		dev_err(&sil9022_client->dev,
> +			"<%s> ERROR: Setting device power state to D0\n",
> +			__func__);
> +		return err;
> +	}
> +
> +	/* Write out the TPI System Control Data to power up and
> +	 * select output mode
> +	 */
> +	val = TPI_SYS_CTRL_POWER_ACTIVE | TPI_SYS_CTRL_OUTPUT_MODE_HDMI;
> +	err = sil9022_write_reg(sil9022_client, HDMI_SYS_CTRL_DATA_REG, val);
> +	if (err < 0) {
> +		dev_err(&sil9022_client->dev,
> +			"<%s> ERROR: Writing system control data\n", __func__);
> +		return err;
> +	}
> +
> +	/*  Read back TPI System Control Data to latch settings */
> +	msleep(20);
> +	err = sil9022_read_reg(sil9022_client, 1, HDMI_SYS_CTRL_DATA_REG, &val);
> +	if (err < 0) {
> +		dev_err(&sil9022_client->dev,
> +			"<%s> ERROR: Writing system control data\n",
> +			__func__);
> +		return err;
> +	}
> +
> +	/* HDCP Enable - Disable */
> +	val = 0;
> +	err = sil9022_write_reg(sil9022_client,
> +				HDMI_TPI_HDCP_CONTROLDATA_REG, val);
> +	if (err < 0) {
> +		dev_err(&sil9022_client->dev,
> +			"<%s> ERROR: Enable (1) / Disable (0) => HDCP: %d\n",
> +			__func__, val);
> +		return err;
> +	}
> +
> +	dev_info(&sil9022_client->dev, "<%s> hdmi enabled\n", __func__);
> +	return 0;
> +
> +}
> +
> +static int
> +sil9022_disable(void)
> +{
> +	u8 val = 0;
> +	int err = 0;
> +
> +	err = sil9022_disable_audio(sil9022_client);
> +	if (err < 0) {
> +		dev_err(&sil9022_client->dev,
> +			"<%s> ERROR: failed to disable audio\n", __func__);
> +		return err;
> +	}
> +
> +	/*  Write out the TPI System Control Data to power down  */
> +	val = TPI_SYS_CTRL_POWER_DOWN;
> +	err = sil9022_write_reg(sil9022_client, HDMI_SYS_CTRL_DATA_REG, val);
> +	if (err < 0) {
> +		dev_err(&sil9022_client->dev,
> +			"<%s> ERROR: writing control data - power down\n",
> +			__func__);
> +		return err;
> +	}
> +
> +	/*  Write out the TPI Device Power State (D2) */
> +	val = TPI_AVI_POWER_STATE_D2;
> +	err = sil9022_write_reg(sil9022_client,
> +			  HDMI_TPI_DEVICE_POWER_STATE_DATA, val);
> +	if (err < 0) {
> +		dev_err(&sil9022_client->dev,
> +			"<%s> ERROR: Setting device power state to D2\n",
> +			__func__);
> +		return err;
> +	}
> +
> +	/*  Read back TPI System Control Data to latch settings */
> +	mdelay(10);
> +	err = sil9022_read_reg(sil9022_client, 1, HDMI_SYS_CTRL_DATA_REG, &val);
> +	if (err < 0) {
> +		dev_err(&sil9022_client->dev,
> +			"<%s> ERROR:  Reading System control data "
> +			"- latch settings\n", __func__);
> +		return err;
> +	}
> +
> +	dev_info(&sil9022_client->dev, "<%s> hdmi disabled\n", __func__);
> +	return 0;
> +
> +}
> +
> +static int sil9022_set_reg_read_ctrl(struct i2c_client *client)
> +{
> +	int err = 0;
> +	u8 ver;
> +
> +	/* probe for sil9022 chip version*/
> +	err = sil9022_write_reg(client, SI9022_REG_TPI_RQB, 0x00);
> +	if (err < 0) {
> +		dev_err(&client->dev,
> +			"<%s> ERROR: Writing HDMI configuration to "
> +			"reg - SI9022_REG_TPI_RQB\n", __func__);
> +		err = -ENODEV;
> +		goto ERROR1;
> +	}
> +
> +	err = sil9022_read_reg(client, 1, SI9022_REG_CHIPID0, &ver);
> +	if (err < 0) {
> +		dev_err(&client->dev,
> +			"<%s> ERROR: Reading HDMI version Id\n", __func__);
> +		err = -ENODEV;
> +		goto ERROR1;
> +	} else if (ver != SI9022_CHIPID_902x) {
> +		dev_err(&client->dev,
> +			"<%s> Not a valid verId: 0x%x\n", __func__, ver);
> +		err = -ENODEV;
> +		goto ERROR1;
> +	} else
> +		dev_info(&client->dev,
> +			 "<%s> sil9022 HDMI Chip version = %x\n",
> +			 __func__, ver);
> +
> +	return 0;
> +ERROR1:
> +	return err;
> +}
> +
> +static inline struct sil9022_platform_data
> +*get_panel_data(const struct omap_dss_device *dssdev)
> +{
> +	return (struct sil9022_platform_data *) dssdev->data;
> +}
> +
> +
> +static int sil9022_panel_probe(struct omap_dss_device *dssdev)
> +{
> +	struct sil9022_platform_data *sidata = get_panel_data(dssdev);
> +	int r;
> +	if (!sidata)
> +		return -EINVAL;
> +
> +	dssdev->panel.timings = omap_dss_hdmi_timings;
> +
> +	if (gpio_is_valid(sidata->res_gpio)) {
> +		r = devm_gpio_request_one(&dssdev->dev, sidata->res_gpio,
> +				GPIOF_OUT_INIT_HIGH, "HDMI");
> +		if (r)
> +			return r;
> +	}
> +
> +	return 0;
> +}
> +
> +static void sil9022_panel_remove(struct omap_dss_device *dssdev)
> +{
> +	omap_dss_unregister_driver(dssdev->driver);
> +}
> +
> +
> +static int sil9022_panel_power_on(struct omap_dss_device *dssdev)
> +{
> +	int r = 0;
> +	struct sil9022_platform_data *sidata = get_panel_data(dssdev);
> +
> +	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
> +		return 0;
> +
> +	if (gpio_is_valid(sidata->res_gpio))
> +		gpio_set_value_cansleep(sidata->res_gpio, 1);
> +
> +	omapdss_dpi_set_timings(dssdev, &dssdev->panel.timings);
> +	omapdss_dpi_set_data_lines(dssdev, dssdev->phy.dpi.data_lines);
> +	r = omapdss_dpi_display_enable(dssdev);
> +	return r;
> +
> +}
> +
> +static void sil9022_panel_power_off(struct omap_dss_device *dssdev)
> +{
> +	struct sil9022_platform_data *sidata = get_panel_data(dssdev);
> +
> +	if (gpio_is_valid(sidata->res_gpio))
> +		gpio_set_value_cansleep(sidata->res_gpio, 0);
> +	return;
> +
> +}
> +
> +static int sil9022_panel_enable(struct omap_dss_device *dssdev)
> +{
> +	int r = 0;
> +
> +	r = sil9022_panel_power_on(dssdev);
> +	if (r)
> +			goto ERROR0;
> +	r = sil9022_set_reg_read_ctrl(sil9022_client);
> +	if (r)
> +		goto ERROR0;
> +
> +	r = sil9022_enable(dssdev);
> +	if (r)
> +		goto ERROR0;
> +	/* wait couple of vsyncs until enabling the LCD */
> +	msleep(50);
> +	return 0;
> +
> +ERROR0:
> +	return r;
> +}
> +
> +static void sil9022_panel_disable(struct omap_dss_device *dssdev)
> +{
> +	sil9022_disable();
> +	/* wait couple of vsyncs until enabling the hdmi */
> +	msleep(50);
> +	sil9022_panel_power_off(dssdev);
> +	return;
> +}
> +
> +static struct omap_dss_driver hdmi_driver = {
> +	.probe		= sil9022_panel_probe,
> +	.remove		= sil9022_panel_remove,
> +
> +	.enable		= sil9022_panel_enable,
> +	.disable		= sil9022_panel_disable,
> +
> +	.driver         = {
> +		.name   = "sil9022_panel",
> +		.owner  = THIS_MODULE,
> +	},
> +};
> +
> +static int
> +sil9022_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +{
> +	int err = 0;
> +
> +	sil9022_client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
> +	if (!sil9022_client) {
> +		err = -ENOMEM;
> +		goto ERROR0;
> +	}
> +	memset(sil9022_client, 0, sizeof(struct i2c_client));
> +
> +	strncpy(sil9022_client->name, client->name, I2C_NAME_SIZE);
> +	sil9022_client->addr = client->addr;
> +	sil9022_client->adapter = client->adapter;
> +
> +	err = sil9022_set_reg_read_ctrl(client);
> +	if (err)
> +		goto ERROR1;
> +
> +	omap_dss_register_driver(&hdmi_driver);
> +	return 0;
> +
> +ERROR1:
> +	kfree(sil9022_client);
> +ERROR0:
> +	return err;
> +}
> +
> +
> +static int
> +sil9022_remove(struct i2c_client *client)
> +
> +{
> +	int err = 0;
> +
> +	if (!client->adapter) {
> +		dev_err(&sil9022_client->dev, "<%s> No HDMI Device\n",
> +			__func__);
> +		return -ENODEV;
> +	}
> +	kfree(sil9022_client);
> +
> +	return err;
> +}
> +
> +static const struct i2c_device_id sil9022_id[] = {
> +	{ SIL9022_DRV_NAME, 0 },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, sil9022_id);
> +
> +static struct i2c_driver sil9022_driver = {
> +	.driver = {
> +		.name  = SIL9022_DRV_NAME,
> +		.owner = THIS_MODULE,
> +		},
> +	.probe		= sil9022_probe,
> +	.remove		= sil9022_remove,
> +	.id_table	= sil9022_id,
> +};
> +
> +static int __init
> +sil9022_init(void)
> +{
> +	int err = 0;
> +	err = i2c_add_driver(&sil9022_driver);
> +	if (err < 0) {
> +		printk(KERN_ERR "<%s> Driver registration failed\n", __func__);
> +		err = -ENODEV;
> +		goto ERROR0;
> +	}
> +
> +	if (sil9022_client == NULL) {
> +		printk(KERN_ERR "<%s> sil9022_client not allocated\n"
> +				"<%s> No HDMI Device\n", __func__, __func__);
> +		err = -ENODEV;
> +		goto ERROR0;
> +	}
> +	return 0;
> +
> +ERROR0:
> +	return err;
> +}
> +
> +static void __exit
> +sil9022_exit(void)
> +{
> +	i2c_del_driver(&sil9022_driver);
> +}
> +
> +late_initcall(sil9022_init);
> +module_exit(sil9022_exit);
> +
> +MODULE_AUTHOR("Texas Instruments");
> +MODULE_DESCRIPTION("SIL9022 HDMI Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/video/omap2/displays/panel-sil9022.h b/drivers/video/omap2/displays/panel-sil9022.h
> new file mode 100644
> index 0000000..7c920c0
> --- /dev/null
> +++ b/drivers/video/omap2/displays/panel-sil9022.h
> @@ -0,0 +1,527 @@
> +/*
> + * drivers/video/omap2/displays/panel-sil9022.c
> + *
> + * Copyright (C) 2009 Texas Instruments
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2. This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + *
> + * sil9022 hdmi driver
> + */
> +#ifndef _SI9022_H_
> +#define _SI9022_H_
> +
> +#define SIL9022_DRV_NAME		"sil9022"
> +
> +#define CLKOUT2_EN		(0x1 << 7)
> +#define CLKOUT2_DIV		(0x4 << 3)
> +#define CLKOUT2SOURCE		(0x2 << 0)
> +#define CM_CLKOUT_CTRL		0x48004D70
> +
> +#define HDMI_XRES			1280
> +#define HDMI_YRES			720
> +#define HDMI_PIXCLOCK_MAX		74250
> +#define VERTICAL_FREQ			0x3C
> +
> +#define I2C_M_WR			0
> +
> +#define SI9022_USERST_PIN		1
> +
> +#define SI9022_REG_PIX_CLK_LSB		0x00
> +#define SI9022_REG_PIX_CLK_MSB		0x01
> +
> +#define SI9022_REG_PIX_REPETITION	0x08
> +#define SI9022_REG_INPUT_FORMAT		0x09
> +#define SI9022_REG_OUTPUT_FORMAT	0x0A
> +#define SI9022_REG_SYNC_GEN_CTRL	0x60
> +
> +#define SI9022_REG_DE_CTRL		0x63
> +#define DE_DLY_MSB_BITPOS		0
> +#define HSYNCPOL_INVERT_BITPOS		4
> +#define VSYNCPOL_INVERT_BITPOS		5
> +#define DE_GENERATOR_EN_BITPOS		6
> +
> +#define SI9022_REG_PWR_STATE		0x1E
> +
> +#define SI9022_REG_TPI_RQB		0xC7
> +
> +#define SI9022_REG_INT_PAGE		0xBC
> +#define SI9022_REG_OFFSET		0xBD
> +#define	SI9022_REG_VALUE		0xBE
> +
> +#define SI9022_PLLMULT_BITPOS		0x05
> +
> +#define SI9022_REG_TPI_SYSCTRL		0x1A
> +#define I2DDCREQ_BITPOS			2
> +#define TMDS_ENABLE_BITPOS		4
> +#define HDMI_ENABLE_BITPOS		0
> +
> +#define SI9022_REG_CHIPID0		0x1B
> +#define SI9022_REG_CHIPID1		0x1C
> +#define SI9022_REG_CHIPID2		0x1D
> +#define SI9022_REG_HDCPVER		0x30
> +
> +#define SI9022_REG_INTSTATUS		0x3D
> +#define HOTPLUG_PENDING_BITPOS		0
> +#define RCV_SENSE_PENDING_BITPOS	1
> +#define HOTPLUG_SENSE_BITPOS		2
> +#define RX_SENSE_BITPOS			3
> +#define AUDIO_ERR_PENDING_BITPOS	4
> +
> +
> +#define SI9022_I2CSLAVEADDRESS		0x39
> +
> +#define SI9022_CHIPID_902x		0xB0
> +
> +#define SI9022_MAXRETRY			100
> +
> +#define SI9022_EDID_DETAILED_TIMING_OFFSET	0x36 /*EDID Detailed Timing */
> +						/*Info 0 begin offset*/
> +#define SI9022_EDID_PIX_CLK_OFFSET		0
> +#define SI9022_EDID_H_ACTIVE_OFFSET		2
> +#define SI9022_EDID_H_BLANKING_OFFSET		3
> +#define SI9022_EDID_V_ACTIVE_OFFSET		5
> +#define SI9022_EDID_V_BLANKING_OFFSET		6
> +#define SI9022_EDID_H_SYNC_OFFSET		8
> +#define SI9022_EDID_H_SYNC_PW_OFFSET		9
> +#define SI9022_EDID_V_SYNC_OFFSET		10
> +#define SI9022_EDID_V_SYNC_PW_OFFSET		10
> +#define SI9022_EDID_H_IMAGE_SIZE_OFFSET		12
> +#define SI9022_EDID_V_IMAGE_SIZE_OFFSET		13
> +#define SI9022_EDID_H_BORDER_OFFSET		15
> +#define SI9022_EDID_V_BORDER_OFFSET		16
> +#define SI9022_EDID_FLAGS_OFFSET		17
> +
> +#define SI9022_PLUG_DETECTED			0xF0
> +#define SI9022_UNPLUG_DETECTED			0xF1
> +
> +
> +/* ---------------------------------------------------------------------  */
> +#define EDID_TIMING_DESCRIPTOR_SIZE		0x12
> +#define EDID_DESCRIPTOR_BLOCK0_ADDRESS		0x36
> +#define EDID_DESCRIPTOR_BLOCK1_ADDRESS		0x80
> +#define EDID_SIZE_BLOCK0_TIMING_DESCRIPTOR	4
> +#define EDID_SIZE_BLOCK1_TIMING_DESCRIPTOR	4
> +
> +/* HDMI Connected States  */
> +#define HDMI_STATE_NOMONITOR	0	/* NOT CONNECTED */
> +#define HDMI_STATE_CONNECTED	1	/* CONNECTED */
> +#define HDMI_STATE_ON		2	/* CONNECTED AND POWERED ON */
> +
> +
> +/* HDMI EDID Length  */
> +#define HDMI_EDID_MAX_LENGTH	256
> +
> +/* HDMI EDID DTDs  */
> +#define HDMI_EDID_MAX_DTDS	4
> +
> +/* HDMI EDID DTD Tags  */
> +#define HDMI_EDID_DTD_TAG_MONITOR_NAME		0xFC
> +#define HDMI_EDID_DTD_TAG_MONITOR_SERIALNUM	0xFF
> +#define HDMI_EDID_DTD_TAG_MONITOR_LIMITS	0xFD
> +
> +
> +/* HDMI EDID Extension Data Block Tags  */
> +#define HDMI_EDID_EX_DATABLOCK_TAG_MASK		0xE0
> +#define HDMI_EDID_EX_DATABLOCK_LEN_MASK		0x1F
> +
> +#define HDMI_EDID_EX_DATABLOCK_AUDIO		0x20
> +#define HDMI_EDID_EX_DATABLOCK_VIDEO		0x40
> +#define HDMI_EDID_EX_DATABLOCK_VENDOR		0x60
> +#define HDMI_EDID_EX_DATABLOCK_SPEAKERS		0x80
> +
> +/* HDMI EDID Extenion Data Block Values: Video  */
> +#define HDMI_EDID_EX_VIDEO_NATIVE		0x80
> +#define HDMI_EDID_EX_VIDEO_MASK			0x7F
> +#define HDMI_EDID_EX_VIDEO_MAX			35
> +
> +#define HDMI_EDID_EX_VIDEO_640x480p_60Hz_4_3		1
> +#define HDMI_EDID_EX_VIDEO_720x480p_60Hz_4_3		2
> +#define HDMI_EDID_EX_VIDEO_720x480p_60Hz_16_9		3
> +#define HDMI_EDID_EX_VIDEO_1280x720p_60Hz_16_9		4
> +#define HDMI_EDID_EX_VIDEO_1920x1080i_60Hz_16_9		5
> +#define HDMI_EDID_EX_VIDEO_720x480i_60Hz_4_3		6
> +#define HDMI_EDID_EX_VIDEO_720x480i_60Hz_16_9		7
> +#define HDMI_EDID_EX_VIDEO_720x240p_60Hz_4_3		8
> +#define HDMI_EDID_EX_VIDEO_720x240p_60Hz_16_9		9
> +#define HDMI_EDID_EX_VIDEO_2880x480i_60Hz_4_3		10
> +#define HDMI_EDID_EX_VIDEO_2880x480i_60Hz_16_9		11
> +#define HDMI_EDID_EX_VIDEO_2880x480p_60Hz_4_3		12
> +#define HDMI_EDID_EX_VIDEO_2880x480p_60Hz_16_9		13
> +#define HDMI_EDID_EX_VIDEO_1440x480p_60Hz_4_3		14
> +#define HDMI_EDID_EX_VIDEO_1440x480p_60Hz_16_9		15
> +#define HDMI_EDID_EX_VIDEO_1920x1080p_60Hz_16_9		16
> +#define HDMI_EDID_EX_VIDEO_720x576p_50Hz_4_3		17
> +#define HDMI_EDID_EX_VIDEO_720x576p_50Hz_16_9		18
> +#define HDMI_EDID_EX_VIDEO_1280x720p_50Hz_16_9		19
> +#define HDMI_EDID_EX_VIDEO_1920x1080i_50Hz_16_9		20
> +#define HDMI_EDID_EX_VIDEO_720x576i_50Hz_4_3		21
> +#define HDMI_EDID_EX_VIDEO_720x576i_50Hz_16_9		22
> +#define HDMI_EDID_EX_VIDEO_720x288p_50Hz_4_3		23
> +#define HDMI_EDID_EX_VIDEO_720x288p_50Hz_16_9		24
> +#define HDMI_EDID_EX_VIDEO_2880x576i_50Hz_4_3		25
> +#define HDMI_EDID_EX_VIDEO_2880x576i_50Hz_16_9		26
> +#define HDMI_EDID_EX_VIDEO_2880x288p_50Hz_4_3		27
> +#define HDMI_EDID_EX_VIDEO_2880x288p_50Hz_16_9		28
> +#define HDMI_EDID_EX_VIDEO_1440x576p_50Hz_4_3		29
> +#define HDMI_EDID_EX_VIDEO_1440x576p_50Hz_16_9		30
> +#define HDMI_EDID_EX_VIDEO_1920x1080p_50Hz_16_9		31
> +#define HDMI_EDID_EX_VIDEO_1920x1080p_24Hz_16_9		32
> +#define HDMI_EDID_EX_VIDEO_1920x1080p_25Hz_16_9		33
> +#define HDMI_EDID_EX_VIDEO_1920x1080p_30Hz_16_9		34
> +
> +/*  HDMI TPI Registers  */
> +#define HDMI_TPI_VIDEO_DATA_BASE_REG	0x00
> +#define HDMI_TPI_PIXEL_CLK_LSB_REG	 (HDMI_TPI_VIDEO_DATA_BASE_REG + 0x00)
> +#define HDMI_TPI_PIXEL_CLK_MSB_REG (HDMI_TPI_VIDEO_DATA_BASE_REG + 0x01)
> +#define HDMI_TPI_VFREQ_LSB_REG	(HDMI_TPI_VIDEO_DATA_BASE_REG + 0x02)
> +#define HDMI_TPI_VFREQ_MSB_REG	(HDMI_TPI_VIDEO_DATA_BASE_REG + 0x03)
> +#define HDMI_TPI_PIXELS_LSB_REG	(HDMI_TPI_VIDEO_DATA_BASE_REG + 0x04)
> +#define HDMI_TPI_PIXELS_MSB_REG	(HDMI_TPI_VIDEO_DATA_BASE_REG + 0x05)
> +#define HDMI_TPI_LINES_LSB_REG		(HDMI_TPI_VIDEO_DATA_BASE_REG + 0x06)
> +#define HDMI_TPI_LINES_MSB_REG		(HDMI_TPI_VIDEO_DATA_BASE_REG + 0x07)
> +
> +#define HDMI_TPI_PIXEL_REPETITION_REG	0x08
> +
> +#define HDMI_TPI_AVI_INOUT_BASE_REG	0x09
> +#define HDMI_TPI_AVI_IN_FORMAT_REG	(HDMI_TPI_AVI_INOUT_BASE_REG + 0x00)
> +#define HDMI_TPI_AVI_OUT_FORMAT_REG	(HDMI_TPI_AVI_INOUT_BASE_REG + 0x01)
> +
> +#define HDMI_SYS_CTRL_DATA_REG		0x1A
> +
> +#define HDMI_TPI_SYN_GENERATOR_REG	0x60
> +
> +#define HDMI_TPI_VIDEO_SYN_POLARITY_REG	0x61
> +
> +#define HDMI_TPI_DE_BASE_REG			0x62
> +#define HDMI_TPI_DE_DLY_LSB_REG		(HDMI_TPI_DE_BASE_REG + 0x0)
> +#define HDMI_TPI_DE_DLY_MSB_REG		(HDMI_TPI_DE_BASE_REG + 0x1)
> +#define HDMI_TPI_DE_TOP_REG			(HDMI_TPI_DE_BASE_REG + 0x2)
> +#define HDMI_TPI_DE_RSVD_REG			(HDMI_TPI_DE_BASE_REG + 0x3)
> +#define HDMI_TPI_DE_CNT_LSB_REG		(HDMI_TPI_DE_BASE_REG + 0x4)
> +#define HDMI_TPI_DE_CNT_MSB_REG		(HDMI_TPI_DE_BASE_REG + 0x5)
> +#define HDMI_TPI_DE_LIN_LSB_REG		(HDMI_TPI_DE_BASE_REG + 0x6)
> +#define HDMI_TPI_DE_LIN_MSB_REG		(HDMI_TPI_DE_BASE_REG + 0x7)
> +
> +#define HDMI_TPI_HRES_LSB_REG		0x6A
> +#define HDMI_TPI_HRES_MSB_REG		0x6B
> +
> +#define HDMI_TPI_VRES_LSB_REG		0x6C
> +#define HDMI_TPI_VRES_MSB_REG		0x6D
> +
> +#define HDMI_TPI_RQB_REG		0xC7
> +#define HDMI_TPI_DEVID_REG		0x1B
> +#define HDMI_TPI_DEVREV_REG		0x1C
> +
> +#define HDMI_TPI_DEVICE_POWER_STATE_DATA	0x1E
> +#define HDMI_REQ_GRANT_BMODE_REG		0xC7
> +#define HDMI_TPI_DEVICE_ID_REG			0x1B
> +#define HDMI_TPI_REVISION_REG			0x1C
> +#define HDMI_TPI_ID_BYTE2_REG			0x1D
> +#define HDMI_TPI_POWER_STATE_CTRL_REG		0x1E
> +
> +#define HDMI_TPI_INTERRUPT_ENABLE_REG		0x3C
> +#define HDMI_TPI_INTERRUPT_STATUS_REG		0x3D
> +
> +
> +/* AVI InfoFrames can be readed byte by byte but must be write in a burst  */
> +#define HDMI_TPI_AVI_DBYTE_BASE_REG      0x0C
> +#define HDMI_TPI_AVI_DBYTE0_CHKSUM_REG   (HDMI_TPI_AVI_DBYTE_BASE_REG +  0x00)
> +#define HDMI_TPI_AVI_DBYTE1_REG          (HDMI_TPI_AVI_DBYTE_BASE_REG +  0x01)
> +#define HDMI_TPI_AVI_DBYTE2_REG          (HDMI_TPI_AVI_DBYTE_BASE_REG +  0x02)
> +#define HDMI_TPI_AVI_DBYTE3_REG          (HDMI_TPI_AVI_DBYTE_BASE_REG +  0x03)
> +#define HDMI_TPI_AVI_DBYTE4_REG          (HDMI_TPI_AVI_DBYTE_BASE_REG +  0x04)
> +#define HDMI_TPI_AVI_DBYTE5_REG          (HDMI_TPI_AVI_DBYTE_BASE_REG +  0x05)
> +#define HDMI_TPI_AVI_ETB_LSB_REG         (HDMI_TPI_AVI_DBYTE_BASE_REG +  0x06)
> +#define HDMI_TPI_AVI_ETB_MSB_REG         (HDMI_TPI_AVI_DBYTE_BASE_REG +  0x07)
> +#define HDMI_TPI_AVI_SBB_LSB_REG         (HDMI_TPI_AVI_DBYTE_BASE_REG +  0x08)
> +#define HDMI_TPI_AVI_SBB_MSB_REG         (HDMI_TPI_AVI_DBYTE_BASE_REG +  0x09)
> +#define HDMI_TPI_AVI_ELB_LSB_REG         (HDMI_TPI_AVI_DBYTE_BASE_REG +  0x0A)
> +#define HDMI_TPI_AVI_ELB_MSB_REG         (HDMI_TPI_AVI_DBYTE_BASE_REG +  0x0B)
> +#define HDMI_TPI_AVI_SRB_LSB_REG         (HDMI_TPI_AVI_DBYTE_BASE_REG +  0x0C)
> +#define HDMI_TPI_AVI_SRB_MSB_REG         (HDMI_TPI_AVI_DBYTE_BASE_REG +  0x0D)
> +
> +#define HDMI_CPI_MISC_IF_SELECT_REG         0xBF
> +#define HDMI_CPI_MISC_IF_OFFSET             0xC0
> +
> +#define MISC_INFOFRAME_SIZE_MEMORY          14
> +#define MISC_INFOFRAME_TYPE_SUBOFFSET       0
> +#define MISC_INFOFRAME_VERSION_SUBOFFSET    1
> +#define MISC_INFOFRAME_LENGTH_SUBOFFSET     2
> +#define MISC_INFOFRAME_CHECKSUM_SUBOFFSET   3
> +#define MISC_INFOFRAME_DBYTE1_SUBOFFSET     4
> +#define MISC_INFOFRAME_DBYTE2_SUBOFFSET     5
> +#define MISC_INFOFRAME_DBYTE3_SUBOFFSET     6
> +#define MISC_INFOFRAME_DBYTE4_SUBOFFSET     7
> +#define MISC_INFOFRAME_DBYTE5_SUBOFFSET     8
> +#define MISC_INFOFRAME_DBYTE6_SUBOFFSET     9
> +#define MISC_INFOFRAME_DBYTE7_SUBOFFSET     10
> +#define MISC_INFOFRAME_DBYTE8_SUBOFFSET     11
> +#define MISC_INFOFRAME_DBYTE9_SUBOFFSET     12
> +#define MISC_INFOFRAME_DBYTE10_SUBOFFSET    13
> +
> +#define HDMI_CPI_MISC_TYPE_REG		(HDMI_CPI_MISC_IF_OFFSET\
> +					+  MISC_INFOFRAME_TYPE_SUBOFFSET)
> +#define HDMI_CPI_MISC_VERSION_REG	(HDMI_CPI_MISC_IF_OFFSET\
> +					+  MISC_INFOFRAME_VERSION_SUBOFFSET)
> +#define HDMI_CPI_MISC_LENGTH_REG	(HDMI_CPI_MISC_IF_OFFSET\
> +					+  MISC_INFOFRAME_LENGTH_SUBOFFSET)
> +#define HDMI_CPI_MISC_CHECKSUM_REG	(HDMI_CPI_MISC_IF_OFFSET\
> +					+  MISC_INFOFRAME_CHECKSUM_SUBOFFSET)
> +#define HDMI_CPI_MISC_DBYTE1_REG        (HDMI_CPI_MISC_IF_OFFSET\
> +					+  MISC_INFOFRAME_DBYTE1_SUBOFFSET)
> +#define HDMI_CPI_MISC_DBYTE2_REG        (HDMI_CPI_MISC_IF_OFFSET\
> +					+  MISC_INFOFRAME_DBYTE2_SUBOFFSET)
> +#define HDMI_CPI_MISC_DBYTE3_REG        (HDMI_CPI_MISC_IF_OFFSET\
> +					+  MISC_INFOFRAME_DBYTE3_SUBOFFSET)
> +#define HDMI_CPI_MISC_DBYTE4_REG        (HDMI_CPI_MISC_IF_OFFSET\
> +					+  MISC_INFOFRAME_DBYTE4_SUBOFFSET)
> +#define HDMI_CPI_MISC_DBYTE5_REG        (HDMI_CPI_MISC_IF_OFFSET\
> +					+  MISC_INFOFRAME_DBYTE5_SUBOFFSET)
> +#define HDMI_CPI_MISC_DBYTE6_REG        (HDMI_CPI_MISC_IF_OFFSET\
> +					+  MISC_INFOFRAME_DBYTE6_SUBOFFSET)
> +#define HDMI_CPI_MISC_DBYTE7_REG        (HDMI_CPI_MISC_IF_OFFSET\
> +					+  MISC_INFOFRAME_DBYTE7_SUBOFFSET)
> +#define HDMI_CPI_MISC_DBYTE8_REG        (HDMI_CPI_MISC_IF_OFFSET\
> +					+  MISC_INFOFRAME_DBYTE8_SUBOFFSET)
> +#define HDMI_CPI_MISC_DBYTE9_REG        (HDMI_CPI_MISC_IF_OFFSET\
> +					+  MISC_INFOFRAME_DBYTE9_SUBOFFSET)
> +#define HDMI_CPI_MISC_DBYTE10_REG       (HDMI_CPI_MISC_IF_OFFSET\
> +					+  MISC_INFOFRAME_DBYTE10_SUBOFFSET)
> +
> +/* Audio  */
> +#define HDMI_TPI_I2S_ENABLE_MAPPING_REG     0x1F
> +#define HDMI_TPI_I2S_INPUT_CONFIG_REG       0x20
> +#define HDMI_TPI_I2S_STRM_HDR_BASE          0x21
> +#define HDMI_TPI_I2S_STRM_HDR_0_REG         (HDMI_TPI_I2S_STRM_HDR_BASE + 0)
> +#define HDMI_TPI_I2S_STRM_HDR_1_REG         (HDMI_TPI_I2S_STRM_HDR_BASE + 1)
> +#define HDMI_TPI_I2S_STRM_HDR_2_REG         (HDMI_TPI_I2S_STRM_HDR_BASE + 2)
> +#define HDMI_TPI_I2S_STRM_HDR_3_REG         (HDMI_TPI_I2S_STRM_HDR_BASE + 3)
> +#define HDMI_TPI_I2S_STRM_HDR_4_REG         (HDMI_TPI_I2S_STRM_HDR_BASE + 4)
> +#define HDMI_TPI_AUDIO_CONFIG_BYTE2_REG     0x26
> +#define HDMI_TPI_AUDIO_CONFIG_BYTE3_REG     0x27
> +#define HDMI_TPI_AUDIO_CONFIG_BYTE4_REG     0x28
> +
> +/* HDCP */
> +#define HDMI_TPI_HDCP_QUERYDATA_REG         0x29
> +#define HDMI_TPI_HDCP_CONTROLDATA_REG       0x2A
> +
> +/* HDMI_TPI_DEVICE_ID_REG  */
> +#define TPI_DEVICE_ID                       0xB0
> +
> +/* HDMI_TPI_REVISION_REG  */
> +#define TPI_REVISION                        0x00
> +
> +/* HDMI_TPI_ID_BYTE2_REG  */
> +#define TPI_ID_BYTE2_VALUE                  0x00
> +
> +/* HDMI_SYS_CTRL_DATA_REG  */
> +#define TPI_SYS_CTRL_POWER_DOWN             (1 << 4)
> +#define TPI_SYS_CTRL_POWER_ACTIVE           (0 << 4)
> +#define TPI_SYS_CTRL_AV_MUTE                (1 << 3)
> +#define TPI_SYS_CTRL_DDC_BUS_REQUEST        (1 << 2)
> +#define TPI_SYS_CTRL_DDC_BUS_GRANTED        (1 << 1)
> +#define TPI_SYS_CTRL_OUTPUT_MODE_HDMI       (1 << 0)
> +#define TPI_SYS_CTRL_OUTPUT_MODE_DVI        (0 << 0)
> +
> +
> +/* HDMI Monitor I2C default address  */
> +#define HDMI_I2C_MONITOR_ADDRESS            0x50
> +
> +
> +/* HDMI_TPI_INTR_ENABLE  */
> +#define TPI_INTR_ENABLE_SECURITY_EVENT      (1 << 5)
> +#define TPI_INTR_ENABLE_AUDIO_EVENT         (1 << 4)
> +#define TPI_INTR_ENABLE_CPI_EVENT           (1 << 3)
> +#define TPI_INTR_ENABLE_RECEIVER_EVENT      (1 << 1)
> +#define TPI_INTR_ENABLE_HOTPLUG_EVENT       (1 << 0)
> +
> +/* HDMI_TPI_INTR_STATUS  */
> +#define TPI_INTR_STATUS_SECURITY_EVENT      (1 << 5)
> +#define TPI_INTR_STATUS_AUDIO_EVENT         (1 << 4)
> +#define TPI_INTR_STATUS_POWERED_EVENT       (1 << 3)
> +#define TPI_INTR_STATUS_HOTPLUG_STATE       (1 << 2)
> +#define TPI_INTR_STATUS_RECEIVER_EVENT      (1 << 1)
> +#define TPI_INTR_STATUS_HOTPLUG_EVENT       (1 << 0)
> +
> +
> +/* HDMI_TPI_PIXEL_REPETITION  */
> +#define TPI_AVI_PIXEL_REP_BUS_24BIT         (1 << 5)
> +#define TPI_AVI_PIXEL_REP_BUS_12BIT         (0 << 5)
> +#define TPI_AVI_PIXEL_REP_RISING_EDGE       (1 << 4)
> +#define TPI_AVI_PIXEL_REP_FALLING_EDGE      (0 << 4)
> +#define TPI_AVI_PIXEL_REP_4X                (3 << 0)
> +#define TPI_AVI_PIXEL_REP_2X                (1 << 0)
> +#define TPI_AVI_PIXEL_REP_NONE              (0 << 0)
> +
> +/* HDMI_TPI_AVI_INPUT_FORMAT  */
> +#define TPI_AVI_INPUT_BITMODE_12BIT         (1 << 7)
> +#define TPI_AVI_INPUT_BITMODE_8BIT          (0 << 7)
> +#define TPI_AVI_INPUT_DITHER                (1 << 6)
> +#define TPI_AVI_INPUT_RANGE_LIMITED         (2 << 2)
> +#define TPI_AVI_INPUT_RANGE_FULL            (1 << 2)
> +#define TPI_AVI_INPUT_RANGE_AUTO            (0 << 2)
> +#define TPI_AVI_INPUT_COLORSPACE_BLACK      (3 << 0)
> +#define TPI_AVI_INPUT_COLORSPACE_YUV422     (2 << 0)
> +#define TPI_AVI_INPUT_COLORSPACE_YUV444     (1 << 0)
> +#define TPI_AVI_INPUT_COLORSPACE_RGB        (0 << 0)
> +
> +
> +/* HDMI_TPI_AVI_OUTPUT_FORMAT  */
> +#define TPI_AVI_OUTPUT_CONV_BT709           (1 << 4)
> +#define TPI_AVI_OUTPUT_CONV_BT601           (0 << 4)
> +#define TPI_AVI_OUTPUT_RANGE_LIMITED        (2 << 2)
> +#define TPI_AVI_OUTPUT_RANGE_FULL           (1 << 2)
> +#define TPI_AVI_OUTPUT_RANGE_AUTO           (0 << 2)
> +#define TPI_AVI_OUTPUT_COLORSPACE_RGBDVI    (3 << 0)
> +#define TPI_AVI_OUTPUT_COLORSPACE_YUV422    (2 << 0)
> +#define TPI_AVI_OUTPUT_COLORSPACE_YUV444    (1 << 0)
> +#define TPI_AVI_OUTPUT_COLORSPACE_RGBHDMI   (0 << 0)
> +
> +
> +/* HDMI_TPI_DEVICE_POWER_STATE  */
> +#define TPI_AVI_POWER_STATE_D3              (3 << 0)
> +#define TPI_AVI_POWER_STATE_D2              (2 << 0)
> +#define TPI_AVI_POWER_STATE_D0              (0 << 0)
> +
> +/* HDMI_TPI_AUDIO_CONFIG_BYTE2_REG  */
> +#define TPI_AUDIO_CODING_STREAM_HEADER      (0 << 0)
> +#define TPI_AUDIO_CODING_PCM                (1 << 0)
> +#define TPI_AUDIO_CODING_AC3                (2 << 0)
> +#define TPI_AUDIO_CODING_MPEG1              (3 << 0)
> +#define TPI_AUDIO_CODING_MP3                (4 << 0)
> +#define TPI_AUDIO_CODING_MPEG2              (5 << 0)
> +#define TPI_AUDIO_CODING_AAC                (6 << 0)
> +#define TPI_AUDIO_CODING_DTS                (7 << 0)
> +#define TPI_AUDIO_CODING_ATRAC              (8 << 0)
> +#define TPI_AUDIO_MUTE_DISABLE              (0 << 4)
> +#define TPI_AUDIO_MUTE_ENABLE               (1 << 4)
> +#define TPI_AUDIO_INTERFACE_DISABLE         (0 << 6)
> +#define TPI_AUDIO_INTERFACE_SPDIF           (1 << 6)
> +#define TPI_AUDIO_INTERFACE_I2S             (2 << 6)
> +
> +/* HDMI_TPI_AUDIO_CONFIG_BYTE3_REG  */
> +#define TPI_AUDIO_CHANNEL_STREAM            (0 << 0)
> +#define TPI_AUDIO_2_CHANNEL                 (1 << 0)
> +#define TPI_AUDIO_8_CHANNEL                 (7 << 0)
> +#define TPI_AUDIO_FREQ_STREAM               (0 << 3)
> +#define TPI_AUDIO_FREQ_32KHZ                (1 << 3)
> +#define TPI_AUDIO_FREQ_44KHZ                (2 << 3)
> +#define TPI_AUDIO_FREQ_48KHZ                (3 << 3)
> +#define TPI_AUDIO_FREQ_88KHZ                (4 << 3)
> +#define TPI_AUDIO_FREQ_96KHZ                (5 << 3)
> +#define TPI_AUDIO_FREQ_176KHZ               (6 << 3)
> +#define TPI_AUDIO_FREQ_192KHZ               (7 << 3)
> +#define TPI_AUDIO_SAMPLE_SIZE_STREAM        (0 << 6)
> +#define TPI_AUDIO_SAMPLE_SIZE_16            (1 << 6)
> +#define TPI_AUDIO_SAMPLE_SIZE_20            (2 << 6)
> +#define TPI_AUDIO_SAMPLE_SIZE_24            (3 << 6)
> +
> +/* HDMI_TPI_I2S_ENABLE_MAPPING_REG  */
> +#define TPI_I2S_SD_CONFIG_SELECT_SD0        (0 << 0)
> +#define TPI_I2S_SD_CONFIG_SELECT_SD1        (1 << 0)
> +#define TPI_I2S_SD_CONFIG_SELECT_SD2        (2 << 0)
> +#define TPI_I2S_SD_CONFIG_SELECT_SD3        (3 << 0)
> +#define TPI_I2S_LF_RT_SWAP_NO               (0 << 2)
> +#define TPI_I2S_LF_RT_SWAP_YES              (1 << 2)
> +#define TPI_I2S_DOWNSAMPLE_DISABLE          (0 << 3)
> +#define TPI_I2S_DOWNSAMPLE_ENABLE           (1 << 3)
> +#define TPI_I2S_SD_FIFO_0                   (0 << 4)
> +#define TPI_I2S_SD_FIFO_1                   (1 << 4)
> +#define TPI_I2S_SD_FIFO_2                   (2 << 4)
> +#define TPI_I2S_SD_FIFO_3                   (3 << 4)
> +#define TPI_I2S_SD_CHANNEL_DISABLE          (0 << 7)
> +#define TPI_I2S_SD_CHANNEL_ENABLE           (1 << 7)
> +
> +
> +/* HDMI_TPI_I2S_INPUT_CONFIG_REG  */
> +#define TPI_I2S_FIRST_BIT_SHIFT_YES         (0 << 0)
> +#define TPI_I2S_FIRST_BIT_SHIFT_NO          (1 << 0)
> +#define TPI_I2S_SD_DIRECTION_MSB_FIRST      (0 << 1)
> +#define TPI_I2S_SD_DIRECTION_LSB_FIRST      (1 << 1)
> +#define TPI_I2S_SD_JUSTIFY_LEFT             (0 << 2)
> +#define TPI_I2S_SD_JUSTIFY_RIGHT            (1 << 2)
> +#define TPI_I2S_WS_POLARITY_LOW             (0 << 3)
> +#define TPI_I2S_WS_POLARITY_HIGH            (1 << 3)
> +#define TPI_I2S_MCLK_MULTIPLIER_128         (0 << 4)
> +#define TPI_I2S_MCLK_MULTIPLIER_256         (1 << 4)
> +#define TPI_I2S_MCLK_MULTIPLIER_384         (2 << 4)
> +#define TPI_I2S_MCLK_MULTIPLIER_512         (3 << 4)
> +#define TPI_I2S_MCLK_MULTIPLIER_768         (4 << 4)
> +#define TPI_I2S_MCLK_MULTIPLIER_1024        (5 << 4)
> +#define TPI_I2S_MCLK_MULTIPLIER_1152        (6 << 4)
> +#define TPI_I2S_MCLK_MULTIPLIER_192         (7 << 4)
> +#define TPI_I2S_SCK_EDGE_FALLING            (0 << 7)
> +#define TPI_I2S_SCK_EDGE_RISING             (1 << 7)
> +
> +/* HDMI_TPI_I2S_STRM_HDR_REG                       */
> +/* the reference of this values is in IEC 60958-3  */
> +#define I2S_CHAN_STATUS_MODE                0x00
> +#define I2S_CHAN_STATUS_CAT_CODE            0x00
> +#define I2S_CHAN_SOURCE_CHANNEL_NUM         0x00
> +#define I2S_CHAN_ACCURACY_N_44_SAMPLING_FS  0x20
> +#define I2S_CHAN_ACCURACY_N_48_SAMPLING_FS  0x22
> +#define I2S_CHAN_ORIGIN_FS_N_SAMP_LENGTH    0xD2
> +
> +
> +/* MISCELLANOUS INFOFRAME VALUES  */
> +
> +#define HDMI_INFOFRAME_TX_ENABLE            (0x1 << 7)
> +#define HDMI_INFOFRAME_TX_REPEAT            (0x1 << 6)
> +#define HDMI_AUDIO_INFOFRAME                (0x2 << 0)
> +
> +/* Stream Header Data  */
> +#define HDMI_SH_PCM                         (0x1 << 4)
> +#define HDMI_SH_TWO_CHANNELS                (0x1 << 0)
> +#define HDMI_SH_44KHz                       (0x2 << 2)
> +#define HDMI_SH_48KHz                       (0x3 << 2)
> +#define HDMI_SH_16BIT                       (0x1 << 0)
> +#define HDMI_SH_SPKR_FLFR                   0x0
> +#define HDMI_SH_0dB_ATUN                    0x0
> +
> +/* MISC_TYPE  */
> +#define MISC_INFOFRAME_TYPE                 0x04  /* for Audio */
> +#define MISC_INFOFRAME_ALWAYS_SET           0x80
> +
> +/* MISC_VERSION  */
> +#define MISC_INFOFRAME_VERSION              0x01
> +
> +/* MISC_LENGTH  */
> +#define MISC_INFOFRAME_LENGTH               0x0A /*length for Audio infoframe*/
> +#define MISC_INFOFRAME_LENGTH_RSVD_BITS     0xE0
> +
> +/* MISC_DBYTE1                */
> +/* Type, Encoding, Trandport  */
> +#define MISC_DBYTE1_CT_CHK_HEADER_STREAM    0x00
> +
> +/* audio channel count  */
> +#define MISC_DBYTE1_CC_CHK_HEADER_STREAM    0x00
> +#define MISC_DBYTE1_CC_2_CHANNELS           0x01
> +
> +/* MISC_DBYTE2  */
> +/*Sample Size   */
> +#define MISC_DBYTE2_SS_CHK_HEADER_STREAM    0x00  /* for hdmi by default */
> +
> +/* Sampling Frequency  */
> +#define MISC_DBYTE2_SF_CHK_HEADER_STREAM    0x00  /* for hdmi by default */
> +
> +/* MISC_DBYTE3     */
> +/* Code Extention  */
> +#define MISC_DBYTE3_CTX_TAKE_DBYTE1         0x00  /* for hdmi by default */
> +
> +/* MISC_DBYTE4  */
> +#define MISC_DBYTE4                         0x00 /*for no multichannel( */
> +						 /* multichannel means more*/
> +						/* than 2 channels */
> +
> +/* MISC_DBYTE5  */
> +#define MISC_DBYTE5           0x00  /* for no multichannel(multichannel  */
> +					/* means more than 2 channels */
> +
> +struct hdmi_reg_data {
> +	u8 reg_offset;
> +	u8 value;
> +};
> +
> +#endif
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
