From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCH v2] i2c: fix missing handling of errata I2C_OMAP3_1P153
Date: Thu, 16 Feb 2012 17:06:07 +0530
Message-ID: <CAM=Q2cvQeAcS3drwKAZxV0=FjmmJQFADQgpt0uk66jK_EPxOmA@mail.gmail.com>
References: <1328538811-13097-1-git-send-email-tasskjapp@gmail.com>
	<1329213583-20839-1-git-send-email-tasskjapp@gmail.com>
	<4F3A345B.2060308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:33156 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866Ab2BPLgI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Feb 2012 06:36:08 -0500
In-Reply-To: <4F3A345B.2060308@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tasslehoff Kjappfot <tasskjapp@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org

Hi ,

On Tue, Feb 14, 2012 at 3:45 PM, Tasslehoff Kjappfot
<tasskjapp@gmail.com> wrote:
> Sorry about the bad mails. First time I use git send-email to follow =
up on a
> patch, and it seems I need to read up a bit more on it.
>
> Anyway.
>
> This patch is tested on our custom board based on Beagleboard rev C3.
thanks for the testing . may be include it in the changelogs .
Just a suggestion not an objection to the patch.
>
> From 7c1e2c14bccb16c20dc7d93088b12ac6e6e351a3 Mon Sep 17 00:00:00 200=
1
> From: Tasslehoff Kjappfot <tasskjapp@gmail.com>
> Date: Mon, 6 Feb 2012 14:14:23 +0100
> Subject: [PATCH] i2c: fix missing handling of errata I2C_OMAP3_1P153
>
>
> i2c_prope
Nitpick :  probe



set the dev->errata flag, but omap_i2c_init cleared the flag
> again. Move the errata handling to i2c_probe.
>
> Signed-off-by: Tasslehoff Kjappfot <tasskjapp@gmail.com>
>
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
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
>
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
