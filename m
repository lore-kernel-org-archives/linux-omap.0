From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 1/5] mfd: tps65217: Add support for IRQs
Date: Wed, 15 Jun 2016 16:13:58 +0100
Message-ID: <20160615151358.GL4948@dell>
References: <20160614132927.3309-1-m.niestroj@grinn-global.com>
 <20160614132927.3309-2-m.niestroj@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160614132927.3309-2-m.niestroj@grinn-global.com>
Sender: linux-input-owner@vger.kernel.org
To: Marcin Niestroj <m.niestroj@grinn-global.com>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, 14 Jun 2016, Marcin Niestroj wrote:

> Add support for handling IRQs: power button, AC and USB power state
> changes. Mask and interrupt bits are shared within one register, whic=
h
> prevents us to use regmap_irq implementation. New irq_domain is creat=
ed in
> order to add interrupt handling for each tps65217's subsystem. IRQ
> resources have been added for charger subsystem to be able to notify =
about
> AC and USB state changes.
>=20
> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
> ---
>  drivers/mfd/Kconfig          |   1 +
>  drivers/mfd/tps65217.c       | 182 +++++++++++++++++++++++++++++++++=
+++++++++-
>  include/linux/mfd/tps65217.h |  11 +++
>  3 files changed, 192 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 1bcf601..f8c9580 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1200,6 +1200,7 @@ config MFD_TPS65217
>  	depends on I2C
>  	select MFD_CORE
>  	select REGMAP_I2C
> +	select IRQ_DOMAIN
>  	help
>  	  If you say yes here you get support for the TPS65217 series of
>  	  Power Management / White LED chips.
> diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
> index 049a6fc..d49f94e 100644
> --- a/drivers/mfd/tps65217.c
> +++ b/drivers/mfd/tps65217.c
> @@ -23,6 +23,9 @@
>  #include <linux/i2c.h>
>  #include <linux/slab.h>
>  #include <linux/regmap.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>

Header includes should be alphabetical.

Please take the opportunity to recorder them.

>  #include <linux/err.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> @@ -30,7 +33,81 @@
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/tps65217.h>
> =20
> -static const struct mfd_cell tps65217s[] =3D {
> +static struct resource charger_resources[] =3D {
> +	DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_AC, "AC"),
> +	DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_USB, "USB"),
> +};
> +
> +struct tps65217_irq {
> +	int mask;
> +	int interrupt;
> +};
> +
> +static const struct tps65217_irq tps65217_irqs[] =3D {

Not sure how this compiles, since you have this struct and the enums
in the header named the same.  Better to differentiate between them.

> +	[TPS65217_IRQ_PB] =3D {
> +		.mask =3D TPS65217_INT_PBM,
> +		.interrupt =3D TPS65217_INT_PBI,
> +	},
> +	[TPS65217_IRQ_AC] =3D {
> +		.mask =3D TPS65217_INT_ACM,
> +		.interrupt =3D TPS65217_INT_ACI,
> +	},
> +	[TPS65217_IRQ_USB] =3D {
> +		.mask =3D TPS65217_INT_USBM,
> +		.interrupt =3D TPS65217_INT_USBI,
> +	},
> +};
> +
> +static void tps65217_irq_lock(struct irq_data *data)
> +{
> +	struct tps65217 *tps =3D irq_data_get_irq_chip_data(data);
> +
> +	mutex_lock(&tps->irq_lock);
> +}
> +
> +static void tps65217_irq_sync_unlock(struct irq_data *data)
> +{
> +	struct tps65217 *tps =3D irq_data_get_irq_chip_data(data);
> +	int ret;
> +
> +	ret =3D tps65217_reg_write(tps, TPS65217_REG_INT, tps->irq_mask,
> +				TPS65217_PROTECT_NONE);
> +	if (ret !=3D 0)
> +		dev_err(tps->dev, "Failed to sync IRQ masks\n");
> +
> +	mutex_unlock(&tps->irq_lock);
> +}
> +
> +static const inline struct tps65217_irq *
> +irq_to_tps65217_irq(struct tps65217 *tps, struct irq_data *data)
> +{
> +	return &tps65217_irqs[data->hwirq];
> +}
> +
> +static void tps65217_irq_enable(struct irq_data *data)
> +{
> +	struct tps65217 *tps =3D irq_data_get_irq_chip_data(data);
> +	const struct tps65217_irq *irq_data =3D irq_to_tps65217_irq(tps, da=
ta);
> +
> +	tps->irq_mask &=3D ~irq_data->mask;
> +}
> +
> +static void tps65217_irq_disable(struct irq_data *data)
> +{
> +	struct tps65217 *tps =3D irq_data_get_irq_chip_data(data);
> +	const struct tps65217_irq *irq_data =3D irq_to_tps65217_irq(tps, da=
ta);
> +
> +	tps->irq_mask |=3D irq_data->mask;
> +}

