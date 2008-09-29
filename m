From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [i2c] [PATCH 8/8] i2c-omap: Clean-up i2c-omap
Date: Mon, 29 Sep 2008 23:31:25 +0100
Message-ID: <20080929223125.GV2716@fluff.org.uk>
References: <1222329234-31473-1-git-send-email-tony@atomide.com> <1222329234-31473-2-git-send-email-tony@atomide.com> <1222329234-31473-3-git-send-email-tony@atomide.com> <1222329234-31473-4-git-send-email-tony@atomide.com> <1222329234-31473-5-git-send-email-tony@atomide.com> <1222329234-31473-6-git-send-email-tony@atomide.com> <1222329234-31473-7-git-send-email-tony@atomide.com> <1222329234-31473-8-git-send-email-tony@atomide.com> <1222329234-31473-9-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from aeryn.fluff.org.uk ([87.194.8.8]:51865 "EHLO
	kira.home.fluff.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751713AbYI2Wbc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 18:31:32 -0400
Content-Disposition: inline
In-Reply-To: <1222329234-31473-9-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: i2c@lm-sensors.org, linux-omap@vger.kernel.org

On Thu, Sep 25, 2008 at 10:53:54AM +0300, Tony Lindgren wrote:
> Minor checkpatch and formatting clean-up. Also update copyrights.

looks ok, assuming it doesn't get broken by any changes
from the review comments i've made earlier in the series.
=20
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |   28 ++++++++++++++++------------
>  1 files changed, 16 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-o=
map.c
> index 5c54864..a41b655 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -2,13 +2,15 @@
>   * TI OMAP I2C master mode driver
>   *
>   * Copyright (C) 2003 MontaVista Software, Inc.
> - * Copyright (C) 2004 Texas Instruments.
> - *
> - * Updated to work with multiple I2C interfaces on 24xx by
> - * Tony Lindgren <tony@atomide.com> and Imre Deak <imre.deak@nokia.c=
om>
>   * Copyright (C) 2005 Nokia Corporation
> + * Copyright (C) 2004 - 2007 Texas Instruments.
>   *
> - * Cleaned up by Juha Yrj=C3=B6l=C3=A4 <juha.yrjola@nokia.com>
> + * Originally written by MontaVista Software, Inc.
> + * Additional contributions by:
> + *	Tony Lindgren <tony@atomide.com>
> + *	Imre Deak <imre.deak@nokia.com>
> + *	Juha Yrj=C3=B6l=C3=A4 <juha.yrjola@nokia.com>
> + *	Syed Khasim <x0khasim@ti.com>
>   *
>   * This program is free software; you can redistribute it and/or mod=
ify
>   * it under the terms of the GNU General Public License as published=
 by
> @@ -33,8 +35,7 @@
>  #include <linux/completion.h>
>  #include <linux/platform_device.h>
>  #include <linux/clk.h>
> -
> -#include <asm/io.h>
> +#include <linux/io.h>
> =20
>  /* timeout waiting for the controller to respond */
>  #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
> @@ -215,7 +216,7 @@ static void omap_i2c_idle(struct omap_i2c_dev *de=
v)
>  	dev->iestate =3D omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
>  	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
>  	if (dev->rev1)
> -		iv =3D omap_i2c_read_reg(dev, OMAP_I2C_IV_REG);	/* Read clears */
> +		iv =3D omap_i2c_read_reg(dev, OMAP_I2C_IV_REG); /* Read clears */
>  	else
>  		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, dev->iestate);
>  	/*
> @@ -334,9 +335,9 @@ static int omap_i2c_init(struct omap_i2c_dev *dev=
)
> =20
>  	/* Enable interrupts */
>  	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG,
> -			   (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
> -			    OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
> -			    OMAP_I2C_IE_AL)  | ((dev->fifo_size) ?
> +			(OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
> +			OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
> +			OMAP_I2C_IE_AL)  | ((dev->fifo_size) ?
>  				(OMAP_I2C_IE_RDR | OMAP_I2C_IE_XDR) : 0));
>  	return 0;
>  }
> @@ -402,8 +403,10 @@ static int omap_i2c_xfer_msg(struct i2c_adapter =
*adap,
>  		w |=3D OMAP_I2C_CON_XA;
>  	if (!(msg->flags & I2C_M_RD))
>  		w |=3D OMAP_I2C_CON_TRX;
> +
>  	if (!dev->b_hw && stop)
>  		w |=3D OMAP_I2C_CON_STP;
> +
>  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
> =20
>  	/*
> @@ -476,7 +479,8 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2=
c_msg msgs[], int num)
> =20
>  	omap_i2c_unidle(dev);
> =20
> -	if ((r =3D omap_i2c_wait_for_bb(dev)) < 0)
> +	r =3D omap_i2c_wait_for_bb(dev);
> +	if (r < 0)
>  		goto out;
> =20
>  	for (i =3D 0; i < num; i++) {
> --=20
> 1.5.6.rc3.21.g8c6b5
>=20
>=20

> _______________________________________________
> i2c mailing list
> i2c@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/i2c

--=20
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
