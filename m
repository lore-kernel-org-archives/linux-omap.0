From: "Dr. H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH v2 1/5] video: omapdss: Add opa362 driver
Date: Thu, 13 Nov 2014 17:25:41 +0100
Message-ID: <9FD016B8-4EA2-4A0D-B790-6494AB449B31@goldelico.com>
References: <1415830247-31633-1-git-send-email-marek@goldelico.com> <1415830247-31633-2-git-send-email-marek@goldelico.com> <54649B43.1000801@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54649B43.1000801-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gta04-owner-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

Am 13.11.2014 um 12:51 schrieb Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>:

> On 13/11/14 00:10, Marek Belisko wrote:
>> opa362 is amplifier for video and can be connected to the tvout pads
>> of the OMAP3. It has one gpio control for enable/disable of the outp=
ut
>> (high impedance).
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
>> ---
>> drivers/video/fbdev/omap2/displays-new/Kconfig     |   6 +
>> drivers/video/fbdev/omap2/displays-new/Makefile    |   1 +
>> .../fbdev/omap2/displays-new/amplifier-opa362.c    | 343 +++++++++++=
++++++++++
>=20
> I think it would be better to rename this to encoder-opa362.c. It's n=
ot

When developing this driver we did simply rename the encoder-tfp410 fil=
e,
but thent hough that it does not fit into the =84encoder=93 category, b=
ecause we
would expect something digital or digital to analog =84encoding=93 whic=
h it does not.

> encoder as such, but it falls into the same category.

But we can change it.

>=20
>> include/video/omap-panel-data.h                    |  12 +
>> 4 files changed, 362 insertions(+)
>> create mode 100644 drivers/video/fbdev/omap2/displays-new/amplifier-=
opa362.c
>>=20
>> diff --git a/drivers/video/fbdev/omap2/displays-new/Kconfig b/driver=
s/video/fbdev/omap2/displays-new/Kconfig
>> index e6cfc38..211b3ec 100644
>> --- a/drivers/video/fbdev/omap2/displays-new/Kconfig
>> +++ b/drivers/video/fbdev/omap2/displays-new/Kconfig
>> @@ -1,6 +1,12 @@
>> menu "OMAP Display Device Drivers (new device model)"
>>         depends on OMAP2_DSS
>>=20
>> +config DISPLAY_AMPLIFIER_OPA362
>=20
> Here also use ENCODER instead.
>=20
>> +        tristate "external analog amplifier with output disable/hig=
h-Z (e.g. OPA362)"
>> +	help
>> +	  Driver to enable an external analog TV amplifier (e.g. OPA362)
>> +	  through a GPIO.
>=20
> The indentation above seems funny.
>=20
> The text looks a bit odd. So is this a driver for OPA362, or is this =
a
> generic driver for any similar devices? Most of the names and code ma=
kes
> me think this is a driver for OPA362, but the text above quite clearl=
y
> gives the impression that this is a driver for any analog video amp,
> with single enable gpio.

Hm. We can imagine that there are other devices with similar functional=
ity
and gpio but we have not tested any. So it is indeed better to describe=
 it as
a pure OPA362 driver.

