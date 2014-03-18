From: Sathya Prakash M R <sathyap@ti.com>
Subject: [PATCH 1/2] OMAPDSS: Add Sil9022 DPI-HDMI Encoder Driver
Date: Tue, 18 Mar 2014 15:37:56 +0530
Message-ID: <1395137278-5065-2-git-send-email-sathyap@ti.com>
References: <1395137278-5065-1-git-send-email-sathyap@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56825 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753987AbaCRKIT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Mar 2014 06:08:19 -0400
In-Reply-To: <1395137278-5065-1-git-send-email-sathyap@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, tomi.valkeinen@ti.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, pawel.moll@arm.com, paul@pwsan.com
Cc: Sathya Prakash M R <sathyap@ti.com>

Sil9022 DPI to HDMI Encoder driver is part of
AM43xx SOC. Adding the basic Sil9022 driver
HPD and Audio support is not present yet.

Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
---
 drivers/video/omap2/displays-new/Kconfig           |    8 +
 drivers/video/omap2/displays-new/Makefile          |    1 +
 drivers/video/omap2/displays-new/encoder-sil9022.c |  748 ++++++++++++++++++++
 drivers/video/omap2/displays-new/encoder-sil9022.h |  105 +++
 4 files changed, 862 insertions(+)
 create mode 100644 drivers/video/omap2/displays-new/encoder-sil9022.c
 create mode 100644 drivers/video/omap2/displays-new/encoder-sil9022.h

diff --git a/drivers/video/omap2/displays-new/Kconfig b/drivers/video/omap2/displays-new/Kconfig
index e6cfc38..9243dd7 100644
--- a/drivers/video/omap2/displays-new/Kconfig
+++ b/drivers/video/omap2/displays-new/Kconfig
@@ -12,6 +12,14 @@ config DISPLAY_ENCODER_TPD12S015
 	  Driver for TPD12S015, which offers HDMI ESD protection and level
 	  shifting.
 
+config DISPLAY_ENCODER_SIL9022
+        tristate "Sil9022 DPI to HDMI Encoder"
+	depends on I2C
+	help
+	  Driver for Silicon Image Sil9022 DPI to HDMI encoder and
+	  a brief about Sil9022 can be found here:
+	  http://www.semiconductorstore.com/pdf/newsite/siliconimage/SiI9022a_pb.pdf
+
 config DISPLAY_CONNECTOR_DVI
         tristate "DVI Connector"
 	depends on I2C
diff --git a/drivers/video/omap2/displays-new/Makefile b/drivers/video/omap2/displays-new/Makefile
index 0323a8a..f3c8997 100644
--- a/drivers/video/omap2/displays-new/Makefile
+++ b/drivers/video/omap2/displays-new/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_DISPLAY_ENCODER_TFP410) += encoder-tfp410.o
 obj-$(CONFIG_DISPLAY_ENCODER_TPD12S015) += encoder-tpd12s015.o
+obj-$(CONFIG_DISPLAY_ENCODER_SIL9022) += encoder-sil9022.o
 obj-$(CONFIG_DISPLAY_CONNECTOR_DVI) += connector-dvi.o
 obj-$(CONFIG_DISPLAY_CONNECTOR_HDMI) += connector-hdmi.o
 obj-$(CONFIG_DISPLAY_CONNECTOR_ANALOG_TV) += connector-analog-tv.o
