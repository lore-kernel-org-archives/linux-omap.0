From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/5] mfd: twl-core: Fix passing of platform data in the
 device tree case
Date: Mon, 18 Nov 2013 10:29:07 +0000
Message-ID: <20131118102907.GC13640@lee--X1>
References: <1384562167-14725-1-git-send-email-tony@atomide.com>
 <1384562167-14725-2-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:52666 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754Ab3KRK3L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Nov 2013 05:29:11 -0500
Received: by mail-ob0-f178.google.com with SMTP id va2so6819895obc.9
        for <linux-omap@vger.kernel.org>; Mon, 18 Nov 2013 02:29:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1384562167-14725-2-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

> Since we still need to rely on a mix of device tree initialized
> drivers and legacy platform data initialize drivers, let's fix
> the passing of platform data to twl4030-gpio.
>=20
> As the twl4030 GPIO is initialized by twl-core.c, we need to register
> the auxdata for twl4030 GPIO in twl-core.c.
>=20
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>=20
> Samuel & Lee, I'd like to merge this fix via arm-soc tree if this loo=
ks
> OK to you as I have other patches that depend on this.
>=20
> ---
>  drivers/mfd/twl-core.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index 29473c2..d5b3dd8 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -1133,6 +1133,11 @@ static int twl_remove(struct i2c_client *clien=
t)
>  	return 0;
>  }
> =20
> +static struct of_dev_auxdata twl_auxdata_lookup[] =3D {
> +	OF_DEV_AUXDATA("ti,twl4030-gpio", 0, "twl4030-gpio", NULL),
> +	{ /* sentinel */ },
> +};
> +
>  /* NOTE: This driver only handles a single twl4030/tps659x0 chip */
>  static int
>  twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
> @@ -1271,10 +1276,14 @@ twl_probe(struct i2c_client *client, const st=
ruct i2c_device_id *id)
>  		twl_i2c_write_u8(TWL4030_MODULE_INTBR, temp, REG_GPPUPDCTR1);
>  	}
> =20
> -	if (node)
> -		status =3D of_platform_populate(node, NULL, NULL, &client->dev);
> -	else
> +	if (node) {
> +		if (pdata)
> +			twl_auxdata_lookup[0].platform_data =3D pdata->gpio;
> +		status =3D of_platform_populate(node, NULL, twl_auxdata_lookup,
> +					      &client->dev);
> +	} else {
>  		status =3D add_children(pdata, irq_base, id->driver_data);

Why doesn't the TWL driver use the MFD framework for this stuff?

> +	}
> =20
>  fail:
>  	if (status < 0)

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