>=20
>> +
>> config DISPLAY_ENCODER_TFP410
>>         tristate "TFP410 DPI to DVI Encoder"
>> 	help
>> diff --git a/drivers/video/fbdev/omap2/displays-new/Makefile b/drive=
rs/video/fbdev/omap2/displays-new/Makefile
>> index 0323a8a..b311542 100644
>> --- a/drivers/video/fbdev/omap2/displays-new/Makefile
>> +++ b/drivers/video/fbdev/omap2/displays-new/Makefile
>> @@ -1,3 +1,4 @@
>> +obj-$(CONFIG_DISPLAY_AMPLIFIER_OPA362) +=3D amplifier-opa362.o
>> obj-$(CONFIG_DISPLAY_ENCODER_TFP410) +=3D encoder-tfp410.o
>> obj-$(CONFIG_DISPLAY_ENCODER_TPD12S015) +=3D encoder-tpd12s015.o
>> obj-$(CONFIG_DISPLAY_CONNECTOR_DVI) +=3D connector-dvi.o
>> diff --git a/drivers/video/fbdev/omap2/displays-new/amplifier-opa362=
=2Ec b/drivers/video/fbdev/omap2/displays-new/amplifier-opa362.c
>> new file mode 100644
>> index 0000000..8065a28
>> --- /dev/null
>> +++ b/drivers/video/fbdev/omap2/displays-new/amplifier-opa362.c
>> @@ -0,0 +1,343 @@
>> +/*
>> + * OPA362 analog video amplifier with output/power control
>> + *
>> + * Copyright (C) 2014 Golden Delicious Computers
>> + * Author: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
>> + *
>> + * based on encoder-tfp410
>> + *
>> + * Copyright (C) 2013 Texas Instruments
>> + * Author: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify it
>> + * under the terms of the GNU General Public License version 2 as p=
ublished by
>> + * the Free Software Foundation.
>> + */
>> +
>> +#include <linux/gpio.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/of_gpio.h>
>> +
>> +#include <video/omapdss.h>
>> +#include <video/omap-panel-data.h>
>> +
>> +struct panel_drv_data {
>> +	struct omap_dss_device dssdev;
>> +	struct omap_dss_device *in;
>> +
>> +	int enable_gpio;
>> +
>> +	struct omap_video_timings timings;
>> +};
>> +
>> +#define to_panel_data(x) container_of(x, struct panel_drv_data, dss=
dev)
>> +
>> +static int opa362_connect(struct omap_dss_device *dssdev,
>> +		struct omap_dss_device *dst)
>> +{
>> +	struct panel_drv_data *ddata =3D to_panel_data(dssdev);
>> +	struct omap_dss_device *in =3D ddata->in;
>> +	int r;
>> +
>> +	dev_dbg(dssdev->dev, "connect\n");
>> +
>> +	if (omapdss_device_is_connected(dssdev))
>> +		return -EBUSY;
>> +
>> +	r =3D in->ops.atv->connect(in, dssdev);
>> +	if (r)
>> +		return r;
>> +
>> +	dst->src =3D dssdev;
>> +	dssdev->dst =3D dst;
>> +
>> +	return 0;
>> +}
>> +
>> +static void opa362_disconnect(struct omap_dss_device *dssdev,
>> +		struct omap_dss_device *dst)
>> +{
>> +	struct panel_drv_data *ddata =3D to_panel_data(dssdev);
>> +	struct omap_dss_device *in =3D ddata->in;
>> +
>> +	dev_dbg(dssdev->dev, "disconnect\n");
>> +
>> +	WARN_ON(!omapdss_device_is_connected(dssdev));
>> +	if (!omapdss_device_is_connected(dssdev))
>> +		return;
>> +
>> +	WARN_ON(dst !=3D dssdev->dst);
>> +	if (dst !=3D dssdev->dst)
>> +		return;
>> +
>> +	dst->src =3D NULL;
>> +	dssdev->dst =3D NULL;
>> +
>> +	in->ops.atv->disconnect(in, &ddata->dssdev);
>> +}
>> +
>> +static int opa362_enable(struct omap_dss_device *dssdev)
>> +{
>> +	struct panel_drv_data *ddata =3D to_panel_data(dssdev);
>> +	struct omap_dss_device *in =3D ddata->in;
>> +	int r;
>> +
>> +	dev_dbg(dssdev->dev, "enable\n");
>> +
>> +	if (!omapdss_device_is_connected(dssdev))
>> +		return -ENODEV;
>> +
>> +	if (omapdss_device_is_enabled(dssdev))
>> +		return 0;
>> +
>> +	in->ops.atv->set_timings(in, &ddata->timings);
>> +	/* fixme: should we receive the invert from our consumer, i.e. the=
 connector? */
>> +	in->ops.atv->invert_vid_out_polarity(in, true);
>=20
> Well this does seem to be broken. I don't know what the answer to the
> question above is, but the code doesn't work properly.
>=20
> In the opa362_invert_vid_out_polarity function below, you get the inv=
ert
> boolean from the connector. This you pass to the OMAP venc. However,
> above you always override that value in venc with true.
>=20
> So, either the invert_vid_out_polarity value has to be always true or
> false, because _OPA362_ requires it to be true or false, OR you need =
use
> the value from the connector.
>=20
> Seeing the comment in opa362_invert_vid_out_polarity, my guess is the
> latter, and the call above should be removed.

Yes, you are right - this is not systematic.

But the problem is that we can=92t ask the connector here what it wants
to see. It might (or might not) call our opa362_invert_vid_out_polarity=
() later
which we can then forward to overwrite the inital state of this opa362_=
enable().

What it should be is something like

in->ops.atv->invert_vid_out_polarity(in, ! out->ops.atv->get_expected_v=
id_output_polarity())

but that does not exist and I am not sure if you want to introduce it.

So I only see the option that we always use=20

in->ops.atv->invert_vid_out_polarity(in, true);

and do a sanity check in opa362_invert_vid_out_polarity() to block a co=
nnector
that is requesting the wrong polarity.

>=20
>> +
>> +	r =3D in->ops.atv->enable(in);
>> +	if (r)
>> +		return r;
>> +
>> +	if (gpio_is_valid(ddata->enable_gpio))
>> +		gpio_set_value_cansleep(ddata->enable_gpio, 1);
>> +
>> +	dssdev->state =3D OMAP_DSS_DISPLAY_ACTIVE;
>> +
>> +	return 0;
>> +}
>> +
>> +static void opa362_disable(struct omap_dss_device *dssdev)
>> +{
>> +	struct panel_drv_data *ddata =3D to_panel_data(dssdev);
>> +	struct omap_dss_device *in =3D ddata->in;
>> +
>> +	dev_dbg(dssdev->dev, "disable\n");
>> +
>> +	if (!omapdss_device_is_enabled(dssdev))
>> +		return;
>> +
>> +	if (gpio_is_valid(ddata->enable_gpio))
>> +		gpio_set_value_cansleep(ddata->enable_gpio, 0);
>> +
>> +	in->ops.atv->disable(in);
>> +
>> +	dssdev->state =3D OMAP_DSS_DISPLAY_DISABLED;
>> +}
>> +
>> +static void opa362_set_timings(struct omap_dss_device *dssdev,
>> +		struct omap_video_timings *timings)
>> +{
>> +	struct panel_drv_data *ddata =3D to_panel_data(dssdev);
>> +	struct omap_dss_device *in =3D ddata->in;
>> +
>> +	dev_dbg(dssdev->dev, "set_timings\n");
>> +
>> +	ddata->timings =3D *timings;
>> +	dssdev->panel.timings =3D *timings;
>> +
>> +	in->ops.atv->set_timings(in, timings);
>> +}
>> +
>> +static void opa362_get_timings(struct omap_dss_device *dssdev,
>> +		struct omap_video_timings *timings)
>> +{
>> +	struct panel_drv_data *ddata =3D to_panel_data(dssdev);
>> +
>> +	dev_dbg(dssdev->dev, "get_timings\n");
>> +
>> +	*timings =3D ddata->timings;
>> +}
>> +
>> +static int opa362_check_timings(struct omap_dss_device *dssdev,
>> +		struct omap_video_timings *timings)
>> +{
>> +	struct panel_drv_data *ddata =3D to_panel_data(dssdev);
>> +	struct omap_dss_device *in =3D ddata->in;
>> +
>> +	dev_dbg(dssdev->dev, "check_timings\n");
>> +
>> +	return in->ops.atv->check_timings(in, timings);
>> +}
>> +
>> +static void opa362_set_type(struct omap_dss_device *dssdev,
>> +		enum omap_dss_venc_type type)
>> +{
>> +	/* we can only drive a COMPOSITE output */
>> +	WARN_ON(type !=3D OMAP_DSS_VENC_TYPE_COMPOSITE);
>> +
>> +}
>> +
>> +static void opa362_invert_vid_out_polarity(struct omap_dss_device *=
dssdev,
>> +		bool invert_polarity)
>> +{
>> +	struct panel_drv_data *ddata =3D to_panel_data(dssdev);
>> +	struct omap_dss_device *in =3D ddata->in;
>> +
>> +	/* OPA362 inverts the polarity */
>> +	in->ops.atv->invert_vid_out_polarity(in, !invert_polarity);
>> +}
>> +
>> +static const struct omapdss_atv_ops opa362_atv_ops =3D {
>> +	.connect	=3D opa362_connect,
>> +	.disconnect	=3D opa362_disconnect,
>> +
>> +	.enable		=3D opa362_enable,
>> +	.disable	=3D opa362_disable,
>> +
>> +	.check_timings	=3D opa362_check_timings,
>> +	.set_timings	=3D opa362_set_timings,
>> +	.get_timings	=3D opa362_get_timings,
>> +
>> +	.set_type	=3D opa362_set_type,
>> +	.invert_vid_out_polarity	=3D opa362_invert_vid_out_polarity,
>> +};
>> +
>> +static int opa362_probe_pdata(struct platform_device *pdev)
>> +{
>> +	struct panel_drv_data *ddata =3D platform_get_drvdata(pdev);
>> +	struct amplifier_opa362_platform_data *pdata;
>> +	struct omap_dss_device *dssdev, *in;
>> +
>> +	pdata =3D dev_get_platdata(&pdev->dev);
>> +
>> +	ddata->enable_gpio =3D pdata->enable_gpio;
>> +
>> +	in =3D omap_dss_find_output(pdata->source);
>> +	if (in =3D=3D NULL) {
>> +		dev_err(&pdev->dev, "Failed to find video source\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	ddata->in =3D in;
>> +
>> +	dssdev =3D &ddata->dssdev;
>> +	dssdev->name =3D pdata->name;
>> +
>> +	return 0;
>> +}
>=20
> We are going to support only DT boot at some point. Thus I think the
> whole platform data code should be left out.

Is there already a decision? I think it should not be done before. And =
it
does not harm to still have it.

>=20
>> +
>> +static int opa362_probe_of(struct platform_device *pdev)
>> +{
>> +	struct panel_drv_data *ddata =3D platform_get_drvdata(pdev);
>> +	struct device_node *node =3D pdev->dev.of_node;
>> +	struct omap_dss_device *in;
>> +	int gpio;
>> +
>> +	gpio =3D of_get_gpio(node, 0);
>> +
>> +	if (gpio_is_valid(gpio) || gpio =3D=3D -ENOENT) {
>> +		ddata->enable_gpio =3D gpio;
>> +	} else {
>> +		dev_err(&pdev->dev, "failed to parse enable gpio\n");
>> +		return gpio;
>> +	}
>=20
> You should use the new GPIO API to get full support from the DT data.
> For an example, see panel-dpi.c's enable_gpio.

Ok.

BR,
Nikolaus

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
