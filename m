From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/3] mfd: menelaus: drop support for SW controller VCORE
Date: Mon, 30 Mar 2015 08:15:14 +0100
Message-ID: <20150330071514.GI457@x1>
References: <1427575537-28508-1-git-send-email-aaro.koskinen@iki.fi>
 <1427575537-28508-3-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35254 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752949AbbC3HPT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Mar 2015 03:15:19 -0400
Received: by wicne17 with SMTP id ne17so18807274wic.0
        for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2015 00:15:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1427575537-28508-3-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

On Sat, 28 Mar 2015, Aaro Koskinen wrote:

> Drop support for SW controlled VCORE, nobody uses it.
>=20
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  drivers/mfd/menelaus.c       | 23 -----------------------
>  include/linux/mfd/menelaus.h |  1 -
>  2 files changed, 24 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
> index 9f01aef..917fa86 100644
> --- a/drivers/mfd/menelaus.c
> +++ b/drivers/mfd/menelaus.c
> @@ -532,29 +532,6 @@ static const struct menelaus_vtg_value vcore_val=
ues[] =3D {
>  	{ 1450, 18 },
>  };
> =20
> -int menelaus_set_vcore_sw(unsigned int mV)
> -{
> -	int val, ret;
> -	struct i2c_client *c =3D the_menelaus->client;
> -
> -	val =3D menelaus_get_vtg_value(mV, vcore_values,
> -				     ARRAY_SIZE(vcore_values));
> -	if (val < 0)
> -		return -EINVAL;
> -
> -	dev_dbg(&c->dev, "Setting VCORE to %d mV (val 0x%02x)\n", mV, val);
> -
> -	/* Set SW mode and the voltage in one go. */
> -	mutex_lock(&the_menelaus->lock);
> -	ret =3D menelaus_write_reg(MENELAUS_VCORE_CTRL1, val);
> -	if (ret =3D=3D 0)
> -		the_menelaus->vcore_hw_mode =3D 0;
> -	mutex_unlock(&the_menelaus->lock);
> -	msleep(1);
> -
> -	return ret;
> -}
> -
>  int menelaus_set_vcore_hw(unsigned int roof_mV, unsigned int floor_m=
V)
>  {
>  	int fval, rval, val, ret;
> diff --git a/include/linux/mfd/menelaus.h b/include/linux/mfd/menelau=
s.h
> index a1e12bf3..9e85ac0 100644
> --- a/include/linux/mfd/menelaus.h
> +++ b/include/linux/mfd/menelaus.h
> @@ -24,7 +24,6 @@ extern int menelaus_set_vaux(unsigned int mV);
>  extern int menelaus_set_vdcdc(int dcdc, unsigned int mV);
>  extern int menelaus_set_slot_sel(int enable);
>  extern int menelaus_get_slot_pin_states(void);
> -extern int menelaus_set_vcore_sw(unsigned int mV);
>  extern int menelaus_set_vcore_hw(unsigned int roof_mV, unsigned int =
floor_mV);
> =20
>  #define EN_VPLL_SLEEP	(1 << 7)

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
