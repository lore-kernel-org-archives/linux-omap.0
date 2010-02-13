From: Mike Rapoport <mike.rapoport@gmail.com>
Subject: Re: [PATCH v2] Input: ads7846: add regulator support
Date: Sat, 13 Feb 2010 21:40:26 +0200
Message-ID: <f870da181002131140q45c91251mdd19f51bf5c9c9d7@mail.gmail.com>
References: <1266078714-18155-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f201.google.com ([209.85.223.201]:57863 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905Ab0BMTk1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Feb 2010 14:40:27 -0500
In-Reply-To: <1266078714-18155-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org

Just one nitpicking comment below:

On Sat, Feb 13, 2010 at 6:31 PM, Grazvydas Ignotas <notasas@gmail.com> =
wrote:
> The ADS7846/TSC2046 touchscreen controllers can (and usually are)
> connected to various regulators for power, so add regulator support.
>
> Valid regulator will now be required, so boards without complete
> regulator setup should either disable regulator framework or enable
> CONFIG_REGULATOR_DUMMY.
>
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---
> =A0drivers/input/touchscreen/ads7846.c | =A0 28 +++++++++++++++++++++=
++++++-
> =A01 files changed, 27 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touc=
hscreen/ads7846.c
> index 52d2ca1..8b05d8e 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -27,6 +27,7 @@
> =A0#include <linux/gpio.h>
> =A0#include <linux/spi/spi.h>
> =A0#include <linux/spi/ads7846.h>
> +#include <linux/regulator/consumer.h>
> =A0#include <asm/irq.h>
>
> =A0/*
> @@ -85,6 +86,7 @@ struct ads7846 {
> =A0 =A0 =A0 =A0char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0name[32];
>
> =A0 =A0 =A0 =A0struct spi_device =A0 =A0 =A0 *spi;
> + =A0 =A0 =A0 struct regulator =A0 =A0 =A0 =A0*reg;
>
> =A0#if defined(CONFIG_HWMON) || defined(CONFIG_HWMON_MODULE)
> =A0 =A0 =A0 =A0struct attribute_group =A0*attr_group;
> @@ -788,6 +790,8 @@ static void ads7846_disable(struct ads7846 *ts)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 regulator_disable(ts->reg);
> +
> =A0 =A0 =A0 =A0/* we know the chip's in lowpower mode since we always
> =A0 =A0 =A0 =A0 * leave it that way after every request
> =A0 =A0 =A0 =A0 */
> @@ -799,6 +803,8 @@ static void ads7846_enable(struct ads7846 *ts)
> =A0 =A0 =A0 =A0if (!ts->disabled)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> + =A0 =A0 =A0 regulator_enable(ts->reg);
> +
> =A0 =A0 =A0 =A0ts->disabled =3D 0;
> =A0 =A0 =A0 =A0ts->irq_disabled =3D 0;
> =A0 =A0 =A0 =A0enable_irq(ts->spi->irq);
> @@ -1139,6 +1145,19 @@ static int __devinit ads7846_probe(struct spi_=
device *spi)
>
> =A0 =A0 =A0 =A0ts->last_msg =3D m;
>
> + =A0 =A0 =A0 ts->reg =3D regulator_get(&spi->dev, "vcc");

"vcc" is way too generic name. What about "vcc-ts" or "vcc-touch"?

> + =A0 =A0 =A0 if (IS_ERR(ts->reg)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&spi->dev, "unable to get regul=
ator: %ld\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PTR_ERR(ts->reg));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_gpio;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 err =3D regulator_enable(ts->reg);
> + =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&spi->dev, "unable to enable re=
gulator: %d\n", err);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_put_regulator;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0if (request_irq(spi->irq, ads7846_irq, IRQF_TRIGGER_FA=
LLING,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spi->dev.driver->name,=
 ts)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_info(&spi->dev,
> @@ -1148,7 +1167,7 @@ static int __devinit ads7846_probe(struct spi_d=
evice *spi)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sp=
i->dev.driver->name, ts);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&spi->dev, "ir=
q %d busy?\n", spi->irq);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_gpio;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_disable_regula=
tor;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> @@ -1180,6 +1199,10 @@ static int __devinit ads7846_probe(struct spi_=
device *spi)
> =A0 =A0 =A0 =A0ads784x_hwmon_unregister(spi, ts);
> =A0err_free_irq:
> =A0 =A0 =A0 =A0free_irq(spi->irq, ts);
> + err_disable_regulator:
> + =A0 =A0 =A0 regulator_disable(ts->reg);
> + err_put_regulator:
> + =A0 =A0 =A0 regulator_put(ts->reg);
> =A0err_free_gpio:
> =A0 =A0 =A0 =A0if (ts->gpio_pendown !=3D -1)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpio_free(ts->gpio_pendown);
> @@ -1208,6 +1231,9 @@ static int __devexit ads7846_remove(struct spi_=
device *spi)
> =A0 =A0 =A0 =A0/* suspend left the IRQ disabled */
> =A0 =A0 =A0 =A0enable_irq(ts->spi->irq);
>
> + =A0 =A0 =A0 regulator_disable(ts->reg);
> + =A0 =A0 =A0 regulator_put(ts->reg);
> +
> =A0 =A0 =A0 =A0if (ts->gpio_pendown !=3D -1)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpio_free(ts->gpio_pendown);
>
> --
> 1.6.3.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
	Sincerely Yours,
		Mike.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