Nit: Swap this with enable, either here or in the struct below.

> +static struct irq_chip tps65217_irq_chip =3D {
> +	.irq_bus_lock		=3D tps65217_irq_lock,
> +	.irq_bus_sync_unlock	=3D tps65217_irq_sync_unlock,
> +	.irq_disable		=3D tps65217_irq_disable,
> +	.irq_enable		=3D tps65217_irq_enable,
> +};
> +
> +static struct mfd_cell tps65217s[] =3D {
>  	{
>  		.name =3D "tps65217-pmic",
>  		.of_compatible =3D "ti,tps65217-pmic",
> @@ -41,10 +118,89 @@ static const struct mfd_cell tps65217s[] =3D {
>  	},
>  	{
>  		.name =3D "tps65217-charger",
> +		.num_resources =3D ARRAY_SIZE(charger_resources),
> +		.resources =3D charger_resources,
>  		.of_compatible =3D "ti,tps65217-charger",
>  	},
>  };
> =20
> +static irqreturn_t tps65217_irq_thread(int irq, void *data)
> +{
> +	struct tps65217 *tps =3D data;
> +	unsigned int status;
> +	bool handled =3D false;
> +	int i;
> +	int ret;
> +
> +	ret =3D tps65217_reg_read(tps, TPS65217_REG_INT, &status);
> +	if (ret < 0) {
> +		dev_err(tps->dev, "Failed to read IRQ status: %d\n",
> +			ret);
> +		return IRQ_NONE;
> +	}
> +
> +	for (i =3D 0; i < ARRAY_SIZE(tps65217_irqs); i++) {
> +		if (status & tps65217_irqs[i].interrupt) {
> +			handle_nested_irq(irq_find_mapping(tps->irq_domain, i));
> +			handled =3D true;
> +		}
> +	}
> +
> +	if (handled)
> +		return IRQ_HANDLED;
> +	else
> +		return IRQ_NONE;

The else is kinda redundant here.

=2E.. and I think it's possible to get a warning saying something about
coming to the end of a non-void function.

> +}
> +
> +static int tps65217_irq_map(struct irq_domain *h, unsigned int virq,
> +			irq_hw_number_t hw)
> +{
> +	struct tps65217 *tps =3D h->host_data;
> +
> +	irq_set_chip_data(virq, tps);
> +	irq_set_chip_and_handler(virq, &tps65217_irq_chip, handle_edge_irq)=
;
> +	irq_set_nested_thread(virq, 1);
> +	irq_set_noprobe(virq);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops tps65217_irq_domain_ops =3D {
> +	.map =3D tps65217_irq_map,
> +};
> +
> +static int tps65217_irq_init(struct tps65217 *tps, int irq)
> +{
> +	int ret;
> +
> +	mutex_init(&tps->irq_lock);
> +
> +	/* Mask all interrupt sources */
> +	tps->irq_mask =3D (TPS65217_INT_RESERVEDM | TPS65217_INT_PBM
> +			| TPS65217_INT_ACM | TPS65217_INT_USBM);
> +	tps65217_reg_write(tps, TPS65217_REG_INT, tps->irq_mask,
> +			TPS65217_PROTECT_NONE);
> +
> +	tps->irq_domain =3D irq_domain_add_linear(tps->dev->of_node,

I think it's suggested that you use *add_simple() these days.

> +		TPS65217_NUM_IRQ, &tps65217_irq_domain_ops, tps);
> +	if (!tps->irq_domain) {
> +		dev_err(tps->dev, "Could not create IRQ domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	ret =3D devm_request_threaded_irq(tps->dev, irq, NULL,
> +					tps65217_irq_thread,
> +					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +					"tps65217-irq", tps);
> +	if (ret) {
> +		dev_err(tps->dev, "Failed to request IRQ %d: %d\n",
> +			irq, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * tps65217_reg_read: Read a single tps65217 register.
>   *
> @@ -149,11 +305,22 @@ int tps65217_clear_bits(struct tps65217 *tps, u=
nsigned int reg,
>  }
>  EXPORT_SYMBOL_GPL(tps65217_clear_bits);
> =20
> +static bool tps65217_volatile_reg(struct device *dev, unsigned int r=
eg)
> +{
> +	switch (reg) {
> +	case TPS65217_REG_INT:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  static const struct regmap_config tps65217_regmap_config =3D {
>  	.reg_bits =3D 8,
>  	.val_bits =3D 8,
> =20
>  	.max_register =3D TPS65217_REG_MAX,
> +	.volatile_reg =3D tps65217_volatile_reg,
>  };
> =20
>  static const struct of_device_id tps65217_of_match[] =3D {
> @@ -205,8 +372,19 @@ static int tps65217_probe(struct i2c_client *cli=
ent,
>  		return ret;
>  	}
> =20
> +	if (client->irq) {
> +		tps65217_irq_init(tps, client->irq);
> +	} else {
> +		int i;
> +
> +		/* Don't tell children about IRQ resources which won't fire */
> +		for (i =3D 0; i < ARRAY_SIZE(tps65217s); i++)
> +			tps65217s[i].num_resources =3D 0;
> +	}
> +
>  	ret =3D devm_mfd_add_devices(tps->dev, -1, tps65217s,
> -				   ARRAY_SIZE(tps65217s), NULL, 0, NULL);
> +				   ARRAY_SIZE(tps65217s), NULL, 0,
> +				   tps->irq_domain);
>  	if (ret < 0) {
>  		dev_err(tps->dev, "mfd_add_devices failed: %d\n", ret);
>  		return ret;
> diff --git a/include/linux/mfd/tps65217.h b/include/linux/mfd/tps6521=
7.h
> index ac7fba4..f80a5d3 100644
> --- a/include/linux/mfd/tps65217.h
> +++ b/include/linux/mfd/tps65217.h
> @@ -73,6 +73,7 @@
>  #define TPS65217_PPATH_AC_CURRENT_MASK	0x0C
>  #define TPS65217_PPATH_USB_CURRENT_MASK	0x03
> =20
> +#define TPS65217_INT_RESERVEDM		BIT(7)
>  #define TPS65217_INT_PBM		BIT(6)
>  #define TPS65217_INT_ACM		BIT(5)
>  #define TPS65217_INT_USBM		BIT(4)
> @@ -233,6 +234,13 @@ struct tps65217_bl_pdata {
>  	int dft_brightness;
>  };
> =20
> +enum tps65217_irqs {
> +	TPS65217_IRQ_PB,
> +	TPS65217_IRQ_AC,
> +	TPS65217_IRQ_USB,
> +	TPS65217_NUM_IRQ
> +};
> +
>  /**
>   * struct tps65217_board - packages regulator init data
>   * @tps65217_regulator_data: regulator initialization values
> @@ -257,6 +265,9 @@ struct tps65217 {
>  	unsigned long id;
>  	struct regulator_desc desc[TPS65217_NUM_REGULATOR];
>  	struct regmap *regmap;
> +	struct irq_domain *irq_domain;
> +	struct mutex irq_lock;
> +	u8 irq_mask;
>  };
> =20
>  static inline struct tps65217 *dev_to_tps65217(struct device *dev)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
