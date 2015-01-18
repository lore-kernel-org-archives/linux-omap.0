From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/5] mfd: tps65218: make INT1 our status_base register
Date: Sun, 18 Jan 2015 09:52:39 +0000
Message-ID: <20150118095239.GB3574@x1>
References: <1419622104-25812-1-git-send-email-balbi@ti.com>
 <1419622104-25812-3-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:44337 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276AbbARJwp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 18 Jan 2015 04:52:45 -0500
Received: by mail-ie0-f177.google.com with SMTP id at20so2635829iec.8
        for <linux-omap@vger.kernel.org>; Sun, 18 Jan 2015 01:52:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1419622104-25812-3-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, stable@vger.kernel.org, Keerthy <j-keerthy@ti.com>

On Fri, 26 Dec 2014, Felipe Balbi wrote:

> If we don't tell regmap-irq that our first status
> register is at offset 1, it will try to read offset
> zero, which is the chipid register.
>=20
> Fixes: 44b4dc6 mfd: tps65218: Add driver for the TPS65218 PMIC
> Cc: <stable@vger.kernel.org> # v3.15+
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/mfd/tps65218.c | 1 +
>  1 file changed, 1 insertion(+)

Sorry for the delay.  It's difficult to get a WiFi signal 2000m up in
an Austrian mountain. :)

Applied now, thanks.

> diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
> index 2243f75..d6b7643 100644
> --- a/drivers/mfd/tps65218.c
> +++ b/drivers/mfd/tps65218.c
> @@ -204,6 +204,7 @@ static struct regmap_irq_chip tps65218_irq_chip =3D=
 {
> =20
>  	.num_regs =3D 2,
>  	.mask_base =3D TPS65218_REG_INT_MASK1,
> +	.status_base =3D TPS65218_REG_INT1,
>  };
> =20
>  static const struct of_device_id of_tps65218_match_table[] =3D {

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
