From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [RESEND/PATCHv5 1/2] drivers: input: keypad: Add device tree support
Date: Tue, 19 Jun 2012 19:55:44 +0530
Message-ID: <CAKdam56W025H_0MKMcX_7h61n7FQ7ZEbAG_SYWOU5Tj=nRDbEQ@mail.gmail.com>
References: <1339152780-25301-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:45816 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750998Ab2FSOZr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jun 2012 10:25:47 -0400
Received: by bkvi18 with SMTP id i18so6450869bkv.13
        for <linux-omap@vger.kernel.org>; Tue, 19 Jun 2012 07:25:45 -0700 (PDT)
In-Reply-To: <1339152780-25301-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, sourav.poddar@ti.com, Andrew Morton <akpm@linux-foundation.org>, Benoit Cousson <b-cousson@ti.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Dmitry Torokhov <dtor@mail.ru>, Randy Dunlap <rdunlap@xenotime.net>, lo <linux-omap@vger.kernel.org>

+cc linux-omap

On Fri, Jun 8, 2012 at 4:22 PM, Sourav Poddar <sourav.poddar@ti.com> wr=
ote:
> Update the Documentation with omap4 keypad device tree
> binding information.
> Add device tree support for omap4 keypad driver.
>
> Tested on omap4430 sdp.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Dmitry Torokhov <dtor@mail.ru>
> Cc: Randy Dunlap <rdunlap@xenotime.net>
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> ---
> changes since v4:
> - Developed it on top of dmitry's 'next' branch due to
> dependency on generic "matrix_keypad_build_keymap" api
> patches queued in that branch
> - Adapted the driver to fill "keymap" in device tree
> using "matrix_keypad_build_keymap" api defined in
> drivers/input/matrix-keymap.c
> =A0.../devicetree/bindings/input/omap-keypad.txt =A0 =A0 =A0| =A0 31 =
++++++
> =A0drivers/input/keyboard/omap4-keypad.c =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0108 +++++++++++++++-----
> =A02 files changed, 111 insertions(+), 28 deletions(-)
> =A0create mode 100644 Documentation/devicetree/bindings/input/omap-ke=
ypad.txt
>
> diff --git a/Documentation/devicetree/bindings/input/omap-keypad.txt =
b/Documentation/devicetree/bindings/input/omap-keypad.txt
> new file mode 100644
> index 0000000..722425b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/omap-keypad.txt
> @@ -0,0 +1,31 @@
> +* TI's Keypad Controller device tree bindings
> +
> +TI's Keypad controller is used to interface a SoC with a matrix-type
> +keypad device. The keypad controller supports multiple row and colum=
n lines.
> +A key can be placed at each intersection of a unique row and a uniqu=
e column.
> +The keypad controller can sense a key-press and key-release and repo=
rt the
> +event using a interrupt to the cpu.
> +
> +Required SoC Specific Properties:
> +- compatible: should be one of the following
> + =A0 - "ti,omap4-keypad": For controllers compatible with omap4 keyp=
ad
> + =A0 =A0 =A0controller.
> +
> +Required Board Specific Properties, in addition to those specified b=
y
> +the shared matrix-keyboard bindings:
> +- keypad,num-rows: Number of row lines connected to the keypad
> + =A0controller.
> +
> +- keypad,num-columns: Number of column lines connected to the
> + =A0keypad controller.
> +
> +Optional Properties specific to linux:
> +- linux,keypad-no-autorepeat: do no enable autorepeat feature.
> +
> +Example:
> + =A0 =A0 =A0 =A0keypad@4ae1c000{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "ti,omap4-keypad";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0keypad,num-rows =3D <2>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0keypad,num-columns =3D <8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 linux,keypad-no-autorepeat;
> + =A0 =A0 =A0 };
> diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/ke=
yboard/omap4-keypad.c
> index aed5f69..d5a2d1a 100644
> --- a/drivers/input/keyboard/omap4-keypad.c
> +++ b/drivers/input/keyboard/omap4-keypad.c
> @@ -27,6 +27,7 @@
> =A0#include <linux/platform_device.h>
> =A0#include <linux/errno.h>
> =A0#include <linux/io.h>
> +#include <linux/of.h>
> =A0#include <linux/input.h>
> =A0#include <linux/slab.h>
> =A0#include <linux/pm_runtime.h>
> @@ -75,6 +76,7 @@ enum {
>
> =A0struct omap4_keypad {
> =A0 =A0 =A0 =A0struct input_dev *input;
> + =A0 =A0 =A0 struct matrix_keymap_data *keymap_data;
>
> =A0 =A0 =A0 =A0void __iomem *base;
> =A0 =A0 =A0 =A0unsigned int irq;
> @@ -84,6 +86,7 @@ struct omap4_keypad {
> =A0 =A0 =A0 =A0u32 reg_offset;
> =A0 =A0 =A0 =A0u32 irqreg_offset;
> =A0 =A0 =A0 =A0unsigned int row_shift;
> + =A0 =A0 =A0 bool no_autorepeat;
> =A0 =A0 =A0 =A0unsigned char key_state[8];
> =A0 =A0 =A0 =A0unsigned short keymap[];
> =A0};
> @@ -208,25 +211,74 @@ static void omap4_keypad_close(struct input_dev=
 *input)
> =A0 =A0 =A0 =A0pm_runtime_put_sync(input->dev.parent);
> =A0}
>
> +static struct omap4_keypad *omap_keypad_parse_dt(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint32_=
t rows, uint32_t cols,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
input_dev *input_dev)
> +{
> + =A0 =A0 =A0 struct device_node *np =3D dev->of_node;
> + =A0 =A0 =A0 struct platform_device *pdev =3D to_platform_device(dev=
);
> + =A0 =A0 =A0 struct omap4_keypad *keypad_data =3D platform_get_drvda=
ta(pdev);
> + =A0 =A0 =A0 int error;
> +
> + =A0 =A0 =A0 error =3D matrix_keypad_build_keymap(NULL, "linux,keyma=
p",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rows, c=
ols, keypad_data->keymap, input_dev);
> + =A0 =A0 =A0 if (error) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to build ke=
ymap\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_free_device(input_dev);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (of_get_property(np, "linux,input-no-autorepeat", NU=
LL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->no_autorepeat =3D true;
> +
> + =A0 =A0 =A0 return keypad_data;
> +}
> +
> =A0static int __devinit omap4_keypad_probe(struct platform_device *pd=
ev)
> =A0{
> + =A0 =A0 =A0 struct device *dev =3D &pdev->dev;
> + =A0 =A0 =A0 struct device_node *np =3D dev->of_node;
> =A0 =A0 =A0 =A0const struct omap4_keypad_platform_data *pdata;
> =A0 =A0 =A0 =A0struct omap4_keypad *keypad_data;
> =A0 =A0 =A0 =A0struct input_dev *input_dev;
> =A0 =A0 =A0 =A0struct resource *res;
> =A0 =A0 =A0 =A0resource_size_t size;
> - =A0 =A0 =A0 unsigned int row_shift, max_keys;
> + =A0 =A0 =A0 unsigned int row_shift =3D 0, max_keys =3D 0;
> + =A0 =A0 =A0 uint32_t num_rows =3D 0, num_cols =3D 0;
> =A0 =A0 =A0 =A0int rev;
> =A0 =A0 =A0 =A0int irq;
> =A0 =A0 =A0 =A0int error;
>
> =A0 =A0 =A0 =A0/* platform data */
> =A0 =A0 =A0 =A0pdata =3D pdev->dev.platform_data;
> - =A0 =A0 =A0 if (!pdata) {
> + =A0 =A0 =A0 if (np) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_property_read_u32(np, "keypad,num-ro=
ws", &num_rows);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_property_read_u32(np, "keypad,num-co=
lumns", &num_cols);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!num_rows || !num_cols) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "nu=
mber of keypad rows/columns not specified\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 } else if (pdata) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 num_rows =3D pdata->rows;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 num_cols =3D pdata->cols;
> + =A0 =A0 =A0 } else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev, "no platform data =
defined\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 row_shift =3D get_count_order(num_cols);
> + =A0 =A0 =A0 max_keys =3D num_rows << row_shift;
> +
> + =A0 =A0 =A0 keypad_data =3D devm_kzalloc(dev, sizeof(struct omap4_k=
eypad) +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_keys * sizeof(keypa=
d_data->keymap[0]),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KER=
NEL);
> +
> + =A0 =A0 =A0 if (!keypad_data) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "keypad_data memory=
 allocation failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 platform_set_drvdata(pdev, keypad_data);
> +
> =A0 =A0 =A0 =A0res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0)=
;
> =A0 =A0 =A0 =A0if (!res) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev, "no base address s=
pecified\n");
> @@ -239,22 +291,6 @@ static int __devinit omap4_keypad_probe(struct p=
latform_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (!pdata->keymap_data) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no keymap data def=
ined\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 row_shift =3D get_count_order(pdata->cols);
> - =A0 =A0 =A0 max_keys =3D pdata->rows << row_shift;
> -
> - =A0 =A0 =A0 keypad_data =3D kzalloc(sizeof(struct omap4_keypad) +
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_key=
s * sizeof(keypad_data->keymap[0]),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL)=
;
> - =A0 =A0 =A0 if (!keypad_data) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "keypad_data memory=
 allocation failed\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> - =A0 =A0 =A0 }
> -
> =A0 =A0 =A0 =A0size =3D resource_size(res);
>
> =A0 =A0 =A0 =A0res =3D request_mem_region(res->start, size, pdev->nam=
e);
> @@ -271,10 +307,10 @@ static int __devinit omap4_keypad_probe(struct =
platform_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_release_mem;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 keypad_data->rows =3D num_rows;
> + =A0 =A0 =A0 keypad_data->cols =3D num_cols;
> =A0 =A0 =A0 =A0keypad_data->irq =3D irq;
> =A0 =A0 =A0 =A0keypad_data->row_shift =3D row_shift;
> - =A0 =A0 =A0 keypad_data->rows =3D pdata->rows;
> - =A0 =A0 =A0 keypad_data->cols =3D pdata->cols;
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0* Enable clocks for the keypad module so that we can r=
ead
> @@ -322,15 +358,25 @@ static int __devinit omap4_keypad_probe(struct =
platform_device *pdev)
> =A0 =A0 =A0 =A0input_dev->open =3D omap4_keypad_open;
> =A0 =A0 =A0 =A0input_dev->close =3D omap4_keypad_close;
>
> - =A0 =A0 =A0 error =3D matrix_keypad_build_keymap(pdata->keymap_data=
, NULL,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0pdata->rows, pdata->cols,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0keypad_data->keymap, input_dev);
> - =A0 =A0 =A0 if (error) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to build ke=
ymap\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_input;
> + =A0 =A0 =A0 if (np) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data =3D omap_keypad_parse_dt(&p=
dev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_=
data->rows, keypad_data->cols,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_d=
ev);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->keymap_data =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (struct matrix_keymap_d=
ata *)pdata->keymap_data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D matrix_keypad_build_keymap(ke=
ypad_data->keymap_data,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL, k=
eypad_data->rows, keypad_data->cols,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_=
data->keymap, input_dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (error) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "fa=
iled to build keymap\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_input;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 __set_bit(EV_REP, input_dev->evbit);
> + =A0 =A0 =A0 if (!keypad_data->no_autorepeat)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(EV_REP, input_dev->evbit);
> +
> =A0 =A0 =A0 =A0input_set_capability(input_dev, EV_MSC, MSC_SCAN);
>
> =A0 =A0 =A0 =A0input_set_drvdata(input_dev, keypad_data);
> @@ -351,7 +397,6 @@ static int __devinit omap4_keypad_probe(struct pl=
atform_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_pm_disable;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 platform_set_drvdata(pdev, keypad_data);
> =A0 =A0 =A0 =A0return 0;
>
> =A0err_pm_disable:
> @@ -392,12 +437,19 @@ static int __devexit omap4_keypad_remove(struct=
 platform_device *pdev)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +static const struct of_device_id omap_keypad_dt_match[] =3D {
> + =A0 =A0 =A0 { .compatible =3D "ti,omap4-keypad" },
> + =A0 =A0 =A0 {},
> +};
> +MODULE_DEVICE_TABLE(of, omap_keypad_dt_match);
> +
> =A0static struct platform_driver omap4_keypad_driver =3D {
> =A0 =A0 =A0 =A0.probe =A0 =A0 =A0 =A0 =A0=3D omap4_keypad_probe,
> =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D __devexit_p(omap4_keypad_r=
emove),
> =A0 =A0 =A0 =A0.driver =A0 =A0 =A0 =A0 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "omap4-keypad",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D of_match_ptr(omap_k=
eypad_dt_match),
> =A0 =A0 =A0 =A0},
> =A0};
> =A0module_platform_driver(omap4_keypad_driver);
> --
> 1.7.1
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
