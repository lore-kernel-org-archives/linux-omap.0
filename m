From: Russ Dill <russ.dill@gmail.com>
Subject: Re: [PATCH 01/25] OMAPDSS: panel-dvi: add PD gpio handling
Date: Wed, 9 May 2012 09:50:31 -0700
Message-ID: <CA+Bv8XZSpBJ4_DD=uTkX1zD+Hj31MehCVATjNKo0Bo4aHUfnNA@mail.gmail.com>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
	<1336053481-25433-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:55407 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757617Ab2EIQud convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 May 2012 12:50:33 -0400
In-Reply-To: <1336053481-25433-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

On Thu, May 3, 2012 at 6:57 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:
> The driver for the TFP410 chip should handle the power-down signal of
> the chip, instead of the current way of handling it in the board file=
s.
>
> This patch adds power_down_gpio into the device's platform data, and
> adds the necessary code in the driver to request and handle the GPIO.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
> =C2=A0drivers/video/omap2/displays/panel-dvi.c | =C2=A0 31 ++++++++++=
++++++++++++++++++++
> =C2=A0include/video/omap-panel-dvi.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | =C2=A0 =C2=A02 ++
> =C2=A02 files changed, 33 insertions(+)
>
> diff --git a/drivers/video/omap2/displays/panel-dvi.c b/drivers/video=
/omap2/displays/panel-dvi.c
> index 03eb14a..876b798 100644
> --- a/drivers/video/omap2/displays/panel-dvi.c
> +++ b/drivers/video/omap2/displays/panel-dvi.c
> @@ -21,6 +21,7 @@
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <video/omapdss.h>
> =C2=A0#include <linux/i2c.h>
> +#include <linux/gpio.h>
> =C2=A0#include <drm/drm_edid.h>
>
> =C2=A0#include <video/omap-panel-dvi.h>
> @@ -44,6 +45,8 @@ struct panel_drv_data {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct omap_dss_device *dssdev;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mutex lock;
> +
> + =C2=A0 =C2=A0 =C2=A0 int pd_gpio;
> =C2=A0};
>
> =C2=A0static inline struct panel_dvi_platform_data
> @@ -54,6 +57,7 @@ static inline struct panel_dvi_platform_data
>
> =C2=A0static int panel_dvi_power_on(struct omap_dss_device *dssdev)
> =C2=A0{
> + =C2=A0 =C2=A0 =C2=A0 struct panel_drv_data *ddata =3D dev_get_drvda=
ta(&dssdev->dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct panel_dvi_platform_data *pdata =3D =
get_pdata(dssdev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int r;
>
> @@ -70,6 +74,9 @@ static int panel_dvi_power_on(struct omap_dss_devic=
e *dssdev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0goto err1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> + =C2=A0 =C2=A0 =C2=A0 if (gpio_is_valid(ddata->pd_gpio))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpio_set_value(dda=
ta->pd_gpio, 1);
> +

On Beagleboard xM, this GPIO is connected though an I2C chip so it
sleeps. Can you change these to gpio_set_value_cansleep?

> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0err1:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omapdss_dpi_display_disable(dssdev);
> @@ -79,11 +86,15 @@ err0:
>
> =C2=A0static void panel_dvi_power_off(struct omap_dss_device *dssdev)
> =C2=A0{
> + =C2=A0 =C2=A0 =C2=A0 struct panel_drv_data *ddata =3D dev_get_drvda=
ta(&dssdev->dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct panel_dvi_platform_data *pdata =3D =
get_pdata(dssdev);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dssdev->state !=3D OMAP_DSS_DISPLAY_AC=
TIVE)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>
> + =C2=A0 =C2=A0 =C2=A0 if (gpio_is_valid(ddata->pd_gpio))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpio_set_value(dda=
ta->pd_gpio, 0);
> +

Same with this one.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pdata->platform_disable)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pdata->platfor=
m_disable(dssdev);
>
> @@ -92,7 +103,9 @@ static void panel_dvi_power_off(struct omap_dss_de=
vice *dssdev)
>
> =C2=A0static int panel_dvi_probe(struct omap_dss_device *dssdev)
> =C2=A0{
> + =C2=A0 =C2=A0 =C2=A0 struct panel_dvi_platform_data *pdata =3D get_=
pdata(dssdev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct panel_drv_data *ddata;
> + =C2=A0 =C2=A0 =C2=A0 int r;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ddata =3D kzalloc(sizeof(*ddata), GFP_KERN=
EL);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ddata)
> @@ -104,6 +117,21 @@ static int panel_dvi_probe(struct omap_dss_devic=
e *dssdev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ddata->dssdev =3D dssdev;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_init(&ddata->lock);
>
> + =C2=A0 =C2=A0 =C2=A0 if (pdata)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ddata->pd_gpio =3D=
 pdata->power_down_gpio;
> + =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ddata->pd_gpio =3D=
 -1;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (gpio_is_valid(ddata->pd_gpio)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D gpio_request=
_one(ddata->pd_gpio, GPIOF_OUT_INIT_LOW,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "tfp410 pd");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 dev_err(&dssdev->dev, "Failed to request PD GPIO %d\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ddata->=
pd_gpio);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ddata->pd_gpio =3D -1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_set_drvdata(&dssdev->dev, ddata);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> @@ -115,6 +143,9 @@ static void __exit panel_dvi_remove(struct omap_d=
ss_device *dssdev)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&ddata->lock);
>
> + =C2=A0 =C2=A0 =C2=A0 if (gpio_is_valid(ddata->pd_gpio))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpio_free(ddata->p=
d_gpio);
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_set_drvdata(&dssdev->dev, NULL);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&ddata->lock);
> diff --git a/include/video/omap-panel-dvi.h b/include/video/omap-pane=
l-dvi.h
> index 87ad567b..4ad41fc 100644
> --- a/include/video/omap-panel-dvi.h
> +++ b/include/video/omap-panel-dvi.h
> @@ -27,11 +27,13 @@ struct omap_dss_device;
> =C2=A0* @platform_enable: platform specific panel enable function
> =C2=A0* @platform_disable: platform specific panel disable function
> =C2=A0* @i2c_bus_num: i2c bus id for the panel
> + * @power_down_gpio: gpio number for PD pin (or -1 if not available)
> =C2=A0*/
> =C2=A0struct panel_dvi_platform_data {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int (*platform_enable)(struct omap_dss_dev=
ice *dssdev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0void (*platform_disable)(struct omap_dss_d=
evice *dssdev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 i2c_bus_num;
> + =C2=A0 =C2=A0 =C2=A0 int power_down_gpio;
> =C2=A0};
>
> =C2=A0#endif /* __OMAP_PANEL_DVI_H */
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
