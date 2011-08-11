From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 2/3] twl4030-madc: turn on the MADC clock
Date: Thu, 11 Aug 2011 12:55:26 +0300
Message-ID: <CANOLnOM8fuAuas7eWG=qUi20SW2NE_BJQwqHcZbf9SEHpxggvw@mail.gmail.com>
References: <1313033272-16774-1-git-send-email-kyle@kylemanna.com>
	<1313033272-16774-3-git-send-email-kyle@kylemanna.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f170.google.com ([209.85.210.170]:59999 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754492Ab1HKJz1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Aug 2011 05:55:27 -0400
Received: by iye16 with SMTP id 16so984842iye.1
        for <linux-omap@vger.kernel.org>; Thu, 11 Aug 2011 02:55:27 -0700 (PDT)
In-Reply-To: <1313033272-16774-3-git-send-email-kyle@kylemanna.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kyle Manna <kyle@kylemanna.com>
Cc: linux-omap@vger.kernel.org

This one needs to go to mfd maintainer too.

On Thu, Aug 11, 2011 at 6:27 AM, Kyle Manna <kyle@kylemanna.com> wrote:
> Without turning the MADC clock on, no MADC conversions occur.
>
> $ cat /sys/class/hwmon/hwmon0/device/in8_input
> [ =A0 53.428436] twl4030_madc twl4030_madc: conversion timeout!
> cat: read error: Resource temporarily unavailable
>
> Signed-off-by: Kyle Manna <kyle@kylemanna.com>
> ---
> =A0drivers/mfd/twl4030-madc.c =A0 =A0 =A0 | =A0 22 ++++++++++++++++++=
++++
> =A0include/linux/i2c/twl4030-madc.h | =A0 =A04 ++++
> =A02 files changed, 26 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mfd/twl4030-madc.c b/drivers/mfd/twl4030-madc.c
> index 8ef7801..75040b4 100644
> --- a/drivers/mfd/twl4030-madc.c
> +++ b/drivers/mfd/twl4030-madc.c
> @@ -740,6 +740,28 @@ static int __devinit twl4030_madc_probe(struct p=
latform_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TWL4030_BCI_BCICTL1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_i2c;
> =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 /* Check that MADC clock is on */
> + =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL4030_MODULE_INTBR, &regval, =
TWL4030_REG_GPBR1);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "unable to read reg=
 GPBR1 0x%X\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TWL4030=
_REG_GPBR1);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* If MADC clk is not on, turn it on */
> + =A0 =A0 =A0 if (!(regval & TWL4030_GPBR1_MADC_HFCLK_EN)) {

You should check if above read failed before using regval - you might
end up writing trash to GPBR1..

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&pdev->dev, "clk disabled, ena=
bling\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval |=3D TWL4030_GPBR1_MADC_HFCLK_EN=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL4030_MODULE=
_INTBR, regval,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0TWL4030_REG_GPBR1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "un=
able to write reg GPBR1 0x%X\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 TWL4030_REG_GPBR1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_i2c;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> +

Single newline is enough.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
