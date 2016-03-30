From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 4/8] mfd: Add TWL6030 power driver, with minimal support
 for power off
Date: Wed, 30 Mar 2016 18:56:18 +0300
Message-ID: <56FBF722.5060803@ti.com>
References: <1459279341-17389-1-git-send-email-contact@paulk.fr>
 <1459279341-17389-4-git-send-email-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1459279341-17389-4-git-send-email-contact@paulk.fr>
Sender: linux-pm-owner@vger.kernel.org
To: Paul Kocialkowski <contact@paulk.fr>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-omap@vger.kernel.org

On 03/29/2016 10:22 PM, Paul Kocialkowski wrote:
> This adds a TWL6030 power driver, that currently only supports powering off the
> device when the TWL is used as system power controller.
>
> This driver might be extended to support more power-related features of the
> TWL6030.
>
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>   .../devicetree/bindings/mfd/twl6030-power.txt      |  31 +++++++
>   drivers/mfd/Kconfig                                |  10 ++
>   drivers/mfd/Makefile                               |   5 +-
>   drivers/mfd/twl-core.c                             |   8 ++
>   drivers/mfd/twl6030-power.c                        | 102 +++++++++++++++++++++

Seems proper place for this driver is drivers/power/reset.


>   5 files changed, 154 insertions(+), 2 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/mfd/twl6030-power.txt
>   create mode 100644 drivers/mfd/twl6030-power.c
>
> diff --git a/Documentation/devicetree/bindings/mfd/twl6030-power.txt b/Documentation/devicetree/bindings/mfd/twl6030-power.txt
> new file mode 100644
> index 0000000..97600e7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/twl6030-power.txt
> @@ -0,0 +1,31 @@
> +Texas Instruments TWL family (twl6030) reset and power management module
> +
> +For now, the binding only supports the complete shutdown of the system after
> +poweroff.
> +
> +Required properties:
> +- compatible : must be
> +	"ti,twl6030-power"
> +
> +Optional properties:
> +
> +- ti,system-power-controller: This indicates that TWL6030 is the
> +  power supply master of the system. With this flag, the chip will
> +  initiate an ACTIVE-to-OFF or SLEEP-to-OFF transition when the
> +  system poweroffs.
> +
> +Example:
> +&i2c1 {
> +	clock-frequency = <2600000>;
> +
> +	twl: twl@48 {
> +		reg = <0x48>;
> +		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
> +		interrupt-parent = <&intc>;
> +
> +		twl_power: power {
> +			compatible = "ti,twl6030-power";
> +			ti,system-power-controller;
> +		};
> +	};
> +};
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 28bfe3d..a0a8012 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1301,6 +1301,16 @@ config MFD_TWL4030_AUDIO
>   	select MFD_CORE
>   	default n
>
> +config TWL6030_POWER
> +	bool "TI TWL6030 power resources"
> +	depends on TWL_CORE && ARM
> +	help
> +	  Say yes here if you want to use the power resources on the
> +	  TWL6030 family chips.
> +
> +	  When used as system power controller, this driver allows turning off
> +	  the main power supply.
> +
>   config TWL6040_CORE
>   	bool "TI TWL6040 audio codec"
>   	depends on I2C=y
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 7daeab5..5aa16c8 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -81,9 +81,10 @@ obj-$(CONFIG_MFD_TPS65912_SPI)  += tps65912-spi.o
>   obj-$(CONFIG_MFD_TPS80031)	+= tps80031.o
>   obj-$(CONFIG_MENELAUS)		+= menelaus.o
>
> -obj-$(CONFIG_TWL_CORE)	+= twl-core.o twl4030-irq.o twl6030-irq.o
> -obj-$(CONFIG_TWL4030_POWER)    += twl4030-power.o
> +obj-$(CONFIG_TWL_CORE)		+= twl-core.o twl4030-irq.o twl6030-irq.o
> +obj-$(CONFIG_TWL4030_POWER)	+= twl4030-power.o
>   obj-$(CONFIG_MFD_TWL4030_AUDIO)	+= twl4030-audio.o
> +obj-$(CONFIG_TWL6030_POWER)	+= twl6030-power.o
>   obj-$(CONFIG_TWL6040_CORE)	+= twl6040.o
>
>   obj-$(CONFIG_MFD_MX25_TSADC)	+= fsl-imx25-tsadc.o
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index dae52f7..74372bc 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -972,6 +972,14 @@ add_children(struct twl_platform_data *pdata, unsigned irq_base,
>   			return PTR_ERR(child);
>   	}
>
> +	if (IS_ENABLED(CONFIG_TWL6030_POWER) && pdata->power) {
> +		child = add_child(TWL_MODULE_PM_MASTER, "twl6030_power",
> +				  pdata->power, sizeof(*pdata->power), false,
> +				  0, 0);
> +		if (IS_ERR(child))
> +			return PTR_ERR(child);
> +	}
> +

