From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 1/7] extcon: usb-gpio: Introduce gpio usb extcon driver
Date: Fri, 30 Jan 2015 16:03:38 +0200
Message-ID: <54CB8F3A.7020903@ti.com>
References: <1422274532-9488-1-git-send-email-rogerq@ti.com> <1422274532-9488-2-git-send-email-rogerq@ti.com> <54C8D2F4.9050404@ti.com> <54CACC28.3050306@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37988 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762376AbbA3ODq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Jan 2015 09:03:46 -0500
In-Reply-To: <54CACC28.3050306@samsung.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: myungjoo.ham@samsung.com, balbi@ti.com, tony@atomide.com, george.cherian@ti.com, nsekhar@ti.com, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

On 30/01/15 02:11, Chanwoo Choi wrote:
> Hi Roger,
> 
> On 01/28/2015 09:15 PM, Roger Quadros wrote:
>> This driver observes the USB ID pin connected over a GPIO and
>> updates the USB cable extcon states accordingly.
>>
>> The existing GPIO extcon driver is not suitable for this purpose
>> as it needs to be taught to understand USB cable states and it
>> can't handle more than one cable per instance.
>>
>> For the USB case we need to handle 2 cable states.
>> 1) USB (attach/detach)
>> 2) USB-Host (attach/detach)
>>
>> This driver can be easily updated in the future to handle VBUS
>> events in case it happens to be available on GPIO for any platform.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>> v3:
>> - removed IRQF_NO_SUSPEND flag. Added IRQF_TRIGGER_RISING and
>>   IRQF_TRIGGER_FALLING
>> - Added disable_irq() to suspend() and enable_irq() to resume()
>>
>>  .../devicetree/bindings/extcon/extcon-usb-gpio.txt |  18 ++
>>  drivers/extcon/Kconfig                             |   7 +
>>  drivers/extcon/Makefile                            |   1 +
>>  drivers/extcon/extcon-usb-gpio.c                   | 233 +++++++++++++++++++++
>>  4 files changed, 259 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt
>>  create mode 100644 drivers/extcon/extcon-usb-gpio.c
>>
>> diff --git a/Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt b/Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt
>> new file mode 100644
>> index 0000000..85fe6b0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt
>> @@ -0,0 +1,18 @@
>> +USB GPIO Extcon device
>> +
>> +This is a virtual device used to generate USB cable states from the USB ID pin
>> +connected to a GPIO pin.
>> +
>> +Required properties:
>> +- compatible: Should be "linux,extcon-usb-gpio"
>> +- id-gpio: gpio for USB ID pin. See gpio binding.
>> +
>> +Example:
>> +	extcon_usb1 {
>> +		compatible = "linux,extcon-usb-gpio";
>> +		id-gpio = <&gpio6 1 GPIO_ACTIVE_HIGH>;
>> +	}
>> +
>> +	&omap_dwc3_1 {
>> +		extcon = <&extcon_usb1>;
>> +	};
>> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
>> index 6a1f7de..fd11536 100644
>> --- a/drivers/extcon/Kconfig
>> +++ b/drivers/extcon/Kconfig
>> @@ -93,4 +93,11 @@ config EXTCON_SM5502
>>  	  Silicon Mitus SM5502. The SM5502 is a USB port accessory
>>  	  detector and switch.
>>  
>> +config EXTCON_USB_GPIO
>> +	tristate "USB GPIO extcon support"
>> +	select GPIOLIB
>> +	help
>> +	  Say Y here to enable GPIO based USB cable detection extcon support.
>> +	  Used typically if GPIO is used for USB ID pin detection.
>> +
>>  endif # MULTISTATE_SWITCH
>> diff --git a/drivers/extcon/Makefile b/drivers/extcon/Makefile
>> index 0370b42..6a08a98 100644
>> --- a/drivers/extcon/Makefile
>> +++ b/drivers/extcon/Makefile
>> @@ -12,3 +12,4 @@ obj-$(CONFIG_EXTCON_MAX8997)	+= extcon-max8997.o
>>  obj-$(CONFIG_EXTCON_PALMAS)	+= extcon-palmas.o
>>  obj-$(CONFIG_EXTCON_RT8973A)	+= extcon-rt8973a.o
>>  obj-$(CONFIG_EXTCON_SM5502)	+= extcon-sm5502.o
>> +obj-$(CONFIG_EXTCON_USB_GPIO)	+= extcon-usb-gpio.o
>> diff --git a/drivers/extcon/extcon-usb-gpio.c b/drivers/extcon/extcon-usb-gpio.c
>> new file mode 100644
>> index 0000000..99a58b2
>> --- /dev/null
>> +++ b/drivers/extcon/extcon-usb-gpio.c
>> @@ -0,0 +1,233 @@
>> +/**
>> + * drivers/extcon/extcon-usb-gpio.c - USB GPIO extcon driver
>> + *
>> + * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com
>> + * Author: Roger Quadros <rogerq@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/extcon.h>
>> +#include <linux/init.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/irq.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of_gpio.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/workqueue.h>
>> +
>> +#define USB_GPIO_DEBOUNCE_MS	20	/* ms */
>> +
>> +struct usb_extcon_info {
>> +	struct device *dev;
>> +	struct extcon_dev *edev;
>> +
>> +	struct gpio_desc *id_gpiod;
>> +	int id_irq;
>> +	bool id_irqwake;		/* ID wakeup enabled flag */
>> +
>> +	unsigned long debounce_jiffies;
>> +	struct delayed_work wq_detcable;
>> +};
>> +
>> +/* List of detectable cables */
>> +enum {
>> +	EXTCON_CABLE_USB = 0,
>> +	EXTCON_CABLE_USB_HOST,
>> +
>> +	EXTCON_CABLE_END,
>> +};
>> +
>> +static const char *usb_extcon_cable[] = {
>> +	[EXTCON_CABLE_USB] = "USB",
>> +	[EXTCON_CABLE_USB_HOST] = "USB-Host",
> 
> I'll use the defined name for extcon cable name as soon because 
> it has potential isseu about the conflict of extcon cable name between subsystems.
> So, I recommend to use a captical letter as "USB-HOST" instead of "USB-Host".
> If other extcon driver don't use the captical letter, I'll fix it.

Did you see patch 2 in this series?
In that I had fixed all instances to use "USB-Host" based on
http://lxr.free-electrons.com/source/drivers/extcon/extcon-class.c#L45

What do you suggest?
Skip patch 2 and convert all "USB-Host" to "USB-HOST"?

cheers,
-roger
