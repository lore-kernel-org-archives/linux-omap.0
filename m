From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/4] MFD: TPS65218: Add driver for the TPS65218 PMIC
Date: Tue, 3 Dec 2013 09:24:10 +0000
Message-ID: <20131203092410.GD11828@lee--X1>
References: <1386053006-6480-1-git-send-email-j-keerthy@ti.com>
 <1386053006-6480-3-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:63297 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab3LCJYV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Dec 2013 04:24:21 -0500
Received: by mail-ie0-f177.google.com with SMTP id tp5so22373222ieb.8
        for <linux-omap@vger.kernel.org>; Tue, 03 Dec 2013 01:24:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1386053006-6480-3-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, rob@landley.net, sameo@linux.intel.com, grant.likely@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

> The TPS65218 chip is a power management IC for Portable Navigation Sy=
stems
> and Tablet Computing devices. It contains the following components:
>=20
>  - Regulators.
>  - Over Temperature warning and Shut down.
>=20
> This patch adds support for tps65218 mfd device. At this time only
> the regulator functionality is made available.
>=20
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/mfd/Kconfig          |   14 ++
>  drivers/mfd/Makefile         |    1 +
>  drivers/mfd/tps65218.c       |  281 ++++++++++++++++++++++++++++++++=
+++++++++
>  include/linux/mfd/tps65218.h |  288 ++++++++++++++++++++++++++++++++=
++++++++++

<snip>

> +config MFD_TPS65218
> +	tristate "TI TPS65218 Power Management chips"
> +	depends on I2C
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	help
> +	  If you say yes here you get support for the TPS65218 series of
> +	  Power Management chips.
> +	  These include voltage regulators, gpio and other features
> +	  that are often used in portable devices.

Perhaps you should add a note that only the regulator component is
currently supported.

<snip>

> new file mode 100644
> index 0000000..8c61640
> --- /dev/null
> +++ b/drivers/mfd/tps65218.c
> @@ -0,0 +1,281 @@
> +/*
> + * TPS65218 chip family multi-function driver

Instead of calling it an MFD driver (is there such a thing?) I think
you should mention its true purpose, as per the datasheet.

<snip>

> +static const struct of_device_id of_tps65218_match_table[] =3D {
> +	{ .compatible =3D "ti,tps65218", },
> +	{ /* end */ }

I think the end comment is superfluous.

However, if you _really_ want to put something in there, I dislike
"/* Sentinel */" the least.

> +static int tps65218_probe(struct i2c_client *client,
> +				const struct i2c_device_id *ids)
> +{

<snip>

> +	ret =3D of_platform_populate(client->dev.of_node, NULL, NULL,
> +				   &client->dev);

What are you trying to do here?

Register each regulator as a platform device?

<snip>

> +static const struct i2c_device_id tps65218_id_table[] =3D {
> +	{"tps65218", TPS65218},
> +};

This has a different structure to of_tps65218_match_table, please
ensure they're the same. I prefer spaces after '{' and before '}'.

<snip>

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
