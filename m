From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v6 1/3] mfd: tps65217: Add support for IRQs
Date: Mon, 12 Sep 2016 14:57:40 +0100
Message-ID: <20160912135740.GD9789@dell>
References: <20160909084204.26226-1-m.niestroj@grinn-global.com>
 <20160909084204.26226-2-m.niestroj@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160909084204.26226-2-m.niestroj@grinn-global.com>
Sender: linux-pm-owner@vger.kernel.org
To: Marcin Niestroj <m.niestroj@grinn-global.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Grygorii Strashko <grygorii.strashko@ti.com>, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, 09 Sep 2016, Marcin Niestroj wrote:

> Add support for handling IRQs: power button, AC and USB power state
> changes. Mask and interrupt bits are shared within one register, which
> prevents us to use regmap_irq implementation. New irq_domain is created in
> order to add interrupt handling for each tps65217's subsystem. IRQ
> resources have been added for charger subsystem to be able to notify about
> AC and USB state changes.
> 
> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Tested-by: Tony Lindgren <tony@atomide.com>
> ---
> Changes v4 -> v6: none
> 
> Changes v3 -> v4 (suggested by Grygorii):
>  * Add irq_set_parent() during irq init
>  * Remove hardcoded IRQ trigger type, rely on DT bindings instead
> 
> Changes v2 -> v3 (suggested by Lee):
>  * Alphabetical reorder of includes
>  * Rename enum tps65217_irqs -> tps65217_irq_type, so we won't confuse
>    it with structure object with the same name.
>  * Fix inconsistent order of irq_enable and irq_disable
>  * Remove redundant 'else' when returning from tps65217_irq_thread
> 
> Changes v1 -> v2: none
> 
>  drivers/mfd/Kconfig          |   1 +
>  drivers/mfd/tps65217.c       | 195 +++++++++++++++++++++++++++++++++++++++++--
>  include/linux/mfd/tps65217.h |  12 +++
>  3 files changed, 200 insertions(+), 8 deletions(-)