diff --git a/drivers/video/omap2/displays-new/encoder-sil9022.c b/drivers/video/omap2/displays-new/encoder-sil9022.c
new file mode 100644
index 0000000..411867b
--- /dev/null
+++ b/drivers/video/omap2/displays-new/encoder-sil9022.c
@@ -0,0 +1,748 @@
+/*
+ * Silicon image Sil9022 DPI-to-HDMI encoder driver
+ *
+ * Copyright (C) 2013 Texas Instruments
+ * Author: Sathya Prakash M R <sathyap@ti.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/of_gpio.h>
+
+#include <video/omapdss.h>
+#include <video/omap-panel-data.h>
+#include "encoder-sil9022.h"
+
+struct panel_drv_data {
+	struct omap_dss_device dssdev;
+	struct omap_dss_device *in;
+	struct i2c_client *i2c_client;
+	int reset_gpio;
+	int data_lines;
+	struct regmap *regmap;
+	struct omap_video_timings timings;
+};
+
+static struct regmap_config sil9022_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+
+#define to_panel_data(x) container_of(x, struct panel_drv_data, dssdev)
+
+static int sil9022_ddc_read(struct i2c_client *client,
+		unsigned char *buf, u16 count, u8 offset)
+{
+	int r, retries;
+
+	for (retries = 3; retries > 0; retries--) {
+		struct i2c_msg msgs[] = {
+			{
+				.addr   = 0x50,
+				.flags  = 0,
+				.len    = 1,
+				.buf    = &offset,
+			}, {
+				.addr   = 0x50,
+				.flags  = I2C_M_RD,
+				.len    = count,
+				.buf    = buf,
+			}
+		};
+
+		r = i2c_transfer(client->adapter, msgs, 2);
+		if (r == 2)
+			return 0;
+
+		if (r != -EAGAIN)
+			break;
+	}
+
+	return r < 0 ? r : -EIO;
+}
+
+static int sil9022_hw_enable(struct omap_dss_device *dssdev)
+{
+	int		r = 0;
+	u8		vals[8];
+	unsigned int val;
+	u16		xres;
+	u16		yres;
+	u16		pclk;
+
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+	struct omap_video_timings *hdmi_timings = &ddata->timings;
+	struct i2c_client *sil9022_client = ddata->i2c_client;
+	struct regmap *map = ddata->regmap;
+
+	xres = hdmi_timings->x_res;
+	yres = hdmi_timings->y_res;
+	pclk = hdmi_timings->pixel_clock;
+
+	dev_info(dssdev->dev,
+			 "sii9022_ENABLE -> Timings\n"
+			 "pixel_clk			= %d\n"
+			 "horizontal res		= %d\n"
+			 "vertical res			= %d\n",
+			 pclk, xres, yres);
+
+	/*  Fill the TPI Video Mode Data structure */
+	vals[0] = (pclk & 0xFF);                  /* Pixel clock */
+	vals[1] = ((pclk & 0xFF00) >> 8);
+	vals[2] = VERTICAL_FREQ;                    /* Vertical freq */
+	/* register programming information on how vertical freq is to be
+	programmed to Sil9022 not clear. Hence setting to 60 for now */
+	vals[3] = 0x00;
+	vals[4] = (xres & 0xFF);         /* Horizontal pixels*/
+	vals[5] = ((xres & 0xFF00) >> 8);
+	vals[6] = (yres & 0xFF);           /* Vertical pixels */
+	vals[7] = ((yres & 0xFF00) >> 8);
+
+	/*  Write out the TPI Video Mode Data */
+	r = regmap_raw_write(map, HDMI_TPI_VIDEO_DATA_BASE_REG, vals, 8);
+
+	if (r < 0) {
+		dev_err(dssdev->dev,
+			"ERROR: writing TPI video mode data\n");
+		return r;
+	}
+
+	/* Write out the TPI Input bus and pixel repetition Data:
+	(24 bit wide bus, falling edge, no pixel replication, 1:1 CLK ratio) */
+	r = regmap_write(map,
+			HDMI_TPI_PIXEL_REPETITION_REG,
+			TPI_AVI_PIXEL_REP_BUS_24BIT |
+			TPI_AVI_PIXEL_REP_FALLING_EDGE |
+			TPI_AVI_PIXEL_REP_NONE |
+			TPI_CLK_RATIO_1X);
+
+	if (r < 0) {
+		dev_err(dssdev->dev,
+			"ERROR: writing TPI pixel repetition data\n");
+		return r;
+	}
+
+	 /*  Write out the TPI AVI Input Format */
+	r = regmap_write(map,
+			HDMI_TPI_AVI_IN_FORMAT_REG,
+			TPI_AVI_INPUT_BITMODE_8BIT |
+			TPI_AVI_INPUT_RANGE_AUTO |
+			TPI_AVI_INPUT_COLORSPACE_RGB);
+
+	if (r < 0) {
+		dev_err(dssdev->dev,
+			"ERROR: writing TPI AVI Input format\n");
+		return r;
+	}
+
+	/*  Write out the TPI AVI Output Format */
+	r = regmap_write(map,
+			HDMI_TPI_AVI_OUT_FORMAT_REG,
+			TPI_AVI_OUTPUT_CONV_BT709 |
+			TPI_AVI_OUTPUT_RANGE_AUTO |
+			TPI_AVI_OUTPUT_COLORSPACE_RGBHDMI);
+
+	if (r < 0) {
+		dev_err(dssdev->dev,
+			"ERROR: writing TPI AVI output format\n");
+		return r;
+	}
+
+	/* Write out the TPI System Control Data to power down */
+	r = regmap_write(map,
+			HDMI_SYS_CTRL_DATA_REG,
+			TPI_SYS_CTRL_POWER_DOWN);
+
+	if (r < 0) {
+		dev_err(dssdev->dev,
+			"ERROR: writing TPI power down control data\n");
+		return r;
+	}
+
+	/* Move from ENABLED -> FULLY ENABLED Power State  */
+	r = regmap_write(map,
+			HDMI_TPI_POWER_STATE_CTRL_REG,
+			TPI_AVI_POWER_STATE_D0);
+
+	if (r < 0) {
+		dev_err(&sil9022_client->dev,
+			"<%s> ERROR: Setting device power state to D0\n",
+			__func__);
+		return r;
+	}
+
+	/* Write out the TPI System Control Data to power up and
+	 * select output mode
+	 */
+
+	r = regmap_write(map,
+			HDMI_SYS_CTRL_DATA_REG,
+			TPI_SYS_CTRL_POWER_ACTIVE |
+			TPI_SYS_CTRL_OUTPUT_MODE_HDMI);
+
+	if (r < 0) {
+		dev_err(&sil9022_client->dev,
+			"<%s> ERROR: Writing system control data\n", __func__);
+		return r;
+	}
+
+	/*  Read back TPI System Control Data to latch settings */
+	r = regmap_read(map, HDMI_SYS_CTRL_DATA_REG, &val);
+
+	if (r < 0) {
+		dev_err(&sil9022_client->dev,
+			"<%s> ERROR: Reading back system control data\n",
+			__func__);
+		return r;
+	}
+
+	/* HDCP */
+	r = regmap_write(map,
+				HDMI_TPI_HDCP_CONTROLDATA_REG,
+				HDCP_DISABLE);
+
+	if (r < 0) {
+		dev_err(&sil9022_client->dev,
+			"<%s> ERROR: Writing HDCP information",
+			__func__);
+		return r;
+	}
+
+	dev_info(&sil9022_client->dev,
+		"<%s> hdmi over sil9022 is now enabled\n", __func__);
+	return 0;
+
+}
+
+static int sil9022_hw_disable(struct omap_dss_device *dssdev)
+{
+	unsigned int val = 0;
+	int r = 0;
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+	struct regmap *map = ddata->regmap;
+
+	/*  Write out the TPI System Control Data to power down  */
+	r = regmap_write(map,
+			HDMI_SYS_CTRL_DATA_REG,
+			TPI_SYS_CTRL_POWER_DOWN);
+
+	if (r < 0) {
+		dev_err(dssdev->dev,
+			"ERROR: writing control data - power down\n");
+		return r;
+	}
+
+	/*  Move from FULLY ENABLED -> ENABLED Power state */
+	r = regmap_write(map,
+			HDMI_TPI_POWER_STATE_CTRL_REG,
+			TPI_AVI_POWER_STATE_D2);
+
+	if (r < 0) {
+		dev_err(dssdev->dev,
+			"ERROR: Setting device power state to D2\n");
+		return r;
+	}
+
+	/*  Read back TPI System Control Data to latch settings */
+	r = regmap_read(map, HDMI_SYS_CTRL_DATA_REG, &val);
+	if (r < 0) {
+		dev_err(dssdev->dev,
+			"ERROR:  Reading System control data "
+			"- latch settings\n");
+		return r;
+	}
+
+	dev_info(dssdev->dev, "hdmi disabled\n");
+	return 0;
+
+}
+
+static int sil9022_probe_chip_version(struct omap_dss_device *dssdev)
+{
+	int r = 0;
+	unsigned int ver;
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+	struct regmap *map = ddata->regmap;
+
+	/* probe for sil9022 chip version*/
+	r = regmap_write(map, SIL9022_REG_TPI_RQB, 0x00);
+	if (r < 0) {
+		dev_err(dssdev->dev,
+			"ERROR: Writing HDMI configuration to "
+			"reg - SI9022_REG_TPI_RQB\n");
+		return r;
+	}
+
+	r = regmap_read(map, SIL9022_REG_CHIPID0, &ver);
+	if (r < 0) {
+		dev_err(dssdev->dev,
+			"ERROR: Reading HDMI version Id\n");
+	} else if (ver != SIL9022_CHIPID_902x) {
+		dev_err(dssdev->dev,
+			"Not a valid verId: 0x%x\n", ver);
+	} else {
+		dev_info(dssdev->dev,
+			 "sil9022 HDMI Chip version = %x\n", ver);
+	}
+	return r;
+}
+
+/* Hdmi ops */
+
+static int sil9022_connect(struct omap_dss_device *dssdev,
+		struct omap_dss_device *dst)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+	struct omap_dss_device *in = ddata->in;
+	struct regmap *map = ddata->regmap;
+	int r = 0;
+
+	if (omapdss_device_is_connected(dssdev))
+		return -EBUSY;
+
+	r = in->ops.dpi->connect(in, dssdev);
+	if (r)
+		return r;
+
+	dst->src = dssdev;
+	dssdev->dst = dst;
+
+	/* Move from LOW -> ENABLED Power state */
+	r = regmap_write(map, HDMI_TPI_POWER_STATE_CTRL_REG,
+			TPI_AVI_POWER_STATE_D2);
+	if (r < 0) {
+		dev_err(dssdev->dev, "ERROR: Setting device power state to D2\n");
+		goto err_pwr;
+	}
+
+	return 0;
+err_pwr:
+		dst->src = NULL;
+		dssdev->dst = NULL;
+		in->ops.dpi->disconnect(in, dssdev);
+		return r;
+
+}
+
+static void sil9022_disconnect(struct omap_dss_device *dssdev,
+		struct omap_dss_device *dst)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+	struct omap_dss_device *in = ddata->in;
+
+	WARN_ON(!omapdss_device_is_connected(dssdev));
+	if (!omapdss_device_is_connected(dssdev))
+		return;
+
+	WARN_ON(dst != dssdev->dst);
+	if (dst != dssdev->dst)
+		return;
+
+	/* we don't control the RESET pin, so we can't wake up from D3 */
+	/* Hence we dont move to D3 state when disconnect is done */
+
+	dst->src = NULL;
+	dssdev->dst = NULL;
+	in->ops.dpi->disconnect(in, &ddata->dssdev);
+}
+
+static int sil9022_enable(struct omap_dss_device *dssdev)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+	struct omap_dss_device *in = ddata->in;
+	int r;
+
+	if (!omapdss_device_is_connected(dssdev))
+		return -ENODEV;
+
+	if (omapdss_device_is_enabled(dssdev))
+		return 0;
+
+	in->ops.dpi->set_timings(in, &ddata->timings);
+	in->ops.dpi->set_data_lines(in, ddata->data_lines);
+
+	r = in->ops.dpi->enable(in);
+	if (r)
+		return r;
+
+	if (gpio_is_valid(ddata->reset_gpio))
+		gpio_set_value_cansleep(ddata->reset_gpio, 0);
+
+	r = sil9022_hw_enable(dssdev);
+	if (r)
+		goto err_hw_en;
+
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	return 0;
+
+err_hw_en:
+		if (gpio_is_valid(ddata->reset_gpio))
+			gpio_set_value_cansleep(ddata->reset_gpio, 1);
+
+		in->ops.dpi->disable(in);
+		return r;
+}
+
+static void sil9022_disable(struct omap_dss_device *dssdev)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+	struct omap_dss_device *in = ddata->in;
+
+	if (!omapdss_device_is_enabled(dssdev))
+		return;
+
+	sil9022_hw_disable(dssdev);
+
+	if (gpio_is_valid(ddata->reset_gpio))
+		gpio_set_value_cansleep(ddata->reset_gpio, 1);
+
+	in->ops.dpi->disable(in);
+
+	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
+}
+
+static void sil9022_set_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+	struct omap_dss_device *in = ddata->in;
+	struct omap_video_timings *sil9022_timings = timings;
+
+       /* update DPI specific timing info */
+	sil9022_timings->data_pclk_edge  = OMAPDSS_DRIVE_SIG_RISING_EDGE;
+	sil9022_timings->de_level		  = OMAPDSS_SIG_ACTIVE_HIGH;
+	sil9022_timings->sync_pclk_edge = OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES;
+	ddata->timings = *sil9022_timings;
+	dssdev->panel.timings = *sil9022_timings;
+
+	in->ops.dpi->set_timings(in, sil9022_timings);
+}
+
+static void sil9022_get_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+	*timings = ddata->timings;
+}
+
+static int sil9022_check_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+	struct omap_dss_device *in = ddata->in;
+	struct omap_video_timings *sil9022_timings = timings;
+
+	/* update DPI specific timing info */
+	sil9022_timings->data_pclk_edge  = OMAPDSS_DRIVE_SIG_RISING_EDGE;
+	sil9022_timings->de_level		  = OMAPDSS_SIG_ACTIVE_HIGH;
+	sil9022_timings->sync_pclk_edge = OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES;
+
+	return in->ops.dpi->check_timings(in, sil9022_timings);
+}
+
+static int sil9022_read_edid(struct omap_dss_device *dssdev,
+	       u8 *edid, int len)
+{
+
+	int r =  0;
+	unsigned int val = 0;
+	int retries = 0;
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+	struct i2c_client *client = ddata->i2c_client;
+	struct regmap *map = ddata->regmap;
+
+	len = (len < HDMI_EDID_MAX_LENGTH) ? len : HDMI_EDID_MAX_LENGTH;
+
+	/* Request DDC bus access to read EDID info */
+
+	/* Disable TMDS clock */
+
+	r = regmap_write(map, HDMI_SYS_CTRL_DATA_REG, 0x11);
+	if (r < 0) {
+		dev_err(&client->dev,
+			"ERROR: Failed to disable TMDS clock\n");
+		return r;
+	}
+
+	val = 0;
+
+	/* Read TPI system control register*/
+	r = regmap_read(map, HDMI_SYS_CTRL_DATA_REG, &val);
+	if (r < 0) {
+		dev_err(&client->dev,
+			"ERROR: Reading DDC BUS REQUEST\n");
+		return r;
+	}
+
+	/* The host writes 0x1A[2]=1 to request the
+	 * DDC(Display Data Channel) bus
+	 */
+	r = regmap_write(map, HDMI_SYS_CTRL_DATA_REG,
+				val | TPI_SYS_CTRL_DDC_BUS_REQUEST);
+	if (r < 0) {
+		dev_err(&client->dev,
+			"ERROR: Writing DDC BUS REQUEST\n");
+		return r;
+	}
+
+	/*  Poll for bus DDC Bus control to be granted */
+	val = 0;
+
+	/* Through trial and error, to get DDC BUS we need around 3 tries */
+	/* Hence keeping it rounded at 5 tries - a max of 4 retries allowed */
+	do {
+		r = regmap_read(map, HDMI_SYS_CTRL_DATA_REG, &val);
+		if (retries++ > 5) {
+			dev_err(&client->dev, "ERROR: Acquiring DDC Bus\n");
+			return r;
+		}
+	} while ((val & TPI_SYS_CTRL_DDC_BUS_GRANTED) == 0);
+
+	/*  Close the switch to the DDC */
+	r = regmap_write(map, HDMI_SYS_CTRL_DATA_REG,
+		val | TPI_SYS_CTRL_DDC_BUS_REQUEST |
+		TPI_SYS_CTRL_DDC_BUS_GRANTED);
+
+	if (r < 0) {
+		dev_err(&client->dev,
+			"<%s> ERROR: Close switch to DDC BUS REQUEST\n",
+			__func__);
+		return r;
+	}
+
+	r = sil9022_ddc_read(client, edid, len, 0);
+	if (r < 0) {
+		dev_err(&client->dev, "ERROR: Reading EDID\n");
+		return r;
+	}
+
+	/* Release DDC bus access */
+	val &= ~(TPI_SYS_CTRL_DDC_BUS_REQUEST | TPI_SYS_CTRL_DDC_BUS_GRANTED);
+
+	/*Through trial and error, seen that releasing BUS needed 3 tries */
+	/* Hence keeping it rounded at 5 tries - a max of 4 retries allowed */
+	retries = 0;
+	do {
+		r = regmap_write(map, HDMI_SYS_CTRL_DATA_REG, val);
+		if (r >= 0)
+			break;
+		retries++;
+	} while (retries < 5);
+	if (r < 0) {
+		dev_err(&client->dev, "ERROR: Releasing DDC Bus Access\n");
+		return r;
+		}
+	return 0;
+}
+
+static bool sil9022_detect(struct omap_dss_device *dssdev)
+{
+	/* Hot plug detection is not implemented */
+	/* Hence we assume monitor connected */
+	/* This will be fixed once HPD / polling is implemented */
+	return true;
+}
+
+static bool sil9022_audio_supported(struct omap_dss_device *dssdev)
+{
+	/* Audio configuration not present, hence returning false */
+	return false;
+}
+
+static const struct omapdss_hdmi_ops sil9022_hdmi_ops = {
+	.connect			= sil9022_connect,
+	.disconnect		= sil9022_disconnect,
+
+	.enable			= sil9022_enable,
+	.disable			= sil9022_disable,
+
+	.check_timings	= sil9022_check_timings,
+	.set_timings		= sil9022_set_timings,
+	.get_timings		= sil9022_get_timings,
+
+	.read_edid		= sil9022_read_edid,
+	.detect			= sil9022_detect,
+
+	.audio_supported	= sil9022_audio_supported,
+	/* Yet to implement audio ops */
+	/* For now audio_supported ops to return false */
+};
+
+
+static int sil9022_probe_of(struct i2c_client *client)
+{
+	struct panel_drv_data *ddata = dev_get_drvdata(&client->dev);
+	struct device_node *node = client->dev.of_node;
+	struct device_node *src_node;
+	struct omap_dss_device *dssdev, *in;
+
+	int r, reset_gpio, datalines;
+
+	src_node = of_parse_phandle(node, "video-source", 0);
+	if (!src_node) {
+		dev_err(&client->dev, "failed to parse video source\n");
+		return -ENODEV;
+	}
+
+	in = omap_dss_find_output_by_node(src_node);
+	if (in == NULL) {
+		dev_err(&client->dev, "failed to find video source\n");
+		return -EPROBE_DEFER;
+	}
+	ddata->in = in;
+
+	reset_gpio = of_get_named_gpio(node, "reset-gpio", 0);
+
+	if (gpio_is_valid(reset_gpio) || reset_gpio == -ENOENT) {
+		ddata->reset_gpio = reset_gpio;
+	} else {
+		dev_err(&client->dev, "failed to parse lcdorhdmi gpio\n");
+		return reset_gpio;
+	}
+
+	r = of_property_read_u32(node, "data-lines", &datalines);
+	if (r) {
+		dev_err(&client->dev, "failed to parse datalines\n");
+		return r;
+	}
+
+	ddata->data_lines = datalines;
+	ddata->reset_gpio = reset_gpio;
+	dssdev = &ddata->dssdev;
+
+	return 0;
+
+}
+
+static int sil9022_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	struct panel_drv_data *ddata;
+	struct omap_dss_device *dssdev;
+	struct regmap *regmap;
+	int r = 0;
+
+	regmap = devm_regmap_init_i2c(client, &sil9022_regmap_config);
+	if (IS_ERR(regmap)) {
+		r = PTR_ERR(regmap);
+		dev_err(&client->dev, "Failed to init regmap: %d\n", r);
+		return r;
+	}
+
+	ddata = devm_kzalloc(&client->dev, sizeof(*ddata), GFP_KERNEL);
+	if (ddata == NULL)
+		return -ENOMEM;
+
+	dev_set_drvdata(&client->dev, ddata);
+
+	if (client->dev.of_node) {
+		r = sil9022_probe_of(client);
+		if (r)
+			return r;
+	} else {
+		return -ENODEV;
+	}
+
+	if (gpio_is_valid(ddata->reset_gpio)) {
+		r = devm_gpio_request_one(&client->dev, ddata->reset_gpio,
+				GPIOF_OUT_INIT_HIGH, "Sil9022-Encoder");
+		if (r)
+			goto err_gpio;
+	}
+
+	ddata->regmap = regmap;
+	ddata->i2c_client = client;
+	dssdev = &ddata->dssdev;
+	dssdev->dev = &client->dev;
+	dssdev->ops.hdmi = &sil9022_hdmi_ops;
+	dssdev->type = OMAP_DISPLAY_TYPE_DPI;
+	dssdev->output_type = OMAP_DISPLAY_TYPE_HDMI;
+	dssdev->owner = THIS_MODULE;
+	dssdev->phy.dpi.data_lines = ddata->data_lines;
+
+	/* Read sil9022 chip version */
+	r = sil9022_probe_chip_version(dssdev);
+	if (r) {
+		dev_err(&client->dev, "Failed to read CHIP VERSION\n");
+		goto err_i2c;
+	}
+
+	r = omapdss_register_output(dssdev);
+	if (r) {
+		dev_err(&client->dev, "Failed to register output\n");
+		goto err_reg;
+	}
+
+	return 0;
+
+err_reg:
+err_i2c:
+err_gpio:
+
+	omap_dss_put_device(ddata->in);
+	return r;
+}
+
+
+static int sil9022_remove(struct i2c_client *client)
+{
+	struct panel_drv_data *ddata = dev_get_drvdata(&client->dev);
+	struct omap_dss_device *dssdev = &ddata->dssdev;
+
+	omapdss_unregister_output(dssdev);
+
+	WARN_ON(omapdss_device_is_enabled(dssdev));
+	if (omapdss_device_is_enabled(dssdev))
+		sil9022_disable(dssdev);
+
+	WARN_ON(omapdss_device_is_connected(dssdev));
+	if (omapdss_device_is_connected(dssdev))
+		sil9022_disconnect(dssdev, dssdev->dst);
+
+	omap_dss_put_device(ddata->in);
+
+	return 0;
+}
+
+static const struct i2c_device_id sil9022_id[] = {
+	{ SIL9022_DRV_NAME, 0 },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(i2c, sil9022_id);
+
+static struct i2c_driver sil9022_driver = {
+	.driver = {
+		.name  = SIL9022_DRV_NAME,
+		.owner = THIS_MODULE,
+		},
+	.probe		= sil9022_probe,
+	.remove		= sil9022_remove,
+	.id_table	= sil9022_id,
+};
+
+module_i2c_driver(sil9022_driver);
+
+MODULE_AUTHOR("Sathya Prakash M R <sathyap@ti.com>");
+MODULE_DESCRIPTION("Sil9022 DPI to HDMI encoder Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/video/omap2/displays-new/encoder-sil9022.h b/drivers/video/omap2/displays-new/encoder-sil9022.h
new file mode 100644
index 0000000..2922662
--- /dev/null
+++ b/drivers/video/omap2/displays-new/encoder-sil9022.h
@@ -0,0 +1,105 @@
+/*
+ * drivers/video/omap2/displays-new/encoder-sil9022.c
+ *
+ * Copyright (C) 2013 Texas Instruments
+ * Author : Sathya Prakash M R <sathyap@ti.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ *
+ */
+
+#ifndef _SI9022_H_
+#define _SI9022_H_
+
+#define SIL9022_DRV_NAME	"sii9022"
+
+#define SIL9022_REG_CHIPID0		0x1B
+#define SIL9022_CHIPID_902x		0xB0
+#define SIL9022_REG_TPI_RQB		0xC7
+
+
+#define HDMI_EDID_MAX_LENGTH	256
+
+#define VERTICAL_FREQ			0x3C /* 60 Hz */
+
+/* Sil9022 TPI mode Programming Register set  */
+#define HDMI_TPI_VIDEO_DATA_BASE_REG		0x00
+#define HDMI_TPI_PIXEL_REPETITION_REG		0x08
+#define HDMI_TPI_AVI_IN_FORMAT_REG			0x09
+#define HDMI_TPI_AVI_OUT_FORMAT_REG		0x0A
+#define HDMI_SYS_CTRL_DATA_REG			0x1A
+#define HDMI_TPI_POWER_STATE_CTRL_REG	0x1E
+#define HDMI_TPI_HDCP_QUERYDATA_REG		0x29
+#define HDMI_TPI_HDCP_CONTROLDATA_REG	0x2A
+
+
+/* Programming HDMI_SYS_CTRL_DATA_REG  power state and mode of operation*/
+#define TPI_SYS_CTRL_POWER_DOWN             (1 << 4)
+#define TPI_SYS_CTRL_POWER_ACTIVE           (0 << 4)
+
+#define TPI_SYS_CTRL_AV_MUTE                (1 << 3)
+
+#define TPI_SYS_CTRL_DDC_BUS_REQUEST        (1 << 2)
+#define TPI_SYS_CTRL_DDC_BUS_GRANTED        (1 << 1)
+
+#define TPI_SYS_CTRL_OUTPUT_MODE_HDMI       (1 << 0)
+#define TPI_SYS_CTRL_OUTPUT_MODE_DVI        (0 << 0)
+
+/* Programming HDMI_TPI_PIXEL_REPETITION_REG  - clock and pixel properties*/
+#define TPI_AVI_PIXEL_REP_BUS_24BIT         (1 << 5)
+#define TPI_AVI_PIXEL_REP_BUS_12BIT         (0 << 5)
+
+#define TPI_AVI_PIXEL_REP_RISING_EDGE       (1 << 4)
+#define TPI_AVI_PIXEL_REP_FALLING_EDGE      (0 << 4)
+
+#define TPI_AVI_PIXEL_REP_4X                (3 << 0)
+#define TPI_AVI_PIXEL_REP_2X                (1 << 0)
+#define TPI_AVI_PIXEL_REP_NONE              (0 << 0)
+
+#define TPI_CLK_RATIO_HALF		(0 << 6)
+#define TPI_CLK_RATIO_1X		(1 << 6)
+#define TPI_CLK_RATIO_2X		(2 << 6)
+#define TPI_CLK_RATIO_4X		(3 << 6)
+
+
+/* Programming HDMI_TPI_AVI_IN_FORMAT_REG - input properties*/
+#define TPI_AVI_INPUT_BITMODE_12BIT         (1 << 7)
+#define TPI_AVI_INPUT_BITMODE_8BIT          (0 << 7)
+
+#define TPI_AVI_INPUT_DITHER                (1 << 6)
+
+#define TPI_AVI_INPUT_RANGE_LIMITED         (2 << 2)
+#define TPI_AVI_INPUT_RANGE_FULL            (1 << 2)
+#define TPI_AVI_INPUT_RANGE_AUTO            (0 << 2)
+
+#define TPI_AVI_INPUT_COLORSPACE_BLACK      (3 << 0)
+#define TPI_AVI_INPUT_COLORSPACE_YUV422     (2 << 0)
+#define TPI_AVI_INPUT_COLORSPACE_YUV444     (1 << 0)
+#define TPI_AVI_INPUT_COLORSPACE_RGB        (0 << 0)
+
+
+/* Programming HDMI_TPI_AVI_OUT_FORMAT_REG  - output properties */
+#define TPI_AVI_OUTPUT_CONV_BT709           (1 << 4)
+#define TPI_AVI_OUTPUT_CONV_BT601           (0 << 4)
+
+#define TPI_AVI_OUTPUT_RANGE_LIMITED        (2 << 2)
+#define TPI_AVI_OUTPUT_RANGE_FULL           (1 << 2)
+#define TPI_AVI_OUTPUT_RANGE_AUTO           (0 << 2)
+
+#define TPI_AVI_OUTPUT_COLORSPACE_RGBDVI    (3 << 0)
+#define TPI_AVI_OUTPUT_COLORSPACE_YUV422    (2 << 0)
+#define TPI_AVI_OUTPUT_COLORSPACE_YUV444    (1 << 0)
+#define TPI_AVI_OUTPUT_COLORSPACE_RGBHDMI   (0 << 0)
+
+/* Programming HDMI_TPI_POWER_STATE_CTRL_REG  */
+#define TPI_AVI_POWER_STATE_D3			(3 << 0)
+#define TPI_AVI_POWER_STATE_D2			(2 << 0)
+#define TPI_AVI_POWER_STATE_D0			(0 << 0)
+
+/* Programming HDMI_TPI_HDCP_CONTROLDATA_REG */
+#define HDCP_DISABLE	0
+#define HDCP_ENABLE		1
+
+#endif
-- 
1.7.9.5

