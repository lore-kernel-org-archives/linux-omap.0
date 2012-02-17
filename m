From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCH v3] i2c: fix missing handling of errata I2C_OMAP3_1P153
Date: Fri, 17 Feb 2012 18:10:07 +0530
Message-ID: <CAM=Q2ctw8ps6a+cNRihoTFu+95hyOt0Et+qXbgxmwmRAED7B7g@mail.gmail.com>
References: <1328538811-13097-1-git-send-email-tasskjapp@gmail.com>
	<1329213583-20839-1-git-send-email-tasskjapp@gmail.com>
	<4F3A345B.2060308@gmail.com>
	<CAM=Q2cvQeAcS3drwKAZxV0=FjmmJQFADQgpt0uk66jK_EPxOmA@mail.gmail.com>
	<4F3E45D1.3070405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:43846 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606Ab2BQMkI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Feb 2012 07:40:08 -0500
In-Reply-To: <4F3E45D1.3070405@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tasslehoff Kjappfot <tasskjapp@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org

Hello,


On Fri, Feb 17, 2012 at 5:49 PM, Tasslehoff Kjappfot
<tasskjapp@gmail.com> wrote:
> From 0195dcf606b0ad069d8b5bc56cb877ff65ebea22 Mon Sep 17 00:00:00 200=
1
>
> From: Tasslehoff Kjappfot <tasskjapp@gmail.com>
> Date: Mon, 6 Feb 2012 14:14:23 +0100
> Subject: [PATCH] i2c: fix missing handling of errata I2C_OMAP3_1P153
>
> i2c_probe set the dev->errata flag, but omap_i2c_init cleared the fla=
g
> again. Move the errata handling to i2c_probe.
>
Looks good to me.
Reviewed-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>
> Signed-off-by: Tasslehoff Kjappfot <tasskjapp@gmail.com>
> ---
> =A0drivers/i2c/busses/i2c-omap.c | =A0 10 +++++-----
> =A01 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-o=
map.c
> index 801df60..d609ae2 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -468,11 +468,6 @@ static int omap_i2c_init(struct omap_i2c_dev *de=
v)
> =A0 =A0 =A0 =A0/* Take the I2C module out of reset: */
> =A0 =A0 =A0 =A0omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON=
_EN);
>
> - =A0 =A0 =A0 dev->errata =3D 0;
> -
> - =A0 =A0 =A0 if (dev->flags & OMAP_I2C_FLAG_APPLY_ERRATA_I207)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->errata |=3D I2C_OMAP_ERRATA_I207;
> -
> =A0 =A0 =A0 =A0/* Enable interrupts */
> =A0 =A0 =A0 =A0dev->iestate =3D (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY =
|
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_I2C_IE_ARDY | OMA=
P_I2C_IE_NACK |
> @@ -1058,6 +1053,11 @@ omap_i2c_probe(struct platform_device *pdev)
>
> =A0 =A0 =A0 =A0dev->rev =3D omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) =
& 0xff;
>
> + =A0 =A0 =A0 dev->errata =3D 0;
> +
> + =A0 =A0 =A0 if (dev->flags & OMAP_I2C_FLAG_APPLY_ERRATA_I207)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->errata |=3D I2C_OMAP_ERRATA_I207;
> +
> =A0 =A0 =A0 =A0if (dev->rev <=3D OMAP_I2C_REV_ON_3430)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->errata |=3D I2C_OMAP3_1P153;
>
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" =
in
>
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
