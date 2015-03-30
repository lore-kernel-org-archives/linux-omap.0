From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: twl6040: Remove wrong and unneeded
 "platform:twl6040" modalias
Date: Mon, 30 Mar 2015 11:08:04 +0100
Message-ID: <20150330100804.GW457@x1>
References: <1427703175.30616.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:33827 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685AbbC3KIK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Mar 2015 06:08:10 -0400
Received: by wibg7 with SMTP id g7so87407523wib.1
        for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2015 03:08:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1427703175.30616.1.camel@phoenix>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, Jorge Eduardo Candelaria <jorge.candelaria@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 30 Mar 2015, Axel Lin wrote:

> This is a I2C driver, so it's wrong to use platform prefix for the
> modalias. We have all needed i2c aliases coming form MODULE_DEVICE_TA=
BLE,
> so let's remove the wrong and unneeded "platform:twl6040" modalias.
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/mfd/twl6040.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

> diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
> index f71ee3d..c5265c1 100644
> --- a/drivers/mfd/twl6040.c
> +++ b/drivers/mfd/twl6040.c
> @@ -814,4 +814,3 @@ MODULE_DESCRIPTION("TWL6040 MFD");
>  MODULE_AUTHOR("Misael Lopez Cruz <misael.lopez@ti.com>");
>  MODULE_AUTHOR("Jorge Eduardo Candelaria <jorge.candelaria@ti.com>");
>  MODULE_LICENSE("GPL");
> -MODULE_ALIAS("platform:twl6040");

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
