From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] DT: OMAP: Convert I2C driver to use device tree
Date: Mon, 1 Aug 2011 23:04:49 +0100
Message-ID: <CACxGe6ugCVJJb32uie=Kh7sKrKREH8h0euuZVUrGeLab4zSgVw@mail.gmail.com>
References: <1312235294-4397-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:40841 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473Ab1HAWFL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Aug 2011 18:05:11 -0400
Received: by ewy4 with SMTP id 4so3007356ewy.19
        for <linux-omap@vger.kernel.org>; Mon, 01 Aug 2011 15:05:09 -0700 (PDT)
In-Reply-To: <1312235294-4397-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org

On Mon, Aug 1, 2011 at 10:48 PM, G, Manjunath Kondaiah <manjugk@ti.com>=
 wrote:
> The i2c-omap driver is modified to support both DT and non DT builds
> and driver is updated to use dt data partially.
>
> Tested on OMAP3 beagle board for dt and non dt builds.
>
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> ---
> =A0drivers/i2c/busses/i2c-omap.c | =A0 33 +++++++++++++++++++++++++++=
+++---
> =A01 files changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-o=
map.c
> index 1a766cf..cf82f89 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -37,6 +37,8 @@
> =A0#include <linux/platform_device.h>
> =A0#include <linux/clk.h>
> =A0#include <linux/io.h>
> +#include <linux/of_i2c.h>
> +#include <linux/of_device.h>
> =A0#include <linux/slab.h>
> =A0#include <linux/i2c-omap.h>
> =A0#include <linux/pm_runtime.h>
> @@ -971,6 +973,16 @@ static const struct i2c_algorithm omap_i2c_algo =
=3D {
> =A0 =A0 =A0 =A0.functionality =A0=3D omap_i2c_func,
> =A0};
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
> +
> =A0static int __devinit
> =A0omap_i2c_probe(struct platform_device *pdev)
> =A0{
> @@ -978,10 +990,13 @@ omap_i2c_probe(struct platform_device *pdev)
> =A0 =A0 =A0 =A0struct i2c_adapter =A0 =A0 =A0*adap;
> =A0 =A0 =A0 =A0struct resource =A0 =A0 =A0 =A0 *mem, *irq, *ioarea;
> =A0 =A0 =A0 =A0struct omap_i2c_bus_platform_data *pdata =3D pdev->dev=
=2Eplatform_data;
> + =A0 =A0 =A0 const struct of_device_id *match;
> =A0 =A0 =A0 =A0irq_handler_t isr;
> =A0 =A0 =A0 =A0int r;
> =A0 =A0 =A0 =A0u32 speed =3D 0;
>
> + =A0 =A0 =A0 match =3D of_match_device(omap_i2c_of_match, &pdev->dev=
);
> +
> =A0 =A0 =A0 =A0/* NOTE: driver uses the static register mapping */
> =A0 =A0 =A0 =A0mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0)=
;
> =A0 =A0 =A0 =A0if (!mem) {
> @@ -1007,14 +1022,23 @@ omap_i2c_probe(struct platform_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_release_region;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 speed =3D 100; =A0 =A0/* Default speed */
> =A0 =A0 =A0 =A0if (pdata !=3D NULL) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0speed =3D pdata->clkrate;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->set_mpu_wkup_lat =3D pdata->set_m=
pu_wkup_lat;
> - =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 speed =3D 100; =A0 =A0/* Default speed =
*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->set_mpu_wkup_lat =3D NULL;
> +#if defined(CONFIG_OF)
> + =A0 =A0 =A0 } else if (pdev->dev.of_node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 prop;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!of_property_read_u32(pdev->dev.of_=
node, "clock-frequency",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 &prop))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 speed =3D prop/100;
> +#endif
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 /* TODO: remove this after DT depencies with hwmod are =
resolved */
> + =A0 =A0 =A0 if (match)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +

Drop this hunk for the patch you're submitting to mainline.  It's okay
to have it in while you're testing, but the code that is actually
merged shouldn't have it.  We'll have a workaround for the hwmod issue
sorted out this week.  After doing this you can add:

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> =A0 =A0 =A0 =A0dev->speed =3D speed;
> =A0 =A0 =A0 =A0dev->idle =3D 1;
> =A0 =A0 =A0 =A0dev->dev =3D &pdev->dev;
> @@ -1095,6 +1119,7 @@ omap_i2c_probe(struct platform_device *pdev)
> =A0 =A0 =A0 =A0strlcpy(adap->name, "OMAP I2C adapter", sizeof(adap->n=
ame));
> =A0 =A0 =A0 =A0adap->algo =3D &omap_i2c_algo;
> =A0 =A0 =A0 =A0adap->dev.parent =3D &pdev->dev;
> + =A0 =A0 =A0 adap->dev.of_node =3D pdev->dev.of_node;
>
> =A0 =A0 =A0 =A0/* i2c device drivers may be active on return from add=
_adapter() */
> =A0 =A0 =A0 =A0adap->nr =3D pdev->id;
> @@ -1103,6 +1128,7 @@ omap_i2c_probe(struct platform_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev->dev, "failure adding adap=
ter\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_free_irq;
> =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 of_i2c_register_devices(adap);
>
> =A0 =A0 =A0 =A0return 0;
>
> @@ -1174,6 +1200,7 @@ static struct platform_driver omap_i2c_driver =3D=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "omap_i2c",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =A0=3D THIS_MODULE,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.pm =A0 =A0 =3D OMAP_I2C_PM_OPS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D omap_i2c_of_match,
> =A0 =A0 =A0 =A0},
> =A0};
>
> --
> 1.7.1
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
