From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v2 1/2] input: misc: Add generic input driver to read
 encoded GPIO lines
Date: Tue, 23 Aug 2016 10:27:59 -0500
Message-ID: <949d92f3-4510-ada5-d3d6-a29544465fd6@ti.com>
References: <20160823061649.3394-1-vigneshr@ti.com>
 <20160823061649.3394-2-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160823061649.3394-2-vigneshr@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vignesh R <vigneshr@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Moritz Fischer <moritz.fischer@ettus.com>, John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Daniel Hung-yu Wu <hywu@google.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Grant Grundler <grundler@chromium.org>, Rob Herring <robh+dt@kernel.org>, S Twiss <stwiss.opensource@diasemi.com>, linux-input@vger.kernel.org, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 08/23/2016 01:16 AM, Vignesh R wrote:
> Add a driver to read group of GPIO lines and provide its status as a
> numerical value as input event to the system. This will help in
> intefacing devices, that can be connected over GPIOs, that provide input
> to the system by driving GPIO lines connected to them like a rotary dial
> or a switch.
> 
> For example, a rotary switch can be connected to four GPIO lines. The
> status of the GPIO lines reflect the actual position of the rotary
> switch dial. For example, if dial points to 9, then the four GPIO lines
> connected to the switch will read HLLH(0b'1001 = 9). This value
> can be reported as an ABS_* event to the input subsystem.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> 
> v2: Use decoder,max-value instead of gpio-decoder,max-value.
> 
>  .../devicetree/bindings/input/gpio-decoder.txt     |  23 ++++
>  drivers/input/misc/Kconfig                         |  12 ++
>  drivers/input/misc/Makefile                        |   1 +
>  drivers/input/misc/gpio_decoder.c                  | 130 +++++++++++++++++++++
>  4 files changed, 166 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/gpio-decoder.txt
>  create mode 100644 drivers/input/misc/gpio_decoder.c
> 
> diff --git a/Documentation/devicetree/bindings/input/gpio-decoder.txt b/Documentation/devicetree/bindings/input/gpio-decoder.txt
> new file mode 100644
> index 000000000000..f27f083a9075
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/gpio-decoder.txt
> @@ -0,0 +1,23 @@
> +* GPIO Decoder DT bindings
> +
> +Required Properties:
> +- compatible: should be "gpio-decoder"
> +- gpios: a spec of gpios (atleast two) to be decoded to a number with

                              ^^ two words

> +  first entry representing the MSB.
> +
> +Optional Properties:
> +- decoder,max-value: Maximum possible value that can be reported by
> +  the gpios.
> +- linux,axis: the input subsystem axis to map to (ABS_X/ABS_Y).
> +  Defaults to 0 (ABS_X).
> +
> +Example:
> +	gpio-decoder0 {
> +		compatible = "gpio-decoder";
> +		gpios = <&pca9536 3 GPIO_ACTIVE_HIGH>,
> +			<&pca9536 2 GPIO_ACTIVE_HIGH>,
> +			<&pca9536 1 GPIO_ACTIVE_HIGH>,
> +			<&pca9536 0 GPIO_ACTIVE_HIGH>;
> +		linux,axis = <0>; /* ABS_X */
> +		decoder,max-value = <9>;
> +	};
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index efb0ca871327..c44513cac3b7 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -292,6 +292,18 @@ config INPUT_GPIO_TILT_POLLED
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called gpio_tilt_polled.
>  
> +config INPUT_GPIO_DECODER
> +	tristate "Polled GPIO Decoder Input driver"
> +	depends on GPIOLIB && OF
> +	select INPUT_POLLDEV
> +	help
> +	 Say Y here if you want driver to read status of multiple GPIO
> +	 lines and report the encoded value as an absolute integer to
> +	 input subsystem.
> +
> +	 To compile this driver as a module, choose M here: the module
> +	 will will be called gpio_decoder.
> +
>  config INPUT_IXP4XX_BEEPER
>  	tristate "IXP4XX Beeper support"
>  	depends on ARCH_IXP4XX
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 6a1e5e20fc1c..0b6d025f0487 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_INPUT_DRV2667_HAPTICS)	+= drv2667.o
>  obj-$(CONFIG_INPUT_GP2A)		+= gp2ap002a00f.o
>  obj-$(CONFIG_INPUT_GPIO_BEEPER)		+= gpio-beeper.o
>  obj-$(CONFIG_INPUT_GPIO_TILT_POLLED)	+= gpio_tilt_polled.o
> +obj-$(CONFIG_INPUT_GPIO_DECODER)	+= gpio_decoder.o
>  obj-$(CONFIG_INPUT_HISI_POWERKEY)	+= hisi_powerkey.o
>  obj-$(CONFIG_HP_SDC_RTC)		+= hp_sdc_rtc.o
>  obj-$(CONFIG_INPUT_IMS_PCU)		+= ims-pcu.o
> diff --git a/drivers/input/misc/gpio_decoder.c b/drivers/input/misc/gpio_decoder.c
> new file mode 100644
> index 000000000000..eec0fda6f562
> --- /dev/null
> +++ b/drivers/input/misc/gpio_decoder.c
> @@ -0,0 +1,130 @@
> +/*
> + * gpio-decoder.c
> + *

^ the name of the file often changes without this being updated, it
really doesn't add anything anyway, would recommend dropping it.

> + * A generic driver to reads multiple gpio lines and translate the
> + * encoded numeric value into an input event.
> + *
> + * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/input.h>
> +#include <linux/input-polldev.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +
> +struct gpio_decoder {
> +	struct input_polled_dev *poll_dev;
> +	struct gpio_descs *input_gpios;
> +	struct device *dev;
> +	u32 axis;
> +	u32 last_stable;
> +};
> +
> +static unsigned int gpio_decoder_get_gpios_state(struct gpio_decoder
> +						 *decoder)
> +{
> +	struct gpio_descs *gpios = decoder->input_gpios;
> +	unsigned int ret = 0;
> +	int i, val;
> +
> +	for (i = 0; i < gpios->ndescs; i++) {
> +		val = gpiod_get_value_cansleep(gpios->desc[i]);
> +		ret = ret << 1 | val;

Just to be safe, could you mask val with 0x1 here.

> +	}
> +
> +	return ret;
> +}
> +
> +static void gpio_decoder_poll_gpios(struct input_polled_dev *poll_dev)
> +{
> +	struct gpio_decoder *decoder = poll_dev->private;
> +	unsigned int state = gpio_decoder_get_gpios_state(decoder);
> +
> +	if (state != decoder->last_stable) {
> +		input_report_abs(poll_dev->input, decoder->axis, state);
> +		input_sync(poll_dev->input);
> +		decoder->last_stable = state;
> +	}
> +}
> +
> +static int gpio_decoder_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct gpio_decoder *decoder;
> +	struct input_polled_dev *poll_dev;
> +	u32  max;
> +	int err;
> +
> +	decoder = devm_kzalloc(dev, sizeof(struct gpio_decoder), GFP_KERNEL);
> +	if (!decoder)
> +		return -ENOMEM;
> +
> +	device_property_read_u32(dev, "linux,axis", &decoder->axis);
> +	decoder->input_gpios = devm_gpiod_get_array(dev, NULL, GPIOD_IN);
> +	if (IS_ERR(decoder->input_gpios)) {
> +		dev_err(dev, "unable to acquire input gpios\n");
> +		return PTR_ERR(decoder->input_gpios);
> +	}
> +	if (decoder->input_gpios->ndescs < 2) {
> +		dev_err(dev, "not enough gpios found\n");
> +		return -EINVAL;
> +	}
> +
> +	if (device_property_read_u32(dev, "decoder,max-value", &max))
> +		max = BIT(decoder->input_gpios->ndescs);
> +
> +	decoder->dev = dev;
> +	poll_dev = devm_input_allocate_polled_device(decoder->dev);
> +	if (!poll_dev)
> +		return -ENOMEM;
> +
> +	poll_dev->private = decoder;
> +	poll_dev->poll = gpio_decoder_poll_gpios;
> +	decoder->poll_dev = poll_dev;
> +
> +	poll_dev->input->name = pdev->name;
> +	poll_dev->input->id.bustype = BUS_HOST;
> +	poll_dev->input->dev.parent = dev;
> +	input_set_abs_params(poll_dev->input, decoder->axis, 0, max, 0, 1);
> +
> +	err = input_register_polled_device(poll_dev);
> +	if (err) {
> +		dev_err(dev, "failed to register polled  device\n");
> +		return err;
> +	}
> +	platform_set_drvdata(pdev, decoder);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id gpio_decoder_of_match[] = {
> +	{ .compatible = "gpio-decoder", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, gpio_decoder_of_match);
> +
> +static struct platform_driver gpio_decoder_driver = {
> +	.probe		= gpio_decoder_probe,
> +	.driver		= {
> +		.name	= "gpio-decoder",
> +		.of_match_table = of_match_ptr(gpio_decoder_of_match),

When the struct 'gpio_decoder_of_match' is always defined (not
conditional on OF support), then 'of_match_ptr' does nothing and can be
dropped here.

> +	}
> +};
> +module_platform_driver(gpio_decoder_driver);
> +
> +MODULE_DESCRIPTION("GPIO decoder input driver");
> +MODULE_AUTHOR("Vignesh R <vigneshr@ti.com>");
> +MODULE_LICENSE("GPL v2");
