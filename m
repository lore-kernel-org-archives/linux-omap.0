From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/2] OMAPDSS: Add Sil9022 DPI-HDMI Encoder Driver
Date: Tue, 18 Mar 2014 13:20:59 +0200
Message-ID: <53282C1B.7030507@ti.com>
References: <1395137278-5065-1-git-send-email-sathyap@ti.com> <1395137278-5065-2-git-send-email-sathyap@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="nV0cjgXKsMWUv866lLl8qqGuHQvd5ugsc"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59795 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754001AbaCRLVN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Mar 2014 07:21:13 -0400
In-Reply-To: <1395137278-5065-2-git-send-email-sathyap@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sathya Prakash M R <sathyap@ti.com>
Cc: tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, pawel.moll@arm.com, paul@pwsan.com

--nV0cjgXKsMWUv866lLl8qqGuHQvd5ugsc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sathya,

On 18/03/14 12:07, Sathya Prakash M R wrote:
> Sil9022 DPI to HDMI Encoder driver is part of
> AM43xx SOC. Adding the basic Sil9022 driver

Umm it's not part of AM43xx SoC...

> HPD and Audio support is not present yet.
>=20
> Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
> ---
>  drivers/video/omap2/displays-new/Kconfig           |    8 +
>  drivers/video/omap2/displays-new/Makefile          |    1 +
>  drivers/video/omap2/displays-new/encoder-sil9022.c |  748 ++++++++++++=
++++++++
>  drivers/video/omap2/displays-new/encoder-sil9022.h |  105 +++
>  4 files changed, 862 insertions(+)
>  create mode 100644 drivers/video/omap2/displays-new/encoder-sil9022.c
>  create mode 100644 drivers/video/omap2/displays-new/encoder-sil9022.h
>=20
> diff --git a/drivers/video/omap2/displays-new/Kconfig b/drivers/video/o=
map2/displays-new/Kconfig
> index e6cfc38..9243dd7 100644
> --- a/drivers/video/omap2/displays-new/Kconfig
> +++ b/drivers/video/omap2/displays-new/Kconfig
> @@ -12,6 +12,14 @@ config DISPLAY_ENCODER_TPD12S015
>  	  Driver for TPD12S015, which offers HDMI ESD protection and level
>  	  shifting.
> =20
> +config DISPLAY_ENCODER_SIL9022
> +        tristate "Sil9022 DPI to HDMI Encoder"

Use a tab there.

> +	depends on I2C
> +	help
> +	  Driver for Silicon Image Sil9022 DPI to HDMI encoder and
> +	  a brief about Sil9022 can be found here:
> +	  http://www.semiconductorstore.com/pdf/newsite/siliconimage/SiI9022a=
_pb.pdf
> +
>  config DISPLAY_CONNECTOR_DVI
>          tristate "DVI Connector"
>  	depends on I2C
> diff --git a/drivers/video/omap2/displays-new/Makefile b/drivers/video/=
omap2/displays-new/Makefile
> index 0323a8a..f3c8997 100644
> --- a/drivers/video/omap2/displays-new/Makefile
> +++ b/drivers/video/omap2/displays-new/Makefile
> @@ -1,5 +1,6 @@
>  obj-$(CONFIG_DISPLAY_ENCODER_TFP410) +=3D encoder-tfp410.o
>  obj-$(CONFIG_DISPLAY_ENCODER_TPD12S015) +=3D encoder-tpd12s015.o
> +obj-$(CONFIG_DISPLAY_ENCODER_SIL9022) +=3D encoder-sil9022.o
>  obj-$(CONFIG_DISPLAY_CONNECTOR_DVI) +=3D connector-dvi.o
>  obj-$(CONFIG_DISPLAY_CONNECTOR_HDMI) +=3D connector-hdmi.o
>  obj-$(CONFIG_DISPLAY_CONNECTOR_ANALOG_TV) +=3D connector-analog-tv.o
> diff --git a/drivers/video/omap2/displays-new/encoder-sil9022.c b/drive=
rs/video/omap2/displays-new/encoder-sil9022.c
> new file mode 100644
> index 0000000..411867b
> --- /dev/null
> +++ b/drivers/video/omap2/displays-new/encoder-sil9022.c
> @@ -0,0 +1,748 @@
> +/*
> + * Silicon image Sil9022 DPI-to-HDMI encoder driver

The chip is SiI9022, not Sil, according to the specs from Silicon Image.
I'm not sure what would be the best naming all around, but at least in
the comments and Kconfig help texts it would be best to use the correct
names to help finding the chip with google.

> + *
> + * Copyright (C) 2013 Texas Instruments
> + * Author: Sathya Prakash M R <sathyap@ti.com>
> + *
> + * This file is licensed under the terms of the GNU General Public Lic=
ense
> + * version 2. This program is licensed "as is" without any warranty of=
 any
> + * kind, whether express or implied.
> + *
> + */
> +
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
> +#include <linux/regmap.h>
> +#include <linux/of_gpio.h>
> +
> +#include <video/omapdss.h>
> +#include <video/omap-panel-data.h>
> +#include "encoder-sil9022.h"

