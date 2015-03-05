From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/2] pinctrl: Introduce TI IOdelay configuration driver
Date: Wed, 4 Mar 2015 20:22:04 -0600
Message-ID: <54F7BDCC.8030602@ti.com>
References: <1425427237-11511-1-git-send-email-nm@ti.com> <1425427237-11511-3-git-send-email-nm@ti.com> <1425509926.2090.56.camel@tiscali.nl> <20150304225857.GC13520@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20150304225857.GC13520@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Bolle <pebolle@tiscali.nl>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lokesh Vutla <lokeshvutla@ti.com>
List-Id: linux-omap@vger.kernel.org

On 03/04/2015 04:58 PM, Tony Lindgren wrote:
> * Paul Bolle <pebolle@tiscali.nl> [150304 14:58]:
>> Nishanth Menon schreef op di 03-03-2015 om 18:00 [-0600]:
>>> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
>>> index ee9f44ad7f02..8e463d75fbb2 100644
>>> --- a/drivers/pinctrl/Kconfig
>>> +++ b/drivers/pinctrl/Kconfig
>>> @@ -160,6 +160,17 @@ config PINCTRL_TEGRA_XUSB
>>>  	select PINCONF
>>>  	select PINMUX
>>>  
>>> +config PINCTRL_TI_IODELAY
>>> +	bool "TI IODelay Module pinconf driver"
>>
>> This adds a boolean Kconfig symbol.

Uggh.. thanks for the review and catching this..

>>
>>> +	depends on OF
>>> +	select PINCONF
>>> +	select GENERIC_PINCONF
>>> +	select REGMAP_MMIO
>>> +	help
>>> +	  Say Y here to support Texas Instruments' IODelay pinconf driver.
>>> +	  IODelay module is used for the DRA7 SoC family. This driver is in
>>> +	  addition to PINCTRL_SINGLE which controls the mux.
>>> +
>>>  config PINCTRL_TZ1090
>>>  	bool "Toumaz Xenif TZ1090 pin control driver"
>>>  	depends on SOC_TZ1090
>>> diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
>>> index 0475206dd600..e441cd71aedf 100644
>>> --- a/drivers/pinctrl/Makefile
>>> +++ b/drivers/pinctrl/Makefile
>>> @@ -28,6 +28,7 @@ obj-$(CONFIG_PINCTRL_TEGRA30)	+= pinctrl-tegra30.o
>>>  obj-$(CONFIG_PINCTRL_TEGRA114)	+= pinctrl-tegra114.o
>>>  obj-$(CONFIG_PINCTRL_TEGRA124)	+= pinctrl-tegra124.o
>>>  obj-$(CONFIG_PINCTRL_TEGRA_XUSB)	+= pinctrl-tegra-xusb.o
>>> +obj-$(CONFIG_PINCTRL_TI_IODELAY)	+= pinctrl-ti-iodelay.o
>>
>> So this objectfile will either be built-in or not be built at all.
>>
>>>  obj-$(CONFIG_PINCTRL_TZ1090)	+= pinctrl-tz1090.o
>>>  obj-$(CONFIG_PINCTRL_TZ1090_PDC)	+= pinctrl-tz1090-pdc.o
>>>  obj-$(CONFIG_PINCTRL_U300)	+= pinctrl-u300.o
>>> diff --git a/drivers/pinctrl/pinctrl-ti-iodelay.c b/drivers/pinctrl/pinctrl-ti-iodelay.c
>>> new file mode 100644
>>> index 000000000000..e4c6e25a781c
>>> --- /dev/null
>>> +++ b/drivers/pinctrl/pinctrl-ti-iodelay.c
>>> @@ -0,0 +1,963 @@
>>> [...]
>>> +#include <linux/err.h>
>>> +#include <linux/init.h>
>>> +#include <linux/io.h>
>>> +#include <linux/list.h>
>>> +#include <linux/module.h>
>>
>> This is, I think, a bit of a red flag.
>>
>>> +#include <linux/of_device.h>
>>> +#include <linux/of.h>
>>> +#include <linux/pinctrl/pinconf-generic.h>
>>> +#include <linux/pinctrl/pinconf.h>
>>> +#include <linux/pinctrl/pinctrl.h>
>>> +#include <linux/regmap.h>
>>> +#include <linux/slab.h>
>>
>> [...]
>>
>>> +static const struct of_device_id ti_iodelay_of_match[] = {
>>> +	{.compatible = "ti,dra7-iodelay", .data = &dra7_iodelay_data},
>>> +	{ /* Hopefully no more.. */ },
>>> +};
>>> +MODULE_DEVICE_TABLE(of, ti_iodelay_of_match);
>>> +
>>> +static struct platform_driver ti_iodelay_driver = {
>>> +	.probe = ti_iodelay_probe,
>>> +	.remove = ti_iodelay_remove,
>>> +	.driver = {
>>> +		   .owner = THIS_MODULE,
>>
>> So THIS_MODULE will, basically, be NULL.
>>
>>> +		   .name = DRIVER_NAME,
>>> +		   .of_match_table = ti_iodelay_of_match,
>>> +		   },
>>> +};
>>> +module_platform_driver(ti_iodelay_driver);
>>> +
>>> +MODULE_AUTHOR("Texas Instruments, Inc.");
>>> +MODULE_DESCRIPTION("Pinconf driver for TI's IO Delay module");
>>> +MODULE_LICENSE("GPL v2");
>>
>> And these three macros will be preprocessed away.
>>
>> (Perhaps there are non-modular alternatives to MODULE_DEVICE_TABLE and
>> module_platform_driver, but I'm not sure how those two macros actually
>> work.)
> 
> This should be just made to work as a regular loadable module.
> We already have pinctrl-single for the same platforms working
> as a loadable module.
> 
Yes, indeed. this can easily be fixed. my bad. will convert this to a
module in the next rev.

I will wait a week before reposting next rev to see if there are
improvements necessary in other areas - specifically in the way
pinconf is being used and if there are any binding related comments.

Will be great to hear any feedback on the same as well.


-- 
Regards,
Nishanth Menon
