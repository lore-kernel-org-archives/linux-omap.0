From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] mfd: palmas: Add support for optional wakeup
Date: Fri, 29 Aug 2014 11:56:19 +0100
Message-ID: <20140829105619.GH24579@lee--X1>
References: <1408457197-30487-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1408457197-30487-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, 19 Aug 2014, Nishanth Menon wrote:

> With the recent pinctrl-single changes, omaps can treat wake-up event=
s
> from deeper idle states as interrupts.
>=20
> Let's add support for the optional second interrupt for wake-up
> events. And then SoC can wakeup and handle the event using it's
> regular handler.
>=20
> Finally, to pass the wake-up interrupt in the dts file,
> interrupts-extended property needs to be passed.
>=20
> This is similar in approach to commit 2a0b965cfb6e ("serial: omap: Ad=
d
> support for optional wake-up")
>=20
> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/mfd/palmas.txt |   20 ++++++++

DT Ack please.

>  drivers/mfd/palmas.c                             |   59 ++++++++++++=
++++++++++
>  include/linux/mfd/palmas.h                       |    2 +
>  3 files changed, 81 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/palmas.txt b/Docum=
entation/devicetree/bindings/mfd/palmas.txt
> index eda8989..2627842 100644
> --- a/Documentation/devicetree/bindings/mfd/palmas.txt
> +++ b/Documentation/devicetree/bindings/mfd/palmas.txt
> @@ -51,3 +51,23 @@ palmas {
>  		....
>  	};
>  }
> +
> +Example: with interrupts extended
> + See Documentation/devicetree/bindings/interrupt-controller/interrup=
ts.txt
> + Use pinmux 0x418 as wakeup interrupt and gpio1_0 as interrupt sourc=
e
> +
> +palmas {

Should this be 'palmas@40 {'?

> +	compatible =3D "ti,twl6035", "ti,palmas";
> +	reg =3D <0x48>
> +	interrupt-parent =3D <&intc>;
> +	interrupt-controller;
> +	#interrupt-cells =3D <2>;
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
> +	interrupts-extended =3D <&gpio1 0 IRQ_TYPE_LEVEL_HIGH
> +			       &pinmux 0x418>;

Can I get a DT Ack, that this is being used correctly?  It doesn't
match the syntax given in:

  Documentation/devicetree/bindings/interrupt-controller/interrupts.txt

> +	pmic {
> +		compatible =3D "ti,twl6035-pmic", "ti,palmas-pmic";
> +		....
> +	};
> +}
> diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
> index 28cb048..11186ab 100644
> --- a/drivers/mfd/palmas.c
> +++ b/drivers/mfd/palmas.c
> @@ -24,6 +24,7 @@
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/palmas.h>
>  #include <linux/of_device.h>
> +#include <linux/of_irq.h>
> =20
>  static const struct regmap_config palmas_regmap_config[PALMAS_NUM_CL=
IENTS] =3D {
>  	{
> @@ -326,6 +327,16 @@ static struct regmap_irq_chip tps65917_irq_chip =
=3D {
>  			PALMAS_INT1_MASK),
>  };
> =20
> +static irqreturn_t palmas_wake_irq(int irq, void *_palmas)
> +{
> +	/*
> +	 * Return Not handled so that interrupt is disabled.
> +	 * Level event ensures that the event is eventually handled
> +	 * by the appropriate chip handler already registered
> +	 */

This looks okay to me, but could do with a second opinion from someone
who is a little more familier with this kind of h/w.

How does this differ from threading IRQs?

> +	return IRQ_NONE;
> +}
> +
>  int palmas_ext_control_req_config(struct palmas *palmas,
>  	enum palmas_external_requestor_id id,  int ext_ctrl, bool enable)
>  {
> @@ -409,6 +420,7 @@ static void palmas_dt_to_pdata(struct i2c_client =
*i2c,
>  		pdata->mux_from_pdata =3D 1;
>  		pdata->pad2 =3D prop;
>  	}
> +	pdata->wakeirq =3D irq_of_parse_and_map(node, 1);
> =20
>  	/* The default for this register is all masked */
>  	ret =3D of_property_read_u32(node, "ti,power-ctrl", &prop);
> @@ -521,6 +533,7 @@ static int palmas_i2c_probe(struct i2c_client *i2=
c,
>  	i2c_set_clientdata(i2c, palmas);
>  	palmas->dev =3D &i2c->dev;
>  	palmas->irq =3D i2c->irq;
> +	palmas->wakeirq =3D pdata->wakeirq;
> =20
>  	match =3D of_match_device(of_palmas_match_tbl, &i2c->dev);
> =20
> @@ -587,6 +600,22 @@ static int palmas_i2c_probe(struct i2c_client *i=
2c,
>  	if (ret < 0)
>  		goto err_i2c;
> =20
> +	if (!palmas->wakeirq)
> +		goto no_wake_irq;
> +
> +	ret =3D devm_request_irq(palmas->dev, palmas->wakeirq,
> +			       palmas_wake_irq,
> +			       IRQF_ONESHOT | pdata->irq_flags,
> +			       dev_name(palmas->dev),
> +			       &palmas);
> +	if (ret < 0)
> +		goto err_i2c;
> +
> +	/* We use wakeirq only during suspend-resume path */
> +	device_set_wakeup_capable(palmas->dev, true);
> +	disable_irq_nosync(palmas->wakeirq);
> +
> +no_wake_irq:
>  no_irq:
>  	slave =3D PALMAS_BASE_TO_SLAVE(PALMAS_PU_PD_OD_BASE);
>  	addr =3D PALMAS_BASE_TO_REG(PALMAS_PU_PD_OD_BASE,
> @@ -706,6 +735,34 @@ static int palmas_i2c_remove(struct i2c_client *=
i2c)
>  	return 0;
>  }
> =20
> +static int palmas_i2c_suspend(struct i2c_client *i2c,  pm_message_t =
mesg)
> +{
> +	struct palmas *palmas =3D i2c_get_clientdata(i2c);
> +	struct device *dev =3D &i2c->dev;
> +
> +	if (!palmas->wakeirq)
> +		return 0;
> +
> +	if (device_may_wakeup(dev))
> +		enable_irq(palmas->wakeirq);
> +
> +	return 0;
> +}
> +
> +static int palmas_i2c_resume(struct i2c_client *i2c)
> +{
> +	struct palmas *palmas =3D i2c_get_clientdata(i2c);
> +	struct device *dev =3D &i2c->dev;
> +
> +	if (!palmas->wakeirq)
> +		return 0;
> +
> +	if (device_may_wakeup(dev))
> +		disable_irq_nosync(palmas->wakeirq);
> +
> +	return 0;
> +}
> +
>  static const struct i2c_device_id palmas_i2c_id[] =3D {
>  	{ "palmas", },
>  	{ "twl6035", },
> @@ -721,6 +778,8 @@ static struct i2c_driver palmas_i2c_driver =3D {
>  		   .of_match_table =3D of_palmas_match_tbl,
>  		   .owner =3D THIS_MODULE,
>  	},
> +	.suspend =3D palmas_i2c_suspend,
> +	.resume =3D palmas_i2c_resume,
>  	.probe =3D palmas_i2c_probe,
>  	.remove =3D palmas_i2c_remove,
>  	.id_table =3D palmas_i2c_id,
> diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
> index fb0390a..e8cf4c2 100644
> --- a/include/linux/mfd/palmas.h
> +++ b/include/linux/mfd/palmas.h
> @@ -75,6 +75,7 @@ struct palmas {
>  	/* IRQ Data */
>  	int irq;
>  	u32 irq_mask;
> +	int wakeirq;
>  	struct mutex irq_lock;
>  	struct regmap_irq_chip_data *irq_data;
> =20
> @@ -377,6 +378,7 @@ struct palmas_clk_platform_data {
> =20
>  struct palmas_platform_data {
>  	int irq_flags;
> +	int wakeirq;
>  	int gpio_base;
> =20
>  	/* bit value to be loaded to the POWER_CTRL register */

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
