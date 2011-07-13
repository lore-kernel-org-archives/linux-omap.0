From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 4/4] dt: i2c-omap: Convert i2c driver to use device tree
Date: Thu, 14 Jul 2011 08:20:28 +0900
Message-ID: <CACxGe6vG9BKUDvthOKFtx3u=Vq0EfBaZakxVqx8AYfRe_ruNdg@mail.gmail.com>
References: <1310592975-25773-1-git-send-email-manjugk@ti.com> <1310592975-25773-5-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46204 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507Ab1GMXUt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jul 2011 19:20:49 -0400
Received: by yxi11 with SMTP id 11so2642508yxi.19
        for <linux-omap@vger.kernel.org>; Wed, 13 Jul 2011 16:20:48 -0700 (PDT)
In-Reply-To: <1310592975-25773-5-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, ben-linux@fluff.org

On Thu, Jul 14, 2011 at 7:06 AM, G, Manjunath Kondaiah <manjugk@ti.com>=
 wrote:
>
> The i2c-omap driver is converted for supporting both
> dt and non dt builds and driver is modified to use dt
> data partially.
>
> Tested on OMAP3 beagle board.
>
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> ---
> =A0drivers/i2c/busses/i2c-omap.c | =A0 48 +++++++++++++++++++++++++++=
+++++++++++++-
> =A01 files changed, 47 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-o=
map.c
> index ae1545b..6d11a13 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -38,9 +38,13 @@
> =A0#include <linux/clk.h>
> =A0#include <linux/io.h>
> =A0#include <linux/of_i2c.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_address.h>
> =A0#include <linux/slab.h>
> =A0#include <linux/i2c-omap.h>
> =A0#include <linux/pm_runtime.h>
> +#include <plat/i2c.h>
>
> =A0/* I2C controller revisions */
> =A0#define OMAP_I2C_REV_2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x20
> @@ -972,6 +976,10 @@ static const struct i2c_algorithm omap_i2c_algo =
=3D {
> =A0 =A0 =A0 =A0.functionality =A0=3D omap_i2c_func,
> =A0};
>
> +#if defined(CONFIG_OF)
> +static const struct of_device_id omap_i2c_of_match[];
> +#endif
> +
> =A0static int __devinit
> =A0omap_i2c_probe(struct platform_device *pdev)
> =A0{
> @@ -979,10 +987,17 @@ omap_i2c_probe(struct platform_device *pdev)
> =A0 =A0 =A0 =A0struct i2c_adapter =A0 =A0 =A0*adap;
> =A0 =A0 =A0 =A0struct resource =A0 =A0 =A0 =A0 *mem, *irq, *ioarea;
> =A0 =A0 =A0 =A0struct omap_i2c_bus_platform_data *pdata =3D pdev->dev=
=2Eplatform_data;
> +#if defined(CONFIG_OF)
> + =A0 =A0 =A0 const struct of_device_id *match;
> +#endif
> =A0 =A0 =A0 =A0irq_handler_t isr;
> =A0 =A0 =A0 =A0int r;
> =A0 =A0 =A0 =A0u32 speed =3D 0;
>
> +#if defined(CONFIG_OF)
> + =A0 =A0 =A0 match =3D of_match_device(omap_i2c_of_match, &pdev->dev=
);
> +#endif

of_match_device() is an empty inline when CONFIG_OF is not defined.
You can drop the #if defined() protection around this statement.

> +
> =A0 =A0 =A0 =A0/* NOTE: driver uses the static register mapping */
> =A0 =A0 =A0 =A0mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0)=
;
> =A0 =A0 =A0 =A0if (!mem) {
> @@ -1011,11 +1026,25 @@ omap_i2c_probe(struct platform_device *pdev)
> =A0 =A0 =A0 =A0if (pdata !=3D NULL) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0speed =3D pdata->clkrate;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->set_mpu_wkup_lat =3D pdata->set_m=
pu_wkup_lat;
> +#if defined(CONFIG_OF)
> + =A0 =A0 =A0 } else if (pdev->dev.of_node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 prop;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!of_property_read_u32(pdev->dev.of_=
node, "clock-frequency",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 &prop))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 speed =3D prop/100;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 speed =3D 100;

If you move the 'speed =3D 100' statement above the if(pdata !=3D NULL)
test, then this whole block can become simpler for both the pdata and
DT situations.

> +#else
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0speed =3D 100; =A0 =A0/* Default speed=
 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->set_mpu_wkup_lat =3D NULL;
> +#endif
> =A0 =A0 =A0 =A0}
>
> +#if defined(CONFIG_OF)
> + =A0 =A0 =A0 /* TODO: remove this after DT depencies with hwmod are =
resolved */
> + =A0 =A0 =A0 if (match)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +#endif
> =A0 =A0 =A0 =A0dev->speed =3D speed;
> =A0 =A0 =A0 =A0dev->idle =3D 1;
> =A0 =A0 =A0 =A0dev->dev =3D &pdev->dev;
> @@ -1096,7 +1125,9 @@ omap_i2c_probe(struct platform_device *pdev)
> =A0 =A0 =A0 =A0strlcpy(adap->name, "OMAP I2C adapter", sizeof(adap->n=
ame));
> =A0 =A0 =A0 =A0adap->algo =3D &omap_i2c_algo;
> =A0 =A0 =A0 =A0adap->dev.parent =3D &pdev->dev;
> +#if defined(CONFIG_OF)
> =A0 =A0 =A0 =A0adap->dev.of_node =3D pdev->dev.of_node;
> +#endif

The #if defined() can be safely removed here.

>
> =A0 =A0 =A0 =A0/* i2c device drivers may be active on return from add=
_adapter() */
> =A0 =A0 =A0 =A0adap->nr =3D pdev->id;
> @@ -1106,7 +1137,9 @@ omap_i2c_probe(struct platform_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_free_irq;
> =A0 =A0 =A0 =A0}
>
> +#if defined(CONFIG_OF)
> =A0 =A0 =A0 =A0of_i2c_register_devices(adap);
> +#endif

Ditto here. of_i2c_register_devices() is an empty inline when !CONFIG_O=
=46

>
> =A0 =A0 =A0 =A0return 0;
>
> @@ -1162,6 +1195,16 @@ static int omap_i2c_resume(struct device *dev)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +#if defined(CONFIG_OF)
> +static const struct of_device_id omap_i2c_of_match[] =3D {
> + =A0 =A0 =A0 {.compatible =3D "ti,omap3-i2c", },
> + =A0 =A0 =A0 {},
> +}
> +MODULE_DEVICE_TABLE(of, omap_i2c_of_match);
> +#else
> +#define omap_i2c_of_match NULL
> +#endif

You can move this whole block up to where omap_i2c_of_match is forward
declared, which will make the patch smaller.

> +
> =A0static struct dev_pm_ops omap_i2c_pm_ops =3D {
> =A0 =A0 =A0 =A0.suspend =3D omap_i2c_suspend,
> =A0 =A0 =A0 =A0.resume =3D omap_i2c_resume,
> @@ -1178,6 +1221,9 @@ static struct platform_driver omap_i2c_driver =3D=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "omap_i2c",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =A0=3D THIS_MODULE,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.pm =A0 =A0 =3D OMAP_I2C_PM_OPS,
> +#if defined(CONFIG_OF)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D omap_i2c_of_match,
> +#endif

Drop the #if defined() protection.

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