non-DT boot option is not supported for twl6030 any more and
all related code was removed already.

>   	return 0;
>   }
>
> diff --git a/drivers/mfd/twl6030-power.c b/drivers/mfd/twl6030-power.c
> new file mode 100644
> index 0000000..a0bb6d8
> --- /dev/null
> +++ b/drivers/mfd/twl6030-power.c
> @@ -0,0 +1,102 @@
> +/*
> + * TWL6030 power
> + *
> + * Copyright (C) 2016 Paul Kocialkowski <contact@paulk.fr>
> + *
> + * This file is subject to the terms and conditions of the GNU General
> + * Public License. See the file "COPYING" in the main directory of this
> + * archive for more details.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

I think header should look different now (but not sure).

> + */
> +
> +#include <linux/module.h>
> +#include <linux/pm.h>
> +#include <linux/i2c/twl.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +
> +#define TWL6030_PHOENIX_DEV_ON		0x25
> +
> +#define TWL6030_PHOENIX_APP_DEVOFF	(1 << 0)
> +#define TWL6030_PHOENIX_CON_DEVOFF	(1 << 1)
> +#define TWL6030_PHOENIX_MOD_DEVOFF	(1 << 2)
> +
> +void twl6030_power_off(void)
> +{
> +	int err;
> +
> +	err = twl_i2c_write_u8(TWL6030_MODULE_ID0, TWL6030_PHOENIX_APP_DEVOFF |
> +		TWL6030_PHOENIX_CON_DEVOFF | TWL6030_PHOENIX_MOD_DEVOFF,
> +		TWL6030_PHOENIX_DEV_ON);
> +	if (err)
> +		pr_err("TWL6030 Unable to power off\n");
> +}
> +
> +static bool twl6030_power_use_poweroff(const struct twl_power_data *pdata,
> +	struct device_node *node)
> +{
> +	if (pdata && pdata->use_poweroff)
> +		return true;

the same comment as above - only DT support for this PMIC as of now.

> +
> +	if (of_property_read_bool(node, "ti,system-power-controller"))
> +		return true;
> +
> +	return false;
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id twl6030_power_of_match[] = {
> +	{
> +		.compatible = "ti,twl6030-power",
> +	},
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, twl6030_power_of_match);
> +#endif	/* CONFIG_OF */
> +
> +static int twl6030_power_probe(struct platform_device *pdev)
> +{
> +	const struct twl_power_data *pdata = dev_get_platdata(&pdev->dev);
> +	struct device_node *node = pdev->dev.of_node;
> +
> +	if (!pdata && !node) {
> +		dev_err(&pdev->dev, "Platform data is missing\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Board has to be wired properly to use this feature */
> +	if (twl6030_power_use_poweroff(pdata, node) && !pm_power_off)
> +		pm_power_off = twl6030_power_off;
> +
> +	return 0;
> +}
> +
> +static int twl6030_power_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +static struct platform_driver twl6030_power_driver = {
> +	.driver = {
> +		.name	= "twl6030_power",
> +		.of_match_table = of_match_ptr(twl6030_power_of_match),
> +	},
> +	.probe		= twl6030_power_probe,
> +	.remove		= twl6030_power_remove,
> +};
> +
> +module_platform_driver(twl6030_power_driver);
> +
> +MODULE_AUTHOR("Paul Kocialkowski <contact@paulk.fr>");
> +MODULE_DESCRIPTION("Power management for TWL6030");
> +MODULE_LICENSE("GPL");
>


-- 
regards,
-grygorii
