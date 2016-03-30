From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 7/8] input: misc: Add TWL6030 power button support to
 twl-pwrbutton
Date: Wed, 30 Mar 2016 19:16:24 +0300
Message-ID: <56FBFBD8.7010401@ti.com>
References: <1459279341-17389-1-git-send-email-contact@paulk.fr>
 <1459279341-17389-7-git-send-email-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459279341-17389-7-git-send-email-contact@paulk.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Kocialkowski <contact@paulk.fr>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-omap@vger.kernel.org

On 03/29/2016 10:22 PM, Paul Kocialkowski wrote:
> This renames the twl4030-pwrbutton driver to twl-pwrbutton, since power button
> handling is very similar on most TWL chips. This also introduces TWL6030 power
> button support.
> 
> TWL6030 power button support requires the following additional changes:
> * Devicetree binding and support
> * Interrupt unmasking and remasking support

Again. pls, do not mix clean up/beautification and adding new features.
And don't mix DT changes with code changes.

> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>   .../devicetree/bindings/input/twl-pwrbutton.txt    |  22 ++++
>   .../bindings/input/twl4030-pwrbutton.txt           |  21 ---
>   arch/arm/boot/dts/twl6030.dtsi                     |   5 +
>   arch/arm/configs/omap2plus_defconfig               |   2 +-
>   drivers/input/misc/Kconfig                         |   8 +-
>   drivers/input/misc/Makefile                        |   2 +-
>   drivers/input/misc/twl-pwrbutton.c                 | 143 +++++++++++++++++++++
>   drivers/input/misc/twl4030-pwrbutton.c             | 116 -----------------
>   drivers/mfd/twl-core.c                             |  12 +-
>   include/linux/i2c/twl.h                            |   1 +
>   10 files changed, 187 insertions(+), 145 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/input/twl-pwrbutton.txt
>   delete mode 100644 Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt
>   create mode 100644 drivers/input/misc/twl-pwrbutton.c
>   delete mode 100644 drivers/input/misc/twl4030-pwrbutton.c
> 
> diff --git a/Documentation/devicetree/bindings/input/twl-pwrbutton.txt b/Documentation/devicetree/bindings/input/twl-pwrbutton.txt
> new file mode 100644
> index 0000000..4931be4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/twl-pwrbutton.txt
> @@ -0,0 +1,22 @@
> +Texas Instruments TWL family pwrbutton module
> +
> +This module is part of a TWL chip. For more details about the whole
> +chip see Documentation/devicetree/bindings/mfd/twl-familly.txt.
> +
> +This module provides a simple power button event via an Interrupt.
> +
> +Required properties:
> +- compatible: should be one of the following
> +   - "ti,twl4030-pwrbutton": For controllers compatible with twl4030
> +   - "ti,twl6030-pwrbutton": For controllers compatible with twl6030
> +- interrupts: should be one of the following
> +   - <8>: For controllers compatible with the twl
> +
> +Example:
> +
> +&twl {
> +	twl_pwrbutton: pwrbutton {
> +		compatible = "ti,twl4030-pwrbutton";
> +		interrupts = <8>;
> +	};
> +};
> diff --git a/Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt b/Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt
> deleted file mode 100644
> index c864a46..0000000
> --- a/Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -Texas Instruments TWL family (twl4030) pwrbutton module
> -
> -This module is part of the TWL4030. For more details about the whole
> -chip see Documentation/devicetree/bindings/mfd/twl-familly.txt.
> -
> -This module provides a simple power button event via an Interrupt.
> -
> -Required properties:
> -- compatible: should be one of the following
> -   - "ti,twl4030-pwrbutton": For controllers compatible with twl4030
> -- interrupts: should be one of the following
> -   - <8>: For controllers compatible with twl4030
> -
> -Example:
> -
> -&twl {
> -	twl_pwrbutton: pwrbutton {
> -		compatible = "ti,twl4030-pwrbutton";
> -		interrupts = <8>;
> -	};
> -};
> diff --git a/arch/arm/boot/dts/twl6030.dtsi b/arch/arm/boot/dts/twl6030.dtsi
> index 55eb35f..6a52df1 100644
> --- a/arch/arm/boot/dts/twl6030.dtsi
> +++ b/arch/arm/boot/dts/twl6030.dtsi
> @@ -99,4 +99,9 @@
>   		compatible = "ti,twl6030-pwmled";
>   		#pwm-cells = <2>;
>   	};
> +
> +	twl_pwrbutton: pwrbutton {
> +		compatible = "ti,twl6030-pwrbutton";
> +		interrupts = <0>;
> +	};
>   };
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index 156bc88..ff9752a 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -217,7 +217,7 @@ CONFIG_TOUCHSCREEN_TSC2007=m
>   CONFIG_TOUCHSCREEN_TI_AM335X_TSC=m
>   CONFIG_INPUT_MISC=y
>   CONFIG_INPUT_TPS65218_PWRBUTTON=m
> -CONFIG_INPUT_TWL4030_PWRBUTTON=m
> +CONFIG_INPUT_TWL_PWRBUTTON=m
>   CONFIG_INPUT_PALMAS_PWRBUTTON=m
>   CONFIG_SERIO=m
>   # CONFIG_LEGACY_PTYS is not set
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 6abb6df..f643e14 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -459,15 +459,15 @@ config INPUT_AXP20X_PEK
>   	  be called axp20x-pek.
>   
>   
> -config INPUT_TWL4030_PWRBUTTON
> -	tristate "TWL4030 Power button Driver"
> +config INPUT_TWL_PWRBUTTON
> +	tristate "TWL Power button Driver"
>   	depends on TWL_CORE
>   	help
>   	  Say Y here if you want to enable power key reporting via the
> -	  TWL4030 family of chips.
> +	  TWL family of chips.
>   
>   	  To compile this driver as a module, choose M here. The module will
> -	  be called twl4030_pwrbutton.
> +	  be called twl_pwrbutton.
>   
>   config INPUT_TWL4030_VIBRA
>   	tristate "Support for TWL4030 Vibrator"
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 0357a08..f77f5e7 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -66,7 +66,7 @@ obj-$(CONFIG_INPUT_SIRFSOC_ONKEY)	+= sirfsoc-onkey.o
>   obj-$(CONFIG_INPUT_SOC_BUTTON_ARRAY)	+= soc_button_array.o
>   obj-$(CONFIG_INPUT_SPARCSPKR)		+= sparcspkr.o
>   obj-$(CONFIG_INPUT_TPS65218_PWRBUTTON)	+= tps65218-pwrbutton.o
> -obj-$(CONFIG_INPUT_TWL4030_PWRBUTTON)	+= twl4030-pwrbutton.o
> +obj-$(CONFIG_INPUT_TWL_PWRBUTTON)	+= twl-pwrbutton.o
>   obj-$(CONFIG_INPUT_TWL4030_VIBRA)	+= twl4030-vibra.o
>   obj-$(CONFIG_INPUT_TWL6040_VIBRA)	+= twl6040-vibra.o
>   obj-$(CONFIG_INPUT_UINPUT)		+= uinput.o
> diff --git a/drivers/input/misc/twl-pwrbutton.c b/drivers/input/misc/twl-pwrbutton.c
> new file mode 100644
> index 0000000..a7bc8ad
> --- /dev/null
> +++ b/drivers/input/misc/twl-pwrbutton.c
> @@ -0,0 +1,143 @@
> +/**
> + * twl4030-pwrbutton.c - TWL4030 Power Button Input Driver
> + *
> + * Copyright (C) 2008-2009 Nokia Corporation
> + *
> + * Written by Peter De Schrijver <peter.de-schrijver@nokia.com>
> + * Several fixes by Felipe Balbi <felipe.balbi@nokia.com>
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
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/i2c/twl.h>
> +
> +#define PWR_PWRON_IRQ (1 << 0)
> +
> +#define TWL4030_STS_HW_CONDITIONS 0x0f
> +#define TWL6030_STS_HW_CONDITIONS 0x21
> +
> +static irqreturn_t powerbutton_irq(int irq, void *_pwr)
> +{
> +	struct input_dev *pwr = _pwr;
> +	int err;
> +	u8 value;
> +
> +	if (twl_class_is_4030())

one of the benefits of using DT is that we can get rid of code
like above - compatible string should provide enough info.

> +		err = twl_i2c_read_u8(TWL_MODULE_PM_MASTER, &value,
> +				TWL4030_STS_HW_CONDITIONS);
> +	else
> +		err = twl_i2c_read_u8(TWL6030_MODULE_ID0, &value,
> +				TWL6030_STS_HW_CONDITIONS);
> +
> +	if (!err)  {
> +		pm_wakeup_event(pwr->dev.parent, 0);
> +		input_report_key(pwr, KEY_POWER, value & PWR_PWRON_IRQ);
> +		input_sync(pwr);
> +	} else {
> +		dev_err(pwr->dev.parent, "twl4030: i2c error %d while reading"
> +			" TWL4030 PM_MASTER STS_HW_CONDITIONS register\n", err);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int twl_pwrbutton_probe(struct platform_device *pdev)
> +{
> +	struct input_dev *pwr;
> +	int irq = platform_get_irq(pdev, 0);

It may fail ?! and return -EPROBE_DEFER

> +	int err;
> +
> +	pwr = devm_input_allocate_device(&pdev->dev);
> +	if (!pwr) {
> +		dev_err(&pdev->dev, "Can't allocate power button\n");
> +		return -ENOMEM;
> +	}
> +
> +	pwr->evbit[0] = BIT_MASK(EV_KEY);
> +	pwr->keybit[BIT_WORD(KEY_POWER)] = BIT_MASK(KEY_POWER);
> +	pwr->name = "twl_pwrbutton";
> +	pwr->phys = "twl_pwrbutton/input0";
> +	pwr->dev.parent = &pdev->dev;
> +
> +	if (twl_class_is_6030()) {
> +		twl6030_interrupt_unmask(TWL6030_PWRON_INT_MASK,
> +			REG_INT_MSK_LINE_A);
> +		twl6030_interrupt_unmask(TWL6030_PWRON_INT_MASK,
> +			REG_INT_MSK_STS_A);

Seems it's time to update twl6030-irq.c and add enable_irq()/disable_irq() functionality.

> +	}
> +
> +	err = devm_request_threaded_irq(&pwr->dev, irq, NULL, powerbutton_irq,
> +			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING |
> +			IRQF_ONESHOT,
> +			"twl_pwrbutton", pwr);
> +	if (err < 0) {
> +		dev_err(&pdev->dev, "Can't get IRQ for pwrbutton: %d\n", err);
> +		return err;
> +	}
> +
> +	err = input_register_device(pwr);
> +	if (err) {
> +		dev_err(&pdev->dev, "Can't register power button: %d\n", err);
> +		return err;
> +	}
> +
> +	platform_set_drvdata(pdev, pwr);
> +	device_init_wakeup(&pdev->dev, true);
> +
> +	return 0;
> +}
> +
> +static int twl_pwrbutton_remove(struct platform_device *pdev)
> +{
> +	if (twl_class_is_6030()) {
> +		twl6030_interrupt_mask(TWL6030_PWRON_INT_MASK,
> +			REG_INT_MSK_LINE_A);
> +		twl6030_interrupt_mask(TWL6030_PWRON_INT_MASK,
> +			REG_INT_MSK_STS_A);
> +	}
	device_init_wakeup(&pdev->dev, 0);


> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id twl_pwrbutton_dt_match_table[] = {
> +       { .compatible = "ti,twl4030-pwrbutton" },
> +       { .compatible = "ti,twl6030-pwrbutton" },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, twl_pwrbutton_dt_match_table);
> +#endif
> +
> +static struct platform_driver twl_pwrbutton_driver = {
> +	.probe		= twl_pwrbutton_probe,
> +	.remove		= twl_pwrbutton_remove,
> +	.driver		= {
> +		.name	= "twl_pwrbutton",
> +		.of_match_table = of_match_ptr(twl_pwrbutton_dt_match_table),
> +	},
> +};
> +module_platform_driver(twl_pwrbutton_driver);
> +
> +MODULE_ALIAS("platform:twl_pwrbutton");
> +MODULE_DESCRIPTION("TWL Power Button");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Peter De Schrijver <peter.de-schrijver@nokia.com>");
> +MODULE_AUTHOR("Felipe Balbi <felipe.balbi@nokia.com>");
> diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
> deleted file mode 100644
> index 603fc2f..0000000
> --- a/drivers/input/misc/twl4030-pwrbutton.c
> +++ /dev/null
> @@ -1,116 +0,0 @@
> -/**
> - * twl4030-pwrbutton.c - TWL4030 Power Button Input Driver
> - *
> - * Copyright (C) 2008-2009 Nokia Corporation
> - *
> - * Written by Peter De Schrijver <peter.de-schrijver@nokia.com>
> - * Several fixes by Felipe Balbi <felipe.balbi@nokia.com>
> - *
> - * This file is subject to the terms and conditions of the GNU General
> - * Public License. See the file "COPYING" in the main directory of this
> - * archive for more details.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> - */
> -
> -#include <linux/module.h>
> -#include <linux/init.h>
> -#include <linux/kernel.h>
> -#include <linux/errno.h>
> -#include <linux/input.h>
> -#include <linux/interrupt.h>
> -#include <linux/platform_device.h>
> -#include <linux/i2c/twl.h>
> -
> -#define PWR_PWRON_IRQ (1 << 0)
> -
> -#define STS_HW_CONDITIONS 0xf
> -
> -static irqreturn_t powerbutton_irq(int irq, void *_pwr)
> -{
> -	struct input_dev *pwr = _pwr;
> -	int err;
> -	u8 value;
> -
> -	err = twl_i2c_read_u8(TWL_MODULE_PM_MASTER, &value, STS_HW_CONDITIONS);
> -	if (!err)  {
> -		pm_wakeup_event(pwr->dev.parent, 0);
> -		input_report_key(pwr, KEY_POWER, value & PWR_PWRON_IRQ);
> -		input_sync(pwr);
> -	} else {
> -		dev_err(pwr->dev.parent, "twl4030: i2c error %d while reading"
> -			" TWL4030 PM_MASTER STS_HW_CONDITIONS register\n", err);
> -	}
> -
> -	return IRQ_HANDLED;
> -}
> -
> -static int twl4030_pwrbutton_probe(struct platform_device *pdev)
> -{
> -	struct input_dev *pwr;
> -	int irq = platform_get_irq(pdev, 0);
> -	int err;
> -
> -	pwr = devm_input_allocate_device(&pdev->dev);
> -	if (!pwr) {
> -		dev_err(&pdev->dev, "Can't allocate power button\n");
> -		return -ENOMEM;
> -	}
> -
> -	pwr->evbit[0] = BIT_MASK(EV_KEY);
> -	pwr->keybit[BIT_WORD(KEY_POWER)] = BIT_MASK(KEY_POWER);
> -	pwr->name = "twl4030_pwrbutton";
> -	pwr->phys = "twl4030_pwrbutton/input0";
> -	pwr->dev.parent = &pdev->dev;
> -
> -	err = devm_request_threaded_irq(&pwr->dev, irq, NULL, powerbutton_irq,
> -			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING |
> -			IRQF_ONESHOT,
> -			"twl4030_pwrbutton", pwr);
> -	if (err < 0) {
> -		dev_err(&pdev->dev, "Can't get IRQ for pwrbutton: %d\n", err);
> -		return err;
> -	}
> -
> -	err = input_register_device(pwr);
> -	if (err) {
> -		dev_err(&pdev->dev, "Can't register power button: %d\n", err);
> -		return err;
> -	}
> -
> -	platform_set_drvdata(pdev, pwr);
> -	device_init_wakeup(&pdev->dev, true);
> -
> -	return 0;
> -}
> -
> -#ifdef CONFIG_OF
> -static const struct of_device_id twl4030_pwrbutton_dt_match_table[] = {
> -       { .compatible = "ti,twl4030-pwrbutton" },
> -       {},
> -};
> -MODULE_DEVICE_TABLE(of, twl4030_pwrbutton_dt_match_table);
> -#endif
> -
> -static struct platform_driver twl4030_pwrbutton_driver = {
> -	.probe		= twl4030_pwrbutton_probe,
> -	.driver		= {
> -		.name	= "twl4030_pwrbutton",
> -		.of_match_table = of_match_ptr(twl4030_pwrbutton_dt_match_table),
> -	},
> -};
> -module_platform_driver(twl4030_pwrbutton_driver);
> -
> -MODULE_ALIAS("platform:twl4030_pwrbutton");
> -MODULE_DESCRIPTION("Triton2 Power Button");
> -MODULE_LICENSE("GPL");
> -MODULE_AUTHOR("Peter De Schrijver <peter.de-schrijver@nokia.com>");
> -MODULE_AUTHOR("Felipe Balbi <felipe.balbi@nokia.com>");
> -
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index 74372bc..a1bfe23 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -848,13 +848,21 @@ add_children(struct twl_platform_data *pdata, unsigned irq_base,
>   			return PTR_ERR(child);
>   	}
>   
> -	if (IS_ENABLED(CONFIG_INPUT_TWL4030_PWRBUTTON) && twl_class_is_4030()) {
> -		child = add_child(TWL_MODULE_PM_MASTER, "twl4030_pwrbutton",
> +	if (IS_ENABLED(CONFIG_INPUT_TWL_PWRBUTTON) && twl_class_is_4030()) {
> +		child = add_child(TWL_MODULE_PM_MASTER, "twl_pwrbutton",
>   				  NULL, 0, true, irq_base + 8 + 0, 0);
>   		if (IS_ERR(child))
>   			return PTR_ERR(child);
>   	}
>   
> +	if (IS_ENABLED(CONFIG_INPUT_TWL_PWRBUTTON) && twl_class_is_6030()) {
> +		child = add_child(TWL_MODULE_PM_MASTER, "twl_pwrbutton",
> +				  NULL, 0, true, irq_base + 0, 0);
> +		if (IS_ERR(child))
> +			return PTR_ERR(child);
> +	}
> +

no legacy code for twl6030 pls

> +
>   	if (IS_ENABLED(CONFIG_MFD_TWL4030_AUDIO) && pdata->audio &&
>   	    twl_class_is_4030()) {
>   		child = add_child(TWL4030_MODULE_AUDIO_VOICE, "twl4030-audio",
> diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
> index 2decb190..20d33b7 100644
> --- a/include/linux/i2c/twl.h
> +++ b/include/linux/i2c/twl.h
> @@ -127,6 +127,7 @@ enum twl6030_module_ids {
>   #define REG_INT_MSK_STS_C		0x08
>   
>   /* MASK INT REG GROUP A */
> +#define TWL6030_PWRON_INT_MASK		0x01
>   #define TWL6030_PWR_INT_MASK 		0x07
>   #define TWL6030_RTC_INT_MASK 		0x18
>   #define TWL6030_HOTDIE_INT_MASK 	0x20
> 


-- 
regards,
-grygorii