You should quickly go though the includes, and remove unneeded ones.
There are no platform devices here, nor is video/omap-panel-data.h needed=
=2E

> +struct panel_drv_data {
> +	struct omap_dss_device dssdev;
> +	struct omap_dss_device *in;
> +	struct i2c_client *i2c_client;
> +	int reset_gpio;
> +	int data_lines;
> +	struct regmap *regmap;
> +	struct omap_video_timings timings;
> +};
> +
> +static struct regmap_config sil9022_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +};

Can this be const?

> +
> +
> +#define to_panel_data(x) container_of(x, struct panel_drv_data, dssdev=
)
> +
> +static int sil9022_ddc_read(struct i2c_client *client,
> +		unsigned char *buf, u16 count, u8 offset)
> +{
> +	int r, retries;
> +
> +	for (retries =3D 3; retries > 0; retries--) {
> +		struct i2c_msg msgs[] =3D {
> +			{
> +				.addr   =3D 0x50,
> +				.flags  =3D 0,
> +				.len    =3D 1,
> +				.buf    =3D &offset,
> +			}, {
> +				.addr   =3D 0x50,
> +				.flags  =3D I2C_M_RD,
> +				.len    =3D count,
> +				.buf    =3D buf,
> +			}
> +		};
> +
> +		r =3D i2c_transfer(client->adapter, msgs, 2);
> +		if (r =3D=3D 2)
> +			return 0;
> +
> +		if (r !=3D -EAGAIN)
> +			break;
> +	}
> +
> +	return r < 0 ? r : -EIO;
> +}
> +
> +static int sil9022_hw_enable(struct omap_dss_device *dssdev)
> +{
> +	int		r =3D 0;
> +	u8		vals[8];
> +	unsigned int val;
> +	u16		xres;
> +	u16		yres;
> +	u16		pclk;
> +
> +	struct panel_drv_data *ddata =3D to_panel_data(dssdev);
> +	struct omap_video_timings *hdmi_timings =3D &ddata->timings;
> +	struct i2c_client *sil9022_client =3D ddata->i2c_client;
> +	struct regmap *map =3D ddata->regmap;

Use a consistent style. If you align variable names like you do for
xres, yes, etc., use it for everything. I think personally it's cleaner
to not align them.

> +
> +	xres =3D hdmi_timings->x_res;
> +	yres =3D hdmi_timings->y_res;
> +	pclk =3D hdmi_timings->pixel_clock;
> +
> +	dev_info(dssdev->dev,

In the minimum change the dev_info()s to dev_dbg(). Even better, have a
bit thought and see if they are needed at all or were they only useful
for early device bring-up.

> +			 "sii9022_ENABLE -> Timings\n"
> +			 "pixel_clk			=3D %d\n"
> +			 "horizontal res		=3D %d\n"
> +			 "vertical res			=3D %d\n",
> +			 pclk, xres, yres);
> +
> +	/*  Fill the TPI Video Mode Data structure */
> +	vals[0] =3D (pclk & 0xFF);                  /* Pixel clock */
> +	vals[1] =3D ((pclk & 0xFF00) >> 8);
> +	vals[2] =3D VERTICAL_FREQ;                    /* Vertical freq */
> +	/* register programming information on how vertical freq is to be
> +	programmed to Sil9022 not clear. Hence setting to 60 for now */

Use the comment formatting according to kernel's coding style.

> +	vals[3] =3D 0x00;
> +	vals[4] =3D (xres & 0xFF);         /* Horizontal pixels*/
> +	vals[5] =3D ((xres & 0xFF00) >> 8);
> +	vals[6] =3D (yres & 0xFF);           /* Vertical pixels */
> +	vals[7] =3D ((yres & 0xFF00) >> 8);
> +
> +	/*  Write out the TPI Video Mode Data */
> +	r =3D regmap_raw_write(map, HDMI_TPI_VIDEO_DATA_BASE_REG, vals, 8);
> +
> +	if (r < 0) {
> +		dev_err(dssdev->dev,
> +			"ERROR: writing TPI video mode data\n");
> +		return r;
> +	}
> +
> +	/* Write out the TPI Input bus and pixel repetition Data:
> +	(24 bit wide bus, falling edge, no pixel replication, 1:1 CLK ratio) =
*/
> +	r =3D regmap_write(map,
> +			HDMI_TPI_PIXEL_REPETITION_REG,
> +			TPI_AVI_PIXEL_REP_BUS_24BIT |
> +			TPI_AVI_PIXEL_REP_FALLING_EDGE |
> +			TPI_AVI_PIXEL_REP_NONE |
> +			TPI_CLK_RATIO_1X);
> +
> +	if (r < 0) {
> +		dev_err(dssdev->dev,
> +			"ERROR: writing TPI pixel repetition data\n");
> +		return r;
> +	}
> +
> +	 /*  Write out the TPI AVI Input Format */
> +	r =3D regmap_write(map,
> +			HDMI_TPI_AVI_IN_FORMAT_REG,
> +			TPI_AVI_INPUT_BITMODE_8BIT |
> +			TPI_AVI_INPUT_RANGE_AUTO |
> +			TPI_AVI_INPUT_COLORSPACE_RGB);
> +
> +	if (r < 0) {
> +		dev_err(dssdev->dev,
> +			"ERROR: writing TPI AVI Input format\n");
> +		return r;
> +	}
> +
> +	/*  Write out the TPI AVI Output Format */
> +	r =3D regmap_write(map,
> +			HDMI_TPI_AVI_OUT_FORMAT_REG,
> +			TPI_AVI_OUTPUT_CONV_BT709 |
> +			TPI_AVI_OUTPUT_RANGE_AUTO |
> +			TPI_AVI_OUTPUT_COLORSPACE_RGBHDMI);
> +
> +	if (r < 0) {
> +		dev_err(dssdev->dev,
> +			"ERROR: writing TPI AVI output format\n");
> +		return r;
> +	}
> +
> +	/* Write out the TPI System Control Data to power down */
> +	r =3D regmap_write(map,
> +			HDMI_SYS_CTRL_DATA_REG,
> +			TPI_SYS_CTRL_POWER_DOWN);
> +
> +	if (r < 0) {
> +		dev_err(dssdev->dev,
> +			"ERROR: writing TPI power down control data\n");
> +		return r;
> +	}
> +
> +	/* Move from ENABLED -> FULLY ENABLED Power State  */
> +	r =3D regmap_write(map,
> +			HDMI_TPI_POWER_STATE_CTRL_REG,
> +			TPI_AVI_POWER_STATE_D0);
> +
> +	if (r < 0) {
> +		dev_err(&sil9022_client->dev,
> +			"<%s> ERROR: Setting device power state to D0\n",
> +			__func__);

No need to print __func__. dyndbg will allow the user to either print or
not print the function name.

You could store &sil9022_client->dev to variable 'dev', reducing the
code quite a bit. And if you change the texts a bit, maybe many of them
even fit into one line (say, "ERROR: Setting device power state to D0"
-> "Failed to set power state to D0").

> +		return r;
> +	}
> +
> +	/* Write out the TPI System Control Data to power up and
> +	 * select output mode
> +	 */
> +
> +	r =3D regmap_write(map,
> +			HDMI_SYS_CTRL_DATA_REG,
> +			TPI_SYS_CTRL_POWER_ACTIVE |
> +			TPI_SYS_CTRL_OUTPUT_MODE_HDMI);
> +
> +	if (r < 0) {
> +		dev_err(&sil9022_client->dev,
> +			"<%s> ERROR: Writing system control data\n", __func__);
> +		return r;
> +	}
> +
> +	/*  Read back TPI System Control Data to latch settings */
> +	r =3D regmap_read(map, HDMI_SYS_CTRL_DATA_REG, &val);
> +
> +	if (r < 0) {
> +		dev_err(&sil9022_client->dev,
> +			"<%s> ERROR: Reading back system control data\n",
> +			__func__);
> +		return r;
> +	}
> +
> +	/* HDCP */
> +	r =3D regmap_write(map,
> +				HDMI_TPI_HDCP_CONTROLDATA_REG,
> +				HDCP_DISABLE);
> +
> +	if (r < 0) {
> +		dev_err(&sil9022_client->dev,
> +			"<%s> ERROR: Writing HDCP information",
> +			__func__);
> +		return r;
> +	}
> +
> +	dev_info(&sil9022_client->dev,
> +		"<%s> hdmi over sil9022 is now enabled\n", __func__);
> +	return 0;
> +
> +}
> +
> +static int sil9022_hw_disable(struct omap_dss_device *dssdev)
> +{
> +	unsigned int val =3D 0;
> +	int r =3D 0;
> +	struct panel_drv_data *ddata =3D to_panel_data(dssdev);
> +	struct regmap *map =3D ddata->regmap;
> +
> +	/*  Write out the TPI System Control Data to power down  */
> +	r =3D regmap_write(map,
> +			HDMI_SYS_CTRL_DATA_REG,
> +			TPI_SYS_CTRL_POWER_DOWN);
> +
> +	if (r < 0) {
> +		dev_err(dssdev->dev,
> +			"ERROR: writing control data - power down\n");
> +		return r;
> +	}
> +
> +	/*  Move from FULLY ENABLED -> ENABLED Power state */
> +	r =3D regmap_write(map,
> +			HDMI_TPI_POWER_STATE_CTRL_REG,
> +			TPI_AVI_POWER_STATE_D2);
> +
> +	if (r < 0) {
> +		dev_err(dssdev->dev,
> +			"ERROR: Setting device power state to D2\n");
> +		return r;
> +	}
> +
> +	/*  Read back TPI System Control Data to latch settings */
> +	r =3D regmap_read(map, HDMI_SYS_CTRL_DATA_REG, &val);
> +	if (r < 0) {
> +		dev_err(dssdev->dev,
> +			"ERROR:  Reading System control data "
> +			"- latch settings\n");
> +		return r;
> +	}
> +
> +	dev_info(dssdev->dev, "hdmi disabled\n");
> +	return 0;
> +
> +}
> +
> +static int sil9022_probe_chip_version(struct omap_dss_device *dssdev)
> +{
> +	int r =3D 0;

Here, and also elsewhere in this driver, assigning initial 0 to the
return value is not needed.

> +	unsigned int ver;
> +	struct panel_drv_data *ddata =3D to_panel_data(dssdev);
> +	struct regmap *map =3D ddata->regmap;
> +
> +	/* probe for sil9022 chip version*/
> +	r =3D regmap_write(map, SIL9022_REG_TPI_RQB, 0x00);
> +	if (r < 0) {
> +		dev_err(dssdev->dev,
> +			"ERROR: Writing HDMI configuration to "
> +			"reg - SI9022_REG_TPI_RQB\n");
> +		return r;
> +	}
> +
> +	r =3D regmap_read(map, SIL9022_REG_CHIPID0, &ver);
> +	if (r < 0) {
> +		dev_err(dssdev->dev,
> +			"ERROR: Reading HDMI version Id\n");
> +	} else if (ver !=3D SIL9022_CHIPID_902x) {
> +		dev_err(dssdev->dev,
> +			"Not a valid verId: 0x%x\n", ver);
> +	} else {
> +		dev_info(dssdev->dev,
> +			 "sil9022 HDMI Chip version =3D %x\n", ver);
> +	}
> +	return r;
> +}
> +
> +/* Hdmi ops */
> +
> +static int sil9022_connect(struct omap_dss_device *dssdev,
> +		struct omap_dss_device *dst)
> +{
> +	struct panel_drv_data *ddata =3D to_panel_data(dssdev);
> +	struct omap_dss_device *in =3D ddata->in;
> +	struct regmap *map =3D ddata->regmap;
> +	int r =3D 0;
> +
> +	if (omapdss_device_is_connected(dssdev))
> +		return -EBUSY;
> +
> +	r =3D in->ops.dpi->connect(in, dssdev);
> +	if (r)
> +		return r;
> +
> +	dst->src =3D dssdev;
> +	dssdev->dst =3D dst;
> +
> +	/* Move from LOW -> ENABLED Power state */
> +	r =3D regmap_write(map, HDMI_TPI_POWER_STATE_CTRL_REG,
> +			TPI_AVI_POWER_STATE_D2);
> +	if (r < 0) {
> +		dev_err(dssdev->dev, "ERROR: Setting device power state to D2\n");
> +		goto err_pwr;
> +	}
> +
> +	return 0;
> +err_pwr:
> +		dst->src =3D NULL;
> +		dssdev->dst =3D NULL;
> +		in->ops.dpi->disconnect(in, dssdev);
> +		return r;
> +
> +}
> +
> +static void sil9022_disconnect(struct omap_dss_device *dssdev,
> +		struct omap_dss_device *dst)
> +{
> +	struct panel_drv_data *ddata =3D to_panel_data(dssdev);
> +	struct omap_dss_device *in =3D ddata->in;
> +
> +	WARN_ON(!omapdss_device_is_connected(dssdev));
> +	if (!omapdss_device_is_connected(dssdev))
> +		return;
> +
> +	WARN_ON(dst !=3D dssdev->dst);
> +	if (dst !=3D dssdev->dst)
> +		return;
> +
> +	/* we don't control the RESET pin, so we can't wake up from D3 */
> +	/* Hence we dont move to D3 state when disconnect is done */

So, this hacky reset handling, which wasn't switching reset but a GPIO
to switch HDMI/LCD, was ok for testing purposes, but we need to clean
this up before this can be merged to mainline.

The driver should be made to handle the reset gpio properly. However,
having the reset gpio should be optional for cases where the reset pin
is not controllable (like it is on the current AM4 boards). So the
driver should get the reset gpio from th DT, but if it's missing, then
act as it can't be controlled.

> +
> +	dst->src =3D NULL;
> +	dssdev->dst =3D NULL;
> +	in->ops.dpi->disconnect(in, &ddata->dssdev);
> +}
> +
> +static int sil9022_enable(struct omap_dss_device *dssdev)
> +{
> +	struct panel_drv_data *ddata =3D to_panel_data(dssdev);
> +	struct omap_dss_device *in =3D ddata->in;
> +	int r;
> +
> +	if (!omapdss_device_is_connected(dssdev))
> +		return -ENODEV;
> +
> +	if (omapdss_device_is_enabled(dssdev))
> +		return 0;
> +
> +	in->ops.dpi->set_timings(in, &ddata->timings);
> +	in->ops.dpi->set_data_lines(in, ddata->data_lines);
> +
> +	r =3D in->ops.dpi->enable(in);
> +	if (r)
> +		return r;
> +
> +	if (gpio_is_valid(ddata->reset_gpio))
> +		gpio_set_value_cansleep(ddata->reset_gpio, 0);
> +
> +	r =3D sil9022_hw_enable(dssdev);
> +	if (r)
> +		goto err_hw_en;
> +
> +	dssdev->state =3D OMAP_DSS_DISPLAY_ACTIVE;
> +
> +	return 0;
> +
> +err_hw_en:
> +		if (gpio_is_valid(ddata->reset_gpio))
> +			gpio_set_value_cansleep(ddata->reset_gpio, 1);
> +
> +		in->ops.dpi->disable(in);
> +		return r;

Indentation is wrong here.

> +}
> +
> +static void sil9022_disable(struct omap_dss_device *dssdev)
> +{
> +	struct panel_drv_data *ddata =3D to_panel_data(dssdev);
> +	struct omap_dss_device *in =3D ddata->in;
> +
> +	if (!omapdss_device_is_enabled(dssdev))
> +		return;
> +
> +	sil9022_hw_disable(dssdev);
> +
> +	if (gpio_is_valid(ddata->reset_gpio))
> +		gpio_set_value_cansleep(ddata->reset_gpio, 1);
> +
> +	in->ops.dpi->disable(in);
> +
> +	dssdev->state =3D OMAP_DSS_DISPLAY_DISABLED;
> +}
> +
> +static void sil9022_set_timings(struct omap_dss_device *dssdev,
> +		struct omap_video_timings *timings)
> +{
> +	struct panel_drv_data *ddata =3D to_panel_data(dssdev);
> +	struct omap_dss_device *in =3D ddata->in;
> +	struct omap_video_timings *sil9022_timings =3D timings;
> +
> +       /* update DPI specific timing info */
> +	sil9022_timings->data_pclk_edge  =3D OMAPDSS_DRIVE_SIG_RISING_EDGE;
> +	sil9022_timings->de_level		  =3D OMAPDSS_SIG_ACTIVE_HIGH;

Extra spaces/tabs.

> +	sil9022_timings->sync_pclk_edge =3D OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES;=

> +	ddata->timings =3D *sil9022_timings;
> +	dssdev->panel.timings =3D *sil9022_timings;
> +
> +	in->ops.dpi->set_timings(in, sil9022_timings);
> +}
> +
> +static void sil9022_get_timings(struct omap_dss_device *dssdev,
> +		struct omap_video_timings *timings)
> +{
> +	struct panel_drv_data *ddata =3D to_panel_data(dssdev);
> +	*timings =3D ddata->timings;
> +}
> +
> +static int sil9022_check_timings(struct omap_dss_device *dssdev,
> +		struct omap_video_timings *timings)
> +{
> +	struct panel_drv_data *ddata =3D to_panel_data(dssdev);
> +	struct omap_dss_device *in =3D ddata->in;
> +	struct omap_video_timings *sil9022_timings =3D timings;
> +
> +	/* update DPI specific timing info */
> +	sil9022_timings->data_pclk_edge  =3D OMAPDSS_DRIVE_SIG_RISING_EDGE;
> +	sil9022_timings->de_level		  =3D OMAPDSS_SIG_ACTIVE_HIGH;

And here.

> +	sil9022_timings->sync_pclk_edge =3D OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES;=

> +
> +	return in->ops.dpi->check_timings(in, sil9022_timings);
> +}
> +
> +static int sil9022_read_edid(struct omap_dss_device *dssdev,
> +	       u8 *edid, int len)
> +{
> +
> +	int r =3D  0;
> +	unsigned int val =3D 0;
> +	int retries =3D 0;
> +	struct panel_drv_data *ddata =3D to_panel_data(dssdev);
> +	struct i2c_client *client =3D ddata->i2c_client;
> +	struct regmap *map =3D ddata->regmap;
> +
> +	len =3D (len < HDMI_EDID_MAX_LENGTH) ? len : HDMI_EDID_MAX_LENGTH;
> +
> +	/* Request DDC bus access to read EDID info */
> +
> +	/* Disable TMDS clock */
> +
> +	r =3D regmap_write(map, HDMI_SYS_CTRL_DATA_REG, 0x11);
> +	if (r < 0) {
> +		dev_err(&client->dev,
> +			"ERROR: Failed to disable TMDS clock\n");
> +		return r;
> +	}
> +
> +	val =3D 0;
> +
> +	/* Read TPI system control register*/
> +	r =3D regmap_read(map, HDMI_SYS_CTRL_DATA_REG, &val);
> +	if (r < 0) {
> +		dev_err(&client->dev,
> +			"ERROR: Reading DDC BUS REQUEST\n");
> +		return r;
> +	}
> +
> +	/* The host writes 0x1A[2]=3D1 to request the
> +	 * DDC(Display Data Channel) bus
> +	 */
> +	r =3D regmap_write(map, HDMI_SYS_CTRL_DATA_REG,
> +				val | TPI_SYS_CTRL_DDC_BUS_REQUEST);
> +	if (r < 0) {
> +		dev_err(&client->dev,
> +			"ERROR: Writing DDC BUS REQUEST\n");
> +		return r;
> +	}
> +
> +	/*  Poll for bus DDC Bus control to be granted */
> +	val =3D 0;
> +
> +	/* Through trial and error, to get DDC BUS we need around 3 tries */
> +	/* Hence keeping it rounded at 5 tries - a max of 4 retries allowed *=
/
> +	do {
> +		r =3D regmap_read(map, HDMI_SYS_CTRL_DATA_REG, &val);
> +		if (retries++ > 5) {
> +			dev_err(&client->dev, "ERROR: Acquiring DDC Bus\n");
> +			return r;
> +		}
> +	} while ((val & TPI_SYS_CTRL_DDC_BUS_GRANTED) =3D=3D 0);
> +
> +	/*  Close the switch to the DDC */
> +	r =3D regmap_write(map, HDMI_SYS_CTRL_DATA_REG,
> +		val | TPI_SYS_CTRL_DDC_BUS_REQUEST |
> +		TPI_SYS_CTRL_DDC_BUS_GRANTED);
> +
> +	if (r < 0) {
> +		dev_err(&client->dev,
> +			"<%s> ERROR: Close switch to DDC BUS REQUEST\n",
> +			__func__);
> +		return r;
> +	}
> +
> +	r =3D sil9022_ddc_read(client, edid, len, 0);
> +	if (r < 0) {
> +		dev_err(&client->dev, "ERROR: Reading EDID\n");
> +		return r;
> +	}
> +
> +	/* Release DDC bus access */
> +	val &=3D ~(TPI_SYS_CTRL_DDC_BUS_REQUEST | TPI_SYS_CTRL_DDC_BUS_GRANTE=
D);
> +
> +	/*Through trial and error, seen that releasing BUS needed 3 tries */
> +	/* Hence keeping it rounded at 5 tries - a max of 4 retries allowed *=
/
> +	retries =3D 0;
> +	do {
> +		r =3D regmap_write(map, HDMI_SYS_CTRL_DATA_REG, val);
> +		if (r >=3D 0)
> +			break;
> +		retries++;
> +	} while (retries < 5);
> +	if (r < 0) {
> +		dev_err(&client->dev, "ERROR: Releasing DDC Bus Access\n");
> +		return r;
> +		}
> +	return 0;
> +}
> +
> +static bool sil9022_detect(struct omap_dss_device *dssdev)
> +{
> +	/* Hot plug detection is not implemented */
> +	/* Hence we assume monitor connected */
> +	/* This will be fixed once HPD / polling is implemented */
> +	return true;
> +}
> +
> +static bool sil9022_audio_supported(struct omap_dss_device *dssdev)
> +{
> +	/* Audio configuration not present, hence returning false */
> +	return false;
> +}
> +
> +static const struct omapdss_hdmi_ops sil9022_hdmi_ops =3D {
> +	.connect			=3D sil9022_connect,
> +	.disconnect		=3D sil9022_disconnect,
> +
> +	.enable			=3D sil9022_enable,
> +	.disable			=3D sil9022_disable,
> +
> +	.check_timings	=3D sil9022_check_timings,
> +	.set_timings		=3D sil9022_set_timings,
> +	.get_timings		=3D sil9022_get_timings,
> +
> +	.read_edid		=3D sil9022_read_edid,
> +	.detect			=3D sil9022_detect,
> +
> +	.audio_supported	=3D sil9022_audio_supported,
> +	/* Yet to implement audio ops */
> +	/* For now audio_supported ops to return false */
> +};
> +
> +
> +static int sil9022_probe_of(struct i2c_client *client)
> +{
> +	struct panel_drv_data *ddata =3D dev_get_drvdata(&client->dev);
> +	struct device_node *node =3D client->dev.of_node;
> +	struct device_node *src_node;
> +	struct omap_dss_device *dssdev, *in;
> +
> +	int r, reset_gpio, datalines;
> +
> +	src_node =3D of_parse_phandle(node, "video-source", 0);
> +	if (!src_node) {
> +		dev_err(&client->dev, "failed to parse video source\n");
> +		return -ENODEV;
> +	}

There is no "video-source" property any more, and the endpoint handling
is missing, so I think it's clear you have not tested this driver with
the bindings you have in the patch 2/2.

> +
> +	in =3D omap_dss_find_output_by_node(src_node);
> +	if (in =3D=3D NULL) {
> +		dev_err(&client->dev, "failed to find video source\n");
> +		return -EPROBE_DEFER;
> +	}
> +	ddata->in =3D in;
> +
> +	reset_gpio =3D of_get_named_gpio(node, "reset-gpio", 0);
> +
> +	if (gpio_is_valid(reset_gpio) || reset_gpio =3D=3D -ENOENT) {
> +		ddata->reset_gpio =3D reset_gpio;
> +	} else {
> +		dev_err(&client->dev, "failed to parse lcdorhdmi gpio\n");
> +		return reset_gpio;
> +	}
> +
> +	r =3D of_property_read_u32(node, "data-lines", &datalines);

This driver doesn't use datalines information for anything, so this is
not needed.

 Tomi



--nV0cjgXKsMWUv866lLl8qqGuHQvd5ugsc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTKCwbAAoJEPo9qoy8lh71IyQP/1ZFA0by1qxNGzWFZishCpwY
zJXLrGSQ17DTyBY70XzLWSw5ceWFinUUYFoGFSu/Mt/EF4ki5Ju2lbJQgayBH2lX
sT+gp3at9kPNX6aHymNASMVOBcZRVblwPMNumlnSTEjB2IRQQA1l5vrV873Qay+9
vwQQsWycO1Dh2d/jrhmzYYdDu8MUIMYyZhOwLJO+vjUtWHeMqGZvgWUdP1KjTBMB
I/tfERyayvinO+yOLVwPOC0epfhUBmfudekKv/JA5zp6/wmIGi9QW1pUKWW4NXSG
OXzJFqHkIWMLpXVZpngYlb7pA+OsrohY9T0unUQPK9chK7CWfHN6N65X9pqkKo1m
WODYTrsTU4hsWwPLwXsiDSxVivPYuxCi6YUSGkkQk46IiJM3wAsGuLUUGjlOUe53
eiXw0zR5bjaGw48EV94UZmG6t4NDVHDYNgZWsHXeZStXRl/J1B+YVWv76LEKtamJ
xKNxR7zFuKDpuQl/kWKZWnSZ3UQ6tPQHQoVsYh45gW3e7bN383ulxyhAigBCvP5x
a2j/OH3RMmUYy2Y43vNgVHVPNQ63+OBYFsSL3sDX6V453Q6Dx5D2HMT/uBW9RNt+
QyfC8n5UntcH349pyAPdMv/w2KRoWRVnhO30oDarY6SqMKeqn5h6rG5Bj0EPVise
B+/Qze1soqmsU08bFkfO
=Zzyv
-----END PGP SIGNATURE-----

--nV0cjgXKsMWUv866lLl8qqGuHQvd5ugsc--