Applied, thanks.
  
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 2d1fb64..35e9c9a 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1214,6 +1214,7 @@ config MFD_TPS65217
>  	depends on I2C
>  	select MFD_CORE
>  	select REGMAP_I2C
> +	select IRQ_DOMAIN
>  	help
>  	  If you say yes here you get support for the TPS65217 series of
>  	  Power Management / White LED chips.
> diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
> index 049a6fc..41b5d59 100644
> --- a/drivers/mfd/tps65217.c
> +++ b/drivers/mfd/tps65217.c
> @@ -15,22 +15,99 @@
>   * GNU General Public License for more details.
>   */
>  
> -#include <linux/kernel.h>
>  #include <linux/device.h>
> -#include <linux/module.h>
> -#include <linux/platform_device.h>
> +#include <linux/err.h>
>  #include <linux/init.h>
> +#include <linux/interrupt.h>
>  #include <linux/i2c.h>
> -#include <linux/slab.h>
> -#include <linux/regmap.h>
> -#include <linux/err.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
>  
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/tps65217.h>
>  
> -static const struct mfd_cell tps65217s[] = {
> +static struct resource charger_resources[] = {
> +	DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_AC, "AC"),
> +	DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_USB, "USB"),
> +};
> +
> +struct tps65217_irq {
> +	int mask;
> +	int interrupt;
> +};
> +
> +static const struct tps65217_irq tps65217_irqs[] = {
> +	[TPS65217_IRQ_PB] = {
> +		.mask = TPS65217_INT_PBM,
> +		.interrupt = TPS65217_INT_PBI,
> +	},
> +	[TPS65217_IRQ_AC] = {
> +		.mask = TPS65217_INT_ACM,
> +		.interrupt = TPS65217_INT_ACI,
> +	},
> +	[TPS65217_IRQ_USB] = {
> +		.mask = TPS65217_INT_USBM,
> +		.interrupt = TPS65217_INT_USBI,
> +	},
> +};
> +
> +static void tps65217_irq_lock(struct irq_data *data)
> +{
> +	struct tps65217 *tps = irq_data_get_irq_chip_data(data);
> +
> +	mutex_lock(&tps->irq_lock);
> +}
> +
> +static void tps65217_irq_sync_unlock(struct irq_data *data)
> +{
> +	struct tps65217 *tps = irq_data_get_irq_chip_data(data);
> +	int ret;
> +
> +	ret = tps65217_reg_write(tps, TPS65217_REG_INT, tps->irq_mask,
> +				TPS65217_PROTECT_NONE);
> +	if (ret != 0)
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
> +	struct tps65217 *tps = irq_data_get_irq_chip_data(data);
> +	const struct tps65217_irq *irq_data = irq_to_tps65217_irq(tps, data);
> +
> +	tps->irq_mask &= ~irq_data->mask;
> +}
> +
> +static void tps65217_irq_disable(struct irq_data *data)
> +{
> +	struct tps65217 *tps = irq_data_get_irq_chip_data(data);
> +	const struct tps65217_irq *irq_data = irq_to_tps65217_irq(tps, data);
> +
> +	tps->irq_mask |= irq_data->mask;
> +}
> +
> +static struct irq_chip tps65217_irq_chip = {
> +	.irq_bus_lock		= tps65217_irq_lock,
> +	.irq_bus_sync_unlock	= tps65217_irq_sync_unlock,
> +	.irq_enable		= tps65217_irq_enable,
> +	.irq_disable		= tps65217_irq_disable,
> +};
> +
> +static struct mfd_cell tps65217s[] = {
>  	{
>  		.name = "tps65217-pmic",
>  		.of_compatible = "ti,tps65217-pmic",
> @@ -41,10 +118,90 @@ static const struct mfd_cell tps65217s[] = {
>  	},
>  	{
>  		.name = "tps65217-charger",
> +		.num_resources = ARRAY_SIZE(charger_resources),
> +		.resources = charger_resources,
>  		.of_compatible = "ti,tps65217-charger",
>  	},
>  };
>  
> +static irqreturn_t tps65217_irq_thread(int irq, void *data)
> +{
> +	struct tps65217 *tps = data;
> +	unsigned int status;
> +	bool handled = false;
> +	int i;
> +	int ret;
> +
> +	ret = tps65217_reg_read(tps, TPS65217_REG_INT, &status);
> +	if (ret < 0) {
> +		dev_err(tps->dev, "Failed to read IRQ status: %d\n",
> +			ret);
> +		return IRQ_NONE;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(tps65217_irqs); i++) {
> +		if (status & tps65217_irqs[i].interrupt) {
> +			handle_nested_irq(irq_find_mapping(tps->irq_domain, i));
> +			handled = true;
> +		}
> +	}
> +
> +	if (handled)
> +		return IRQ_HANDLED;
> +
> +	return IRQ_NONE;
> +}
> +
> +static int tps65217_irq_map(struct irq_domain *h, unsigned int virq,
> +			irq_hw_number_t hw)
> +{
> +	struct tps65217 *tps = h->host_data;
> +
> +	irq_set_chip_data(virq, tps);
> +	irq_set_chip_and_handler(virq, &tps65217_irq_chip, handle_edge_irq);
> +	irq_set_nested_thread(virq, 1);
> +	irq_set_parent(virq, tps->irq);
> +	irq_set_noprobe(virq);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops tps65217_irq_domain_ops = {
> +	.map = tps65217_irq_map,
> +};
> +
> +static int tps65217_irq_init(struct tps65217 *tps, int irq)
> +{
> +	int ret;
> +
> +	mutex_init(&tps->irq_lock);
> +	tps->irq = irq;
> +
> +	/* Mask all interrupt sources */
> +	tps->irq_mask = (TPS65217_INT_RESERVEDM | TPS65217_INT_PBM
> +			| TPS65217_INT_ACM | TPS65217_INT_USBM);
> +	tps65217_reg_write(tps, TPS65217_REG_INT, tps->irq_mask,
> +			TPS65217_PROTECT_NONE);
> +
> +	tps->irq_domain = irq_domain_add_linear(tps->dev->of_node,
> +		TPS65217_NUM_IRQ, &tps65217_irq_domain_ops, tps);
> +	if (!tps->irq_domain) {
> +		dev_err(tps->dev, "Could not create IRQ domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	ret = devm_request_threaded_irq(tps->dev, irq, NULL,
> +					tps65217_irq_thread, IRQF_ONESHOT,
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
> @@ -149,11 +306,22 @@ int tps65217_clear_bits(struct tps65217 *tps, unsigned int reg,
>  }
>  EXPORT_SYMBOL_GPL(tps65217_clear_bits);
>  
> +static bool tps65217_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case TPS65217_REG_INT:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  static const struct regmap_config tps65217_regmap_config = {
>  	.reg_bits = 8,
>  	.val_bits = 8,
>  
>  	.max_register = TPS65217_REG_MAX,
> +	.volatile_reg = tps65217_volatile_reg,
>  };
>  
>  static const struct of_device_id tps65217_of_match[] = {
> @@ -205,8 +373,19 @@ static int tps65217_probe(struct i2c_client *client,
>  		return ret;
>  	}
>  
> +	if (client->irq) {
> +		tps65217_irq_init(tps, client->irq);
> +	} else {
> +		int i;
> +
> +		/* Don't tell children about IRQ resources which won't fire */
> +		for (i = 0; i < ARRAY_SIZE(tps65217s); i++)
> +			tps65217s[i].num_resources = 0;
> +	}
> +
>  	ret = devm_mfd_add_devices(tps->dev, -1, tps65217s,
> -				   ARRAY_SIZE(tps65217s), NULL, 0, NULL);
> +				   ARRAY_SIZE(tps65217s), NULL, 0,
> +				   tps->irq_domain);
>  	if (ret < 0) {
>  		dev_err(tps->dev, "mfd_add_devices failed: %d\n", ret);
>  		return ret;
> diff --git a/include/linux/mfd/tps65217.h b/include/linux/mfd/tps65217.h
> index 1c88231..4ccda89 100644
> --- a/include/linux/mfd/tps65217.h
> +++ b/include/linux/mfd/tps65217.h
> @@ -73,6 +73,7 @@
>  #define TPS65217_PPATH_AC_CURRENT_MASK	0x0C
>  #define TPS65217_PPATH_USB_CURRENT_MASK	0x03
>  
> +#define TPS65217_INT_RESERVEDM		BIT(7)
>  #define TPS65217_INT_PBM		BIT(6)
>  #define TPS65217_INT_ACM		BIT(5)
>  #define TPS65217_INT_USBM		BIT(4)
> @@ -233,6 +234,13 @@ struct tps65217_bl_pdata {
>  	int dft_brightness;
>  };
>  
> +enum tps65217_irq_type {
> +	TPS65217_IRQ_PB,
> +	TPS65217_IRQ_AC,
> +	TPS65217_IRQ_USB,
> +	TPS65217_NUM_IRQ
> +};
> +
>  /**
>   * struct tps65217_board - packages regulator init data
>   * @tps65217_regulator_data: regulator initialization values
> @@ -258,6 +266,10 @@ struct tps65217 {
>  	struct regulator_desc desc[TPS65217_NUM_REGULATOR];
>  	struct regmap *regmap;
>  	u8 *strobes;
> +	struct irq_domain *irq_domain;
> +	struct mutex irq_lock;
> +	u8 irq_mask;
> +	int irq;
>  };
>  
>  static inline struct tps65217 *dev_to_tps65217(struct device *dev)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
